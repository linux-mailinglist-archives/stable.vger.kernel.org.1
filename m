Return-Path: <stable+bounces-140001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01432AAA401
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBDE7B5841
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA762F54C9;
	Mon,  5 May 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dArHgBS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1761D2F54BB;
	Mon,  5 May 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483878; cv=none; b=IJw5ckd/8PbyduqY/MdI43txGz/RY0mv0IGssRqTD14dCEOoJzjsmiUhd2FGlzAFfUBht3+YcFhMYptVP6Ynptf2gUD5vlRSx2ihv4dpF10tj2O5tFopKD/sXh4gNhwzC9+lnjZzb/9IGcGX+YX6MeEgiT1mZOD6K3qcHTLd91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483878; c=relaxed/simple;
	bh=SWyscu+yuF6KYdS2OxLwWlv1eNxyNyI81bj5r+fMogc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xe6YuG9cmfzxvminjLxHcpDta5o9AzcMumRyysJEs/O90SgSoM6z5LF4pqoln8tWBq8wNeUbCQnhYpcnK8AkNfm8e3RfZLx2lRd3BLZqmB94UnyWn6ANRg96cpGjDLCq46I7mdcziRLBaEm2dM5c3jckZQqo6+iQzi75JdFZRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dArHgBS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC91C4CEEE;
	Mon,  5 May 2025 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483877;
	bh=SWyscu+yuF6KYdS2OxLwWlv1eNxyNyI81bj5r+fMogc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dArHgBS6a6klLuOVPzzmqtZAFi9T0BAhpnFRWoIEZHQFf34ICxScdBnOSZU1rKK0v
	 e5e+zS7KZg9C4BO1FPaE606ewMtTPQlKksKPDrHbnq52EJ6cbtnpuBRw2FQg5tYfBE
	 JYb0+PRj27N9+/eITWIfl4TRdiTe/GqahFcNPzhwMdgSomY9NJBI9+YU7A2LM5+rmC
	 OQcbflISQKzBmH1uSRd6v99XL7/wanwvWz+niXifu/PE3DOAVr0VOjKHByQIz/HdZ2
	 rhIFYCGFE5I4zkcQUr52Bhm3xZbwNN1s9IvBDaIa/jHnMpFro0LBWW+HmNkT5yvoXv
	 bVEadlQNg6uWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	leo.liu@amd.com,
	sathishkumar.sundararaju@amd.com,
	David.Wu3@amd.com,
	kevinyang.wang@amd.com,
	Jane.Jian@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 254/642] drm/amdgpu: Avoid HDP flush on JPEG v5.0.1
Date: Mon,  5 May 2025 18:07:50 -0400
Message-Id: <20250505221419.2672473-254-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit a734a717dcfe1ce618301775034e598cb456665b ]

Similar to JPEG v4.0.3, HDP flush shouldn't be performed by JPEG engine.
Keep it empty.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 88f9771c16869..b2904ee494e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -637,7 +637,7 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
 }
 
-static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	/* JPEG engine access for HDP flush doesn't work when RRMT is enabled.
 	 * This is a workaround to avoid any HDP flush through JPEG ring.
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
index 747a3e5f68564..a90bf370a0025 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
@@ -56,6 +56,7 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
 				unsigned int flags);
 void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					unsigned int vmid, uint64_t pd_addr);
+void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 void jpeg_v4_0_3_dec_ring_insert_start(struct amdgpu_ring *ring);
 void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 40d4c32a8c2a6..f2cc11b3fd68b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -655,6 +655,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
 	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
 	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
 	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
-- 
2.39.5


