Return-Path: <stable+bounces-247385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GJ0OuuzBmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:49:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D74549BCD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F422E3013852
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBEC3672AA;
	Fri, 15 May 2026 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpz+EzC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D3366558;
	Fri, 15 May 2026 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823962; cv=none; b=Tk4+yvXU2GTaIjlwqhExnSTtNnP6agpEH5I0vDVoGsNQdiTJOqPkHMUN7B1nTV2aZkVBUubfHVSZW1utT91SeqGInBeQUgjtp8jAJ6ntmJ++8yZ+inM2wiQs1NeA4xGjh22ZadUKQj5fDX2YZWjtBI9VNYTJDSzLT6XKdteVeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823962; c=relaxed/simple;
	bh=qMe4YWMTHuawxGHtHBohvLCOx0jFKEK/DQlpxsLfAwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmovnydZeJNiEjprKu15G0mAbcPHbfgwx2Lv/AOdLw2h5C8JHJz9IpT4a19MbjDEfcUrpN4ODylV07l5iwogLX9nzM+oKxWVGTqGx7Olh4aBZ+4VCMhzKSWS/zeerX8deVW2i7SP5BU30lPLBUZxfxyULrb04kuWu6uybB1Dir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpz+EzC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC7EC2BCB0;
	Fri, 15 May 2026 05:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823962;
	bh=qMe4YWMTHuawxGHtHBohvLCOx0jFKEK/DQlpxsLfAwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kpz+EzC/WeasYkgJ2rsLTD/S7LkfmVxrtx7VtrPDa6OOWIuBeJ73XBxp96+G9b61Y
	 Kok0TjRUlKlyblRoZSPsIgouCmyVul4bxaq0TprcdEUkwB0lQjd3jSnuIFdRJEPuhU
	 HmQcyr/PPk/oGMkmfxw6LF5AwUMtAH25TFF4Igt8=
Date: Fri, 15 May 2026 07:46:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: lukas@wunner.de, ignat@linux.win, jarkko@kernel.org,
	yimingqian591@gmail.com, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] lib/crypto: mpi: Fix integer underflow
 in" failed to apply to 6.1-stable tree
Message-ID: <2026051550-stupor-gravy-b1b8@gregkh>
References: <2026051223-undercoat-reps-6626@gregkh>
 <20260513025130.GA3110@sol>
 <2026051334-showgirl-hurdle-22eb@gregkh>
 <20260513170445.GA2128@quark>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513170445.GA2128@quark>
X-Rspamd-Queue-Id: 62D74549BCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247385-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[wunner.de,linux.win,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,copy.fail:url,gregkh:email,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:04:45AM -0700, Eric Biggers wrote:
> On Wed, May 13, 2026 at 12:34:38PM +0200, Greg KH wrote:
> > On Tue, May 12, 2026 at 07:51:30PM -0700, Eric Biggers wrote:
> > > [+Cc linux-crypto@vger.kernel.org]
> > > 
> > > On Tue, May 12, 2026 at 04:01:23PM +0200, gregkh@linuxfoundation.org wrote:
> > > > 
> > > > The patch below does not apply to the 6.1-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > > 
> > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > > 
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 8c2f1288250a90a4b5cabed5d888d7e3aeed4035
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051223-undercoat-reps-6626@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > > > 
> > > > Possible dependencies:
> > > 
> > > A couple issues.  First, this email wasn't sent to the subsystem's
> > > mailing list (linux-crypto@vger.kernel.org in this case).  That greatly
> > > reduces the number of people who are made aware that this didn't get
> > > automatically backported.
> > 
> > We never send out these FAILED emails to the mailing lists, as that
> > would make just even more noise.  It's always been this way, sorry.
> 
> Yes, this has been a problem for a long time, resulting in lots of
> missed backports including the copy.fail ones.  It's time for you to fix
> your process.
> 
> > > Second, the upstream commit cherry-picks to 6.1, 5.15, and 5.10 without
> > > conflict.  (The file being changed was renamed between 6.1 and 6.6, but
> > > 'git cherry-pick' handles that automatically.)
> > > 
> > > I don't know what you're doing exactly that caused it to be
> > > unnecessarily marked as FAILED.  But whatever it is, it's not working,
> > > and it is causing backports to be missed.
> > 
> > We don't use git for cherry-picking as we have a patch queue, so renames
> > will often times fail, like it did here.  This has always been the case
> > in the decades we have been running the stable kernels :)
> 
> Again, this has been a problem for a long time, and it's time for you to
> fix your process.  You can still have the patch queue; just use git for
> the actual cherry-pick.

Doesn't work well unless we turn the patch queue into a git tree at
every step of the way :(

