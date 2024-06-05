Return-Path: <stable+bounces-48166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7E8FCD42
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19C91F220F1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C41A2FD4;
	Wed,  5 Jun 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXj2k8lp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD171C5380;
	Wed,  5 Jun 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589031; cv=none; b=F5YHv0G98wsJiSZZ/toGC8dcCfk0c62srr5N5jUEKGAEvRH9biqCgbVNwUk6V2qPf+eRg5Y3EgU0wmNICVIQ6BxZ4kkyyAasQ/RjDz0lC2eAmwPJ42439lp9VNlInfJVM5I1GQ19i7KVlE0HxUDegQfEL+G9FTMov7Q2EmhcYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589031; c=relaxed/simple;
	bh=VB9SDG8gr31R2W8OWY7ctbZhG9qXo6auRWU3/Xy/4DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSO7SKsBaXuFPErBHPpWAjhrQzrsOwC3oJiTBqIEgRfbkQlfpLEBky1jYNh8rAJjN/bmbRIqm89uOcM+NCq/bOqfRrIAMlKsdhJjYIXwHjbPBAtGvQYa+3Hd1dkE2A7tlqPEThxDCQXyEPwFzyofqBF9jdrA48C5sr9cRI7qFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXj2k8lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4EFC3277B;
	Wed,  5 Jun 2024 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589031;
	bh=VB9SDG8gr31R2W8OWY7ctbZhG9qXo6auRWU3/Xy/4DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXj2k8lpi5jCEWgJt0t8CbVvvhVTzc9flHelIvT+rY4aU94V88t1M5hEV5nCgiD3a
	 JxCnbmNf24hN3ifQgal9AswGo5GoBrHzDD/Z+kro/1Ra7YLOv7U4O5NHQGEfU9BgXs
	 K+e8qNc3mRlEEoDUYWsuTUOQ4zpuvUnaxzxI7W7P/LGkrmNa/N9ay93nKFmPiQzVQm
	 lZeK2mZmVZZ6KiW8/JEtZQcD3c/4erhW3nCbs+wOyv1sWUiAmzQ0Zez7OmsYK4kXRl
	 B4lvz0MMvrKZVGtVz4V2pnyHxrp+62uOesN+bUb8Cu6lYtwq8TCBcnGV8nAvxDCmkN
	 2FWhVBy56n/gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Felix.Kuehling@amd.com,
	shashank.sharma@amd.com,
	guchun.chen@amd.com,
	Philip.Yang@amd.com,
	mukul.joshi@amd.com,
	xiaogang.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 16/18] drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent
Date: Wed,  5 Jun 2024 08:03:06 -0400
Message-ID: <20240605120319.2966627-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit a0cf36546cc24ae1c95d72253c7795d4d2fc77aa ]

The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
To make the code more robust, check the pointer parent.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07c..099e375a39ec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -766,11 +766,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_vm_bo_base *parent = amdgpu_vm_pt_parent(entry);
-	struct amdgpu_bo *bo = parent->bo, *pbo;
+	struct amdgpu_bo *bo, *pbo;
 	struct amdgpu_vm *vm = params->vm;
 	uint64_t pde, pt, flags;
 	unsigned int level;
 
+	if (WARN_ON(!parent))
+		return -EINVAL;
+
+	bo = parent->bo;
 	for (level = 0, pbo = bo->parent; pbo; ++level)
 		pbo = pbo->parent;
 
-- 
2.43.0


