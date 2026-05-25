Return-Path: <stable+bounces-254052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK7CBg2ZE2rjDwcAu9opvQ
	(envelope-from <stable+bounces-254052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:34:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B7D5C50A3
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0F0300F513
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FC21E7C18;
	Mon, 25 May 2026 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GcGAq63D"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0611922FD
	for <stable@vger.kernel.org>; Mon, 25 May 2026 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779669238; cv=none; b=Nu8TU1G9nsFX6D7uS4KJJwLSDPVVcwho4jHAxqLkrHE+4BvJ4CBOLxNWwVsFqhcK0G5gOYnKteH7j7hGaNkgRcG4ICK3A+3r7RYeNTSoQteZg8o440Ah90fsfU3jhNLwBZrjrvIzJB3+zw8X2aC9IAYnQrz6A6oh3GWgBxfaykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779669238; c=relaxed/simple;
	bh=NxBgylfGI61QezjFuHLlTPY1IY+6uc8yTNmpMIxvsRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txEs2LBLvpYspFyZ7RMhju65TVTWd3vuMGl2mKxSH172tRsqyuG2lWYbUZhkytDAxpJYE//n3sw0I6/5qlriYJa1S90icRaD06ZelD4Do8zWY2k873f3rF5A7hRqMXXZhOPo72/8DPV5Wy4KW7EJI0aRvcH4n4jziR/kGxHXXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GcGAq63D; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64P0XMi6023089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 20:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779669205; bh=WKS4775VuFwUPFf6kitgs+nNyhe3+RO9OMQko7wP3dM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GcGAq63D/xo2c+Y+jkbg+2iv39qVjix71xS1kqHufdIfHc7cPQ3KgCN3YwE2icNfd
	 PIplsW6IRpJPD4jVLxV9Pf+NkryMqYH3ANwdwrid1JkxbqxMeHWNy7er/Z7WXvAXCm
	 DvzDDARwEiHlyavlBv+hfIJ3DHmjrzR4e8EI9aLwMPaDso3nGFCQwluF9wK0yH5pqV
	 cGU/0OPLGjQ6DSMXp0D0GqWJYS4XWLtB/Oc+0d2512kPWN97N5juM8V1mVTg/K+OGH
	 Ca9e4hK49QND6+o9gsmwh7MTIKEU1ibADkZuf/ujot9meB8dOIYAYpt1dprpWe/nfH
	 BDSFUoI08IeOA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E61906A5A0DD; Sun, 24 May 2026 19:33:21 -0500 (CDT)
Date: Sun, 24 May 2026 19:33:21 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Artem S. Tashkinov" <aros@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
Message-ID: <20260525003321.GA51941@macsyma.local>
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
 <2026052444-unlawful-eskimo-9c41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026052444-unlawful-eskimo-9c41@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254052-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsyma.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 85B7D5C50A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:56:54PM +0200, Greg Kroah-Hartman wrote:
> > point-release numbers can be replaced by
> > automated, time-stamped git tags and machine-generated source snapshots cut
> > on a strict, automated interval (e.g., every 48 hours), removing human
> > maintainers entirely from the release timing.
> 
> That's probably not a good idea anyway.  Are you doing continous testing
> of the stable queue?  If so, great, just take from there today.
> Everyone adds patches on top of releases anyway, what's a few more if it
> happens to resolve specific issues for a day or so before a .y release
> can be cut?

It's already the case that not all maintainers have the time to test
the stable queue, and it's not clear that current testing of the
weekly release is all that great.  I have seen stabilty regressions
where an xfstest running against ext4 will cause the kernel to crash
with the 6.1 and 6.6 LTS kernels.  It took me several days to figure
out the 6.1 regression, and I still haven't had time to look into the
6.6 regression, because my day job (which is not ext4, but herding
cats for an AI infrastructure project --- it's amazing how many fellow
developers I met at LSF/MM are actually doing AI infrastructure
projects for $WORK, and not kernel development as their primary job
responsibilities.)

So even the weekly cadence is starting to creek a bit from a quality
perspective.  I can't even *imagine* what a continuous, automated, "it
builds, ship it!" would do to the quality of the stable kernel series.

		     	  	      	  - Ted

P.S.  If someone is interesting in helping to test ext4 and xfs stable
kernel patches, talk to me.  There is partial automation to test
updates to the stable-rc trees, but I've never had time to automate
the rest of the test regression analysis combined with the automated
"which patches need to be backed out to avoid the regression / kernel
crash".  There had been a few companies contributing fractions of
engineers to do XFS stable maintainenace, all of those resources have
been withdrawn by their respective companies in the past year.




> 
> > ### Why This Benefits the Ecosystem
> > 
> > * **Eliminates Churn and Latency:**
> > 
> > When a patch introduces an edge-case regression or requires an immediate
> > follow-up (a common reason for rapid point-release sequences), maintainers
> > do not need to coordinate a whole new release event.
> 
> No real "coordination" happens here.
> 
> > The follow-up fix is simply patch $n+1$. Downstream CI pipelines
> > ingest it natively via standard git fetches.
> 
> Again, we do that today.
> 
> > * **Maintains Git-Native Debugging:**
> > 
> > Debugging stable regressions via `git bisect` has always been patch-based,
> > not release-based. Since point releases are meant strictly for backported
> > bug fixes, removing the arbitrary `x.y.z` release tags changes nothing about
> > a developer's ability to isolate a regression. If anything, it prevents
> > downstream vendors from pulling out-of-order patches that complicate
> > bisection across distros.
> 
> Who bisects across distros?
> 
> > * **Eases Downstream Automation:**
> > 
> > Modern tracking distributions (Arch, Fedora snapshotting, etc.) can switch
> > to trunk-based intake, automatically building from the signed tip.
> 
> Have you asked them if they need/want this?
> 
> > For enterprise distributions (RHEL, Ubuntu LTS) where constant kernel
> > packaging and reboots are untenable,
> 
> Why are reboots for these systems untenable?  Why not fix that root
> problem instead?
> 
> > a fluid patch stream allows vendor
> > security teams to more rapidly feed live-patching infrastructure (`kpatch`,
> > `kgraft`), applying critical CVE fixes directly to runtime memory without
> > changing the base package version.
> 
> They can do that today, and do do that today.  So again, what distro
> needs this?
> 
> > * **Bridges the Compliance Gap:**
> > 
> > Embedded, automotive, or medical compliance pipelines
> > that legally require a static, verifiable code artifact can validate their
> > software against the base major release tarball ($7.0.0$) plus the
> > cryptographically signed, append-only stable patch series manifest.
> 
> Do they really need that?  Again, they can have that today, nothing new
> here.
> 
> > The manual compilation, testing, and cutting of sub-version tarballs is an
> > administrative artifact of the late 1990s.
> 
> Weekly releases is not an artivact of the 1990s :)
> 
> > Shifting to an explicit, signed
> > patch-stream architecture acknowledges the velocity of modern vulnerability
> > research, strips away artificial latency, and frees our stable maintainers
> > to focus on code quality rather than release management overhead.
> 
> Again, we have that today, on a weekly basis.
> 
> greg k-h
> 

