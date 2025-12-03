Return-Path: <stable+bounces-198829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6CDCA13DB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FAFA3016EF2
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CA34DCCD;
	Wed,  3 Dec 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kW6P6LHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB834DB7B;
	Wed,  3 Dec 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777811; cv=none; b=YWz30zy3EXasXv+XkhHgdD9/9m2EzSxCGKgBjF0CKRoKuAlR27zsCkBN9v2ORHFVWqGS14BU+CI+Qo2eEnR3ZCPHol0lE9zDn8LDB0aC//ZSs1g25eslWm85a8L0ROpeLZ0VpaIa6PlGl5fnRY1OicYA4yC1oS+1fG8XqtwVbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777811; c=relaxed/simple;
	bh=FVkoMd4WSZt25+y60t4KjlhI+WB97f2fsUug9JwuwIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+sfW5aEH7VpIq+puKEhJbCeOJMLX99oeK6BnjaJjiqnBmvDxil8OOHT0mFzkbiQAKhyHwYXbVzH95jwzSGuGj82HZQVotoGHD+u8MsUz9Z2eGY/A+Kx8UtIKdt8nDKVOadu/82yS4hWKDX9loqur/xu4fHSPv680UobJCOAGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kW6P6LHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487ADC4CEF5;
	Wed,  3 Dec 2025 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777811;
	bh=FVkoMd4WSZt25+y60t4KjlhI+WB97f2fsUug9JwuwIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW6P6LHmegLsdG7OWQlSUv+O6JRgx2nuT8CYn/jQMt6ZkQHH1SDYknU4vc9sbW0rM
	 CFuN0zQrYJGVYL3pWRWXQdgGWlu0gI/lramRZxPFiaQC4+pTWUy8hQEVQLHkJ/uWsS
	 eUi+1JhaJdDsyRmwI9h9p5VvkamXdrO8VJc8MDSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 154/392] drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl
Date: Wed,  3 Dec 2025 16:25:04 +0100
Message-ID: <20251203152419.747958114@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index f293d0dfec613..98c842cf03e4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1625,30 +1625,21 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
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




