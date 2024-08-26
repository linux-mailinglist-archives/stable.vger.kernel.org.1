Return-Path: <stable+bounces-70248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B895F5AA
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61951B21CF0
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4D71946A2;
	Mon, 26 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNHW2fcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854319413E
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687741; cv=none; b=K/WP/UUILDqmZFFmeTvkxegkUkYkj+/optYf42WdtJCQjbyPLL7ltaanWzr1kljYC6fmigc7WzW3R8l+aICSBkfMrizsvpUYQ8IdwC/J6LXelyGvbtJWuN1y6xBhKjmIYD1JQrdsvnMXPQJKlhoBY0kl3xPQedQJMCuYwr3zGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687741; c=relaxed/simple;
	bh=gss/crD6BVbT5sOA9MMEo2luXWETFYQmLmA5fMGU+Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxwqH5UkwwtXmQ623sON67McD/KM8JSZzse1bWL0U3sNkmRyg0GrZVGrjBK6Cvy9QfAFV+RIY4miD5op0yj/EMiwYVB/dll2r/y2kR1HL4tb7Cl1Ji6CPHjbj0EJ6SMFOxv7lDuURe21+p5H6NW0wWHG2xWpWXMf77mOsBNAij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNHW2fcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91238C52FFE;
	Mon, 26 Aug 2024 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687741;
	bh=gss/crD6BVbT5sOA9MMEo2luXWETFYQmLmA5fMGU+Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNHW2fcrU29Gocs08KTiUIzQ5Rbj6hRgsy7AMtj5qDpjraGbHjX2Ar8d7U4ArW9zk
	 LK2ds3TYzodd+42YWM8k5Azb3tVncdjrJYfEoeGC5Ryu0bH6wuXrt+2XJv78/Yi4n4
	 wG/JnhOlZiMMt3aPr7+jzSO3VV5n/Ud18jlZ3PEyjSue9hU4wX/fwkmcnP4USxQHNY
	 ZUwhx8sN28+jLl7nPXShO6lxqpstwxDrVq2GJX5nc0nQyHi6+E8m7V7ZP4YA81/Fma
	 NH/fEOR7+rpNnsU+1nOqI612CjF16KC7CSsYWEWFKxQlDuDA8ABxajrtpuO03m1k46
	 C/ONwyt1EL+kg==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.6 1/2] drm/amdgpu/vcn: identify unified queue in sw init
Date: Mon, 26 Aug 2024 10:55:31 -0500
Message-ID: <20240826155532.2031159-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826155532.2031159-1-superm1@kernel.org>
References: <20240826155532.2031159-1-superm1@kernel.org>
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 03b4bcfca196..199fb3c50de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -135,6 +135,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0);
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
@@ -259,18 +263,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
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
@@ -707,12 +699,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
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
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -725,7 +716,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (sq) {
+	if (adev->vcn.using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -744,7 +735,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -834,15 +825,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
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
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -856,7 +847,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -878,7 +869,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -901,15 +892,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
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
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -923,7 +914,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -945,7 +936,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a3eed90b6af0..3dc2cffdae4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -284,6 +284,7 @@ struct amdgpu_vcn {
 
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
+	bool using_unified_queue;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.43.0


