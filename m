Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6579C089
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359801AbjIKWSs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbjIKOQr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:16:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811CDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:16:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A337C433C7;
        Mon, 11 Sep 2023 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441802;
        bh=mYTIDqotvu9eyqmSz3fi8oweN1pJUCJM528xe94x77E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neMAsfrYS931rmlTYSu46uauQmPpx+4tyx59tRNVb7oc7B9qlGZP77ylwAAZjBx/6
         MkXIl9JKfatt0hmuU5FwDG/E10OmPEQGNuDpdEiPPTNpJRzPkJQHuxTJJVpiOdaF6U
         CR6u8u/OiM/+Ohj08V1qK+WT4bCTNep2kiwU0P5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 541/739] media: ov2680: Remove auto-gain and auto-exposure controls
Date:   Mon, 11 Sep 2023 15:45:40 +0200
Message-ID: <20230911134706.207862900@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7b5a42e6ae71927359ea67a2c22570ba97fa4059 ]

Quoting the OV2680 datasheet:

"3.2 exposure and gain control

In the OV2680, the exposure time and gain are set manually from an external
controller. The OV2680 supports manual gain and exposure control only for
normal applications, no auto mode."

And indeed testing with the atomisp_ov2680 fork of ov2680.c has shown that
auto-exposure and auto-gain do not work.

Note that the code setting the auto-exposure flag was broken, callers
of ov2680_exposure_set() were directly passing !!ctrls->auto_exp->val as
"bool auto_exp" value, but ctrls->auto_exp is a menu control with:

enum  v4l2_exposure_auto_type {
        V4L2_EXPOSURE_AUTO = 0,
        V4L2_EXPOSURE_MANUAL = 1,
	...

So instead of passing !!ctrls->auto_exp->val they should have been passing
ctrls->auto_exp->val == V4L2_EXPOSURE_AUTO, iow the passed value was
inverted of what it should have been.

Also remove ov2680_g_volatile_ctrl() since without auto support the gain
and exposure controls are not volatile.

This also fixes the control values not being properly applied in
ov2680_mode_set(). The 800x600 mode register-list also sets gain,
exposure and vflip overriding the last set ctrl values.

ov2680_mode_set() does call ov2680_gain_set() and ov2680_exposure_set()
but did this before writing the mode register-list, so these values
would still be overridden by the mode register-list.

Add a v4l2_ctrl_handler_setup() call after writing the mode register-list
to restore all ctrl values. Also remove the ctrls->gain->is_new check from
ov2680_gain_set() so that the gain always gets restored properly.

Last since ov2680_mode_set() now calls v4l2_ctrl_handler_setup(), remove
the v4l2_ctrl_handler_setup() call after ov2680_mode_restore() since
ov2680_mode_restore() calls ov2680_mode_set().

Fixes: 3ee47cad3e69 ("media: ov2680: Add Omnivision OV2680 sensor driver")
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2680.c | 161 ++++---------------------------------
 1 file changed, 17 insertions(+), 144 deletions(-)

diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index d06e9fc37f770..049ca28b96631 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -85,15 +85,8 @@ struct ov2680_mode_info {
 
 struct ov2680_ctrls {
 	struct v4l2_ctrl_handler handler;
-	struct {
-		struct v4l2_ctrl *auto_exp;
-		struct v4l2_ctrl *exposure;
-	};
-	struct {
-		struct v4l2_ctrl *auto_gain;
-		struct v4l2_ctrl *gain;
-	};
-
+	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *gain;
 	struct v4l2_ctrl *hflip;
 	struct v4l2_ctrl *vflip;
 	struct v4l2_ctrl *test_pattern;
@@ -143,6 +136,7 @@ static const struct reg_value ov2680_setting_30fps_QUXGA_800_600[] = {
 	{0x380e, 0x02}, {0x380f, 0x84}, {0x3811, 0x04}, {0x3813, 0x04},
 	{0x3814, 0x31}, {0x3815, 0x31}, {0x3820, 0xc0}, {0x4008, 0x00},
 	{0x4009, 0x03}, {0x4837, 0x1e}, {0x3501, 0x4e}, {0x3502, 0xe0},
+	{0x3503, 0x03},
 };
 
 static const struct reg_value ov2680_setting_30fps_720P_1280_720[] = {
@@ -405,69 +399,15 @@ static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
 	return 0;
 }
 
-static int ov2680_gain_set(struct ov2680_dev *sensor, bool auto_gain)
-{
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 gain;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(1),
-			     auto_gain ? 0 : BIT(1));
-	if (ret < 0)
-		return ret;
-
-	if (auto_gain || !ctrls->gain->is_new)
-		return 0;
-
-	gain = ctrls->gain->val;
-
-	ret = ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
-
-	return 0;
-}
-
-static int ov2680_gain_get(struct ov2680_dev *sensor)
-{
-	u32 gain;
-	int ret;
-
-	ret = ov2680_read_reg16(sensor, OV2680_REG_GAIN_PK, &gain);
-	if (ret)
-		return ret;
-
-	return gain;
-}
-
-static int ov2680_exposure_set(struct ov2680_dev *sensor, bool auto_exp)
+static int ov2680_gain_set(struct ov2680_dev *sensor, u32 gain)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 exp;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(0),
-			     auto_exp ? 0 : BIT(0));
-	if (ret < 0)
-		return ret;
-
-	if (auto_exp || !ctrls->exposure->is_new)
-		return 0;
-
-	exp = (u32)ctrls->exposure->val;
-	exp <<= 4;
-
-	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, exp);
+	return ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
 }
 
-static int ov2680_exposure_get(struct ov2680_dev *sensor)
+static int ov2680_exposure_set(struct ov2680_dev *sensor, u32 exp)
 {
-	int ret;
-	u32 exp;
-
-	ret = ov2680_read_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, &exp);
-	if (ret)
-		return ret;
-
-	return exp >> 4;
+	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH,
+				  exp << 4);
 }
 
 static int ov2680_stream_enable(struct ov2680_dev *sensor)
@@ -482,33 +422,17 @@ static int ov2680_stream_disable(struct ov2680_dev *sensor)
 
 static int ov2680_mode_set(struct ov2680_dev *sensor)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 	int ret;
 
-	ret = ov2680_gain_set(sensor, false);
-	if (ret < 0)
-		return ret;
-
-	ret = ov2680_exposure_set(sensor, false);
+	ret = ov2680_load_regs(sensor, sensor->current_mode);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_load_regs(sensor, sensor->current_mode);
+	/* Restore value of all ctrls */
+	ret = __v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
 	if (ret < 0)
 		return ret;
 
-	if (ctrls->auto_gain->val) {
-		ret = ov2680_gain_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (ctrls->auto_exp->val == V4L2_EXPOSURE_AUTO) {
-		ret = ov2680_exposure_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
 	sensor->mode_pending_changes = false;
 
 	return 0;
@@ -590,15 +514,10 @@ static int ov2680_s_power(struct v4l2_subdev *sd, int on)
 	else
 		ret = ov2680_power_off(sensor);
 
-	mutex_unlock(&sensor->lock);
-
-	if (on && ret == 0) {
-		ret = v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
-		if (ret < 0)
-			return ret;
-
+	if (on && ret == 0)
 		ret = ov2680_mode_restore(sensor);
-	}
+
+	mutex_unlock(&sensor->lock);
 
 	return ret;
 }
@@ -794,52 +713,19 @@ static int ov2680_enum_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ov2680_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
-{
-	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
-	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	int val;
-
-	if (!sensor->is_enabled)
-		return 0;
-
-	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
-		val = ov2680_gain_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->gain->val = val;
-		break;
-	case V4L2_CID_EXPOSURE:
-		val = ov2680_exposure_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->exposure->val = val;
-		break;
-	}
-
-	return 0;
-}
-
 static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 
 	if (!sensor->is_enabled)
 		return 0;
 
 	switch (ctrl->id) {
-	case V4L2_CID_AUTOGAIN:
-		return ov2680_gain_set(sensor, !!ctrl->val);
 	case V4L2_CID_GAIN:
-		return ov2680_gain_set(sensor, !!ctrls->auto_gain->val);
-	case V4L2_CID_EXPOSURE_AUTO:
-		return ov2680_exposure_set(sensor, !!ctrl->val);
+		return ov2680_gain_set(sensor, ctrl->val);
 	case V4L2_CID_EXPOSURE:
-		return ov2680_exposure_set(sensor, !!ctrls->auto_exp->val);
+		return ov2680_exposure_set(sensor, ctrl->val);
 	case V4L2_CID_VFLIP:
 		if (sensor->is_streaming)
 			return -EBUSY;
@@ -864,7 +750,6 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 }
 
 static const struct v4l2_ctrl_ops ov2680_ctrl_ops = {
-	.g_volatile_ctrl = ov2680_g_volatile_ctrl,
 	.s_ctrl = ov2680_s_ctrl,
 };
 
@@ -936,7 +821,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	v4l2_ctrl_handler_init(hdl, 7);
+	v4l2_ctrl_handler_init(hdl, 5);
 
 	hdl->lock = &sensor->lock;
 
@@ -948,16 +833,9 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 					ARRAY_SIZE(test_pattern_menu) - 1,
 					0, 0, test_pattern_menu);
 
-	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
-						 V4L2_CID_EXPOSURE_AUTO,
-						 V4L2_EXPOSURE_MANUAL, 0,
-						 V4L2_EXPOSURE_AUTO);
-
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_EXPOSURE,
 					    0, 32767, 1, 0);
 
-	ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTOGAIN,
-					     0, 1, 1, 1);
 	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN, 0, 2047, 1, 0);
 
 	if (hdl->error) {
@@ -965,14 +843,9 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 		goto cleanup_entity;
 	}
 
-	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
-	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
 	ctrls->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 	ctrls->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
-
 	sensor->sd.ctrl_handler = hdl;
 
 	ret = v4l2_async_register_subdev(&sensor->sd);
-- 
2.40.1



