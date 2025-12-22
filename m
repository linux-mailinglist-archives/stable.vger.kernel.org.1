Return-Path: <stable+bounces-203189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD4CD4B82
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 06:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D379D3007FE7
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 05:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAE3009C3;
	Mon, 22 Dec 2025 05:29:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B882522A7;
	Mon, 22 Dec 2025 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766381340; cv=fail; b=HyUrUWVB1d0mK7Ewwd4WHKtx4B/gnSTrYUj+kRfuv1evtdx5M8kuEG/QvWazPNrCbRoDKwhms3WVjkpLTSUR+HPcWLiHeobumZGPoTxcecGOLIFHjno3Ywi3EyfiI6BJXq4iDp8noqDhu6I0Wwr+7BxbzpH8mtv9pgWP/NPBLgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766381340; c=relaxed/simple;
	bh=cmHvKLrFAPPrzG9q1NC96qBpkkmsTzXD9yn5im2A/DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GLj/okMC3V39x5VOsCTPWPY89Sbi91eNwbjbHrbJ73oYBfsDiY27mBG4q/NZ3OZNoZrzOcXMHQ8bh8pD6v9DG0IxK/iUeXjLPBySpSAIYIEdvNOzEC/Kue4uqMxTNqniaJS7T8l/CgutZCS25SjmlR1hdLG3GzN7UzLj6k9U0B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTko4SvSNnCAGozZpGhkppM3E4D18bT3oq1PzGRCHXN0m/b/YRaGl6mfCLB3+l0QSom83OGYfOUH1F17Co7Td2kttt+lmBqATPqn5MRppeHQKD1l5J35Kv8DtqNjvZ5y+aTFGfoT6foEuuc8JSkLTGknF5d9E/w9Jp/DcOzqSlEW3ajgfr2hvEWdbjZhvm4pIVfbrC5vF8CK1TFRzceYi1/BEIMDliiREeXGKhlWKhsgGe8cXhF6hR4IVYhtgAmqkTeHkLl3iuVhaJAd9+8jjoDaeasgX4rLRjGo/FRQZJpBPahFADKFMkWhOCT0hbwnCJHFrNv3pLMT6v9PXlPAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A+B2dBHLxx5S37M/r6hJhOLlYAeSAKNxLFleRdnUbo=;
 b=YvHD6LPUDArMg2wNoUBubR8woIvYmjuQBxyvF/1q4JNyHa2eeZxVYpeXjM8ghLx+0YswztmkMHE51kWHGX+QlYkpQQFgy1YF/Vn/6boE8hC8GRpq8Xi2rST7YpW6+9W0iJeBFG9Q6PRYMSkM3ncC7F/9rWYGcT+jTmo6QAUkN9C9mVmqdC1ooFyyEQK+RznA5yvncdMjF8z5+L6HH1AJcFFRJiUUGFUwVOqykOi/cxydqEtHIHxFk2krAWQfnZtDgsQLNBGlaEsXTpKScg58lgcCD2GkHH9v2lB7FYu84QDeYCeXuCwr4awGgyst4xxDAHmdRBV0WJT48PEb+3bIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1259.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.17; Mon, 22 Dec
 2025 01:56:07 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Mon, 22 Dec 2025
 01:56:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
Subject: RE: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist" has
 been added to the 6.12-stable tree
Thread-Topic: Patch "cpufreq: dt-platdev: Add JH7110S SOC to the allowlist"
 has been added to the 6.12-stable tree
Thread-Index: AQHccOORi0END/dw0kqivmvmxbAe+bUs6hHw
Date: Mon, 22 Dec 2025 01:56:06 +0000
Message-ID:
 <ZQ2PR01MB13078B8FE3D7EA7D50A8A59FE6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251219123234.980671-1-sashal@kernel.org>
In-Reply-To: <20251219123234.980671-1-sashal@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1259:EE_
x-ms-office365-filtering-correlation-id: f5c82831-dad8-45ac-2ffe-08de40fd4577
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 wPzxZpgXJoatWpH28Ja1Z3A2kyrJNfsqarakq7Sz4PsqwIIkHdn+fmZN07rDg+tPjEGVHOPwmCQiCcTGLn9YI+6g/Do7h/42x0fF8OsJXgAn1Y6oWYxWla4Ws/tDUcRoPMaInMEoLXxyOQbruIwwkQ57z2nB1/RVIiwoncKJi2zGRaXnuQGMD/eHoXRd+FjVJNj8+vcWi+NKA07AkmSZzgu1b3CNCMbdD3paHsYn2GgD04q9z4sFjcs+ii5c085++tUQlOs/i64ea3Hto94dIoqc6oJTPqaGqh6f0XnoeFOJ52ki/EnaDeINTcC4l1LXBU/gRSFXUdK+IXHLOoi9+OarsddHsGNFsqE+wMXyspdL7FIM5m0vqrXCVaeJbowlgFKICs9VsTAlO9LDRlGsDdJKAG4NMnPB8VJoevbKRiVPlIL/wMNqG2WvOFwjuSEMgs5FMPShIK45/RFKjRNLpPk8ns9zKK1YBuwDX2kkRuhcFNiJPOF5SDOiDWg5by7tvjdhn3K9T65EUcuS+0QHbFB9jjkR41T1ybjyrLgJIR4Tub/Tw+Y+OoWsOx2tR28yLJkMjTgUGbzZ4pxYnGQ5tA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DZi3FA7j12mY3YukuIxrbBmgUtxAzBI0QenOPJHfmYFnDtIQBBcOt9WHIk0M?=
 =?us-ascii?Q?vesBm6CcoqYnlnlK8rT9ZkDqpEOO90gWwwXWddXg3d8v2ZpCcF+Tc6Vm2MoN?=
 =?us-ascii?Q?y0p09e5aiHLF5wcvAd1lhMOdWn8mNksSJ70f+YdW0hC+5qryQQEN5MWbjghk?=
 =?us-ascii?Q?x1j/vwrwS2Jx0GmA0vvnxqPrLcrXxD9jIzn8cwvSailRVRLC7wBzpNU64l9p?=
 =?us-ascii?Q?wDvmYRbGX+FK8PcEKz3LXxvEa8HgTWNG51mziFbVGO47Atx+2hru1r66+30c?=
 =?us-ascii?Q?W1RG9tFWCwyjDT13OAw/2dLGDJDuLmGZk1p3UfKsG746x7D7HAcv6xhQVuyX?=
 =?us-ascii?Q?VLlOLRgEkg6dp2UE9wT1xLrmHbJn8FaWn4GUgP3gj6LC4DkjzB7rp5V7nCPZ?=
 =?us-ascii?Q?ZG+hxULHZFBGn84OK2JQQyGvV+D4oeyUd1ouUf4Uy4h0HiaF2mRopegJdYy6?=
 =?us-ascii?Q?mJ3cF/n92/XSeUDlWrRSJjVc/47wLE73ALLSNjyBvl4PkL89DZLlNi/WaNHz?=
 =?us-ascii?Q?9OlInh4LeG0eg9s0sL3uhiJghqlBmQwtP7bK+j/53b9AWDH0tiHPAFObNHYG?=
 =?us-ascii?Q?vG2yvxFNqvMGBAUCxJyBze02Lhc5AkFaqBR1HyfJmHCEriTNzNMtw1HdXl0q?=
 =?us-ascii?Q?nCTXFuza2GEmRWdeKdvpH7OYJszYdJV0ZGuTXYxtqWhDCFFSZ68aliUC18ZZ?=
 =?us-ascii?Q?OhMk3uMUuBU85MyNjPmBXvdZGR+xLK1BTramaR1id1vpz1wjSSZ7n9egJp8v?=
 =?us-ascii?Q?cIhCIQRhOmqDHdApdWQaAsn2RHLv5j59+iHSEGhrGnxRmrWCL3NcTkgVB3a6?=
 =?us-ascii?Q?yR0/VuPaSRLOC2nLjA1TBMVUcfUlj0QjepERxsCaHm34qnXtNpjcphFBwiX/?=
 =?us-ascii?Q?LZoPOEjnnP411J4YnZlzeDZVBxzlukdo9M+v10Hb6KavbLViGbriTNgrOgYj?=
 =?us-ascii?Q?He3sBKkWB79SSfc8UsKR3raOEaoW+Jeeo0sHY7aiyaFQBfEaLQGTqSN3AZEy?=
 =?us-ascii?Q?/UAZQVFVD8IwliEvLZqiPLBwcuFxRmjLvE6+H0+frlrYOurbEU9UauVn+EUb?=
 =?us-ascii?Q?Q60vYFBax4yKqEFfaKDyS+gEZKtbxxlM5W2fV077rn9VHg6y16c0JIWGYKyo?=
 =?us-ascii?Q?YI8B6HIsObnmqNypNAmg4h6aMMF8ZTpl6DFtMgBYkgsadekiHQfd3K3pZFhr?=
 =?us-ascii?Q?KqBhQQiRnGcziiqwabngyIL5EPa7ltGS8i6Lax/26GIZ0ZrHn1MyBKNkJMp9?=
 =?us-ascii?Q?nfJCpEoL40bG4dHKkNVWIe+YE2yVKkMfs8J9/c6MyMUse6dVY3GbQDA9hs5v?=
 =?us-ascii?Q?Zu97rBgq7uFgW436Hj7VcFS498jdHMCdaNhlTUAK1zvQ+qTAUmBWV8qpEPhN?=
 =?us-ascii?Q?0nvy2qBZVcj+0sTRc3DbQrzdXO867MNSaCcBo4xfHLtGyJvjlybD1Gp6SOkP?=
 =?us-ascii?Q?/uShU+3AooVG0VNfhe/mcGQ5cbkTyOJh7MPCsTC5UdShe1iJMmwr2iOnF5C0?=
 =?us-ascii?Q?S4qfV78haTSW4D/bnfzcUhX6dZwdKNENfLQbXA7uECC+CYdbskGvGxYIHh3j?=
 =?us-ascii?Q?jciqYfodYQspPswtWzNKsIP0xZIn6wrDwu/h52tX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c82831-dad8-45ac-2ffe-08de40fd4577
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 01:56:06.8961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkK5DgTXJjw6dYLzN0DUgDPG14Feb83BLRBzKfSmDU4luFlIPo5Rufl53K3CRcyZziibwi/1rMh9RCNCSLlkPZjbdGxr598ZFrKCfEVExTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1259

> On 19.12.25 20:33, Sasha Levin wrote:
>=20
> This is a note to let you know that I've just added the patch titled
>=20
>     cpufreq: dt-platdev: Add JH7110S SOC to the allowlist
>=20
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>=20
> The filename of the patch is:
>      cpufreq-dt-platdev-add-jh7110s-soc-to-the-allowlist.patch
> and it can be found in the queue-6.12 subdirectory.
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
> commit fb0dfa5be2ce8716ed8a7a6c8ffb8d36f5e03541
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
> index 67bac12d4d55b..dbd73cd0cf535 100644
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

