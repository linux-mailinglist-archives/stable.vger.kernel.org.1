Return-Path: <stable+bounces-70245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB595F5A5
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD21C21D69
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4A19340E;
	Mon, 26 Aug 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbUem9KF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98549631
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687726; cv=none; b=jj0EB5bWAhHC6riX5lBglEbSDGqWwX4VNJS/Mh34SOfV0ODfn2cX+1K7YIHgK0DEciyAJqeKfIQsq3rT6s26VI6BWnlhsuiNEXsZ0yKrvcOg2eFk3GgZsD9yIeLPTMgEpVrhjODfWtFuncSsdt+xobiDFXfZfUVvuWHzrKplQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687726; c=relaxed/simple;
	bh=QTVQblzRagtFO4ZBGZfxZ28z3VB6XSrDQGnl5H38dE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRyeoGv/OlWmYb6u5pfC/DFZVlHK3C0odzIFsM1fuYETVDFzd90vCr/rRfWjzDFvNRO4AQjhrO+SNCIjSJ6yOc7pHRwEf7ycwQMUcXi2r4BRir//GEreSgyrTW/PuS9houkXlKeri6xb6egVbnhYtJ1EJ92VkNIrd1yqqAEgxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbUem9KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE111C52FF6;
	Mon, 26 Aug 2024 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687726;
	bh=QTVQblzRagtFO4ZBGZfxZ28z3VB6XSrDQGnl5H38dE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbUem9KFdHTTX7F8EoGQ1WVW4DeufOnxU1fx0w3/njEOsfJP++6BQS2r92KSlg4Ne
	 MkEAim68uwZVOqEybFZ8TR7BJimvB7oB6N+K0IJindx7/Obt8ZOVd7IaMqW0g0Wb3A
	 7zc5X+xX9ClqMjXv6O6Tmmfn+FL6ab1yBoC+wF8RpGlFylMvM4twXO3qyGLxLPWfqZ
	 22X/dCYCKr8wfxd53aC27x7JiHOCSXbXFsZ7kdBXgoLJFb+Dk/7I5gRtyPl93ALc2I
	 GqHXIQAJDJc9DVGAtAxd2/U8IHs4JAbXRgUTC2XbSG60TPJrHtwhhfXjBFay7fY77O
	 BPfFPENYRDOpQ==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 1/2] drm/amdgpu/vcn: identify unified queue in sw init
Date: Mon, 26 Aug 2024 10:55:18 -0500
Message-ID: <20240826155519.2030932-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826155519.2030932-1-superm1@kernel.org>
References: <20240826155519.2030932-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boyuan Zhang <boyuan.zhang@amd.com>

Determine whether VCN using unified queue in sw_init, instead of calling
functions later on.

v2: fix coding style

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ecfa23c8df7ef3ea2a429dfe039341bf792e95b4)
Modified for lack of amdgpu_ip_version() symbol.
Modified for contextual changes in amdgpu_vcn.h.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 48e612023d0c..cb4318974e7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -239,6 +239,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0);
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
@@ -357,18 +361,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-/* from vcn4 and above, only unified queue is used */
-static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool ret = false;
-
-	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0))
-		ret = true;
-
-	return ret;
-}
-
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -806,12 +798,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
@@ -823,7 +814,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (sq) {
+	if (adev->vcn.using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -842,7 +833,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -932,15 +923,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
@@ -953,7 +944,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -975,7 +966,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -998,15 +989,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
@@ -1019,7 +1010,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -1041,7 +1032,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 253ea6b159df..165d841e0aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -271,6 +271,7 @@ struct amdgpu_vcn {
 
 	struct ras_common_if    *ras_if;
 	struct amdgpu_vcn_ras   *ras;
+	bool using_unified_queue;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.43.0


