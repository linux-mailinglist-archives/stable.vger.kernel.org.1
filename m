Return-Path: <stable+bounces-76003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C51976B3F
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 15:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EE61F20D46
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE81B14E9;
	Thu, 12 Sep 2024 13:53:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040D1B12D5;
	Thu, 12 Sep 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149226; cv=fail; b=ZpTzSvrOEn/ge7Lyqb6gUzWfBldo+rTRCVU/GJPkDImQr4x45Dtgx/EncSFuzPo0Bsn1fKtu/0QhSxan6EO6wzPwwe+krrg/HxKy3PTdu7kwpHGX9kjhpYXTO/aFptVjmbLS1YnkqJhRUcprLlbw064buhxm/gkHPfYzn/gmucc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149226; c=relaxed/simple;
	bh=2esxoqkxwySXtba29ZNNsXff6Dh0S0R1kgPpc2bCdXw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3S8QfFG5PTIF86iX8CNpNITogDfJHz2z/UNg6wcfJV7GvRTxF085nH56xVn6w6QmlK/xhnfBqHg9AtM/YzZTh+T9vtPQoyLbgg0guYmWvOFPvxHfA2lJLwYKkdTK8JwCHmMglgYkrYKej0qyRAhjHQeGoYKDFQotT6GFUPFz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBgQp9zCYC2SdHPw/CYqcmFsosE9vKOyt77uj/4V2IAHeP8exuVXxYss9RUQlyMTNEYLZsN5QyW1PfPJxcpZID6La7P1QGRZUMsJO3XWpyc8ABj7ojjMvGAG4+kIk5DB0FGIhVycIHSw2eZ6nENUaneTKCj66X5uezQhjOA0+D4ao8Y27Y4UQ/xI8BdUrg4pfJSqC3TS60zCsm6lZ/e1RwunWzj2qNvE2KpWrcBrILxWWR1TjNhFPSQOhflzOJX9mJK1R0GO5RAuFMfYRPcf47XiAkavLkEj/auaoqThwUVTqlV9J1gGFg1VBXx3qYe2I9LbkSBH1BNpwNCmZPpclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihoqzJx7Bxz82mx3cCsxPqV7cPgGaRLe97T5fskXL5I=;
 b=Bvo06Te3wzKuCc+DosNTkTec66RpCo3YhnpiAeks3AP3MMSUSZqD1mpTxaINXlee7eCF67QxzHvP7kfnEtVoO2TrtLh7/OSVxOcUVfKZB9F/Rg6TE/rD20Y3eZ7dHEk4ED0hTmfv4xQnD1x5harTLhMa+R5zjuc5xGd8pkv2KHS3MFKp0OcWBpVWafxwSyQyJutF+o5KZ9s9ICYeA8LBOgpDHJL2/qGEkCNP/G1GX0N4+dbiwB31QB8znL13kVCMFH1FbNkpFi1Jrx4KfsMJ+oFFoolAWDX8xf/Tu0KxRuT15oy8USTVLOI4yXwCS2Ory8qINZgewygjylpRjzkIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1162.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.34; Thu, 12 Sep
 2024 10:23:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.7897.033; Thu, 12 Sep 2024
 10:23:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: WangYuli <wangyuli@uniontech.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "sashal@kernel.org" <sashal@kernel.org>,
	William Qiu <william.qiu@starfivetech.com>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, Walker Chen <walker.chen@starfivetech.com>,
	"robh@kernel.org" <robh@kernel.org>
CC: "kernel@esmil.dk" <kernel@esmil.dk>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH 6.6 v2 3/4] riscv: dts: starfive: Add the nodes and pins
 of I2Srx/I2Stx0/I2Stx1
Thread-Topic: [PATCH 6.6 v2 3/4] riscv: dts: starfive: Add the nodes and pins
 of I2Srx/I2Stx0/I2Stx1
Thread-Index: AQHbBL9uRaYLhj5O1EmC5D9t6hh/M7JT7fHA
Date: Thu, 12 Sep 2024 10:23:09 +0000
Message-ID:
 <ZQ2PR01MB13070BA638E892A5516DEA8CE6642@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
 <D2DCF9E2F70EDC93+20240912025539.1928223-3-wangyuli@uniontech.com>
In-Reply-To:
 <D2DCF9E2F70EDC93+20240912025539.1928223-3-wangyuli@uniontech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1162:EE_
x-ms-office365-filtering-correlation-id: 1d81a0fd-7bdd-4363-300b-08dcd314e632
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 4x9wm48hWWTrb1/K5jcAnFmtDFht2xF+CFe1TcPDW2ADXw11AzMoQrK+fBrsxuHfd1uk5D5T4DniMsguzFtXwE/4MQ7npA90cGGnV+HV6jD1dvZ9SUohm3BkF3UGZgxL3VrZfj0xMI84CYookUo8NFUr3vc1OKy20uEE2hNcSw3N30JnKqCyPCMXnRI6kRqu03rFZlQMplt6bikVNh+vCIir5c8zrDG5X2ld9o6521h9iSmJ8NigduwoR6HMP/mhIBX8tfCyf6uWn+iYQ0F0EjXKHLoJeWzhulRmp9lf7zCVDNjZ+tv7mikP88a4/OxdwGUtWCuLWOrpjsfnZATttx1KehQQI09Z/+zz36AOLM77DrZ+yrJ2oPrNMcr3fdel3nPzvuDiZDpruDLgYGb1LRcuJcpeRWpQtOb0NhNCNzteYBGP0Rotyh4fu389Vm6gt1yffDVDOS+hbr3jAQQAjkIVPAaIs6H0d/SBZpEY0Esj5DGclvi5j0gCmi5Fa3itMoiuiHyt/KV8bEUqFOE2olY5a/Qt/w1aD5TON/XwYJhQncqa71gxHeM5mDZQI/JUFYRilJld4qMvuQYyLIjyblBO5s82CJqzBLg+UZ1lbwnNihUl4AGxOkC0ZxXbmnUEWLgBWiGlzXDnnhAXd14IFw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8yBA/e8LOdHWba4APcXfEomdItV8egtzlEccbtjm1KVOLJQQAV/bBG5r/aY1?=
 =?us-ascii?Q?3Zhf7fZRvFJYWFLO51/Fy1aGjcxVfv3CEg/AU/aoEelPHopfYPJ51ALEufpb?=
 =?us-ascii?Q?Hc2QYxBhTUvKKHdBNJmpYssPk8Pmw2CceTSx7Lyk0udVET8oarSDTmbTpbJo?=
 =?us-ascii?Q?EGA6/At4VEiy3lV/8lVgazoAE8/PU7n0XZXBJ97CZLxCZjny9LNdXD6nUJAR?=
 =?us-ascii?Q?aslNtUseFEVuIS3HsZ1p/Hq2rT9xeM3GMfrk1tOKJ1H6S+JXdCOCKo6gK5V0?=
 =?us-ascii?Q?w9aMX2bUBrmcUfGKo0KRRt7Ghci3REc3Ri3C1eIWsT9U9X/QgFMuRestsFIS?=
 =?us-ascii?Q?+VdXjN20B6E6yk4tskaVaRCZAbz8KQ6NxPyXjcMrKydCi2qBbrxOL64xjCw2?=
 =?us-ascii?Q?1c5vpe8Y99wbgU2tzVSERwQSRHZVXxzEa0Dp+KNoNRMdfvLhUczaByqK59y7?=
 =?us-ascii?Q?tIbRQRFBAzbjIPPo1/nBMqdz/PhsTldjiBzMHgA/Xl7L1WiJhBAYzz1CVV7x?=
 =?us-ascii?Q?TpanRSCHCPhqtKCX2kgNePR1kw1YjChUHFF+nt3bgU6p6nRNrgOhuG86HlC2?=
 =?us-ascii?Q?jOxsoPWX9CIzukqzYqWJpPn4QCV8vdkwNOhK09JfLjcKQhkhOuUKJKgayy0z?=
 =?us-ascii?Q?5dViAEiDzq3yTr0ZGzty9geFeYEy+2scogFuEF/RHqE43apubBQ2KwwToV6G?=
 =?us-ascii?Q?HawGel/J1exH+5qhpv7CrPci+CyMHSn0jXW60lQGaoaw7wRt3CNOPOBQvj+w?=
 =?us-ascii?Q?xnlo6BXr73OsHb7DIQMHsytVeg1UQia6ePz6irB51M4lucdn1KsltoDmYgiJ?=
 =?us-ascii?Q?/vEftJhAHKSzi5nlhskP+8Crhu06Vt1Gm32mdoFX7feKAYNBudHvhKhlzKDp?=
 =?us-ascii?Q?AK2o7AzF/OV+XoyEuaFCLg2wnujxOqsmhqjApafaTRPXqwidk1vd78tjwOdI?=
 =?us-ascii?Q?b1oR/OSx40J+hfC3sLMelmg6EusjcVrtReAyy1Bn1xY82RmdLhJNASsXQ5mv?=
 =?us-ascii?Q?Xcu5SnBKo1NfrjoB6q1rH5M17cieu8iDjbZcPk+JhQmKBOUL03HYmvTn8GEi?=
 =?us-ascii?Q?sOJDX/7JYNzzUZNLRR0Sejv+PFwwi6Ugiixe4geRx4qqvmOfPDSwpnnW9JlE?=
 =?us-ascii?Q?CiB/w7VeHHKbO8q6Ylly6mJv0j703s5Y/BRim6BtKOwABXkQ5xQph/W8SyOh?=
 =?us-ascii?Q?e02y4KorXCRjous4CZ0aA4Dbn9ggxUjKACVuwGqsY3PCYR/P2+MzIw2MwMKr?=
 =?us-ascii?Q?6wgf8SDl0r/zp+b4Nyu4QL150M6A2EZFXw0pxOrZPJ1+UTcKRKpKBjtpjHSc?=
 =?us-ascii?Q?vuLa26Y6lKZMPZZxbpcFUUJ/45ltGRF9kGJ0bpHooAyrj5Rj9EtxvQS9WblA?=
 =?us-ascii?Q?SaIZVXJYIi08DuC8u/rbS2ELAIM4P4QP6y8Rqkqa3qaCO+W9/61cmxMxagB1?=
 =?us-ascii?Q?SKPAyqW8jyQqeJTTUH2kbo5hWdHDu9HWnD2NHJ7AECIMtgFKprpNUMJDNrMJ?=
 =?us-ascii?Q?U/YeOZTqmtCMzjpQsTDOljF8yWeSK/PYtgDmd8Tg7dJ0LvoUBE7pZ7IFPrZj?=
 =?us-ascii?Q?+MDXvcAokDa0dd4ToysEzaopNOs/R/RL0TzCBknp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d81a0fd-7bdd-4363-300b-08dcd314e632
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 10:23:09.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RdgcZ0OU1+ti7H68T9gUKl/10IwKk5GyaI6LpPIOQiOMmJzWHA3u+DkxZr8rm8N3SsszdQXjetAlUk+flKdZZZXAdIes255RTV0KD2Y6CV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1162

> On 12.09.24 10:55, WangYuli wrote:
>=20
> From: Xingyu Wu <xingyu.wu@starfivetech.com>
>=20
> [ Upstream commit 92cfc35838b2a4006abb9e3bafc291b56f135d01 ]
>=20
> Add I2Srx/I2Stx0/I2Stx1 nodes and pins configuration for the StarFive JH7=
110
> SoC.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 58 +++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 65 +++++++++++++++++++
>  2 files changed, 123 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si
> b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 4874e3bb42ab..caa59b9b2f19 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -202,6 +202,24 @@ &i2c6 {
>  	status =3D "okay";
>  };
>=20
> +&i2srx {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2srx_pins>;
> +	status =3D "okay";
> +};
> +
> +&i2stx0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mclk_ext_pins>;
> +	status =3D "okay";
> +};
> +
> +&i2stx1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2stx1_pins>;
> +	status =3D "okay";
> +};
> +
>  &mmc0 {
>  	max-frequency =3D <100000000>;
>  	assigned-clocks =3D <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>; @@ -
> 340,6 +358,46 @@ GPOEN_SYS_I2C6_DATA,
>  		};
>  	};
>=20
> +	i2srx_pins: i2srx-0 {
> +		clk-sd-pins {
> +			pinmux =3D <GPIOMUX(38, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_I2SRX_BCLK)>,
> +				 <GPIOMUX(63, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_I2SRX_LRCK)>,
> +				 <GPIOMUX(38, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_I2STX1_BCLK)>,
> +				 <GPIOMUX(63, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_I2STX1_LRCK)>,
> +				 <GPIOMUX(61, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_I2SRX_SDIN0)>;
> +			input-enable;
> +		};
> +	};
> +
> +	i2stx1_pins: i2stx1-0 {
> +		sd-pins {
> +			pinmux =3D <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +		};
> +	};
> +
> +	mclk_ext_pins: mclk-ext-0 {
> +		mclk-ext-pins {
> +			pinmux =3D <GPIOMUX(4, GPOUT_LOW,
> +					     GPOEN_DISABLE,
> +					     GPI_SYS_MCLK_EXT)>;
> +			input-enable;
> +		};
> +	};
> +
>  	mmc0_pins: mmc0-0 {
>  		 rst-pins {
>  			pinmux =3D <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,

The above changes had been reverted in commit e0503d47e93d in the mainline.
Is it appropriate to merge this patch into the stable branch?

https://lore.kernel.org/all/20240415125033.86909-1-hannah.peuckmann@canonic=
al.com/

Best regards,
Hal

> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index e85464c328d0..621b68c02ea8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -512,6 +512,30 @@ tdm: tdm@10090000 {
>  			status =3D "disabled";
>  		};
>=20
> +		i2srx: i2s@100e0000 {
> +			compatible =3D "starfive,jh7110-i2srx";
> +			reg =3D <0x0 0x100e0000 0x0 0x1000>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_I2SRX_BCLK_MST>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_APB>,
> +				 <&syscrg JH7110_SYSCLK_MCLK>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&mclk_ext>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_BCLK>,
> +				 <&syscrg JH7110_SYSCLK_I2SRX_LRCK>,
> +				 <&i2srx_bclk_ext>,
> +				 <&i2srx_lrck_ext>;
> +			clock-names =3D "i2sclk", "apb", "mclk",
> +				      "mclk_inner", "mclk_ext", "bclk",
> +				      "lrck", "bclk_ext", "lrck_ext";
> +			resets =3D <&syscrg JH7110_SYSRST_I2SRX_APB>,
> +				 <&syscrg JH7110_SYSRST_I2SRX_BCLK>;
> +			dmas =3D <0>, <&dma 24>;
> +			dma-names =3D "tx", "rx";
> +			starfive,syscon =3D <&sys_syscon 0x18 0x2>;
> +			#sound-dai-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
>  		usb0: usb@10100000 {
>  			compatible =3D "starfive,jh7110-usb";
>  			ranges =3D <0x0 0x0 0x10100000 0x100000>; @@ -
> 736,6 +760,47 @@ spi6: spi@120a0000 {
>  			status =3D "disabled";
>  		};
>=20
> +		i2stx0: i2s@120b0000 {
> +			compatible =3D "starfive,jh7110-i2stx0";
> +			reg =3D <0x0 0x120b0000 0x0 0x1000>;
> +			clocks =3D <&syscrg
> JH7110_SYSCLK_I2STX0_BCLK_MST>,
> +				 <&syscrg JH7110_SYSCLK_I2STX0_APB>,
> +				 <&syscrg JH7110_SYSCLK_MCLK>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&mclk_ext>;
> +			clock-names =3D "i2sclk", "apb", "mclk",
> +				      "mclk_inner","mclk_ext";
> +			resets =3D <&syscrg JH7110_SYSRST_I2STX0_APB>,
> +				 <&syscrg JH7110_SYSRST_I2STX0_BCLK>;
> +			dmas =3D <&dma 47>;
> +			dma-names =3D "tx";
> +			#sound-dai-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2stx1: i2s@120c0000 {
> +			compatible =3D "starfive,jh7110-i2stx1";
> +			reg =3D <0x0 0x120c0000 0x0 0x1000>;
> +			clocks =3D <&syscrg
> JH7110_SYSCLK_I2STX1_BCLK_MST>,
> +				 <&syscrg JH7110_SYSCLK_I2STX1_APB>,
> +				 <&syscrg JH7110_SYSCLK_MCLK>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&mclk_ext>,
> +				 <&syscrg JH7110_SYSCLK_I2STX1_BCLK>,
> +				 <&syscrg JH7110_SYSCLK_I2STX1_LRCK>,
> +				 <&i2stx_bclk_ext>,
> +				 <&i2stx_lrck_ext>;
> +			clock-names =3D "i2sclk", "apb", "mclk",
> +				      "mclk_inner", "mclk_ext", "bclk",
> +				      "lrck", "bclk_ext", "lrck_ext";
> +			resets =3D <&syscrg JH7110_SYSRST_I2STX1_APB>,
> +				 <&syscrg JH7110_SYSRST_I2STX1_BCLK>;
> +			dmas =3D <&dma 48>;
> +			dma-names =3D "tx";
> +			#sound-dai-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
>  		sfctemp: temperature-sensor@120e0000 {
>  			compatible =3D "starfive,jh7110-temp";
>  			reg =3D <0x0 0x120e0000 0x0 0x10000>;
> --
> 2.43.4


