Return-Path: <stable+bounces-62735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07031940ED9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76CB283844
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B024194AD7;
	Tue, 30 Jul 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3rSuNUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A49208DA;
	Tue, 30 Jul 2024 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334843; cv=none; b=XAoi0+AenvXUULUyd3j8CjQ8COmA245dj2p9ejaLNs6uw2JXPgl5BF3CwxOYHljUuhtPkq70to9XNg6Gq+Bc8IO+ZJpyWMg9DRRoE1qQ0qwv1+WIq2OMCbxnm5xyCM2oKit1NmcdbrMqj1qd7N65KBoZ+r/y1vkDUq77K6duQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334843; c=relaxed/simple;
	bh=5kuY+GXkSu2+PSobo1SL9QjXJZESAQjxDibn3e5uTmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVTbJurL6WNG+G9ct3ISc2fu4JurG7u0e9+r3ZeRMUZT1xpw+3Y/XrOCYGXMfP/bQNQOf0cK3YmEn8jgwG9HrgMdeaeept1hjda93QJv9nNmQKE3Zb1vL7O5t176aNHf4SmuNwwAbyC2NXkQNYN4KKXboi5JxUXwMbIBns3ZgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3rSuNUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302FCC4AF09;
	Tue, 30 Jul 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722334842;
	bh=5kuY+GXkSu2+PSobo1SL9QjXJZESAQjxDibn3e5uTmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3rSuNUkYKBBuYyJOOw9KBi/Rfc/IV1bBGaLZFuUQmm9Klpg2ck7HkjLM1rFY+rY0
	 ikFf1AIJ3o6hKN4NEm+1kny/iuHxkLdPjB5H7XglDGmzc8dX72kycNB7f/421/bkED
	 gNBNqqwSXm0g0BrkV0yMNUOkBRDo8p7Qt94FvEqo=
Date: Tue, 30 Jul 2024 12:20:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: dongml2@chinatelecom.cn, linux-kernel@vger.kernel.org,
	menglong8.dong@gmail.com, mingo@redhat.com, peterz@infradead.org,
	stable@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated
 domain
Message-ID: <2024073000-uncouple-stipend-2062@gregkh>
References: <2024073011-operating-pointless-7ab9@gregkh>
 <tencent_16253196C5C7F0141593B633CA21A0150505@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_16253196C5C7F0141593B633CA21A0150505@qq.com>

On Tue, Jul 30, 2024 at 06:11:06PM +0800, wujing wrote:
> > On Tue, Jul 30, 2024 at 05:40:17PM +0800, wujing wrote:
> > > > What "current patch"?
> > > >
> > > > confused,
> > > >
> > > > greg k-h
> > >
> > > The current patch is in my first email.
> >
> > What message exactly?  I don't see any such message on the stable list.
> >
> > > Please ignore the previous two emails.
> > > The "current patch" mentioned in the earlier emails refers to the upstream
> > > status, but the latest upstream patch can no longer be applied to linux-4.19.y.
> >
> > Again, please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> >
> > thanks,
> >
> > greg k-h
> 
> The email you just replied to is correct.
> 
> I reviewed the link in the email, and according to the link,
> the patch I submitted meets the third criterion. I have noted
> Upstream commit <8aeaffef8c6e> in the patch log.
> 
> 
> 
> >From 9d4ecc9314088c2b0aa39c2248fb5e64042f1eef Mon Sep 17 00:00:00 2001
> From: wujing <realwujing@gmail.com>
> Date: Tue, 30 Jul 2024 15:35:53 +0800
> Subject: [PATCH] sched/fair: Correct CPU selection from isolated domain
> 
> We encountered an issue where the kernel thread `ksmd` runs on the PMD
> dedicated isolated core, leading to high latency in OVS packets.
> 
> Upon analysis, we discovered that this is caused by the current
> select_idle_smt() function not taking the sched_domain mask into account.
> 
> Upstream commit <8aeaffef8c6e>
> 
> Kernel version: linux-4.19.y

This is not in a format that I can take.

Also, this does not match that commit id, so you need to document it
really really well why this is different.

And you lost the original authorship information, and the reviews.

And finally, we can't take a change for 4.19.y that is also not in newer
kernel releases, because if we did that, and you upgraded, you would
have a regression.

But most importantly, why are you still doing stuff on 4.19.y?  This
kernel is going to go end-of-life very soon, and you should already have
all of your systems that rely on it off of it by now, or planned to
within a few months.  To not do that is to ensure that you will end up
with insecure systems when the end-of-life deadline happens.

thanks,

greg k-h

