//
//  VideoViewController.m
//  TYVideoPlayerDemo
//
//  Created by tany on 16/7/5.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "SimpleVideoViewController.h"

#import "TYVideoPlayer.h"
#import "TYVideoPlayerView.h"

@interface SimpleVideoViewController ()<TYVideoPlayerDelegate>
@property (nonatomic, strong) TYVideoPlayer *videoPlayer;
@property (nonatomic, weak) TYVideoPlayerView *playerView;
@end

@implementation SimpleVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addPlayerView];
    
    [self addVideoPlayer];
    
    [self loadVideo];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _playerView.frame  = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)*9/16);
}

- (void)addPlayerView
{
    TYVideoPlayerView *playerView = [[TYVideoPlayerView alloc]init];
    playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:playerView];
    _playerView = playerView;
}

- (void)addVideoPlayer
{
    TYVideoPlayer *videoPlayer = [[TYVideoPlayer alloc]init];
    videoPlayer.delegate = self;
    _videoPlayer = videoPlayer;
}

- (void)loadVideo
{
    NSURL *streamURL = [NSURL URLWithString:@"http://down.233.com/2014_2015/2014/jzs1/jingji_zhenti_yjw/6-qllgl2v5x9b80vvgwgzzlnzydkj1bpr66hnool80.mp4"];
    [_videoPlayer loadVideoWithStreamURL:streamURL playerLayer:_playerView.layerView];
}


#pragma mark -  action

- (IBAction)loadTrackAction:(id)sender {
    [self.videoPlayer reloadCurrentVideoTrack];
}

- (IBAction)playAction:(id)sender {
    [self.videoPlayer play];
}

- (IBAction)pasueAction:(id)sender {
    [self.videoPlayer pause];
}

- (IBAction)stopAction:(id)sender {
    [self.videoPlayer stop];
}

- (IBAction)popVC:(id)sender {
    [_videoPlayer stop];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TYVideoPlayerDelegate

- (void)videoPlayer:(TYVideoPlayer*)videoPlayer track:(id<TYVideoPlayerTrack>)track didChangeFromState:(TYVideoPlayerState)fromState
{
    switch (videoPlayer.state) {
        case TYVideoPlayerStateContentReadyToPlay:
            [videoPlayer play];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end