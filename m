Return-Path: <stable+bounces-85118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4EF99E3D1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EDAB22A28
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE01E379D;
	Tue, 15 Oct 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Cr7SIyGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp104.iad3a.emailsrvr.com (smtp104.iad3a.emailsrvr.com [173.203.187.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9441DD88D;
	Tue, 15 Oct 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988010; cv=none; b=MoOAJ8zbxVedeZBHWTA6ZPlbiYvz3C7ASdzKktOXG03xA/JGF1AmZr7q+skO7rlH9QPNkGy0Sb0mj5oMe6B5/GnmzR72tzcqfhibw/6CM09SFcmMLfuVHqxcHku7XrFdvEGlQNYqaAbvo0BHw8hUDzrUyb29BoyBu/D2sNICJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988010; c=relaxed/simple;
	bh=PJRqIp9n5Mf2OJtL8AZpAYA3vRkTkn4CYT/9vbWvho8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcX91RUvRaZbESqLgAy/xUJ0apbWWehB0Xoo1Bfvfhe4vYPVDXYijSnBZXGwt9Gjo+e47qZzMroXee1XSORgxWwg9fjmJvpIKOhm9ZUbXX8DX7+Z4T9T2iv1xmcgX3JBd8JlboqJvp1rBEGzdqZwZ5I41fkwmINHY+vWKHk1sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Cr7SIyGl; arc=none smtp.client-ip=173.203.187.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1728987586;
	bh=PJRqIp9n5Mf2OJtL8AZpAYA3vRkTkn4CYT/9vbWvho8=;
	h=Date:Subject:To:From:From;
	b=Cr7SIyGlsNLBl59vrLeXnfX6GKV51CZVuPfviskV2CEcRDD0M0MvwhjrMogDjMM/T
	 uQImLOIg01NRAezOoPpR6Y2+QCQW7YZk6Md14NuwISO2Zi2Hb7BpPipcoqZXDYhz9d
	 vrfU4HUcJy+F18cAKn000hzOAFSmihBBJctx08yQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0D81A3AB1;
	Tue, 15 Oct 2024 06:19:45 -0400 (EDT)
Message-ID: <4f531d06-9802-4086-8463-db4c9b6ba11c@mev.co.uk>
Date: Tue, 15 Oct 2024 11:19:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: Flush partial mappings in error case
To: Jann Horn <jannh@google.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Frank Mori Hess <fmhess@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241014-comedi-tlb-v1-1-4b699144b438@google.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20241014-comedi-tlb-v1-1-4b699144b438@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 0eb9834f-7cf2-4e2b-8beb-e87435a99214-1-1

On 14/10/2024 21:50, Jann Horn wrote:
> If some remap_pfn_range() calls succeeded before one failed, we still have
> buffer pages mapped into the userspace page tables when we drop the buffer
> reference with comedi_buf_map_put(bm). The userspace mappings are only
> cleaned up later in the mmap error path.
> 
> Fix it by explicitly flushing all mappings in our VMA on the comedi_mmap()
> error path.
> 
> See commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> error case").
> 
> Cc: stable@vger.kernel.org

Your patched version won't compile before 6.1 so you may want to 
indicate that in the Cc line.

> Fixes: ed9eccbe8970 ("Staging: add comedi core")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Note: compile-tested only; I don't actually have comedi hardware, and I
> don't know anything about comedi.
> ---
>   drivers/comedi/comedi_fops.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 1b481731df96..0e573df8646f 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -2414,6 +2414,15 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
>   		vma->vm_private_data = bm;
>   
>   		vma->vm_ops->open(vma);
> +	} else {
> +		/*
> +		 * Leaving behind a partial mapping of a buffer we're about to
> +		 * drop is unsafe, see remap_pfn_range_notrack().
> +		 * We need to zap the range here ourselves instead of relying
> +		 * on the automatic zapping in remap_pfn_range() because we call
> +		 * remap_pfn_range() in a loop.
> +		 */
> +		zap_page_range_single(vma, vma->vm_start, size, NULL);
>   	}
>   
>   done:
> 
> ---
> base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
> change-id: 20241014-comedi-tlb-400246505961

I guess this doesn't need to be done for the path that calls 
dma_mmap_coherent() since that does not do any range splitting. Would it 
be better to move it into the branch that calls remap_pfn_range() in a loop?

Note that I have no commit access to pulled-from repositories.  Greg-KH 
usually commits them on one of his repos, so could you Cc him too?  Thanks.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

