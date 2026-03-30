Return-Path: <stable+bounces-231112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDuPJtZIymlc7QUAu9opvQ
	(envelope-from <stable+bounces-231112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C65358ABF
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 321EF3065306
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE03B5852;
	Mon, 30 Mar 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aG44AT/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F1A3B19A5
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864247; cv=none; b=pEYa0vTp4GxlSXCQyuztcsy01G4nqfAVe4HxkLeYvXYJUfTj9+w6z0qocwX9ev7OOV+Jx15TX+9iOiFcLo8HhwwMnBG494EFPhjUpntAY95eYBpyVib0JMkwcMPpyEdJPIPWoJtunFSlk8F4tFC7BIhMCgp6YGmkM1i9yXOsIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864247; c=relaxed/simple;
	bh=21HO+Jwr0pVSXS0xFAg5GKBgKZuG0uLXxJM1dHYcqv4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PnIERzscd1QTs1lqKh68MWamI27USEAW8ny4TWvcoPWqkqItOmAZEaPG18brgNcVJsCT8b8Db9FpBaUUTLovBDCLvj0o5irbflN84j/5gA3tiQBj5tTp9u3nxbK3fi4y38kaKBiRyiD1P/zVNaYLYLRLI57CjEh8/1LKz1dmRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aG44AT/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DD2C4CEF7;
	Mon, 30 Mar 2026 09:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864246;
	bh=21HO+Jwr0pVSXS0xFAg5GKBgKZuG0uLXxJM1dHYcqv4=;
	h=Subject:To:Cc:From:Date:From;
	b=aG44AT/RdG3zy44PF0QWyUj8/G2hKzmHxoJhjS7yqfFdPSh6285fEgKBPn9HzxrVI
	 FNJEPakOKonz9dqR8q0g7/LrdpHj9jiwwyBkPMAicM0JaTYBryLOZiTlChDacR3RxZ
	 nr7Rcp9+Oki+2xP0Iz1bfHhLzUb8/FZ3TIdqvb1Q=
Subject: FAILED: patch "[PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid" failed to apply to 6.19-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:50:43 +0200
Message-ID: <2026033042-superior-difficult-0a49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231112-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 10C65358ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3e6dd28a11083e83e11a284d99fcc9eb748c321c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033042-superior-difficult-0a49@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3e6dd28a11083e83e11a284d99fcc9eb748c321c Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Thu, 19 Mar 2026 21:17:38 -0400
Subject: [PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid
 for smu v13

Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range is invalid,
otherwise PMFW will reject this configuration on smu v13.0.x

example:
$ sudo cat /sys/bus/pci/devices/<BDF>/gpu_od/fan_ctrl/fan_curve

OD_FAN_CURVE:
0: 0C 0%
1: 0C 0%
2: 0C 0%
3: 0C 0%
4: 0C 0%
OD_RANGE:
FAN_CURVE(hotspot temp): 0C 0C
FAN_CURVE(fan speed): 0% 0%

$ echo "0 50 40" | sudo tee fan_curve

kernel log:
[  756.442527] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!
[  777.345800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!

Closes: https://github.com/ROCm/amdgpu/issues/208
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 470891606c5a97b1d0d937e0aa67a3bed9fcb056)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a8d63d4d1f6e..554f616328c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_0_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1043,8 +1047,35 @@ static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_FAN_CURVE_BIT:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v13_0_0_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+		}
+		break;
+	default:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		break;
+	}
+
+out:
+	return feature_enabled;
 }
 
 static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 5500a0f12f0e..f331e87858c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@ -1053,8 +1057,35 @@ static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
 				&pptable->SkuTable.OverDriveLimitsBasicMax;
+	int32_t min_value, max_value;
+	bool feature_enabled;
 
-	return overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit);
+	switch (od_feature_bit) {
+	case PP_OD_FEATURE_FAN_CURVE_BIT:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		if (feature_enabled) {
+			smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v13_0_7_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+		}
+		break;
+	default:
+		feature_enabled = !!(overdrive_upperlimits->FeatureCtrlMask & (1U << od_feature_bit));
+		break;
+	}
+
+out:
+	return feature_enabled;
 }
 
 static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,


