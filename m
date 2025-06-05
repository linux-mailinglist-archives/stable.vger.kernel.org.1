Return-Path: <stable+bounces-151492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A298ACEAE4
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116B71895C58
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C511BEF74;
	Thu,  5 Jun 2025 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyEfqwsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4qMiTnRv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyEfqwsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4qMiTnRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD21FECCD
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108814; cv=none; b=rywjtFNRknnqz/FhoFCsS6h7YMaH+XhJpbK64LAwLrrn2LfGh3xjs0PjmbI+P1soPLwl3hg68jt8UbXgdqkVAGUrFX35WgmJE/8uYomF2xgILJ5BEUKB+ynRN+Fub75m1DGiqxdT/d29WI+LyZh2nrWZsiw+hbjXouASmng1m1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108814; c=relaxed/simple;
	bh=gmGszBrVzfKmvu4SEigChqt4NOq+6RosBHpHMVPbLxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9+3dMTl+JG6D5L4Rtrcdf1/5Spgn7i8xzxPgq08uONcrvvRe/p/UlYOEpi+3dbAXMqDyLIwoEpnr1/Ghe8gIkD1lEhobNj375DssC5bVSt/W0TGYuDWARCGtwah5qO00X3ueIbseSw8Dv+REWE0hn3jBQybHe37BOQOXKqelys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyEfqwsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4qMiTnRv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyEfqwsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4qMiTnRv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B960020FD7;
	Thu,  5 Jun 2025 07:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749108804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eti/kusLt4Hx+hsFwLu/xPDbXs6k5uThauq5TP9Zszc=;
	b=WyEfqwsKqgPfO1QdDu6pv4Uz2cq6epVuvFGr/6QjRCuIykB4AI8SHcXQvNYRX35t43RIH+
	lc7CfQdPyZJqwmXOxuLLmnfa8h6oqFmh+65Fow+NQs/lIr1NT7iDU+WkqXg1YzTW6BMmQL
	CoXlh1Ox6NPcpuwOKL36P0plWQru/Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749108804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eti/kusLt4Hx+hsFwLu/xPDbXs6k5uThauq5TP9Zszc=;
	b=4qMiTnRvB1UEr2w62DR60LOzGg7ovQAE/sx9LACL/a0A7wxPZRr/66BsiNqSemeVzJG9RN
	eKyFRu+8APadQhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749108804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eti/kusLt4Hx+hsFwLu/xPDbXs6k5uThauq5TP9Zszc=;
	b=WyEfqwsKqgPfO1QdDu6pv4Uz2cq6epVuvFGr/6QjRCuIykB4AI8SHcXQvNYRX35t43RIH+
	lc7CfQdPyZJqwmXOxuLLmnfa8h6oqFmh+65Fow+NQs/lIr1NT7iDU+WkqXg1YzTW6BMmQL
	CoXlh1Ox6NPcpuwOKL36P0plWQru/Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749108804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Eti/kusLt4Hx+hsFwLu/xPDbXs6k5uThauq5TP9Zszc=;
	b=4qMiTnRvB1UEr2w62DR60LOzGg7ovQAE/sx9LACL/a0A7wxPZRr/66BsiNqSemeVzJG9RN
	eKyFRu+8APadQhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A16031373E;
	Thu,  5 Jun 2025 07:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dTAEJ0RIQWiNLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Jun 2025 07:33:24 +0000
Message-ID: <ba208d76-7992-4c70-be8f-49082001f194@suse.cz>
Date: Thu, 5 Jun 2025 09:33:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 Pedro Falcato <pfalcato@suse.de>
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On 6/3/25 20:21, Jann Horn wrote:
> When fork() encounters possibly-pinned pages, those pages are immediately
> copied instead of just marking PTEs to make CoW happen later. If the parent
> is multithreaded, this can cause the child to see memory contents that are
> inconsistent in multiple ways:
> 
> 1. We are copying the contents of a page with a memcpy() while userspace
>    may be writing to it. This can cause the resulting data in the child to
>    be inconsistent.
> 2. After we've copied this page, future writes to other pages may
>    continue to be visible to the child while future writes to this page are
>    no longer visible to the child.
> 
> This means the child could theoretically see incoherent states where
> allocator freelists point to objects that are actually in use or stuff like
> that. A mitigating factor is that, unless userspace already has a deadlock
> bug, userspace can pretty much only observe such issues when fancy lockless
> data structures are used (because if another thread was in the middle of
> mutating data during fork() and the post-fork child tried to take the mutex
> protecting that data, it might wait forever).
> 
> On top of that, this issue is only observable when pages are either
> DMA-pinned or appear false-positive-DMA-pinned due to a page having >=1024
> references and the parent process having used DMA-pinning at least once
> before.

Seems the changelog seems to be missing the part describing what it's doing
to fix the issue? Some details are not immediately obvious (the writing
threads become blocked in page fault) as the conversation has shown.

> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Given how the fix seems to be localized to the already rare slowpath and
doesn't require us to pessimize every trivial fork(), it seems reasonable to
me even if don't have a concrete example of a sane code in the wild that's
broken by the current behavior, so:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memory.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 49199410805c..b406dfda976b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -917,7 +917,25 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>  	/*
>  	 * We have a prealloc page, all good!  Take it
>  	 * over and copy the page & arm it.
> +	 *
> +	 * One nasty aspect is that we could be in a multithreaded process or
> +	 * such, where another thread is in the middle of writing to memory
> +	 * while this thread is forking. As long as we're just marking PTEs as
> +	 * read-only to make copy-on-write happen *later*, that's easy; we just
> +	 * need to do a single TLB flush before dropping the mmap/VMA locks, and
> +	 * that's enough to guarantee that the child gets a coherent snapshot of
> +	 * memory.
> +	 * But here, where we're doing an immediate copy, we must ensure that
> +	 * threads in the parent process can no longer write into the page being
> +	 * copied until we're done forking.
> +	 * This means that we still need to mark the source PTE as read-only,
> +	 * with an immediate TLB flush.
> +	 * (To make the source PTE writable again after fork() is done, we can
> +	 * rely on the page fault handler to do that lazily, thanks to
> +	 * PageAnonExclusive().)
>  	 */
> +	ptep_set_wrprotect(src_vma->vm_mm, addr, src_pte);
> +	flush_tlb_page(src_vma, addr);
>  
>  	if (copy_mc_user_highpage(&new_folio->page, page, addr, src_vma))
>  		return -EHWPOISON;
> 


