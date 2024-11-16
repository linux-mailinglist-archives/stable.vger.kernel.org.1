Return-Path: <stable+bounces-93644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276319CFEF6
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB13F287FED
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB216631C;
	Sat, 16 Nov 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDVdmehu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE12C470
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762287; cv=none; b=ikJWW4uq3ZSzvns2Mzw4s99PZyKhWGsKf4v8v1df5QJDfxWmz1JfVbwrHTtwG/oVl3cXmGtMaam1QVI/0YtMh45fFYhBZNqLCypKOaGPd0Ux0z/FBiJVO8zgE3CfBgLXx3nhqWbZrWMAg8Gg/0+33Vvjm9o9FHHdaj5JW+d1aGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762287; c=relaxed/simple;
	bh=14Kmtp+QHAHiF6crmcI2HUdJ7ScxEgaTYmxm0E6I9KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUQ4MPymmiEzklH/JSN/gFr114XA+4s17X8Py9UzCMoJMWiOefEpqc7xPnQRsdwqahWS4TU7fJedgolQmSOGGODYyl2iyiQP5S7KsLXhaREiO/VGiGVo4uTV1LPF73AXi+htod9ZX/IonMBV7lPIwWSvwcFBwruGtevty+hHYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDVdmehu; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460a612d867so2849191cf.3
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 05:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762284; x=1732367084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOr+pH7O6SOfDB3FQItpqSZxcv9ug3IMYOKWgou0aBI=;
        b=cDVdmehuMEF3c3otQqs9QygeWAn45n33L/ZvXPFvwqNuq1yUd3r2GznXBj/r4ytxBH
         DtpGiOgaYaM2538uJUsq2FDo78XSQS+bpXH+Irj5acLiz635zWCa8GRCfKCkw9Jmu/4K
         x+p+2kFPDXyFJnXxktiABxw4ghtPWSPqxIgaNr4He9NhVzcy/Yfje94nthpsXqliFEzD
         3yvfS1Ah6tfL5pf7G6xgcN51tHy7JJyS81Q1FufklcBB9RLivN6dJbNyGaZNIsFADbA0
         QIsEyZUNTSqSUBMl7VOdhfRr34x3MtH6iu8cN1vwp0Sfaha5uZVQCXY5LOmFL/6QRArp
         CIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762284; x=1732367084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOr+pH7O6SOfDB3FQItpqSZxcv9ug3IMYOKWgou0aBI=;
        b=ByTdQEikYXawSEnCCL80KXO1/8mxS9fYPOIoLDy9YC053P+p9Nnz/fzv0tQxfMl/K0
         s/eavIXtDg/SgSnyP7o8cpug1HPGYwQ/u8dWQRhDNadzDWUS6lT9XOoEdnn/tIY+X+zd
         L+BXAG396hDWkBdjrTrUtMAgCXaQL6aTAuH5UbtME19oZK7T97WPJA/SaBQl8Yf0yWPH
         rNjWeFOzU1qi54aklPy83SqDP85A9AEhwjpgiZFKd+aNQuWNP+OI85eOiovpI5Yrm7eR
         wTXTw2zzzzSKXnlAX46ngEzWSA0Fc0hhIguGx8EONgkDXz7ZZT2Vy1iOv9C281+EtKVu
         PszA==
X-Gm-Message-State: AOJu0YwiTJtgqAqbMgMg8lpST9RL3iIyc0pxCbNjUJBfS98QCw6nAiMK
	4V39r+Bq5a8gXLHI8R2HUzfWEHPkljtiFKH3lf3KLklAzmFNwcN5GSAN6gPm
X-Gm-Gg: ASbGncs8lIr2DA0qNKz6bP3vA7PBfy+Vp4u3SDTfkwTtth2L2Z/Ybc9zn0cODORV2zf
	1BU4g+p6TuCDqc74yuI8H2xLSiQftxzAVjMaxfQwV4F7u0w9xTgSqlHSjgA1KMvAjjBaGZiQ57o
	O847AltZLftAheSPp966iSRI/koaqoaL0c150pr9RBq8lPFgu4s57XkPbV4Nuyo38YqGIn7T0Jm
	yScowAP2gmDJXfV2uo2DkedqYTtyVzirWr7XgOMSNvuo6v9VBejFAz12HH8O4qTumE=
X-Google-Smtp-Source: AGHT+IFOc2K8h+wneyIOVV87Uat/yX2vBHBUy9CZpn/kG4N3GBBsQFJXnhFLxvcY36Ty3CIQx94yrw==
X-Received: by 2002:a05:620a:2a11:b0:7b1:13c9:ad10 with SMTP id af79cd13be357-7b36236be01mr369425285a.14.1731762283918;
        Sat, 16 Nov 2024 05:04:43 -0800 (PST)
Received: from tr4.amd.com (mkmvpn.amd.com. [165.204.54.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca2f632sm257722585a.73.2024.11.16.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:04:42 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amd/pm: correct the workload setting"
Date: Sat, 16 Nov 2024 08:04:27 -0500
Message-ID: <20241116130427.1688714-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.

This causes a regression in the workload selection.
A more extensive fix is being worked on for mainline.
For stable, revert.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.11.x
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 49 ++++++-------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 20 ++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  5 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  9 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  8 ---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 -
 12 files changed, 36 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ee1bcfaae3e3..80e60ea2d11e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1259,33 +1259,26 @@ static int smu_sw_init(void *handle)
 	smu->watermarks_bitmap = 0;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-	smu->user_dpm_profile.user_workload_mask = 0;
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
-	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
-	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
+	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
 
 	if (smu->is_apu ||
-	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
-	} else {
-		smu->driver_workload_mask =
-			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
-		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-	}
+	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
+	else
+		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 
-	smu->workload_mask = smu->driver_workload_mask |
-							smu->user_dpm_profile.user_workload_mask;
 	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
@@ -2355,20 +2348,17 @@ static int smu_switch_power_profile(void *handle,
 		return -EINVAL;
 
 	if (!en) {
-		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
+		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	} else {
-		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
+		smu->workload_mask |= (1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
 		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 	}
 
-	smu->workload_mask = smu->driver_workload_mask |
-						 smu->user_dpm_profile.user_workload_mask;
-
 	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
@@ -3059,23 +3049,12 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
-	int ret;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	if (smu->user_dpm_profile.user_workload_mask &
-	   (1 << smu->workload_priority[param[param_size]]))
-	   return 0;
-
-	smu->user_dpm_profile.user_workload_mask =
-		(1 << smu->workload_priority[param[param_size]]);
-	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
-		smu->driver_workload_mask;
-	ret = smu_bump_power_profile_mode(smu, param, param_size);
-
-	return ret;
+	return smu_bump_power_profile_mode(smu, param, param_size);
 }
 
 static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index d60d9a12a47e..b44a185d07e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
 	uint32_t clk_dependency;
-	uint32_t user_workload_mask;
 };
 
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
@@ -558,8 +557,7 @@ struct smu_context {
 	bool disable_uclk_switch;
 
 	uint32_t workload_mask;
-	uint32_t driver_workload_mask;
-	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
+	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
 	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
 	uint32_t power_profile_mode;
 	uint32_t default_power_profile_mode;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 31fe512028f4..c0f6b59369b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1455,6 +1455,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 		return -EINVAL;
 	}
 
+
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
 		if (size != 10)
@@ -1522,14 +1523,14 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetWorkloadMask,
-					  smu->workload_mask,
+					  1 << workload_type,
 					  NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index bb4ae529ae20..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2081,13 +2081,10 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index ca94c52663c0..0d3e1a121b67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1786,13 +1786,10 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
-	else
-		smu_cmn_assign_power_profile(smu);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 952ee22cbc90..1fe020f1f4db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1079,7 +1079,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
+				    1 << workload_type,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
@@ -1087,7 +1087,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 62316a6707ef..cc0504b063fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -890,14 +890,14 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
-				    smu->workload_mask,
+				    1 << workload_type,
 				    NULL);
 	if (ret) {
 		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
 		return ret;
 	}
 
-	smu_cmn_assign_power_profile(smu);
+	smu->power_profile_mode = profile_mode;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5dd7ceca64fe..d53e162dcd8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2485,7 +2485,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	DpmActivityMonitorCoeffInt_t *activity_monitor =
 		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
 	int workload_type, ret = 0;
-	u32 workload_mask;
+	u32 workload_mask, selected_workload_mask;
 
 	smu->power_profile_mode = input[size];
 
@@ -2552,7 +2552,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	workload_mask = 1 << workload_type;
+	selected_workload_mask = workload_mask = 1 << workload_type;
 
 	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
 	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
@@ -2567,22 +2567,12 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			workload_mask |= 1 << workload_type;
 	}
 
-	smu->workload_mask |= workload_mask;
 	ret = smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_SetWorkloadMask,
-					       smu->workload_mask,
+					       workload_mask,
 					       NULL);
-	if (!ret) {
-		smu_cmn_assign_power_profile(smu);
-		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
-			workload_type = smu_cmn_to_asic_specific_index(smu,
-							       CMN2ASIC_MAPPING_WORKLOAD,
-							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
-			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
-										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
-										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
-		}
-	}
+	if (!ret)
+		smu->workload_mask = selected_workload_mask;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9d0b19419de0..b891a5e0a396 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2499,14 +2499,13 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 						       smu->power_profile_mode);
 	if (workload_type < 0)
 		return -EINVAL;
-
 	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-				    smu->workload_mask, NULL);
+				    1 << workload_type, NULL);
 
 	if (ret)
 		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
 	else
-		smu_cmn_assign_power_profile(smu);
+		smu->workload_mask = (1 << workload_type);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d9f0e7f81ed7..eaf80c5b3e4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1508,11 +1508,12 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	if (workload_type < 0)
 		return -EINVAL;
 
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
-										  smu->workload_mask, NULL);
-
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetWorkloadMask,
+					       1 << workload_type,
+					       NULL);
 	if (!ret)
-		smu_cmn_assign_power_profile(smu);
+		smu->workload_mask = 1 << workload_type;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bdfc5e617333..91ad434bcdae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1138,14 +1138,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-void smu_cmn_assign_power_profile(struct smu_context *smu)
-{
-	uint32_t index;
-	index = fls(smu->workload_mask);
-	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
-	smu->power_profile_mode = smu->workload_setting[index];
-}
-
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 {
 	struct pci_dev *p = NULL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 8a801e389659..1de685defe85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
 int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
 
-void smu_cmn_assign_power_profile(struct smu_context *smu);
-
 /*
  * Helper function to make sysfs_emit_at() happy. Align buf to
  * the current page boundary and record the offset.
-- 
2.47.0


