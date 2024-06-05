Return-Path: <stable+bounces-48184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D08FCDA4
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81CEB2C2FD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEA1CA2E8;
	Wed,  5 Jun 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv6DeN51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E61CA2E4;
	Wed,  5 Jun 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589081; cv=none; b=XxEK91FGx9Eb+UcPBRz+1BxSasXxEQ9OYx0SL8yCpdvIFev+iLWyuh+6YJYfwC9SlfzeuShHhfJ9Mo2MwJcYBBsjgrYAb+lZLHhAhPjzsWOxkn0AItKTgwUwx/uVIrB2Ca3N+q98wuBlO+VcNxm5PcimfNSuWP3jNAH/dxXOxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589081; c=relaxed/simple;
	bh=Vjgiu0ILR3uskzK21Z0875GunoRwQmq+BkAqVYl9M+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5mK5EcBZslZHCtggNTQblXZkwH2UTWbQLab35CjJNj3h+9uZN0H89uYiQHzmtkQlnJzMiWuMLTzIocKGp+P34VBWE4eWbc1pAbZKFfA9/jZ7JcSCaco0WAi54n7o7b+SSxWejiU67mgJq3DZAHT6Yup4c2kIQYFT6pR3BRhWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv6DeN51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F53C4AF09;
	Wed,  5 Jun 2024 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589080;
	bh=Vjgiu0ILR3uskzK21Z0875GunoRwQmq+BkAqVYl9M+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iv6DeN51QEggnAkiZVE+/TVBGNJ8z/dhDsrdGN1VrJUGkQWgrzeJ6aQ0472Tgnf+V
	 1/myHM4lIEneJ9IjoYaxVnOlC/lywW/ZgBUbXVBkhphiXOxe5euLNsQNQwQ7mei/Qe
	 AkV0nveOyckT0/QZbl0EuQJEOnq6m6fVfrl7f9Jz0P6s/QfasWgyy39Rh7IAqHfhbo
	 1oWrMCBxkqfBISsMBzuZP4akNgflmwbPh3eoj36SuXnSlvFU9KikMqypKkiMcIj7oX
	 dDB9wS7LoUI8X3ExTDBTclCwRrBCHQ9BVKrbOfx1wwCjMers/o1p1Ca8UMnhPoLD4n
	 ctUrt1xOm+XrQ==
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
Subject: [PATCH AUTOSEL 6.6 16/18] drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent
Date: Wed,  5 Jun 2024 08:03:55 -0400
Message-ID: <20240605120409.2967044-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 0d51222f6f8eb..026a3db947298 100644
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


