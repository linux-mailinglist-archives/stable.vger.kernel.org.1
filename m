Return-Path: <stable+bounces-240973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGZjJEx462npNAAAu9opvQ
	(envelope-from <stable+bounces-240973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:03:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2A45FF6B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 835DA30059A2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8F3DB62B;
	Fri, 24 Apr 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV12P03R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C83DBD4B;
	Fri, 24 Apr 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039430; cv=none; b=W6cZaVT+PUk/TPF3jLV4S7ug0qIqKeH3slEp7QDzNL2zjGc6PzPCH/J+wJWsfFqcIphT1oiBrlBOcvCCmTCtwfvR5XXDQo9ZTr+GFTq1aVKMg7OMz3YONPLxT0rAyhNFUNF46RpI+IyS3y22jDIa40Gre1Meen/Zm5sYzRBdhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039430; c=relaxed/simple;
	bh=VCH0z00/JA4upHhagkU5oPLp1pfvB8+41e0ijTBVlkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovS+VhRIR/QsJnLg2nai4eiq2nm2QG/ORqbZKncIriOeEq35XfLxGU6iUYWbEbF9wY7c1ia81DZyPgr4Nz5Igtni0Km1bTMPHbf0P5vuCTWoOPhJH6C5348a1sC1ge6hYEhaXsdByw3bC/9k9eAyt1ISn9lMZKfxVLQTeMca9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV12P03R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B59DC19425;
	Fri, 24 Apr 2026 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777039430;
	bh=VCH0z00/JA4upHhagkU5oPLp1pfvB8+41e0ijTBVlkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QV12P03RQDvYkQ9Gkl1vVmqePy3U9aBjOv0wQgIt/xHSd3oYYQ2LfN57OsEGE7U2F
	 +TRggP7iKlh1hieuG55CLOjt/THowJjzYetRzO//7K5SDKSTtGqLvt9mchQ4zijAyx
	 jW9FIK/GY+mFortU7EXPB6RrWHlboV8cyHJ6Dgu64q0pvhsiilO863bWNnAoaIqxNP
	 WEvWd9VRfvBHz1eLZPuyWWDkxJOM0lYPx3+L4cJcgRQoUjDuNj6NuNivQH24H95evW
	 sNcJg67ZrIY7SGfZBfD+GzSrQngQ4yvFnK1M7u64w1xZCjKI784TIXYlF2+SkRWa2P
	 rmzCBaohmfD6w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGH8G-0000000B1aD-09lN;
	Fri, 24 Apr 2026 16:03:48 +0200
Date: Fri, 24 Apr 2026 16:03:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: faux: fix root device registration
Message-ID: <aet4RKLFJGZqwFI9@hovoldconsulting.com>
References: <20260424102231.2615557-1-johan@kernel.org>
 <DI1CW4GWGUD6.2K7VZG165WJP8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI1CW4GWGUD6.2K7VZG165WJP8@kernel.org>
X-Rspamd-Queue-Id: 25C2A45FF6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240973-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hovoldconsulting.com:mid]

On Fri, Apr 24, 2026 at 01:42:12PM +0200, Danilo Krummrich wrote:
> On Fri Apr 24, 2026 at 12:22 PM CEST, Johan Hovold wrote:
> > diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> > index fb3e42f21362..402ed119dfdf 100644
> > --- a/drivers/base/faux.c
> > +++ b/drivers/base/faux.c
> > @@ -133,6 +133,9 @@ struct faux_device *faux_device_create_with_groups(const char *name,
> >  	struct device *dev;
> >  	int ret;
> >  
> > +	if (IS_ERR_OR_NULL(faux_bus_root))
> > +		return NULL;
> 
> As Greg mentioned, if this happens we already have a much bigger fundamental
> problem earlier in the boot process.
> 
> Anyway, I think this check only catches when root_device_register() fails, but
> everything that comes after root_device_register() in faux_bus_init() still
> leaves us with a dangling pointer.

Indeed. I cleared the pointer in an earlier draft for this reason, but
got side tracked and later found the change too invasive for something
that would never happen in practise and somehow convinced myself that
this check would do.

I'll respin.

Johan

