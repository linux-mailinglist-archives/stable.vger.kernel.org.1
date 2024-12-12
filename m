Return-Path: <stable+bounces-100922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCAB9EE898
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7841889381
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D08837;
	Thu, 12 Dec 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqJfDKS/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3502147E4
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013027; cv=none; b=WgeRAqRHwC+d/AI9nc1CrDDFPRo0Tpx7PwSNtQo5tbrDXCLlgmrk/TDQ+DKIsHa6MZLXtKLXPtiJMyElXC2Ldsb38f/zzG+QvcVDH7fBO8G+H3GM/Fe6903gDrJBnKWHdWe159kgc5Usy9xUDosxZZsiZ9ndMwHEy4PoUn1oekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013027; c=relaxed/simple;
	bh=aQ6SrqOSuqKMxfyUzgq0+6q0K4TEMvhavYDwG7p5Jkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elEQPa6RkCDWlm16/ZzE49vE8cxKoI2uny22I/H+Ef0cd/DAW9S9RrxS4tAmU0fy6owGuyoqdyIOlScBUyMh1HGQJg0zttdWkPpD7DxLVPWKmZvUexv5C17oHxjY1RPB1Mq0Xp5BG6QPW7kQQI/f5izCaH6rO/Hx/Wc2iDY25Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqJfDKS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1610C4CECE;
	Thu, 12 Dec 2024 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734013026;
	bh=aQ6SrqOSuqKMxfyUzgq0+6q0K4TEMvhavYDwG7p5Jkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqJfDKS/RC5zMvh244X9hk0PN4D/Vjb+08c97ESIvlmTqEG5d1er7kLRTIHopqj0i
	 Y70/yuWcEbOygIETc6VpB5K7eoxG5omJjqUi9an49I6lgTpiCi4YrezmorwXxld3Mv
	 lKe3hh9t8Pp0ZD2ssdx6I7GA/q8s1PBEicVjWaas=
Date: Thu, 12 Dec 2024 15:17:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource: Make negative motion
 detection more robust" failed to apply to 6.12-stable tree
Message-ID: <2024121232-obligate-varsity-e68f@gregkh>
References: <2024121203-griminess-blah-4e97@gregkh>
 <87ikrp9f59.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikrp9f59.ffs@tglx>

On Thu, Dec 12, 2024 at 02:58:42PM +0100, Thomas Gleixner wrote:
> On Thu, Dec 12 2024 at 14:03, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 76031d9536a076bf023bedbdb1b4317fc801dd67
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121203-griminess-blah-4e97@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Possible dependencies:
> >
> 
> There clearly is a dependency:
> 
> > From 76031d9536a076bf023bedbdb1b4317fc801dd67 Mon Sep 17 00:00:00 2001
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Tue, 3 Dec 2024 11:16:30 +0100
> > Subject: [PATCH] clocksource: Make negative motion detection more robust
> 
> <snip>
> 
> > Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")
> 
> This was merged in the 6.13 merge window into Linus tree and not
> backported to 6.12.y according to my clone of the stable tree.
> 
> AI went sideways?

Nope, that commit is now in all of the stable queues, which is why I
added this backport.  Or attempted to.

> But I don't think these two commits are necessarily stable material,
> though I don't have a strong opinion on it. If c163e40af9b2 is
> backported, then it has it's own large dependency chain on pre 6.10
> kernels...

It's in the queues for some reason, let me figure out why...


