Return-Path: <stable+bounces-203188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F3CD4B13
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 05:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA86730038ED
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 04:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BF1624C6;
	Mon, 22 Dec 2025 04:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B77E105;
	Mon, 22 Dec 2025 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766377892; cv=fail; b=c7vtaGBNm9vETqwtvAhburhlYRLmGRaduywbTv1PHySN0edjFgZ/J/Lz7hkT9I65Yer6pTllq+PAzd54hPcwyGtSik5T4YEm4msLll2fLDCPHiKO5rmx67Ln1TL4saykaOkIGLtnX8n/oM0Sl+0Ikx3js03+ReiKYj+WC4ZH59Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766377892; c=relaxed/simple;
	bh=Ti9Fz3zdKyJXnTlooIRghWWypQdD96QW5/yiCcSirMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHxILjOoAItRrLj9u63pS3sS4/Z2Yq7ateReE3ELzlC7/KqVutj0KFL05jLrLyIv7OPSLGtpTKa/k8ORkAgReCdJ1S7QaytD7oF88l+2Ae+KCR6s1VeVkGuGvq6gSAK1wOjUEtX4teXi2wovt10hRUcDXzJUnyPRPfqh+gUudcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bchSr1OSXmwMQkp6gj8+lN4W6u71WUdzWpHqfNRJ9HVB7B5x1LRw4udJQhW6qTe3kSHVz3VMoYQ/+qzgnA9vwf8UZx3GeIWooRLYo0f/oqsEE4+XFzDfvCETPZOo/brDcZR4gBwd4Hb/itufJq/DkeKGmSG7TP4rAk/Jsckq2JAtgRwmvgRggodwczcnPrM2ae9lBLIsL4hqncdeC2e287dOqH+bPF7ro/MXjgSQFVcHiz66s00Lg7/K9CEDoN6ndzDQWnhlBnG33dBHn9W3vD8276qDNf4UQm3Pk5pDmB4Q9hhx9XA4Wqk1DcBum+GlaWkqznr+9eepn1hAHLHQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Iu1C+oSMu0mJ1kFI/hjUY4BvKR8deunEd0w1vgCsE=;
 b=D95UowAY0vVPtuom+ZoACCbuW92wBTW8BeLKsqdB89cJWwGFB8LrLLcy59nQQYAfBDX6oQxu39ChNf771z2UBmw0UYYjZ344qwPPC3+Fr5Q3Xv6P+TCrcL0TCAoRa4m9F+LYQm6R2N8uNza3G/o88LrEHV5gA5iRZMIyK8sZaYiaKNOv7Y2W1UARqhx1CCXJh28yWUKZdjkr+iKCWwmi2HaUfzIlsWX40Ml+FJVYN+L+/kyZywyDfMZPFoDb35IMTcUSLYuUxE+KlJMufe8o579wYwZ0rKbPDP08sucvh6BY/h0LFO2NtronBhCezZiWwysrPcZvsQSuOZY9xNcoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 22 Dec
 2025 01:57:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 01:57:04 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
Subject: RE: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist" has
 been added to the 6.6-stable tree
Thread-Topic: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.6-stable tree
Thread-Index: AQHccOPOtv7AE4tV+UuJMv611UaC6rUs6oKA
Date: Mon, 22 Dec 2025 01:57:03 +0000
Message-ID:
 <ZQ2PR01MB13072BC9637DDFB75C566527E6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251219123414.982975-1-sashal@kernel.org>
In-Reply-To: <20251219123414.982975-1-sashal@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
x-ms-office365-filtering-correlation-id: 25ed5882-9b9c-464f-f878-08de40fd6775
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 LLsi9QI5F7FuPu2sXUtWH0ljeGpSjoACg4aa1A3aeZWlD6MSK7j4CaRZ9qk3kuL/iIuJzfafqhqw6bVSwgAeehc26DhL2KDOL9N4sxb/t9C89/r+87Otlhie1djPjufoEBypZkFtla5KA+3iuYkWcfGMItsElzeZkZdPHddEDM9/R6WF5o7zdWqlrkbZK5CN20S5/e5qbpWJQUoQsR5PW/c6S2xAZ3Pb1NTOaozuVivNzA/3ThopSfNsxQGiic3CrQ5nA6j8G24M6DIIcSXoO2zN2S4VjUYcZ6I67Y6CM4J1LchzimSqOsDYKIhibelf1mtuFMSczljTkHKCFrAhF+kPnQgZNwZZ5ikikEp3UlZWDbDE0V5aupRsyz9z5It2VBwDJfK9noYP4On4imOPhYJl1r9cJHC0YwDFG4y0ymp1qIrwetaT7/OdmK4k82Z1DB9QqGIWOWgVXoGhpyknwXYyuKtnOq2rKlXyviYuwtdD4NU+niqXTtx9K7+gqmMhK5HwJC6JlmvKPgZ3HSNK14IVljV4Pcdoz57tuzf2OIdjLRL+HlKB+hR3Oc6cekx/atLrLkYbr9ErObrVvKh4GA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z/BqFYAK4REFeUorO2lPrhspS/KixeOwo+WCAGF/LUSz4TYIlL1v9Xlp1Jy/?=
 =?us-ascii?Q?pVVQrEGkXamkH+StRx0ec75E9DOZun2z8TL8zZr/fLHJY6e/6e7pWyxeaVE+?=
 =?us-ascii?Q?p+QDVgnc+XSObXj3zFKPUCgoQZbmxgzlnfP/wlfJ2I7ZyWqLnUr6LgHGNB1t?=
 =?us-ascii?Q?40Cwc8lk6kXSRJjl2RB3Bf2G8k0RLhfE8ACdNfhCT4NcICrPR7cqaObt8n6g?=
 =?us-ascii?Q?+l8LHz+GYMT1kIXZ4nuYa/SR2LYGvcNAMMK3OEeqW5L8lbP6RMR9uW4jvsNH?=
 =?us-ascii?Q?2o7mSlqwTsR0aMu1RHX6Sdx8Pb+ZW1iGAq3llOEcE4Uc3ED+p5psOPGEdes3?=
 =?us-ascii?Q?9GOkxKLRTcTCu8okT/m06MOB5BXmJTpkdQsMGkWqdqtNb/E3/yR6B4R8vYen?=
 =?us-ascii?Q?Y7dOLSH/L6LFD8gZMtfzPxr5tJmXBnXgSvavtfhfhxIi3TaA3FTkPJj41LDm?=
 =?us-ascii?Q?3VkWh4ERrL09Z3ixP/WYFotB/Ckr/r+2gd7XufWOj4OTRbSWAVc0Q1m6Jmx2?=
 =?us-ascii?Q?cjCo/jAhFcmhtRUG8LMF48MBZ4dlK7ak22ayf+tfKUnt5nC/cegscVjloCPF?=
 =?us-ascii?Q?slhIS4oP+i4p1Od995FuXl73P+uESiuaE1hypkHh2zEnLODWOa/z87g7F9q/?=
 =?us-ascii?Q?g7QJnbDG/2XfGpeEIw5ma8v7N0oWaMl59UkcDTvKP0Jx48MwJqDW22Fnlvss?=
 =?us-ascii?Q?l8nT5H46HOVv/ztl4uM97KM3JVvO0eQolC1Sva09B4RFf5ggs4TEv6OJGDAw?=
 =?us-ascii?Q?TXP5zfNfBjS3CJ7A3vJ662adn9hwclNgxkkhK7gM0KGBZga1RG2bfuuu9liI?=
 =?us-ascii?Q?RKvyPbxfES0owZ4wOIiSyL/LlatNK4Wo+4LGT2FI29EmjwwDZOet3Xm624g0?=
 =?us-ascii?Q?AW4mEUo4EdMgxSDpd9/T1F7Gvb60c6NQ1Ueu5YRs4JzQkeMW73OkdLiG924N?=
 =?us-ascii?Q?6z8pjmtIFq36hm83ASpEHTrsiXynTZ38Tv8fhClpWAWZ7ClF9kq25fiBtprH?=
 =?us-ascii?Q?VA/wVWq/8EHWuAOtlXfOsNb+RFNBr+rUlhwalqAiWJ3n+RwLD5MOsUcQ8ClC?=
 =?us-ascii?Q?+dbx8ZaUGPgC+8Q22gD69XO6s+CUGgO6TgqVEefg8JP+OUdBfIutqscyP9ID?=
 =?us-ascii?Q?M+YJEGvH0axdKp8g9BnD+iCOCQgH8I6K9HHFs10XFzBE8+hdC7qNnSaCGLHT?=
 =?us-ascii?Q?J21+55D7vz7EOJfkbdYOCs954p8J9OpKWkt10YwqoAauam9mmrcltfJUUudt?=
 =?us-ascii?Q?/BmRAOQNIvJpuLwqScFTOsNF+khRtJz14XaLRfqMHTd7rQ8+7hyPvV89ycd+?=
 =?us-ascii?Q?q4tIB14OMygbrzwTI9/r4fLnOz6dRCbTHKQZEnFCNYzL7foaHf9lHMMdcPD3?=
 =?us-ascii?Q?CMmclnf62dos/2eSLadrDQiI9Tss1BIFkt0AUGE7uRDNgca6NqIJl1XPtbXT?=
 =?us-ascii?Q?4TOaepXtYs4nO4252Gh3XFEbOtDlcGdo5SlzWfFM3/pXY5TUyN+fL79coQU5?=
 =?us-ascii?Q?HfhGPkxsZLM1/hbDstqUlfJqSUlzFRTWocdn/k8a3br/HAiTl7YX8hfNO1zQ?=
 =?us-ascii?Q?Uvmk2i3pZ6A/w6EugSA35mNydxC1ftxbwhLs3syV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ed5882-9b9c-464f-f878-08de40fd6775
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 01:57:03.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mPB9gp3gO3R83WmlTHdk4YYRkFd7+LPrpGD8i2hI+bxIcw8tyqp1nZkhb4lPewuLrMkI/o6DHUr6XA9YM3MyBrzcL9qq9Rx9OEj9lTyDHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323

> On 19.12.25 20:34, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>=20
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>=20
> The filename of the patch is:
>      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> and it can be found in the queue-6.6 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.

As series [1] is accepted, this patch will be not needed and will be revert=
ed in the mainline.

[1] https://lore.kernel.org/all/20251212211934.135602-1-e@freeshell.de/

So we should not add it to the stable tree. Thanks.

Best regards,
Hal

>=20
>=20
>=20
> commit 62295dd3b326acf42f033124c4a48278b71b53a4
> Author: Hal Feng <hal.feng@starfivetech.com>
> Date:   Thu Oct 16 16:00:48 2025 +0800
>=20
>     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>=20
>     [ Upstream commit 6e7970cab51d01b8f7c56f120486c571c22e1b80 ]
>=20
>     Add the compatible strings for supporting the generic
>     cpufreq driver on the StarFive JH7110S SoC.
>=20
>     Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>     Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufr=
eq-
> dt-platdev.c
> index c58c1defd7458..8b53388280d73 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initcons=
t =3D {
>  	{ .compatible =3D "st-ericsson,u9540", },
>=20
>  	{ .compatible =3D "starfive,jh7110", },
> +	{ .compatible =3D "starfive,jh7110s", },
>=20
>  	{ .compatible =3D "ti,omap2", },
>  	{ .compatible =3D "ti,omap4", },

