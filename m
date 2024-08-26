Return-Path: <stable+bounces-70249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF795F5AB
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672681C21DF3
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325C1946B9;
	Mon, 26 Aug 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BejElLD6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497A1946B0
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687742; cv=none; b=eFmerdG2hq9hfwiTTfNZ4o1cGlGDrtviisN2pya+hs3P+4Q27NpN090DBx45Uj83EKncnfcWdgWTS5WJRPvIW3FhzKuB2rSZI31XGmypROSU5HbNp361UTBqOSBVU2uo311tcyzmRWKU8SFPTnB01jAHMu/9qb5vlL2vGQhGALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687742; c=relaxed/simple;
	bh=xzY0SZ+zXQIn5WR8rdZYAXo7Sl6LJIDJuVtV4CeO/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdtJxPvWi9fqho07wQCIZPKYGanOgaJrVX8gR228OfeKxJMt8dy90PsH4YRc7i2p/AQqEFnoKov1iaVJAmDikPkCntNr49z6fZbsKCWTJQgQeyhLuaHZtor0pVgtHE2/s7BMKRUkcoJmlMdHpyn+b3Mo0g355aXgheASsot6/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BejElLD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66636C4AF12;
	Mon, 26 Aug 2024 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687742;
	bh=xzY0SZ+zXQIn5WR8rdZYAXo7Sl6LJIDJuVtV4CeO/ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BejElLD6GGRb6UWIf4V75CWt4Rh5dM1PZPU0PaguNlk6kJu2xzTj0fJJn165nTdqC
	 4b1QA+uvnz8YObZxVZBJt9s9tr0hm+euqudv3JOKJvU6p79ofx/v2Ihf9HRXoGNiZo
	 QTYAIVXG7HWdIs4K5peJrskZ5CiAaPSv1mYX+nLKhsH8nZoKFcEmpLQx5ZJj+/7+F8
	 5pBmYLxZo90j0w4ysRwkyWRG/wc4EMEwwjSCjjOUy0mBJ3o4wifYoNFwqa32j48tPI
	 YF+LBGCP5bQ8DJjO6TRyWppkWztxzhU6XWNwqlnHWxPX1dW1AOZIcRKsipYtjUqawP
	 tUD6t5I8ZE9Dg==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.6 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Date: Mon, 26 Aug 2024 10:55:32 -0500
Message-ID: <20240826155532.2031159-3-superm1@kernel.org>
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

For unified queue, DPG pause for encoding is done inside VCN firmware,
so there is no need to pause dpg based on ring type in kernel.

For VCN3 and below, pausing DPG for encoding in kernel is still needed.

v2: add more comments
v3: update commit message

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7d75ef3736a025db441be652c8cc8e84044a215f)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 199fb3c50de1..111350ef1b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -372,7 +372,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -418,7 +420,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -444,8 +448,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
-- 
2.43.0


