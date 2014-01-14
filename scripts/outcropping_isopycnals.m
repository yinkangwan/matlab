tsfile='/ltraid2/ashao/uw-apl/data/offtrac/input/normalyear/ts.nc';

offtrac.sst=nc_varget(tsfile,'temp',[0 0 0 0],[-1 1 -1 -1]);
offtrac.sss=nc_varget(tsfile,'salt',[0 0 0 0],[-1 1 -1 -1]);
P=ones(size(offtrac.sss))*2000;
PR=ones(size(offtrac.sss))*2000;
offtrac.pd2000=sw_pden(offtrac.sss,offtrac.sst,P,PR);

him.layers=nc_varget( ...
    '/ltraid1/ashao/HIM/himw/him_sis/INPUT/Global_HIM_IC.nc','Layer');
load metrics
offtrac.pd2000(:,~logical(metrics.wet.data))=NaN;
%%
lonrange=[-260 -120];
latrange=[20 50];
m_proj('Mercator','lon',lonrange,'lat',latrange);
[cs v]=m_contour(metrics.geolon.data,metrics.geolat.data, ...
    offtrac.pd2000(2,:,:),him.layers);
clabel(cs,v);
m_grid;
m_coast('patch',[0.5 0.5 0.5]);
colorbar;