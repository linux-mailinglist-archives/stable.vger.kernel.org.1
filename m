Return-Path: <stable+bounces-43243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2608BF083
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5121628235D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD65132C36;
	Tue,  7 May 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy17fPBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F684FBA;
	Tue,  7 May 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122777; cv=none; b=HtTPrXn4RsrfM3rq5TPyPzuOjzebkkcO5KJ5XIHZXozsHr0a9OE0q+BtstU7cdtc6Nd2IaElDPV6jdgnPlIwrj5sKhzI2Ac6bK0xgC+lC2obnPB3SC9+v1jEh+Ea5yFoQRxerv6Y4Bm0i05sfQ7leIxlVZDla1yNWeq+1w6oqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122777; c=relaxed/simple;
	bh=GSgso4j/tOihTdR418XhJIdPJ7U4CCqfjdUxioDLNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vql16cq2Rk07EftKeplYztbu3AqTzcKNzVdJzRCWba4WQf+AbWZTPbG/o7YNZFUsjVRGt/hYiP4pPH5FivKoEnqk0NoAbHhCgMwh5FYbtvznwXpYtYgqb2+mt+ic30EBV4yeioIkW3vKnbFmlDNkureXDeoIfCHOE/6mS81ZL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy17fPBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F050C4AF17;
	Tue,  7 May 2024 22:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122776;
	bh=GSgso4j/tOihTdR418XhJIdPJ7U4CCqfjdUxioDLNMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sy17fPBF7gghmrOvMA3wja5uqkMQb5baaog288RhoNE9jTuINenNy/ubFe09aXZmt
	 +H7gt+XrbvKBpRUOeSgOD9OQbeYoho+kBqT8l7B0s4X2zF4398Ho91V0UoRsKCS4gB
	 sqvuB3sXbIRySE+alclCyxCnYYIjjDP4hLnd3a3oImx61jzc7AKK+Xsdw5cswmXrWk
	 p1/tIjzPeV322zsJLNPGp12fDMtb1timHgXZaQGMnnVNo0V/8y7+UFOyYBG+BOBSn2
	 ZfoV1vCa1o7BrGGBUKtFYmeZb6l8Ct4LTpzD5p1iPqJdm5rvin720HW77eMvqE+Vrj
	 fttmz2CeYCxEw==
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
Subject: [PATCH AUTOSEL 6.6 10/19] drm/amdkfd: Add VRAM accounting for SVM migration
Date: Tue,  7 May 2024 18:58:32 -0400
Message-ID: <20240507225910.390914-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 659313648b200..3263b5fa182d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -516,10 +516,19 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	start = prange->start << PAGE_SHIFT;
 	end = (prange->last + 1) << PAGE_SHIFT;
 
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
 	ttm_res_offset = prange->offset << PAGE_SHIFT;
 
@@ -549,6 +558,11 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
index 87e9ca65e58e0..ce76d45549984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3416,7 +3416,7 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
 	*migrated = !r;
 
-	return r;
+	return 0;
 }
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
-- 
2.43.0


