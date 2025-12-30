Return-Path: <stable+bounces-204227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE59CE9F4A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8966530329E6
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99F2741AB;
	Tue, 30 Dec 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="ON1iMg9B"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C081DE4FB
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105646; cv=none; b=svD67dnRIE9NhpxLZ1G/RoySv/exm3FISB4oNOzvb6UnQXhZIScB+GhHlAIgrXDKc7gdcMDY7V7an5dq1mPFluuyPjrziQgtfUs8LHy/CeQu7I6jEceB8Azw70oUeaYHArpK5pyAbpZZVkrlA3KuyD+KuJ1/lmP+qWHcHsR1j8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105646; c=relaxed/simple;
	bh=IdtnV5Di0vox3pEoEtaNIt1U9telRL/FRWwLH7rRPBc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=em7R8RnVFB40RUgDxXiqPCGL/WUaI2ME74fLezd6vLALT83ymzT61Ima233pQP7l0y2DnLJLeNK2CzfM29ZcM4YIY7N1sVFC22Jp7elxpFPcxUaCZZtVP0lRl6iervffhEbOZ54Gkz0mIFHaObYquyWdVwMQQMXW7RnZo0lPYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=ON1iMg9B; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1767105632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziEtXLcpFBCjfzgTqfbUWrGVwPN/l0EtRe61oQ0DM/A=;
	b=ON1iMg9Bde60GDrSW9qBWkAlnQa98vY6cncy+4tqwyL/LWvtXCV6Bw//W/q2W6z30znFrd
	iLuTO94uUBQBaKNtxIez5lr/Ds0XwLm/7R+JOFi7+isjI5Okbx5Zgo2C1jvXaLaFe0VfDT
	PAPMCiMYW1GCCYtojD6Z5P8fBndBcSEA2jdDeRf5JbKGYoA7Cq2Zep3oNSzPYS3NTLoCIq
	G+8tdWSPAexSdcS1D655pgtr+hbkstqh+mdZW4kX10J8EjfBhLPx/qsIpQ8wwi+bRcXdtX
	Ale7LYAd9602sceNKzCqZJF4dmkzphU/xR7hAOxuDvlCT9BbnF0lQu4TBXI4+g==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Dec 2025 15:40:27 +0100
Message-Id: <DFBMNYF0U5PK.24YOAUZFZ0ESB@cknow-tech.com>
Cc: "Huacai Chen" <chenhuacai@kernel.org>, "Alan Stern"
 <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Shengwen Xiao"
 <atzlinux@sina.com>, <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_hcd
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Huacai Chen"
 <chenhuacai@loongson.cn>
References: <20251230080014.3934590-1-chenhuacai@loongson.cn>
 <2025123049-cadillac-straggler-d2fb@gregkh>
In-Reply-To: <2025123049-cadillac-straggler-d2fb@gregkh>
X-Migadu-Flow: FLOW_OUT

On Tue Dec 30, 2025 at 9:15 AM CET, Greg Kroah-Hartman wrote:
> On Tue, Dec 30, 2025 at 04:00:14PM +0800, Huacai Chen wrote:
>> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
>> loaded first") said that ehci-hcd should be loaded before ohci-hcd and
>> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
>> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
>> pci, which is not enough and we may still see the warnings in boot log.
>> So fix it by also making ohci-hcd/uhci-hcd depend on ehci-hcd.
>>=20
>> Cc: stable@vger.kernel.org
>> Reported-by: Shengwen Xiao <atzlinux@sina.com>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  drivers/usb/host/ohci-hcd.c | 1 +
>>  drivers/usb/host/uhci-hcd.c | 1 +
>>  2 files changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 9c7f3008646e..549c965b7fbe 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -1355,4 +1355,5 @@ static void __exit ohci_hcd_mod_exit(void)
>>  	clear_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
>>  }
>>  module_exit(ohci_hcd_mod_exit);
>> +MODULE_SOFTDEP("pre: ehci_hcd");
>
> Ick, no, this way lies madness.  I hate the "softdep" stuff, it's
> usually a sign that something is wrong elsewhere.
>
> And don't add this _just_ to fix a warning message in a boot log, if you
> don't like that message, then build the module into your kernel, right?
>
> And I really should just go revert 05c92da0c524 ("usb: ohci/uhci - add
> soft dependencies on ehci_pci") as well, that feels wrong too.

FWIW, I've been seeing this warning on several of my Rockchip based
devices as well. I thought I had already mentioned that on some ML, but
couldn't find it on lore.k.o ... turns out I reported it on my 'own' ML:
https://lists.sr.ht/~diederik/pine64-discuss/%3CDD65LB64HB7K.15ZYRTB98X8G2@=
cknow.org%3E
(and likely on #linux-rockchip IRC channel)

Most of it is just my research notes, but the last post also had this:

```
I checked the last 20 boots on my devices to see that warning (or not).
Device				Number of times that warning showed up
Rock64 (rk3328)			16x
RockPro64 (rk3399)		11x
Quartz64 Model A (rk3566)	 7x
Quartz64 Model B (rk3566)	14x
PineTab2 (rk3566)		17x
NanoPi R5S (rk3568)		13x
Rock 5B (rk3588)		12x
```

While I generally don't like seeing warning messages, it often also
resulted in USB2 ports not working. Maybe even every time, but I only
notice it when I actually tried to use one of the USB2 ports.

The first post mentioned what I 'assume' to be the problem:
```
CONFIG_USB_XHCI_HCD=3Dm
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
```

So I guess USB_EHCI_HCD doesn't work with '=3Dm'.

Cheers,
  Diederik

