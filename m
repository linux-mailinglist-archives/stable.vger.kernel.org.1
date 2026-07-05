Return-Path: <stable+bounces-272028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cStyGEIeSmr++QAAu9opvQ
	(envelope-from <stable+bounces-272028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:05:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 985547098B8
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 11:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=e8D89nm8;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272028-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272028-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653F43012C44
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6936492C;
	Sun,  5 Jul 2026 09:05:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAACD379EDA;
	Sun,  5 Jul 2026 09:05:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783242303; cv=none; b=n4vZUlQVyzZfKo8O1hw/A/NrBxfJk/f0rdR9rOizeK6OnRiS+tQ/dHxS4BzQdc61pqxS9ZGIZbYY9ItECn5seaWxUH/OgjM1urPDrJC5vl12iYLFFG1kf6TtOu+1Esp5KPMFshzBkemQyQWWEbPJQngTh1kiSv3DKnFOFkWIf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783242303; c=relaxed/simple;
	bh=1p5VzzNE8pQlThtmaBT2bVxPsoQgBFGrQcAXhpIkWas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVQZC1Bi6evXQbEeIToKKqo/xF/4EyA3JqCimo+rjzTSDXj/eE7EMaCUs15b1mN5ezppfDoDw1tn/dQNeS2sQ6jA7uAZbzo/x1c9LpJpP7dRsFcA0gNqz6gxwA7IBRXAd/p33hhsQ4IdbEOy7h2Ftb0Ol472Xxt+9ClMW13HF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8D89nm8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB511F000E9;
	Sun,  5 Jul 2026 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783242300;
	bh=Oc6q8Yu6p5Bx79EiYKMkfCm8c2i/JBb36QAEOc6EYIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e8D89nm8ce0TAsFYZuWDDpCTqTsXFgrGXK4ATIZjJctHvkDJGrGyOU69zmRnhwi96
	 We+8si4LUea7OKBylX/OOqZXqf0JOuuBAwEATI7jG9Bv/ajixQm+r0me8uhFAFZacV
	 VdwZR/EPHjUVMJc+CO29DGgQKGeV9lLAEDTlR79c=
Date: Sun, 5 Jul 2026 11:03:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 6.18 044/108] block: invalidate cached plug timestamp
 after task switch
Message-ID: <2026070536-showroom-unlit-4f84@gregkh>
References: <20260703123236.3139759-1-usama.arif@linux.dev>
 <2026070315-stable-reply-0015@kernel.org>
 <eeec321a-fd07-408b-9d64-c4d65ec92935@kernel.dk>
 <2026070416-bannister-charred-76c4@gregkh>
 <4a05f7e4-d831-4696-8d34-7e976839b4b2@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a05f7e4-d831-4696-8d34-7e976839b4b2@kernel.dk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272028-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:sashal@kernel.org,m:usama.arif@linux.dev,m:stable@vger.kernel.org,m:patches@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985547098B8

On Sat, Jul 04, 2026 at 06:41:07AM -0600, Jens Axboe wrote:
> On 7/4/26 12:45 AM, Greg Kroah-Hartman wrote:
> > On Fri, Jul 03, 2026 at 08:35:46PM -0600, Jens Axboe wrote:
> >> On 7/3/26 8:05 PM, Sasha Levin wrote:
> >>> On Thu, Jul 03, 2026 at 05:32:35AM -0700, Usama Arif wrote:
> >>>> It looks like this patch was backported, but the preceding patch [1]
> >>>> in the series was not bacported to the stable branches. Both this and its
> >>>> prerequisite have the same Fixes tag.
> >>>> Not having the prerequisite will result in a NULL derefernce.
> >>>> Could we please add [1] to the stable branches?
> >>>
> >>> Now queued the prerequisite fd38b75c4b43 ("kernel/fork: clear PF_BLOCK_TS
> >>> in copy_process()") for 7.1.y, 6.18.y, and 6.12.y, thanks!
> >>
> >> This is a problem. Can some light be shed on why only 1 patch of the 2
> >> got applied? This could lead to big problems, which seems to be the
> >> case for this one in fact.
> > 
> > This is on me, I only took a "subset" of the patches tagged for stable
> > for this round of releases as I was facing a huge backlog of stuff
> > (everyone loves to wait for -rc1 for cc: stable fixes), combined with me
> > having travelled for 6 weeks straight for conferences which didn't allow
> > me a ton of time to do stable kernel work to keep on top of the pile.
> > 
> > The patch wasn't lost, and is still in my queue to process (along with
> > 748 other patches) it just wasn't obvious that there was a dependancy
> > and that I had to take them both in order, that's on me, sorry.  This is
> 
> At least this one would've been avoided if patches marked as fixing the
> same upstream commit would never get split. Which does seem like a
> (very) sane default! Particularly when they are part of the same
> posting, it's not like they landed at separate times.

I have never considered searching to show which patches say they fix the
same commit.  Next time I do a "not all of the patches at once" I will
do that.  As this hasn't come up in the past before, because normally I
can keep on top of the flood, it shouldn't be something we have to
institute very often.

> > also why we have review, to catch things when I do something stupid like
> > this :)
> 
> Agree, but at the same time, requiring review to catch these is fraught
> with error. Not only do maintainers and developers get a lot of emails
> from stable, we need to carefully sift through them. And rely on the
> original patch author to do the same. Which in this case thankfully did
> happen, but... People also don't necessarily pay full attention all the
> time, there's work and vacation and a bunch of other things that get in
> the way.
> 
> This is different than normal review, where inclusion is gated on the
> review. If nobody says anything, it'll go in.

That's because these patches have already been accepted into our tree
and gone through our review process.  Backporting them usually should be
trivial, it's only the minority that are in series and dependant on
others in that series, so this doesn't come up often.

> >> A Depends-on could be used here, but it's pretty hard for a submitter
> >> to do that, as the sha isn't known before it goes into the maintainers
> >> tree.
> > 
> > Agreed, that wouldn't really work, and isn't normally needed.
> > 
> > But again, maybe trying to get patches that are cc: stable into Linus
> > _before_ -rc1 is better?  Hey, I can dream...
> 
> I send out fixes _every week_, -rc1 or -rcX changes nothing in my
> workflow.

Based on the huge number of patches for stable that show up in -rc1, you
are in the minority :)

thanks,

greg k-h

