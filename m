Return-Path: <stable+bounces-204797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC28CF3CE9
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 836363003FEC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A1239E6C;
	Mon,  5 Jan 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXT5NKeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BF23958D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619839; cv=none; b=bluIOnOQkf6vXBlS1RUeH6tzV1BH+OLFm1bCLgrg5vTmfnAee7lD8basgLI67PRkut6LKqPfU1KenG1iHGFIHJpwoXfcX34Eg9uNIFhb71trSM/EOnHGlC81dUV/6mFVzhzxNutCXWBVwjkG5WgtQZDQAw1XxEVHGdyREu1MiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619839; c=relaxed/simple;
	bh=bfGrPOsn9yeKExAhuSXXk11bnSHo4CwqzR4VBo90xGI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Glu0r6b2merq6Syl6fm7PdJv1TGM/CCadjVaHPpz3H2zUGoNx7LubSeVV96DRL+Epw5bDVU09NE9QfJNSyd1JUlnhC8a9Ms5orIA6wAsZAiQlLtMJUa+vF6+neN8eMHKvE4wxe4fK9GPJE9mC6rhM/r+aZhPljkKKPmogyLTA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xXT5NKeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C342FC116D0;
	Mon,  5 Jan 2026 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619839;
	bh=bfGrPOsn9yeKExAhuSXXk11bnSHo4CwqzR4VBo90xGI=;
	h=Subject:To:Cc:From:Date:From;
	b=xXT5NKeC2EumemAjjLVwilG9Aji8fsPaOOXCTANH/qvtr/cDio3vpBlYtxIr/upNP
	 wufJXfUa80qtdWQtWsDH6itqhbPAOhTNtX5v2FuI9yrtzPQv+tSkppQKFArtNOZvmP
	 eoI1mm03pdlyMfedcelT/K6+AVETRPs+q/tQ0NxI=
Subject: FAILED: patch "[PATCH] drm/msm: Fix a7xx per pipe register programming" failed to apply to 6.18-stable tree
To: anna.maniscalco2000@gmail.com,akhilpo@oss.qualcomm.com,robin.clark@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:30:36 +0100
Message-ID: <2026010536-emoticon-pessimist-46ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d2b6e710d2706c8915fe5e2f961c3365976d2ae1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010536-emoticon-pessimist-46ea@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2b6e710d2706c8915fe5e2f961c3365976d2ae1 Mon Sep 17 00:00:00 2001
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Mon, 1 Dec 2025 19:14:36 +0100
Subject: [PATCH] drm/msm: Fix a7xx per pipe register programming

GEN7_GRAS_NC_MODE_CNTL was only programmed for BR and not for BV pipe
but it needs to be programmed for both.

Program both pipes in hw_init and introducea separate reglist for it in
order to add this register to the dynamic reglist which supports
restoring registers per pipe.

Fixes: 91389b4e3263 ("drm/msm/a6xx: Add a pwrup_list field to a6xx_info")
Cc: stable@vger.kernel.org
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/691553/
Message-ID: <20251201-gras_nc_mode_fix-v3-1-92a8a10d91d0@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index b731491dc522..ac9a95aab2fb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1376,7 +1376,6 @@ static const uint32_t a7xx_pwrup_reglist_regs[] = {
 	REG_A6XX_UCHE_MODE_CNTL,
 	REG_A6XX_RB_NC_MODE_CNTL,
 	REG_A6XX_RB_CMP_DBG_ECO_CNTL,
-	REG_A7XX_GRAS_NC_MODE_CNTL,
 	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
 	REG_A6XX_UCHE_GBIF_GX_CONFIG,
 	REG_A6XX_UCHE_CLIENT_PF,
@@ -1449,6 +1448,12 @@ static const u32 a750_ifpc_reglist_regs[] = {
 
 DECLARE_ADRENO_REGLIST_LIST(a750_ifpc_reglist);
 
+static const struct adreno_reglist_pipe a7xx_dyn_pwrup_reglist_regs[] = {
+	{ REG_A7XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+};
+
+DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
+
 static const struct adreno_info a7xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
@@ -1492,6 +1497,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a730_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020000,
 		},
@@ -1514,6 +1520,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
 			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7020100,
 			.gmu_cgc_mode = 0x00020202,
@@ -1548,6 +1555,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
 			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7050001,
@@ -1590,6 +1598,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
 			.ifpc_reglist = &a750_ifpc_reglist,
 			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x7090100,
@@ -1624,6 +1633,7 @@ static const struct adreno_info a7xx_gpus[] = {
 			.hwcg = a740_hwcg,
 			.protect = &a730_protect,
 			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
 			.gbif_cx = a640_gbif,
 			.gmu_chipid = 0x70f0000,
 			.gmu_cgc_mode = 0x00020222,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 7e71f6bb5283..2129d230a92b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -849,9 +849,16 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 		  min_acc_len_64b << 3 |
 		  hbb_lo << 1 | ubwc_mode);
 
-	if (adreno_is_a7xx(adreno_gpu))
-		gpu_write(gpu, REG_A7XX_GRAS_NC_MODE_CNTL,
-			  FIELD_PREP(GENMASK(8, 5), hbb_lo));
+	if (adreno_is_a7xx(adreno_gpu)) {
+		for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_BV; pipe_id++) {
+			gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
+				  A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id));
+			gpu_write(gpu, REG_A7XX_GRAS_NC_MODE_CNTL,
+				  FIELD_PREP(GENMASK(8, 5), hbb_lo));
+		}
+		gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
+			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(PIPE_NONE));
+	}
 
 	gpu_write(gpu, REG_A6XX_UCHE_MODE_CNTL,
 		  min_acc_len_64b << 23 | hbb_lo << 21);
@@ -865,9 +872,11 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	const struct adreno_reglist_list *reglist;
+	const struct adreno_reglist_pipe_list *dyn_pwrup_reglist;
 	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
 	struct cpu_gpu_lock *lock = ptr;
 	u32 *dest = (u32 *)&lock->regs[0];
+	u32 dyn_pwrup_reglist_count = 0;
 	int i;
 
 	lock->gpu_req = lock->cpu_req = lock->turn = 0;
@@ -909,7 +918,24 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	 * (<aperture, shifted 12 bits> <address> <data>), and the length is
 	 * stored as number for triplets in dynamic_list_len.
 	 */
-	lock->dynamic_list_len = 0;
+	dyn_pwrup_reglist = adreno_gpu->info->a6xx->dyn_pwrup_reglist;
+	if (dyn_pwrup_reglist) {
+		for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_BV; pipe_id++) {
+			gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
+				  A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id));
+			for (i = 0; i < dyn_pwrup_reglist->count; i++) {
+				if ((dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)) == 0)
+					continue;
+				*dest++ = A7XX_CP_APERTURE_CNTL_HOST_PIPE(pipe_id);
+				*dest++ = dyn_pwrup_reglist->regs[i].offset;
+				*dest++ = gpu_read(gpu, dyn_pwrup_reglist->regs[i].offset);
+				dyn_pwrup_reglist_count++;
+			}
+		}
+		gpu_write(gpu, REG_A7XX_CP_APERTURE_CNTL_HOST,
+			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(PIPE_NONE));
+	}
+	lock->dynamic_list_len = dyn_pwrup_reglist_count;
 }
 
 static int a7xx_preempt_start(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6820216ec5fc..4eaa04711246 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -45,6 +45,7 @@ struct a6xx_info {
 	const struct adreno_reglist *hwcg;
 	const struct adreno_protect *protect;
 	const struct adreno_reglist_list *pwrup_reglist;
+	const struct adreno_reglist_pipe_list *dyn_pwrup_reglist;
 	const struct adreno_reglist_list *ifpc_reglist;
 	const struct adreno_reglist *gbif_cx;
 	const struct adreno_reglist_pipe *nonctxt_reglist;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 0f8d3de97636..1d0145f8b3ec 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -188,6 +188,19 @@ static const struct adreno_reglist_list name = {		\
 	.count = ARRAY_SIZE(name ## _regs),		\
 };
 
+struct adreno_reglist_pipe_list {
+	/** @reg: List of register **/
+	const struct adreno_reglist_pipe *regs;
+	/** @count: Number of registers in the list **/
+	u32 count;
+};
+
+#define DECLARE_ADRENO_REGLIST_PIPE_LIST(name)	\
+static const struct adreno_reglist_pipe_list name = {		\
+	.regs = name ## _regs,				\
+	.count = ARRAY_SIZE(name ## _regs),		\
+};
+
 struct adreno_gpu {
 	struct msm_gpu base;
 	const struct adreno_info *info;


