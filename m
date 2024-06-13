Return-Path: <stable+bounces-50473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23306906701
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731D2B248D1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07813F454;
	Thu, 13 Jun 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b="Y9jd3FOH"
X-Original-To: stable@vger.kernel.org
Received: from ext6.scm.com (ext6.scm.com [5.9.60.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8013E40E
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.60.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267795; cv=none; b=DpHLmGu2b5mjveJ+IrL1hd1ziv6I1zaudPMsTGaflsWkkzEOtCKXQd/xVD/uvegB4PrP6zEBwWQeBLgBLGqoGcyq7MYOBSUFcmP0TxHZUbpmtyocsc4JQWCuW7Yq86A+UuaoHz+Q37aKU8fY7z+7J3cfh3+MNUYOISrGHplOcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267795; c=relaxed/simple;
	bh=yRi0iYU1PJzNw7vp+OiJICvX+S+3plWdLC9S6JtY1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeO2DsUxM3LeVpgWPJFuwGM3RNKkzQDFxlmYFLoBFp/fLaymGwDgRBydco9CZod/mlavWV+/Oo4LS1B/9QgSDN8+p9Ots7wT7dQ8ZaW3tUJ2+l9mnFncUukLZktFiM/1js1BVcRLyBFQlllPUoGa5GF8ivuu2m4dqCqmo1X1huY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b=Y9jd3FOH; arc=none smtp.client-ip=5.9.60.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Received: from mintaka.ncbr.muni.cz (mintaka.ncbr.muni.cz [147.251.90.119])
	by ext6.scm.com (Postfix) with ESMTPSA id E48857E805D3;
	Thu, 13 Jun 2024 10:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scm.com;
	s=dkim20220819; t=1718267789;
	bh=yRi0iYU1PJzNw7vp+OiJICvX+S+3plWdLC9S6JtY1EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9jd3FOHCNzuzVMIL+KFRkFlqu0Ikk0+gKgaBzQZ+9j2PbpdvF8VNsC2j7ZJRvl1I
	 /aHCCjm7DVh8DabEImdhe2IBb9/8v5Q3EymHrmN8oSD6YKx3N7prs7vfuogyBnL2Bn
	 O4MIASugFKYmUsqrUaIvncZilEzLwI8GWXO33WxVjLriejRZV3C11xwaKQrvH61pyB
	 v1OBTIrQ54Wxz4zzzUWBp17tyeF4F51erkum5CSPTWymIj2rcYI0TY4LeliUBJNPcg
	 J5ChD6aFN+4Pi01DvM1hpl6BCa4G7oJ/7y9W6ztAGV/j2rYq2I4KjqDgSHbxXrP201
	 zibYZhJMjpCNw==
From: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>, "Yu, Lang" <Lang.Yu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
Date: Thu, 13 Jun 2024 10:36:28 +0200
Message-ID: <2505378.XAFRqVoOGU@mintaka.ncbr.muni.cz>
In-Reply-To: <2024061357-unseemly-nervy-7b25@gregkh>
References:
 <20240531141807.3501061-1-alexander.deucher@amd.com>
 <26439120.1r3eYUQgxm@mintaka.ncbr.muni.cz>
 <2024061357-unseemly-nervy-7b25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46rom: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0 ]

Observed on gfx8 ASIC where KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
Two attachments use the same VM, root PD would be locked twice.

[   57.910418] Call Trace:
[   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
[   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgp=
u]
[   57.793923]  ? idr_get_next_ul+0xbe/0x100
[   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
[   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
[   57.794141]  ? process_scheduled_works+0x29c/0x580
[   57.794147]  process_scheduled_works+0x303/0x580
[   57.794157]  ? __pfx_worker_thread+0x10/0x10
[   57.794160]  worker_thread+0x1a2/0x370
[   57.794165]  ? __pfx_worker_thread+0x10/0x10
[   57.794167]  kthread+0x11b/0x150
[   57.794172]  ? __pfx_kthread+0x10/0x10
[   57.794177]  ret_from_fork+0x3d/0x60
[   57.794181]  ? __pfx_kthread+0x10/0x10
[   57.794184]  ret_from_fork_asm+0x1b/0x30

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
Tested-by: Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.6.x only
Signed-off-by: Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>
[TT: trivially adjusted for 6.6 which does not have commit 05d249352f
     (third argument to drm_exec_init removed)]
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/
drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 15c5a2533ba6..9115fc8c96ba 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1135,7 +1135,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *me=
m,
 	int ret;
=20
 	ctx->sync =3D &mem->sync;
=2D	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+		      DRM_EXEC_IGNORE_DUPLICATES);
 	drm_exec_until_all_locked(&ctx->exec) {
 		ctx->n_vms =3D 0;
 		list_for_each_entry(entry, &mem->attachments, list) {
=2D-=20
2.45.1





