Return-Path: <stable+bounces-237726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMP0D5XU3WnfjwkAu9opvQ
	(envelope-from <stable+bounces-237726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:45:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE563F5CB1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16B79300DCD5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51FB324B23;
	Tue, 14 Apr 2026 05:45:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467B282F1B;
	Tue, 14 Apr 2026 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145549; cv=none; b=IXAMaN86RY/wN5QIlfUfx3791br7TfY9mXHdGIT7sVT2yES7NMg9Bx71Y1dRBRy9Nm1QUZf3rSNTrE1pe6cF5Jx1qpLZfuAaDD5YMGWZ/8qsLwqvTb9CldsN6h8jofwdCnJ2qBbQpQXr827VfXr7UXvzCIFTVfAfzBrTSI8Ib1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145549; c=relaxed/simple;
	bh=h/0SmEXZ0QK4rok0JqrXdt5TO0dmhnBhwH0/E32rHqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbEXBjBXrEWsps9OyM8H6BURqdAxidcDJ3lPaqlM35RlX2MNmVs9FOHGzlw1OANkDbeA3P2H1yD6rNJ+kPnWkfm6eJgTSIs2qXtZM7hMK+IpFFfLKUPBJbxRkotlNr6Dui2IXMzgZTGHU6OoOWbS+yMuszVOYErDGt58qzuP6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 81E87C2B;
	Tue, 14 Apr 2026 07:45:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 44B32600B21B; Tue, 14 Apr 2026 07:45:39 +0200 (CEST)
Date: Tue, 14 Apr 2026 07:45:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Alexandre N." <an.tech@mailo.com>
Cc: Bernd Schumacher <bernd@bschu.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	1131025@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
Message-ID: <ad3Ug9NK3bgStlE4@wunner.de>
References: <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
 <ac_VqcBbKRDkHp69@wunner.de>
 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
 <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
 <adxlr9lWBTZIQMev@wunner.de>
 <f55cb406-4a49-462d-b933-48303b32c014@mailo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55cb406-4a49-462d-b933-48303b32c014@mailo.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: CAE563F5CB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:01:17PM +0200, Alexandre N. wrote:
> On 4/13/26 05:40, Lukas Wunner wrote:
> > Could both of you, Alexandre and Bernd, give that patch a spin
> > to see if it fixes the issue?
> 
> I confirm that your last patch alone applied to 6.19.11
> works in my case! (no need for 4d4c10f763d7 nor 907a7a2e5bf4)
> 
> Now my host and guest behave like on 6.18.9, including removing the
> pci-stub.ids line from my kernel command line since the automatic
> handover between ahci <--> vfio-pci is working again.

Thanks a lot, glad to hear that.

I'm curious what you did so that 4d4c10f763d7 wasn't sufficient
to fix the issue.  I'd be grateful if you could provide full dmesg
output for analysis of a non-working kernel with this debug patch
applied:

  https://lore.kernel.org/all/acvIfI3naoGsOpFE@wunner.de/

and with the following added to the kernel command line

  log_buf_len=16M dyndbg="file drivers/pci/* +p"

and with this option enabled in .config:

  CONFIG_DYNAMIC_DEBUG=y

That would allow me to amend the commit message of the patch with
a better explanation why simply backporting 4d4c10f763d7 is not
sufficient as a fix.

Thanks!

Lukas

