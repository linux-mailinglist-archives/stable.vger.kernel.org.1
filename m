Return-Path: <stable+bounces-128111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAEA7AF5C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D03B6495
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F4255248;
	Thu,  3 Apr 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jckuWxxJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507E255241;
	Thu,  3 Apr 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707995; cv=none; b=m3bN8vb0+a6R3wC+JJNdp/0n9RsrtbfMEN26iNBg+Iu6WYiHvmC+sOAi73jTSs/38aUQYri+sUMndzShfvtEuoOllSmEfFzpOJLzLry9jZX9wsiLihbnB1Tieddk+iICvAf98XnmzPhNc/V7H+iB4X7kH+A1vHuGiGyZA3HPptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707995; c=relaxed/simple;
	bh=3Z6fy5hxSvMdFpWWJUca2tlJiW70Z0YISP1h6W4KPgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKP+eH/ScEfATgUPADk5sKU3gx5LMFjWrBYOSUKelmw7fnJlTfz57b1Flt/s6U1SUrwcnKFbBWcGYLZiBQB6C4nnD4TPNkHLY8wBHqnNfRrS3GOT+/wD+M562CszqzmiDKRh17GmIwrlrCCKLci/2KgpaXguopCm11T/CSn8wP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jckuWxxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9ACC4CEE8;
	Thu,  3 Apr 2025 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707995;
	bh=3Z6fy5hxSvMdFpWWJUca2tlJiW70Z0YISP1h6W4KPgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jckuWxxJwREwAUoehhuKZleQhx96ZnuJMUd0JbmsPpTZNwCO6B4a7oWrqojDacA7P
	 PqTMr0gwQmG6fAJBdChPwJREzcndnI5iYE+6Ol0vjgcjPp83IqBDVFCPqMD92sQgbR
	 rkgLMCa5qvvaPKEM44DDsb+qlPBIYdSH2FJ8ZH08sEuiVL7fQM9zvdOFV5+eu8sW5I
	 lguvy4xgtPGD3GXOg77oeM2WWxH25ICR8nVMnByKi6aqBMsPuMrkNpn6dsWUu7J3N8
	 py4OzviDiQTa/LVeFqAgYNS4OWjgXQkGLcpLy9gHadrGjzqFEl/U6kImKFWyOb3crW
	 GBEBIWPJtAEpQ==
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
Subject: [PATCH AUTOSEL 6.1 17/20] drm/amdgpu: grab an additional reference on the gang fence v2
Date: Thu,  3 Apr 2025 15:19:10 -0400
Message-Id: <20250403191913.2681831-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index b41a97185823a..fcd0c61499f89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6186,6 +6186,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		rcu_read_lock();
@@ -6195,12 +6196,19 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
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


