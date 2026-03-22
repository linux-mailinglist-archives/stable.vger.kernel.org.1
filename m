Return-Path: <stable+bounces-227821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o1Z8CdOqv2mu7QMAu9opvQ
	(envelope-from <stable+bounces-227821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:39:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF892E8A21
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B829300FC4A
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F430CDAB;
	Sun, 22 Mar 2026 08:39:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915772631
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774168781; cv=none; b=B2OcPb2UmXB6/QsFBMrbWZj584HosXodvgYq5fI6kejXL1Fz7DA+o4/yC6BT7xjo7x2crk/lSrOH9Ar8wj93pvOwgOHukRvO6C7qlft9nSoSS8xVCyomuTKljEsJqItXimbWzO1MQ3OIquSzM1+wgBBPLz4lmQ5/J1MZYngMwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774168781; c=relaxed/simple;
	bh=0944QCZlTawWsvM/m7Ifd4XZoBZklGZFcnup1iHsvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5uIJHdwHEhlV56UZSNL3mfk+yPQwG/cj8poocIX6cZ7ivwPbTD0L8J65m7GbvKVBUU+uOIONBMCI5VgyyeGhGq/tpdDDGtjuRgG7pOVNTRaeGM6FUSuQJsYcw4iF+mMNxrM8M/ZtuBlJoj8KRzcGSI85AehgTXFf41xRI7yIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E50986078E; Sun, 22 Mar 2026 09:39:30 +0100 (CET)
Date: Sun, 22 Mar 2026 09:39:30 +0100
From: Florian Westphal <fw@strlen.de>
To: bestswngs@gmail.com
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, xmei5@asu.edu, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: xt_devgroup: reject unsupported families
 in checkentry
Message-ID: <ab-qwvT576uYX6ny@strlen.de>
References: <20260322041844.983129-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322041844.983129-3-bestswngs@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[strlen.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 6CF892E8A21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> devgroup_mt_checkentry() validates hook_mask using NF_INET_* constants,
> but the match is registered with NFPROTO_UNSPEC, which allows it to be
> used from any protocol family through nft_compat.
>
> On an ARP nftables output chain, nft_compat passes
> hook_mask = 1 << NF_ARP_OUT. Because NF_ARP_OUT == 1 == NF_INET_LOCAL_IN,
> the source-group hook validation incorrectly accepts the rule. At runtime
> arp_xmit() invokes the chain with state->in == NULL, and devgroup_mt()
> dereferences xt_in(par)->group, crashing the kernel:
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000044: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
>  RIP: 0010:devgroup_mt+0xff/0x350
>  Call Trace:
>   <TASK>
>   nft_match_eval (net/netfilter/nft_compat.c:407)
>   nft_do_chain (net/netfilter/nf_tables_core.c:285)
>   nft_do_chain_arp (net/netfilter/nft_chain_filter.c:61)
>   nf_hook_slow (net/netfilter/core.c:623)
>   arp_xmit (net/ipv4/arp.c:666)
>   arp_solicit (net/ipv4/arp.c:393)
>   neigh_probe (net/core/neighbour.c:1098)
>   __neigh_event_send (net/core/neighbour.c:1277)
>   neigh_resolve_output (net/core/neighbour.c:1604)
>   ip_finish_output2 (net/ipv4/ip_output.c:237)
>   </TASK>
>  Kernel panic - not syncing: Fatal exception in interrupt
> 
> Reject families whose hook numbering differs from the NF_INET_* scheme
> early in checkentry. NFPROTO_INET and NFPROTO_BRIDGE share the same
> five-hook layout (PRE_ROUTING ... POST_ROUTING) and the same
> state->in/state->out semantics as IPv4/IPv6, so they are safe.
> ARP only has three hooks (IN=0, OUT=1, FORWARD=2) with different
> semantics, causing the numbering collision that triggers this bug.

I think we should solve this in x_tables.c so we don't have to ensure
all the .checkentry functions provide for this.
While this patch solves the specific module at hand, it begs
the question if the same bug pattern exist exlsewhere.

xt_check_match and xt_check_target should call a common
helper, this helper checks that if the match/target is UNSPEC
and has .hooks != 0, then the calling family is IPV4, IPV6 or BRIDGE.

All others can be rejected.

Would you make such a patch?

Thanks!

