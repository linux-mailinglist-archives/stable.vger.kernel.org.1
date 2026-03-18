Return-Path: <stable+bounces-227103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH9hC57GummEbwIAu9opvQ
	(envelope-from <stable+bounces-227103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:37:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D926B2BE5E4
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2512730CCA19
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793AA29AB1D;
	Wed, 18 Mar 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b="Sg/fv/dS"
X-Original-To: stable@vger.kernel.org
Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7084294A10
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847829; cv=none; b=AsfjEedEjzQd+1tdtvyC/xcbRiLlw8Z7lTAUgvs56XkY3woeIUgNF6awrUK3eJ4nV5GjxdRSkBULxZ/EhJ4NhDiePCC5TMHWbKFtccsj5OQzbrbt0V6B1OqiTXx9/SOfeNtjUn7WFmJPQyJGUyo62tjBBGSrh/cQQqrUqTOQyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847829; c=relaxed/simple;
	bh=AKcunM3iWUh4cw3R/thVy83DnMENaqi/MzghhGnaspk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol21qobY86qvFfFx/dRpXQte1shzH6PyWdV9JpnySWlNgKoucx67WZACk8uwEUzwfxWPs34Z0iv3m4tPTj3mC4+i+mSWmzfdsB5pdmeCfqveoA+BQ9Ysr0ostg3yiZDmTQwuFXsXC2DG2JP6dLSGgr+yoh2Jo7ZQAlX1jBLsWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se; spf=pass smtp.mailfrom=ac2.se; dkim=pass (1024-bit key) header.d=ac2.se header.i=@ac2.se header.b=Sg/fv/dS; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ac2.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ac2.se
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id D93BD44B90;
	Wed, 18 Mar 2026 16:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ac2.se; s=default;
	t=1773847824; bh=AKcunM3iWUh4cw3R/thVy83DnMENaqi/MzghhGnaspk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg/fv/dSVqr5b2fCTEIBB7XstyCV9fllbXH1t8gBR3N3yi3NE+KKE6fCF6OmsxLXs
	 rL1C29i3zoO3P73F7qsfBrz8oWSq4uzC+T4YTbsj03IM9BNHCSnEZS8QItWruN1JdE
	 vIxGHxwAZ9ikNGIUfk7UGAW/qAzPrZ1zCqbXKRCg=
Received: by mail.acc.umu.se (Postfix, from userid 24471)
	id 64CDA44B91; Wed, 18 Mar 2026 16:30:24 +0100 (CET)
Date: Wed, 18 Mar 2026 16:30:23 +0100
From: Anton Lundin <glance@ac2.se>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCHv2] sign-file,extract-cert: use KBUILD_SIGN_PIN in
 provider mode
Message-ID: <abrFD67qPggeEUWs@accum.se>
References: <20260318090336.556068-1-glance@ac2.se>
 <6327e8c3d5828ac60c95a5b51c4bc17ec7f3d9f9.camel@HansenPartnership.com>
 <55cdec43cafe67dd632b665d18b1b5d423a749dd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55cdec43cafe67dd632b665d18b1b5d423a749dd.camel@HansenPartnership.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ac2.se,none];
	R_DKIM_ALLOW(-0.20)[ac2.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227103-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ac2.se:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glance@ac2.se,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,accum.se:mid]
X-Rspamd-Queue-Id: D926B2BE5E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18 March, 2026 - James Bottomley wrote:

> On Wed, 2026-03-18 at 10:44 -0400, James Bottomley wrote:
> > On Wed, 2026-03-18 at 10:02 +0100, Anton Lundin wrote:
> > > This adds support for the documented KBUILD_SIGN_PIN functionality
> > > to
> > > sign-file and extract-cert when built with USE_PKCS11_PROVIDER.
> > 
> > Why would you do this?  It's going to pop up a prompt for a password
> > for every module you have ... that can be hundreds to thousands in a
> > distribution kernel, so it's unscalable.  The usual way we do this is
> > to put the password into an environment variable (insecure but
> > scalable) but I suppose if you have a more secure solution there
> > might
> > be interest.
> 
> Sorry, ignore me.  I didn't read enough to see this is only plumbing
> our current environment variable method into the new store open API we
> use for providers which didn't pick up a password method.  However, the
> thought does occur: if the pkcs11 engine does this by an engine
> parameter, wouldn't the provider have an equivalent provider parameter?

There are OSSL_PROVIDER_add_conf_parameter, which are from OpenSSL 3.5,
which can set pkcs11-module-token-pin.

This code path has been activated from OpenSSL 3.0 and even when testing
with my local OpenSSL 3.5.5 I haven't gotten that to work.


Until recently I've had a patch in our local trees which just disables
the openssl provider parts and uses the engine api instead. In debian
bookworm the pkcs11-provider was too old to get anything working anyway,
and because of reasons that patch stuck around until now.


//Anton

