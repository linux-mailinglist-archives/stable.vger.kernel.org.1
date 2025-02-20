Return-Path: <stable+bounces-118438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C38A3DB57
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F9E17AAA7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9A1F8670;
	Thu, 20 Feb 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bwOJo+lI"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874CE288A2;
	Thu, 20 Feb 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058297; cv=none; b=SVqaEylj6hs18AOlJnsNw9ESrXtiGNQFwJQM89K+kGbO343qBK3BOVJRYkreYCatBAJ3zAQMuK37IBY5iM7iYmtY6IntPCSVPhC8PcPEyiJemwTNXnPNQYlFNjtC8mfDayF4etWS7AXSkRIWMhVohdjG0OCiz3o7+Xnhqi3O/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058297; c=relaxed/simple;
	bh=+BLHUOTGg4Xc2Cd4lVLcPAZ39MPOBrnJ+minoVo+LZE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=rWrekwomzUAYgjCJtWLfmp+0K9uvAY8AHWEPdVUkVIGdbBw/7VBg2YXvtUyVrAfrrYfM/XbACMqzfZ/2+H3Q8nKCsF9WjiImDmMKczpmwxh3ge1L8NIRaf+6wyBENL4aLyaXhY+ECVFCTlr5ZdyIpW/Wq8BlOtA5B3U2otnA3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bwOJo+lI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AB664329B;
	Thu, 20 Feb 2025 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740058292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkUjsmd0pVsmitb0WeguhFZha5DdicaUilLQLg4YgVA=;
	b=bwOJo+lIPQFFU574qPjJZ2V7C45r99lHmH2oSTCQ2yKnmcrL2Ei5+4CvHysZrdIs9saOar
	0hDeIGSy//DHPp3fwPKI35rErylX5qWTujxuA9uujmRaSFHNB8I3iZ78v4ejX8abfDncsE
	ND4CHpeaYnGqrihatO3n4LD18RCIAZ2VTdw7y0vTO+j8/y2izOyzFY06+zPUsiAvMJUgbh
	tA+98IWix4u2J8Tag8BnLuU+B52JVvCIFQLfQ10CdgpV70C53w8MXvhnyCuVnVo7lS9g6N
	OFPRKsw/H0UH9RiE2Kbz1K/omGs8BqSwljQnuT+Br0X2ODuDB+a5elIJK00C4A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 14:31:29 +0100
Message-Id: <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
In-Reply-To: <2025022005-affluent-hardcore-c595@gregkh>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvhffuvefofhgjsehtqhertdertdejnecuhfhrohhmpefvhhorohcunfgvsghruhhnuceothhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedvffeftddukedvffffjeehvedtueeuteefffeijeeiteelgefgfeeihfduheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeiieegsgemfhdtfhhfmehfvgdutdemlegvfhgupdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehgrhgrnhhtrdhlihhkvghlhiesshgvtghrvghtlhgrsgdrtggrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Greg,

On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
> On Tue, Feb 18, 2025 at 12:00:11PM +0100, Th=C3=A9o Lebrun wrote:
>> The use-after-free bug appears when:
>>  - A platform device is created from OF, by of_device_add();
>>  - The same device's name is changed afterwards using dev_set_name(),
>>    by its probe for example.
>>=20
>> Out of the 37 drivers that deal with platform devices and do a
>> dev_set_name() call, only one might be affected. That driver is
>> loongson-i2s-plat [0]. All other dev_set_name() calls are on children
>> devices created on the spot. The issue was found on downstream kernels
>> and we don't have what it takes to test loongson-i2s-plat.
>>=20
>> Note: loongson-i2s-plat maintainers are CCed.
>>=20
>>    =E2=9F=A9 # Finding potential trouble-makers:
>>    =E2=9F=A9 git grep -l 'struct platform_device' | xargs grep -l dev_se=
t_name
>>=20
>> The solution proposed is to add a flag to platform_device that tells if
>> it is responsible for freeing its name. We can then duplicate the
>> device name inside of_device_add() instead of copying the pointer.
>
> Ick.
>
>> What is done elsewhere?
>>  - Platform bus code does a copy of the argument name that is stored
>>    alongside the struct platform_device; see platform_device_alloc()[1].
>>  - Other busses duplicate the device name; either through a dynamic
>>    allocation [2] or through an array embedded inside devices [3].
>>  - Some busses don't have a separate name; when they want a name they
>>    take it from the device [4].
>
> Really ick.
>
> Let's do the right thing here and just get rid of the name pointer
> entirely in struct platform_device please.  Isn't that the correct
> thing that way the driver core logic will work properly for all of this.

I would agree, if it wasn't for this consideration that is found in the
commit message [0]:

> It is important to duplicate! pdev->name must not change to make sure
> the platform_match() return value is stable over time. If we updated
> pdev->name alongside dev->name, once a device probes and changes its
> name then the platform_match() return value would change.

I'd be fine sending a V2 that removes the field *and the fallback* [1],
but I don't have the full scope in mind to know what would become broken.

[0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bootl=
in.com/
[1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/platform.=
c#L1357

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

