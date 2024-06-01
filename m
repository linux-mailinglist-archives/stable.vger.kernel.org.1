Return-Path: <stable+bounces-47817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2608D6E07
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 07:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FC7284C8F
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 05:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96487B64B;
	Sat,  1 Jun 2024 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bn1PUc9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD04C8C
	for <stable@vger.kernel.org>; Sat,  1 Jun 2024 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717219447; cv=none; b=blB4gXS1CIO9RWDN0cHARhQfvvKB38FyyrkR0h+uHXSBHpEFMdTL8gi4WStzdrN2hYJ//s2rOIF29W0XuZykbcyoqNasCFMHfJpwwGhRIa2pnHBT8VsO9FDhZKtWOBhJ+XtnYcQQFQt95IHPMmT6tRlZ3MAqhxC09Ut9C1R1C9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717219447; c=relaxed/simple;
	bh=A6eRlilG3DROl2LIYQJq85ttfBMNnOGLW84UpnH/8Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lloJJmPpUizuhnMKAZk1PFdqksKMsylTK+rcNSUWB+I8RPR7p7L7NptbFZGpY6KNeFWErbp69cGR0zhX8qsl+Nfg52MMzlVA06j6HnLoC/qIlo88pcDLczSSM+LPUAWP2liyUDpbiETSP5puGGCI9PfUQ5tot+bC+Owk2ktmnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bn1PUc9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253ABC116B1;
	Sat,  1 Jun 2024 05:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717219446;
	bh=A6eRlilG3DROl2LIYQJq85ttfBMNnOGLW84UpnH/8Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn1PUc9eblRoLk57rwKMomsu3rKTSyT7nRrCadidR8Lh96MiBp58GpQ7/Fp+Hev4l
	 98YnszgDy4h8Tgi9HepfF+sUNMnB88mA+13oxjkimrWiJ/GLiNwhaLUAIBmwGxpNTI
	 LUKnqMIiSEOQWXjx++QlC7g7VTHPToXUBHKsAMx8=
Date: Sat, 1 Jun 2024 07:24:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, Lang Yu <Lang.Yu@amd.com>,
	=?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Message-ID: <2024060148-monopoly-broiler-1e11@gregkh>
References: <20240531141807.3501061-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531141807.3501061-1-alexander.deucher@amd.com>

On Fri, May 31, 2024 at 10:18:07AM -0400, Alex Deucher wrote:
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
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

What kernel release(s) is this backport for?

thanks,

greg k-h

