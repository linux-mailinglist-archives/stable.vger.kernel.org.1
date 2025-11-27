Return-Path: <stable+bounces-197500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA6C8F205
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18E81357EED
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AB334C19;
	Thu, 27 Nov 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GnaJ78fP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C067334373
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256001; cv=none; b=OJBYw4gr1WyVloEk0WSWLNRuiMJvJGhUP4ZEpP7q+fW2HsJDFLJkCeCrgGL4VZKLJXUF2xv9pjybK+W1CpttSXyg03IwT2uSLAQInF5ZgmtY9brE346tQqyVOEoMF+3t6KQzRXY8LGnbYNfUBExMg2ufen6ncmPYu6QDMcs8ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256001; c=relaxed/simple;
	bh=kqUuQl5N/1WPyTGCD1JuIC5I1IVeqILtr8tIT3hTP4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWPbnZqrs7Mee5tYbC4us6R9RwpIbjyl75ZNj9AAjIrSp3ndlHWA6FxB90JCU3AnTIpIqxoJDGhhFo+ZS4/loLsFgms9/+W/Ja58dKpoJY4qvZFOq8oKEUns4PSCbyBsU8YUQ3DijNnPa0xCp3H5wzwP7AABnBZHkJdUa6FUL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GnaJ78fP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC29BC4CEF8;
	Thu, 27 Nov 2025 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764256001;
	bh=kqUuQl5N/1WPyTGCD1JuIC5I1IVeqILtr8tIT3hTP4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnaJ78fPcKysW/S3M6xCo3dAvKlqDeM/YdhB2t8319CLbEYa+mATGoF8icUqiU2mh
	 71OTo/tc0g0l9dreATt//zSxrOFNWgMp7e4b1NvJ49kCnTmFrr4duM0MrqOkfHXLc4
	 JLGb82AOnfi1vT0Bh4Fpf3MLOuqk0gwygEP2UuRY=
Date: Thu, 27 Nov 2025 16:03:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org,
	linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <2025112726-bovine-snare-3147@gregkh>
References: <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
 <aSWl95gPfnaaq1gR@opensource.cirrus.com>
 <2025112757-squash-hesitant-d8d6@gregkh>
 <aShagMFXfpIYyJPO@opensource.cirrus.com>
 <2025112721-suggest-truth-bfb4@gregkh>
 <aShb2K1brBmQtioZ@opensource.cirrus.com>
 <2025112716-glimpse-deface-db74@gregkh>
 <CAMRc=MegBo8vxEMd=9tt91SQie9u9_46Z00jzzZXGcvVQs5w5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MegBo8vxEMd=9tt91SQie9u9_46Z00jzzZXGcvVQs5w5Q@mail.gmail.com>

On Thu, Nov 27, 2025 at 03:45:29PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 27, 2025 at 3:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Nov 27, 2025 at 02:10:32PM +0000, Charles Keepax wrote:
> > > On Thu, Nov 27, 2025 at 03:07:48PM +0100, Greg KH wrote:
> > > > On Thu, Nov 27, 2025 at 02:04:48PM +0000, Charles Keepax wrote:
> > > > > On Thu, Nov 27, 2025 at 02:51:50PM +0100, Greg KH wrote:
> > > > > > On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> > > > > > > On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > > > > > > > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > > > > > > > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > > > > > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > > > > > > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > > > > > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > > > > Do we have to wait for the fixes to hit Linus's tree before
> > > > > > > pushing them to stable? As they are still in Philipp Zabel's
> > > > > > > reset tree at the moment and I would quite like to stem the
> > > > > > > rising tide of tickets I am getting about audio breaking on
> > > > > > > peoples laptops as soon as possible.
> > > > > >
> > > > > > Yes, we need the fixes there first.
> > > > >
> > > > > Fair enough, but it is super sad that everyone has to sit around
> > > > > with broken devices until after the merge window. This is not a
> > > > > theoretical issue people are complaining about this now.
> > > >
> > > > Are people sitting around with this issue in 6.18-rc releases now?  Is
> > > > 6.18-final going to be broken in the same way?
> > >
> > > Yeah regrettably that is going to be broken too, at least until
> > > the first stable release either does the same revert or backports
> > > the same fixes.
> >
> > Great, we are "bug compatible!"  :)
> >
> > Seriously, this happens for minor things all the time, not that big of a
> > deal normally.
> >
> 
> Just my two cents: this feature interacts quite a lot with another new
> feature: shared GPIOs in GPIOLIB. I've already either queued or have
> under review ~7 other fixes. Since in stable, the code from this
> series would not interact with gpiolib-shared (because no way this
> should get backported), we'd still have a bit of a different
> environment in mainline and stable branches.
> 
> I would very much prefer to revert the patch in question than worry
> about divergences in logic.

Ok, fair enough, now reverted!

thanks,

greg k-h

