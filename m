Return-Path: <stable+bounces-48199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEAA8FCD96
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC901C23F57
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30719598B;
	Wed,  5 Jun 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4KDWDzv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA561CD448;
	Wed,  5 Jun 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589119; cv=none; b=Lnjdd/4MXsOG9dDQt+o57g14xfgbtx4/QLIKFyHWSzUbINEu9J7Kq02j5vHgrpeUyZAajVBcGE4WcIjvqzAnsQyrCZXCZoX1XkSzb0p5SznVDXguNhqMlTy4h0JuIZgbXteitnVdjJrkt/9aYruVRw8sfsVcZo0saTgeyNoIvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589119; c=relaxed/simple;
	bh=qQuitPoq93Dql+IO0stmpexe7lWd2SiPR91hJ0WDJ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueFWdYXS0CQmzt59c1NVWt/QgXQb9A22aTwV+c8M9X9L+c5GuGhm4yPIEfHYMY/LuXWb3VPiW/HwT8TRM2rXgejKf0NqvCoZKsVlUHI0VLncGaFYEnFQ4K186ak6ym2YECpdMAE3mJuNU8aBGb4OLHM+Ipct+3SYBBN0rnrj904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4KDWDzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12EBC32781;
	Wed,  5 Jun 2024 12:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589118;
	bh=qQuitPoq93Dql+IO0stmpexe7lWd2SiPR91hJ0WDJ/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4KDWDzv78u4Qc5Lss1IhyGHk6z/lbEuJiS5k9O0oaDV5eLVC2+5cAjRqpHVP9tRi
	 y1YJLHqK39A551DJsgLkna3D5INDkS9azzdAD99dohCvL4hM9By6a/C6/x7uJ/grbb
	 EMbtz5wYWqrn+X694968tOaBgKGhr1lu6OpNujZBJV/EuGFI60bQqwXOeSHZouEf3a
	 9aQtg497ASk6aJHZo6PAcp4hwnV5qvk1zp43gdNTRDn74JCKL0GRMDfg8U47gBn7aT
	 ctmvDFBoWsKA84KR5XmoyuehfWCnscgz6t2O1r1l9mFXrP12+H03gv+wYaaxV7Yh8y
	 CCx4JWy6LLdYw==
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
Subject: [PATCH AUTOSEL 6.1 13/14] drm/amdgpu: fix dereference null return value for the function amdgpu_vm_pt_parent
Date: Wed,  5 Jun 2024 08:04:46 -0400
Message-ID: <20240605120455.2967445-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 69b3829bbe53f..370d02bdde862 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -754,11 +754,15 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
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


