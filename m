Return-Path: <stable+bounces-6675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9381215C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89D31F2113A
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA5481823;
	Wed, 13 Dec 2023 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="GJej2Go6"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D09C;
	Wed, 13 Dec 2023 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702506186; x=1703110986; i=linosanfilippo@gmx.de;
	bh=DQ7xBBQCgcshkcRM262ggbnkjqtSZ6ncm89KuR3cYt0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=GJej2Go6lh4QHv8jJwR0EdstE3FwpWKqBmk6Jo47z1QpK8QJ4D980XgbFTeZo/C1
	 8Vp+yN4P2uCp+8TQDSm2dCveGp47KDflGeW2Q8IFgd+lF33OOGT9nU1HnppKQK6Td
	 GeeKuaOiyPIxziGdex9PW543G8tmC+I9JBgxS8BiGGLq2Lr0o52kUP3aV8md+TMJb
	 tbxtQtyFj7UpKPcZq8RNpGBoMfJpWyWbtdw6h5a1flXBLqkIERCWAYzIyp4TIBKbT
	 Duh6SX5+Gr4pbmj+m3H2e5Id6SpnFzBWcSHLjRY5FAqm6HcQwOXCRvb9qgEobSBGY
	 kktoK3+ud+mMVwkXlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1rg0cz1xVr-00gmKJ; Wed, 13
 Dec 2023 23:23:06 +0100
Message-ID: <abec93ce-4c6d-47e7-8fd0-99eb5b9e6043@gmx.de>
Date: Wed, 13 Dec 2023 23:23:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] serial: core: make sure RS485 cannot be enabled
 when it is not supported
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
 <20231209125836.16294-5-l.sanfilippo@kunbus.com>
 <5a1f1e87-38c8-7f0-35bf-689ceff844ba@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <5a1f1e87-38c8-7f0-35bf-689ceff844ba@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p39tPFUa/8fO6Ycej9GbAUfZkBZXy6SSkJUWOqMehm4VB+hSPL1
 QJaahOi7vSMYCcpsNhpzadNvK9BC6nypWxho1z26swS0FTlcOp7lhkUSIsoyE0KLpzzWJDV
 UPnrr9fjFDXTngSEGIQBvTp6hkiRjoNRooqBbJ+BqJ53xmERUofbj6kCHh6jNgrVdXS2egh
 /FCBDJF/lCJTxTGpsJ9Ag==
UI-OutboundReport: notjunk:1;M01:P0:Vkt1SRPMJSg=;QUWY42ysatQmaTCuL3u4p5Uz5kA
 PFpGzR0gptWG9miTP/vOZuHJQKHGi8MBNyZ7unyt5eKtb5AxkyHpIlvW3ruaxU5cM+X2iVXf6
 7QdDjx51eyEyabmjefn652e9eoQXu/xIRUCBPB9mJbFROaXXXgfp/KQ5sHDnjVPle0QRSzDWN
 jSZKvtbBB2vG/LrbcPvvVVvTxIGQCu7H6Fn6SqPcL40Km0XHQ+9hGz31ms4EzjOyWGeczc8Vg
 cI98nEOBHut0Q9yDYAwsAwiCCqMjEoZL30RkJWwoxJ+Q1pExoFS+7Tr0Sa5mylYdbQGCL03AE
 fX/piXa6R9K3w1OCfIpsLg5iNvuWa5myLCdo/DJM4zyMUXtLTxWBgqluKo7v2LBBu7tg8CNIY
 4KfiVXJR3/k5Qsqo3YqnJeLO7gAkGnG+liv9rjFqXTXEhqpg42DAopx9mQWKvJkTZyP4wfTKG
 B7Fk8xILWBFWCgHxIzlZU+986CUUktq9W1TBUt6zr+1AKomDn4fzSj37XFexMwhrlSpru9SvT
 TAQGEkhFOCx6uyA5UFLkR0rXggIWVOw2OMLCTL7vbyI6xkj1+JxQiGSlO3Go9mWusF+l65VYE
 2SVtCLE4fIP5VXIJayeKqYG7TLqQu9BxhxIGz3DfW7wyLOrlN+R0AZNHNeY7uarj2zGv+pE76
 8Rk8UL28cZwx5fCmBZY9MTxVhrSLRZVxFct8lASHa3r45ZmD4DGvwzeFCnZhbUoc6sWRLOu0k
 +OuThidqVs4VxvTWY9mBiKQAl4V9F3s9v1Q4d4suwF3l+W6BkSRHL+SNwRrtcpgEiMMXRxU3k
 AZFZS9RowLOh8au1VeK5KrbZ93tH6/3OrqV8x7YP6NofN6ZYRBjJ4oaSmP1vkwrhsjes0QNn2
 SooCO7GjsS0Cbzguo5+RbZR8ignrmXk54unA3X2XZLkuq/PKehi1XZ42AEwtMMqEFCi632br/
 pfbw5BsBcRgI6PgDxVAKqBL0aBU=



On 11.12.23 11:53, Ilpo J=C3=A4rvinen wrote:
> On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
>
>> Some uart drivers specify a rs485_config() function and then decide lat=
er
>> to disable RS485 support for some reason (e.g. imx and ar933).
>>
>> In these cases userspace may be able to activate RS485 via TIOCSRS485
>> nevertheless, since in uart_set_rs485_config() an existing rs485_config=
()
>> function indicates that RS485 is supported.
>>
>> Make sure that this is not longer possible by checking the uarts
>> rs485_supported.flags instead and bailing out if SER_RS485_ENABLED is n=
ot
>> set.
>>
>> Furthermore instead of returning an empty structure return -ENOTTY if t=
he
>> RS485 configuration is requested via TIOCGRS485 but RS485 is not suppor=
ted.
>> This has a small impact on userspace visibility but it is consistent wi=
th
>> the -ENOTTY error for TIOCGRS485.
>>
>> Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")
>> Fixes: 55e18c6b6d42 ("serial: imx: Remove serial_rs485 sanitization")
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index 4eae1406cb6c..661074ab8edb 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1448,6 +1448,9 @@ static int uart_get_rs485_config(struct uart_port=
 *port,
>>  	unsigned long flags;
>>  	struct serial_rs485 aux;
>>
>> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>> +		return -ENOTTY;
>> +
>>  	uart_port_lock_irqsave(port, &flags);
>>  	aux =3D port->rs485;
>>  	uart_port_unlock_irqrestore(port, flags);
>> @@ -1465,7 +1468,7 @@ static int uart_set_rs485_config(struct tty_struc=
t *tty, struct uart_port *port,
>>  	int ret;
>>  	unsigned long flags;
>>
>> -	if (!port->rs485_config)
>> +	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
>>  		return -ENOTTY;
>>
>>  	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
>
> Looking through debian code search entries for TIOCGRS485, this might
> actually fly... I'd suggest splitting this into two patches though.

Ok. I will split this into two patches or maybe even leave the change for =
uart_get_rs485_config()
completely out of this series (which is only about bug fixes) for now. Tha=
nks!


