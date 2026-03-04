Return-Path: <stable+bounces-223071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAJ3Gvw4qGkTqgAAu9opvQ
	(envelope-from <stable+bounces-223071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:51:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA0200BAA
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9198F3022604
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364C17B50F;
	Wed,  4 Mar 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J5Fk6POe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752156472
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632089; cv=none; b=GbelCIdl/8xWYMXq8H8Yu+A/7mXu8e4wJgHV7RZyZFwbsUneNTsvWtwmT5UbnRONVIhNiHT9r2cjexhVdnViXkkXvLDUnJTUPFf95Z5kqw9Do0gtkkBPIit3gqGzzZ5BglYDAxoTrx2OLtBQlAXma16sqnrIsIComeTwhy99PhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632089; c=relaxed/simple;
	bh=G10+EM/oseOya7uub/uHIIzvsDeITuYQcq6og1Lpc1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWhbAtSPlu72RmqWNstyxEUH+YRNH0+Q6y+1PVv/sEI3GIrg1md6U5lYx2S2+YvkKYhDV2Le26Z5k4OQMR4GY06401CdAJppoCmK7mExMTopq+5vkGu0njwAGFI3KwXVcrqBHVuse77uGR8UWVCjx1ySijjFoHPcoxSyDXOPNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J5Fk6POe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1E8C2BC87;
	Wed,  4 Mar 2026 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772632089;
	bh=G10+EM/oseOya7uub/uHIIzvsDeITuYQcq6og1Lpc1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5Fk6POehWeJfEZRj5AFi62IV7tmLgYVUxvlkoiTfhT6DX/dhiEX+3HE4TsbaeEDA
	 2MnTq2JxMekXyM6AsNJHnbX7piU1YmKaPh7HRtsLNJd3setm+FqkhWh9YF3wJGRpWU
	 Xxl3pVQoe4T6FQlh6K+zYD7QCUmMivNoltBo3BSQ=
Date: Wed, 4 Mar 2026 14:47:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Natarajan KV <natarajankv91@gmail.com>
Cc: stable@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de
Subject: Re: [PATCH] netfilter: nft_set_pipapo: clear dirty flag on
 abort/commit clone failure
Message-ID: <2026030450-smoky-joystick-5bd5@gregkh>
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
X-Rspamd-Queue-Id: BEDA0200BAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223071-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:38:59PM +0400, Natarajan KV wrote:
> nft_pipapo_abort() and nft_pipapo_commit() call pipapo_clone() which
> can fail under memory pressure. When this happens, the functions return
> early without clearing priv->dirty. Since the set_ops->abort callback
> returns void, the nf_tables framework cannot detect this failure.
> 
> The stale clone, which still contains modifications from the failed
> transaction, persists with dirty == true. On a subsequent commit,
> nft_pipapo_commit() sees dirty == true and promotes the stale clone
> to the active match via rcu_assign_pointer(), causing the lookup data
> to reflect operations that should have been rolled back.
> 
> This can lead to incorrect packet matching (firewall rule bypass),
> memory leaks from unreachable elements, and potential use-after-free
> if elements freed by the framework are still referenced through
> stale clone mapping tables.
> 
> In mainline, this was resolved by commit 212ed75dc5fb ("netfilter:
> nf_tables: integrate pipapo into commit protocol") which refactored
> pipapo to use dedicated set commit/abort ops, eliminating
> pipapo_clone() from the abort path entirely. That refactor touches
> 3 files and modifies the nf_tables framework, making it too invasive
> to backport to stable branches.
> 
> Fix this minimally by clearing priv->dirty when pipapo_clone() fails
> in both nft_pipapo_commit() and nft_pipapo_abort(), preventing stale
> clone promotion on subsequent commits.
> 
> Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Natarajan KV <natarajankv91@gmail.com>
> ---
>  net/netfilter/nft_set_pipapo.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
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
>  
>  	priv->dirty = false;
>  
> -- 
> 2.34.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

