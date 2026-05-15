Return-Path: <stable+bounces-247384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBYYIt6zBmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:49:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C1549BC6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15715300539E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D2368972;
	Fri, 15 May 2026 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkxGdM9M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF7D366558;
	Fri, 15 May 2026 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823936; cv=none; b=RXU+6YkM09khJa2M4T+/+bb3WXSp52ss8IjPGHI2miL98c7+uExX2iQR/Ulhcr542qEX9n1Mlf97f1AcBPiBiug+pvOq06izAcXZ8oqF5FMwac5+nISuvDA9bVa6jctvmnnhXt77Nxe2m0XlBZULIT26KwVmaoABxyT8TuvhxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823936; c=relaxed/simple;
	bh=Z2q1o2NUqVxfG+ho3ZuFX4Tmhr0ZS4KIYOd4M+uy7vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxsYf2m6uEJxHdvpPT56nA9x70vB46w+JBelbH/Ca8x6KKMop8qV+kslmByadD4enqGZ6qQTs0j477baLNnm2cAg6n8RXygptx330PGlfV7m4u9BVct0eIeMQze7lCDUOLOCw3rFYA/3nJHTQjOreExdMMV4pb/AY4ICv3T2eEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hkxGdM9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35B7C2BCB0;
	Fri, 15 May 2026 05:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823936;
	bh=Z2q1o2NUqVxfG+ho3ZuFX4Tmhr0ZS4KIYOd4M+uy7vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkxGdM9M6Ds5hHY56I0WAdMTR17+c8HLF22EVAA9QoKJE+7TOqh7H+RXYQAZ6+tpo
	 GiSaRM/yGoh8AOLBNxnoQdLk9h3ILyEF6fS1wLruVk4J1lkTKsY5fgWrI74UsX8cHy
	 qFKKe97bReJBHlmMXXO4AT4rLnKCPJxO7K/W4MRE=
Date: Fri, 15 May 2026 07:45:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: lukas@wunner.de, ignat@linux.win, jarkko@kernel.org,
	yimingqian591@gmail.com, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] lib/crypto: mpi: Fix integer underflow
 in" failed to apply to 6.1-stable tree
Message-ID: <2026051530-lushness-attest-bcbb@gregkh>
References: <2026051223-undercoat-reps-6626@gregkh>
 <20260513025130.GA3110@sol>
 <2026051334-showgirl-hurdle-22eb@gregkh>
 <20260513170445.GA2128@quark>
 <20260513225934.GA501859@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513225934.GA501859@google.com>
X-Rspamd-Queue-Id: ED8C1549BC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247384-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[wunner.de,linux.win,kernel.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,copy.fail:url,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:59:34PM +0000, Eric Biggers wrote:
> On Wed, May 13, 2026 at 10:04:47AM -0700, Eric Biggers wrote:
> > > > A couple issues.  First, this email wasn't sent to the subsystem's
> > > > mailing list (linux-crypto@vger.kernel.org in this case).  That greatly
> > > > reduces the number of people who are made aware that this didn't get
> > > > automatically backported.
> > > 
> > > We never send out these FAILED emails to the mailing lists, as that
> > > would make just even more noise.  It's always been this way, sorry.
> > 
> > Yes, this has been a problem for a long time, resulting in lots of
> > missed backports including the copy.fail ones.  It's time for you to fix
> > your process.
> > 
> > > > Second, the upstream commit cherry-picks to 6.1, 5.15, and 5.10 without
> > > > conflict.  (The file being changed was renamed between 6.1 and 6.6, but
> > > > 'git cherry-pick' handles that automatically.)
> > > > 
> > > > I don't know what you're doing exactly that caused it to be
> > > > unnecessarily marked as FAILED.  But whatever it is, it's not working,
> > > > and it is causing backports to be missed.
> > > 
> > > We don't use git for cherry-picking as we have a patch queue, so renames
> > > will often times fail, like it did here.  This has always been the case
> > > in the decades we have been running the stable kernels :)
> > 
> > Again, this has been a problem for a long time, and it's time for you to
> > fix your process.  You can still have the patch queue; just use git for
> > the actual cherry-pick.
> 
> Also I should mention that your own instructions for "reproducing" the
> conflict use 'git cherry-pick':
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>     git checkout FETCH_HEAD
>     git cherry-pick -x 8c2f1288250a90a4b5cabed5d888d7e3aeed4035
>     # <resolve conflicts, build, test, etc.>
>     git commit -s
>     git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051223-undercoat-reps-6626@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> When these instructions are followed, there is no conflict.  The
> "conflict" is purely because you didn't use 'git cherry-pick' yourself.

Yes, that is true, we are showing how someone else can potentially
resolve the issue.  The magic is in the line:
	# <resolve conflicts, build, test, etc.>

We issue FAILED emails for any number of reasons, we don't go into the
details of why it FAILED, otherwise we would have just too much
information here.

> So just start using 'git cherry-pick', and stop asking other people to
> do it for you when there are no conflicts, please.

That does not work in our workflow at all.  Given the huge flow of
patches, and all the different issues/errors, the odds that a simple
rename will resolve the problem is very low.  For that I can not slow
down the whole process for all submissions.

> And please start Cc'ing the mailing lists.  Linux kernel development
> isn't done in private email.

This isn't a private list, we are cc:ing the people who signed off on
the patch directly.  They are the "owners" of it.

> I would have backported the copy.fail
> fixes earlier, but I never received the FAILED emails (which I'm
> guessing you sent, but only in private email to other people), so I
> didn't know they weren't being backported...

Those patches were NOT marked for stable inclusion, so they did not get
a FAILED email at all.  We were lucky that Sasha's sweep of the tree for
"random patches that have a Fixes: tag only that look interesting"
actually caught them for a few branches.  And for those, we NEVER send a
FAILED email either, as the maintainer did not explicitly ask us for
stable inclusion, so we are not going to bother them with extra stuff.

thanks,

greg k-h

