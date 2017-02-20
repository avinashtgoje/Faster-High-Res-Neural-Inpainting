require 'torch'
require 'nn'
require 'optim'
require 'image'
require 'nngraph'
require 'cudnn'
util = paths.dofile('util.lua')
torch.setdefaulttensortype('torch.FloatTensor')

opt = {
  dataset = 'folder', 
  batchSize=7,
  niter=40,
  fineSize=128,
  ntrain = math.huge, 
  gpu=1,
  nThreads = 4,
  scale=4,
  loadSize=512,
  overlapPred=4,
  train_folder='',
  model_file='',
  result_path=''
}
for k,v in pairs(opt) do opt[k] = tonumber(os.getenv(k)) or os.getenv(k) or opt[k] end
print(opt)

local function loadImage(path,size)
    local input = image.load(path, 3, 'float')
    input = image.scale(input,size,size)
    return input
end

modelG=util.load(opt.model_file,opt.gpu)

local real=torch.Tensor(3,128,128)
local real_ctx = torch.Tensor(3,128,128)
local fake2 = torch.Tensor(3,256,256))

for i=1,7 dofile
    real=loadImage(string.format('examples/pink_%04d.png',i),512)
    real_ctx:copy(image.scale(real,128,128))
    fake = modelG:forward(real_ctx)
    fake2:copy(image.scale(fake[j],256,256))
    real[{{},{145,368},{145,368}}]:copy(fake2[{{},{17, 240},{17, 240}}])
    real[real:gt(1)]=1
    real[real:lt(-1)]=-1
    real[real:gt(1)]=1
    image.save(string.format('examples/fake_%04d.png',i),real)
end


