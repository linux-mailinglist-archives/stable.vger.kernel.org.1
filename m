Return-Path: <stable+bounces-128090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2481A7AF18
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A733BA5BB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2622E3E1;
	Thu,  3 Apr 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h81aqZJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943C22E015;
	Thu,  3 Apr 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707946; cv=none; b=HGl0rGLWsKFa9nKvdBu2tWNM9m1Ybl5gpmNyGXlJwo2pf49Sdt50J+es+8kyhfTqPvNt5y8aZ/2fzEkYNhEjyWakH8Tcpip6/f/4u/DkpU/7x4K7nbHBtjeldkFcHPJCIGibEsri5YhJ0hLCJ4+WvJsS8gAn2jbT3IMqtkcL8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707946; c=relaxed/simple;
	bh=WtQCDIJ6Tq2nEPcKD4YwAixawxYOVAK0REBIMmclyM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDbjOpZERG1tSLvQKgH1xepL7VfQrZbGj20ij7+ANWU+ww3fIp04NfE4kLgFhkoPbxRdYCi/TWfZRoD30zI0Q6438hIc7klkHJmeo1ALN0JBNrNSAaPoz2cUrLkH6RQ3eR6tFGxBv2TCJYTQQl1YKs+YqSr7UDAte3FLjdISDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h81aqZJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B35C4CEE3;
	Thu,  3 Apr 2025 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707945;
	bh=WtQCDIJ6Tq2nEPcKD4YwAixawxYOVAK0REBIMmclyM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h81aqZJyatrk3JgibfkcPIClziIlX643hFXyg+KhLXTU+ODyO/KuUOn1/98G5TpGc
	 BOgu3jSuuNESb3ufJ74U7eNGEt3RHv6WsdfOJixB2aFQyaPIIKPnzpjKaNy5K2dcv2
	 +kAHByjcDNZnEI56nofXuJRcaqgkwRKbXTB8Gz1Hxsv4Qpc+GOi0bGBz0YpzQoLIbz
	 I5rWV9gt3IiUjZp/G15nPr4T3Z1dVvqwJ1/tYLVSYf4VCztwMMVPTpSYdLZ61EfjNl
	 RG0mAONEWw5sl8aKgoSOVtL5wmJAJz+nWCOAoSGgiSrR5pIOohnyBMgeQVuYpRwYpi
	 8HLkuYSku6Epw==
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
Subject: [PATCH AUTOSEL 6.6 19/23] drm/amdgpu: grab an additional reference on the gang fence v2
Date: Thu,  3 Apr 2025 15:18:12 -0400
Message-Id: <20250403191816.2681439-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 45dd6cbad81e7..10f5a3d0f5916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6015,6 +6015,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		rcu_read_lock();
@@ -6024,12 +6025,19 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
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


