Return-Path: <stable+bounces-78316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7BC98B392
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1409C1F25A9C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC74194A43;
	Tue,  1 Oct 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Uj5TGdf2"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACD2D052;
	Tue,  1 Oct 2024 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760212; cv=none; b=DuGawxabJPJnvDVsK/NrZ4PyLaJwatGECjSC486NPOjSE8Fwjg2tKsRT+8qvJkSQeGAONkSRKaG8JqYlI7o4DuEUUUjX7Q1BXrY1hRPShxszw0R7SHk4bRv/CCwLsaqfTy763T8cSCRmT9iD8JjlvuYOZUTdngqhLuer/fTN4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760212; c=relaxed/simple;
	bh=UbYaK+zX2oMloTrfw8WNFQQFeDo7GrlQlpT377Wy90A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpHHM1XPp/Pyb6mPLcY8zl15RhdrGW0iD+dtqA/HPfQlW8MjDjlfKRdrV+/W/hP9FzcFL4O/Wh9uXHPCG95Ojt5srmiuVYit4fpVblEhxb5m637IQYrdjb8wZM7qXHT7inVjEIzmPY6nXXoogySm2bGYIAzd0CWTbfLJlonFzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Uj5TGdf2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1727760197; x=1728364997; i=wahrenst@gmx.net;
	bh=vms/8qCUwPUlLxvUeSN5zZsTHMsX0kIYnvjmfjs1vP8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uj5TGdf23AwZ6KFfeeN09wdALroquk5mUr4zNLHmiJRWTSJfF1i45XpiKx+WDfTU
	 S6m/RmkUHQWqsZCPX8EyNylm6/mj2XNgH468nGY7dTajvPe5G9kx9GoWi6wdZgvFL
	 8qb+soM7e0AopU7CdOzUk1ZzSi1yazQpP8SJSSRg6OKBmwEjVxq5RGT75B5FbY6o+
	 S09tt3AdT/p6vk+o/vaHJfS/Kum19J5so3CriPauY0U9/VymWt5bT+gqllJXLmC85
	 A9goqx6FKKxyFwItxKPFzL2J+pyZxfwkc5nuKdZGoidVcOJAyVSEC++CJ4KJL5dwX
	 N15yfhTsazASaN+GNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1s1cVy1IR1-00ydNQ; Tue, 01
 Oct 2024 07:23:17 +0200
Message-ID: <17c9e4c6-260a-40c9-be1f-4f67ec6d5e3b@gmx.net>
Date: Tue, 1 Oct 2024 07:23:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "usb: dwc2: Skip clock gating on Broadcom SoCs" has been
 added to the 6.11-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Cc: Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240930232610.2570738-1-sashal@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240930232610.2570738-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5fWxrpOMC2m6X+PwdSs5ePUhHrKG/PCXOt18RTTdBCizfwpYwi+
 +aEKVEeD5M8AogE3jLMPpga2yTrjpMGwqqVP2yd+SiWCuDj44MDEVdRVGmYPuIC5gHdW5NA
 YmFeiiD3AP15Jc7QLtUYTP4PemMFBYhT3xeBbkEUrkWr8UmNA1nkfVhXJ51SmmtD5BsK+Rg
 VditO0spByzGH7fEpSrqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aODW5LajeqE=;HYMH1C52+7VGTyzLggxILeM3x+V
 ErmpVxnC5gShrmmmTX/8MAPfkri26P2+B0wwYpmiKXHc5V99G6kPtXUK2iH9DHnSpS/TFEAOh
 oVGK9o02s59Q4XAWVTmH5SuvOrMmJXh0R32r+hJ+fJgt6aHjg5ePJJit13t0jzMHD/UaE8LED
 VUOb3a+3mtZPS5Ggc4V2CX548Uk2/w1ar6+vQquSJrr9oohinU58aZ7zHXv0l7g3QYM/MBTLq
 M9kPcD9YChx9h4Zr9NNFNAoSsVt+IpDO1frv57hSIZw6md8JGgpYx9ScDkhfnudZLPRB36mNd
 aW+hRckUB4bL3TrkYijCPcwif1IwGfh913ShXgAOi7K4eIgN9Cml+Fkz5whEIPTGOHRyhtffX
 Fj1lhAzaBSSJbxMOuxa8LG5Y4CFRfX/DWLTDye4j4hq5nI7LzDr0uxXajVWQU21hNbj3qX1yA
 85zGedu8zv2DUP/RZw7D7cRfbwH4bRQkMveMpJpiVcdaG+LO2tZlbmGL4BVv1KClSG+9NUJRV
 U7mpTsD6wkHszLcel8TpNtWBf81ETZuIzXGVVBzdQlx0wvteMlkqtwLwhUIgC16Gk2ieqDg13
 97IvMr3//0OwQXw9zKhX0PCbltJUm4X9gIh+W3hwtANzh8ddrbrtpHYfa2MKub6RqFL7kU8Bp
 dcNvNNPSKbrbycHxZiAHVzuiYLtcxWpnGiclP3ENHTyJc0NcZP2S9CLyHz58bFKODuLVCmGPm
 b2O13+ZSfz2iN2KO+zaSrOZAYs+/2YqrGEM4xBL36TyKrIltTAYTZd7BrwCjNJS8Vu3VG2P3d
 jNrnxOpF1Yinih0q8DmmgA3g==

Hi Sasha,

Am 01.10.24 um 01:26 schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>
>      usb: dwc2: Skip clock gating on Broadcom SoCs
>
> to the 6.11-stable tree which can be found at:
>      http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue=
.git;a=3Dsummary
>
> The filename of the patch is:
>       usb-dwc2-skip-clock-gating-on-broadcom-socs.patch
> and it can be found in the queue-6.11 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
please do not apply this patch to any stable branch yet. Recently i
discovered a critical issue [1] which is revealed by this change. This
needs to be investigated and fixed before this patch can be applied.

Regards Stefan

[1] -
https://lore.kernel.org/linux-usb/a4cb3fe4-3d0f-4bf9-a2b1-7f422ba277c8@gmx=
.net/T/#u
>
>
> commit f2e9c654eb420e15992ef1e6f5e0ceaca92aacbb
> Author: Stefan Wahren <wahrenst@gmx.net>
> Date:   Sun Jul 28 15:00:26 2024 +0200
>
>      usb: dwc2: Skip clock gating on Broadcom SoCs
>
>      [ Upstream commit d483f034f03261c8c8450d106aa243837122b5f0 ]
>
>      On resume of the Raspberry Pi the dwc2 driver fails to enable
>      HCD_FLAG_HW_ACCESSIBLE before re-enabling the interrupts.
>      This causes a situation where both handler ignore a incoming port
>      interrupt and force the upper layers to disable the dwc2 interrupt =
line.
>      This leaves the USB interface in a unusable state:
>
>      irq 66: nobody cared (try booting with the "irqpoll" option)
>      CPU: 0 PID: 0 Comm: swapper/0 Tainted: G W          6.10.0-rc3
>      Hardware name: BCM2835
>      Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x50/0x64
>      dump_stack_lvl from __report_bad_irq+0x38/0xc0
>      __report_bad_irq from note_interrupt+0x2ac/0x2f4
>      note_interrupt from handle_irq_event+0x88/0x8c
>      handle_irq_event from handle_level_irq+0xb4/0x1ac
>      handle_level_irq from generic_handle_domain_irq+0x24/0x34
>      generic_handle_domain_irq from bcm2836_chained_handle_irq+0x24/0x28
>      bcm2836_chained_handle_irq from generic_handle_domain_irq+0x24/0x34
>      generic_handle_domain_irq from generic_handle_arch_irq+0x34/0x44
>      generic_handle_arch_irq from __irq_svc+0x88/0xb0
>      Exception stack(0xc1b01f20 to 0xc1b01f68)
>      1f20: 0005c0d4 00000001 00000000 00000000 c1b09780 c1d6b32c c1b04e5=
4 c1a5eae8
>      1f40: c1b04e90 00000000 00000000 00000000 c1d6a8a0 c1b01f70 c11d2da=
8 c11d4160
>      1f60: 60000013 ffffffff
>      __irq_svc from default_idle_call+0x1c/0xb0
>      default_idle_call from do_idle+0x21c/0x284
>      do_idle from cpu_startup_entry+0x28/0x2c
>      cpu_startup_entry from kernel_init+0x0/0x12c
>      handlers:
>      [<f539e0f4>] dwc2_handle_common_intr
>      [<75cd278b>] usb_hcd_irq
>      Disabling IRQ #66
>
>      Disabling clock gating workaround this issue.
>
>      Fixes: 0112b7ce68ea ("usb: dwc2: Update dwc2_handle_usb_suspend_int=
r function.")
>      Link: https://lore.kernel.org/linux-usb/3fd0c2fb-4752-45b3-94eb-423=
52703e1fd@gmx.net/T/
>      Link: https://lore.kernel.org/all/5e8cbce0-3260-2971-484f-fc73a3b2b=
d28@synopsys.com/
>      Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>      Acked-by: Minas Harutyunyan <hminas@synopsys.com>
>      Link: https://lore.kernel.org/r/20240728130029.78279-5-wahrenst@gmx=
.net
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index a937eadbc9b3e..214dca7044163 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -23,6 +23,7 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hso=
tg)
>   	p->max_transfer_size =3D 65535;
>   	p->max_packet_count =3D 511;
>   	p->ahbcfg =3D 0x10;
> +	p->no_clock_gating =3D true;
>   }
>
>   static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)


