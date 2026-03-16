Return-Path: <stable+bounces-225642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPAnHkFBuGnSawEAu9opvQ
	(envelope-from <stable+bounces-225642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:43:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC229E72F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E053064F35
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F55301004;
	Mon, 16 Mar 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbwCgANB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB01327BFC;
	Mon, 16 Mar 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682693; cv=none; b=ZAB9PpIuW6y3VQO5n8cxgXEjFgh3IHsvfpjRPMzcL8XGr8EszlkLtHu3oJOEgRJiBcdx5f7AcF0pWdZG+o/+Lnhy3S9GuOAuN6Qh3hnC4wTYkB803KA1hS7O0oXQrfGKVb531TgchXgjUxMT6IHa/R7RNcFeOm799cNO4iG6PKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682693; c=relaxed/simple;
	bh=0uW0QOZk5+IfrJxww2/4kQ/hWFCZYeZgunMAVkXXw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgXQh5f6OLsH/9HE9bxZsU6FD+Y13H1lqEbm1AOAwXYMeL1v3s6jE8CjJO36/zKuumJIaHhjPkwtm4VJzMsXFcnv3n4k5LSwAqndOFYz0ANO3gUd9veFXFS+WJktgAz7He2KlL6vvXBC47d3/l+deI3vK8NElNzLFVaFFXFclMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbwCgANB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A269CC19421;
	Mon, 16 Mar 2026 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773682693;
	bh=0uW0QOZk5+IfrJxww2/4kQ/hWFCZYeZgunMAVkXXw+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbwCgANBypjy9qsi2M3LSEE/LODxD5jHzS0uqZlwWS+Pk8Qrcz7ggO1/eWSB7U0oW
	 69BBy8B7n4E1YfjAreHNxmgRhpGnsVaeIEfJ2L/gGO7pKRLew9oiPxOsUXaC0aEcE/
	 Fy+zu4Yn8otzpEMMQzuTlYhf/CTfDt+CcO0xjBjYuDIi2/4SjvnSg0WegJAwfOm30z
	 IoKA9Iy5dOCxrDX7/xYu/pUkUJC9I8OtfrHvLiIv7xiMx/ftallNP0srMh32sb+khI
	 +BN1oT6k1TwGySXYIQZeRlh2rMjr7plvFLajGq3+2oXALjFG2Pv60moJw97JCvdT3l
	 eSZxGqw+H4W7w==
Date: Mon, 16 Mar 2026 17:38:11 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: add null check for find_vm_area in
 __set_memory
Message-ID: <8d5e3b4a-4b8f-4db8-9dab-5b2d66b05f1a@lucifer.local>
References: <20260316151642.13738-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316151642.13738-1-osama.abdelkader@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225642-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CDBC229E72F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(-cc old email address +cc new.)

On Mon, Mar 16, 2026 at 04:16:39PM +0100, Osama Abdelkader wrote:
> find_vm_area() can return NULL. Add a null check to avoid potential
> null pointer dereference, matching the pattern used by other arches.
>
> Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> - Add Cc: stable@vger.kernel.org
> - Add Fixes: tag

This isn't a bug AFAICT, and we'd only really cc: stable add fixes if it was
identifiable as one, as Andrew mentions.

> - mention __set_memory in the commit message
> ---
>  arch/riscv/mm/pageattr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 3f76db3d2769..46a999c86b26 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -289,6 +289,10 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>  		int i, page_start;
>
>  		area = find_vm_area((void *)start);
> +		if (!area) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}

This call is gated on is_vmalloc_or_module_addr() so how would we fail to find
an area here?  (modules are also vmalloc()'d)

All set_memory_*() callers will be referencing genuine live data also, so I
don't think this is an issue?

Other arches do a NULL check, but they are not explicitly checking
is_vmalloc_or_module_addr() before doing the check, they seem to be using this
== NULL to imply the memory is something else.

So I think this patch is not correct, except for cases of some underlying bug,
but a bug SURELY would have triggered by now?

So yeah I don't think we should take this patch, as it implies a case that
simply cannot happen.

If it does happen and we get a bug report, it'll be very obvious where it
happened and why.

>  		page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
>
>  		for (i = page_start; i < page_start + numpages; ++i) {
> --
> 2.43.0
>

Thanks, Lorenzo

