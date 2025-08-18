Return-Path: <stable+bounces-171617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88854B2AC2C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7179A1963ECF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986DD248F7C;
	Mon, 18 Aug 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Vip3LMPz"
X-Original-To: stable@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8324A04D
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529659; cv=none; b=MSV0ZIe1sNiVb8Nal/ltLZcS/+yNfASn6VDFLBP87qS3J+VfqK9BDsCaW3A4W0hCOBeLQnwxibQJXhbzOyMCCtF65eHqAGBtvYjOrdobMZBtBND9RzPbk1r7z8ha+X14QZrqcX5Z3sTStIp0MdCn0T9hJhbMTq0mNshyEk0Fwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529659; c=relaxed/simple;
	bh=W7nLbXxI/v458LuT10vK9EQ738FG7J9ZcOr2AYygDPA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ozfRl8CM0SYYlrRY14GyC5LMclY5fCdzAfsBazQhhb/1TU4pbZgnm+POa6OUDFCRrUVX0GuEeTzsWgNexJeeDE91ElgqLtd+ZbyJZiQ0BGBEV9Hmcvm92MsnDjG7drzlzDdq+/OC5ORmPcvfvdZdaFbjeJ+TJXkRMTQwfCsG7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Vip3LMPz; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1755529650;
	bh=W7nLbXxI/v458LuT10vK9EQ738FG7J9ZcOr2AYygDPA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Vip3LMPztiG2UYNXFw24DnqBP+rUB1YIa2i63kixXVxl4YIRaV0+53cOYwh/P23Fn
	 gp5fWWlkzSeduMhhcwq4uwRLSDnHeyGz7UZhWYjs/uX33YNJYSHDe/0AXoKp1BguNN
	 xiiuSr/Gd3BvamYOV+Vo6+k+lIezyM2tW2R+gGAE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7F2B3401EF; Mon, 18 Aug 2025 08:07:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7C56D4010D;
	Mon, 18 Aug 2025 08:07:30 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:07:30 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: gregkh@linuxfoundation.org
cc: vbabka@suse.cz, harry.yoo@oracle.com, roman.gushchin@linux.dev, 
    stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm, slab: restore NUMA policy support
 for large kmalloc" failed to apply to 6.1-stable tree
In-Reply-To: <2025081818-skilled-timid-4660@gregkh>
Message-ID: <f423079b-6994-a2aa-8bcf-248f39e739b7@gentwo.org>
References: <2025081818-skilled-timid-4660@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

The breakage was introduced in 6.1 So maybe the fix is not needed?

On Mon, 18 Aug 2025, gregkh@linuxfoundation.org wrote:

>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x e2d18cbf178775ad377ad88ee55e6e183c38d262
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081818-skilled-timid-4660@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> >From e2d18cbf178775ad377ad88ee55e6e183c38d262 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 2 Jun 2025 13:02:12 +0200
> Subject: [PATCH] mm, slab: restore NUMA policy support for large kmalloc
>
> The slab allocator observes the task's NUMA policy in various places
> such as allocating slab pages. Large kmalloc() allocations used to do
> that too, until an unintended change by c4cab557521a ("mm/slab_common:
> cleanup kmalloc_large()") resulted in ignoring mempolicy and just
> preferring the local node. Restore the NUMA policy support.
>
> Fixes: c4cab557521a ("mm/slab_common: cleanup kmalloc_large()")
> Cc: <stable@vger.kernel.org>
> Acked-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 31e11ef256f9..06d64a5fb1bf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4269,7 +4269,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>  		flags = kmalloc_fix_flags(flags);
>
>  	flags |= __GFP_COMP;
> -	folio = (struct folio *)alloc_pages_node_noprof(node, flags, order);
> +
> +	if (node == NUMA_NO_NODE)
> +		folio = (struct folio *)alloc_pages_noprof(flags, order);
> +	else
> +		folio = (struct folio *)__alloc_pages_noprof(flags, order, node, NULL);
> +
>  	if (folio) {
>  		ptr = folio_address(folio);
>  		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
>

