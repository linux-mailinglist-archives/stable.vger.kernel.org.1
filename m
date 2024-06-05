Return-Path: <stable+bounces-48107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0F8FCC70
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FF1C23B23
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B651B5800;
	Wed,  5 Jun 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApGyFYRE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DBB19A296;
	Wed,  5 Jun 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588550; cv=none; b=YtaABt3age6IMV374r6G+o9Eb4YNY2P4xRmrvP4a8Zn5Pba1u7X0ZnShW/oDLc+/CAKGBJxnDAPowF3x8weyfY+ynRSH2HDjMtFMaKdv62FSnpjpx6+EkaIhX/lSv9rcomF2GHyLJrHHOQpibhFMajFeCCRt4kqxeApAJ7hxLzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588550; c=relaxed/simple;
	bh=r/TxFmQurUNkYZX6dPJDl9HeZ5o1sG+vL2h0tXP5DPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJPNfWWHKlk2NRvm4BdLDx6nHdd/BD607sgliUradPj6lpTPwjBix4bybobiSXr+0jzwC/Rbp9mtzka/SIKWnoSSKt2Rizw+aimGIw1uQuclW+W8luW+jTQrFtRmlNFVntu1DGdT2/EbR6veDOJWYvgsTD+H6b0AHDkgL4D85RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApGyFYRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3471C3277B;
	Wed,  5 Jun 2024 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588550;
	bh=r/TxFmQurUNkYZX6dPJDl9HeZ5o1sG+vL2h0tXP5DPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApGyFYREVTOQ1wBNAogya5DIcSFe+xrF7mCFbs7tNnBqkL8PQjgoIWqANKT2whnaY
	 VQcIyvREU3fyEr8FyXoMGO/RbnTrlKcX1msLEolRHcV6+MEYW2xvfq8KGyiKdQzBZS
	 Q5By3DlhFdwXXK5ExVA2kXkd6Xs14Gk6NW6YcbVH92vlJJjrQYJCCxll/ggs/VRQBr
	 7+AxfLWFoIYv0cyLEo0+rNMRNHTwiJ+XdkJzJT41KWtYxfapkWycUrj5SN+wPGTtdS
	 EefAfZy0aZOpDuiuG8q3Nt52LdAhicoD7rPjmGcajN7YzpIfpKtSMaA79I9eXy1b88
	 gnWrUvLsdv+mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <Lang.Yu@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 3/6] drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
Date: Wed,  5 Jun 2024 07:55:38 -0400
Message-ID: <20240605115545.2964850-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115545.2964850-1-sashal@kernel.org>
References: <20240605115545.2964850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0 ]

Observed on gfx8 ASIC where KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
Two attachments use the same VM, root PD would be locked twice.

[   57.910418] Call Trace:
[   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
[   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
[   57.793923]  ? idr_get_next_ul+0xbe/0x100
[   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
[   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
[   57.794141]  ? process_scheduled_works+0x29c/0x580
[   57.794147]  process_scheduled_works+0x303/0x580
[   57.794157]  ? __pfx_worker_thread+0x10/0x10
[   57.794160]  worker_thread+0x1a2/0x370
[   57.794165]  ? __pfx_worker_thread+0x10/0x10
[   57.794167]  kthread+0x11b/0x150
[   57.794172]  ? __pfx_kthread+0x10/0x10
[   57.794177]  ret_from_fork+0x3d/0x60
[   57.794181]  ? __pfx_kthread+0x10/0x10
[   57.794184]  ret_from_fork_asm+0x1b/0x30

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e4d4e55c08ad5..0535b07987d9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1188,7 +1188,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 	int ret;
 
 	ctx->sync = &mem->sync;
-	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+		      DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ctx->n_vms = 0;
 		list_for_each_entry(entry, &mem->attachments, list) {
-- 
2.43.0


