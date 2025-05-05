Return-Path: <stable+bounces-140207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15542AAA644
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42025A7C09
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433931FA84;
	Mon,  5 May 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnBnADpu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7331FA7B;
	Mon,  5 May 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484340; cv=none; b=AY3kIxs5PwCPOxoDCaBIF3og0RVak6WPjpJTBKhBia/pf76T8qezXwKeqDO5ZHMX+Op7kze3MpauvYaKekq7aZmKWwMbHEYyq2r5Vuz4wnsPsait23z594DiIBm6IkFwKav5Axc+UCMb7omDqM8Wl+8dosBV2h/9Wp7zNZyVyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484340; c=relaxed/simple;
	bh=IalM9L5efkNTEa16hmoVEVF62GEGUp+xR1nAhVa6dc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRrOcBDkOsGODfiLXWxpTUyy7IPfCdpQEw+On4UA69DglgXDUAA//mnfu+otMpeKLfKMoZfD9wbMyyeF3T1w46tazPnNnSB/DYRmAja3IRgMASihwP9h34az4YIpAKBm1jsfAiZMY9R5amOPUlX03bDSRovgiTBB10fO3Kjj/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnBnADpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AA3C4CEE4;
	Mon,  5 May 2025 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484340;
	bh=IalM9L5efkNTEa16hmoVEVF62GEGUp+xR1nAhVa6dc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnBnADpuO3Jq5JFeDBw0Mf4K6mZ8fBqZjI0pfHMYA+KtrEtObLl0xe2wht2IY+M4X
	 YIOjCjbYQYH8UJhsKPw5I7b5fOMEhUYOPv5mpmOf63CiMAx067a/mUMdNi04HoXgdR
	 6e+XbvQ1SrQgyXhPAV3Qw1LeKB9kKetEd8unUs68sJqSurrDV7EuUYbGukxoIP5HuF
	 LLhBr8s0dfz/yb3BuCtBadSAX8FvPHvTxiu5C8NQkIlLpDsFoJoIbHwsE9zp3epPFF
	 enqrYz+ySwZfuR+tMZcUq/JoLrqqF4fROdnBFpuaA/me3jY3T/OSKHFq5cONdJdXD8
	 xFNPxhF9N+jqw==
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
Subject: [PATCH AUTOSEL 6.14 459/642] drm/amdkfd: fix missing L2 cache info in topology
Date: Mon,  5 May 2025 18:11:15 -0400
Message-Id: <20250505221419.2672473-459-sashal@kernel.org>
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
index 334c576a75b14..98317eda2cdb4 100644
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


