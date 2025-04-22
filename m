Return-Path: <stable+bounces-135020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10656A95E03
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFDA7A83E0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D91F2B8B;
	Tue, 22 Apr 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmUZA7D+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6371EF090
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302811; cv=none; b=tKMaJt5bDp0FojmDGeZWUb9pbslbjgEe+kJ2MmgiB6uM2i8MYiMU7IeOpGXAq0qjgXUdL6kY+JUuFIZuFk00NvXm+7CVnIYaHciOqbG5Rw+b0oE93VBsyox2XYqh9AEC2YwBSGLAQQ65pxSpt9EeV+a/Is1xRSntOrZ8QkXCSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302811; c=relaxed/simple;
	bh=WnJ03ztcgAyuL21s72NPkDGMJsBIcaaeghTIO1dZ1fU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sOI3cW0Sr6t8mfU+seEbazQ8peMAAMvmV/gGDSyW5//n0y8+TcSMKZQJP26zpjqGJHqXwUEPetg432wkm1P9lzjGXcr+zgEWYukGWZuSbszlx9Dy3hsrUf2v8FvZB3Kmy1SSWIQCXzfM2jaiIlGYRbUARkCMHCtKTkZTb5/fyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmUZA7D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C1EC4CEE9;
	Tue, 22 Apr 2025 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302811;
	bh=WnJ03ztcgAyuL21s72NPkDGMJsBIcaaeghTIO1dZ1fU=;
	h=Subject:To:Cc:From:Date:From;
	b=jmUZA7D+0RkXhNg/yww8tnAnvNIP5JvAQZ/PanUELkxt8oUhb3i0rpL2JaPfx48Nx
	 7nmi+waflSVFMB5oIY81L34YeJ4jAWPql+D8yFRYqBL5HHwZxDB6qanPvu44lFGzH8
	 SWoFGQjmlnxQiWwZRRN54jO+fM/7erExKXbSU0ZY=
Subject: FAILED: patch "[PATCH] drm/amd/pm: Add zero RPM enabled OD setting support for" failed to apply to 6.12-stable tree
To: tomasz.pakula.oficjalny@gmail.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:20:08 +0200
Message-ID: <2025042208-negotiate-doily-2307@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b03f1810db7bf609a64b90704f11da46e3baa050
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042208-negotiate-doily-2307@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b03f1810db7bf609a64b90704f11da46e3baa050 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Date: Tue, 25 Mar 2025 11:26:52 +0100
Subject: [PATCH] drm/amd/pm: Add zero RPM enabled OD setting support for
 SMU14.0.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hook up zero RPM enable for 9070 and 9070 XT based on RDNA3
(smu 13.0.0 and 13.0.7) code.

Tested on 9070 XT Hellhound

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index f7cfe1f35cae..82c2db972491 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -79,6 +79,7 @@
 #define PP_OD_FEATURE_FAN_ACOUSTIC_TARGET		8
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
+#define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1052,6 +1053,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanMinimumPwm;
 		od_max_setting = overdrive_upperlimits->FanMinimumPwm;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE:
+		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
+		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1330,6 +1335,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_ENABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_ENABLE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+				(int)od_table->OverDriveTable.FanZeroRpmEnable);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_ENABLE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2270,7 +2293,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_TARGET_TEMPERATURE_SET |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET;
+					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2349,6 +2374,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanTargetTemperature;
 		user_od_table->OverDriveTable.FanMinimumPwm =
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
+		user_od_table->OverDriveTable.FanZeroRpmEnable =
+			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2396,6 +2423,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+		od_table->OverDriveTable.FanZeroRpmEnable =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
@@ -2678,6 +2710,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM enable setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmEnable = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);


