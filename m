Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF77ED145
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjKOUAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbjKOUA3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:00:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFD189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8563FC433C8;
        Wed, 15 Nov 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078425;
        bh=uSO4EaUmzxmE5vyeSfnZ2trWAa/NSyTQ3Ho9gigXEnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV/sxHwKGb6WohLXb9hNp63+xwLnC/eqsnvFslsmKVR8//8PNLgnIABLSVptd+rPT
         UxU6NByTF+RN12FUM2APISxWLlazR3063ObEHcUmhVY4TaSO+1PyRsRpgvSvknyBJf
         XRu/lvW9C6Pp4iwdVjAUE0Zch+5Q3MInmza0GQfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 316/379] media: ov5640: Drop dead code using frame_interval
Date:   Wed, 15 Nov 2023 14:26:31 -0500
Message-ID: <20231115192703.843051456@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

[ Upstream commit eeaa47d182fedfe68b8fd40ef3798761c8904791 ]

The ov5640_update_pixel_rate() function handles the parallel and MIPI
CSI-2 cases separately.

When running on a parallel setup the V4L2_CID_PIXEL_RATE value is
calculated at the beginning of the function using the values configured
with the frame_interval operations, and then the function immediately
returns.

The remaining of the function handles the MIPI CSI-2 configuration and
should not use the 'current_fr' and 'def_fps' fields as those are only
relevant for parallel mode.

Drop a small section of dead code that updates vblank using
frame_interval on a MIPI CSI-2 setup.

Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 8fc29e3c9f68 ("media: ov5640: fix vblank unchange issue when work at dvp mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5640.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 2ee832426736d..505dd7c10235e 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2912,19 +2912,6 @@ static int ov5640_update_pixel_rate(struct ov5640_dev *sensor)
 				 hblank, hblank, 1, hblank);
 
 	vblank = timings->vblank_def;
-
-	if (sensor->current_fr != mode->def_fps) {
-		/*
-		 * Compute the vertical blanking according to the framerate
-		 * configured with s_frame_interval.
-		 */
-		int fie_num = sensor->frame_interval.numerator;
-		int fie_denom = sensor->frame_interval.denominator;
-
-		vblank = ((fie_num * pixel_rate / fie_denom) / timings->htot) -
-			mode->height;
-	}
-
 	__v4l2_ctrl_modify_range(sensor->ctrls.vblank, OV5640_MIN_VBLANK,
 				 OV5640_MAX_VTS - mode->height, 1, vblank);
 	__v4l2_ctrl_s_ctrl(sensor->ctrls.vblank, vblank);
-- 
2.42.0



