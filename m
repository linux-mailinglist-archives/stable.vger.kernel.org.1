Return-Path: <stable+bounces-123227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C9A5C3FB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2D17AAB56
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721625CC9F;
	Tue, 11 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="TfMw8114"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B325CC77;
	Tue, 11 Mar 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703810; cv=none; b=J3uRkzOF5AKtQ03oUsczUy4KrYNiwSRYszL+J+AD2C9HcXeA9VXBr1MfNdyhxfw/ubq/spJmyDGvc8SoOymhQU0FiaG8FnYqLQ+3N6Im/u4imvJ+8tRX9+vahRlfrXa5BdQZR72HYpMngxUBbmyp2rbLIOeT0yiy2amkGtLe4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703810; c=relaxed/simple;
	bh=mC/5J7Ya9VRj3TG8oIfCpNT8VWsPU/gApt0oe4jH43U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0QMryTEnQVNWCIcdwizf7j8V7r7j2J/GBrsBofY5VqibCgERLsw8whlJLvPLSbRYXuYwWiFX5bf9IIzc2usa5XiR1tNH+LzVsdXEahMzOpN+XMElPm30V9dvybK0oZ3/IfcL9/7iu3c1ORs9FOuW10Y9EuCmMigVEqM/vF/yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=TfMw8114; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741703804; x=1742308604; i=fiona.klute@gmx.de;
	bh=7T2Eg25mErZe40rj8TyAYOGzmsWuKdrSGJHWaZx+Q8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TfMw8114RB24F7ztJ9T4OQOly1wRMxWyq43c7beDx7XhJLqkqR13dIp5Qazg/ASI
	 DO1i3BbiSQgusdjd0SJhG1f9yluj4soUjDogyW1hkmqwUeiG4cH9inxZy3AY7hiKJ
	 PinTJx15VCMn1bKipKxV5DzxlQzngrJP8tIQaSlkbNZtUcGe0YW735sRMgZ2IaDF0
	 Z+e9DMms+XNiXtFARUl/U6iA7JMSHLEJW7BM/0Qni7RyNVkBoJVKU9XxB5/gpiVIN
	 UXBWVwh8fJK07mH1XJd0gCQckDsBNhUAxgSGSlCIRgyIwJZ+GVnbpAJNvLqCfeNfg
	 rlQusdTj207pjLDuzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.124.191]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5G9t-1tBUsL2SQv-00weus; Tue, 11
 Mar 2025 15:36:44 +0100
Message-ID: <83b8ec69-0f7b-4ede-bf4f-f35b5d4fa4b2@gmx.de>
Date: Tue, 11 Mar 2025 15:36:42 +0100
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
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y5lSVKyec42DqzTu9KXl+1p64Hiv3BOm5Ij4FQIqfJDN830PoOc
 aNDa0PpzlmCobpwFKVktXCS6NuQB4JhiCHo5NnoNBOIOFJ8lfIWa9dxYVQ7t4TtMYdHc0yQ
 NesTdvAPVIgTcp4fHcGUH/glod4PUdN9hYBy+i7POLxjm45GGl6Rvk0Dq8mArX6rvQwceEb
 3csNvPn4W/Ebj5YaNybcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0cL0Ug/OdVc=;H5g+wwiR5FzkTIk5YpgDcnh2XVh
 ukpI9WmiAL3aT24CojMXwYdK/qaeFbvLdrG82eyOGELUJxUqZOCrEP4GYuJ5+WQkiFalwBSSW
 ccyVe0veSaID+LRcbGUi39O+Ac7SQI5sKu4A0WNFawJPSZ8OQRwEaZwbQ17Nl4uk7TGPriKVV
 1P+bK5mwcghETEvMWxqm+pGJFiRZ5gFC59mCkF9+6+Mx8bCl08JXnKwrWF3J57D2QLLMTrS8K
 42WcNonj5jr8USsqJlEgbnm7LPu5oN4qZQQ0XwnJ6ZEMhouo4rfI/ea6qsTbrMGLjl5Me7fiu
 DDew1moYjAJvlPT3gH46UUmTO71BarNhh2zN3I7/YByPzAMaiWLFxN/00HgicHXh7yBIWKpWD
 G3ZWxrTP+QbGxPfRJw7ddx/oIod37HX8+z/7WItP5Dw0uysq40Rewl7RQraLV2rISVYCsx5F6
 cqXpXvHZDOFIUH0SNyS1Q7LFgMwoGK5zLq3wa8wPWj5HqOSPpZgdFikYkvSNuz9nStwIBT2Sq
 OjrZA+vigMWSpUSe1IYYdQZtOxu80PDzxuyXLjSJm067bMMilTzVIwFScMayclc3yb5F9MOqB
 AXmTSTw9hDsEunqnYZT40KXQDLOjnmiWU19veYYhLYcgjqLXEOOCKX98s3wdiXy2EB6m6ACcO
 4EYhJY8c71H5D3rXbt7ADxd4s8QbzGfo+OEU78IRZhavy7WD4tcXMIe7CslRTkNASxUhwBo7P
 N6MHPXwtOYZmr1ZEBBIBTnnFBJIRgNQODYJ4mOHCl2c+R+Kc5tFsc/ky2nbcQ++A5lDSqdDO1
 juQyuOIYxOhwN+H+stbpe4RWse8JzeXWYUimfyFmr/R86NNJ7nlAycZKE/UzJ9YC1HE3E4txm
 OpKYwHjGDBUPoKuj/X128jDnjiBJzQGCidFq9pRw4oD82MVf+xrWyw91BHXzDmoyluMaVqZxD
 fMzwo/7jeJmTlbERsBn4dTAp2EYGHNmDp1JTf32FKo0AeEHhUoKhlOomk99mSmqaHaXdatFRX
 RjAJK5zmUuw7BAeQ4TFizoA2MPehYqBcHJdh444e9CnbsE11lcHQoCSaA8OhAFtJhuk0W7GFo
 GRbs5CFgkhoo9wEUd/R5GIlGcZvHa0osBvZqjXuho1a3eEAUxVZmGQHWQZS/at2boOwI9PPal
 +fCI5Bzi4FcuL7I4HvqHiuGZSrOUbfsL33SLo1lXRWUyNH/1N5KeafdvC3EUGVHfrtUtK93zT
 8+mRmVVUCifElqC61IBuA89VV1dzJyD/dkDMq/rqbJ5TprNkZwDiEkc1xfsU1hFxnKqXFMTQH
 Je+D3xp7gEfemy/40MxNEUFSzXFO7c9G+L14wDQJkR11trDAoIhzDKwUWiDPxhxG9Fc75PjHQ
 9WZqTVKdpqRcznrJQkiTd2T7q/Aw+E8i3ncFZ6cZpmTTl4XTyv3t59UWuheTOnRT7pUfcj8ro
 7SLMQcg==

Am 11.03.25 um 14:22 schrieb Andrew Lunn:
> On Tue, Mar 11, 2025 at 01:30:54PM +0100, Fiona Klute wrote:
>> Am 10.03.25 um 22:27 schrieb Andrew Lunn:
>>> On Mon, Mar 10, 2025 at 05:59:31PM +0100, Fiona Klute wrote:
>>>> If a new reset event appears before the previous one has been
>>>> processed, the device can get stuck into a reset loop. This happens
>>>> rarely, but blocks the device when it does, and floods the log with
>>>> messages like the following:
>>>>
>>>>     lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>>>>
>>>> The only bit that the driver pays attention to in the interrupt data
>>>> is "link was reset". If there's a flapping status bit in that endpoin=
t
>>>> data (such as if PHY negotiation needs a few tries to get a stable
>>>> link), polling at a slower rate allows the state to settle.
>>>
>>> Could you expand on this a little bit more. What is the issue you are
>>> seeing?
>>
>> What happens is that *sometimes* when the interface is activated (up, i=
m
>> my case via NetworkManager) during boot, the "kevent 4 may have been
>> dropped" message starts to be emitted about every 6 or 7 ms.
>
> This sounding a bit like an interrupt storm. The PHY interrupt is not
> being cleared correctly. PHY interrupts are level interrupts, so if
> you don't clear the interrupt at the source, it will fire again as
> soon as you re-enable it.
>
> So which PHY driver is being used? If you look for the first kernel
> message about the lan78xx it probably tells you.
>
>> [   27.918335] Call trace:
>> [   27.918338]  console_flush_all+0x2b0/0x4f8 (P)
>> [   27.918346]  console_unlock+0x8c/0x170
>> [   27.918352]  vprintk_emit+0x238/0x3b8
>> [   27.918357]  dev_vprintk_emit+0xe4/0x1b8
>> [   27.918364]  dev_printk_emit+0x64/0x98
>> [   27.918368]  __netdev_printk+0xc8/0x228
>> [   27.918376]  netdev_info+0x70/0xa8
>> [   27.918382]  phy_print_status+0xcc/0x138
>> [   27.918386]  lan78xx_link_status_change+0x78/0xb0
>> [   27.918392]  phy_link_change+0x38/0x70
>> [   27.918398]  phy_check_link_status+0xa8/0x110
>> [   27.918405]  _phy_start_aneg+0x5c/0xb8
>> [   27.918409]  lan88xx_link_change_notify+0x5c/0x128
>> [   27.918416]  _phy_state_machine+0x12c/0x2b0
>> [   27.918420]  phy_state_machine+0x34/0x80
>> [   27.918425]  process_one_work+0x150/0x3b8
>> [   27.918432]  worker_thread+0x2a4/0x4b8
>> [   27.918438]  kthread+0xec/0xf8
>> [   27.918442]  ret_from_fork+0x10/0x20
>> [   27.918534] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>> [   27.924985] lan78xx 2-3:1.0 enp1s0u3: kevent 4 may have been dropped
>
> Ah, O.K. This tells me the PHY is a lan88xx. And there is a workaround
> involved for an issue in this PHY. Often PHYs are driven by polling
> for status changes once per second. Not all PHYs/boards support
> interrupts. It could be this workaround has only been tested with
> polling, not interrupts, and so is broken when interrupts are used.
>
> As a quick hack test, in lan78xx_phy_init()
>
> 	/* if phyirq is not set, use polling mode in phylib */
> 	if (dev->domain_data.phyirq > 0)
> 		phydev->irq =3D dev->domain_data.phyirq;
> 	else
> 		phydev->irq =3D PHY_POLL;
>
> Hard code phydev->irq to PHY_POLL, so interrupts are not used.
>
> See if you can reproduce the issue when interrupts are not used.
Thank you, I'll test that. Given the issue appears rarely it'll
unfortunately take a while to be (mostly) sure.

Best regards,
Fiona


