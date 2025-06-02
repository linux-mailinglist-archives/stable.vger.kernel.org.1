Return-Path: <stable+bounces-148430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA130ACA2B2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E51C3B6EED
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CA225D20F;
	Sun,  1 Jun 2025 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwjQcVhe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF32586EC;
	Sun,  1 Jun 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820466; cv=none; b=IIULW639kPW4eLSzOBu7i0WfSi89IG8KPsFvVcshN/SopFZ/oTGP8Wuaz94RmpU3ZBdPHku2zwWUaOgcVa/gUbdJSuSv5zjVpqYvn5M4mNx19jPEQwPJJsEbYY50BSlKr7wfjwNrYoHEXTotiFFD0u10o1jx1skCoH9kNoZjmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820466; c=relaxed/simple;
	bh=H7N2aGpoDH1XiK8+uUWeESX3fLL7dORI5KeyL68eLl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr5bN8vudbwwjqbVuQ9hMPpBhhX+p6aJKL2Du7LLAo4XqDbaurZQuw42D9h36JpWU0CasFxIF9O43WfL6h7s/crU2rUH6KNfxVrq+rxLvA+uxlFQfVfi79B4cbArNYrxrrcyPJDxnfdUg2f7wMDHaFLGor9MU0iMSDIalHGg+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwjQcVhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D657C4CEE7;
	Sun,  1 Jun 2025 23:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820466;
	bh=H7N2aGpoDH1XiK8+uUWeESX3fLL7dORI5KeyL68eLl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwjQcVhezceZzgPVk/Adl21m0UYLQgWhGp1bWwSi/CC1GK3gP/bXB4RZCsq0M265r
	 vOiUqVz5ynGrmPM0orTAU7bP0b5QEZije+Xq6hrCy5B7CYStwNmcBs4v5L6L+jv2mP
	 ujHuLeIG+SRTiYuzOOusmqqgrvQ9Mc/upxGDvJIIhCft7U7Jy3qIi0APLPAj9V5175
	 0Hrt9Hyp3ZBampkpHbuXkXyerr1UYiZfroRHpe5bbScRbcGP4lCF4DXxupFFU0oed4
	 w57/K6QqHe12R3lBfFnlKo3WNmDejm0fo5sxmCTPlBjPvLPc9vA5ugLqTePQG9APKM
	 uy2IV+lx79Zgw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	asad.kamal@amd.com,
	Hawking.Zhang@amd.com,
	linux@treblig.org,
	Kun.Liu2@amd.com,
	boyuan.zhang@amd.com,
	tao.zhou1@amd.com,
	mario.limonciello@amd.com,
	kevinyang.wang@amd.com,
	Jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 064/110] drm/amd/pm: Reset SMU v13.0.x custom settings
Date: Sun,  1 Jun 2025 19:23:46 -0400
Message-Id: <20250601232435.3507697-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 923406e74ec66364b829b7f8b6b67d46200567a6 ]

On SMU v13.0.2 and SMU v13.0.6 variants user may choose custom min/max
clocks in manual perf mode. Those custom min/max values need to be
reset once user switches to auto or restores default settings.
Otherwise, they may get used inadvertently during the next operation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Problem Analysis The commit fixes a bug where
custom min/max clock settings in manual performance mode for SMU v13.0.2
and SMU v13.0.6 variants are not properly reset when users switch to
auto mode or restore default settings. This results in stale custom
values being inadvertently used in subsequent operations, causing
incorrect clock behavior. ## Code Changes Analysis ### 1. New Reset
Function (`smu_v13_0.c`) The commit introduces
`smu_v13_0_reset_custom_level()` function that properly resets all
custom pstate values: ```c void smu_v13_0_reset_custom_level(struct
smu_context *smu) { struct smu_umd_pstate_table *pstate_table =
&smu->pstate_table; pstate_table->uclk_pstate.custom.min = 0;
pstate_table->uclk_pstate.custom.max = 0;
pstate_table->gfxclk_pstate.custom.min = 0;
pstate_table->gfxclk_pstate.custom.max = 0; } ``` ### 2. Aldebaran
Implementation (`aldebaran_ppt.c`) - In
`aldebaran_set_performance_level()`: Added call to
`smu_v13_0_reset_custom_level(smu)` when switching to
`AMD_DPM_FORCED_LEVEL_AUTO` - In `aldebaran_usr_edit_dpm_table()`: Added
reset call in `PP_OD_RESTORE_DEFAULT_TABLE` case after successfully
restoring defaults ### 3. SMU v13.0.6 Implementation
(`smu_v13_0_6_ppt.c`) - Replaced manual
`pstate_table->uclk_pstate.custom.max = 0` with calls to
`smu_v13_0_reset_custom_level(smu)` in both: -
`smu_v13_0_6_set_performance_level()` for `AMD_DPM_FORCED_LEVEL_AUTO` -
`smu_v13_0_6_usr_edit_dpm_table()` for `PP_OD_RESTORE_DEFAULT_TABLE` ##
Backport Suitability Assessment ### ✅ **Fixes Important User-Visible
Bug** This addresses a real functional issue where GPU clock settings
don't behave as expected when switching between manual and auto modes,
affecting GPU performance and power management. ### ✅ **Small and
Contained Changes** - Introduces one small utility function (8 lines) -
Makes targeted changes to existing functions - No architectural changes
or new features - Changes are localized to AMD GPU power management
subsystem ### ✅ **Low Regression Risk** - The fix ensures proper cleanup
of state, reducing the chance of incorrect behavior - Changes are
defensive in nature (resetting stale values) - Affects only specific SMU
variants (v13.0.2, v13.0.6) - Only impacts performance level switching
code paths ### ✅ **Clear Bug Fix Pattern** Looking at the similar
commits provided: - **Similar Commit #2 and #4**: Both were marked "YES"
for backporting and had `Cc: stable@vger.kernel.org` tags. They fixed
SMU pstate profiling clock settings. - **Similar Commit #5**: Also
marked "YES" and had stable tag, fixing reported maximum shader clock
values. - The pattern shows SMU clock/pstate fixes are typically
backported when they fix user-visible functional issues. ### ✅ **Affects
Critical Subsystem Properly** While this touches GPU power management (a
critical subsystem), the changes follow established patterns and are
consistent with how similar SMU fixes have been handled. ### ✅ **No
Explicit Stable Tag But Follows Pattern** Although this commit lacks an
explicit `Cc: stable@vger.kernel.org` tag, the similar commits #2, #4,
and #5 show that SMU pstate/clock fixes of this nature are regularly
backported to stable trees. ## Conclusion This commit fixes a clear
functional bug in GPU power management that affects user experience,
uses a small and safe implementation, and follows the established
pattern of similar SMU fixes that have been successfully backported. The
risk of regression is minimal while the benefit of fixing incorrect
clock behavior is significant for users with affected AMD GPUs.

 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c  | 13 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c      | 10 ++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |  4 ++--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index cd03caffe3173..21589c4583e6b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -310,6 +310,7 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 				     uint32_t *value);
 
 void smu_v13_0_interrupt_work(struct smu_context *smu);
+void smu_v13_0_reset_custom_level(struct smu_context *smu);
 bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
 int smu_v13_0_12_get_max_metrics_size(void);
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 83163d7c7f001..5cb3b9bb60898 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1270,6 +1270,7 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 	struct smu_13_0_dpm_table *gfx_table =
 		&dpm_context->dpm_tables.gfx_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+	int r;
 
 	/* Disable determinism if switching to another mode */
 	if ((smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) &&
@@ -1282,7 +1283,11 @@ static int aldebaran_set_performance_level(struct smu_context *smu,
 
 	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
 		return 0;
-
+	case AMD_DPM_FORCED_LEVEL_AUTO:
+		r = smu_v13_0_set_performance_level(smu, level);
+		if (!r)
+			smu_v13_0_reset_custom_level(smu);
+		return r;
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 	case AMD_DPM_FORCED_LEVEL_LOW:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
@@ -1423,7 +1428,11 @@ static int aldebaran_usr_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_
 			min_clk = dpm_context->dpm_tables.gfx_table.min;
 			max_clk = dpm_context->dpm_tables.gfx_table.max;
 
-			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk, max_clk, false);
+			ret = aldebaran_set_soft_freq_limited_range(
+				smu, SMU_GFXCLK, min_clk, max_clk, false);
+			if (ret)
+				return ret;
+			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ba5a9012dbd5e..075f381ad311b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2595,3 +2595,13 @@ int smu_v13_0_set_wbrf_exclusion_ranges(struct smu_context *smu,
 
 	return ret;
 }
+
+void smu_v13_0_reset_custom_level(struct smu_context *smu)
+{
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
+
+	pstate_table->uclk_pstate.custom.min = 0;
+	pstate_table->uclk_pstate.custom.max = 0;
+	pstate_table->gfxclk_pstate.custom.min = 0;
+	pstate_table->gfxclk_pstate.custom.max = 0;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c478b3be37af1..b8feabb019cf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1927,7 +1927,7 @@ static int smu_v13_0_6_set_performance_level(struct smu_context *smu,
 				return ret;
 			pstate_table->uclk_pstate.curr.max = uclk_table->max;
 		}
-		pstate_table->uclk_pstate.custom.max = 0;
+		smu_v13_0_reset_custom_level(smu);
 
 		return 0;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
@@ -2140,7 +2140,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
 				smu, SMU_UCLK, min_clk, max_clk, false);
 			if (ret)
 				return ret;
-			pstate_table->uclk_pstate.custom.max = 0;
+			smu_v13_0_reset_custom_level(smu);
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.39.5


