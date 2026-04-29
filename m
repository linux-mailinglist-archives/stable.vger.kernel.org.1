Return-Path: <stable+bounces-241867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CQXAWrp8WmalQEAu9opvQ
	(envelope-from <stable+bounces-241867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E124936C0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00EB30401A5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A63DE447;
	Wed, 29 Apr 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6LIqHlT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D82F12AF;
	Wed, 29 Apr 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461590; cv=none; b=aEDD/fYaHWhNFpt2bakA9isSLujfA7PoiauumnsULYSgdjFCCbgwefTIFbw/cC5CPHXQtRj3JPkJAPTNRRwDl7ifECy37DblOLEIWxchubBsb0/S03t/yDPaGiZNCjQGfdmWMl0kvhgK+IQ/aIeTfGLpnydEIOfS/dJTyiHFzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461590; c=relaxed/simple;
	bh=BFQp+YQiBU8zErQRGXepU7rsL4fe06Njb4MCK2eRm7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+6HROJOiZ/kpkynHGZJaWaYfgjIQ5Qb+CweaUz68IUM+Pvozdpp+5wHgN5Vs1BT/eRnZ9nrq8XYicTTB2YhFQAt4xGeMqecaR/HIvV82OqaOugrlRsn/Eu0OZ+JgN2p3eO95hvjh7ZgFUk7BnFpg2w2mjQtbpmjzBRwkGmfpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6LIqHlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E48EC19425;
	Wed, 29 Apr 2026 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777461590;
	bh=BFQp+YQiBU8zErQRGXepU7rsL4fe06Njb4MCK2eRm7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6LIqHlTt752j4Ijg8+cfm+L1Cz1F1zeabJGOubkTLjZYLKlyoxGH9UatFyt9atUo
	 HL7ihp9GrgA3NR1bGCidsqoJQun96BFbz2bCHyklAYPgYOFME4y/UXRxL4rWUYWDIg
	 EO7KQQ7MGzInEOTLrvGCzw6CByLXM8N7ASbJKMymDA/jIvjScIZ+neEoyE5m3DCcK2
	 Cp+LmAMGaPqOpSwZNkpTx47mO1TlgHbHBFE3ZxVajcB2xwiyw8YuftrVEUcOmETuAV
	 61UX3/2IGuijsWDpiRdF9gm7gE7l4aHZP8MONurWVEwREJuFQclH5bgcI5hHuogTxM
	 xww1o2WQBoKZQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI2xH-00000000ioJ-3Gx5;
	Wed, 29 Apr 2026 13:19:47 +0200
Date: Wed, 29 Apr 2026 13:19:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Message-ID: <afHpUxQ5U_4RWjDZ@hovoldconsulting.com>
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
 <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
 <afHapCZz5C42euaD@hovoldconsulting.com>
 <DI5KV97TNS9D.28EQTYL46PKT1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5KV97TNS9D.28EQTYL46PKT1@kernel.org>
X-Rspamd-Queue-Id: 76E124936C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241867-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 12:47:53PM +0200, Danilo Krummrich wrote:
> On Wed Apr 29, 2026 at 12:17 PM CEST, Johan Hovold wrote:
> > On Wed, Apr 29, 2026 at 12:19:06AM +0200, Danilo Krummrich wrote:
> >> On Fri Apr 24, 2026 at 5:31 PM CEST, Johan Hovold wrote:
> >> > A recent change made the faux bus root device be allocated dynamically
> >> > but failed to provide a release function to free the memory when the
> >> > last reference is dropped (on theoretical failure to register the device
> >> > or bus).
> >> >
> >> > Fix this by using root_device_register() instead of open coding.
> >> >
> >> > Also add the missing sanity check when registering faux devices to avoid
> >> > use-after-free if the bus failed to register (which would previously
> >> > have triggered a bunch of use-after-free warnings).
> >> >
> >> > Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct device")
> >> > Cc: stable@vger.kernel.org	# 7.0
> >> 
> >> I think this is more of a theoretical issue, do we need this in stable trees?
> >
> > Sure, this is borderline, but given that autosel would probably pick it
> > up anyway we might as well mark it directly.
> 
> In such a case developers should probably give the stable team a hint that the
> patch in question does not need backporting.
> 
> But using the expectation that autosel may pick it up as a justification to mark
> it for stable in the first place seems wrong.

It fixes a memory leak (and some warnings). We backport such fixes all
the time, including in other error paths which are unlikely to ever be
hit.

> The stable documentation [1] is very clear that theoretical issues must not be
> backported into stable trees unless an explanation of how the bug can be
> exploited can be provided.
> 
> If that was relaxed in some way, it probably needs updating.

The stable rules have been relaxed in practice since Autosel. Anything
that looks like a fix (e.g. has a Fixes tag) gets backported.

And people get tired of asking the stable team to drop patches that were
not marked for backporting.

But feel free to drop the CC-stable tag here if you want to.

Johan

