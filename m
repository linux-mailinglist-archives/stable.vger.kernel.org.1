Return-Path: <stable+bounces-273750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I+bWOBHqVGpKhAAAu9opvQ
	(envelope-from <stable+bounces-273750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:37:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF974BAE9
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ix3MMdiK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273750-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273750-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DC83084717
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F357242B301;
	Mon, 13 Jul 2026 13:25:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119DF42B30B;
	Mon, 13 Jul 2026 13:25:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949139; cv=none; b=cFs40Zo70bi5QqSrucTlCbFsaYcrxT/AbPX9jx1RNjHJOO3vONdpP3zVCubfjgEuvWHm4f4x0IAzZC1xBNc1wDXkZ+XQYfObtO+rBk8/n5CvgJAKKgF+rQffhOA4USrQY2fWCNNb6AEhzsvBogaXykGLSm17RfZBvQCDLpRDeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949139; c=relaxed/simple;
	bh=4p4pOqHPR/FSXAycf5Ox3xWUt3hHCsh48CCppunVf/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il4+ocD+OTUwZo6NAcKDLXB5tUEgwF3cfrodSNjpG+8KMaKYcZcCiTLG0c5C+KSLKttY4rV3C3BgVTxAgcFJae+1aiuSnGyIkUcWApiALjzlGi+9WaM104ftwt0ZVOY1gCPWJPyfX2A+sRCyDcxIPn0S8UkTyK54B/JcxFczzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ix3MMdiK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6341D1F000E9;
	Mon, 13 Jul 2026 13:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783949137;
	bh=Gy/cfC9eWSI/4w83EWhj+5TaSyCxLCsDNooQU9g7aCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ix3MMdiKvNSDH1QKARVBfMh230lzDNqULteYdKoRLu+kj4TBW0nXjt5LZXKm71YNZ
	 OfzCXxpC1msmJNB9OnvOSolywlOVzc03JCLnUrRt60hAafrXur6pgFwUXFgRtJZaO3
	 VKz3ogHoYS6xtxGcEnRdCnOwD8tpKzBvzPIsYsUI=
Date: Mon, 13 Jul 2026 15:19:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: demiobenour@gmail.com, Russell King <linux@armlinux.org.uk>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drivers/crypto: Mark QCE as BROKEN
Message-ID: <2026071312-prowler-expectant-8294@gregkh>
References: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com>
 <2026071312-uncover-refining-8cac@gregkh>
 <20260713130745.GA2254@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713130745.GA2254@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273750-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,gondor.apana.org.au,davemloft.net,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:demiobenour@gmail.com,m:linux@armlinux.org.uk,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93CF974BAE9

On Mon, Jul 13, 2026 at 09:07:45AM -0400, Eric Biggers wrote:
> On Mon, Jul 13, 2026 at 06:47:07AM +0200, Greg KH wrote:
> > On Sun, Jul 12, 2026 at 05:31:31PM -0400, Demi Marie Obenour via B4 Relay wrote:
> > > From: Demi Marie Obenour <demiobenour@gmail.com>
> > > 
> > > This driver is harmful:
> > > 
> > > - It is much slower than the CPU [1] [2].
> > > - It Has a history of bugs [2] [3].
> > > - It does not have exclusive access to the hardware [4], causing races
> > >   with the secure world.
> > > - It register its implementations with too low a cra_priority for them
> > >   to be actually used [5].
> > > 
> > > Therefore, disable it to ensure that nobody builds it into kernels they
> > > intend to ship.
> > > 
> > > In the future, the driver will be used for processing restricted media
> > > content.  However, the kernel does not currently support this.  Since
> > > the driver will have future uses, allow building it if COMPILE_TEST is
> > > enabled.
> > 
> > Why not just delete it now, and then bring it back when it is needed in
> > the future?  Otherwise this will just trip up the static code checkers
> > who will attempt to "fix" things in it.
> 
> That makes sense to me, but Qualcomm pushed back on deletion:
> https://lore.kernel.org/linux-crypto/20260602-qcom-qce-broken-v1-1-a4ef756089e0@oss.qualcomm.com/
> 
> But I've still not seen any evidence that this driver is useful for
> anything or has any users.  Even Qualcomm seems to be unwilling to make
> such claims; they only claim that the IP is used (i.e., not in Linux)
> and that new features are planned.

Well we don't normally have drivers that are marked as BROKEN just
laying around in the tree these days, especially given that a LLM is
bound to do a drive-by and find lots of issues that people will not
realize doesn't matter given that the code is never actually built.

But hey, it's not my subsystem, if you want to keep it here, fine with
me, just asking :)

thanks,

greg k-h

