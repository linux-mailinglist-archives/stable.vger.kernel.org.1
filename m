Return-Path: <stable+bounces-118444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16602A3DC17
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8624E16BD0E
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4C1B87EE;
	Thu, 20 Feb 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btmol7l+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3E1A8F94;
	Thu, 20 Feb 2025 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060392; cv=none; b=unMqydj/LulESYOddfqj63/ooyal//Nmo7UbUcp30faAJgTgP/vmpIyfr54vCvgLi1CEmBIxOKOmxjnCDkdDcyVgmLUGMW8Z+mb90/2D8wGaXjZ6fivEjAMOas1s1UeHV00HxGfM7Jq8nxIHoO9r3dcW97Trg2MPIPZXyxMtvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060392; c=relaxed/simple;
	bh=4oo5bwiM+XhKfUR8UYyGQVQWQ/6Ov6wGIKczUKT0zuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAm3ZB5L12/umHboqDi2IKSuOUVC02hExqFtx4T7Kyce992jW+qF8iqE7reJW6+XimuD8NyDSYByePL0Bkla2uZ5q5+6Yket4rZ3c2G60mXaNLsXzY9Ta8aUBpPuT8PIK6aXS6Jop0zHl/cFQXgNc9PMbxUmn6qeEiCzT0EOXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btmol7l+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B85BC4CEDD;
	Thu, 20 Feb 2025 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740060391;
	bh=4oo5bwiM+XhKfUR8UYyGQVQWQ/6Ov6wGIKczUKT0zuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btmol7l+E9F0Dq7CHFxzj9ptIoP+WuCKdQeF+u8NmZcIuPkyJT5yDE84M3+w0mGE/
	 p/2qSrormQ0zOOprtPL8ucuyM3VHc7dHH7VBp0EWNDJDfNSbLCDVQSzYiq5Orhkqic
	 7RCgsE2BhKYMI1t2f75vNDYQLIB6HMfqUkhwybrk=
Date: Thu, 20 Feb 2025 15:06:28 +0100
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
Message-ID: <2025022004-scheming-expend-b9b3@gregkh>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
 <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>

On Thu, Feb 20, 2025 at 02:31:29PM +0100, Théo Lebrun wrote:
> Hello Greg,
> 
> On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
> > On Tue, Feb 18, 2025 at 12:00:11PM +0100, Théo Lebrun wrote:
> >> The use-after-free bug appears when:
> >>  - A platform device is created from OF, by of_device_add();
> >>  - The same device's name is changed afterwards using dev_set_name(),
> >>    by its probe for example.
> >> 
> >> Out of the 37 drivers that deal with platform devices and do a
> >> dev_set_name() call, only one might be affected. That driver is
> >> loongson-i2s-plat [0]. All other dev_set_name() calls are on children
> >> devices created on the spot. The issue was found on downstream kernels
> >> and we don't have what it takes to test loongson-i2s-plat.
> >> 
> >> Note: loongson-i2s-plat maintainers are CCed.
> >> 
> >>    ⟩ # Finding potential trouble-makers:
> >>    ⟩ git grep -l 'struct platform_device' | xargs grep -l dev_set_name
> >> 
> >> The solution proposed is to add a flag to platform_device that tells if
> >> it is responsible for freeing its name. We can then duplicate the
> >> device name inside of_device_add() instead of copying the pointer.
> >
> > Ick.
> >
> >> What is done elsewhere?
> >>  - Platform bus code does a copy of the argument name that is stored
> >>    alongside the struct platform_device; see platform_device_alloc()[1].
> >>  - Other busses duplicate the device name; either through a dynamic
> >>    allocation [2] or through an array embedded inside devices [3].
> >>  - Some busses don't have a separate name; when they want a name they
> >>    take it from the device [4].
> >
> > Really ick.
> >
> > Let's do the right thing here and just get rid of the name pointer
> > entirely in struct platform_device please.  Isn't that the correct
> > thing that way the driver core logic will work properly for all of this.
> 
> I would agree, if it wasn't for this consideration that is found in the
> commit message [0]:

What, that the of code is broken?  Then it should be fixed, why does it
need a pointer to a name at all anyway?  It shouldn't be needed there
either.

> > It is important to duplicate! pdev->name must not change to make sure
> > the platform_match() return value is stable over time. If we updated
> > pdev->name alongside dev->name, once a device probes and changes its
> > name then the platform_match() return value would change.
> 
> I'd be fine sending a V2 that removes the field *and the fallback* [1],
> but I don't have the full scope in mind to know what would become broken.
> 
> [0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bootlin.com/
> [1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/platform.c#L1357

The fallback will not need to be removed, properly point to the name of
the device and it should work correctly.

thanks,

greg k-h

