Return-Path: <stable+bounces-118459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D4AA3DF30
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1794917D4EF
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A11FA84F;
	Thu, 20 Feb 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bDdFbWWV"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358C13BACC;
	Thu, 20 Feb 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066432; cv=none; b=ko320whSvU4XjJQQv62vrS+IabETHNCev/gyYfhfHqbQHr23/UtUTgY7Og2YFSkKUyd/CLRen0/oEVjK5t9+M/UUUKF+ePfyk5liTbt6aT3EkCfwj9KPI+K5wu5UMvhRHgpPDpxsn8ezYjOgWbcTj+LEtqENGH+qCK9v7lEbEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066432; c=relaxed/simple;
	bh=4ni84CzkNyV93MRYSwVLLXyfCfXfk8pzJmoa9OW/6cA=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:Mime-Version:
	 References:In-Reply-To; b=GLIbJhDgxg6UMq0co7Nlv8RAFsrXTLMnomb61mg2xkAg3MwovaY9Zz8lBiuieX0cFkjD2hUk2fSFZcQnPB2nVaxT1cOmLnjGiEdfz06b1bi4CDCEpGt1hkbIjul64ihbt6NBNEySPbfMJ9BNdTfid6V2jWE8gRfq/An96bmphhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bDdFbWWV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66093443FB;
	Thu, 20 Feb 2025 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740066422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFrZx3aO5d5jVw4+5EsyssrmSSe7/642XQj528XSzqM=;
	b=bDdFbWWVaeY1uvx7YeYMrUZTlW/PU/1bK5dr2xnrgNxYMFOQbIGd81V+YSMLywKxmebUJV
	MX4enZUVeRaqtpAI8r3O5MSD+CZ3nL6QRh1bg4czEFxcEbwwpGmk4oYse4rTaqLJ3uJGTS
	Y8DdvjlcWYs29T1nNZFQXMaZ9kosaHhd6301rlaA4kY5jYBvO7pGw3Esy5vbhl/cTrrm47
	yJ++wTWIgVWRQ0XOWUtTWMbd/HfmIHON7/EMmF4v5D8mFoMSsgUv3trgt+acqJh5VmopgE
	tmVxfYkcBOBWVwfKcBCLNZtZzlLpPsWG8U0o4XB2ICDW1urDcqB856Ea2Fsdsg==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 16:46:59 +0100
Message-Id: <D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 0/2] driver core: platform: avoid use-after-free on
 device name
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Rob Herring" <robh@kernel.org>, "Saravana Kannan"
 <saravanak@google.com>, "David S. Miller" <davem@davemloft.net>, "Grant
 Likely" <grant.likely@secretlab.ca>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, "Binbin Zhou" <zhoubinbin@loongson.cn>,
 <linux-sound@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <stable@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
 <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
 <2025022004-scheming-expend-b9b3@gregkh>
In-Reply-To: <2025022004-scheming-expend-b9b3@gregkh>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptgffkffhufevvfgggffofhgjsehtqhertdertdejnecuhfhrohhmpefvhhorohcunfgvsghruhhnuceothhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeevvedugefhudfhgedtgeeuhfeufeejteeikeefledtheektdehgeekkeevleeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehgrhgrnhhtrdhlihhkvghlhiesshgvtghrvghtlhgrsgdrtggrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

On Thu Feb 20, 2025 at 3:06 PM CET, Greg Kroah-Hartman wrote:
> On Thu, Feb 20, 2025 at 02:31:29PM +0100, Th=C3=A9o Lebrun wrote:
>> On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
>> > On Tue, Feb 18, 2025 at 12:00:11PM +0100, Th=C3=A9o Lebrun wrote:
>> >> The solution proposed is to add a flag to platform_device that tells =
if
>> >> it is responsible for freeing its name. We can then duplicate the
>> >> device name inside of_device_add() instead of copying the pointer.
>> >
>> > Ick.
>> >
>> >> What is done elsewhere?
>> >>  - Platform bus code does a copy of the argument name that is stored
>> >>    alongside the struct platform_device; see platform_device_alloc()[=
1].
>> >>  - Other busses duplicate the device name; either through a dynamic
>> >>    allocation [2] or through an array embedded inside devices [3].
>> >>  - Some busses don't have a separate name; when they want a name they
>> >>    take it from the device [4].
>> >
>> > Really ick.
>> >
>> > Let's do the right thing here and just get rid of the name pointer
>> > entirely in struct platform_device please.  Isn't that the correct
>> > thing that way the driver core logic will work properly for all of thi=
s.
>>=20
>> I would agree, if it wasn't for this consideration that is found in the
>> commit message [0]:
>
> What, that the of code is broken?  Then it should be fixed, why does it
> need a pointer to a name at all anyway?  It shouldn't be needed there
> either.

I cannot guess why it originally has a separate pdev->name field.
All I can tell you is a good reason to have one, as quoted below.

>> > It is important to duplicate! pdev->name must not change to make sure
>> > the platform_match() return value is stable over time. If we updated
>> > pdev->name alongside dev->name, once a device probes and changes its
>> > name then the platform_match() return value would change.
>>=20
>> I'd be fine sending a V2 that removes the field *and the fallback* [1],
>> but I don't have the full scope in mind to know what would become broken=
.
>>=20
>> [0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bo=
otlin.com/
>> [1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/platfo=
rm.c#L1357
>
> The fallback will not need to be removed, properly point to the name of
> the device and it should work correctly.

No, it will not work correctly, as the above quote indicates.

Let's assume we remove the field, this situation would be broken:
 - OF allocates platform devices and gives them names.
 - A device matches with a driver, which gets probed.
 - During the probe, driver does a dev_set_name().
 - Afterwards, the upcoming platform_match() against other drivers are
   called with another device name.

We should be safe as there are guardraids to not probe twice a device,
see __driver_probe_device() that checks dev->driver is NULL. But it
isn't a situation we should be in.

Another broken situation:
 - OF allocates platform devices and gives them names.
 - A device matches with a driver, which gets probed based on its name.
 - During the probe, driver does a dev_set_name().
 - Module is removed.
 - Module is re-added, the (driver, device) pair don't end up matching
   again because the device name changed.

I might be missing other edge-cases.

Conclusion: we need a constant name for platform devices as we want the
return value of platform_match() to stay stable across time.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


