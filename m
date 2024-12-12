Return-Path: <stable+bounces-100923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED49EE89C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF9818876A9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508B2144A8;
	Thu, 12 Dec 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6afC43k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B7213E92
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013112; cv=none; b=Vr1veom4AjdgyTHYaUw9zczt2MxOt1u3SGkOuPAwzDcoFEOM4tECwcnp+i2UEiUgB1TqcR+vU6zQx4C5N2zZavwRVNlmVMGQ6E4dnLQw68LpCkKIPxRiVqZk/73RDCFXlW+mxtzLK4sJ7I5nAEnzTfAqJ7hX1UwuJ43w9lOSXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013112; c=relaxed/simple;
	bh=QPI91ScTFNWrSsRB8mLlod3lZYSLc/ngd+AsbIrh/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7WjjFp9HmQugq/iob3M8EyrKLwHXqcWezmEdxNyTVnnNhONqBaOUxNbVH7AS3b8NYlUXEiBem6B+zy4I5boiPzf/+PsU1D9e3pOU+giiaWd6kiXwr3rGYQJtXPIFC9SX/T7zYAm72K8L2z55hfS13kJfM7saUloL7NuH2qVmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6afC43k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F40AC4CECE;
	Thu, 12 Dec 2024 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734013111;
	bh=QPI91ScTFNWrSsRB8mLlod3lZYSLc/ngd+AsbIrh/+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6afC43kCuVo17yK1qZfgcD3/y5Lxmj6Py+3nmsP2nP1ayASnIp3FSEblYDbySmml
	 Aj69Y0YcX4hoVLQ3tEydo0lYyow5ZHprH5/HBaz6+kPX5ddMv+g6LLsZmBY5bKvofn
	 HdilsHxTvXnZb+g5cOCjAMGXNGwKJVGP/bwnAGxw=
Date: Thu, 12 Dec 2024 15:18:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
Message-ID: <2024121235-impale-paddle-8f94@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
 <87ikrp9f59.ffs@tglx>
 <2024121232-obligate-varsity-e68f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121232-obligate-varsity-e68f@gregkh>

On Thu, Dec 12, 2024 at 03:17:03PM +0100, Greg KH wrote:
> On Thu, Dec 12, 2024 at 02:58:42PM +0100, Thomas Gleixner wrote:
> > On Thu, Dec 12 2024 at 14:03, gregkh@linuxfoundation.org wrote:
> > > The patch below does not apply to the 6.12-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 76031d9536a076bf023bedbdb1b4317fc801dd67
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121203-griminess-blah-4e97@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > >
> > > Possible dependencies:
> > >
> > 
> > There clearly is a dependency:
> > 
> > > From 76031d9536a076bf023bedbdb1b4317fc801dd67 Mon Sep 17 00:00:00 2001
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > Date: Tue, 3 Dec 2024 11:16:30 +0100
> > > Subject: [PATCH] clocksource: Make negative motion detection more robust
> > 
> > <snip>
> > 
> > > Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")
> > 
> > This was merged in the 6.13 merge window into Linus tree and not
> > backported to 6.12.y according to my clone of the stable tree.
> > 
> > AI went sideways?
> 
> Nope, that commit is now in all of the stable queues, which is why I
> added this backport.  Or attempted to.
> 
> > But I don't think these two commits are necessarily stable material,
> > though I don't have a strong opinion on it. If c163e40af9b2 is
> > backported, then it has it's own large dependency chain on pre 6.10
> > kernels...
> 
> It's in the queues for some reason, let me figure out why...

Ah, it was an AUTOSEL thing, I'll go drop it from all queues except
6.12.y for now, thanks.

But, for 6.12.y, we want this fixup too, right?

greg k-h

