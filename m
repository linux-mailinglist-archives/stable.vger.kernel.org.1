Return-Path: <stable+bounces-76136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32CB978F21
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85857288751
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B613B58F;
	Sat, 14 Sep 2024 08:35:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2111.outbound.protection.partner.outlook.cn [139.219.146.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD479CC;
	Sat, 14 Sep 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302928; cv=fail; b=Vo6rnMqqzcRr9Xsws8x1Z8oZpsTluhJCOzXRNgEQM34gRJ8hMmo1aHsckb6BDn9GbZfUCNsAhhBVaHg7zGMCd4SEg20n316w9b+6X7bwT4s52qVdd8U5I5YViL0hS3iY6JpaC86s+MTJWeiOD67t4dQkt2mt9quAAbIUMb+jUCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302928; c=relaxed/simple;
	bh=vtXF+h45/+DK/Rt61wH1702VJHdVMFsSEkyqRhJ89Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6KtQp2LbaliV/uOPSQFFFVOtQRcoBEWMqlx9emjhmzW83om5mwZM5vJiPJZNCpvfa1oSnY0WH7o1TiXHBWPdi3V85yyz5aWnAWFSTwyAmwzrIREhmr6kPtaHkSdQ2KrVsIALbT4GmARvBusDagfpUcCROVrrC5sUEinAhWH3qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMnxeTKFhgt142cEWROUCCthjxIfEExjE7G+9F1pmAVSCORjlqeWP+PpvpJyipgalyiD0G2U/GUDeZWfYkY6Y7WXKn1U0am3tKqMpXP3wB+2g3QIUTapOcIDJoC/WqU0MW0LXxwlDJ9pim0a3uCzUaBVybAv+h/zfoXTc11Nyzxwccj6DsvYJwBCxYNYf1FUlIynDeKpRrsr6S3wqkkmTEFGa3n3jqRztLx7EXEpFGGqL4Iu1tCF+C6Wy1/9g1lD3UCTr+KuGP/79lGRvO8vBRpA5yUkONlg3iMy9aj600XIQ3A9Qtk+pVIxv5SsQA1gsIWwqG/E9rPQtE+tW5dilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suChLtNUqYSYEnlz8B/qcPmLxuFdzKldGYBN2YW4DNE=;
 b=bJxkaJGSUA+2VDjaolJlePQIqjbNu4gcx2jhVC0BBirUpbx1U3D7Wqc979EbHrK+DTuJJ43qw3EYUpITEoeoepeJ9ZZi19ST3JUYpParkA8lLhisYOUkphA+PW7cX+2jktGEPC/1COYZzYEGer1a7tR2VrYhXnvJkDbRrPQ/qp4ihvRWkohS8qPITa70NsTfzX75X1uyRegegCy8cxnMZjZAaYRWXUub3SgP1rrFvhXXaDjcrtoDPHwtnV2SxeWbek1RTZaWjBFzCV3yO235sMHiciWlmQM7kyrDzMJ+2FoU8ViWcUkhAJ+neoflIZzOJ8+kLfQ+ujf02VMh9Ro81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1052.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Sat, 14 Sep
 2024 08:01:44 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7962.021; Sat, 14 Sep 2024 08:01:44 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, Sasha
 Levin <sashal@kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>
Subject: RE: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Thread-Topic: Patch "riscv: dts: starfive: jh7110-common: Fix lower rate of
 CPUfreq by setting PLL0 rate to 1.5GHz" has been added to the 6.10-stable
 tree
Thread-Index: AQHbBebciFlAlMvb90WBGNGztNgBK7JW3Ekg
Date: Sat, 14 Sep 2024 08:01:44 +0000
Message-ID:
 <NTZPR01MB0956F268E07BAE72F3A133DE9F662@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240913141134.2831322-1-sashal@kernel.org>
In-Reply-To: <20240913141134.2831322-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1052:EE_
x-ms-office365-filtering-correlation-id: ba611a55-002e-4ea1-47a5-08dcd493796b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 gVAvSxVnNB9aP0YJNNnLs8cir4YHCGZhap8zbMQoDFF6M5UCVZv1D+50VFqYCPcvnYdBRUuGocUQfIdrVteq0YSReqy31WAkpvA9/EpKsGBphfFXKNQ2rBWT3kQZEpZt+tx0Lx0h4T1YnLq1LLMe9GtCA3j35lJJxSca1nS11IpL/tokHosUf0o3FAfBfmkpB8UXRjnDlyFUlZ+1YltKt8Oclx4XqN3z7JcHJaTn51Ksn44mrtF6hP/9Spb2R/OuPAVAQ4BtaOEWRHsQw40uh7iFN9U2fzyEyT/EuDp/Yc7cBXyur5w5ecl84OshETlpZW8Ex2N4V+JTi2SdxrNhMd2ZOk+Gk9rx21lnLnrSGn43rdGiPxE76gZg+i8DUVFeaTofkEEEM/57LoFcQW22QYMHzp5GjuV5tCYRmngdHJFljDgXDmSOaq3bkR8yJyajbNO34ahOA0M8yr3i2NjMO8E0Lmn0EV6MBWlXDnQlCrs+WMDyXl/4WZARtqq9nj8xuaS228J2OVpJCrM6fpT15NNf39gJc/OKtdmMepYJA+FnYn5/6bto4C1ejyUm5eb9I4u/eUmkvieftlInyggfu/x5WN5gGnafV8pS9ynqpTnWX7FoIV6XfFMWLXzC9VNq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3myxFwNRnSt8jRrFpg/M5E7mmyvzGV4KnA1B0Na0FjOZTFyX2IrJn1xOZqYk?=
 =?us-ascii?Q?q4sTp8o5n++6X6Dk8VjInEQhTODF5FTiEfFXATFMrJqvln6GNUc/zK5fwXCE?=
 =?us-ascii?Q?qQGC0YSxuIxhpJFfDKak2NWBEScEay/YwE/uVLwTujBk0IraSAPnMrN9hZgR?=
 =?us-ascii?Q?pC481BDpFt/N/aUntSB0B3ErpdoFOjSYOzGWC1rVGsdil/p1dGIn82uROqnQ?=
 =?us-ascii?Q?WDuMH0WTK6SP2P0MscOMR7Fl6ZeiQvkhr6TfdKNUaETyHJQ/ndg50ZCdYREJ?=
 =?us-ascii?Q?VeLFqAbthb6zUsVLdjyw1HvpmCV/3kL+Ji9T/3lB9+RBtZ+hoHtA8fveTKlc?=
 =?us-ascii?Q?w9aSrda33d7wcQNFqMTLjCC4jiiBMFTERzZ9fjvqPPZmPf4z6fkx2ov/D1DQ?=
 =?us-ascii?Q?hqhjbJf2PgXSMRAhbh7Fu2BgMviZTslxUa/lkIoFCfglgDbfnJxO/Jk7V+ue?=
 =?us-ascii?Q?K0rlx/OaPinp3pOkXdqZmwe+8VcSViLW2c4BqNgoIz4kPw1+icOAW8eZEcww?=
 =?us-ascii?Q?q5tIJx0fkC1GHo652gkE+FhuDMDOZmLlbSLTr2Q6QakGrw06CzN5o+BDzRmB?=
 =?us-ascii?Q?NtrEgnaN6jlwUG7PSFA32y4/OPfOS/aE/UvTOXfztzLb1N+C0z3HtKF37400?=
 =?us-ascii?Q?UheP3iX+EcbZkKbCqK8KeCQLO+2aK1riAwbiL2U3U/ebL62OanmfuwlcUUKK?=
 =?us-ascii?Q?Hsl2nY34hfUl/Tws67TfYcNBHqB9pZBh/swfR3Wr2bmAmckIOwGnAIffvT3E?=
 =?us-ascii?Q?kw3BP42XCnMaRUhc95NqmlqPpjbdEMlV99eNV6/Ob4QmH6ajFkmMSYZPRF5g?=
 =?us-ascii?Q?c62wAtl/yFpG4iVY4TuL5s3AlMyfmPRwBKPWkroAOlUyRLhBbRFwLvM2EhfX?=
 =?us-ascii?Q?MFoawylQcI38y2vZ6djJf4AUSZMQ+aqrE8GmD07DHjOV6TIJMbkwWuG2XWtA?=
 =?us-ascii?Q?HP0Y0FIX9crzi2kZzKOWJW1edgx+Pe5nDvWExyKjIRTI4fbJuZFh2YDdkG7H?=
 =?us-ascii?Q?hMBdF5IbUHl18aN9OgPbWzqPNPvAW/vBE/vCJtcfoMSnb4u5CRb2UP4TEQwR?=
 =?us-ascii?Q?0GWKoqeC5n5Il8b9uasWWS0cvAQzdVdaJPPeo2FBm5eBLNFt2NZyzkEB40nt?=
 =?us-ascii?Q?gvgoTbpQSO5bJ3nSGTKnyy8pRXzDvU+u2CBfKbW0vMvl8Mn7cUJN2TFODw92?=
 =?us-ascii?Q?3wwl7/PCOiSIQjkiqM+kpMZui8t2FelAV92BZRbMKLEbOa3SdaoFqOvWrOsZ?=
 =?us-ascii?Q?BeCFzJlfgSB1dTjGbc7zf5aU27d8ehAcr5OGSVp8vkxNqLFP9Z/RImzMWyLa?=
 =?us-ascii?Q?gBqSwERqUlYpJdh+ovQq5GsRGf1T23SZ5MjDCQ/WGFg4bbZqhrTJPNbSPrCv?=
 =?us-ascii?Q?xFgcGfWg4jLcicD/hokH8JHjWSQ8RY21ZrDLmDpBQD2Q/frIGM14Po8IrB8v?=
 =?us-ascii?Q?lqNhcKSx567Y7C6nMMDiURuCn6xie6XvaNM2ErSu/bsbWv9AQt3DFIKWUu7f?=
 =?us-ascii?Q?Tm0D8oHSbYHmwnL/8WHtAydrZQ5oBr4wDCnhdjSSgpmSrJSZYzCm25eLcRN4?=
 =?us-ascii?Q?YhbKsjRtIuTglyV8FR5ItXj3XWuCdPoOnku6pyNl?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ba611a55-002e-4ea1-47a5-08dcd493796b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 08:01:44.2002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwApNQUPkb8mWPGsyDlCNXIT+ofpf9SdADl3THejS+fiiD4GvGJoQojR5tt6OFLewby4qVUCoNkrzgVycJiwnEnLgKIJ8fjzuZOwXxfxBns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1052

On 13/09/2024 22:12, Sasha Levin wrote:
>=20
> This is a note to let you know that I've just added the patch titled
>=20
>     riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by set=
ting PLL0
> rate to 1.5GHz
>=20
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>=20
> The filename of the patch is:
>      riscv-dts-starfive-jh7110-common-fix-lower-rate-of-c.patch
> and it can be found in the queue-6.10 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.
>=20

Hi Sasha,

This patch only has the part of DTS without the clock driver patch[1].
[1]: https://lore.kernel.org/all/20240826080430.179788-2-xingyu.wu@starfive=
tech.com/

I don't know your plan about this driver patch, or maybe I missed it.=20
But the DTS changes really needs the driver patch to work and you should ad=
d the driver patch.

Thanks,
Xingyu Wu

>=20
>=20
> commit 67b60bf9777bd340c7179adb5376dcdd3f0c260c
> Author: Xingyu Wu <xingyu.wu@starfivetech.com>
> Date:   Mon Aug 26 16:04:30 2024 +0800
>=20
>     riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by set=
ting PLL0
> rate to 1.5GHz
>=20
>     [ Upstream commit 61f2e8a3a94175dbbaad6a54f381b2a505324610 ]
>=20
>     CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
>     But now PLL0 rate is 1GHz and the cpu frequency loads become
>     250/333/500/1000MHz in fact.
>=20
>     The PLL0 rate should be default set to 1.5GHz and set the
>     cpu_core rate to 500MHz in safe.
>=20
>     Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH711=
0 SoC")
>     Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>     Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>     Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 68d16717db8c..51d85f447626 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -354,6 +354,12 @@ spi_dev0: spi@0 {
>  	};
>  };
>=20
> +&syscrg {
> +	assigned-clocks =3D <&syscrg JH7110_SYSCLK_CPU_CORE>,
> +			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
> +	assigned-clock-rates =3D <500000000>, <1500000000>; };
> +
>  &sysgpio {
>  	i2c0_pins: i2c0-0 {
>  		i2c-pins {

