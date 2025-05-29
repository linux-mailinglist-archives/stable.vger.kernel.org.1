Return-Path: <stable+bounces-148115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF94AAC8286
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A37FA23B57
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50893207DF7;
	Thu, 29 May 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="00f82g2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC921362;
	Thu, 29 May 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748546386; cv=none; b=aiX441Co29NAhxiC3pqETFK5NNJ5US1nz37fe5S6s7y/ZlNgUng95FpOwOMY/xsclHUTyQY+m3LFm6BceFGmUPltnZUKoFbjg/FBGkIrUb4U+5RDzS/tFwtH4/6MwRAPkTGuUJvfhmYGBgPF++uY33P4wPpU2mvEKXyse/nIeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748546386; c=relaxed/simple;
	bh=gjCiKDdfaEWII9jOdJ9+wKKH4AcrdcHQPnXnJ+qyn2w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wndhn+l9Di12I1WBbyXuXsLczVKqhTvTiECWmc4/Gx2XFEnUGlfYo4LEbnJ6AXJUcgDBtiO6hfVCyXs9IX0orM7xhRTH2GPunb895cHstgyL0mYhGNvmPKBeHjQKV7KCCNrwvfwhKIiFdhvJJn2Snc1WAL3AormB5TJjfwezBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=00f82g2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D2C4CEE7;
	Thu, 29 May 2025 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748546385;
	bh=gjCiKDdfaEWII9jOdJ9+wKKH4AcrdcHQPnXnJ+qyn2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=00f82g2FzzQZob2qEoFw/5W2wOvRfGP8OoYIQzmLEDYTfzn6QlXym2gM0VV8PTfdL
	 9ww7NfRt1ksYE/cB6Du0hVhBnibmZyhRSggoqCBKjbCNwbmaOIyZCs1Yrm0OWksuFC
	 G/oU5eQ4h0Y+Bo0/wyy7hbttbe5uNk8S+Clnv+t4=
Date: Thu, 29 May 2025 12:19:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
Subject: Re: [PATCH v1 2/4] mm: Expose abnormal new_pte during move_ptes
Message-Id: <20250529121944.3612511aa540b9711657e05a@linux-foundation.org>
In-Reply-To: <20250529155650.4017699-3-pulehui@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
	<20250529155650.4017699-3-pulehui@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 15:56:48 +0000 Pu Lehui <pulehui@huaweicloud.com> wrote:

> From: Pu Lehui <pulehui@huawei.com>
> 
> When executing move_ptes, the new_pte must be NULL, otherwise it will be
> overwritten by the old_pte, and cause the abnormal new_pte to be leaked.
> In order to make this problem to be more explicit, let's add
> WARN_ON_ONCE when new_pte is not NULL.
> 
> ...
>
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -237,6 +237,8 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  
>  	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
>  				   new_pte++, new_addr += PAGE_SIZE) {
> +		WARN_ON_ONCE(!pte_none(*new_pte));
> +
>  		if (pte_none(ptep_get(old_pte)))
>  			continue;
>  

We now have no expectation that this will trigger, yes?  It's a sanity
check that patch [1/4] is working?  Perhaps VM_WARN_ON_ONCE() would be
more appropriate.  And maybe even a comment:

	/* temporary, remove this one day */



