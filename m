Return-Path: <stable+bounces-48147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F3A8FCCF7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFFC1F231EF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536791C157F;
	Wed,  5 Jun 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkGDEzT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB71C156D;
	Wed,  5 Jun 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588981; cv=none; b=ikcJ+3PIc65YmwIW1vBuXYmQCtGLuegifezRRTBtJKpBrCc6Df42uZXdpey0VBWmE7/VYOVZ0GQR/ItKp/+42RHFI9yXeFfwF7SeqLFDQOfV0s8mb7LiCqaR75ScXSwwbKD2XY2qP7px54kRv51oIPM+viEK8hdowQ5IbGjC9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588981; c=relaxed/simple;
	bh=uVevTPR/osKWsOEkjvF98Wwcb8jPDMSg6NxJx8m/h4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5/CN1POPWQjvhlKKty+06DYmLzeP5EJCMYxAEwYC1Lf9bPbULPF8VGhZH9FW7z4W/8HDTdPhZbQuVCddu/l/ssB/bGSKdnv8St6YxcdfoQHliTW4EfXzJ8+MExJ6uWBBpE0Zr3+Yzqfmv8hKSUSghxTl3VPRBif0nNDQ8OU0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkGDEzT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15166C32786;
	Wed,  5 Jun 2024 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588980;
	bh=uVevTPR/osKWsOEkjvF98Wwcb8jPDMSg6NxJx8m/h4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkGDEzT0Uq/9hnhNq09/lTP+spFUndLatikNyVRZqN/CvGZGgVI/SRyk7q4ERaTBo
	 wjJaPws6RiWCh9SsAKUq1jFgWssvH2/t6GJmukRQidHnS5rOWHRp4t9hBHpuACEtRM
	 QY6mBd3olYesiJS8/mCihz/7ocr3Mxk3J2dSdM5FI9C/Xf7knCVCb8M1VSbN29PiDr
	 rcXPSZK1kXXjqb3xvPJ0aG9vj/cIjoGvAQfxDJdRYWpqYo7s6oGD+TW8GLYwAXni2q
	 fK8TdvdepyoYXKFGC+1hVKq3zPNjEMISIJFNwa/WytoLsZKFVVvVR2r4CWf5DRWkK1
	 Qh7XOlAHM5qiA==
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
	Philip.Yang@amd.com,
	guchun.chen@amd.com,
	mukul.joshi@amd.com,
	xiaogang.chen@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 20/23] drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent
Date: Wed,  5 Jun 2024 08:02:03 -0400
Message-ID: <20240605120220.2966127-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index 124389a6bf481..512b42225003f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -682,11 +682,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
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


