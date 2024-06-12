Return-Path: <stable+bounces-50228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1B90520D
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0CADB20AFC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282E16F0E1;
	Wed, 12 Jun 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BiL/t4iI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EC374D3
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194001; cv=none; b=hiDsrWMQPdTQ8h7LNHgCUNx9xaShCsQJW1VUKSNedJZVpKTQTlaQZQu9nzF/13qNMnruGzX7grfPSt/v0golzA9ZWq5qBVu8xkVvl9tV9Hs0zb4LCvJFaFNU093dRP36IOcKHQLXXvpsYdboMl691c75HH/nGM7e/gHaHLNvK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194001; c=relaxed/simple;
	bh=gM3mVIInr6GFNijc4mkuocWjRWnTu2i0B/utID4O0Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au/Gf9bx0HrTMKRgTSU0hYM86bv8+MC6lhTdPyZL0BwSw3sqTkJL8qAO7cDxH0YNTUDu+Tw8HwPHRav9OligS3X7zo5pR3mIWy10YjnZcVgDbxZyBZGPdrLd1dpVVvfgW9TAYQSrJliZzm9EYcd+LPiyFCJiKi75aHudNSZYCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BiL/t4iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E7C32789;
	Wed, 12 Jun 2024 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194000;
	bh=gM3mVIInr6GFNijc4mkuocWjRWnTu2i0B/utID4O0Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BiL/t4iIdQgUAjWQGw0fdmlT1ig7BZj7YE2GOjk2JQHl+4fAM594xDl2zS4HEUQGd
	 cSDX+IhPQpSE8qPfZAnZNeirT+CvL3U4xlCZNVKbvs6D4Mbn+CO8IRlvgw5Mweepr8
	 cLFqxFBM2hOokMt23RqlUxlhjMGPzLClo3mjPmMI=
Date: Wed, 12 Jun 2024 14:06:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"Yu, Lang" <Lang.Yu@amd.com>,
	=?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Message-ID: <2024061217-prodigal-navigate-557c@gregkh>
References: <20240531141807.3501061-1-alexander.deucher@amd.com>
 <2024060148-monopoly-broiler-1e11@gregkh>
 <BL1PR12MB5144EA4E60894AEDF352D61FF7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB5144EA4E60894AEDF352D61FF7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>

On Mon, Jun 03, 2024 at 02:31:27PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Saturday, June 1, 2024 1:24 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: stable@vger.kernel.org; sashal@kernel.org; Yu, Lang <Lang.Yu@amd.com>;
> > Tomáš Trnka <trnka@scm.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> > Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
> > reserve_bo_and_cond_vms
> >
> > On Fri, May 31, 2024 at 10:18:07AM -0400, Alex Deucher wrote:
> > > From: Lang Yu <Lang.Yu@amd.com>
> > >
> > > Observed on gfx8 ASIC where
> > KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM is used.
> > > Two attachments use the same VM, root PD would be locked twice.
> > >
> > > [   57.910418] Call Trace:
> > > [   57.793726]  ? reserve_bo_and_cond_vms+0x111/0x1c0 [amdgpu]
> > > [   57.793820]
> > amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x6c/0x1c0 [amdgpu]
> > > [   57.793923]  ? idr_get_next_ul+0xbe/0x100
> > > [   57.793933]  kfd_process_device_free_bos+0x7e/0xf0 [amdgpu]
> > > [   57.794041]  kfd_process_wq_release+0x2ae/0x3c0 [amdgpu]
> > > [   57.794141]  ? process_scheduled_works+0x29c/0x580
> > > [   57.794147]  process_scheduled_works+0x303/0x580
> > > [   57.794157]  ? __pfx_worker_thread+0x10/0x10
> > > [   57.794160]  worker_thread+0x1a2/0x370
> > > [   57.794165]  ? __pfx_worker_thread+0x10/0x10
> > > [   57.794167]  kthread+0x11b/0x150
> > > [   57.794172]  ? __pfx_kthread+0x10/0x10
> > > [   57.794177]  ret_from_fork+0x3d/0x60
> > > [   57.794181]  ? __pfx_kthread+0x10/0x10
> > > [   57.794184]  ret_from_fork_asm+0x1b/0x30
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3007
> > > Tested-by: Tomáš Trnka <trnka@scm.com>
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: stable@vger.kernel.org
> > > (cherry picked from commit
> > 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0)
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > What kernel release(s) is this backport for?
> 
> 6.6.x and newer.

Does not apply to 6.6.y, sorry, how was this tested?  Can you submit a
patch that does work?

thanks,

greg k-h

