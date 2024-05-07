Return-Path: <stable+bounces-43220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE28BF032
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC101C21DF1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDF86247;
	Tue,  7 May 2024 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVfZBGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D1D8615E;
	Tue,  7 May 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122671; cv=none; b=VtMOC//deMTI2iBfs1iSstj0v14IZuSeB5rHcNRT77UJppf5aEW+Dcjs6t8gEPhGFONwqIQcWGH6NKj+uiiYpZKrrQkUNYetKhQ7xqC7+Tfg4MX85cbMrjhEmoE2D+KDnX4oOjoCc92XGDS9fRwuuLAVTJaHsm64m4rTPq6lC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122671; c=relaxed/simple;
	bh=BlyzEZlJylp6TxjnPAewWc0ccLh5lSN6B0Qh+KN2ADk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiiKHHplPOEDok+k3k8U+SbZwRRsv5O70/ppUS+lmFBbCwl9eRxBUBwd8av3IcO4UZ7SjQt9VNBnKcouoiCzsDHexhLtUcWzLtgsyN/j7h2u0ajcKooQc/lY6WZ8LVN+s9waKGI3oY0ixGh+k+rNcZGJpoAHbtIgGBcYv/9ALu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeVfZBGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE2C2BBFC;
	Tue,  7 May 2024 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122670;
	bh=BlyzEZlJylp6TxjnPAewWc0ccLh5lSN6B0Qh+KN2ADk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeVfZBGAEcjbByG3v6KhjaqTdu9pCgLaixlo5YzCF0GtYGUFVylljayJihuKNv+6p
	 7SME9REccHL/xTy/RjYQA4de4AK8+D2kZb+UMgpmilMsAxXFxPHnmrBf3bxc21ZtDv
	 4qlEPiptEvsisq5/G6FRcg7hPp+TQJvoWgn+Nbp0Ac3zLJ326Ns96+fFn6QFTmkxKP
	 GmWIix70fqh0TscV8Y7W3vSnnSUn2gUwLjsQPyMpRVZSf9bWiW5bbA6ynN9vfc4ASh
	 leuW6xFfj1SzlIGdW6kA2cvid/yMN1lcrlOroslcd6DuROg8vMjK5iF3Yyt6MTpoQL
	 sh5rFj7sPyV/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Mukul Joshi <mukul.joshi@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Philip.Yang@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	Hongkun.Zhang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	Jun.Ma2@amd.com,
	Wang.Beyond@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 10/23] drm/amdgpu: Update BO eviction priorities
Date: Tue,  7 May 2024 18:56:36 -0400
Message-ID: <20240507225725.390306-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <felix.kuehling@amd.com>

[ Upstream commit b0b13d532105e0e682d95214933bb8483a063184 ]

Make SVM BOs more likely to get evicted than other BOs. These BOs
opportunistically use available VRAM, but can fall back relatively
seamlessly to system memory. It also avoids SVM migrations evicting
other, more important BOs as they will evict other SVM allocations
first.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 866bfde1ca6f9..e7deb13ca4090 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -608,6 +608,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
-- 
2.43.0


