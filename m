Return-Path: <stable+bounces-166790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC20B1DA98
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9583ADF6D
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02625CC4D;
	Thu,  7 Aug 2025 15:11:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFD14884C
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579490; cv=none; b=oBSKsrnErCrS8gul/nORtQdGimIZ/5bJ5r1VoDLl7bFT582Wo/xaOSgrpaI2zSEGOgLLuHaxSl+VOcPj+AoohesP93pRqjdxkxUO6eX39OzAphpfm/OhyM2g+1muqROqJQlENUed/NPPkYocgQ8SEv5rynF2E04QBfTfyN43iSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579490; c=relaxed/simple;
	bh=QzhMySKuuSkey3yzlilATGr/aMw8wCt/kptf6UfgzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPo9TkAMPNI7BLo1ifNMqfR/Nw8dfh3jjZnO1lGAA4cMsGmcMU3LpL+oDxig0ZYvQ/aYP218YeETQuRdXxYOnpNa5PONvE5qoDZ3eFG9R84eSglYgdgXOHw1LRPoJf3IGtMcuJzse/mhzBkDOwpG38+74qmbVfP0nc3Mfn+JDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8390C16F2;
	Thu,  7 Aug 2025 08:11:19 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B139D3F5A1;
	Thu,  7 Aug 2025 08:11:25 -0700 (PDT)
Date: Thu, 7 Aug 2025 16:11:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v2] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJTCGrkg69Ytg-CC@arm.com>
References: <20250807091444.1999938-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807091444.1999938-1-gubowen5@huawei.com>

On Thu, Aug 07, 2025 at 05:14:44PM +0800, Gu Bowen wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 4801751cb6b6..381145dde54f 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -390,9 +390,15 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>  		else if (object->pointer == ptr || alias)
>  			return object;
>  		else {
> +			/*
> +			 * Printk deferring due to the kmemleak_lock held.
> +			 * This is done to avoid deadlock.
> +			 */
> +			printk_deferred_enter();
>  			kmemleak_warn("Found object by alias at 0x%08lx\n",
>  				      ptr);
>  			dump_object_info(object);
> +			printk_deferred_exit();
>  			break;
>  		}
>  	}

This hunk is fine.

> @@ -433,8 +439,15 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
>  		list_del(&object->object_list);
>  	else if (mem_pool_free_count)
>  		object = &mem_pool[--mem_pool_free_count];
> -	else
> +	else {
> +		/*
> +		 * Printk deferring due to the kmemleak_lock held.
> +		 * This is done to avoid deadlock.
> +		 */
> +		printk_deferred_enter();
>  		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
> +		printk_deferred_exit();
> +	}
>  	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);

I wouldn't bother with printk deferring here, just set a bool warn
variable and report it after unlocking. We recently merged another patch
that does this.

>  
>  	return object;
> @@ -632,6 +645,11 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  		else if (parent->pointer + parent->size <= ptr)
>  			link = &parent->rb_node.rb_right;
>  		else {
> +			/*
> +			 * Printk deferring due to the kmemleak_lock held.
> +			 * This is done to avoid deadlock.
> +			 */
> +			printk_deferred_enter();
>  			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
>  				      ptr);
>  			/*
> @@ -639,6 +657,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>  			 * be freed while the kmemleak_lock is held.
>  			 */
>  			dump_object_info(parent);
> +			printk_deferred_exit();

This is part of __link_object(), called with the lock held, so easier to
defer the printing as above.

BTW, the function names in the diff don't match mainline. Which kernel
version is this patch based on?

With the second change above using a bool warn, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin

