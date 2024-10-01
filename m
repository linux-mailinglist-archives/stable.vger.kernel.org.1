Return-Path: <stable+bounces-78455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139B98BADB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC87B20E9E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F941BF7E7;
	Tue,  1 Oct 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Godm5rbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E121BF7F9;
	Tue,  1 Oct 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781590; cv=none; b=CwFF4/SRxSpSUo0MuUlucU3ThN9nbmt6Ox/kTQX92la1Vj2BHkqeg1TLn//Ow3rlR3f7XWJPtccBBhRG0k5TuxxYIePmRlwxlAWWZb6OoEPFkg5arGV+jzMrO4+fjoK7Abf87n739oCeLg/nXQqz6clULwEInuOd4PrRY1XRCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781590; c=relaxed/simple;
	bh=UjAVLKs0KDdXi5voWzIKbUWSHZkg90qQyL9jxLlZnbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRxgoYLWJ+6EmOqsLpk2NHjEIB/rrkr3cnFD+W/01pl8Ht63XPWgUO2BMDDzgvTkGXkQipytSZEBBoSwlyeL9y0RMDRL5xqnR8BoIoFrboHFdnXtsuB754YBNcHyqoUhyFc/DkY7WynjuJBeAwoAvuiCAvAu6UJ4WgvUd0b5p+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Godm5rbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEF4C4CEC6;
	Tue,  1 Oct 2024 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727781590;
	bh=UjAVLKs0KDdXi5voWzIKbUWSHZkg90qQyL9jxLlZnbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Godm5rbES0bkq8Mgf+N4EiNcAvmNr5TD3p+Fg1LWDxsN0By33QjHufRVAb4eWG0e4
	 IMFpEmbzs5DHAPWaPH80SSm0n339+FCslx681+3bl6j0Y+y500iHxiBtZH8L1isSPv
	 ELX36+LphrN3gkuydhPDcOXcYe6Ub2DdEi31D29A=
Date: Tue, 1 Oct 2024 13:19:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <2024100155-scalded-salon-a744@gregkh>
References: <20241001002900.2628013-1-sashal@kernel.org>
 <Zvu8GiY4PxqTQPD0@google.com>
 <2024100134-talcum-angular-6e20@gregkh>
 <ZvvIJX1IzHy8DCl7@google.com>
 <2024100149-repugnant-unrelated-5974@gregkh>
 <ZvvTJD20aLHgHY7q@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvTJD20aLHgHY7q@google.com>

On Tue, Oct 01, 2024 at 03:47:00AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 01, 2024 at 12:05:56PM +0200, Greg KH wrote:
> > On Tue, Oct 01, 2024 at 03:00:05AM -0700, Dmitry Torokhov wrote:
> > > On Tue, Oct 01, 2024 at 11:32:16AM +0200, Greg KH wrote:
> > > > On Tue, Oct 01, 2024 at 02:08:42AM -0700, Dmitry Torokhov wrote:
> > > > > On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> > > > > > This is a note to let you know that I've just added the patch titled
> > > > > > 
> > > > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > > > > 
> > > > > > to the 5.15-stable tree which can be found at:
> > > > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > > > 
> > > > > > The filename of the patch is:
> > > > > >      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> > > > > > and it can be found in the queue-5.15 subdirectory.
> > > > > > 
> > > > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > > > please let <stable@vger.kernel.org> know about it.
> > > > > 
> > > > > For the love of God, why? Why does this pure cleanup type of change
> > > > > needs to be in stable?
> > > > 
> > > > Because someone said:
> > > > 
> > > > > > commit 2d007ddec282076923c4d84d6b12858b9f44594a
> > > > > > Author: Jinjie Ruan <ruanjinjie@huawei.com>
> > > > > > Date:   Thu Sep 12 11:30:13 2024 +0800
> > > > > > 
> > > > > >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > > > > >     
> > > > > >     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
> > > > > >     
> > > > > >     disable_irq() after request_irq() still has a time gap in which
> > > > > >     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > > > > >     disable IRQ auto-enable when request IRQ.
> > > > 
> > > > Looks like a bug fix, and also:
> > > > 
> > > > > >     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")
> > > > 
> > > > Someone marked it as such.
> > > > 
> > > > I'll go drop it, but really, don't mark things as fixes if they really
> > > > are not.
> > > 
> > > They are fixes, they just do not belong to stable and that is why they
> > > are not marked as such.
> > 
> > Ok, if your subsystem will always mark this type of thing properly, we
> > will be glad to add you to the "don't take any Fixes: only commits" to
> > the list that we keep.  Here's the subsystems that we currently do this
> > for:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list
> > 
> > what regex should we use for this list?
> 
> Let's do:
> 
> 	drivers/input/*
> 
> and see how it goes.

Ok, now added, thanks!

