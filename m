Return-Path: <stable+bounces-43261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE78BF0F9
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA91B235BC
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F986AEE;
	Tue,  7 May 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrXgzrnq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0D86AE5;
	Tue,  7 May 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122859; cv=none; b=VefSMZQVSXE0adZEXySY5PTxe6xFtsorF0OxH2Z1yRvDXfCWVzXNVbabA+e5s8rs6aEoHrVyf/ghZ1PjntaU5LXXvO2fom4x6+tJgQoekPqZcXxxnlzKyTlD0ZJC8bVqH+QOC69J1skBiw0cWbLsXAAGyUCi5UJBJr9tL+PZFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122859; c=relaxed/simple;
	bh=i4Y3wTxzSJiKkzVH/krYzuXwNU7BG2Sq70romIzv9Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojUzbjvITuxnl40lERYRmGPqzEBweFHYeydm58I43+0UWUtKzC3us/xQEOpF4AY5GMmp/Rk01rX9VcdO/s7howNK5ZD3JKCCnrfgZsnyDKcptD5QyhR6dY2dlV/jrZYIywTJzubKAI+ZKUWfz0XHuWjr7WK/5MUcNYcL+5vjzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrXgzrnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB37C2BBFC;
	Tue,  7 May 2024 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122859;
	bh=i4Y3wTxzSJiKkzVH/krYzuXwNU7BG2Sq70romIzv9Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrXgzrnq/VKRnda5f43xAbPnAoahp0MxHl1+MTkq6luaFUFfLRdQQ+uKix2vsrho7
	 rga3wDUajOGrbY5orxv0vBJhuK6qsgvuXZof4E/VIxWnE6Lq9rQGr1g9jEuIfnu2Rq
	 9vvLUnB+v6lGF8v2+3N2oPRc3H3oZXudeO3Vs9NngnpGeEkxoe3N/FSsAMbCjqYs5L
	 wIZSk5KRpyh5HUNZc8cLesSY3f0mMT51LzC8ioXYks7HXD89IFkRzanGbdXLW+H3I+
	 CD8bYRsmNPGQTwLB4/5lsLhCmd8EGX/UU7VyhYefviczFbERGXhtcjusa7jp1iEkFb
	 WgBk/XmUkAzug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	Felix.Kuehling@amd.com,
	Jun.Ma2@amd.com,
	srinivasan.shanmugam@amd.com,
	bas@basnieuwenhuizen.nl,
	sukrut.bellary@linux.com,
	lijo.lazar@amd.com,
	jonathan.kim@amd.com,
	Lang.Yu@amd.com,
	yifan1.zhang@amd.com,
	zhenguo.yin@amd.com,
	Tim.Huang@amd.com,
	Jack.Xiao@amd.com,
	aaron.liu@amd.com,
	Hongkun.Zhang@amd.com,
	Jiadong.Zhu@amd.com,
	mdaenzer@redhat.com,
	guchun.chen@amd.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 08/12] drm/amdgpu: Fix the ring buffer size for queue VM flush
Date: Tue,  7 May 2024 19:00:10 -0400
Message-ID: <20240507230031.391436-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Prike Liang <Prike.Liang@amd.com>

[ Upstream commit fe93b0927bc58cb1d64230f45744e527d9d8482c ]

Here are the corrections needed for the queue ring buffer size
calculation for the following cases:
- Remove the KIQ VM flush ring usage.
- Add the invalidate TLBs packet for gfx10 and gfx11 queue.
- There's no VM flush and PFP sync, so remove the gfx9 real
  ring and compute ring buffer usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 84a36b50ddd87..f8382b227ad46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9352,7 +9352,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
@@ -9445,7 +9445,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 		7 + /* gfx_v10_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5a5787bfbce7f..1f9f7fdd4b8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6157,7 +6157,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		5 + /* COND_EXEC */
@@ -6243,7 +6243,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 		7 + /* gfx_v11_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v11_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 195b298923543..6a1fe21685149 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6742,7 +6742,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
 		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
@@ -6781,7 +6780,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_fence = gfx_v9_0_ring_emit_fence_kiq,
-- 
2.43.0


