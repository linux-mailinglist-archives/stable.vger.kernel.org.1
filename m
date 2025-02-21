Return-Path: <stable+bounces-118552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB010A3EEFA
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B212E42102D
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146A200BB2;
	Fri, 21 Feb 2025 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fcc7LM+e"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA91C5F3B;
	Fri, 21 Feb 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127581; cv=none; b=cQBF02ErQnpwjTfI5H7qHJJ0jAXmd2Uo5UzQlDwkIGTv3FXfBcxsXlMBUo9bJecimLiZPxII6FlIitpmZ6NNDSvk0wcG+7ILjkbL7K2kkhvmeeBT8uPFUNcDtHt7vNd/E2W9r6XGLnaSypvSpw5Gl7zpLbdyyuMaiCXuLJU5zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127581; c=relaxed/simple;
	bh=uxE/14AZJPOwjkNfM0o2kRICEkDY6NPqie4S2ZZ7nl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC1Cou/Nd4ZoKaqqjbu9R8RMcRZfWLYuWjTHjHAogqmbeY+emr66dgvDC/MQ6Ytk9/EVHaElXNRyW5soRAu+Ctv3aIYT59IfJHE98xjSJsKM3cVYifEnoi2fRXgmDgGj5PJCrNWTaWE7eYc/CHQH5LY1V31iLGALdXxhl6oK6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fcc7LM+e; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A765A4437F;
	Fri, 21 Feb 2025 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740127576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZqai5OGQRe1+S+SWHr4U/ETYReiLVZF4TVJLDQapsk=;
	b=Fcc7LM+e4fObYR7C5N6IVkXCzOJOsztWAk/zf7zbXIkCXuiIzW0j3Z00cQQh8Hk9mE5/tq
	k48bRopraJoeuvMUqYnEQBEqkuFXhKajhiCzeFrXgId8xaK9RxU+D1K6karK93nBHi5gEn
	VTLtqhQZDk/e3bCLgiATPrWp0jpJKw/TDiwSlHh8+IDEMf2DJdyb7l1+eI+wV5uMAYVPBY
	9dCfw8Ujc14UxfLoE6Ol/ag/f/mG7O5NQ3CQtwVmgW/gKFwfPD5WKU0OOC/jhBS6Z1vzzH
	05GXyrELB1epD0yZJmAO4rd+PGDludXJukMGrpJwxtxbO+8cQx/A9CXygSMaoA==
Date: Fri, 21 Feb 2025 09:46:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, "Grant Likely" <grant.likely@secretlab.ca>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Binbin Zhou" <zhoubinbin@loongson.cn>, <linux-sound@vger.kernel.org>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, =?UTF-8?B?R3I=?=
 =?UTF-8?B?w6lnb3J5?= Clement <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] driver core: platform: avoid use-after-free on
 device name
Message-ID: <20250221094613.7b9b5bf8@windsurf>
In-Reply-To: <D7XHGNJMMUMF.OUL1VHGK5KVM@bootlin.com>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
	<2025022005-affluent-hardcore-c595@gregkh>
	<D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
	<2025022004-scheming-expend-b9b3@gregkh>
	<D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>
	<2025022019-enigmatic-mace-60ca@gregkh>
	<D7XHGNJMMUMF.OUL1VHGK5KVM@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepvfhhohhmrghsucfrvghtrgiiiihonhhiuceothhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehudetueefkeeiveeigeeugeeigfdvveehgffguddtieeuvddtgfelvdegveelieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkedtiegtmehfrgdttdemtgegjeekmeektddtieemvdefudegmeehkegutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeektdeitgemfhgrtddtmegtgeejkeemkedttdeimedvfedugeemheekugdtpdhhvghlohepfihinhgushhurhhfpdhmrghilhhfrhhomhepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpt
 hhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepghhrrghnthdrlhhikhgvlhihsehsvggtrhgvthhlrggsrdgtrg
X-GND-Sasl: thomas.petazzoni@bootlin.com

On Thu, 20 Feb 2025 19:26:41 +0100
Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> wrote:

> That used to exist! I cannot see how it could be a good idea to
> reintroduce the distinction though.
>=20
> commit eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date:   Tue Jun 8 07:48:21 2010 -0600
>=20
>     of: Merge of_platform_bus_type with platform_bus_type

I don't really see how an of_platform bus would make sense. OF is not a
bus at all, it's a way of providing HW description to an operating
system.

What would IMO make a lot more sense is mmio_bus, for Memory-Mapped I/O
peripherals. mmio_device can be described through OF, through old-style
board.c, possibly through ACPI, or other means.

But in my eyes, the current platform bus is exactly this: the bus for
MMIO devices. It would have be clearer to name it mmio_bus, and that
would have probably prevented abuses of the platform bus for things
that aren't memory-mapped peripherals.

But clearly any bus that has "OF" in its name is wrong, as OF cannot be
a bus. Keep in mind that OF allows to describe not only MMIO devices,
but also I2C devices, SPI devices, MMC/SDIO devices, PCI devices, USB
devices, etc. OF is a description of the HW, not a bus.

Best regards,

Thomas
--=20
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com

