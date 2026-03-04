Return-Path: <stable+bounces-223139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OfcH4OkqGnywAAAu9opvQ
	(envelope-from <stable+bounces-223139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 22:30:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5AA207FF7
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A62C3044A63
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF5388E4F;
	Wed,  4 Mar 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="TF2yb9Pd"
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6838735D
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659811; cv=none; b=Q3FzkJ8NpfUNe8m0U+Ltk2j+KWLs6GC3I3PatpFxrsj6KMSRGT2uzn+zqfDyaQt+CyoE5IleXYzp/4zo5pw5UY2CaGRz2feF9jRQdhcKWgK473afdkd6Hx6qkQE3KRFz6yBF+0SjtjsI9VH/yEG+787kGSqjCZEndSr8jpUe0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659811; c=relaxed/simple;
	bh=JLpBgbhEpXHUcy8m3RgiUcVw7GvaSTz+bmeVql0cDPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7pw5j2CCqHLmnzfkDtd8BFG+l4UQFa89XJqbv/ic6ulPLOTDMFqfBXLWF9bSeoEcvchF33PA06GRndcptRy5b7eN4GeMGmn9gvXQElPKrjfTDkeVNyu9Mb6KikrDq73h7poL4GJBSeOWdp+C4FIW9K1rkJJuwVTrTa5gYNxfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=TF2yb9Pd; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 53BE56034E;
	Wed,  4 Mar 2026 22:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772659808;
	bh=WPDgNJcwl7Ca0jYKyCMbdcTrP5sluCDrBPggfklFv4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TF2yb9PdM3WJzzzLKi7BWqFZcX3DAKNnYsyxz38/daxLk/17qy17dJSAWWF3Sh5vW
	 7vPcct8pLxHTGPmke3K3sXEPyjk7Shx6bS7AB99XOQiZ3XlqvL0Jvz1MgJb0MDV/lH
	 /sAYka0xYpvLYrQejZART1cCzmeTm/yddDBgO5EEcucPCzkod+gIg711tVUr2hDrz6
	 4uju/QWbiiQsuWnjJ8iIZfZikeDa5MZBfrlSwb6CVWAfcU0/TVAfcsp0iQbPG8az2s
	 1YNTebFN7ceQBi+MXzPEm+OtywoqaA+fH/TusDcgxUAXFZ95CoMrkn9UyTeKNRkLc3
	 aOggQMEbPSJrg==
Date: Wed, 4 Mar 2026 22:30:05 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Natarajan KV <natarajankv91@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH v3 6.6.y 0/8] netfilter: nft_set_pipapo: move clone
 allocation to insert/removal path
Message-ID: <aaikXUL4AyJuPcrs@chamomile>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com>
 <2026030421-grunt-raft-15f0@gregkh>
 <1772643278.pipapo-v3.0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: CC5AA207FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-223139-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

Thanks for your series.

Please, hold on on this series until someone authoritative on
Netfilter can review this.

On Wed, Mar 04, 2026 at 08:54:38PM +0400, Natarajan KV wrote:
> This is a backport of the following mainline series to 6.6.122:
> 
>   a590f4760922 ("netfilter: nft_set_pipapo: move prove_locking helper around")
>   80efd2997fb9 ("netfilter: nft_set_pipapo: make pipapo_clone helper return NULL")
>   8b8a2417558c ("netfilter: nft_set_pipapo: prepare destroy function for on-demand clone")
>   6c108d9bee44 ("netfilter: nft_set_pipapo: prepare walk function for on-demand clone")
>   c5444786d0ea ("netfilter: nft_set_pipapo: merge deactivate helper into caller")
>   a238106703ab ("netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone")
>   3f1d886cc7c3 ("netfilter: nft_set_pipapo: move cloning of match info to insert/removal path")
>   532aec7e878b ("netfilter: nft_set_pipapo: remove dirty flag")
> 
> The pipapo set backend currently calls pipapo_clone() from the commit
> and abort callbacks. These callbacks must not fail, but pipapo_clone()
> can fail with ENOMEM. When this happens, the working copy ends up in a
> corrupt state: freed elements remain accessible, and the dirty flag stays
> set, causing the next commit to promote a stale clone.
> 
> This series moves pipapo_clone() to the insert and removal paths via a
> new pipapo_maybe_clone() helper that creates the working copy on demand
> and can propagate -ENOMEM to the caller.
> 
> Patches 1-4 cherry-pick cleanly from mainline.
> Patches 5-8 are adapted for 6.6.122's different API:
>  - nft_pipapo_flush() still uses the pipapo_deactivate() helper
>    (mainline removed it via the elem_priv refactor)
>  - pipapo_get() has no GFP parameter (always GFP_ATOMIC)
>  - nft_pipapo_commit() is non-const in 6.6.x
> 
> Build-tested with both nft_set_pipapo.o and nft_set_pipapo_avx2.o.
> 
> Florian Westphal (8):
>   netfilter: nft_set_pipapo: move prove_locking helper around
>   netfilter: nft_set_pipapo: make pipapo_clone helper return NULL
>   netfilter: nft_set_pipapo: prepare destroy function for on-demand clone
>   netfilter: nft_set_pipapo: prepare walk function for on-demand clone
>   netfilter: nft_set_pipapo: merge deactivate helper into caller
>   netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
>   netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
>   netfilter: nft_set_pipapo: remove dirty flag
> 
>  net/netfilter/nft_set_pipapo.c | 196 +++++++++++++++++---------------
>  net/netfilter/nft_set_pipapo.h |   6 --
>  2 files changed, 107 insertions(+), 95 deletions(-)
> 
> -- 
> 2.39.5

