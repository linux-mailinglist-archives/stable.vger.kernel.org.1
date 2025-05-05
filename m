Return-Path: <stable+bounces-140387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AECAAA824
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DBF463EC1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3934881F;
	Mon,  5 May 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C43vr9Gf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADA348817;
	Mon,  5 May 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484748; cv=none; b=Wjsa1+NMFwepNkICSISBdB7NwP2nOsWdTNcL1vkE+R4VK6hwLUE+oZbM2Z+9bPl/PLj92Q2igo6yqDB6YkJjN6rMc8EVJ1sSKKghmqb7APzYAQAkrf51i1to2DWoEg+uCsT1AklNWBjRll0uy5F0OBR39fiMwXpq6Mxrf5+Fhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484748; c=relaxed/simple;
	bh=LjC4SSuqVjn22E0rvV5yJGbrdl+kUvZEuyA1XYwpiaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCL0a567fbuROqvZlgbZDCP9ZiRrTAmd+lsM8W5ypj6ls3CkZf2QftJyCyesOGkOJsc+M+tq2YeUVM0j8O2Q2995mP/oBN+Humm1PEtRRTyG1VFFxPCeu0/n7dD9YVhAHpliMoYW5lJm1OEEbc7iLEI+Zpbgv+0TKPcc5dz9Zy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C43vr9Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAB3C4CEEF;
	Mon,  5 May 2025 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484748;
	bh=LjC4SSuqVjn22E0rvV5yJGbrdl+kUvZEuyA1XYwpiaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C43vr9GfumZUCYZTNN4HOAu2D9DillqVNO4CgeuqnvLt+Ka4/Rh7Oavr7JYUL3WLG
	 QlZ4NylqiSfdtEzLTcq/GODMT/nJU+GsrQdk6fHX3okZO2dLUVXc5Inzi5YJrgT6ap
	 afujyG5Vp8TXq+/b09ictM4Ssr2tQm3WSQGl7dvwizSZrqHFUZeKrlgQsG9O2LDek7
	 rMWOISR0tksVJ/riCDg/EjayMrAUs4kv2kDTNi8DKf4vh2zl2PHeWvd9MyMSFcMw6l
	 lfzkFmUGqW4YtzKFOFuHi7567NeuXkt0Vz6VP3dfFITp8GGR9wQJFeQlVTbu6mRGx/
	 lqwuI1g9NBXdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 638/642] drm/amdkfd: Fix error handling for missing PASID in 'kfd_process_device_init_vm'
Date: Mon,  5 May 2025 18:14:14 -0400
Message-Id: <20250505221419.2672473-638-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 2b04d04de956b44cc140d45cf8ebccfb378ce3bf ]

In the kfd_process_device_init_vm function, a valid error code is now
returned when the associated Process Address Space ID (PASID) is not
present.

If the address space virtual memory (avm) does not have an associated
PASID, the function sets the ret variable to -EINVAL before proceeding
to the error handling section. This ensures that the calling function,
such as kfd_ioctl_acquire_vm, can appropriately handle the error,
thereby preventing any issues during virtual memory initialization.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1694 kfd_process_device_init_vm()
warn: missing error code 'ret'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
    1647 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
    1648                                struct file *drm_file)
    1649 {
    ...
    1690
    1691         if (unlikely(!avm->pasid)) {
    1692                 dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
    1693                                  avm);
--> 1694                 goto err_get_pasid;

ret = -EINVAL?

    1695         }

Fixes: 8544374c0f82 ("drm/amdkfd: Have kfd driver use same PASID values from graphic driver")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a7e0a16dac47b..3f411922534b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1711,6 +1711,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (unlikely(!avm->pasid)) {
 		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
 				 avm);
+		ret = -EINVAL;
 		goto err_get_pasid;
 	}
 
-- 
2.39.5


