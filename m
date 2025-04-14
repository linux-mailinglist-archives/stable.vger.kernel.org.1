Return-Path: <stable+bounces-132533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC0A882F8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20E5163B5A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638B2749D2;
	Mon, 14 Apr 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7KqhVAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5B24729B;
	Mon, 14 Apr 2025 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637353; cv=none; b=ebev4LWJPVN9I4kJZ85v9TR1vcU3+It27KAYZ+MelxNNptbw1tsWVX4Xo7QwthE4UeKqQ8qoYSFr5+n7Zj0Pq/P8h5NRkXlyvTVxtfNbJZXdJwySpFX1T0trQlZjJ4Uz2jMhLEdz/kYC0NZjF9t4I+A7q0vLCbqeUSs/Ag8usJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637353; c=relaxed/simple;
	bh=SyQaz1hrVowpl4N8biIi66zbUTT+qktCaXHTzVUoS44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8NZsSs32ON5iwi783YSw/rTwgw86OOnscP2CC59FcDSpYjL/BVGgsu7JLMAqTe0yZYl3b6XynZDObbDfzbGMuQPZK2eSEFjH6Cx2z+21hPxuEQHkhX261Wz/S9XgDVIEH81W5j4RGpQhTZ5T2XpC9zeLkl//DQivw8bxVBi7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7KqhVAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A911C4CEE9;
	Mon, 14 Apr 2025 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637353;
	bh=SyQaz1hrVowpl4N8biIi66zbUTT+qktCaXHTzVUoS44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7KqhVApa9hN7foBty0q90yHaEs5a8jrHP1NcXlFpx90w0SBK3ao7XEV9lLF5cp9c
	 pGZ8q/E3NavT5sXL6e5Bi3hYbofLTPW5IEUY0YthJRl/dhTBFX/O/BuinrleK9TDfA
	 9YBEFrrwWJGjkLZ2BaR+0n6l/4Vka3nrHfHtk5H+Sf3mAYgcmivqmBcr6lOGGJEBbV
	 f4PeriOtWJxQ+B3i0PDoNADkEcnpfzjn6pZRsm9Xf48fclXy7srIaTkxA0i+FS3A2E
	 JwRY8KjUgldzW5GKqMNuVcGLSJjztKd7WQ0x/tAmejxNw8+lJiAE/ingb1L/nnydEN
	 BWcz5cbHQfbyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jay Cornwall <jay.cornwall@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	sunil.khatri@amd.com,
	srinivasan.shanmugam@amd.com,
	Jesse.zhang@amd.com,
	linux@treblig.org,
	zhangzekun11@huawei.com,
	victor.skvortsov@amd.com,
	rajneesh.bhardwaj@amd.com,
	Yunxiang.Li@amd.com,
	Jack.Xiao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 10/30] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Date: Mon, 14 Apr 2025 09:28:27 -0400
Message-Id: <20250414132848.679855-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Jay Cornwall <jay.cornwall@amd.com>

[ Upstream commit 3666ed821832f42baaf25f362680dda603cde732 ]

KIQ invalidate_tlbs request has been seen to marginally exceed the
configured 100 ms timeout on systems under load.

All other KIQ requests in the driver use a 10 second timeout. Use a
similar timeout implementation on the invalidate_tlbs path.

v2: Poll once before msleep
v3: Fix return value

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9b1e0ede05a45..b7aad43d9ad07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -350,7 +350,6 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 17a19d49d30a5..9d130d3af0b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -678,12 +678,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r;
+	int r, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -740,10 +738,21 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+		might_sleep();
+		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+		       !amdgpu_reset_pending(adev->reset_domain)) {
+			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		}
+
+		if (cnt > MAX_KIQ_REG_TRY) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
-		}
+		} else
+			r = 0;
 	}
 
 error_unlock_reset:
-- 
2.39.5


