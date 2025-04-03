Return-Path: <stable+bounces-128033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EAFA7AE8F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593A817EC15
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E0207DE2;
	Thu,  3 Apr 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMNq1nYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F09207DF6;
	Thu,  3 Apr 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707806; cv=none; b=cxObXF/yoJhxuSjKPAK3/4ucE2ytDQPh3FN4m617seABXtghg9etIkpjWXPxj52zsK2c2SBjgQcIsA6LPbcZVhJ+dYGj3qDmUwgnr63I3Zvo4o/6tWkkC6wnS8xzCFyhxpWkYE/bwWbnV6KnpqxGYLnwRVFpTScBKzeZEIptpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707806; c=relaxed/simple;
	bh=mCS4l3tbN+LrbAUrpldLHlyevu2R5b92XL6t5aRvlmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ull8NvCNHCqmlRnhFmk7H4vte/ri44nqQm4jaBPuxLcpDze9R7lV3rVTQigcShwZsq70k/J29dk390OqOS4GHioq5iSKkfdyHHWBAHZcmtAMybFAZNw0v3jD06nHyQVMr9Zd2pEIvJWiOV7SZ6D/3zMJ+fxJTlNJu+pKFxdoQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMNq1nYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE0BC4CEE3;
	Thu,  3 Apr 2025 19:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707806;
	bh=mCS4l3tbN+LrbAUrpldLHlyevu2R5b92XL6t5aRvlmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMNq1nYh5N8pXawxsy8Y6tC4F/wU0Nmg2FSPpXJewVF7nFuTbtPWdj2i4Na2Edns1
	 HKaR4h5gej75CTIBAi112CK1JvvBahxlX7mChSg3jfXQYMle45fEBKDxnMWG7I6rIU
	 5SldhCGXHbTDpV3zXAN0OgFxVWy5oac0TWsWOLWeqMxeDiCDYrAsC6hwFxbBB5+Sp1
	 wEH3Imkj4pXKDTVAI65XpxQIzNZOMDj/+tS7y4u5D3bgvR2yxUkRqEWkiDiU42pb7o
	 A7Bw1MbHVH4EUPxaaQYAFIoDjs1Y7DU3LLbyGXPFfxlEsNbF75VpAVaDxaLyWQgFWZ
	 jve8i+Wf02lvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	lijo.lazar@amd.com,
	sunil.khatri@amd.com,
	Hawking.Zhang@amd.com,
	Jun.Ma2@amd.com,
	Yunxiang.Li@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 32/37] drm/amdgpu: grab an additional reference on the gang fence v2
Date: Thu,  3 Apr 2025 15:15:08 -0400
Message-Id: <20250403191513.2680235-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 0d9a95099dcb05b5f4719c830d15bf4fdcad0dc2 ]

We keep the gang submission fence around in adev, make sure that it
stays alive.

v2: fix memory leak on retry

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3780d50fd3ae8..61b3f676a5df0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6707,18 +6707,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
 		if (old == gang)
 			break;
 
-		if (!dma_fence_is_signaled(old))
+		if (!dma_fence_is_signaled(old)) {
+			dma_fence_put(gang);
 			return old;
+		}
 
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	/*
+	 * Drop it once for the exchanged reference in adev and once for the
+	 * thread local reference acquired in amdgpu_device_get_gang().
+	 */
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.39.5


