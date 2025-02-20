Return-Path: <stable+bounces-118503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179CA3E3CA
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 19:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF237A4600
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658A214803;
	Thu, 20 Feb 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oYXetD+H"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B72147E7;
	Thu, 20 Feb 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076014; cv=none; b=k4MucXMn64fH9gNLoG8Z3C/6gzV2nxKdhi0HkYWe8EiI08y9sw+lqyw1dAEJMGZng3DkzbqHg8xyMPZ7hDDMIklgSBqGld3EFHjY2xQxeOQTy1/HGH6d0Mykw8DHqgHyYz0iQOK8o9nRrqAqz3uRy+4fI+soUzBL7cfVV7bXTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076014; c=relaxed/simple;
	bh=MJIFizcVzBwkI/LZ/a9I38tiNTjYxi6bRlm0QJbxXtg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=qUl7zxsZG2MzXXClqDQAkrw6DcjOwtMUD9UiPJShd1MNjhmygAb0SJNlTLn57lBVBcnfezDetEM9ZAuUBJonQFdiyifCwubQr+mS1uubNe/n0mgNbrAzzD+UBADTMjv/NVg6ECyookA7HCYeHM3iL7U9PXien5cd9ob+7bEHOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oYXetD+H; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FDF44432C;
	Thu, 20 Feb 2025 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740076009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8N1W7bpFCC1lJyHqVVXv9yI+RBiWfy8yehmTn+fTAA=;
	b=oYXetD+Hh3kngz99yHGRz+jVCmBVyklHlh8//ZP7EHav0jzCBeggxe95iJ+f+H+tMZTx2D
	5WxRfKeOdVFetSfsGJan0WQFfxP1yYdL8CXbelYl8eryldnnSiQZ7iopnsvJasB88Gq80b
	LPt1F8ZbGbqLN9+epfDLJh+dAVf7kBK0w+/M66BvCjcjd/km2DBtNU87FDIv/nGSs5QzSX
	Mm12eQZbcV3JbE9dY7PppZtCWz++TKSLtPqe3Pwi++zBlSr/6OQFqE9xBr/iSDHR3qwfXp
	83OVi34TT9hJmRiPq4Ug6knuuJTvqtf/BFsZ5Ca13hPqqNrj/3mps3RKAl8o1A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 19:26:41 +0100
Message-Id: <D7XHGNJMMUMF.OUL1VHGK5KVM@bootlin.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
 <2025022005-affluent-hardcore-c595@gregkh>
 <D7XB6MXRYVLY.3RM4EJEWD1IQM@bootlin.com>
 <2025022004-scheming-expend-b9b3@gregkh>
 <D7XE2DSESCHX.328BJ5KCEFH0A@bootlin.com>
 <2025022019-enigmatic-mace-60ca@gregkh>
In-Reply-To: <2025022019-enigmatic-mace-60ca@gregkh>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhufevvffofhgjsehtqhertdertdejnecuhfhrohhmpefvhhorohcunfgvsghruhhnuceothhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvedvfedufffghfekuddvffefieekueevffejvdfhteegvdefkeehteehuefggffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepkedtrddvudegrddugeehrdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeektddrvddugedrudeghedrleefpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoo
 hhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehgrhgrnhhtrdhlihhkvghlhiesshgvtghrvghtlhgrsgdrtggrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: theo.lebrun@bootlin.com

On Thu Feb 20, 2025 at 5:19 PM CET, Greg Kroah-Hartman wrote:
> On Thu, Feb 20, 2025 at 04:46:59PM +0100, Th=C3=A9o Lebrun wrote:
>> On Thu Feb 20, 2025 at 3:06 PM CET, Greg Kroah-Hartman wrote:
>> > On Thu, Feb 20, 2025 at 02:31:29PM +0100, Th=C3=A9o Lebrun wrote:
>> >> On Thu Feb 20, 2025 at 1:41 PM CET, Greg Kroah-Hartman wrote:
>> >> > On Tue, Feb 18, 2025 at 12:00:11PM +0100, Th=C3=A9o Lebrun wrote:
>> >> >> The solution proposed is to add a flag to platform_device that tel=
ls if
>> >> >> it is responsible for freeing its name. We can then duplicate the
>> >> >> device name inside of_device_add() instead of copying the pointer.
>> >> >
>> >> > Ick.
>> >> >
>> >> >> What is done elsewhere?
>> >> >>  - Platform bus code does a copy of the argument name that is stor=
ed
>> >> >>    alongside the struct platform_device; see platform_device_alloc=
()[1].
>> >> >>  - Other busses duplicate the device name; either through a dynami=
c
>> >> >>    allocation [2] or through an array embedded inside devices [3].
>> >> >>  - Some busses don't have a separate name; when they want a name t=
hey
>> >> >>    take it from the device [4].
>> >> >
>> >> > Really ick.
>> >> >
>> >> > Let's do the right thing here and just get rid of the name pointer
>> >> > entirely in struct platform_device please.  Isn't that the correct
>> >> > thing that way the driver core logic will work properly for all of =
this.
>> >>=20
>> >> I would agree, if it wasn't for this consideration that is found in t=
he
>> >> commit message [0]:
>> >
>> > What, that the of code is broken?  Then it should be fixed, why does i=
t
>> > need a pointer to a name at all anyway?  It shouldn't be needed there
>> > either.
>>=20
>> I cannot guess why it originally has a separate pdev->name field.
>
> Many people got this wrong when we designed busses, it's not unique.
> But we should learn from our mistakes where we can :)
>
>> >> > It is important to duplicate! pdev->name must not change to make su=
re
>> >> > the platform_match() return value is stable over time. If we update=
d
>> >> > pdev->name alongside dev->name, once a device probes and changes it=
s
>> >> > name then the platform_match() return value would change.
>> >>=20
>> >> I'd be fine sending a V2 that removes the field *and the fallback* [1=
],
>> >> but I don't have the full scope in mind to know what would become bro=
ken.
>> >>=20
>> >> [0]: https://lore.kernel.org/lkml/20250218-pdev-uaf-v1-2-5ea1a0d3aba0=
@bootlin.com/
>> >> [1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/base/pla=
tform.c#L1357
>> >
>> > The fallback will not need to be removed, properly point to the name o=
f
>> > the device and it should work correctly.
>>=20
>> No, it will not work correctly, as the above quote indicates.
>
> I don't know which quote, sorry.
>
>> Let's assume we remove the field, this situation would be broken:
>>  - OF allocates platform devices and gives them names.
>>  - A device matches with a driver, which gets probed.
>>  - During the probe, driver does a dev_set_name().
>>  - Afterwards, the upcoming platform_match() against other drivers are
>>    called with another device name.
>>=20
>> We should be safe as there are guardraids to not probe twice a device,
>> see __driver_probe_device() that checks dev->driver is NULL. But it
>> isn't a situation we should be in.
>
> The fragility of attempting to match a driver to a device purely by a
> name is a very week part of using platform devices.

I never said the opposite, and I agree.
However the mechanism exists and I was focused on not breaking it.

> Why would a driver change the device name?  It's been given to the
> driver to "bind to" not to change its name.  That shouldn't be ok, fix
> those drivers.

I do get the argument that devices shouldn't change device names. I'll
take the devil's advocate and give at least one argument FOR allowing
changing names: prettier names, especially as device names leak into
userspace through pseudo filesystems.

If we agree that device names shouldn't be changed one a device is
matched with a driver, then (1) we can remove the pdev->name field and
(2) `dev_set_name()` should warn when used too late.

Turn the implicit explicit.


diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f05198114..3532b068e32d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3462,10 +3462,13 @@ static void device_remove_class_symlinks(struct dev=
ice *dev)
 int dev_set_name(struct device *dev, const char *fmt, ...)
 {
        va_list vargs;
        int err;

+       if (dev_WARN_ONCE(dev, dev->driver, "device name is static once mat=
ched"))
+               return -EPERM;
+
        va_start(vargs, fmt);
        err =3D kobject_set_name_vargs(&dev->kobj, fmt, vargs);
        va_end(vargs);
        return err;
 }

(Unsure about the exact error code to return.)

[...]

> Do we have examples today of platform drivers that like to rename
> devices?  I did a quick search and couldn't find any in-tree, but I
> might have missed some.

The cover letter expands on the quest for those drivers:

On Tue Feb 18, 2025 at 12:00 PM CET, Th=C3=A9o Lebrun wrote:
> Out of the 37 drivers that deal with platform devices and do a
> dev_set_name() call, only one might be affected. That driver is
> loongson-i2s-plat [0]. All other dev_set_name() calls are on children
> devices created on the spot. The issue was found on downstream kernels
> and we don't have what it takes to test loongson-i2s-plat.
[...]
>
>    =E2=9F=A9 # Finding potential trouble-makers:
>    =E2=9F=A9 git grep -l 'struct platform_device' | xargs grep -l dev_set=
_name
>
[...]
> [0]: https://elixir.bootlin.com/linux/v6.13.2/source/sound/soc/loongson/l=
oongson_i2s_plat.c#L155

[...]

> Or if this really is an issue, let's fix OF to not use the platform bus
> and have it's own bus for stuff like this.

That used to exist! I cannot see how it could be a good idea to
reintroduce the distinction though.

commit eca3930163ba8884060ce9d9ff5ef0d9b7c7b00f
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Jun 8 07:48:21 2010 -0600

    of: Merge of_platform_bus_type with platform_bus_type

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


