Return-Path: <stable+bounces-43455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CEB8BFC52
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523981C22519
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4AA82872;
	Wed,  8 May 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="CrWfCNT0"
X-Original-To: stable@vger.kernel.org
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B182871
	for <stable@vger.kernel.org>; Wed,  8 May 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168428; cv=none; b=D7JvaaweVYy2+Nlhp0Eg+14IvWyyzwwftKHTGPVL4CF7/UClLAoBfaA7/si4abFCvjq9/hI6uxF0lVw+7m6PNomk4mSqep2qhRpWlvRHfAGk1ByjY4r7D5Q7a3WTlw5YEextoQR29QDJX3+WsLb0Icpzy6jufDN9ww/trCuc79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168428; c=relaxed/simple;
	bh=1WqX1aqfl7bB47m2wZLxK9rctc5oy+z815FHX9gXpZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC3CiYCBnOK5bVcz+w6yKcilIPRHRS412JDhBGOyyt1HewvaGgzwwXXu1ASiOoW9pjqGupmImiU208x+nJMOp/SxuETFGGIDM4tFu+Niu5ayQvYa3q8jwr/nZLWPVBH/OfaCyoTo8XODW9Q73riXd2XuKyUtgz+5ZusvpIJqUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=CrWfCNT0; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A181F44D;
	Wed,  8 May 2024 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1715167994;
	bh=1WqX1aqfl7bB47m2wZLxK9rctc5oy+z815FHX9gXpZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrWfCNT04yeOYiY50JhmRtoGF+vIi9MiqJXFPO5IUKsZ9fBAlEq8Dbgd1Jod14VHq
	 KM0/xb/psJfQypb7nJBhtbnjnPX96pivgzdyCFrqnH/JmlqnCf2wwLKrRCUeKoS1bx
	 VpCJRwrXu5pMNdKi+y0OETlWsB/KBWSF99BsXo3k=
Date: Wed, 8 May 2024 11:33:14 +0000
From: Eric Wong <e@80x24.org>
To: Konstantin Ryabitsev <mricon@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, tools@linux.kernel.org,
	stable@vger.kernel.org, meta@public-inbox.org, sashal@kernel.org,
	gregkh@linuxfoundation.org, krzk@kernel.org
Subject: Re: filtering stable patches in lore queries
Message-ID: <20240508113314.M238016@dcvr>
References: <ZixGx_sTyDmdUlaV@zx2c4.com>
 <20240427071921.M438650@dcvr>
 <20240429-antique-hyena-of-glee-d9e4ac@lemur>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429-antique-hyena-of-glee-d9e4ac@lemur>

Konstantin Ryabitsev <mricon@kernel.org> wrote:
> On Sat, Apr 27, 2024 at 07:19:21AM GMT, Eric Wong wrote:
> > Correct, public-inbox currently won't index every header due to
> > cost, false positives, and otherwise lack of usefulness (general
> > gibberish from DKIM sigs, various UUIDs, etc).
> > 
> > So it doesn't currently know about "X-stable:"
> > 
> > I started working on making headers indexing configurable last
> > year, but didn't hear a response from the person that
> > potentially was interested:
> > 
> > https://public-inbox.org/meta/20231120032132.M610564@dcvr/
> > 
> > Right now, indexing new headers + validations can be maintained
> > as a Perl module in the public-inbox codebase.
> > 
> > For lore, it'd make sense to be able to configure a bunch (or
> > all) inboxes at once instead of the per-inbox configuration in
> > my proposed RFC.
> > 
> > At minimum, one would have to know:
> > 
> > 1) the mail header name (e.g. `X-stable')
> > 2) the search prefix to use (e.g. `xstable:') # can't use dash `-' AFAIK
> > 3) the type of header value (phrase, string, sortable numeric, etc...)
> 
> I'm whole-heartedly for this! This ties nicely to my b4 work where I'd 
> like to be able to identify code-review trailers sent for a specific 
> patch, even if that patch itself is not on lore. For example, this could 
> be a patch that is part of a pull-request on a git forge, but we'd still 
> like to be able to collect and find code-review trailers for it when a 
> maintainer applies it.

OK, a more configurable version is available on a per-inbox basis:

https://public-inbox.org/meta/20240508110957.3108196-1-e@80x24.org/

But that's a PITA to configure with hundreds of inboxes and
doesn't have extindex support, yet.

I made it share logic with the old altid code; so I'll also be
getting altid into extindex since ISTR users wanting to be able
to lookup gmane stuff via extindex.

And it also works with the new C++ xap_helper process
(which I'll use for threadid: support (still working on that...)).

> I'm perfectly fine with it only being a string, honestly.

Yeah, though there's 3 ways of indexing strings, currently :x
I've decided to keep some options open and support boolean_term,
text, and phrase for now.

boolean_term is the cheapest and probably best for exactly
matching labels/enums and such.  The others may work better
for more complex texts (comma-delimited labels, maybe).

> > So probably just supporting strings and/or phrases to start...
> > 
> > Validation to prevent poisoning by malicious/broken senders can
> > be useful in some cases (and the reason the RFC was a per use
> > case Perl module).  That said, I'm not sure if much validation
> > is necessary for X-stable: headers or if just any text is fine.
> 
> I'd let the consumer clients worry about it.

Agreed.

