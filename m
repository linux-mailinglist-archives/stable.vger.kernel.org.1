Return-Path: <stable+bounces-273902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YmJUM6kgVWokkQAAu9opvQ
	(envelope-from <stable+bounces-273902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:30:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC374E06A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=SQpHgpa6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273902-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273902-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05F71300B28E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92322349B0A;
	Mon, 13 Jul 2026 17:30:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76933F394;
	Mon, 13 Jul 2026 17:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963808; cv=none; b=RDqggmIf/b1cU4CIgpOg3aL8WJf7lu7UxJA9U6Tm1MzGTTolR1zxjQzZ6istVsGpuAKuOA7Ex2E41Vq1l4unS+Hi/whSYBr/ZWkEOod9F3daYLHd7NTKbe1dPDEptPj5vF1fLS1DnP6x4Nvm04YU7BZ+/seflY/02rxEyl90e1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963808; c=relaxed/simple;
	bh=nCBADfPl5UsjVCRyiNTCceL+P86FRzL33UOwfs8iADs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emyvNi+gBVdQ2x4xxX8Tcud1VZDrlxSgG5GZKZXatFCpD9Bm+Q2kNkfsBTU4ouwzxTaGfJa4hppVlsyoP7pb7Me2KW66wTO7x0qGCpDk/pW6rwtT3MduvHBFV2JXd94zPA4WVtnKgxmlxHKxiFUrmecPhbVknKQfUm1aGCn3Si8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQpHgpa6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F4D1F000E9;
	Mon, 13 Jul 2026 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783963807;
	bh=N/4PU6ql3rOySt5KicKXIt7AV1IpkBb2vzqjVBjyUR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SQpHgpa6Bddqrt5e4wZBV5qUJS3Mhqs53xW1KXK4/OcQaWxYSrlffGG0+7RJ7Ff5P
	 Ilr/w47ByeZ1JoKIacFgU18uOHaDmXxfIFNJ2cipARFf8egODA7qnw8Yts2sakC5TK
	 esMNDaPE4rdcf/jk1JKik1hAZ/Kq1yhOKl+zjMl0=
Date: Mon, 13 Jul 2026 17:31:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drivers/crypto: Mark QCE as BROKEN
Message-ID: <2026071320-encode-modify-6193@gregkh>
References: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com>
 <2026071312-uncover-refining-8cac@gregkh>
 <20260713130745.GA2254@quark>
 <bd5821b9-7459-4db4-86ef-bd67fb645753@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5821b9-7459-4db4-86ef-bd67fb645753@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:demiobenour@gmail.com,m:ebiggers@kernel.org,m:linux@armlinux.org.uk,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-273902-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3BC374E06A

On Mon, Jul 13, 2026 at 10:42:04AM -0400, Demi Marie Obenour wrote:
> On 7/13/26 09:07, Eric Biggers wrote:
> > On Mon, Jul 13, 2026 at 06:47:07AM +0200, Greg KH wrote:
> >> On Sun, Jul 12, 2026 at 05:31:31PM -0400, Demi Marie Obenour via B4 Relay wrote:
> >>> From: Demi Marie Obenour <demiobenour@gmail.com>
> >>>
> >>> This driver is harmful:
> >>>
> >>> - It is much slower than the CPU [1] [2].
> >>> - It Has a history of bugs [2] [3].
> >>> - It does not have exclusive access to the hardware [4], causing races
> >>>   with the secure world.
> >>> - It register its implementations with too low a cra_priority for them
> >>>   to be actually used [5].
> >>>
> >>> Therefore, disable it to ensure that nobody builds it into kernels they
> >>> intend to ship.
> >>>
> >>> In the future, the driver will be used for processing restricted media
> >>> content.  However, the kernel does not currently support this.  Since
> >>> the driver will have future uses, allow building it if COMPILE_TEST is
> >>> enabled.
> >>
> >> Why not just delete it now, and then bring it back when it is needed in
> >> the future?  Otherwise this will just trip up the static code checkers
> >> who will attempt to "fix" things in it.
> > 
> > That makes sense to me, but Qualcomm pushed back on deletion:
> > https://lore.kernel.org/linux-crypto/20260602-qcom-qce-broken-v1-1-a4ef756089e0@oss.qualcomm.com/
> > 
> > But I've still not seen any evidence that this driver is useful for
> > anything or has any users.  Even Qualcomm seems to be unwilling to make
> > such claims; they only claim that the IP is used (i.e., not in Linux)
> > and that new features are planned.
> > 
> > - Eric
> 
> Here is my reading of Qualcomm's statements:
> 
> QCE is currently used by the Arm secure world.  In the future, QCE
> will be used by the kernel as part of restricted content playback.
> Qualcomm wants to add the needed features to the existing driver.
> This will not use the crypto API.

Why is a crypto driver not going to use the crypto API?

> I would be fine with the driver being removed, but not if it means
> another out-of-tree Android driver.

It's not another out-of-tree Android driver if nothing in Android
actually uses it :)

thanks,

greg k-h

