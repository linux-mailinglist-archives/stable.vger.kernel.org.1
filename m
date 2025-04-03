Return-Path: <stable+bounces-128066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B929A7AEDE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F21189BBFA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0122578D;
	Thu,  3 Apr 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0lQ4iPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248C225776;
	Thu,  3 Apr 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707887; cv=none; b=eE5ppcL+kTOXvGE8evB/A3NDkPjY1OTXajdbWzGfqR0t2qGS1vrvfdZNjWrEftdZ+VQDNYLwg/oz2seNiql4+R3s+eD/bXGlDUI7AcrmPoNGZpy/4/bIXmfoZ7ddZfFE6Nk7LE52rXgYmm/unn9jf1ZPe1SGnmWNS4AXd6214hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707887; c=relaxed/simple;
	bh=V1qxuGy8Y+Lg5Bwu/IvIatMzbJSrmut+cqT/owMEmmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd+S/X1L1GkOEFObkqeTm7bU2c1Qnt4ZjY6wV4s+WdMFMBtR616xHYFqzTnuIastvQRWbblYy65C88vqMVDQX231ewfmp3Er7dwTcVLI+ZPE3ix/tpVcMeEmC8oBeoAYcxE7GjRAHGlwpak9MyGbTThqWvYcAgHmyU3HxwrAaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0lQ4iPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85447C4CEE3;
	Thu,  3 Apr 2025 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707887;
	bh=V1qxuGy8Y+Lg5Bwu/IvIatMzbJSrmut+cqT/owMEmmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0lQ4iPD9uSjAG4znbwWBM4jheKfHgc60GKkXy6CmT3ePS7Q6/M9fgb3lmoVhmz9q
	 IdIfGbBAsRI7hZwSayaLTaGb/xRi53j7IJPKDm4P147J1Dv6akQT5ggXgEIOXgiaip
	 zcOj4PeDtZE/ugkesaclor8xJSn/8hrRaeMcXGr4Bhy4EJo/DrRfA8XzCinuJMvp0x
	 YPVLvLjQH/qjTGQaUxjjQVswLZprqMbIDqWsYO2OmJ96KZ0feIMchSlbdk5cuEZK+D
	 6nl6q1surz0toaBAT+04albKIN1EyAhYVm0qfPnF2OuMTi8FOj5YYvm+AOmTyzBonD
	 3eK5mtySrPWnA==
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
Subject: [PATCH AUTOSEL 6.12 28/33] drm/amdgpu: grab an additional reference on the gang fence v2
Date: Thu,  3 Apr 2025 15:16:51 -0400
Message-Id: <20250403191656.2680995-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 96845541b2d25..31d4df9688981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6575,18 +6575,26 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
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


