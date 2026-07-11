Return-Path: <stable+bounces-273346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GCKwF0mIUWp0FwMAu9opvQ
	(envelope-from <stable+bounces-273346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 02:03:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A325173FCA8
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 02:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=ks717yvF;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273346-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273346-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5200F3012D22
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE18BE9;
	Sat, 11 Jul 2026 00:03:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1019C2FD;
	Sat, 11 Jul 2026 00:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728194; cv=none; b=Y1GCm2kPMd4m1z8sEsbnkpxDk5CLlJG2u/4Mz1Q4HYcKW91d+4n9UY0EVNlJkMlP3rFLPzdmABeG+PgztPt1u1vESmIi+2/lxkGJq7jx9aMha4ifsGRLZUgtEtq6TVEhdbmjW+vqcHJwymdj+wSBNTiS2SKC1TLJOKiPNWrrC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728194; c=relaxed/simple;
	bh=enp0NP5xaefs9vcbyeAYqjQEkQVaejslQaL03xbi5w8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h0XrDNFvRp2INDy0kcUKTfwvsCoRKHQSyCun1u65drNjdI0WqjxJnd3XMoLdG530hYFA00kS15xaTxnc5CErfrAiVAkE2mKVCznxInwDOQaQxI0ogvIupcJetUIlz6nsaxO/h/fG7KqKARFu8tk9cZ4QuZylbC5r3gPNuueNVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ks717yvF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A11F000E9;
	Sat, 11 Jul 2026 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783728192;
	bh=xuhLIGvoMzgdosMhkd0fNaNt5l4k3HBHBOpccxuxKL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ks717yvFqYIqA6WR+QY37XIQWgJADMKlFNW8jw3XJ2p3rnLamQ14UKrDDItXLbEl4
	 qMcKrFN9cPWw4pHi6vEKiLUVCcNSTKGHw5XWQFPyyn4tHd+4kR4/AfwoZFuob4diub
	 l93MdDD/tamKwNitPw3Y4n9eHiC14DinXg6/RRiE=
Date: Fri, 10 Jul 2026 17:03:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, Harry
 Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
Message-Id: <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
In-Reply-To: <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
	<20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jackmanb@google.com,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:shakeel.butt@linux.dev,m:harry@kernel.org,m:ast@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273346-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A325173FCA8

On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> As noted in can_spin_trylock(), using this is unsafe in this context.
> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
> but missed the free side.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
> Cc: stable@vger.kernel.org
> Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")

Is this correct?  I'm not seeing anything in that commit which could
have caused this?

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
>  		migratetype = MIGRATE_MOVABLE;
>  	}
>  
> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
> -		     && (in_nmi() || in_hardirq()))) {
> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>  		add_page_to_zone_llist(zone, page, order);
>  		return;
>  	}

It would be nice to include a description of the userspace impact.  I'm
suspecting that's "none known", but some speculation on what might
happen to someone is appropriate.

Also, please let's not combine a cc:stable bugfix with a minor macro
renaming.  They're very different things and will take quite different
paths into mainline and -stable kernels.

Also, Sashiko might have found yet more pre-existing issues:
	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com



