Return-Path: <stable+bounces-263763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mxBWCQVfMWrZiAUAu9opvQ
	(envelope-from <stable+bounces-263763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:34:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1566908D2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UYYJAupL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263763-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263763-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73933249A65
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FA36EA93;
	Tue, 16 Jun 2026 14:19:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F72036C5A1;
	Tue, 16 Jun 2026 14:19:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619575; cv=none; b=I3kZAdJfwQ6DhaGWGF/HoPfeKbVgBPd9omiLNuPskLL4IRTVVBsXLKg2usE8NRub0cvm8pdaFhFUiukQI3i0GudEqSX417WQJuYebWOOJlAnjNh6ki/sFqFbSRZy9r/M1rZ1r0NdBbalwUfhi6XjizzmUYApKA4IZtY4Hn4W5jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619575; c=relaxed/simple;
	bh=f0B7hPcLipWmH3E8jjtfL31N+sYuG8r1wAD9c9nYHVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA48y0rCuT0qOtleuWlS5NvYNh5Y8gTkW6sQugirr6TtOtNfnXd8mLk9TLJtVt9/FhgBG2eXztfrIgrUPhJpMghUUWwr78TqM6ppMLYHj/8ko6WA6jTZ2jIAtogCOZXr8kj1scXpT/h7vdjODT5cUoExXrdvg6QOjudr3Jy4/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYYJAupL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0C21F000E9;
	Tue, 16 Jun 2026 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781619574;
	bh=TLGGdLtUmkchl0dQCLv1NvzeNJ5dSPlGQkOH9FAEEBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYYJAupLKnVLY+f+SbK8WhBPC/wZkWBRG04GJeZddICgwlcHkm3ldMO2Udb/Vk6in
	 /7e5rKDqV7pswD6PRKf3cYq1ax9tI3jsHEOWbtnpPURKASvjwc+STALhf/VbGwwNDK
	 Pm1SKI1FMUEiNHWY+Iuw/+RHW1p6L6H8exaSGqD9Q/TwVj2CO4SYID/aPrafZD51mi
	 aK9TfeDDqNXTMHAATINmkq3104pBcB+czy1IFf8PHGQk+baiz7gOUMKUrQO6gG++VU
	 QZSmAFJwMbQV89U3eOdo4VtYdvy+3RP2JgW1bgNzL9IBQkb3WcnSH8M5zgS7tSip0A
	 EUH+0qGeOryzg==
Date: Tue, 16 Jun 2026 16:19:28 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>, 
	Leah Rumancik <leah.rumancik@gmail.com>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	lvc-project@linuxtesting.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <ajFabPtI8UGfkyix@nidhogg.toxiclabs.cc>
References: <20250322143418.216654-1-pchelkin@ispras.ru>
 <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
 <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
 <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263763-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hamzamahfooz@linux.microsoft.com,m:sashal@kernel.org,m:pchelkin@ispras.ru,m:leah.rumancik@gmail.com,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:djwong@kernel.org,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,ispras.ru,gmail.com,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E1566908D2

On Tue, Jun 16, 2026 at 09:31:41AM -0400, Hamza Mahfooz wrote:
> Cc: linux-xfs@vger.kernel.org
> 
> On Tue, Jun 16, 2026 at 09:13:45AM +0200, Carlos Maiolino wrote:
> > On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> > > Cc: Carlos Maiolino <cem@kernel.org>
> > 
> > FWIW I don't maintain the stable trees I really don't have time for
> > that. Darrick/Leah have been doing a best effort case for that, but
> > again, this is mostly a best effort so we shouldn't expect them to be
> > looking/picking up every single possible patch suggested for stable.
> > 
> 
> Now that you mention it, the xfs-stable mailing list seems to be pretty
> much dead (i.e. the last time fixes from it were merged into stable was
> almost a year ago). I guess no one is really working on it anymore?

IIRC Darrick started it, I personally never worked on it, but I didn't
follow the evolution there.

> 
> > > 
> > > On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> > > > On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > > > > Any idea what happened to this series? It resolves an issue that I've
> > > > > hit in a production environment FWIW.
> > > > >
> > > > > Series is:
> > > > >
> > > > > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > > 
> > > > Thanks for the nudge, and thanks Fedor for putting the backport together.
> > > > 
> > > > We generally don't take XFS backports without a maintainer signing off on them,
> > > > so right now we're waiting for one to do so :)
> > > > 
> > > > --
> > > > Thanks,
> > > > Sasha

