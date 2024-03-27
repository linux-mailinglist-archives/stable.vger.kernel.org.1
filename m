Return-Path: <stable+bounces-33031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7988F177
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31681C2F4EE
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8A152DF7;
	Wed, 27 Mar 2024 22:00:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 10.mo584.mail-out.ovh.net (10.mo584.mail-out.ovh.net [188.165.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF314E2D1
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576804; cv=none; b=aPSut9Svl6/JJpKa3c7d25XPj/5AvKUoGIwckHpLlfJdAwukHBl9bclN6P5l6/a4RRUCrDnrPrylFjmrCLdpUSpBCWF4i+G6M/uF4OHGMLG4Fd2F/xkyLauNrBqz4GXp+0Y5TyEtOdHwkus9evFmgL9eysQ/4Og/x/vivux7Qmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576804; c=relaxed/simple;
	bh=QjtZY6rB2FF4gyaL9iXzJNDSNIVD0xKrRIo9oJmORcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSXrgVJ0mlbanB5fkvZDXd54BoJdnQuV1lOZVCxQLggSwizq2hJBd+wfkxWU4IL0F6qAWyipPY2dh4m6qgf9uuNPeNR+aAZ0KpQGlUJxxAk1+8h85YTo6PRdeUmdjIPbTrv71E0hpSwC7Pogvj9jD4VnpaQSj0/fY9m/NJm39qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=188.165.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.25.156])
	by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4V4gQc5Bk9z1FLB
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 21:53:12 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-fsmdr (unknown [10.110.168.247])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 63E7A1FD49;
	Wed, 27 Mar 2024 21:53:09 +0000 (UTC)
Received: from milecki.pl ([37.59.142.95])
	by ghost-submission-6684bf9d7b-fsmdr with ESMTPSA
	id WN4WFEWVBGbp2AUAQbJ/Pw
	(envelope-from <rafal@milecki.pl>); Wed, 27 Mar 2024 21:53:09 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-95G00185960c84-105b-4035-9ca6-df95b4d75bca,
                    AD8588E3BB83D84E59DEA8CE8674EAB20989D6B2) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:31.11.218.106
Message-ID: <b02dd24b-9e67-4ba7-973e-4c2b180eb56a@milecki.pl>
Date: Wed, 27 Mar 2024 22:53:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
 <44a377b11208ff33045f12f260b667dd@milecki.pl>
 <66042f0a.050a0220.374bd.5e4a@mx.google.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <66042f0a.050a0220.374bd.5e4a@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10756847710028540729
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepteetfeejjeeghfeikeevleevkeehtdeghffguddthefhgffgveduheetveejueetnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth



On 27.03.2024 15:36, Christian Marangi wrote:
> On Wed, Mar 27, 2024 at 03:26:55PM +0100, Rafał Miłecki wrote:
>> On 2024-03-22 05:09, Christian Marangi wrote:
>>> MTD OTP logic is very fragile and can be problematic with some specific
>>> kind of devices.
>>>
>>> NVMEM across the years had various iteration on how Cells could be
>>> declared in DT and MTD OTP probably was left behind and
>>> add_legacy_fixed_of_cells was enabled without thinking of the
>>> consequences.
>>
>> Er... thank you?
>>
> 
> Probably made some bad assumption and sorry for it!

No problem :)


>>> That option enables NVMEM to scan the provided of_node and treat each
>>> child as a NVMEM Cell, this was to support legacy NVMEM implementation
>>> and don't cause regression.
>>>
>>> This is problematic if we have devices like Nand where the OTP is
>>> triggered by setting a special mode in the flash. In this context real
>>> partitions declared in the Nand node are registered as OTP Cells and
>>> this cause probe fail with -EINVAL error.
>>>
>>> This was never notice due to the fact that till now, no Nand supported
>>> the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
>>> access for MX30LFxG18AC") this changed and coincidentally this Nand is
>>> used on an FritzBox 7530 supported on OpenWrt.
>>
>> So as you noticed this problem was *exposed* by adding OTP support for
>> Macronix NAND chips.
>>
>>
>>> Alternative and more robust way to declare OTP Cells are already
>>> prossible by using the fixed-layout node or by declaring a child node
>>> with the compatible set to "otp-user" or "otp-factory".
>>>
>>> To fix this and limit any regression with other MTD that makes use of
>>> declaring OTP as direct child of the dev node, disable
>>> add_legacy_fixed_of_cells if we detect the MTD type is Nand.
>>>
>>> With the following logic, the OTP NVMEM entry is correctly created with
>>> no Cells and the MTD Nand is correctly probed and partitions are
>>> correctly exposed.
>>>
>>> Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old
>>> syntax fixed OF cells")
>>
>> It's not that commit however that introduced the problem. Introducing
>> "add_legacy_fixed_of_cells" just added a clean way of enabling parsing
>> of old cells syntax. Even before my commit NVMEM subsystem was looking
>> for NVMEM cells in NAND devices.
>>
>> I booted kernel 6.6 which has commit e87161321a40 ("mtd: rawnand:
>> macronix: OTP > access for MX30LFxG18AC") but does NOT have commit
>> 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax
>> fixed OF cells").
>>
>> Look at this log from Broadcom Northstar (Linux 6.6):
>> [    0.410107] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
>> [    0.416531] nand: Macronix MX30LF4G18AC
>> [    0.420409] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB
>> size: 64
>> [    0.428022] iproc_nand 18028000.nand-controller: detected 512MiB total,
>> 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
>> [    0.438991] Scanning device for bad blocks
>> [    0.873598] Bad eraseblock 738 at 0x000005c40000
>> [    1.030279] random: crng init done
>> [    1.854895] Bad eraseblock 2414 at 0x000012dc0000
>> [    2.657354] Bad eraseblock 3783 at 0x00001d8e0000
>> [    2.662967] Bad eraseblock 3785 at 0x00001d920000
>> [    2.848418] nvmem user-otp1: nvmem: invalid reg on
>> /nand-controller@18028000/nand@0
>> [    2.856126] iproc_nand 18028000.nand-controller: error -EINVAL: Failed to
>> register OTP NVMEM device
>>
>> So to summary it up:
>> 1. Problem exists since much earlier and wasn't introduced by 2cc3b37f5b6d
>> 2. Commit 2cc3b37f5b6d just gives you a clean way of solving this issue
>> 3. Problem was exposed by commit e87161321a40
>> 4. We miss fix for v6.6 which doesn't have 2cc3b37f5b6d (it hit v6.7)
>>
> 
> So the thing was broken all along? Maybe the regression was introduced
> when OF support for NVMEM cell was introduced? (and OF scan was enabled
> by default?)

I went back to the commit 4b361cfa8624 ("mtd: core: add OTP nvmem
provider support") from 2021 (it went into 5.14). It seems that even
back then nvmem_register() used to call nvmem_add_cells_from_of(). SO
maybe this problem is as old as that?


> Anyway Sorry for adding the wrong fixes, maybe Miquel can remote the
> commit from mtd/fixes and fix the problematic fixes tag?
> 
>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 

