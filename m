Return-Path: <stable+bounces-553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5F7F7B92
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4C7282019
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C639FE3;
	Fri, 24 Nov 2023 18:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+LFEV0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912431740;
	Fri, 24 Nov 2023 18:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEBCC433C8;
	Fri, 24 Nov 2023 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849186;
	bh=PVyBfrSxzuQuaaEnBQZuuwfg/WAmxLb22pY1eCHf29Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+LFEV0roXpd4aZvhk3gWRY+vNDgKjQSJ1XECmcCI8UiXlz/axQce718J8BboXks1
	 AA/n4T4EnlGHwL2lFDKOCa5NZiWTQVD02BiwsN+BrvGJkEK8MYox+/qJVdYEzn9AO5
	 P4mAM29isVJfASlfhr3CmJARbjoyKdswrqwk0ndo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 057/530] drm/amd: Update `update_pcie_parameters` functions to use uint8_t arguments
Date: Fri, 24 Nov 2023 17:43:43 +0000
Message-ID: <20231124172029.797001508@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7752ccf85b929a22e658ec145283e8f31232f4bb ]

The matching values for `pcie_gen_cap` and `pcie_width_cap` when
fetched from powerplay tables are 1 byte, so narrow the arguments
to match to ensure min() and max() comparisons without casts.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 8 ++++----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af4..b47fd42414f46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1232,7 +1232,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
 	struct amdgpu_device *adev = smu->adev;
-	uint32_t pcie_gen = 0, pcie_width = 0;
+	uint8_t pcie_gen = 0, pcie_width = 0;
 	uint64_t features_supported;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 5a52098bcf166..72ed836328966 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -844,7 +844,7 @@ struct pptable_funcs {
 	 * &pcie_gen_cap: Maximum allowed PCIe generation.
 	 * &pcie_width_cap: Maximum allowed PCIe width.
 	 */
-	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
+	int (*update_pcie_parameters)(struct smu_context *smu, uint8_t pcie_gen_cap, uint8_t pcie_width_cap);
 
 	/**
 	 * @i2c_init: Initialize i2c.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 355c156d871af..cc02f979e9e98 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -296,8 +296,8 @@ int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t pptable_id);
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap);
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 18487ae10bcff..c564f6e191f84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2376,8 +2376,8 @@ static int navi10_get_power_limit(struct smu_context *smu,
 }
 
 static int navi10_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+					 uint8_t pcie_gen_cap,
+					 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index da2860da60188..0cc5d9769d382 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2085,14 +2085,14 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
 
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
-					 uint32_t pcie_gen_cap,
-					 uint32_t pcie_width_cap)
+						 uint8_t pcie_gen_cap,
+						 uint8_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	uint8_t *table_member1, *table_member2;
-	uint32_t min_gen_speed, max_gen_speed;
-	uint32_t min_lane_width, max_lane_width;
+	uint8_t min_gen_speed, max_gen_speed;
+	uint8_t min_lane_width, max_lane_width;
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0232adb95df3a..a280c1ed007f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2420,8 +2420,8 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
 }
 
 int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
-				     uint32_t pcie_gen_cap,
-				     uint32_t pcie_width_cap)
+				     uint8_t pcie_gen_cap,
+				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_13_0_pcie_table *pcie_table =
-- 
2.42.0




