Return-Path: <stable+bounces-86821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637DD9A3D68
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237FC283B9F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45651D7E45;
	Fri, 18 Oct 2024 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ZGOLYkeu"
X-Original-To: stable@vger.kernel.org
Received: from smtp83.ord1d.emailsrvr.com (smtp83.ord1d.emailsrvr.com [184.106.54.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21721D5CE0;
	Fri, 18 Oct 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251706; cv=none; b=INClflVC4UTtHgXzAN3HMzYkSZjr92MvbCmE6wob1q0X2/oHvpruX/wME2ohGZ83HQoN1rPc9BALw5exM98Dp/wjCaE0UNc52J/RGMaMh2Jxe0+qq7o3gJPm7taarP4efKVOrY+hywlcNf9ijcuCVnORMgyIZNa1c5fQ7QFYZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251706; c=relaxed/simple;
	bh=9RhLGmbiBRtepmdiZwPlKSDhSY+UR62sjht8gKRsnmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Su1xCsfY4AJmHS//u771JJw44tNNn2f9Xvcf+rUCaWQ7F9KCZC0kRDMnU1B7WLvTlMx0WvKPa3TGT/pOZ73W6YuL9FETFR2N2RHukjp85kddofP8p7rwRLvPHy2PER+dHPbessuFEY9911oa58zavP1uILHsGGOfJP4JUJ+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=ZGOLYkeu; arc=none smtp.client-ip=184.106.54.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1729251329;
	bh=9RhLGmbiBRtepmdiZwPlKSDhSY+UR62sjht8gKRsnmc=;
	h=Date:Subject:To:From:From;
	b=ZGOLYkeuVQ84nHszWqmRpRu+M/Z7ZgMS14SDA8xKhuTanoffTAI7oyLF01bPUOBwY
	 +nxNDriWHvwHZ7IuSlK9KnLIhkknQzkYwfh7uC3+kVOUbeJPa+uOrLaSr+y0DTeNXl
	 9rRrTrOGxGoWUwD8+posdrIp0U3SjH2ztuhJdBs0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C3BAC601D8;
	Fri, 18 Oct 2024 07:35:28 -0400 (EDT)
Message-ID: <10f30e5b-dbf0-4f7d-9688-5ae256e2c252@mev.co.uk>
Date: Fri, 18 Oct 2024 12:35:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] comedi: Flush partial mappings in error case
To: Jann Horn <jannh@google.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Frank Mori Hess <fmh6jj@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241017-comedi-tlb-v3-1-16b82f9372ce@google.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
In-Reply-To: <20241017-comedi-tlb-v3-1-16b82f9372ce@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 4da0f65f-3f97-4434-b483-c44206dccc89-1-1

On 17/10/2024 20:07, Jann Horn wrote:
> If some remap_pfn_range() calls succeeded before one failed, we still have
> buffer pages mapped into the userspace page tables when we drop the buffer
> reference with comedi_buf_map_put(bm). The userspace mappings are only
> cleaned up later in the mmap error path.
> 
> Fix it by explicitly flushing all mappings in our VMA on the error path.
> 
> See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> error case").
> 
> Cc: stable@vger.kernel.org
> Fixes: ed9eccbe8970 ("Staging: add comedi core")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Note: compile-tested only; I don't actually have comedi hardware, and I
> don't know anything about comedi.
> ---
> Changes in v3:
> - gate zapping ptes on CONFIG_MMU (Intel kernel test robot)
> - Link to v2: https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com
> 
> Changes in v2:
> - only do the zapping in the pfnmap path (Ian Abbott)
> - use zap_vma_ptes() instead of zap_page_range_single() (Ian Abbott)
> - Link to v1: https://lore.kernel.org/r/20241014-comedi-tlb-v1-1-4b699144b438@google.com
> ---
>   drivers/comedi/comedi_fops.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 1b481731df96..b9df9b19d4bd 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -2407,6 +2407,18 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
>   
>   			start += PAGE_SIZE;
>   		}
> +
> +#ifdef CONFIG_MMU
> +		/*
> +		 * Leaving behind a partial mapping of a buffer we're about to
> +		 * drop is unsafe, see remap_pfn_range_notrack().
> +		 * We need to zap the range here ourselves instead of relying
> +		 * on the automatic zapping in remap_pfn_range() because we call
> +		 * remap_pfn_range() in a loop.
> +		 */
> +		if (retval)

Perhaps that condition should be changed to `retval && i` since there 
will be no partial mappings left behind if the first call to 
`remap_pfn_range` failed.

> +			zap_vma_ptes(vma, vma->vm_start, size);
> +#endif
>   	}
>   
>   	if (retval == 0) {
> 
> ---
> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> change-id: 20241014-comedi-tlb-400246505961


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

