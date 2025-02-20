Return-Path: <stable+bounces-118504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C733A3E449
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40567A9D34
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732F2638AC;
	Thu, 20 Feb 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8bjeQvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6594262D3F;
	Thu, 20 Feb 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077746; cv=none; b=TwKImzGimqeZgmuuzIjPEYOFaFjlXfyQ5un1/VjeUP62E+BI1J5HcwQkt+IhP9AQpJWBJN9aEkaY4g1SpGygAPF4UjB9sK/paOqo2TIBI3AzAkBoBxjLJcwDnV755pbVcGj5rdjikHFw2lkSczwuW6ikMumP8O2QE6DmrkF/hYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077746; c=relaxed/simple;
	bh=WndaJvfa9ap2UrSfD6FG4qjtrHLbOmfjna8J1EtVtVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aupbzy1yDa1Hd5wCM+7f7nHlnVQYmxPmCUf7s1SskLmLu6wgh+5wYqHqeKyjyYhtKQMsTHk/dUk1xGnqrW99igT9JevDW5Jn947z18nx+Ne6pmpouh50hApPDve6sRCfOxGJM1BiBov4OG1MgI0diq3jXHD3ukHjmAkfb84/00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8bjeQvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DBEC4CED1;
	Thu, 20 Feb 2025 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740077745;
	bh=WndaJvfa9ap2UrSfD6FG4qjtrHLbOmfjna8J1EtVtVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8bjeQvcRkDymICywYT9q7QL5RUGwa+PkIOjJmN8jrS0hbyLuHPFsX4eW9fBSAebZ
	 vBMiptw8y7VcvOgVnTE9Bcn65kGPbAKYoao7aeHsLNlw+ZoSum9j7yQUap15a3+AhU
	 5LKcIGaGdeDuf5aFE+WlzoJ8w3gLnGT19PduqGjs=
Date: Thu, 20 Feb 2025 19:55:42 +0100
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
Message-ID: <2025022017-tarot-harbor-965d@gregkh>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
 <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
 <2025022004-scheming-expend-b9b3@gregkh>
 <D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>
 <2025022019-enigmatic-mace-60ca@gregkh>
 <D7XHGNJMMUMF.OUL1VHGK5KVM@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D7XHGNJMMUMF.OUL1VHGK5KVM@bootlin.com>

On Thu, Feb 20, 2025 at 07:26:41PM +0100, Théo Lebrun wrote:
> On Thu Feb 20, 2025 at 5:19 PM CET, Greg Kroah-Hartman wrote:
> > On Thu, Feb 20, 2025 at 04:46:59PM +0100, Théo Lebrun wrote:
> >> On Thu Feb 20, 2025 at 3:06 PM CET, Greg Kroah-Hartman wrote:
> >> > On Thu, Feb 20, 2025 at 02:31:29PM +0100, Théo Lebrun wrote:
> >> >> On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
> >> >> > On Tue, Feb 18, 2025 at 12:00:11PM +0100, Théo Lebrun wrote:
> >> >> >> The solution proposed is to add a flag to platform_device that tells if
> >> >> >> it is responsible for freeing its name. We can then duplicate the
> >> >> >> device name inside of_device_add() instead of copying the pointer.
> >> >> >
> >> >> > Ick.
> >> >> >
> >> >> >> What is done elsewhere?
> >> >> >>  - Platform bus code does a copy of the argument name that is stored
> >> >> >>    alongside the struct platform_device; see platform_device_alloc()[1].
> >> >> >>  - Other busses duplicate the device name; either through a dynamic
> >> >> >>    allocation [2] or through an array embedded inside devices [3].
> >> >> >>  - Some busses don't have a separate name; when they want a name they
> >> >> >>    take it from the device [4].
> >> >> >
> >> >> > Really ick.
> >> >> >
> >> >> > Let's do the right thing here and just get rid of the name pointer
> >> >> > entirely in struct platform_device please.  Isn't that the correct
> >> >> > thing that way the driver core logic will work properly for all of this.
> >> >> 
> >> >> I would agree, if it wasn't for this consideration that is found in the
> >> >> commit message [0]:
> >> >
> >> > What, that the of code is broken?  Then it should be fixed, why does it
> >> > need a pointer to a name at all anyway?  It shouldn't be needed there
> >> > either.
> >> 
> >> I cannot guess why it originally has a separate pdev->name field.
> >
> > Many people got this wrong when we designed busses, it's not unique.
> > But we should learn from our mistakes where we can :)
> >
> >> >> > It is important to duplicate! pdev->name must not change to make sure
> >> >> > the platform_match() return value is stable over time. If we updated
> >> >> > pdev->name alongside dev->name, once a device probes and changes its
> >> >> > name then the platform_match() return value would change.
> >> >> 
> >> >> I'd be fine sending a V2 that removes the field *and the fallback* [1],
> >> >> but I don't have the full scope in mind to know what would become broken.
> >> >> 
> >> >> [0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bootlin.com/
> >> >> [1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/platform.c#L1357
> >> >
> >> > The fallback will not need to be removed, properly point to the name of
> >> > the device and it should work correctly.
> >> 
> >> No, it will not work correctly, as the above quote indicates.
> >
> > I don't know which quote, sorry.
> >
> >> Let's assume we remove the field, this situation would be broken:
> >>  - OF allocates platform devices and gives them names.
> >>  - A device matches with a driver, which gets probed.
> >>  - During the probe, driver does a dev_set_name().
> >>  - Afterwards, the upcoming platform_match() against other drivers are
> >>    called with another device name.
> >> 
> >> We should be safe as there are guardraids to not probe twice a device,
> >> see __driver_probe_device() that checks dev->driver is NULL. But it
> >> isn't a situation we should be in.
> >
> > The fragility of attempting to match a driver to a device purely by a
> > name is a very week part of using platform devices.
> 
> I never said the opposite, and I agree.
> However the mechanism exists and I was focused on not breaking it.
> 
> > Why would a driver change the device name?  It's been given to the
> > driver to "bind to" not to change its name.  That shouldn't be ok, fix
> > those drivers.
> 
> I do get the argument that devices shouldn't change device names. I'll
> take the devil's advocate and give at least one argument FOR allowing
> changing names: prettier names, especially as device names leak into
> userspace through pseudo filesystems.

Then that same driver should have created a prettier name when it
created the device and sent it to the driver core :)

> If we agree that device names shouldn't be changed one a device is
> matched with a driver, then (1) we can remove the pdev->name field and
> (2) `dev_set_name()` should warn when used too late.
> 
> Turn the implicit explicit.
> 
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5a1f05198114..3532b068e32d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3462,10 +3462,13 @@ static void device_remove_class_symlinks(struct device *dev)
>  int dev_set_name(struct device *dev, const char *fmt, ...)
>  {
>         va_list vargs;
>         int err;
> 
> +       if (dev_WARN_ONCE(dev, dev->driver, "device name is static once matched"))
> +               return -EPERM;

What?  No, this is a platform driver thing, not a driver core thing.
Let's just remove the name pointer in the platform driver structure and
then we can handle the rest from there.

> +
>         va_start(vargs, fmt);
>         err = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
>         va_end(vargs);
>         return err;
>  }
> 
> (Unsure about the exact error code to return.)
> 
> [...]
> 
> > Do we have examples today of platform drivers that like to rename
> > devices?  I did a quick search and couldn't find any in-tree, but I
> > might have missed some.
> 
> The cover letter expands on the quest for those drivers:
> 
> On Tue Feb 18, 2025 at 12:00 PM CET, Théo Lebrun wrote:
> > Out of the 37 drivers that deal with platform devices and do a
> > dev_set_name() call, only one might be affected. That driver is
> > loongson-i2s-plat [0]. All other dev_set_name() calls are on children
> > devices created on the spot. The issue was found on downstream kernels
> > and we don't have what it takes to test loongson-i2s-plat.

out-of-tree drivers don't matter to us :)


> [...]
> >
> >    ⟩ # Finding potential trouble-makers:
> >    ⟩ git grep -l 'struct platform_device' | xargs grep -l dev_set_name
> >
> [...]
> > [0]: https://elixir.bootlin.com/linux/v6.13.2/source/sound/soc/loongson/loongson_i2s_plat.c#L155
> 
> [...]
> 
> > Or if this really is an issue, let's fix OF to not use the platform bus
> > and have it's own bus for stuff like this.
> 
> That used to exist! I cannot see how it could be a good idea to
> reintroduce the distinction though.
> 
> commit eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date:   Tue Jun 8 07:48:21 2010 -0600
> 
>     of: Merge of_platform_bus_type with platform_bus_type

True, that was nice, but we shouldn't let one force bugs in the other :)

Anyway try removing the name pointer and let's see what falls out.

thanks,

greg k-h

