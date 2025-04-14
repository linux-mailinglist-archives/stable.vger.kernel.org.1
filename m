Return-Path: <stable+bounces-132639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E776DA8876E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61893AA422
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781A274658;
	Mon, 14 Apr 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="ttIKMaFO"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851ED142E86;
	Mon, 14 Apr 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644712; cv=none; b=R6JJEe9+zS88knj25z04YQoVmtUfXeJDa2ibwUHwc/3p0aeQmozFKQgCA3NVOGKxxlqPO32mTgllH/HqA1joXjv/HZ0lPmA58JBEXWLJQ/jf2IMdlzaM6/AadVXv/Pw8Kbw6UPA+cBZucoUv3dkK2fPDvyU5pfJSeJjRhIV0S7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644712; c=relaxed/simple;
	bh=jJ/xH2Q6el5v5Of3RuHWI+z95JiuifI1i5iGzRB/CQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBG/kmhXZdYCY+lgeBjuhwVjzOySNZ7W83m2SnSwXN6GKCwJxizCc3gUSyO/XdDXrem4QABeqEQK6HO8Rt9ctEXCoyqbpwoWadEDQB0+8QbAv6zALdrz3d42fawWaahjlFf3zMqDVa1B+yq2X446bZI46aJlJ81JSEnXIxmDKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=ttIKMaFO; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744644697; x=1745249497; i=fiona.klute@gmx.de;
	bh=4mh1jy0J5FdGZIQddvKgIrKEMu83MuJJ/ir6XHpsbp4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ttIKMaFO/yTBCQlRWyrhrgKpdKP3UDBcQlEPb9lRoUChVkfT3k10pKRAcrAVyKsC
	 rPXUt3pAmLBQPAY35emBNLuxtGxmVMpdxhVvmsdEzr/mFF59rpebJr2sHWnBz89XL
	 b/bcWohnam1vfnA+OCnbeLRbz70aO+EmRc9QysrQ1WiAkS8B4vThF0K0kLcpfHL2B
	 YgxC4lhau3hs77yxdZ/0maQvTGDkKl85e20maihVI3wxUTWCgUwuKh1NGZe2IUAwr
	 KnGwtCWJevyfANXWhuJIHDAkNmE0sBs4u5aZh0LKPdHg5S861X4WcT3BNqL/uYzUa
	 lvrTQly1CED8yyDo6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.122.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1t2zZ40zOd-00w7zF; Mon, 14
 Apr 2025 17:31:37 +0200
Message-ID: <c20b01c9-0412-482d-b82e-c1bf1c7ef4ef@gmx.de>
Date: Mon, 14 Apr 2025 17:31:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 stable@vger.kernel.org
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
 <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
 <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>
 <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
 <dc8ef510-8f7d-4c96-9fd8-76b67a22aaf9@gmx.de>
 <0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:puq4CQgy8dxCjw60VLrwH7jmu06fJQstdI/TKmkXlc++xW7FidT
 Jlgl2HXD/XlQ3UXGQOBI1BUtMMpERknbHT31QtzNpdktcdhRVF9DBxrdVZYHkTe6Ped5YSM
 7CCHY1shr+xt6uyUuZdSK2BV6MTElva5+mAkyMxtEsyjH78YUx/a9dNQ9IhR7zCaU8I7XhH
 x7SPSTprGw0zc+/qcmYDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oLHzECRR8UM=;XVJzPjUV4adEj7Nixd9l7JURA0X
 O9/Dq5oqqqWKAKGPtG51Rn7fnw7WHBmoAE7dYgea6RqyXYr/E/hXQiI/grfGm87Rga562MvsF
 VXbG7JhIjN4yOcdLZSrbOqN8cS7fPQa+1porMQ24tpcY9IbjiZy7Iqo+g27R1Fb2tlPjm5DQL
 qzEjUMHIGiUUdvKAbK3WwzzPfEoi0iF9pjJRgNNl0nCLHvX9XPeX21vdRhpL6iSJ6F7uNvciR
 wRotUT6T/2oM4X3SZzYy24b0Kl1I8WAKgeLbRpSLSlSX0VJG6v8L0mmZFTW/OE+xIyr5uF+Xm
 PTMJfSrXo+dAzY28GbHzzuEnf+LXTWXEK2HvTnBUOkgccENQtpviT2Kfi2T/jyzt/NKz4ytZR
 cMQE8XlZ4uozhBhZZW9vI73QQNiOYX/9kQLjWfnBmOLA+4RPqiynC15dwkvH4r/8ZQLc78l1/
 5Yl30YTNXmnm2+2EV5daqp8H90g0yZScdJ3kV8k1ZRo2AjuSySpOcCg4PmqlINZF+4KPSDUl1
 UeUhnemVWeAMNcsvTfoi+1wWBBOSmPgNzAgMkFOfI3TwwpMkjK0nXXvnWAaPbMCkuqbSkE4Kq
 IOzPVclqzFBDPII1kt9iOihuPLAZ9IaF4Du7yev9/rTe4czd6/tqnVX+chHYXNLeZUn8AhtAu
 4N4X1S/nt1Iun7xp24wEteBhRfD315FaxiCwS/DE8eL70I4MrQX41HiC7FelzJYCaHRsSVZBo
 wkiB4U9c0Uui5yeYfka2qHk0Orwui0Ms9271gAgDNnz3i+CIa8i58mvZpilZ5HEbTfcfICWyl
 uNrFcmBH2bET9zIPW5aAlQELJsyiYv81OamiSpN90wUdOwXtSSGIgcLxB1SjdzI18w6E2QVB4
 j9OdTMkbushjHtUNaktwwBfqJDAFvK0Ch1lWDmIQbo84WJRnYa5inl5IoBPN2g/UHwd4xev1+
 fxoRyH6kBuBK2f+kOScSca6kHy6y/Ja/4UgC4MKTuzfgs/n2Ms6SQ4l3DgCFi/yxotlMtp1Kb
 KOfH7XL7oH2q8e9ZKXWNIcjLm/iIpXCZQIdsSPYSdph7py2TRphYWYtW68Gur+nXASFE1dk3c
 cSFwni5D7AhoSmW2HC360ArYR4cWZv3+gLoSgRh7oGbIMog/aFP1vMFQJpy3fa9zV0KCA3KHO
 BcaHBiNKuSm2BsFujOvFxHWDe5NI34qcZUheIg/ozoIwYTrJseAElL5dzOYywfMJ/HgkTLG1h
 oIQ8KGXYA8qRB5mTcRbUHcxpYFk/bjFYW4Yo7pMl6YXDF/3wSFG7NwfTlrd8UYLHFzVpb/GQ3
 UYEqWWR9HRHgV/6xuP2x2X5kRfer4UyVbbVy8IDRy3vUP5Vs/SVVuYuzjJebMgN+lDD8SVUW4
 JQuukegwylgfBJeVHth4ZFfRD0MZr98FdtZdAVSJL/HJuEByj2VJJnJmXmyBvNXGjwzbMgfEn
 lS8Tr6tmIlL4s8Lyp4HWr9/IQBCA=

Am 10.04.25 um 16:43 schrieb Andrew Lunn:
>>> Ah, O.K. This tells me the PHY is a lan88xx. And there is a workaround
>>> involved for an issue in this PHY. Often PHYs are driven by polling
>>> for status changes once per second. Not all PHYs/boards support
>>> interrupts. It could be this workaround has only been tested with
>>> polling, not interrupts, and so is broken when interrupts are used.
>>>
>>> As a quick hack test, in lan78xx_phy_init()
>>>
>>> 	/* if phyirq is not set, use polling mode in phylib */
>>> 	if (dev->domain_data.phyirq > 0)
>>> 		phydev->irq =3D dev->domain_data.phyirq;
>>> 	else
>>> 		phydev->irq =3D PHY_POLL;
>>>
>>> Hard code phydev->irq to PHY_POLL, so interrupts are not used.
>>>
>>> See if you can reproduce the issue when interrupts are not used.
>> It took a while, but I'm fairly confident now that the workaround works=
,
>> I've had over 1000 boots on the hardware in question and didn't see the
>> bug. Someone going by upsampled reported the same in the issue on Githu=
b
>> [1], and pointed out that people working with some Nvidia board and a
>> LAN7800 USB device came to the same conclusion a while ago [2].
>>
>> That leaves me with the question, what does that mean going forward?
>> Would it make sense to add a quirk to unconditionally force polling on
>> lan88xx, at least until/unless the interrupt handling can be fixed?
>=20
> I don't think you need a quirk:
>=20
> static struct phy_driver microchip_phy_driver[] =3D {
> {
>          .phy_id         =3D 0x0007c132,
>          /* This mask (0xfffffff2) is to differentiate from
>           * LAN8742 (phy_id 0x0007c130 and 0x0007c131)
>           * and allows future phy_id revisions.
>           */
>          .phy_id_mask    =3D 0xfffffff2,
>          .name           =3D "Microchip LAN88xx",
>=20
>          /* PHY_GBIT_FEATURES */
>=20
>          .probe          =3D lan88xx_probe,
>          .remove         =3D lan88xx_remove,
>=20
>          .config_init    =3D lan88xx_config_init,
>          .config_aneg    =3D lan88xx_config_aneg,
>          .link_change_notify =3D lan88xx_link_change_notify,
>=20
>          .config_intr    =3D lan88xx_phy_config_intr,
>          .handle_interrupt =3D lan88xx_handle_interrupt,
>=20
> Just remove .config_intr and .handle_interrupt. If these are not
> provided, phylib will poll, even if an interrupt number has been
> passed. And since these functions are not shared with any other PHY,
> you can remove them.
>=20
> Please write a good commit message, we want it clear why they where
> removed, to try to prevent somebody putting them back again.
>=20
> And please aim this for net, not net-next:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
> The change will then get back ported to stable kernels.

I just sent the new patch, I hope I got that right, thank you! Test got=20
to about 650 successful boots by now. :-)

Best regards,
Fiona


