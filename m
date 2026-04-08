Return-Path: <stable+bounces-233900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHkcBJZW1mn5DwgAu9opvQ
	(envelope-from <stable+bounces-233900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:22:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A393BCC66
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38480300736E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950882F3614;
	Wed,  8 Apr 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYRavq7a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAB883F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654148; cv=none; b=D/XfaDf0pffcazO+XHeUcsE9nq0FrOF0zxBhk+m6d07pg4paGHkm45WAvfvUSUZz9rVHJzr4FlS2bRH3iOITru5xynKSVpf93acor5gcxPV0+3X094lQg4u+osbMroEW98LKvzIbHUGlSyv7TMTOOj/gQwWHsfe3iW8SP8UQpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654148; c=relaxed/simple;
	bh=He6k9YHgsNZAbANbinQhe3adqfEFj9WlK61paEYgn58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdisRPmDOV3Lm+hCHiN8yBl3HUvqMwei+fPu4nmNRw+xUogFWqGyngjDV3b/2S8KQac6OAGvrp3HJVWHio00/omB+xmtG3OIBnx7pzFiOP2AXIxZTVuHPGwvv3jyGwveNvm8cpdhjd3VIL2liKEEaSOLsYdV99jZ3JooPKmYBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYRavq7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C1C19421;
	Wed,  8 Apr 2026 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775654148;
	bh=He6k9YHgsNZAbANbinQhe3adqfEFj9WlK61paEYgn58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYRavq7aYRAPJuI5L4BySmrVR9Zmj+XDI3fWnWMWCKgKisSV06/nBINCAyTmOGHdB
	 FIO3RjsCo45krc1EdxZiOKBSlu8B+D9+Sy8Uen9xLphkzYeZxc+3qrfCcya7ZpxYK7
	 Rst/p8c4a9UvR0fZjK9ehowrkuWuHzJoQV6fOxAo=
Date: Wed, 8 Apr 2026 15:15:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Natarajan KV <natarajankv91@gmail.com>
Cc: stable@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de
Subject: Re: [PATCH v3 6.6.y 1/8] netfilter: nft_set_pipapo: move
 prove_locking helper around
Message-ID: <2026040804-portly-tremble-d2ea@gregkh>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com>
 <2026030421-grunt-raft-15f0@gregkh>
 <1772643278.pipapo-v3.0@gmail.com>
 <1772643278.pipapo-v3.1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1772643278.pipapo-v3.1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233900-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,netfilter.org:email]
X-Rspamd-Queue-Id: A6A393BCC66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 08:54:46PM +0400, Natarajan KV wrote:
> Preparation patch, the helper will soon get called from insert
> function too.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nft_set_pipapo.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

You forgot to include the git id of the upstream commit, AND most
importantly, you did not sign off on any of these commits, which is
required when you are passing on patches from others.

And you lost the original authorship?

thanks,

greg k-h

