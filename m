Return-Path: <stable+bounces-203532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25673CE6AEA
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC0F3007C67
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7430FC13;
	Mon, 29 Dec 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q210X5Vc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7730F54C;
	Mon, 29 Dec 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011358; cv=none; b=XQAcPfWpTFfFlkO8JM9iDikIFDPeXOofdyOB1ZVaq2/RxVgXHjnvEFbaeaHvXzSFZ2RZ/vxd3hFFl4gnhPKA9uiW41Uopfpx+95GxMFobDjmyn8OizISu7O+8O9FKnV0b3XtoaI4Zpk+RBEnL98c4fA0/9j9eputFLAzSih8M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011358; c=relaxed/simple;
	bh=XyqUhb/K2htDC2r1wXWToLcYiXo1q8Eg6FXv4WSImw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSupKS6qlskhsS8rden3/UcYlOcQh14aP0/i44nJIZhIQ3Lmcal+hUF3Z3Qbk7Uguzu/jF8Cdt3GsRJSAd5G/vesJfobi0Shk9iPzNvrLtdtJVDyqz+lPu8tVT58JOlH3n24JW9nMD6K7aEA4kstLp62wuyLS193fq6SPJP6SWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q210X5Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D69C4CEF7;
	Mon, 29 Dec 2025 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767011357;
	bh=XyqUhb/K2htDC2r1wXWToLcYiXo1q8Eg6FXv4WSImw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q210X5VcPRx8ksKNpcYv6LnEj/eNeT0SrgBeEz7UKZMJsw07tlpGhL10rdPMnr+Hn
	 Wf1w04hyzG31tJbo0041XDLCwi/jORumGNn/Cqq2VAiv+2I9uLtAC/8HgUELkDGcxp
	 pH/gExVs/Rbvdwp7si2ddzPjoGy4/cbuOO8IVRBk=
Date: Mon, 29 Dec 2025 13:29:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: pmladek@suse.com, sherry.sun@nxp.com, stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Subject: Re: Patch "printk: Avoid scheduling irq_work on suspend" has been
 added to the 6.18-stable tree
Message-ID: <2025122909-unrushed-lubricate-3a07@gregkh>
References: <2025122945-trial-frosted-cef9@gregkh>
 <877bu58owy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bu58owy.fsf@jogness.linutronix.de>

On Mon, Dec 29, 2025 at 01:21:25PM +0106, John Ogness wrote:
> Hi Greg,
> 
> On 2025-12-29, <gregkh@linuxfoundation.org> wrote:
> > This is a note to let you know that I've just added the patch titled
> >
> >     printk: Avoid scheduling irq_work on suspend
> >
> > to the 6.18-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      printk-avoid-scheduling-irq_work-on-suspend.patch
> > and it can be found in the queue-6.18 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> This patch should be accompanied with the preceeding commit:
> 
> d01ff281bd9b ("printk: Allow printk_trigger_flush() to flush all types")
> 
> and the later commit:
> 
> 66e7c1e0ee08 ("printk: Avoid irq_work for printk_deferred() on suspend")
> 
> in order to completely avoid irq_work triggering during suspend for all
> possible call paths.

Thanks, now both queued up.

greg k-h

