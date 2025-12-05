Return-Path: <stable+bounces-200166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E2CA7CC0
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B90853023544
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF928CF49;
	Fri,  5 Dec 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="F4Gx2MyT"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4275219A8D
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764942046; cv=none; b=SgXpHGEDZxH+NFlaQ7xygLT9JtPBQyy0aiH9NN+hjvidN+s2rQpRFpzJmutZgVg0hg2Pjlyna9Sqi8V3HPH/QczSMiCWfnQmjN1ciktWjkunvBvM+BEPRvu3f2t7sQI4sV70WhP8XRz2SPHM+P3ld485kKrbJtj5JwZweThc5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764942046; c=relaxed/simple;
	bh=UY/np+QVBrIy3Vu+k+wCiKZ1IZrpwMilTi7/LaodpvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7ycsaRiaLw+irjd/nxlZqgvb4IVUH3LvO0HsH+joDUmXlhoygv6LtxVYxkCTG+zai03IVz+MFrUNW/0QFBYi749uiTI84aIiXRI05XbyN6my+46ClPw+ubR1T+iMP55abrhpLD444tGAvztZ5MQcFJGNcvxZuH1a6OD8YPykDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=F4Gx2MyT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ckn8sIUwsNZjA6D+X92cCWs5GUTH8Uh9FNEkrAinC0M=; b=F4Gx2MyTi50On0Iahk6HjjIYXf
	Eg0pOSoNsbCl8jvabqx3ftiZCqmCY2HoBy1F7SqbPPpM6ZSZYoZoz7wbTr6tXHX7zrVsgSKzh//tQ
	73mh9E/zkpX9SGQx3eEN9388nSezrJo/Y5ZOCe3FnJKCiwgUSDIIuzn8Rv5M4M75wp37rmYHZqOoy
	Ka/S6LeULrBSvu9DKgHoeHR1EH5D4uMTAbW7I/c1FGJWLfEhlF+Uznh1jzIJDIUUB+Xgr3ogA3Yt0
	4kF44IJa5ZcsKYILnocouGSiibO08C7ftcGdKUEBJQbwZg5lDjan8lXp6dUxqJkljBeKsnym8HF4Y
	XJFhAZ2w==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vRW34-0095gS-53; Fri, 05 Dec 2025 14:40:38 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/12] drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
Date: Fri,  5 Dec 2025 13:40:24 +0000
Message-ID: <20251205134035.91551-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop reference to syncobj and timeline fence when aborting the ioctl due
output array being too small.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index eba9fb359047..13c5d4462be6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -865,6 +865,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_unwrap_for_each(f, &iter, fence) {
 					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 						r = -EINVAL;
+						dma_fence_put(fence);
 						goto free_fences;
 					}
 
@@ -889,6 +890,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 				r = -EINVAL;
+				dma_fence_put(fence);
 				goto free_fences;
 			}
 
-- 
2.51.1


