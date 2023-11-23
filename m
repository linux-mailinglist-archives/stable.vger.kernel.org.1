Return-Path: <stable+bounces-24-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDCB7F5B16
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BA1C20D24
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D471F19D;
	Thu, 23 Nov 2023 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AGTsKSwK"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C3CB
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 01:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700731852; x=1701336652; i=wahrenst@gmx.net;
	bh=uwI2CDxi9zVsr6y4Yba1XaDLRcdL3sEmi6pjhlCpeyo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AGTsKSwKWY34m1mEPHE8ZYlJMLi4rpT030hh+JHvn/TLYvQG3ruMwTKf7DpVf36n
	 QTo7gx5cuooMcTa1HtNa8lD9XQMTiAlq/vdc1bB0acIVXsSsJVhaGjZr1FzmnTXEF
	 3EsRHro8po//nfL3tVZ9u9wKJUJe7imyFZDqzOLOnXiVta9WFJqC/9HpRae6zHCdb
	 QyQ+MMh3aKX6DM3oM15Q/7FYSD7CjKwBDUjG99MZeRvx5shry6Y5ZczLbq+6vwMv7
	 M3A6XuKChr79jJjNWVh2axlKTWCkpijXWZw1pmubLoXzgzb6/JtTtpAR3zsD7hLFf
	 nw+Fabj/fcg2Kje31w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1rLydY2kPH-00srZC; Thu, 23
 Nov 2023 10:30:51 +0100
Message-ID: <ab40f12c-47bf-4915-bdd4-587561563382@gmx.net>
Date: Thu, 23 Nov 2023 10:30:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] pmdomain: bcm: bcm2835-power: check if the
 ASB register is" failed to apply to 6.5-stable tree
To: gregkh@linuxfoundation.org, mcanal@igalia.com,
 florian.fainelli@broadcom.com, ulf.hansson@linaro.org
Cc: stable@vger.kernel.org
References: <2023112257-putdown-prozac-affa@gregkh>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <2023112257-putdown-prozac-affa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hmC6D6e7zFUMNT+K3woMjiRdJnYfWL8rh+C8v9A2FgFws4rGigu
 T9abwY5XZIVQ5Y15j3wOsnJTO8FESYJhsWJwe1IOEpK6SGAZ4AEANKALATN80528c7OWzeP
 tegyaoAXFkeJ1LWRnqgo2jg0hRYxguCQn8mInblsZAKkP2yIYhyy37ah8vywHdBULQu9OK0
 ga276ywr4fARA7jwvQCJg==
UI-OutboundReport: notjunk:1;M01:P0:DfeZe7qzf9I=;ts5UtjYfxRfmbsN8iaOnbsWXW3f
 ShPqewFuRW+8EDspeLTGf410Rv37j177o9Z5haR+HFkioSKm5uYgfM8oswtwIUMm1OsTsvOGP
 CA/O07yd6jfQpMSSJgfreeKrpXwc8JVs19tE8UDh8IovV8X96ehO3WDC5u3UKh6aHT3pdCem4
 8U+YwB9WQS+Z0JzOJSFweWvSYQ5DSM58SBCT4fULfsy6t8fZFO1UUL6/cZV/TRQdOYnpkTZhE
 ddWrxNGL5GY41dbGyKsoXrRMl7FbNGsyOXzzQNOiiI9RXP3nlwqgCUkxxQIdomfAupNNo/mx+
 nEjPYizLtZf6BilJnLFXbFH43xI4DQsYdcZZSgIL7P/mJQGMmwok4TQRktFrxEKV9WKNxE2lc
 vZc5ahfJZ12r1p8rIDoPNkbZ9dLpxp9tga39+nUuDBFoqoTDzsv2skIAMgPHYYSnTMBd64Nf2
 5ueK5DbzrSJFyBxO4y4u8hemJA03G7TMZvrcE211T1OlQcee/K8OP3dDZxksHhMMJpKq896FF
 H9BrayiRlBhVfS4XjXnRwcyTUfGKh73D/dDNCHbFFFAnzYxKBB2hRBNV9kPB68we8wZyvJloy
 DST+IzdEvVOUxaI4F6fAURBxy1JOhCXof16rf19jMn/sGXe+TUY9HBvq3S0yu5mlyfH28OGbd
 b9zJl3lWkB6R2pRge6Fg84YBNTAlf+GDjxLtv3bHeMgBdTqf0BNZ2FoDh2SoL2nyZgbTJ2Il7
 6+9ZxcSdCpQp/hl4LmVbsnwIH3BI0BJOBw5/7hWeoV4cRe8qvAz8XvwH7M3C3+F6SxfwRkwVA
 I6CHB1PerdpfOvWxe8JztJoIouEhU/qjjj8DLSvhgDpogpKqrMP3ca2C/xY81mmnL7j1iJbmR
 u4tHMkh2EdddMc4OflMt921Sy3XMEQaxqoS+KOsL2L+3OC5OwTtFSyN/0Zc4FXh6ufSGJUMuM
 haA46+gHcV37ji24cvuDKQn2Tfw=

Hi,

Am 22.11.23 um 19:52 schrieb gregkh@linuxfoundation.org:
>
> The patch below does not apply to the 6.5-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following comman=
ds:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it/ linux-6.5.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2e75396f1df61e1f1d26d0d703fc7292c4ae4371
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112257=
-putdown-prozac-affa@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..
>
> Possible dependencies:
>
> 2e75396f1df6 ("pmdomain: bcm: bcm2835-power: check if the ASB register i=
s equal to enable")

the reason why this doesn't apply is that the driver has been moved
recently from soc/bcm/ to pmdomain/bcm/ . In this tree the directory
pmdomain doesn't exist.

@Ma=C3=ADra Do you want to send the adapted patch to linux-stable?

https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

Best regards

>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 2e75396f1df61e1f1d26d0d703fc7292c4ae4371 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Ma=3DC3=3DADra=3D20Canal?=3D <mcanal@igalia.com>
> Date: Tue, 24 Oct 2023 07:10:40 -0300
> Subject: [PATCH] pmdomain: bcm: bcm2835-power: check if the ASB register=
 is
>   equal to enable
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control"=
)
> refactored the ASB control by using a general function to handle both
> the enable and disable. But this patch introduced a subtle regression:
> we need to check if !!(readl(base + reg) & ASB_ACK) =3D=3D enable, not j=
ust
> check if (readl(base + reg) & ASB_ACK) =3D=3D true.
>
> Currently, this is causing an invalid register state in V3D when
> unloading and loading the driver, because `bcm2835_asb_disable()` will
> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
> ASB slave for V3D.
>
> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20231024101251.6357-2-mcanal@igalia.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm=
/bcm2835-power.c
> index 1a179d4e011c..d2f0233cb620 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power =
*power, u32 reg, bool enable
>   	}
>   	writel(PM_PASSWORD | val, base + reg);
>
> -	while (readl(base + reg) & ASB_ACK) {
> +	while (!!(readl(base + reg) & ASB_ACK) =3D=3D enable) {
>   		cpu_relax();
>   		if (ktime_get_ns() - start >=3D 1000)
>   			return -ETIMEDOUT;
>

