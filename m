Return-Path: <stable+bounces-43222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15738BF036
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410791F2371B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4486628;
	Tue,  7 May 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJi+IDoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48686274;
	Tue,  7 May 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122676; cv=none; b=cYPAmJ4V8DqlyqG8iXvEocknHzf7XvfNyatkUXtEAMgda1c+qEMGCEhWB83RF+jMN5ukgpHWefQfsMremxJPJmnUfyC/+mSNHBNERe5HWmf45ZNaEIsXaqBRvyOq0NP4ZMgcd7cWok2aVdXpwpXJZADs6v/Hv0B6+SkbKl79Kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122676; c=relaxed/simple;
	bh=45Ctv6QKcT69IleXOGmx/lkPXJ7GAVZJKpVT221zneY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJe1jNv1exv/eF1kFNgmc7RtcAim29c5ptitXe4+sJI7pJoLAsE7rBposU6Pj4nRYzzWpTHCGaIYCSJI/1rnDAJ0ZFJ8w4x05AwTlrraUF8W0SR3Ube0xBTU/Ugzy5X2GcKBruNXQFwGJtrHEd/a1SZAkAcwG3/BSK1aXZAe050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJi+IDoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10017C2BBFC;
	Tue,  7 May 2024 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122676;
	bh=45Ctv6QKcT69IleXOGmx/lkPXJ7GAVZJKpVT221zneY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJi+IDoPvzymqz6B8nXnSWPtU5Bskg8mxETGeQSBVlxWihdZx2eG5ZPl0oG0N6uHw
	 LshG6mQjZ+txRUefyrFdJ5Q3Hrv4fWYcy1YcPZPv9IU7Y2meqRmT7lz479/vKiBzzr
	 IrWE70Q27tmp4xeZJwz1Hz0X7gNy6mGM+ZlRst5b2/1n2sLHh2YJnlvTgx/KqW8CuJ
	 2pEiHoEOvpmuQN8ZQLF6KQRnZXKY0JvZGYR1emCd38z5+4I5W+IDShze9iB7aGaF32
	 L2Bb649/jLSL42ejAID2mWvQ0fXwDhkw0byPOS6t+Deb9AidsPJo2w+mBpqzrY6wHk
	 9XXzZpiq0CcZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
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
Subject: [PATCH AUTOSEL 6.8 12/23] drm/amdkfd: Add VRAM accounting for SVM migration
Date: Tue,  7 May 2024 18:56:38 -0400
Message-ID: <20240507225725.390306-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 1e214f7faaf5d842754cd5cfcd76308bfedab3b5 ]

Do VRAM accounting when doing migrations to vram to make sure
there is enough available VRAM and migrating to VRAM doesn't evict
other possible non-unified memory BOs. If migrating to VRAM fails,
driver can fall back to using system memory seamlessly.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index bdc01ca9609a7..5c8d81bfce7ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -509,10 +509,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = start_mgr << PAGE_SHIFT;
 	end = (last_mgr + 1) << PAGE_SHIFT;
 
+	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
+	if (r) {
+		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
+		return -ENOSPC;
+	}
+
 	r = svm_range_vram_node_new(node, prange, true);
 	if (r) {
 		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
-		return r;
+		goto out;
 	}
 	ttm_res_offset = (start_mgr - prange->start + prange->offset) << PAGE_SHIFT;
 
@@ -545,6 +554,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 		svm_range_vram_node_free(prange);
 	}
 
+out:
+	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
+					prange->npages * PAGE_SIZE,
+					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
+					node->xcp ? node->xcp->id : 0);
 	return r < 0 ? r : 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c50a0dc9c9c07..33205078202b5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3424,7 +3424,7 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
-	return r;
+	return 0;
 }
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
-- 
2.43.0


