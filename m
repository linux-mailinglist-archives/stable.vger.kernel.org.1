Return-Path: <stable+bounces-100928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF29EE907
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22BB281641
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D872153C3;
	Thu, 12 Dec 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCf81hOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C142AA6
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014225; cv=none; b=plLMpeuPldUcxi+pNTCNBaiz5rrQdkpvsXN47mT+s7Gezh3nlFi3VSRtfTPaRNKjGrL5Hh7ororeUA3EW2mBxN3qwvfjJKSqRTwe++6sGarAWYQYYeMufxnIHlxaowF8luwAx77GUSEefa/2wD8xHHDWMVmLLQfI828q8sgbX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014225; c=relaxed/simple;
	bh=OrXgTWOVMSQ8g7yL8EpsBRsTEeuhIumteiVLOraBin4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYd+82jBCiC+ChJUujLdRc8avzs21ja27IunANQvlN9sP3PMPdB19GjiNGhwBajezby5y1ZXaSDvIUZJYlahaXDnyL6U6AkVld7ZiHcSrycep2jmz5/J8Z40Wv3tJq7M0Elc4tC3Lodos4Rlc8r89Q0nI5aMd9d/jERjnH/Utas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCf81hOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E241C4CECE;
	Thu, 12 Dec 2024 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734014224;
	bh=OrXgTWOVMSQ8g7yL8EpsBRsTEeuhIumteiVLOraBin4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCf81hODlYN5liZDXTB4tRbL567MrtyX5Mvvfeb00b5L2iZ3xvzEE1d9V3nyu4ui8
	 /X/UvrtfCuQTttnWrYOCHeSQQ07bKF34pe11skTTp6Q3AqzCeqKSxKU0HeKokU7XSg
	 IiL3WG63qv7sh/xoKJvBNRVffEAunDm3Z30GUWlI=
Date: Thu, 12 Dec 2024 15:37:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
Message-ID: <2024121255-handled-ample-e394@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
 <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
 <2024121235-impale-paddle-8f94@gregkh>
 <87frmt9dl3.ffs@tglx>
 <2024121205-override-postbox-5ed6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024121205-override-postbox-5ed6@gregkh>

On Thu, Dec 12, 2024 at 03:35:14PM +0100, Greg KH wrote:
> On Thu, Dec 12, 2024 at 03:32:24PM +0100, Thomas Gleixner wrote:
> > On Thu, Dec 12 2024 at 15:18, Greg KH wrote:
> > > On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
> > >> > But I don't think these two commits are necessarily stable material,
> > >> > though I don't have a strong opinion on it. If c163e40af9b2 is
> > >> > backported, then it has it's own large dependency chain on pre 6.10
> > >> > kernels...
> > >> 
> > >> It's in the queues for some reason, let me figure out why...
> > >
> > > Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
> > > 6.12.y for now, thanks.
> > >
> > > But, for 6.12.y, we want this fixup too, right?
> > 
> > If you have c163e40af9b2 pulled back into 6.12.y, then yes. I don't know
> > why this actually rejects. I just did
> > 
> > git-cherry-pick c163e40af9b2
> > git-cherry-pick 51f109e92935
> > 
> > on top of v6.12.4 and that just worked fine.
> 
> The build breaks :(

To be specific:

kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
kernel/time/timekeeping.c:263:17: error: too few arguments to function ‘clocksource_delta’
  263 |         delta = clocksource_delta(now, last, mask);
      |                 ^~~~~~~~~~~~~~~~~
In file included from kernel/time/timekeeping.c:30:



