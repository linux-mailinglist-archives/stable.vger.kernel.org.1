Return-Path: <stable+bounces-50466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74F90664D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD31E2830F3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4113D273;
	Thu, 13 Jun 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ct4HdCCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524313BC0D
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266473; cv=none; b=k3rGndNg6W0q6dUfLMp9Bk8v5nfbrRrgI60dL/0xX/cEB9dLA2FlOz8gJmPx0/bl3zKyoWFxIqgVGIkcEb0fNIcGHbi9bMEx5ArMFbTtcEoKWB66XwDrKfp5iwmFKTvsg4AkAwStYrBs8lbMvThZc6uwLPEjeA8IG9bQT1evrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266473; c=relaxed/simple;
	bh=D+QvPlHH57FFlJclwcE2KRgskT5gmaKKKfah5R7cHiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRRyXCc5BkM3WiYLfbE/ZNExi5b6HAPm9aUYZ4m+i1k0vDqgj1VuFDjmJICKB86Z+HLGtemU0jXUdJp+sq4OvDoXPCLb+uxMVbz4dCI/XgA/AIAX8lEDClMQCu1vIMy+L0I3e1UdSQOMrNp8+6BOjWjDmTVwy5bOJm3JkBzJo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ct4HdCCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034EC2BBFC;
	Thu, 13 Jun 2024 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718266473;
	bh=D+QvPlHH57FFlJclwcE2KRgskT5gmaKKKfah5R7cHiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ct4HdCCYzx1Bt+w8AfgCaRtKCeo+mRkPIQJtBk2K3u5Csxzu0kxGpknRfKakcm1wG
	 y0xB6x56IzFirtHSlj6RQvkTZYbQIm1Is1Qs1qJQNJPbU0jrNbRG5ZefBTyzqRjY6R
	 DIF6AtLMBOGWTsmu02U20KDXpN2DLex1YMhBu/C4=
Date: Thu, 13 Jun 2024 10:14:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"Yu, Lang" <Lang.Yu@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Message-ID: <2024061357-unseemly-nervy-7b25@gregkh>
References: <20240531141807.3501061-1-alexander.deucher@amd.com>
 <BL1PR12MB5144EA4E60894AEDF352D61FF7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2024061217-prodigal-navigate-557c@gregkh>
 <26439120.1r3eYUQgxm@mintaka.ncbr.muni.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26439120.1r3eYUQgxm@mintaka.ncbr.muni.cz>

On Thu, Jun 13, 2024 at 10:04:51AM +0200, Tomáš Trnka wrote:
> On Wednesday, June 12, 2024 2:06:37 PM CEST, Greg KH wrote:
> > On Mon, Jun 03, 2024 at 02:31:27PM +0000, Deucher, Alexander wrote:
> > > [Public]
> > > 
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Saturday, June 1, 2024 1:24 AM
> > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > Cc: stable@vger.kernel.org; sashal@kernel.org; Yu, Lang
> > > > <Lang.Yu@amd.com>;
> > > > Tomáš Trnka <trnka@scm.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > > > Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
> > > > reserve_bo_and_cond_vms
> > > > 
> > > > On Fri, May 31, 2024 at 10:18:07AM -0400, Alex Deucher wrote:
> > > > > From: Lang Yu <Lang.Yu@amd.com>
> > > > > 
> > > > > Observed on gfx8 ASIC where
> > > > 
> > > > KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
> > > > 
> > > > > Two attachments use the same VM, root PD would be locked twice.
> > > > > 
> > > > > [   57.910418] Call Trace:
> > > > > [   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
> > > > > [   57.793820]
> > > > 
> > > > amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
> > > > 
> > > > > [   57.793923]  ? idr_get_next_ul+0xbe/0x100
> > > > > [   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
> > > > > [   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
> > > > > [   57.794141]  ? process_scheduled_works+0x29c/0x580
> > > > > [   57.794147]  process_scheduled_works+0x303/0x580
> > > > > [   57.794157]  ? __pfx_worker_thread+0x10/0x10
> > > > > [   57.794160]  worker_thread+0x1a2/0x370
> > > > > [   57.794165]  ? __pfx_worker_thread+0x10/0x10
> > > > > [   57.794167]  kthread+0x11b/0x150
> > > > > [   57.794172]  ? __pfx_kthread+0x10/0x10
> > > > > [   57.794177]  ret_from_fork+0x3d/0x60
> > > > > [   57.794181]  ? __pfx_kthread+0x10/0x10
> > > > > [   57.794184]  ret_from_fork_asm+0x1b/0x30
> > > > > 
> > > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
> > > > > Tested-by: Tomáš Trnka <trnka@scm.com>
> > > > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > > > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > (cherry picked from commit
> > > > 
> > > > 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)
> > > > 
> > > > > ---
> > > > > 
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > What kernel release(s) is this backport for?
> > > 
> > > 6.6.x and newer.
> > 
> > Does not apply to 6.6.y, sorry, how was this tested?  Can you submit a
> > patch that does work?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sorry about that. 6.6 does not have commit 
> 05d249352f1ae909230c230767ca8f4e9fdf8e7b "drm/exec: Pass in initial # of 
> objects" which adds the trailing 0 argument. Just removing that zero makes the 
> patch apply and work. Such a modified version is attached below.
> 
> Tested on 6.6.32 (version below), 6.8.12 and 6.9.3 (version sent by Alex 
> above).
> 
> 2T
> 
> From: Lang Yu <Lang.Yu@amd.com>
> 
> Observed on gfx8 ASIC where KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
> Two attachments use the same VM, root PD would be locked twice.
> 
> [   57.910418] Call Trace:
> [   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
> [   57.793820]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
> [   57.793923]  ? idr_get_next_ul+0xbe/0x100
> [   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
> [   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
> [   57.794141]  ? process_scheduled_works+0x29c/0x580
> [   57.794147]  process_scheduled_works+0x303/0x580
> [   57.794157]  ? __pfx_worker_thread+0x10/0x10
> [   57.794160]  worker_thread+0x1a2/0x370
> [   57.794165]  ? __pfx_worker_thread+0x10/0x10
> [   57.794167]  kthread+0x11b/0x150
> [   57.794172]  ? __pfx_kthread+0x10/0x10
> [   57.794177]  ret_from_fork+0x3d/0x60
> [   57.794181]  ? __pfx_kthread+0x10/0x10
> [   57.794184]  ret_from_fork_asm+0x1b/0x30
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
> Tested-by: Tomáš Trnka <trnka@scm.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> (cherry picked from commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)

As you are modifying, and passing on, a patch, you need to also sign off
on this.

Please submit this in a format that I can apply it in, not as something
I need to hand-edit out of an email.

thanks,

greg k-h

