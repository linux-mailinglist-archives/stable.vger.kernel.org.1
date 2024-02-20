Return-Path: <stable+bounces-20887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167B85C5F6
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E3E1F23930
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60414A4C7;
	Tue, 20 Feb 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qhoyJsXj"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97569DE2
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461563; cv=none; b=nQUfarrFwJYgzx1ikfRcrEa9oRcsK71tgbIUkc4F71RKzB116mLk798ZMGassR//4JU09WoekMFUim9M8PXsukuFdp+tguwkNIaqiaURas83Ixu2x2fZJfRucCAgYifgMgpnBF5tmAk3IU35dkBsWu9DaLfXh5rCyJ7aJhQg+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461563; c=relaxed/simple;
	bh=YJ/JUyW5BRmwlCHHYD43qDZQRKUnoLUWhOUG5VdNZbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrRcoGc3hnJ1E3kTHo7yAcO29vHmzH++hkY7IkuFVExcc26VaPvVxgIihBarOs8t+MiPR3WHTlqoLYT+CIftlrpgY7SN4DLYac/p+EAtkZ4UTFXau5XLo91Ys7khqlU3ReGUFqRhvr0SxkLBF0HGdE4lhQ7DjOtZUpnYAX1MRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qhoyJsXj; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Feb 2024 15:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708461559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xQkZX4wrrzmQvW8dML2GnvQAEARLoW4pgNf2eBR2YQ=;
	b=qhoyJsXjgcMJz8mPxXz1jVuvLx754r4v8IqakJtyQxhf/0nWuc9LOHD7ZzG6GtJR3/m9LR
	rL40skllgmwA0qAfSt0BaQdd+cJnsJR2zY5qF+FMoxjaETJRVGYQ+02k5qQIa7ZYO2vPzd
	Z9g2LWPyLpkoBGJcAsjkMO3m4PrW9Mg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <mpqwydwybzktciqsqsi4ttryazihurwfyl7ruhrxu7o64ahmoh@2xg56usfednx>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
 <ZaW5r5kRbOcKveVn@sashalap>
 <dlxqudswz64v6xn3fg2i6ob2msnytaatmnyhq4ivi7notzs6jf@itt42d42zmsw>
 <2024022056-monkhood-fossil-ec02@gregkh>
 <2024022007-buggy-operator-2dc5@gregkh>
 <g2jlxm6hcpywrezexi3kxrl6nu7bdmkoafa2kh2ptcf7olhofl@ycilgjsqyycq>
 <2024022022-viewless-astronaut-ab8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022022-viewless-astronaut-ab8c@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 09:19:01PM +0100, Greg KH wrote:
> On Tue, Feb 20, 2024 at 03:06:14PM -0500, Kent Overstreet wrote:
> > On Tue, Feb 20, 2024 at 07:53:04PM +0100, Greg KH wrote:
> > > On Tue, Feb 20, 2024 at 07:03:23PM +0100, Greg KH wrote:
> > > > On Tue, Feb 20, 2024 at 12:23:33PM -0500, Kent Overstreet wrote:
> > > > > On Mon, Jan 15, 2024 at 06:03:11PM -0500, Sasha Levin wrote:
> > > > > > On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> > > > > > > Hi stable team - please don't take patches for fs/bcachefs/ except from
> > > > > > > myself; I'll be doing backports and sending pull requests after stuff
> > > > > > > has been tested by my CI.
> > > > > > > 
> > > > > > > Thanks, and let me know if there's any other workflow things I should
> > > > > > > know about
> > > > > > 
> > > > > > Sure, we can ignore fs/bcachefs/ patches.
> > > > > 
> > > > > I see that you even acked this.
> > > > > 
> > > > > What the fuck?
> > > > 
> > > > Accidents happen, you were copied on those patches.  I'll go drop them
> > > > now, not a big deal.
> > > 
> > > Wait, why are you doing "Fixes:" with an empty tag in your commits like
> > > 1a1c93e7f814 ("bcachefs: Fix missing bch2_err_class() calls")?
> > > 
> > > That's messing with scripts and doesn't make much sense.  Please put a
> > > real git id in there as the documentation suggests to.
> > 
> > There isn't always a clear-cut commit when a regression was introduced
> > (it might not have been a regresison at all). I could dig and make
> > something up, but that's slowing down your workflow, and I thought I was
> > going to be handling all the stable backports for fs/bcachefs/, so - ?
> > 
> 
> Doesn't matter, please do not put "fake" tags in commit messages like
> this.  It hurts all of the people that parse commit logs.  Just don't
> put a fixes tag at all as the documentation states that after "Fixes:" a
> commit id belongs.

So you manually repicked a subset of my pull request, and of the two
patches you silently dropped, one was a security fix - and you _never
communicated_ what you were doing.

Greg, this isn't working. How are we going to fix this?

