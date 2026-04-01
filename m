Return-Path: <stable+bounces-232812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG5lH5pGzWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9E37DDD4
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6297A30DCDE7
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848784779A8;
	Wed,  1 Apr 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL3ELQ8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B235DA77
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060200; cv=none; b=WiW7KuAN8GK9t+AL3i6j+d2xuNnk19ZUn9UFXNerdMqxEURi467evXpMbQzQRYomh6neK85XYXr2W0iTS4nGNh6eRevz4N8w+184GFH/ahDSkHXkwGBtAnYSBVlzGncXV4dl8p3O3E3jYAtw1wWmyUyDQJW6f34kfATcsvgHn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060200; c=relaxed/simple;
	bh=9sTFh19675YW33XR5lrDWc8R0ki4ao6rxgTtGUa1CbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofqlDlBIYRBD9dUAYfHeV1AzDOA6O1F/9inYJBoHJKolCNqKHulg9g2/mq/lhNq9PvXm1x9GK6Tc02rf1qYlju4SFTLSvkwn24fGBGc7UX0ouOhSzjjhXhSSfec/ZpmGkYcDblZ//6hic3fG28PO38eBfNnB6rn/D+sRmON8UKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL3ELQ8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FD6C4CEF7;
	Wed,  1 Apr 2026 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775060200;
	bh=9sTFh19675YW33XR5lrDWc8R0ki4ao6rxgTtGUa1CbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eL3ELQ8LJrdWwdi7pLT3wKfQJqbF0lRzM0aNlvdsblAsI+A4UTKhz1YAJyCD70ep4
	 X3VNhbhdBqd5nsw4d4WNmTagdmVYlKjTJTkDrKEOV6RznZ3buOK6sDxxiBjsGkgWBF
	 wSI8n8OX2F1knDSbiy4zvQEIe0GnH+DmmtXIFdMeKxae6bgoU5gGaK4whaHFRuI6cg
	 rW55iZRPPrhYNFRtKprrhdrLXa6CE+YGI/MwFLhoA4w/epL//to5zN5Itk9JBvW1Gp
	 nBBO/YRbeJFLbXdWJRrhtkD/mxIJlFdXzZVvQ16MNZ7h6/NRV+CvM6/RmxiiV84lyI
	 glOzkd4zpZwsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v13
Date: Wed,  1 Apr 2026 12:16:37 -0400
Message-ID: <20260401161637.114960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033042-superior-difficult-0a49@gregkh>
References: <2026033042-superior-difficult-0a49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232812-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CB9E37DDD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 3e6dd28a11083e83e11a284d99fcc9eb748c321c ]

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
[ adapted forward declaration placement to existing FEATURE_MASK macro ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 33 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f4ce4dd027800..cd7db433795f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
@@ -1061,8 +1065,35 @@ static bool smu_v13_0_0_is_od_feature_supported(struct smu_context *smu,
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
index e7b2e823812cb..da31a6504ac05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -59,6 +59,10 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
+static void smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
+					      int od_feature_bit,
+					      int32_t *min, int32_t *max);
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)     | \
@@ -1050,8 +1054,35 @@ static bool smu_v13_0_7_is_od_feature_supported(struct smu_context *smu,
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
-- 
2.53.0


