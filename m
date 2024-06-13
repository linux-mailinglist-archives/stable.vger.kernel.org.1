Return-Path: <stable+bounces-50476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25A9067C1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ACB1F20FD5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8213F438;
	Thu, 13 Jun 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOL75zop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF113E3EF
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268608; cv=none; b=YRaKy1+kh9BqKAV9dZaN8jzARlPynGnlI9tTNs+wYyvRffxnRS6ck86XIKbnDJWf3c7hibUutnfUw+pmJpJBg/gs62uVYvYB/NjH3MWo9Me0Pfa/b7AYLeBgW3AuZMMFuLYgGTYOiENTNdJzw/roimJFAZZW8pxhosxineTiwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268608; c=relaxed/simple;
	bh=EPn4oFLWuJX09QzLIBIUUkxdxRrrJROCEd2puvQgXLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3sz33/tzle71ZAJaJi3R8Yx+m63wNP0uOQNsQ8dzyX9ry0yY90uwrwsepCpsauGalTyEhpyJwFw1yKF0T+aLqFN0znsksIxjyhAgYCVm8bYeq0KkOdP6idQt0kLH+D+ytvtSrDqeJKfIefsZWxNpEOfQxuVmPabQssGKoapyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOL75zop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCA8C3277B;
	Thu, 13 Jun 2024 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718268608;
	bh=EPn4oFLWuJX09QzLIBIUUkxdxRrrJROCEd2puvQgXLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOL75zopk08BqtpA34d1FUNgPezoZtOCiabDKXsSejjcocAiOvtsjsrK+OeIiZnZS
	 eRGaVDZEWnkdepnmSbfLqAOtTDPEYWFT33yU79DCgxqkL3pzoH253wB8GiR52QNM7z
	 W/CJFgLKBL500KbTZN5SIB8sF0L2MC6QsjUu3s3w=
Date: Thu, 13 Jun 2024 10:50:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"Yu, Lang" <Lang.Yu@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Message-ID: <2024061358-shading-sizing-0779@gregkh>
References: <20240531141807.3501061-1-alexander.deucher@amd.com>
 <26439120.1r3eYUQgxm@mintaka.ncbr.muni.cz>
 <2024061357-unseemly-nervy-7b25@gregkh>
 <2505378.XAFRqVoOGU@mintaka.ncbr.muni.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2505378.XAFRqVoOGU@mintaka.ncbr.muni.cz>

On Thu, Jun 13, 2024 at 10:36:28AM +0200, Tomáš Trnka wrote:
> From: Lang Yu <Lang.Yu@amd.com>
> 
> [ Upstream commit 2a705f3e49d20b59cd9e5cc3061b2d92ebe1e5f0 ]
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
> Cc: stable@vger.kernel.org # 6.6.x only
> Signed-off-by: Tomáš Trnka <trnka@scm.com>
> [TT: trivially adjusted for 6.6 which does not have commit 05d249352f
>      (third argument to drm_exec_init removed)]
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

