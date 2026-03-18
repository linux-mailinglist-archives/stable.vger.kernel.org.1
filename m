Return-Path: <stable+bounces-227052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AID8CqqaumnaZQIAu9opvQ
	(envelope-from <stable+bounces-227052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:29:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F22BB7B8
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69006300AC82
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BC73D5649;
	Wed, 18 Mar 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZakMuvHZ"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABE35E926
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836965; cv=none; b=Mfzfi/p0iB17yiuyyZHngH5l8714C0A3O3G9qI0pQh+0gOxyCBPJU9EZCnmLi7DqGrlBd+G5TTJF8+DR2/E6Goyn8/3qMnUMoxZ1/rhpNMdJBLiJMw5kBytROeksCPUUix3VdlsTkvpbI2fIHObrU1QqDHRLmmheCS3MS1zZl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836965; c=relaxed/simple;
	bh=N0hZfNuCwxur62Dhe9eZWTzvJYSym3qOI+8A1UclxuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUQwXaO4QXZ+jrY11pCVnANBTcErV/BorWg9HBbKyy5mntNu/SrefpBEuv6Pl3DfC4O8AqSm7FZZzwyARIrtw5fjBEcVCSV2ellnkPbdZ0IUpfyvcrsGN4PBw/or/gZiGGSlLVJ9wDkIcLDR3Z8v6heAQr54sf186C6PFH4p77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZakMuvHZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Mar 2026 13:29:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773836959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2GdGv5dmSzHUDnW0c1bGqLqX8yfm9FaWipGd7a7als=;
	b=ZakMuvHZcfTJM3L6Wkc9KE1AUB/1Ew7nYxMs88YJKRah6rkshZIvI5lBOJ+KbphmKzb0Xf
	3zB5/PeFwg9qYZnSrwuP1aWN0WAVjogoczY9ikyWC0axJBaTFXzQvVai0OesQGs4P2Arnf
	XcyIZtX+dgnxheNY/rzZ82apQrzpc9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kim Phillips <kim.phillips@freescale.com>,
	Yuan Kang <Yuan.Kang@freescale.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - remove HMAC key hex dumps from
 hash_digest_key
Message-ID: <abqal8qyPbsmpM6p@linux.dev>
References: <20260306111204.302544-1-thorsten.blum@linux.dev>
 <abTqefme_iApfHZi@gondor.apana.org.au>
 <abk4_r-KUYIhvyNL@linux.dev>
 <abpYWkDzofozlOWp@gondor.apana.org.au>
 <abqUQxdoH7zuszZQ@linux.dev>
 <abqXgt5x232kEPUj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abqXgt5x232kEPUj@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227052-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 527F22BB7B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:16:02PM +0900, Herbert Xu wrote:
> On Wed, Mar 18, 2026 at 01:02:11PM +0100, Thorsten Blum wrote:
> >
> > My main concern is that with CONFIG_DYNAMIC_DEBUG enabled, which doesn't
> > require DEBUG, these raw key dumps can still be turned on at runtime in
> > a deployed kernel.
> > 
> > If we want to keep the dumps for debug-only kernels, then #ifdef DEBUG
> > plus print_hex_dump() might be a good compromise.
> 
> Exactly.  Having sensitive information printed with DYNAMIC_DEBUG
> is arguably a problem, but putting them behind DEBUG is definitely
> OK.

Ok, thanks.  I'll send a v2 soon using print_hex_dump() guarded by
#ifdef DEBUG.

