Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857E7ECD56
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjKOTf7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjKOTf5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC159E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3F3C433C9;
        Wed, 15 Nov 2023 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076953;
        bh=quQ2Q/xgtfoefHT6Xv3kg+gjfaHuhZDhElNSw93cnxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txxUTZ5OBz5/6mouot8IG1zjhod4S85EGELIETv7/q7xegRYf+ntcTK61iLc74dlx
         lEoVix73WY0Gwz6aWaFMODHoZPV5+e+1nNsek1cFwoxXSyQCmO8ynlcOkM/wGDjav+
         GHwjZOab3xKFyYq9G2RKFWEBGVNl84VvvHYu1MpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Guoniu.zhou" <guoniu.zhou@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 474/550] media: ov5640: fix vblank unchange issue when work at dvp mode
Date:   Wed, 15 Nov 2023 14:17:38 -0500
Message-ID: <20231115191633.725257748@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoniu.zhou <guoniu.zhou@nxp.com>

[ Upstream commit 8fc29e3c9f682d4ad9b0764d44ecc6c19b000051 ]

The value of V4L2_CID_VBLANK control is initialized to default vblank
value of 640x480 when driver probe. When OV5640 work at DVP mode, the
control value won't update and lead to sensor can't output data if the
resolution remain the same as last time since incorrect total vertical
size. So update it when there is a new value applied.

Fixes: bce93b827de6 ("media: ov5640: Add VBLANK control")
Signed-off-by: Guoniu.zhou <guoniu.zhou@nxp.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 8b7ff2f3bdda7..7c041dafff2b1 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2850,12 +2850,22 @@ static int ov5640_try_fmt_internal(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static void __v4l2_ctrl_vblank_update(struct ov5640_dev *sensor, u32 vblank)
+{
+	const struct ov5640_mode_info *mode = sensor->current_mode;
+
+	__v4l2_ctrl_modify_range(sensor->ctrls.vblank, OV5640_MIN_VBLANK,
+				 OV5640_MAX_VTS - mode->height, 1, vblank);
+
+	__v4l2_ctrl_s_ctrl(sensor->ctrls.vblank, vblank);
+}
+
 static int ov5640_update_pixel_rate(struct ov5640_dev *sensor)
 {
 	const struct ov5640_mode_info *mode = sensor->current_mode;
 	enum ov5640_pixel_rate_id pixel_rate_id = mode->pixel_rate;
 	struct v4l2_mbus_framefmt *fmt = &sensor->fmt;
-	const struct ov5640_timings *timings;
+	const struct ov5640_timings *timings = ov5640_timings(sensor, mode);
 	s32 exposure_val, exposure_max;
 	unsigned int hblank;
 	unsigned int i = 0;
@@ -2874,6 +2884,8 @@ static int ov5640_update_pixel_rate(struct ov5640_dev *sensor)
 		__v4l2_ctrl_s_ctrl_int64(sensor->ctrls.pixel_rate,
 					 ov5640_calc_pixel_rate(sensor));
 
+		__v4l2_ctrl_vblank_update(sensor, timings->vblank_def);
+
 		return 0;
 	}
 
@@ -2916,15 +2928,12 @@ static int ov5640_update_pixel_rate(struct ov5640_dev *sensor)
 	__v4l2_ctrl_s_ctrl_int64(sensor->ctrls.pixel_rate, pixel_rate);
 	__v4l2_ctrl_s_ctrl(sensor->ctrls.link_freq, i);
 
-	timings = ov5640_timings(sensor, mode);
 	hblank = timings->htot - mode->width;
 	__v4l2_ctrl_modify_range(sensor->ctrls.hblank,
 				 hblank, hblank, 1, hblank);
 
 	vblank = timings->vblank_def;
-	__v4l2_ctrl_modify_range(sensor->ctrls.vblank, OV5640_MIN_VBLANK,
-				 OV5640_MAX_VTS - mode->height, 1, vblank);
-	__v4l2_ctrl_s_ctrl(sensor->ctrls.vblank, vblank);
+	__v4l2_ctrl_vblank_update(sensor, vblank);
 
 	exposure_max = timings->crop.height + vblank - 4;
 	exposure_val = clamp_t(s32, sensor->ctrls.exposure->val,
-- 
2.42.0



