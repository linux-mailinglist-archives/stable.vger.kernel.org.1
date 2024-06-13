Return-Path: <stable+bounces-50458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7B90663C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C431C23269
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2E13CAA7;
	Thu, 13 Jun 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b="fK8OSTj5"
X-Original-To: stable@vger.kernel.org
Received: from ext6.scm.com (ext6.scm.com [5.9.60.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EB13CFB9
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.9.60.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266270; cv=none; b=dcmCAPaBYQ6wq5+JONaFjp0ha6mFAlYc/FZHAKM1+D8suTh2nIIx4H2KvhmaMnPVi2w3IZ7UPm5TYkhCRnbZk5f7GCnjoRFliA/C+yFA8aed0QDJGYB2l9fI4fIR3fwdKctFOsAvgx9dGychSEJILA1xVeROFBb3W5om+mmBC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266270; c=relaxed/simple;
	bh=u9MF74Anj6EjDhIaQKIlgKLDW1WgNxvWZze+LY3Y9pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4yXIen85Yxrs9+/MyCy50M1JFwYNTD84tyuP4RNy+Ra5BD73CocTp+g4OPgs989h0DkP3kC33c8wmgOC96DQzbv1+vJwALMIB4dNGFesBde6S3+amyDj/7HIy5EW91uozxLb9JzerpaeFwbk6A+ga1UTLFhBSsgE9jvcNqr3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com; spf=pass smtp.mailfrom=scm.com; dkim=pass (2048-bit key) header.d=scm.com header.i=@scm.com header.b=fK8OSTj5; arc=none smtp.client-ip=5.9.60.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scm.com
Received: from mintaka.ncbr.muni.cz (mintaka.ncbr.muni.cz [147.251.90.119])
	by ext6.scm.com (Postfix) with ESMTPSA id 2BAE87E805D3;
	Thu, 13 Jun 2024 10:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scm.com;
	s=dkim20220819; t=1718265893;
	bh=u9MF74Anj6EjDhIaQKIlgKLDW1WgNxvWZze+LY3Y9pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fK8OSTj5UmCKYKewPmQJyaQbmAWM4eKBl1LinkpyQd6hSE+lAEzeg/2Uy7oFwdMu7
	 B2p9He34whUguR7hfCqWnb2nqs6U2WsFQKBoHmUN1YRUZHrrubiD+irPMVQhWKbOdL
	 6AoO1iDko+MWPdU6+6KAIyBkE5UOezuXNThl2HMgivSjnvOA9Nv7rMb3JOsgOR4XOU
	 oE18wKZDjzrdfnVCDBH3sYKPCnbkVl2P87Nh4EFb6hJX5+r2DiXmH3h/kGLsf8+ZJN
	 S7bHs9lgCUHNZh3NrYqwzaJ57n4Aa/CO88Vngqy6OPg2v4U48f2dQwrZv387x6MoyD
	 O/JxDcKsD7VkA==
From: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "sashal@kernel.org" <sashal@kernel.org>, "Yu, Lang" <Lang.Yu@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject:
 Re: [PATCH] drm/amdkfd: handle duplicate BOs in reserve_bo_and_cond_vms
Date: Thu, 13 Jun 2024 10:04:51 +0200
Message-ID: <26439120.1r3eYUQgxm@mintaka.ncbr.muni.cz>
In-Reply-To: <2024061217-prodigal-navigate-557c@gregkh>
References:
 <20240531141807.3501061-1-alexander.deucher@amd.com>
 <BL1PR12MB5144EA4E60894AEDF352D61FF7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2024061217-prodigal-navigate-557c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, June 12, 2024 2:06:37 PM CEST, Greg KH wrote:
> On Mon, Jun 03, 2024 at 02:31:27PM +0000, Deucher, Alexander wrote:
> > [Public]
> >=20
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Saturday, June 1, 2024 1:24 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: stable@vger.kernel.org; sashal@kernel.org; Yu, Lang
> > > <Lang.Yu@amd.com>;
> > > Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
> > > Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
> > > reserve_bo_and_cond_vms
> > >=20
> > > On Fri, May 31, 2024 at 10:18:07AM -0400, Alex Deucher wrote:
> > > > From: Lang Yu <Lang.Yu@amd.com>
> > > >=20
> > > > Observed on gfx8 ASIC where
> > >=20
> > > KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
> > >=20
> > > > Two attachments use the same VM, root PD would be locked twice.
> > > >=20
> > > > [   57.910418] Call Trace:
> > > > [   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
> > > > [   57.793820]
> > >=20
> > > amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
> > >=20
> > > > [   57.793923]  ? idr_get_next_ul+0xbe/0x100
> > > > [   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
> > > > [   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
> > > > [   57.794141]  ? process_scheduled_works+0x29c/0x580
> > > > [   57.794147]  process_scheduled_works+0x303/0x580
> > > > [   57.794157]  ? __pfx_worker_thread+0x10/0x10
> > > > [   57.794160]  worker_thread+0x1a2/0x370
> > > > [   57.794165]  ? __pfx_worker_thread+0x10/0x10
> > > > [   57.794167]  kthread+0x11b/0x150
> > > > [   57.794172]  ? __pfx_kthread+0x10/0x10
> > > > [   57.794177]  ret_from_fork+0x3d/0x60
> > > > [   57.794181]  ? __pfx_kthread+0x10/0x10
> > > > [   57.794184]  ret_from_fork_asm+0x1b/0x30
> > > >=20
> > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
> > > > Tested-by: Tom=C3=A1=C5=A1 Trnka <trnka@scm.com>
> > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: stable@vger.kernel.org
> > > > (cherry picked from commit
> > >=20
> > > 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)
> > >=20
> > > > ---
> > > >=20
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > What kernel release(s) is this backport for?
> >=20
> > 6.6.x and newer.
>=20
> Does not apply to 6.6.y, sorry, how was this tested?  Can you submit a
> patch that does work?
>=20
> thanks,
>=20
> greg k-h

Sorry about that. 6.6 does not have commit=20
05d249352f1ae909230c230767ca8f4e9fdf8e7b "drm/exec: Pass in initial # of=20
objects" which adds the trailing 0 argument. Just removing that zero makes =
the=20
patch apply and work. Such a modified version is attached below.

Tested on 6.6.32 (version below), 6.8.12 and 6.9.3 (version sent by Alex=20
above).

2T

=46rom: Lang Yu <Lang.Yu@amd.com>

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
Cc: stable@vger.kernel.org
(cherry picked from commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)
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






