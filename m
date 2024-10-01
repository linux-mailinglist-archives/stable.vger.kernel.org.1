Return-Path: <stable+bounces-78386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984B098B8F3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94191C227E6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65B1A0731;
	Tue,  1 Oct 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvJJ1fau"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38719F49F;
	Tue,  1 Oct 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777159; cv=none; b=Dr/WV0IqbeMCrDbE4z2f93Fm0/QxxZ3oigyg6tltfkgd2yiZ399yOTLVT2XTZCy+RmHTnkF6zEDnpKeYdEnPIKipYN79GKsv/EcLvEhfFfAQXR/6QTIm3AMYJ6V8SGKwyz6+6Ul3MGlkEHeBp1Rq7VMnQZzGzfL++LZ8CQCtV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777159; c=relaxed/simple;
	bh=pfsB3sGEmAQ1lJU8i0odaDkthyGPIJqdAygAWPpr+GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul2qITxmDErJStYe4Sff/P3IdcLwKWT7l0O1Gfbo06e09RG62NG5ySLlUF1CYfXTCZb/x3m5UCkNQxO4XYsgGwqTa4yoSQiOgghetHjYaqaAr2iDl+yCzseeXCKVMklRkg8qF3Wm9NoIoC+mPRQYAkYr1PbIhX4Y4Kw95TWN3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvJJ1fau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E472C4CEC6;
	Tue,  1 Oct 2024 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777159;
	bh=pfsB3sGEmAQ1lJU8i0odaDkthyGPIJqdAygAWPpr+GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvJJ1fauSGrRVLKreBtnq9llxXLGZte0mtDF1Tm/W/52EPwqn/yP1UQC7SLFNSHv1
	 dxo/Lz16Pc4yc2Kkvld7F0h6l7s6GMk2YOpTwoRZum8Y75WF5FQgVlFRroFDWjN/BJ
	 0OGrOpu5mUJYt1QZD5sIII/Ojqa2Z+t0m3sOD3Eo=
Date: Tue, 1 Oct 2024 12:05:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <2024100149-repugnant-unrelated-5974@gregkh>
References: <20241001002900.2628013-1-sashal@kernel.org>
 <Zvu8GiY4PxqTQPD0@google.com>
 <2024100134-talcum-angular-6e20@gregkh>
 <ZvvIJX1IzHy8DCl7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvIJX1IzHy8DCl7@google.com>

On Tue, Oct 01, 2024 at 03:00:05AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 01, 2024 at 11:32:16AM +0200, Greg KH wrote:
> > On Tue, Oct 01, 2024 at 02:08:42AM -0700, Dmitry Torokhov wrote:
> > > On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > > 
> > > > to the 5.15-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> > > > and it can be found in the queue-5.15 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > For the love of God, why? Why does this pure cleanup type of change
> > > needs to be in stable?
> > 
> > Because someone said:
> > 
> > > > commit 2d007ddec282076923c4d84d6b12858b9f44594a
> > > > Author: Jinjie Ruan <ruanjinjie@huawei.com>
> > > > Date:   Thu Sep 12 11:30:13 2024 +0800
> > > > 
> > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > >     
> > > >     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
> > > >     
> > > >     disable_irq() after request_irq() still has a time gap in which
> > > >     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > > >     disable IRQ auto-enable when request IRQ.
> > 
> > Looks like a bug fix, and also:
> > 
> > > >     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")
> > 
> > Someone marked it as such.
> > 
> > I'll go drop it, but really, don't mark things as fixes if they really
> > are not.
> 
> They are fixes, they just do not belong to stable and that is why they
> are not marked as such.

Ok, if your subsystem will always mark this type of thing properly, we
will be glad to add you to the "don't take any Fixes: only commits" to
the list that we keep.  Here's the subsystems that we currently do this
for:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

what regex should we use for this list?

thanks,

greg k-h

