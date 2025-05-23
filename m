Return-Path: <stable+bounces-146189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41AFAC2159
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CBF50431B
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405B2288E3;
	Fri, 23 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b2a5Tg+5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58122A4D6;
	Fri, 23 May 2025 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997094; cv=none; b=Vl5X8ScOwq4lMrZZG9Px8r1I7y312jdIZs8WoVlaSd1hzak7M36u/ZIhN+0O4Ls7dtIyPv0r6MELm19GlRltEAAv/Vgtm45B2xMNi5+bDRFCFub0nCKcROe3Mnj6S3znbIOJUp+tXRrXAzczpkcM2yCm34BjmJxeq0uoAp3HSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997094; c=relaxed/simple;
	bh=VZYlNgSBmWqQK7NMMFjogt5NeRXygRdsZYS0WbfgyOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuOX6XpEJGZ+ruWjCSfn33GCfuBJVU9ZN2lWEZdM72kWWppjsZhrKZOgAfCqmTARXPmtpG3GgVxDyBNIVGXRQeKNDqUWobnW+JA/ilBXmEDu8fCxTjIqotvzQZQ/d9Z+erGj/CfbY9B7BtMBZ/t4wpftsS+6csvN+rMMU2+oyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b2a5Tg+5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0aeFl53JyQJoFv9ov6KZzE95rLNvmraObXYehnksakE=; b=b2a5Tg+5HvcXY0Oo9bgdU5lqVJ
	4zu4Ka/CeNw3mwz2dNnTOV7XJW7h3yLffXg0AINfWCiUs50mzbdnJAuEC83TNz+xaCDf4K/ofuA+H
	wItKnyG5zg2L81ua6o1ApGZ43wcvqd7HfDC4p9FUIox2bbZd8lsk1qlpiAu1nBPF14HdTzd0YmRXk
	hxnD0C+go2X3eGCgctOMP38oWzK2JEBXFXNa9PtNFbEXfdIhwMerlGgf4Ywmrp+HOenx6HiPvY/hj
	GtUlO7SvjoT2XzV01/y7SeKkfHu2g9H/El2BttesQUGH8sFKDZNmYV5zEHFm9vUYMoglANwzekTLb
	wjUFRWBg==;
Received: from 53.red-81-38-30.dynamicip.rima-tde.net ([81.38.30.53] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uIPtH-00C8SI-Si; Fri, 23 May 2025 12:44:39 +0200
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, revest@google.com,
 kernel-dev@igalia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: fix copy_vma() error handling for hugetlb mappings
In-Reply-To: <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
References: <20250523-warning_in_page_counter_cancel-v1-1-b221eb61a402@igalia.com>
 <afba02be-21d0-49f2-9ca1-36ee6f7fe27f@lucifer.local>
Date: Fri, 23 May 2025 12:44:32 +0200
Message-ID: <87iklrbo8f.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Lorenzo,

Thanks for the in-depth review! answers below:

On Fri, May 23 2025 at 11:00:40, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> OK so really it is _only_ when vma_link() fails?

AFAICT yes, since copy_vma() only calls vma_close() if vma_link()
fails. A failure in any of the other helpers in copy_vma() before it is
handled by simply freeing the allocated resources.

> Ordinarily 'private syzbot instance' makes me nervous, but you've made your case
> here logically.

I understand your qualms with that but, although that instance is mostly
concerned with downstream code, in this case there's nothing unusual, as
it was able to find the issue in mainline with a common reproducer. The
closest public report I found was the one I linked in [3], although I
couldn't reproduce the issue with the repro provided there.


> Hm, do we have a Fixes?

I couldn't find a single commit to point as a "Fixes". The actual commit
that introduces that close_vma() call there is
4080ef1579b2 ("mm: unconditionally close VMAs on error")
although I wouldn't say that's the culprit. As you said, the problem
with vma_close() seems to be more involved. If you want me to add that
one in the "Fixes" tag so we can keep track of the context, let me know,
that's fine by me.

> Why 6.12+? It seems this bug has been around for... a while.

Because in stable versions lower than that (6.6) the code to patch is in
mm/mmap.c instead, so I'd rather have this one merged first and then
submit the appropriate backport for 6.6.

> Thanks for links, though it's better to please provide this information here
> even if in succinct form. This is because commit messages are a permanent
> record, and these links (other than lore) are ephemeral.

True but, as you said, it's a bit of a pain to try to fit all the info
in the commit message, and the repro will still be living somewhere else.

> So, can we please copy/paste the splat from [1] and drop this link, maybe just
> keep link [2] as it's not so important (I'm guessing this takes a while to repro
> so the failure injection hits the right point?) and of course keep [3].

Sure, I'll make the changes for v2. FWIW, in my tests the repro could
trigger this in a matter of seconds.

> So,
>
> Could you implement this slightly differently please? We're duplicating
> this code now, so I think this should be in its own function with a copious
> comment.
>
> Something like:
>
> static void fixup_hugetlb_reservations(struct vm_area_struct *vma)
> {
> 	if (is_vm_hugetlb_page(new_vma))
> 		clear_vma_resv_huge_pages(new_vma);
> }
>
> And call this from here and also in copy_vma_and_data().
>
> Could you also please update the comment in clear_vma_resv_huge_pages():
>
> /*
>  * Reset and decrement one ref on hugepage private reservation.
>  * Called with mm->mmap_lock writer semaphore held.
>  * This function should be only used by move_vma() and operate on
>  * same sized vma. It should never come here with last ref on the
>  * reservation.
>  */
>
> Drop the mention of the specific function (which is now wrong, but
> mentioning _any_ function is asking for bit rot anyway) and replace with
> something like 'This function should only be used by mremap and...'

Ack, thanks for the suggestions!

Cheers,
Ricardo

