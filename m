Return-Path: <stable+bounces-6676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF89812181
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99A41C211CD
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998D81828;
	Wed, 13 Dec 2023 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="d1lIymFg"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A55E0;
	Wed, 13 Dec 2023 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702506675; x=1703111475; i=linosanfilippo@gmx.de;
	bh=ow0eNzFaApvdODhCrkxtlTs1mvPnhPOnKfYtDQtRAOA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d1lIymFgQfvd+w/akJljGu/fADS93WUpG59uB+U7JTuTp2OfaGDDkf7pspYNQb7I
	 2e/XkALu/n1UhgfByTVV3b3vndKQWwYWgoqNrgcNzI0yd1sLkllq1QGvZhQaVl9cs
	 fTdwL0ciVvLS0Yvc2ksOPtDaxnM/CzkU2XnLY877cUiCxNHF/OYc+UWT/zRH8e+jA
	 0L2C2c6Td1lZT58V7XKE/uWcpbjOnvidbjH7Y2BfGdzpf/yM6Ltjk0GfcD02vQxBv
	 Cu9+Pdsd5vIol2vht9vUQWHwRgdGMDIeQ9oacgh8k/xuofdH9ZddjlLsct8SJiccl
	 5tDGPHLL8VLYhsnvHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1qyvxV42kp-00HNfS; Wed, 13
 Dec 2023 23:31:15 +0100
Message-ID: <9271d88a-52bf-4f3a-9861-fdc5120cfc31@gmx.de>
Date: Wed, 13 Dec 2023 23:31:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] serial: core, imx: do not set RS485 enabled if it
 is not supported
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, LKML <linux-kernel@vger.kernel.org>,
 linux-serial <linux-serial@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
 p.rosenberger@kunbus.com, stable@vger.kernel.org
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
 <20231209125836.16294-6-l.sanfilippo@kunbus.com>
 <ffdaf03b-65af-731f-992-3e90ca6fca@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <ffdaf03b-65af-731f-992-3e90ca6fca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5rOHkfsE4s9ePvnGDmyusjLIj3yIVd2eQPWYbqRlq5CGud6gVIn
 X+I9FPjinXMngbO+6bp8A9/EsEzNaJgNXMwbsS9yvNxF1tRc7PF4xuthVI8ibtPw5QJn+77
 8EdcfCgDO33pq970SCvijgy82MPA4afZMI33IogmjzNdEIiTeRu92iCYNINYQWb9ficQTRh
 OCpIUYGrGXqh/fEJgtY8A==
UI-OutboundReport: notjunk:1;M01:P0:Bj+lj047/H8=;lrv2zARKxJtcHPybrCx9es6QyxT
 hVCkvcK3YZbhRR46EF4MBDeYo9szoAvZXOEygZSsw+lXizouvA88I2L+xJUlQH+xMZWyYzLxE
 ZmKx5qFadWtc7A15irJATZV50FyyQw68xcLC3AY32whbSBy58mTfiVQA41UX6lyV6boTd2Ux7
 86YIh1LzlvEWzCHUnnPH5T2TT6bQjrgYAPtoF2vTdXHBqwImoy4Xbw/Xt7prCjPoWGFDZmyJ+
 WQVW6w9ga6LGWRhs8Tj7cif3uknR19sc8FzJjOA34jS0jaR0U1CvXy45AI8iCouzGhAcZuSPS
 YxrQNa18mL8ZAt04dnZd1MJDb58JRbho32JJcQ8hMGkBixYXfZ/xP6iO7zIjjt/rDZgfOhOGz
 kgwr3jkyRwS3MpmDDZBBC4aeS4c3XX5pljozWaG6q1r/UFPHqb9JXPNQPJO3EZOm/23ouSYgZ
 R4htMtvVqUPA4K55z2KOm1n4x2+jj3xianSdeMMPV+BgAsXdifo4nn1+7VbHyRHoW1PhgozyB
 MFDFryJ7eWR1uFtmtBydegDy8RL/l1G4+4nNWzyydxZBAJ8eVeyXtvuzDJRyUEpX6h1JwvCrN
 RRDnv0nhoImVL4MgUurQ4ZeqDDCob6+pBJeSjxz1XVi+20H36p+Qpaz4VjW2S5IUV4bBp/gMe
 WVjcmJRagp0ZfGJ4QCHpjXy3Zm8OVOeyzvoShT4XTmWWTljADocWW608UK1quEoS37IO/Ja3+
 7Mx3YcTS0AfCZM5jFtuKUfkW5ouSrJ+0q1yBCQGx/4yILSfK8YTMY7ihLlooTqWasKg/tzn46
 REuH+FVQDTJE8yHpDIeqq+KpKUKhIYBNloHVzEkl9daB7cN0Dot9vcoWTfN0xu4iAIYnRn6kl
 PTE+syDMKPjqOlLwZjnlKIrNO/aIi50incblaOAOW6Bf5oi2JtFL6QG1gUYONev3T+JSuFJ1w
 yzWURA==


On 11.12.23 12:00, Ilpo J=C3=A4rvinen wrote:
> On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
>
>> If the imx driver cannot support RS485 it sets the ports rs485_supporte=
d
>> structure to NULL.
>
> No, an embedded struct inside struct uart_port cannot be set to NULL,
> it's always there.
>

Hmm, ok. What I meant was that the structure is nullified. "set to NULL" i=
s maybe a bit
misleading. I will correct this.

> Looking into the code, that setting of rs485_supported from imx_no_rs485
> is actually superfluous as it should be already cleared to zeros on allo=
c.
>

Yes. BTW: Another "no_rs485" configuration setting can be found in the ar9=
33x driver.
If we do not want to keep those assignments I can remove the one for the i=
mx
driver with the next version of this patch...

>> But it still calls uart_get_rs485_mode() which may set
>> the RS485_ENABLED flag nevertheless.
>>
>> This may lead to an attempt to configure RS485 even if it is not suppor=
ted
>> when the flag is evaluated in uart_configure_port() at port startup.
>>
>> Avoid this by bailing out of uart_get_rs485_mode() if the RS485_ENABLED
>> flag is not supported by the caller.
>>
>> With this fix a check for RTS availability is now obsolete in the imx
>> driver, since it can not evaluate to true any more. Remove this check, =
too.
>>
>> Fixes: 00d7a00e2a6f ("serial: imx: Fill in rs485_supported")
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>

