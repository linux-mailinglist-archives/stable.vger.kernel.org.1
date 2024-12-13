Return-Path: <stable+bounces-104019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA69F0B48
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2527283975
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032E1E0E07;
	Fri, 13 Dec 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMLNqm2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0D1DF736
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089623; cv=none; b=Zy1kl4sfT+aIEZnOY7UqEWYGoye5aH5KZBuMcLs4RC2amthWMlx0a2q5So1T1zbhi6tZMpv4j5bzu4yJtOB3/UXLDAHiD9m0cwTdJHH4BxPlia6iY6UPAHbhiBME+UXHZZGdCrtfoQOsImhsmOSYGM1pRaERV6fFsBPjs/q2yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089623; c=relaxed/simple;
	bh=CqmzCllvbVdP2g/m+tJ2Tv/cVLu/rqE3crRjuhdoKOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4+oy3+RUGZklQ3APuvhKmXpnRxVoze7qb+gpf8GYXqWSOPI4S7Fdm3gfzcaIf9zHp4Pp5GxXhOG2sQ0yCH4TuSVe7FefKdgLW4mCkuivUmT/Jr5oNILaV1kr1J0XYjoBB9NgAjIznF+wvvc8gtUBt1/eH3ZLVCeoCjafxfeOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMLNqm2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01550C4CED0;
	Fri, 13 Dec 2024 11:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734089622;
	bh=CqmzCllvbVdP2g/m+tJ2Tv/cVLu/rqE3crRjuhdoKOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMLNqm2gz2q3e8OFfOcF/hChSA9bZuo8TzJH/SWutZ7+UsLVFmOE8pye3j85OwJ7d
	 4yPae8K7Il3OkKPrFHm9Azvb62H/R5/lW6pPNg+tSGm1JyJbhaBkpS86+F8g4fyYVJ
	 5qIyrhlsEjRSOKo1cr+2KYRFCUrSswdcoP3+EZo8=
Date: Fri, 13 Dec 2024 12:33:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
Message-ID: <2024121317-shuffling-paragraph-7fb5@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
 <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
 <2024121235-impale-paddle-8f94@gregkh>
 <87frmt9dl3.ffs@tglx>
 <2024121205-override-postbox-5ed6@gregkh>
 <2024121255-handled-ample-e394@gregkh>
 <87cyhx9c7l.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyhx9c7l.ffs@tglx>

On Thu, Dec 12, 2024 at 04:02:06PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 12 2024 at 15:37, Greg KH wrote:
> > On Thu, Dec 12, 2024 at 03:35:14PM +0100, Greg KH wrote:
> >> On Thu, Dec 12, 2024 at 03:32:24PM +0100, Thomas Gleixner wrote:
> >> > On Thu, Dec 12 2024 at 15:18, Greg KH wrote:
> >> > > On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
> >> > >> > But I don't think these two commits are necessarily stable material,
> >> > >> > though I don't have a strong opinion on it. If c163e40af9b2 is
> >> > >> > backported, then it has it's own large dependency chain on pre 6.10
> >> > >> > kernels...
> >> > >> 
> >> > >> It's in the queues for some reason, let me figure out why...
> >> > >
> >> > > Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
> >> > > 6.12.y for now, thanks.
> >> > >
> >> > > But, for 6.12.y, we want this fixup too, right?
> >> > 
> >> > If you have c163e40af9b2 pulled back into 6.12.y, then yes. I don't know
> >> > why this actually rejects. I just did
> >> > 
> >> > git-cherry-pick c163e40af9b2
> >> > git-cherry-pick 51f109e92935
> >> > 
> >> > on top of v6.12.4 and that just worked fine.
> >> 
> >> The build breaks :(
> >
> > To be specific:
> >
> > kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
> > kernel/time/timekeeping.c:263:17: error: too few arguments to function ‘clocksource_delta’
> >   263 |         delta = clocksource_delta(now, last, mask);
> >       |                 ^~~~~~~~~~~~~~~~~
> > In file included from kernel/time/timekeeping.c:30:
> 
> Ah. You also need:
> 
> d44d26987bb3 ("timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING")
> 
> which in turn does not apply cleanly and needs the backport
> below. *shrug*

Wonderful, thanks for this, that worked I'll go push out a -rc2 with
this soon.

greg k-h

