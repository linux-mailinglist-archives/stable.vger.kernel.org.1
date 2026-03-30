Return-Path: <stable+bounces-231115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LgbAStJymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:58:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591A358B58
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382713082861
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E153B27D3;
	Mon, 30 Mar 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mXtuFpX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255562E8B71
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864263; cv=none; b=NmMCid+FdC+/jsTSFiPQzLoyvfNWKw/Za37+EIvwKESVUtN9uxQyuckF5w9fWMVGoxxO14KCl2csuHdmXopJsrT5VHEtyncbmFcUs6Mk4ryBI9JjTJt6Mx6eYKTod/PlRNl3nMDAcTNFoFoCctmgnkA4ldH5CVKD7JcNkhKP6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864263; c=relaxed/simple;
	bh=PKdeNF97/K9TcVzSv+2thVRTi8KwgGeYlBrK84Hn9eA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vFPI4Y9cQyrdGc64ETNLLzL+ZgxJN6mW0FIBY9BC7320OOM5uR2G0uaf5ix8rki+nAQLMOUr4vxWQ9WMGXRw2OJ8JrWE2t9uTyx1tCt6NO8QU1St5V3/3oQ6aDmRyIxYXOFIyPpmVp1AhfPHynzr7JgcDL5UTH9+CMiVr5UEPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXtuFpX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417B7C2BC9E;
	Mon, 30 Mar 2026 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864262;
	bh=PKdeNF97/K9TcVzSv+2thVRTi8KwgGeYlBrK84Hn9eA=;
	h=Subject:To:Cc:From:Date:From;
	b=mXtuFpX3ZXMMyz9pE8ey+7ZDrHO+/Q4XQd8mqt30jWVJ5dXk01x+/ntK9Rb9x0nBs
	 auNnWFjRladfLK+hvzGZBZFoRkBwGhVJkaiQ85JUMOYe8kHbGuLJ/T1Ua83T/s5gwn
	 zhM65fATFjV4a7OePFIrXOHvn5/X/oJOyd6+52dY=
Subject: FAILED: patch "[PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid" failed to apply to 6.19-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:50:59 +0200
Message-ID: <2026033059-apprehend-hazelnut-e2f0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231115-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 4591A358B58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 28922a43fdab715ed771175e8326ad7e13808be3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033059-apprehend-hazelnut-e2f0@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28922a43fdab715ed771175e8326ad7e13808be3 Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Thu, 19 Mar 2026 03:36:50 -0400
Subject: [PATCH] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid
 for smu v14

Forcibly disable the OD_FAN_CURVE feature when temperature or PWM range is invalid,
otherwise PMFW will reject this configuration on smu v14.0.2/14.0.3.

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
[  969.761627] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!
[ 1010.897800] amdgpu 0000:03:00.0: amdgpu: Fan curve temp setting(50) must be within [0, 0]!

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ab4905d466b60f170d85e19ca2a5d2b159aeb780)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 73762d9b5969..c3ebfac062a7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -56,6 +56,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
 	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
 		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
@@ -922,8 +926,35 @@ static bool smu_v14_0_2_is_od_feature_supported(struct smu_context *smu,
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
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_TEMP,
+							  &min_value, &max_value);
+			if (!min_value && !max_value) {
+				feature_enabled = false;
+				goto out;
+			}
+
+			smu_v14_0_2_get_od_setting_limits(smu, PP_OD_FEATURE_FAN_CURVE_PWM,
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
 
 static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,


