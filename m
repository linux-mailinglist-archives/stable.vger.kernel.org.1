Return-Path: <stable+bounces-106442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F929FE856
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC98A3A25BC
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76CA537E9;
	Mon, 30 Dec 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJCPGM60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BCC15E8B;
	Mon, 30 Dec 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573989; cv=none; b=HrF6h9emHGcbbJ1IqaFqvZ1rtDUOTJ08y0DgrDYwrRKX6ApdREGCYTMhCRQDtJ+rkD+xvGUre+V2dFE6LzAP3/jHM9PfaWEOX5KresYQpsN7elpEUmj5Wi7EtbEP6YN24QSiWe3jaa2+FtXQG7SlqO1IglHACqeuWuvPcY7sXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573989; c=relaxed/simple;
	bh=sZfDqYV9v3M8ZfCLBGpjlUpiHDtUMmczdDawBZLOvbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOM+NmMX3lX57q8VZsu0j29cH1Zfoo/YkhQMm+4z/mYQMzE7tqsNKfYkP9l+swLU1NE8hwm9EgoFaG9cj5JGEO3rZS8HmlepXt7Fnm006k3hEoKArRcvRuaAkHViHrbh8Vw9NejegrG7Aa+e13zisd84fDU4EBIzllOxQQD0GU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJCPGM60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB281C4CED0;
	Mon, 30 Dec 2024 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573989;
	bh=sZfDqYV9v3M8ZfCLBGpjlUpiHDtUMmczdDawBZLOvbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zJCPGM601kMed77xb+tLFe9uNieCk9kNHWfvbhMatbfo3u4XSZhqqPM3DLLtKOm1S
	 yODUyY3xY1tTg1GBIspMXDMx2ziM/hrOD80Sumb8PzQi3/qpke1o8LXGeJTnbEtoYp
	 o9A4s5i5Uuj1T+RMHp1ksIRI/DQ8iFwKJoZdOU+E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 69/86] drm/amdkfd: drop struct kfd_cu_info
Date: Mon, 30 Dec 2024 16:43:17 +0100
Message-ID: <20241230154214.339459500@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 0021d70a0654e668d457758110abec33dfbd3ba5 ]

I think this was an abstraction back from when
kfd supported both radeon and amdgpu.  Since we just
support amdgpu now, there is no more need for this and
we can use the amdgpu structures directly.

This also avoids having the kfd_cu_info structures on
the stack when inlining which can blow up the stack.

Cc: Arnd Bergmann <arnd@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 438b39ac74e2 ("drm/amdkfd: pause autosuspend when creating pdd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 22 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 -
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 28 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 28 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 49 ++++++++-----------
 .../gpu/drm/amd/include/kgd_kfd_interface.h   | 14 ------
 6 files changed, 48 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index af6c6d89e63a..fbee10927bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -467,28 +467,6 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
 		return 100;
 }
 
-void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *cu_info)
-{
-	struct amdgpu_cu_info acu_info = adev->gfx.cu_info;
-
-	memset(cu_info, 0, sizeof(*cu_info));
-	if (sizeof(cu_info->cu_bitmap) != sizeof(acu_info.bitmap))
-		return;
-
-	cu_info->cu_active_number = acu_info.number;
-	cu_info->cu_ao_mask = acu_info.ao_cu_mask;
-	memcpy(&cu_info->cu_bitmap[0], &acu_info.bitmap[0],
-	       sizeof(cu_info->cu_bitmap));
-	cu_info->num_shader_engines = adev->gfx.config.max_shader_engines;
-	cu_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
-	cu_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
-	cu_info->simd_per_cu = acu_info.simd_per_cu;
-	cu_info->max_waves_per_simd = acu_info.max_waves_per_simd;
-	cu_info->wave_front_size = acu_info.wave_front_size;
-	cu_info->max_scratch_slots_per_cu = acu_info.max_scratch_slots_per_cu;
-	cu_info->lds_size = acu_info.lds_size;
-}
-
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3134e6ad81d1..ff2b8ace438b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -235,8 +235,6 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
-void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev,
-			       struct kfd_cu_info *cu_info);
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index f76b7aee5c0a..29a02c175228 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2037,11 +2037,12 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 				      uint32_t proximity_domain)
 {
 	struct crat_header *crat_table = (struct crat_header *)pcrat_image;
+	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
+	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
 	struct crat_subtype_generic *sub_type_hdr;
 	struct kfd_local_mem_info local_mem_info;
 	struct kfd_topology_device *peer_dev;
 	struct crat_subtype_computeunit *cu;
-	struct kfd_cu_info cu_info;
 	int avail_size = *size;
 	uint32_t total_num_of_cu;
 	uint32_t nid = 0;
@@ -2085,21 +2086,20 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	cu->flags |= CRAT_CU_FLAGS_GPU_PRESENT;
 	cu->proximity_domain = proximity_domain;
 
-	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
-	cu->num_simd_per_cu = cu_info.simd_per_cu;
-	cu->num_simd_cores = cu_info.simd_per_cu *
-			(cu_info.cu_active_number / kdev->kfd->num_nodes);
-	cu->max_waves_simd = cu_info.max_waves_per_simd;
+	cu->num_simd_per_cu = cu_info->simd_per_cu;
+	cu->num_simd_cores = cu_info->simd_per_cu *
+			(cu_info->number / kdev->kfd->num_nodes);
+	cu->max_waves_simd = cu_info->max_waves_per_simd;
 
-	cu->wave_front_size = cu_info.wave_front_size;
-	cu->array_count = cu_info.num_shader_arrays_per_engine *
-		cu_info.num_shader_engines;
-	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
+	cu->wave_front_size = cu_info->wave_front_size;
+	cu->array_count = gfx_info->max_sh_per_se *
+		gfx_info->max_shader_engines;
+	total_num_of_cu = (cu->array_count * gfx_info->max_cu_per_sh);
 	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
-	cu->num_cu_per_array = cu_info.num_cu_per_sh;
-	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
-	cu->num_banks = cu_info.num_shader_engines;
-	cu->lds_size_in_kb = cu_info.lds_size;
+	cu->num_cu_per_array = gfx_info->max_cu_per_sh;
+	cu->max_slots_scatch_cu = cu_info->max_scratch_slots_per_cu;
+	cu->num_banks = gfx_info->max_shader_engines;
+	cu->lds_size_in_kb = cu_info->lds_size;
 
 	cu->hsa_capability = 0;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 4c3f37980311..b276bffcaaf3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -99,7 +99,8 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		const uint32_t *cu_mask, uint32_t cu_mask_count,
 		uint32_t *se_mask, uint32_t inst)
 {
-	struct kfd_cu_info cu_info;
+	struct amdgpu_cu_info *cu_info = &mm->dev->adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &mm->dev->adev->gfx.config;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
 	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
@@ -108,9 +109,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	int inc = cu_inc * NUM_XCC(mm->dev->xcc_mask);
 	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
 
-	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
-
-	cu_active_per_node = cu_info.cu_active_number / mm->dev->kfd->num_nodes;
+	cu_active_per_node = cu_info->number / mm->dev->kfd->num_nodes;
 	if (cu_mask_count > cu_active_per_node)
 		cu_mask_count = cu_active_per_node;
 
@@ -118,13 +117,14 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * Returning with no CU's enabled will hang the queue, which should be
 	 * attention grabbing.
 	 */
-	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
-		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
+	if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
+		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
+		       gfx_info->max_shader_engines);
 		return;
 	}
-	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
+	if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
 		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
-			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
+			gfx_info->max_sh_per_se * gfx_info->max_shader_engines);
 		return;
 	}
 
@@ -142,10 +142,10 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
 	 * See note on GFX11 cu_bitmap layout in gfx_v11_0_get_cu_info.
 	 */
-	for (se = 0; se < cu_info.num_shader_engines; se++)
-		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
+	for (se = 0; se < gfx_info->max_shader_engines; se++)
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
 			cu_per_sh[se][sh] = hweight32(
-				cu_info.cu_bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
 				cu_bitmap_sh_mul]);
 
 	/* Symmetrically map cu_mask to all SEs & SHs:
@@ -184,13 +184,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 *
 	 * First ensure all CUs are disabled, then enable user specified CUs.
 	 */
-	for (i = 0; i < cu_info.num_shader_engines; i++)
+	for (i = 0; i < gfx_info->max_shader_engines; i++)
 		se_mask[i] = 0;
 
 	i = inst;
 	for (cu = 0; cu < 16; cu += cu_inc) {
-		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
-			for (se = 0; se < cu_info.num_shader_engines; se++) {
+		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
+			for (se = 0; se < gfx_info->max_shader_engines; se++) {
 				if (cu_per_sh[se][sh] > cu) {
 					if (cu_mask[i / 32] & (en_mask << (i % 32)))
 						se_mask[se] |= en_mask << (cu + sh * 16);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a51363e25624..3885bb53f019 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1537,7 +1537,6 @@ static int kfd_dev_create_p2p_links(void)
 /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
 static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
 				int cu_bitmask,
 				int cache_type, unsigned int cu_processor_id,
 				int cu_block)
@@ -1599,7 +1598,8 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
 static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
+				struct amdgpu_cu_info *cu_info,
+				struct amdgpu_gfx_config *gfx_info,
 				int cache_type, unsigned int cu_processor_id,
 				struct kfd_node *knode)
 {
@@ -1610,7 +1610,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 
 	start = ffs(knode->xcc_mask) - 1;
 	end = start + NUM_XCC(knode->xcc_mask);
-	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
+	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
@@ -1646,15 +1646,15 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		k = 0;
 
 		for (xcc = start; xcc < end; xcc++) {
-			for (i = 0; i < cu_info->num_shader_engines; i++) {
-				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+			for (i = 0; i < gfx_info->max_shader_engines; i++) {
+				for (j = 0; j < gfx_info->max_sh_per_se; j++) {
 					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
 					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
 					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
 					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
 					k += 4;
 
-					cu_sibling_map_mask = cu_info->cu_bitmap[xcc][i % 4][j + i / 4];
+					cu_sibling_map_mask = cu_info->bitmap[xcc][i % 4][j + i / 4];
 					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
 				}
 			}
@@ -1679,16 +1679,14 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	unsigned int cu_processor_id;
 	int ret;
 	unsigned int num_cu_shared;
-	struct kfd_cu_info cu_info;
-	struct kfd_cu_info *pcu_info;
+	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
+	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
 	int gpu_processor_id;
 	struct kfd_cache_properties *props_ext;
 	int num_of_entries = 0;
 	int num_of_cache_types = 0;
 	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
 
-	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
-	pcu_info = &cu_info;
 
 	gpu_processor_id = dev->node_props.simd_id_base;
 
@@ -1715,12 +1713,12 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 		cu_processor_id = gpu_processor_id;
 		if (pcache_info[ct].cache_level == 1) {
 			for (xcc = start; xcc < end; xcc++) {
-				for (i = 0; i < pcu_info->num_shader_engines; i++) {
-					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
-						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
+				for (i = 0; i < gfx_info->max_shader_engines; i++) {
+					for (j = 0; j < gfx_info->max_sh_per_se; j++) {
+						for (k = 0; k < gfx_info->max_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
 
-							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
-										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
+							ret = fill_in_l1_pcache(&props_ext, pcache_info,
+										cu_info->bitmap[xcc][i % 4][j + i / 4], ct,
 										cu_processor_id, k);
 
 							if (ret < 0)
@@ -1733,9 +1731,9 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 
 							/* Move to next CU block */
 							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
-								pcu_info->num_cu_per_sh) ?
+								gfx_info->max_cu_per_sh) ?
 								pcache_info[ct].num_cu_shared :
-								(pcu_info->num_cu_per_sh - k);
+								(gfx_info->max_cu_per_sh - k);
 							cu_processor_id += num_cu_shared;
 						}
 					}
@@ -1743,7 +1741,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 			}
 		} else {
 			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
-					pcu_info, ct, cu_processor_id, kdev);
+						   cu_info, gfx_info, ct, cu_processor_id, kdev);
 
 			if (ret < 0)
 				break;
@@ -1922,10 +1920,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 {
 	uint32_t gpu_id;
 	struct kfd_topology_device *dev;
-	struct kfd_cu_info *cu_info;
 	int res = 0;
 	int i;
 	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
+	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
+	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
 
 	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
@@ -1963,12 +1962,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	/* Fill-in additional information that is not available in CRAT but
 	 * needed for the topology
 	 */
-	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
-	if (!cu_info)
-		return -ENOMEM;
-
-	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
-
 	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
 		dev->node_props.name[i] = __tolower(asic_name[i]);
 		if (asic_name[i] == '\0')
@@ -1977,7 +1970,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	dev->node_props.name[i] = '\0';
 
 	dev->node_props.simd_arrays_per_engine =
-		cu_info->num_shader_arrays_per_engine;
+		gfx_info->max_sh_per_se;
 
 	dev->node_props.gfx_target_version =
 				gpu->kfd->device_info.gfx_target_version;
@@ -2058,7 +2051,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	 */
 	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
 		dev->node_props.simd_count =
-			cu_info->simd_per_cu * cu_info->cu_active_number;
+			cu_info->simd_per_cu * cu_info->number;
 		dev->node_props.max_waves_per_simd = 10;
 	}
 
@@ -2085,8 +2078,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 
 	kfd_notify_gpu_change(gpu_id, 1);
 
-	kfree(cu_info);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 3b5a56585c4b..c653a7f4d5e5 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -57,20 +57,6 @@ struct kfd_vm_fault_info {
 	bool		prot_exec;
 };
 
-struct kfd_cu_info {
-	uint32_t num_shader_engines;
-	uint32_t num_shader_arrays_per_engine;
-	uint32_t num_cu_per_sh;
-	uint32_t cu_active_number;
-	uint32_t cu_ao_mask;
-	uint32_t simd_per_cu;
-	uint32_t max_waves_per_simd;
-	uint32_t wave_front_size;
-	uint32_t max_scratch_slots_per_cu;
-	uint32_t lds_size;
-	uint32_t cu_bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
-};
-
 /* For getting GPU local memory information from KGD */
 struct kfd_local_mem_info {
 	uint64_t local_mem_size_private;
-- 
2.39.5




