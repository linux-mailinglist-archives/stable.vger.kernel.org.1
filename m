Return-Path: <stable+bounces-270532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0W73HNpyRmoBVQsAu9opvQ
	(envelope-from <stable+bounces-270532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB96F8C96
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:16:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TCT7nv6Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270532-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270532-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3811F30C84DE
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10D4C77A4;
	Thu,  2 Jul 2026 14:11:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C481FB9
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 14:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001464; cv=none; b=lHKU4gbjjRIB7NJsdpTGsFx/5TA1JD6mEHHwD3VmYoVw6vCS0tv42+ooMwxTRYrK36QXqsaSGVF7ouT8aIyoQ4g5FUXmBmxo1NJ9In5SO5kAlafKs9NChhNG6TZPYR4HxcQ6sMV16MILKiFsEm4GvDzt9C6Mpr9W5SIQnYsu+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001464; c=relaxed/simple;
	bh=Ve7taSANLZuMYoPDi3+82QT4KBdCFgR0shejjYB7kY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpjIjZecGSk4j6aSkQr8lMzeNAlu6JQKPKSpq33HU3NrTMYM86R34ewE5O4ea26FFJzeNi7LwYajkxBTO9iXAKPmeGH1GIJn9Pf8cdaPeMzhNlgCCl+hiLEl+Ax/DcejTPxawQ5gZ5IyHLRLMZRocn4FNuHsQ7hH6oamy7wvd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCT7nv6Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B751F000E9;
	Thu,  2 Jul 2026 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001462;
	bh=eGN0W9GqOz+nTHlByNW+rSC+GtM2Q7ANNhzo3cBVLxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TCT7nv6ZJK04r7SlRBVwdWAOw5vhfcXg9oBSIgrQCLeR/5IVs8sXPjpvpPDwGnzlA
	 ulnzSuQJhkScm77eNGaEt8zK3ZcBv2z6oRU04E41iujQ85yJDODnoSr13yDMz5rPLu
	 UmMiMkfMLz/glciTOR+VrtZYLPTz/gzZ7rsCHD6I=
Date: Thu, 2 Jul 2026 16:11:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: stable@vger.kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
	mwalle@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 6.6.y v2 0/2] mtd: spi-nor: macronix: backport Quad Input
 Page Program fixups
Message-ID: <2026070239-proponent-lazily-990a@gregkh>
References: <20260702021842.2771498-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702021842.2771498-1-linchengming884@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linchengming884@gmail.com,m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270532-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mxic.com.tw:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0FB96F8C96

On Thu, Jul 02, 2026 at 10:18:40AM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> This is a backport of two upstream commits to 6.6.y:
> 
>   commit 798aafeffb36 ("mtd: spi-nor: macronix: Add post_sfdp fixups
>   for Quad Input Page Program")
>   commit 797bbaa7531f ("mtd: spi-nor: macronix: add support for
>   mx66{l2, u1}g45g")
> 
> Neither commit was tagged for -stable when merged. 6.6.y also predates
> commit 09e5a29fa3ad ("mtd: spi-nor: macronix: convert flash_info to new
> format"), which landed in v6.10, so drivers/mtd/spi-nor/macronix.c is
> still in the old INFO()/NO_SFDP_FLAGS()/FIXUP_FLAGS() macro-based
> format. Both patches have been adapted to that format with no other
> functional change; patch 2 depends on the macronix_qpp4b_fixups hook
> introduced by patch 1.

Why not just move to a newer kernel to get support for these newer
devices instead?  That's much simpler and I'd prefer that over taking
much-different patches instead.

thanks,

greg k-h

