Return-Path: <stable+bounces-141225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC2AAB195
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16BD1B60727
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A463405019;
	Tue,  6 May 2025 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJeyaZJC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7952D269F;
	Mon,  5 May 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485529; cv=none; b=AuUKInSejGruTA6y8R5Qg/g/JbtLdZNybLP6pDQfv/kop1OGk1YivHb6iB1mOn5j3iBOA6AThG86FA7x/+ORS5N3JLiKzT6lP0NsG+eABXd9tPME3rMS9G1D/mhV72PVV59r63cOAY7VX/02Qo3R2hWV5moabB0Y0q+m+IYx+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485529; c=relaxed/simple;
	bh=HxDtch4IqgpHeb7qWXQwCYhi2AwwzgWpUVKxiGz9wIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PI88U4ZTxg9DEi3sG3e4MVCNE/zFtA/7ItHR8INs2fjUaQcKMz8Hq9kIVwbY+3KqZrBJqIRaTGy4nUK75u+1lMfCwTgg104+pm2484cyNvf4e9F0Ax5ZybfBpkYTee2ZELHumS35m0n/2HcvQYx1JXq/TixH3zlDgoafvWpSYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJeyaZJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E6FC4CEE4;
	Mon,  5 May 2025 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485528;
	bh=HxDtch4IqgpHeb7qWXQwCYhi2AwwzgWpUVKxiGz9wIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJeyaZJCR2rZWjGTzH+q4E46Ew6Gv1o6P8MBW+nNGLiKfjpPmbko+9PxbodqZdW/r
	 neFXX7602ITn5uxGGI27Ivz7ayKir40mI8wdJs2c7pBzgwEvyp5hOBN3yuisGX1/Y3
	 VxBrcXxkb1qWhMxWtSe2vBjMZJBzP+83aRdJpIHUc7hUCu5FqBd3NkimrXjqqkYO7R
	 SeUfm3mSf/IPw9A/t1tK9l9pIEqweam4kPPgUbv6olP7/hSszXIk7CgEWjxYx4YNuq
	 GAsimPNDCeQTnjTiqp0nvh2GcYXA3XJWs+qf7W+ZRykGDAxzJt8tDtV7o5VKyFIbed
	 7n88Qv2X1W53Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Huang <jinhuieric.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 361/486] drm/amdkfd: fix missing L2 cache info in topology
Date: Mon,  5 May 2025 18:37:17 -0400
Message-Id: <20250505223922.2682012-361-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Eric Huang <jinhuieric.huang@amd.com>

[ Upstream commit 5ffd56822a7159917306d99f18fd15dfd7288f20 ]

In some ASICs L2 cache info may miss in kfd topology,
because the first bitmap may be empty, that means
the first cu may be inactive, so to find the first
active cu will solve the issue.

v2: Only find the first active cu in the first xcc

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index bcb5cdc4a9d81..82da568604b6e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1683,17 +1683,32 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				int cache_type, unsigned int cu_processor_id,
 				struct kfd_node *knode)
 {
-	unsigned int cu_sibling_map_mask;
+	unsigned int cu_sibling_map_mask = 0;
 	int first_active_cu;
 	int i, j, k, xcc, start, end;
 	int num_xcc = NUM_XCC(knode->xcc_mask);
 	struct kfd_cache_properties *pcache = NULL;
 	enum amdgpu_memory_partition mode;
 	struct amdgpu_device *adev = knode->adev;
+	bool found = false;
 
 	start = ffs(knode->xcc_mask) - 1;
 	end = start + num_xcc;
-	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
+
+	/* To find the bitmap in the first active cu in the first
+	 * xcc, it is based on the assumption that evrey xcc must
+	 * have at least one active cu.
+	 */
+	for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
+		for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
+			if (cu_info->bitmap[start][i % 4][j % 4]) {
+				cu_sibling_map_mask =
+					cu_info->bitmap[start][i % 4][j % 4];
+				found = true;
+			}
+		}
+	}
+
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
-- 
2.39.5


