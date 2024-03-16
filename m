Return-Path: <stable+bounces-28290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BA87D801
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 03:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627161C2132F
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D7639;
	Sat, 16 Mar 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lg1hFPvu"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B284C8E
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710557091; cv=none; b=i2TV1qOxyw3brWsJiHvueakcKpDle0FAIPbXGn8rfwk6i0OTVwRSALLWMOS9XPokXoKL3UfSpBEzPMWREjNvsU3peEtKFLDkotJ7MVXDtbxMPwO8JGFkqb1sXRHH4XxPQ1dgVubcv7/IrGDwhVzT3+9OmDZ7tL7QkqXGTEu9d6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710557091; c=relaxed/simple;
	bh=w8lHOO/aFpKHrM0d13CZzAaN8FgCf8QjGDXvIuoPFEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBASeDpeG/V0HJsSevWThXyDBi3Ab5Tjooy32P3eXTVYU4UgZ7WajG5kbACZ2OkXF3DCDNyaCwPYm1TPtqgr8eiC8EA+XpY0zJraiZAM4yS4ur1yGOGMYyXh0kBF4Nxbzvg/x1oRtaX+J4bOIK2BUJNyMGZ02L9pQx5zx92EJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lg1hFPvu; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Mar 2024 22:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710557087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VLaLToBfBQejAz8L9o/7cpqJg1o7vDzx3w4Yc7z51LM=;
	b=Lg1hFPvuVs8u/qTgsj8FHMl0VMLYj2HAmXuZlkrGL0NnlHoR6dDhZ7vO86TBCGEeyhentm
	pltaKJgYRgkb6CaB+g+6EGhnkGg3NAjeRLkv7XpJeJf6IbrxyNSEMAkw8bQL2Wj/F3n/P0
	B89uI2I6KFG5rhrAtf7pn6fa67o86QU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Helge Deller <deller@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: dddd
Message-ID: <v44t23xux6w4jrpcsh54z5r6ukya5afcgzmyczus4wkouszb5l@s2ofhjlwlz77>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ZfN8WxMrgQBUfjGo@sashalap>
 <7g5wb7rf3xxn5gz4dnqevbee7ba6zd4kllzb5lbj2i6capxppv@blm5renpmaiz>
 <2024031516-chip-circulate-ff78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024031516-chip-circulate-ff78@gregkh>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 15, 2024 at 07:27:23PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 14, 2024 at 07:02:46PM -0400, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 06:38:19PM -0400, Sasha Levin wrote:
> > > On Thu, Mar 14, 2024 at 05:46:35AM -0400, Kent Overstreet wrote:
> > > > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > > > Dear Greg & stable team,
> > > > > 
> > > > > could you please queue up the patch below for the stable-6.7 kernel?
> > > > > This is upstream commit:
> > > > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > > > 
> > > > > Thanks,
> > > > > Helge
> > > > 
> > > > I've already sent Greg a pull request with this patch - _twice_.
> > > 
> > > I'll point out, again, that if you read the docs it clearly points out
> > > that pull requests aren't a way to submit patches into stable.
> > 
> > Sasha, Greg and I already discussed and agreed that this would be the
> > plan for fs/bcachefs/.
> 
> I agreed?  I said that I would turn a pull request into individual
> patches, but that it's extra work for me to do so so that it usually
> will end up at the end of my work queue.  I'll get to this when I get
> back from vacation and catch up with other stuff in a few weeks, thanks.

No, you never said anything about turning a pull request into individual
patches; that was something I found out after you repeatedly mangled my
pull requests.

But how the pull requests get applied is entirely beside the point right
now, because apparently you agreed to a process without making any
provisions for having that continue while you were on vacation?

So now we've got a user data eating bug out there, with a fix that's
been sent to you, and you guys are just sitting on your hands.

You guys need to get your shit together - I've already let people know
that 6.7 is not safe to use and they need to immediately upgrade to 6.8,
but unfortunately not everyone will see that.

This is going to cause people reall pain.

