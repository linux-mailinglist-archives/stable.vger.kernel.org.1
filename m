Return-Path: <stable+bounces-223082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IbdM8ROqGmvsgAAu9opvQ
	(envelope-from <stable+bounces-223082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:24:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E2403202990
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3CE7303ADBB
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC25C946A;
	Wed,  4 Mar 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVVSlH9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90426ED4F
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637179; cv=none; b=Qe4QoXKUX3JWtea4L/uzIFJKyI+UVhnxnliTeaTq+EXS3b0VhKdVwIqeletSbI+3Np35zRqqphx0MvqXyBXUTxuIysD8gj8G2xG6Dt7i+fw0PT36yYSsgeCTFO8HMzDGIRwS4N8xvG6Q0EqxRYBvgTrrI1lWMHeD5QkGKVz4C4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637179; c=relaxed/simple;
	bh=af6cYoJytGkhhXoK0ltQ4A8+u7Bj81lkGekPMIgSQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS2xWxE+irPDq4MJ2QHwp4WE3IJOSJ9ChrV7WyHU8ESnvjABz4kmbvn0QxrRbJ97IQaXhu55AJxRsUa1ZaWoMDtLvb1mgpxj+mB74QLh0+1DCJvNZlav5HuizS71Xsx5ft+9pAhgYiTLl+Ipq+IgtfqwohO+FOXxNT/tBEdrUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVVSlH9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF15CC4CEF7;
	Wed,  4 Mar 2026 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772637179;
	bh=af6cYoJytGkhhXoK0ltQ4A8+u7Bj81lkGekPMIgSQNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVVSlH9bK3dKCbY9NGX7J1/AQt6gwUWRr4swq9R+8Zlq6G+dKMTLsSP1w6lQl9+Wc
	 jAxIemQ+V0iMlzRs1O/8SNd5Hec35pfGgiZ00ykTBF9BJJvAt/2q9CniFlT2BVNa+q
	 W/Im2Cb416MR6zr3K/MbyWYHX5t1ZGa4WtSyDgkk=
Date: Wed, 4 Mar 2026 16:12:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Natarajan KV <natarajankv91@gmail.com>
Cc: stable@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de
Subject: Re: [PATCH v2] netfilter: nft_set_pipapo: move clone allocation to
 insert/removal path
Message-ID: <2026030421-grunt-raft-15f0@gregkh>
References: <20260304133859.28372-1-natarajankv91@gmail.com>
 <69a84adc.050a0220.1cea47.3011@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a84adc.050a0220.1cea47.3011@mx.google.com>
X-Rspamd-Queue-Id: E2403202990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223082-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:08:12AM -0800, Natarajan KV wrote:
> Move pipapo_clone() from the commit/abort callbacks to the
> insert and removal paths via pipapo_maybe_clone(), which creates
> the working copy on demand and can propagate allocation failures.
> 
> Previously, pipapo_clone() was called from nft_pipapo_commit() and
> nft_pipapo_abort() which return void, making it impossible to
> report allocation failures. When pipapo_clone() failed during abort,
> the stale clone persisted with dirty == true, causing subsequent
> commits to promote a clone containing freed element references --
> a use-after-free.
> 
> With this change:
>  - pipapo_maybe_clone() allocates the clone lazily on first insert,
>    deactivate, walk(UPDATE), or remove. Allocation failure returns
>    NULL and propagates -ENOMEM to the caller.
>  - nft_pipapo_commit() simply swaps clone to match and sets clone
>    to NULL. No allocation needed.
>  - nft_pipapo_abort() simply frees the clone and sets it to NULL.
>    No allocation needed.
>  - The dirty flag is removed; clone != NULL indicates pending changes.
>  - nft_pipapo_init() no longer pre-allocates a clone.
> 
> This is a backport adaptation of the mainline on-demand clone refactor
> series from commit a590f4760922 ("netfilter: nft_set_pipapo: move
> prove_locking helper around") through commit 532aec7e878b
> ("netfilter: nft_set_pipapo: remove dirty flag") to the 6.6.x
> stable tree, preserving the 6.6.x function signatures and API
> conventions.


I would prefer to take the backport of these 6 patches.  That's not many
at all, we've taken series much much larger than that in the past.  That
way we can properly track and document exactly what commits get
backported to where, to make fixes and bug tracking easier.

So can you send the full series and not just one patch?

thanks,

greg k-h

