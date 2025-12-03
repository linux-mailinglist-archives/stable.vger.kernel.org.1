Return-Path: <stable+bounces-199297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1717CA110D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 898A63014B74
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170CF332902;
	Wed,  3 Dec 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XILq2rQA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54909331204;
	Wed,  3 Dec 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779329; cv=none; b=Ls17EjfgkF6QqbQYKcETy2NrLVpBZixqjtVk7sRmnOIxB8rPWJ+TbkN5/Zfk4L9Usop4d1X54AqraxM7dS/vXn3X/63OBNBorv+zBisDFooiwwkS+Q4PKwLpVZQMt5pROMlMmAbnCoRjJWs7/D8XE7dzRXNa0ZTBf+8VtB8Gfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779329; c=relaxed/simple;
	bh=m0AEI3SYjWcpjL9aY1myhD6mHZ6bt2AtGd9Y7TZPwIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwYKSZIMog6ONoGgVXZzMAA+btQuP47FN6OGutardgCC0ggmpU/RygG6ABuhfeqvJbPLwBy+I/r+F9cJUmofhjN5EuVxOHqbPxt+SYDRcHxJOKhAFKs9cNcgL5J+mJoDOw1qyjuUB/IGBABzhFAiExXG/ZPL51TVllRwd/pjzlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XILq2rQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6693C4CEF5;
	Wed,  3 Dec 2025 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779329;
	bh=m0AEI3SYjWcpjL9aY1myhD6mHZ6bt2AtGd9Y7TZPwIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XILq2rQANeKxSDBsHgekjmj7AzHEfMmIL9cz/R+kxuwq+ne0juC/JfINlIUDSWm1p
	 PvoC74/IbvIgZDR6mxL1dHcEUDdb7iIIyAfRJ5+IpguQhAupryL4KzMreJDfClFxaC
	 loFP0K+Gmum1rAn5aKDZmrXb3JuVf3UMZRmIWxBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 226/568] drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl
Date: Wed,  3 Dec 2025 16:23:48 +0100
Message-ID: <20251203152449.000074488@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit dea75df7afe14d6217576dbc28cc3ec1d1f712fb ]

Replace kmalloc_array() + copy_from_user() with memdup_array_user().

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 25cccd080d977..e0cd6a08ffb27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1695,30 +1695,21 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	union drm_amdgpu_wait_fences *wait = data;
-	uint32_t fence_count = wait->in.fence_count;
-	struct drm_amdgpu_fence *fences_user;
 	struct drm_amdgpu_fence *fences;
 	int r;
 
 	/* Get the fences from userspace */
-	fences = kmalloc_array(fence_count, sizeof(struct drm_amdgpu_fence),
-			GFP_KERNEL);
-	if (fences == NULL)
-		return -ENOMEM;
-
-	fences_user = u64_to_user_ptr(wait->in.fences);
-	if (copy_from_user(fences, fences_user,
-		sizeof(struct drm_amdgpu_fence) * fence_count)) {
-		r = -EFAULT;
-		goto err_free_fences;
-	}
+	fences = memdup_array_user(u64_to_user_ptr(wait->in.fences),
+				   wait->in.fence_count,
+				   sizeof(struct drm_amdgpu_fence));
+	if (IS_ERR(fences))
+		return PTR_ERR(fences);
 
 	if (wait->in.wait_all)
 		r = amdgpu_cs_wait_all_fences(adev, filp, wait, fences);
 	else
 		r = amdgpu_cs_wait_any_fence(adev, filp, wait, fences);
 
-err_free_fences:
 	kfree(fences);
 
 	return r;
-- 
2.51.0




