Return-Path: <stable+bounces-6678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE3812228
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 23:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0883DB211C9
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70781E53;
	Wed, 13 Dec 2023 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="bCCAkK0l"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC2D0;
	Wed, 13 Dec 2023 14:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702508133; x=1703112933; i=linosanfilippo@gmx.de;
	bh=/y0wEErfQaUWPQ8zqwwuu6OFCzGo6/tXPuv3/jpuNy8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bCCAkK0lf9fSZsImv9lKbhuShujBCQcLLR1Jb70gV1zYFcoM5v6/ICL8qlXbVbRN
	 dvdIvIC9R85PhTXE5n8s/SMVal/g2NhXsFrrLk9a4fW69wfUunhWhD2wiS/Jk8Xdw
	 2S2QOgmApAH2YhG5HVETl4u9XGHgOWPFxUjqffeh13hb6NxZ2mgh4MSd4tV6DTmEY
	 An2fnVcUpO+uq122g1GtxKSKcMWF2tFTSyRtjdMQ+hGGFbXbFrS+N4WdJP/xkBVcf
	 DmvW26doF/yDFgxclctVck2hlouTwk02ua874Q7C8/F6S56Dd0gNvSZJ1n39c8TYs
	 kORuqBL6dSwnpEyQHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.180.3.177]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1quvKD12Hk-00KyCf; Wed, 13
 Dec 2023 23:55:33 +0100
Message-ID: <e59cf6e9-1f1d-4252-aee2-818fef9c9936@gmx.de>
Date: Wed, 13 Dec 2023 23:55:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] serial: omap: do not override settings for RS485
 support
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
 <20231209125836.16294-7-l.sanfilippo@kunbus.com>
 <e1e8d86e-2cb-db8d-77a5-dcb5cd3fbb22@linux.intel.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <e1e8d86e-2cb-db8d-77a5-dcb5cd3fbb22@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SIgpHmzRjggQCx8l60M5/USwq0CPJwr19UwqrlNnMnZ1m3b83Na
 HKl5Zl2OI6jeOdSZbucZoVGUMhR9Pk7j4jXtKRpSWj4H3CxSbYwfCtRfURB1PpXRyGgjJ4L
 aPg9S99Ipg7JliKoiDJGHYbvwJGJsOXxNuPd3Wvmj9kflxalMxED5K3V8OD5zkGJMSSqqjE
 qQDuBfk6KHNbthMlDRbfw==
UI-OutboundReport: notjunk:1;M01:P0:lTOLppwMnGU=;j8xm1OPssHUyNtBsIBw//ew0224
 zudRD/Rjbppd68nYKUmBLkZvTdD4DIeTiSFjjHCcj1lpLc1dKWGRKTwnjsvVfi70lYeq4R76S
 sa8ExvDX1+XWnxmvVVtFKLH634FV5GsByTDZBD5LrTVY1+4TIEh7joUKTBR5ZqEfvHHg02nZx
 ZVCUfWwoGpAAM1szFxgd/8gTfSCe3ow/WzqPkP536f47gjUGcoPUubFv9cBaI/uqHxGdsBtJ6
 KzV90wXaJkGP2kKbD2IdE2BX5QIAtncLsE11y0DztZGvTMrFTsukDavKA19IaFkVcnrZ7tIh7
 Q/cCB+tV8u5D4Qyzs3Er9RotKpQqYFwIhbWtkyw3m5oh3VQqBLUmxssa7TwL1UpLZaqGUrLfh
 bo1vAPdeE3/hMnW20i6u4gw5+PvYg55HWO4cu8rh7pvPtWD1P0Kce8bw5oyuSatymwMTg9tbv
 VsJLbboiwo2MyV74nSbYHC2ka9W8llCGd45r9DVbHqe0+jIJsV++z08bSASsZR7sqk+Ai+71a
 LP6E6E0+SgFgHDq9Gb1hHm29RqrtMpuR8N70I/s9Ei6bLug8XWKSPeFbtnFVCJV+XuT+iB2R0
 fg2FTk4FbYneqLwwK6ynpNyzIzwIbxPJxlL5AgXfm2sjSI349NheCf0zwuTIIa/muD6iVXC82
 5CCQEAe1ejkg1Iz6mPginHJ2c9nWZF8RrFCdGT9sjtMC318cd2o51p57eO/f34WTJm0JUZYzK
 Uxczlp7sQkht8eor6fsCZ5GDN+Ic3OJk3ph6xiSBkat+MYY4ugN/nluiiROa+WWZHSiURj4+3
 jWQR3wv8lNNaK/L2QOV6wGCLc5Y3aZQIAYRgfzA0/dIcOvSGJBZv72UQbzoN6d0E8Hy+muGom
 jErW9v1rQTu3mwDsF05MXEnRrDYXS+1gXIOitwF/jtMjytRtvVgFdxNkblrVDUIL2xZNJ8wjw
 ndEj7w==



On 13.12.23 11:26, Ilpo J=C3=A4rvinen wrote:
> On Sat, 9 Dec 2023, Lino Sanfilippo wrote:
>
>> In serial_omap_rs485() RS485 support may be deactivated due to a missin=
g
>
> There's no serial_omap_rs485() function. I assume/know you meant
> serial_omap_probe_rs485() but please correct.
>

Right, I meant serial_omap_probe_rs485(). Will fix the misnaming as well a=
s
the typos below.

>> RTS GPIO. This is done by nullifying the ports rs485_supported struct.
>> After that however the serial_omap_rs485_supported struct is assigned t=
o
>> the same structure unconditionally, which results in an unintended
>> reactivation of RS485 support.
>>
>> Fix this by callling serial_omap_rs485() after the assignment of
>
> callling -> calling.
>
> Again, the function name is incorrect.
>

>> rs485_supported.
>
> Wouldn't it be better if all rs485 init/setups would occur in the same
> place rather than being spread around? That is, move the rs485_config an=
d
> rs485_supported setup into serial_omap_probe_rs485()?
>

No problem, I can do that. Thanks for the review(s)!

Regards,
Lino

