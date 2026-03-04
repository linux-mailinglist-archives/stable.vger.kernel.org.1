Return-Path: <stable+bounces-223072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOMGKAw6qGkTqgAAu9opvQ
	(envelope-from <stable+bounces-223072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:56:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4E0200CF5
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21EA30ADBB1
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FB030E0E5;
	Wed,  4 Mar 2026 13:50:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B3269D18
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632217; cv=none; b=tiVpr1IhdbjzuPUWcJ3q/mOCI54sSfTIRalwVZHF+tG+ok5Q9Y6rokkGE03Vf7nj7A+G9oJ4GhUcj10V4uCUx9iQJizeIu4X6cd1vV7EZxWaLlJlNkbspcuFvJS7gsAxc+xMe+0Md030SYB/TvpazeZQJJfCw6K6EHcgUtWYgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632217; c=relaxed/simple;
	bh=oUCBHwoYpdLB/hcFTz8xMw46AcE2qwmnTC+aNLoCrbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKn1tDMdL0gTDdRMzWh9T4kcXyM6ipoTJ3x4oriChnOlkDBqiG/sgu8prGvkuBpBwi/4EzZ2nclYWTQzpLnD/pRfCGZvI9/hCaPNlB7oYEEJdMLsy1FwUSFQdsW5sZ8+whydFoxPVosnSNDRjSgT903es/3OxQCD2j6pR1vvLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 43A42602AB; Wed, 04 Mar 2026 14:50:14 +0100 (CET)
Date: Wed, 4 Mar 2026 14:50:14 +0100
From: Florian Westphal <fw@strlen.de>
To: Natarajan KV <natarajankv91@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, pablo@netfilter.org,
	kadlec@netfilter.org
Subject: Re: [PATCH] netfilter: nft_set_pipapo: clear dirty flag on
 abort/commit clone failure
Message-ID: <aag4luW2YDNSqghr@strlen.de>
References: <20260304133859.28372-1-natarajankv91@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304133859.28372-1-natarajankv91@gmail.com>
X-Rspamd-Queue-Id: 4B4E0200CF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223072-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.021];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Natarajan KV <natarajankv91@gmail.com> wrote:
> nft_pipapo_abort() and nft_pipapo_commit() call pipapo_clone() which
> can fail under memory pressure. When this happens, the functions return

> diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
> index 4274831b6e67..34a108399fd3 100644
> --- a/net/netfilter/nft_set_pipapo.c
> +++ b/net/netfilter/nft_set_pipapo.c
> @@ -1708,8 +1708,10 @@ static void nft_pipapo_commit(struct nft_set *set)
>  		return;
>  
>  	new_clone = pipapo_clone(priv->clone);
> -	if (IS_ERR(new_clone))
> +	if (IS_ERR(new_clone)) {
> +		priv->dirty = false;
>  		return;
> +	}
>  
>  	priv->dirty = false;
>  
> @@ -1743,8 +1745,10 @@ static void nft_pipapo_abort(const struct nft_set *set)
>  	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
>  
>  	new_clone = pipapo_clone(m);
> -	if (IS_ERR(new_clone))
> +	if (IS_ERR(new_clone)) {
> +		priv->dirty = false;
>  		return;
> +	}

As I said, I don't think this really helps.  Cloning must only happen
in locations where we can still reject the transaction, e.g. during
insert or delete operations.

