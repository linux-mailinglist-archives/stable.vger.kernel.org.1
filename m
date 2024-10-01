Return-Path: <stable+bounces-78354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7698B867
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4EA1C22171
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7E19CC32;
	Tue,  1 Oct 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFWdheH5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF332B9B0;
	Tue,  1 Oct 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775139; cv=none; b=WoPB4tNC0GKWhqKtezNzAfxsYKrYyywj6046XGy93ak8qL+/bre7y3d0C5ifduZMWi1eGtruYTNGi5gaa4DmqLL9VWXk11wpGX2N1/Q1eEZoyt7o/zIP07BCBNYYjS9ngzlnAeBjPDhvjudY2t3AAilogi5mIhHmp0i7PXK2ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775139; c=relaxed/simple;
	bh=A277t4MvCLhx6tJFdzkWn5fv1UpPOKHjwo9fuI2GPUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn8EGpQxdAz4FlgrrXe95/+YP6nTR9BRKeg5B8ooxvXW9nRccB/FA9IZ77OrPeeUMRlAtyHan3FNxo+9MBzWOyrKGyPM50xxicr59NuzriEcD4dA3u/j/bwIrTbBRNQF6+LcFHz9Rl5nndTg7EGj7dj4qrGMwp5tlXy187ETMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFWdheH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7108CC4CEC6;
	Tue,  1 Oct 2024 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727775138;
	bh=A277t4MvCLhx6tJFdzkWn5fv1UpPOKHjwo9fuI2GPUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFWdheH56Cshy2M0WEMignyUOiVPwTF5zUk6+ZlXflF4twVhOrIO8w1gY4UEa+9gO
	 E5k4b+qayUeFrR6ukJiec5yxF0JRaYyh3r53Ctc09JtHI8GSSL/tVhcS8/0/TrsMMJ
	 BGyoQl1p/RHxVD91B1exK/qobTyA4kvvawCAgZt8=
Date: Tue, 1 Oct 2024 11:32:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	ruanjinjie@huawei.com
Subject: Re: Patch "Input: ps2-gpio - use IRQF_NO_AUTOEN flag in
 request_irq()" has been added to the 5.15-stable tree
Message-ID: <2024100134-talcum-angular-6e20@gregkh>
References: <20241001002900.2628013-1-sashal@kernel.org>
 <Zvu8GiY4PxqTQPD0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvu8GiY4PxqTQPD0@google.com>

On Tue, Oct 01, 2024 at 02:08:42AM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 30, 2024 at 08:28:59PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      input-ps2-gpio-use-irqf_no_autoen-flag-in-request_ir.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> For the love of God, why? Why does this pure cleanup type of change
> needs to be in stable?

Because someone said:

> > commit 2d007ddec282076923c4d84d6b12858b9f44594a
> > Author: Jinjie Ruan <ruanjinjie@huawei.com>
> > Date:   Thu Sep 12 11:30:13 2024 +0800
> > 
> >     Input: ps2-gpio - use IRQF_NO_AUTOEN flag in request_irq()
> >     
> >     [ Upstream commit dcd18a3fb1228409dfc24373c5c6868a655810b0 ]
> >     
> >     disable_irq() after request_irq() still has a time gap in which
> >     interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> >     disable IRQ auto-enable when request IRQ.

Looks like a bug fix, and also:

> >     Fixes: 9ee0a0558819 ("Input: PS/2 gpio bit banging driver for serio bus")

Someone marked it as such.

I'll go drop it, but really, don't mark things as fixes if they really
are not.

thanks,

greg k-h

