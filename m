Return-Path: <stable+bounces-67427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7494FDFA
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D231C21C3C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399B93A8D8;
	Tue, 13 Aug 2024 06:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URpm6Pla"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF744C64;
	Tue, 13 Aug 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531120; cv=none; b=S02Lu/R4Wxm0oTEjg4C3VffwnNU4svZHJVfxT8ftPKGuL5Nwgz4m9qNPZhgFvZM0UIXo27/bWdaiEjso1J9ir5VQbLUv/+lDqYMLvOkeZZHD2zvYc0zKSnGgTRvn4nNA8LCTMrh5ZLk9oAGnpmZl8xkuDi/Or9SgZ/nZ2/GFmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531120; c=relaxed/simple;
	bh=gZXfOgCSbDUjKyomnFKCsMOHrgHqxFBPR0m6J5XfPME=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr5HNma6PA3F/StuWcKWKSvMImAIB9lfvmQHZGyEa1MvW4GjaungMFvTvQ5sD80cp5y/6qV8dKLBqI24I6J3ZEnk1u6KXPAPiq8Xb+exMrjSsFQYmu57Vx6aXWb4PTXVMMWsH5XDGnLIqG1sjujXHYaFBfOc1aMG16lXqekP1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URpm6Pla; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ef95ec938so5270997e87.3;
        Mon, 12 Aug 2024 23:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723531116; x=1724135916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJa60IJFVdBK+UxERtF9fP2C2kOIjqyMYl8iCwtl87Q=;
        b=URpm6PlagID5gH4+EDYk6LfAzboziQu4EoxMjagIKzeYyG8S6ffsTffqROect5/wVW
         4LNi1B2tgbhqA15avdnLpHOVXuRdoh4zCJr1Is2KLUfjnCIySv7QAw5LbJuPvh5d4+CI
         pEUWf4lncumLMZ3vPahulvXS8kDhiyeRtrHs6DILx1H7MV/o4RBpD/oPaKdW7zTn0N2R
         inQAdWcEep//aTp9w+QBtuzX43UD3oo4iWfyLw+5yj7q5Y7sWCbzQPfrJXaJU7DRNSYC
         3uthf3TOb0pZ3fnfPGbHMOmOmt1dAQjablZ7EYmOnJBjV1AM81VdXvLk3HDkY3atdQxa
         neaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723531116; x=1724135916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJa60IJFVdBK+UxERtF9fP2C2kOIjqyMYl8iCwtl87Q=;
        b=VtHqjArgDIjlTZGbqdtJN3COIp2oKPdaVxqilXsoh2eGrBK7azOoKNlCWEYYRAC5dD
         2XDGNObOJV8CwyT22r0/LlAD7/S9R39dzrzI4I59luXVIEwF5xeEA/V7o12IahmY9KNl
         q2yzOD6vyKcdl3whEANrpt+6qPgL0V5QA2pNJ80jvsQPckCM6An2qdyxxY8UUXxzDPE9
         QXWdj/OgCZ9DFNq3yw+9gEN4jwRN9bmtMjqKqKN1ibkAH1lk4AszG1/8sfAJJ3B2t1V8
         saNnhH2doE99qsumT1OCzEeM1eyRH6kJKT1B+baS+iSHrc59KAxJv4xQ0ngR6iqneen1
         TFTw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsL2s3WcBedZXz76dxn5y/GPsWyBXQQ5+m/Jc2TSR36akkoxx61n4pYF6jrTL3+hYsoDhX+yrXH40dfeE/ugzOcJ8XFna3uy46m8eIBPMPBpl0sZ4MTttqynkQ0uvFH+v0WuE
X-Gm-Message-State: AOJu0YzPJyiFeX2wndK9xwE4PFms5YAs3sVHoLSnyHrHLtgx6wpXaaeV
	XVlqLq475TqkoLIkD1lGi/buSIu0Ol6RViArtyb8o3Jo2lTSBfBn9DxJ7jjj
X-Google-Smtp-Source: AGHT+IHhkmtFOfnRR50pgIzu5D/40I3gw9Ry+fCCMDd3CDlMfZaly4fo1Ik4GsP056Fe4HFXbMVR8g==
X-Received: by 2002:a05:6512:1055:b0:52e:9b74:120 with SMTP id 2adb3069b0e04-5321365875cmr1672804e87.19.1723531115765;
        Mon, 12 Aug 2024 23:38:35 -0700 (PDT)
Received: from pc636 (host-95-193-9-14.mobileonline.telia.com. [95.193.9.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53202b5b447sm830926e87.177.2024.08.12.23.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 23:38:35 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 13 Aug 2024 08:38:32 +0200
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"Hailong . Liu" <hailong.liu@oppo.com>,
	Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: Ensure vmap_block is initialised before
 adding to queue
Message-ID: <Zrr_aI7Xi0tkf06O@pc636>
References: <20240812171606.17486-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812171606.17486-1-will@kernel.org>

On Mon, Aug 12, 2024 at 06:16:06PM +0100, Will Deacon wrote:
> Commit 8c61291fd850 ("mm: fix incorrect vbq reference in
> purge_fragmented_block") extended the 'vmap_block' structure to contain
> a 'cpu' field which is set at allocation time to the id of the
> initialising CPU.
> 
> When a new 'vmap_block' is being instantiated by new_vmap_block(), the
> partially initialised structure is added to the local 'vmap_block_queue'
> xarray before the 'cpu' field has been initialised. If another CPU is
> concurrently walking the xarray (e.g. via vm_unmap_aliases()), then it
> may perform an out-of-bounds access to the remote queue thanks to an
> uninitialised index.
> 
> This has been observed as UBSAN errors in Android:
> 
>  | Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
>  |
>  | Call trace:
>  |  purge_fragmented_block+0x204/0x21c
>  |  _vm_unmap_aliases+0x170/0x378
>  |  vm_unmap_aliases+0x1c/0x28
>  |  change_memory_common+0x1dc/0x26c
>  |  set_memory_ro+0x18/0x24
>  |  module_enable_ro+0x98/0x238
>  |  do_init_module+0x1b0/0x310
> 
> Move the initialisation of 'vb->cpu' in new_vmap_block() ahead of the
> addition to the xarray.
> 
> Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Cc: Hailong.Liu <hailong.liu@oppo.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 8c61291fd850 ("mm: fix incorrect vbq reference in purge_fragmented_block")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
> 
> I _think_ the insertion into the free list is ok, as the vb shouldn't be
> considered for purging if it's clean. It would be great if somebody more
> familiar with this code could confirm either way, however.
> 
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6b783baf12a1..64c0a2c8a73c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2626,6 +2626,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	vb->dirty_max = 0;
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
> +	vb->cpu = raw_smp_processor_id();
>  
>  	xa = addr_to_vb_xa(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
> @@ -2642,7 +2643,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	 * integrity together with list_for_each_rcu from read
>  	 * side.
>  	 */
> -	vb->cpu = raw_smp_processor_id();
>  	vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
>  	spin_lock(&vbq->lock);
>  	list_add_tail_rcu(&vb->free_list, &vbq->free);
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Makes sense to me. Thank you!

--
Uladzislau Rezki

