Return-Path: <stable+bounces-272384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pGhbCdu+TGpbpAEAu9opvQ
	(envelope-from <stable+bounces-272384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:54:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E31719680
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:54:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2QrVnkOv;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272384-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272384-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B845B3027687
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0922380FDA;
	Tue,  7 Jul 2026 08:47:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695A23ED6F;
	Tue,  7 Jul 2026 08:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414066; cv=none; b=ZT1LnUSZsP/t9cXgC8xUIT4XnA/zFHfVr2kp78NfyO8eTSMzKcgfj4GNjDtTdkms3DVLp/cO3vRoxUUr//XKc29Ov6dCodVBh9jRhiz15Ltq67buJBa+IQvL+YOaBDy8431jQRNY0bsy4qqy46FUpTDZmud+5r2t7fQhAiVarHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414066; c=relaxed/simple;
	bh=qcK5ZwksY4PmnyEw1Uxw5s4nstgSFv4j/qsRE6ElsvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uClQKHGOd4GYOgjRl2Kv6eII7ht5FnY+PRlA6FM62s3144oC9PKAPcxHkkv7AhWxj8M1MeeRZjO984rqG1MpLfC4w6JOdcMEsJ1l1iR859ZWX833ZepNdZZTaX90MZ5hFkZzfUos7u+0gx6ckXGUsFkXf60lFq+Fm3NWlUBoUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2QrVnkOv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE651F00A3A;
	Tue,  7 Jul 2026 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783414065;
	bh=X9UaWalHIyP2bw67sTL4X7j/K+JWUj44P7QGkfhtp7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2QrVnkOvzHBzAGfd9bA1s9DgYzLfAX1fn495PMEPIMs6h2G+1BvwNm3qzLKeSRKA9
	 FktWo0ujb8kJkOPXRdDA/ZH3bZUZNr3hLrE2NLjVb3Aibz/f3dcfmg6QwvgFTTckSU
	 Lw+2QlTCpVocXgcyYpVekA0TWmzxn9SFMkYWS7/w=
Date: Tue, 7 Jul 2026 10:47:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Adin, Menachem" <menachem.adin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	lkp <lkp@intel.com>
Subject: Re: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Message-ID: <2026070722-zips-outgrow-ee43@gregkh>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
 <2026070608-reformat-pungent-aeb4@gregkh>
 <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
 <akypBhzJdxGLJiYq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akypBhzJdxGLJiYq@ashevche-desk.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:alexander.usyskin@intel.com,m:arnd@arndb.de,m:badal.nilawar@intel.com,m:linux-kernel@vger.kernel.org,m:menachem.adin@intel.com,m:stable@vger.kernel.org,m:lkp@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-272384-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63E31719680

On Tue, Jul 07, 2026 at 10:21:42AM +0300, Andy Shevchenko wrote:
> On Tue, Jul 07, 2026 at 06:43:20AM +0000, Usyskin, Alexander wrote:
> > > On Mon, Jul 06, 2026 at 04:01:30PM +0300, Alexander Usyskin wrote:
> 
> ...
> 
> > > > Cc: stable@vger.kernel.org
> > > 
> > > Why cc: stable?  It doesn't actually cause any functional change to the
> > > code at all, right?  This isn't running on s390, or am I mistaken?
> > 
> > This driver is for discrete graphics card, so it may run on non-x86 system, thus all conversions.
> > 
> > I've been told that if there is Fixes: for commit that already in stable, I should cc: stable.
> > If it is not hard rule, I'll drop cc: from the next patch revision.
> 
> Cc'ing stable@ is a rule which is documented in-tree. Many developers just omit
> it for unknown reasons.

My point is that this is NOT an actual bugfix that needs to be applied
anywhere except during the next merge window, as all it does is make
sparse quiet (which is a valid change).  It doesn't do anything "real"
as this hardware is not on any big-endian systems.

Please don't send stuff to stable that does not actually need to be in a
stable kernel tree.

thanks,

greg k-h

