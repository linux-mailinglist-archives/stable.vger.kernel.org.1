Return-Path: <stable+bounces-197117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB61C8EBAF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E5E4E35ED
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52C24291E;
	Thu, 27 Nov 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H54urlEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5301239E79
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253065; cv=none; b=g98KU+ZiR3FYGZdQOQFukJjVxyEtlLdJrpDbHjiOHWBiES/Hxp06xX15K/VXnMJgYFDjEFw7cEmX60JmhHB6vFT13NxvilI9aFo38J8w3n4RX0X2ZvLxVWObnII6y+zuTyrQUG7BgFlDkdbcXaBKa7TJLdUmrKo88gdH88rz8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253065; c=relaxed/simple;
	bh=dxTWAd8KdAQvX7Xiz9imUgASCHKs8qsKvrsO8Y+66oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2SBHWn7bG1LB+9VxuIegz0czrFE+iTrAVV596/uL0iUusznragTe/W2+JAdZS7WglJ+LU8MvirVoE7Oza3K8Qvar2hHu/bAk3BiQYKm2oMN7TyN8RSa6avHdQMckLz4zW1o9Orib0ilCSZPMJ0GbHvXGW6nGOkMIVhuL/8eC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H54urlEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368A2C4CEF8;
	Thu, 27 Nov 2025 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764253065;
	bh=dxTWAd8KdAQvX7Xiz9imUgASCHKs8qsKvrsO8Y+66oQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H54urlEw8A8zZnVKpohYzDmdPUf4nZcXGzJ2rurMKMwyQ9yPrXSZCA6mQ9OoK7Xm2
	 AVu3X9a4UKxdsGb6rL4/6Lg8nrdNiYGvygzGmyA4InWmkNMbIORC/0ado6B5Yw0b+l
	 UTrcwPH/QmCbNdNKOBWculpMh9rt8MjE2s4TI/MU=
Date: Thu, 27 Nov 2025 15:17:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <2025112716-glimpse-deface-db74@gregkh>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
 <aSWl95gPfnaaq1gR@opensource.cirrus.com>
 <2025112757-squash-hesitant-d8d6@gregkh>
 <aShagMFXfpIYyJPO@opensource.cirrus.com>
 <2025112721-suggest-truth-bfb4@gregkh>
 <aShb2K1brBmQtioZ@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aShb2K1brBmQtioZ@opensource.cirrus.com>

On Thu, Nov 27, 2025 at 02:10:32PM +0000, Charles Keepax wrote:
> On Thu, Nov 27, 2025 at 03:07:48PM +0100, Greg KH wrote:
> > On Thu, Nov 27, 2025 at 02:04:48PM +0000, Charles Keepax wrote:
> > > On Thu, Nov 27, 2025 at 02:51:50PM +0100, Greg KH wrote:
> > > > On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> > > > > On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > > > > > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > > > > > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > > > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > > > > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > > > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > Do we have to wait for the fixes to hit Linus's tree before
> > > > > pushing them to stable? As they are still in Philipp Zabel's
> > > > > reset tree at the moment and I would quite like to stem the
> > > > > rising tide of tickets I am getting about audio breaking on
> > > > > peoples laptops as soon as possible.
> > > > 
> > > > Yes, we need the fixes there first.
> > > 
> > > Fair enough, but it is super sad that everyone has to sit around
> > > with broken devices until after the merge window. This is not a
> > > theoretical issue people are complaining about this now.
> > 
> > Are people sitting around with this issue in 6.18-rc releases now?  Is
> > 6.18-final going to be broken in the same way?
> 
> Yeah regrettably that is going to be broken too, at least until
> the first stable release either does the same revert or backports
> the same fixes.

Great, we are "bug compatible!"  :)

Seriously, this happens for minor things all the time, not that big of a
deal normally.

thanks,

greg k-h

