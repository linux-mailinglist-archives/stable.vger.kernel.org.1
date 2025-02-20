Return-Path: <stable+bounces-118473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8BBA3E05E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DE719C0082
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287020485F;
	Thu, 20 Feb 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IWJEYbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7B1FF7C3;
	Thu, 20 Feb 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068370; cv=none; b=nirfQlbe0fSeHCT9UkABruw2EDeaehmTx7uy6XrVln+9ZqMdTVFDY91+YMyaOSpiErjajEcACbHtiQBleMmix5+4BMgWSdcuyD4qNq9olkh/GepGfvhb7wZoJ0drpRatBW3PT5P9koyOYmmyq1V/pJel1lHceUNM+Xk+9dahwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068370; c=relaxed/simple;
	bh=fdNUkWYIqBHHk1Go5mS2hsO50NlDOAYmlPsOmBBjZlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY2l03Skn3Pqoix/p2XCc7dR0CoeqZ9LmjR33H6USvvg7Ohl2+8kLC58zV+l10EZoIh7LXSHeTwIDWHhZ+yed4BMnUeSCBJxmSFC7m49Lax4hYWnMgN46nW63cjqgD3cSyZhGLwTDi0hbq7va/PUxUQqFRgzFszyD2B5WNKGElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1IWJEYbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A253C4CED1;
	Thu, 20 Feb 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740068369;
	bh=fdNUkWYIqBHHk1Go5mS2hsO50NlDOAYmlPsOmBBjZlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1IWJEYbswD+naPjeNo5FuOFVhsGLrJofycv1yDl5WSTL52fwYUtfFNeUHS8Oa8AXR
	 V+g9s4tgdRdEhH2td2TixDDT01QKffhpCISQ35siDl30FtTZCp1bTZvk3SgOtJNhzK
	 V173iCyMghCLpORb/jZl6f70iQZj5wcLlSHNdnvc=
Date: Thu, 20 Feb 2025 17:19:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-sound@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: avoid use-after-free on
 device name
Message-ID: <2025022019-enigmatic-mace-60ca@gregkh>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
 <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
 <2025022004-scheming-expend-b9b3@gregkh>
 <D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>

On Thu, Feb 20, 2025 at 04:46:59PM +0100, Théo Lebrun wrote:
> On Thu Feb 20, 2025 at 3:06 PM CET, Greg Kroah-Hartman wrote:
> > On Thu, Feb 20, 2025 at 02:31:29PM +0100, Théo Lebrun wrote:
> >> On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
> >> > On Tue, Feb 18, 2025 at 12:00:11PM +0100, Théo Lebrun wrote:
> >> >> The solution proposed is to add a flag to platform_device that tells if
> >> >> it is responsible for freeing its name. We can then duplicate the
> >> >> device name inside of_device_add() instead of copying the pointer.
> >> >
> >> > Ick.
> >> >
> >> >> What is done elsewhere?
> >> >>  - Platform bus code does a copy of the argument name that is stored
> >> >>    alongside the struct platform_device; see platform_device_alloc()[1].
> >> >>  - Other busses duplicate the device name; either through a dynamic
> >> >>    allocation [2] or through an array embedded inside devices [3].
> >> >>  - Some busses don't have a separate name; when they want a name they
> >> >>    take it from the device [4].
> >> >
> >> > Really ick.
> >> >
> >> > Let's do the right thing here and just get rid of the name pointer
> >> > entirely in struct platform_device please.  Isn't that the correct
> >> > thing that way the driver core logic will work properly for all of this.
> >> 
> >> I would agree, if it wasn't for this consideration that is found in the
> >> commit message [0]:
> >
> > What, that the of code is broken?  Then it should be fixed, why does it
> > need a pointer to a name at all anyway?  It shouldn't be needed there
> > either.
> 
> I cannot guess why it originally has a separate pdev->name field.

Many people got this wrong when we designed busses, it's not unique.
But we should learn from our mistakes where we can :)

> >> > It is important to duplicate! pdev->name must not change to make sure
> >> > the platform_match() return value is stable over time. If we updated
> >> > pdev->name alongside dev->name, once a device probes and changes its
> >> > name then the platform_match() return value would change.
> >> 
> >> I'd be fine sending a V2 that removes the field *and the fallback* [1],
> >> but I don't have the full scope in mind to know what would become broken.
> >> 
> >> [0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bootlin.com/
> >> [1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/platform.c#L1357
> >
> > The fallback will not need to be removed, properly point to the name of
> > the device and it should work correctly.
> 
> No, it will not work correctly, as the above quote indicates.

I don't know which quote, sorry.

> Let's assume we remove the field, this situation would be broken:
>  - OF allocates platform devices and gives them names.
>  - A device matches with a driver, which gets probed.
>  - During the probe, driver does a dev_set_name().
>  - Afterwards, the upcoming platform_match() against other drivers are
>    called with another device name.
> 
> We should be safe as there are guardraids to not probe twice a device,
> see __driver_probe_device() that checks dev->driver is NULL. But it
> isn't a situation we should be in.

The fragility of attempting to match a driver to a device purely by a
name is a very week part of using platform devices.

Why would a driver change the device name?  It's been given to the
driver to "bind to" not to change its name.  That shouldn't be ok, fix
those drivers.

> Another broken situation:
>  - OF allocates platform devices and gives them names.
>  - A device matches with a driver, which gets probed based on its name.
>  - During the probe, driver does a dev_set_name().

Again, don't do that.  That's the breaking part.

>  - Module is removed.
>  - Module is re-added, the (driver, device) pair don't end up matching
>    again because the device name changed.

Sure, that was a bug in the driver.  It shouldn't be changing the name,
the name is set/owned by the bus, not the driver.

Do we have examples today of platform drivers that like to rename
devices?  I did a quick search and couldn't find any in-tree, but I
might have missed some.

Again, the bus controls the name when the device is created, changing it
after the fact is generally not a good idea.

> I might be missing other edge-cases.
> 
> Conclusion: we need a constant name for platform devices as we want the
> return value of platform_match() to stay stable across time.

No, let's just not rename devices in platform drivers.

Or if this really is an issue, let's fix OF to not use the platform bus
and have it's own bus for stuff like this.

thanks,

greg k-h

