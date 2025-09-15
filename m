Return-Path: <stable+bounces-179595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FAB56E3E
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 04:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB5F189BA67
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 02:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24B1DC988;
	Mon, 15 Sep 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V24DX/1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5352DC790
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902777; cv=none; b=HufX8ayqePAbfTEkuQRqU+USbFJ84WM9+kVfc2ZSFDaPvK8Reki6VWSrPeYDHJkurVureck6od+MkrIO5E8wZqy2PlMNrLdSbD8MsJAdPxf+ZfrqlYdUHEkrVJVBo7eGx72lJKBofl0CbZdPEvSh2+smpoEaHesS4+qKqFbzSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902777; c=relaxed/simple;
	bh=Qc7QnJhLTaFW0vGd+tzEUeayV1al5EEzjxrLVuQ0t6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2q5jyMQjTwGKJYIgQ23k9A1EXZPxgAab8ek32E00pz9AOuTaRvEFzAoH6QdZ+umvHsvM5WJGJZ2MU9UxE/D1OIaciabOQ+uxFqb1wPiIwFMqrFH8p4RuB13U/Nb944EdhDsAxxsTLaRuMd8APbhlWyB2RscKqLtWNRuyQls0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V24DX/1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184ECC4CEF0;
	Mon, 15 Sep 2025 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757902776;
	bh=Qc7QnJhLTaFW0vGd+tzEUeayV1al5EEzjxrLVuQ0t6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V24DX/1Jhbf5lwUYWstI5jtuSBvPNgXiJ4nsvDOHKFincEiJ6hajvI0JziKd/ry31
	 fKttkPhIPnfQ/3NKmjjZR2fj5rJtKUMoXGSF24Vh3GJ2d5JM3iBGX49PxGY3Iu0bUH
	 joO+3Fp2Kq1DF8+msnl1OR6SHXV/AAIPJlur63TGqda5mJAQc12k5UzNP9VWs22J9N
	 /XSf7kjM7ULYbJnzOXXGg1eTkgzwn0Mx1Hfm8XGCXLTwKXAP/W6iDLNxm08zyQhVnc
	 1GZDJDUU7H1rOh41ZqZwyIwoPvX1PSWTdSD5EGRVZ5o2hR2ZfiuH+muZmLnExbpgtV
	 Igv//JbGpt76g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	"Lin.Cao" <lincao12@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: fix a memory leak in fence cleanup when unloading
Date: Sun, 14 Sep 2025 22:19:33 -0400
Message-ID: <20250915021933.371266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091359-thank-chest-a9e0@gregkh>
References: <2025091359-thank-chest-a9e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 7838fb5f119191403560eca2e23613380c0e425e ]

Commit b61badd20b44 ("drm/amdgpu: fix usage slab after free")
reordered when amdgpu_fence_driver_sw_fini() was called after
that patch, amdgpu_fence_driver_sw_fini() effectively became
a no-op as the sched entities we never freed because the
ring pointers were already set to NULL.  Remove the NULL
setting.

Reported-by: Lin.Cao <lincao12@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: b61badd20b44 ("drm/amdgpu: fix usage slab after free")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a525fa37aac36c4591cc8b07ae8957862415fbd5)
Cc: stable@vger.kernel.org
[ Adapt to conditional check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index f44b303ae287a..eebac2e1a6c75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -396,9 +396,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	if (!ring->is_mes_queue)
-		ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.51.0


