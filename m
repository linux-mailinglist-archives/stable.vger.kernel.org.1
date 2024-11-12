Return-Path: <stable+bounces-92217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F249C515B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73F4B2D166
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5FA20F5AF;
	Tue, 12 Nov 2024 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdIFLg8r"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398F20EA2D;
	Tue, 12 Nov 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400767; cv=fail; b=uRAY+EK8eDSCI9k6BH1bhNYPSffWKtqzSfDiUmrigYEFGlP6iGcCZWbRhgM1wcAGKwb4B9SBpbwv8EDmYIaPaX8VITkD8N/nCJNdf6Vie0peZFU1ClNOc3HlsuD2GrLO6qdjrvt5kQzQBOA6/5Zjb577eEnJCJ7YVQPZ1rm0j50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400767; c=relaxed/simple;
	bh=ZmPf68cjZwRL0FwE7sBU6MGkxvvpZe6rpRvpvLpGa+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXFgyWS/39HJwnfVlKCb12hNuSQtDqbOc0tFIBoemQ0dZyKJmBDaPywN3EVncLJzcpAR/tQSWe+Ez7RLUVqCwzk5gR5oVTi65BRSaKFTka5h4b4TpUgC++OgiEZitAtNnLG2DDNLYMrVROGHVnuoq6aqIloSWlXJoqUS46mhWAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdIFLg8r; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yagHUCMW/01ykmfpY1/w1IizJWlUwbcu48SCbtm7PQS4aU1XeUuAYIk2vNDR8ZWhPUo1dAvhUCoSKi9CRLLfPnCw1Ga1NfzfN9Wd6Cgw7s01/Odm9taZtuQbKZ3fsSXJHmZJsglcT5XCu3e19rXGWf+tw2bSNB7EChlN9UZ1LKyIm3f/JUuHwkSdpL85SPAU8ga1cm+H+Xj3iNxbxjUmBNVydq35yUkegsuw37rdTyH6JCYevkOO1/YFWJdDIWfE5NW1mwFMv0xGZ9iMhUksY8S6L3YcdLv01uqipK5lmTIczIZZR30HhdcYf1qUx9oWsu5U6eae5NIZHGHxNh2wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmPf68cjZwRL0FwE7sBU6MGkxvvpZe6rpRvpvLpGa+U=;
 b=gneZ3fgPaLdSOCCxVVWreKu342SvHH/0haajNLUjzphs/zm0c4lCLA82faajZ1peREgvyW0B4wYmvQQIVskOOYl7Nng14anih/YbpVGjZo5gLAty2M/2leCyOQs0BrGuSUpAyf20OJ0qtNQZlSELvEQ84qn1OklCSEk13ZHzS1rAUQHIzdczT18yXuqdoQMnGt80xCeYGnNpXeg3ZtwBCUlmPRxhh5uq+L3GaSZMuzlWb3KKG4QGAZxh8+cIso70WknPZiHAcIDkSsTxKnFdOKet4FgFBGErel7dy2a05Y9a2EENPDVQpaaZmxR1geAvtBaNGv+Yqa/ooNEbCGMJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmPf68cjZwRL0FwE7sBU6MGkxvvpZe6rpRvpvLpGa+U=;
 b=TdIFLg8rrnNvqgYKExHQHdKuq70p/Ica5QHyzYZTMvFdbufl51M4aTPOKpsfRE2+pCrDqL0HW2SN6C6xRR3//g7EVXPzZ6wbuOILP/gNNdC9HlP1CFhosjURSmSDYBdJIJ8AJ5ALqbxur/MDTU2V6pp+N0GfEXnk6qhczMLDRXPYggMzSZyP+3i/2/ioRdfTpD9p5SGiv12Bs7KOV5u+6HC67mwRUJwIRF/ucrfOODy89FiCXXb8obHuRcT8i18kSrBgZcM+EedBH4dnG0tUagSYmeVdmIeemA12rSEocC5PaIq5mq4Tz56NWtw2n2E+bG8sOnJx0ieOO8RRpFadjQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6916.eurprd04.prod.outlook.com (2603:10a6:208:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:39:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 08:39:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
CC: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] clk: imx8mp: Fix clkout1/2 support
Thread-Topic: [PATCH] clk: imx8mp: Fix clkout1/2 support
Thread-Index: AQHbNKNxtuk+MPPDh0WQ86RisZplrrKzU15g
Date: Tue, 12 Nov 2024 08:39:22 +0000
Message-ID:
 <PAXPR04MB8459329A30FC92B7C03BED6888592@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241112013718.333771-1-marex@denx.de>
In-Reply-To: <20241112013718.333771-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM0PR04MB6916:EE_
x-ms-office365-filtering-correlation-id: e1bec1a8-70ea-4bf0-4068-08dd02f581fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+3C5HBBLHD6KhsBCUe4YmCfij2CsYtQGdjlfg3XDtGdVQazwiX9RbW835gvZ?=
 =?us-ascii?Q?8r/HEM5O7Lbs6YN5sDZCMuPEbVNSEswGQH/rT/CbT4YgH6fjgtMOHw3o5xC2?=
 =?us-ascii?Q?ShwwuWGoxw3MlSmcajF6ZiZBmMLXrblclDlqW329SSOS8BvKshsrwfgPhGXG?=
 =?us-ascii?Q?mOkNrOK/w2AhsaJQBTRmtHVLJq7+d01Ya53Z53kDBH8TKvsl3fxOMt/lsoEO?=
 =?us-ascii?Q?p4oy4geTL9dYrbwGBMZrcUi+QrCgqm3CoS/xeGsY4/7ny7RGUoU8SJAJygTf?=
 =?us-ascii?Q?iU0RJTsgXR47C+uk6OTp9r6x8er1v3K0TK3TwtevwoxQrN5ic+EE/6CkCBJE?=
 =?us-ascii?Q?mMHNPwvxcavAGtsRu162MhATco0PHnhFZYEliIn47z5B+76TCVzTUCOsqWn1?=
 =?us-ascii?Q?z5pNcdctSp7UyCQmD+DvuYGmDJE81V0lvWi20YEh2ZPVSl8gVwQlvWP4kRVI?=
 =?us-ascii?Q?Pte6s50ywYgO6YOe/EsqeLWw4QRW7hG5yodpMgapMyO/7FYRFwYFP2eCclQQ?=
 =?us-ascii?Q?s7Pl5xv0V2+YSQLjFkKVd8eH/U1eXljPRXxd5ihYlbv63vJWWUPWX4BN1Osa?=
 =?us-ascii?Q?sSObx0GUtC1NWY9//hfo6QKg4IBfmOJOI+PLHvO5GHvDe3SO1gRpD0U6ybay?=
 =?us-ascii?Q?VpTcylIqf5WP9wT6G6xbRUjyNtzHokQW7NdgAd/3KUFT4zAYhh/PQtEmq6Dp?=
 =?us-ascii?Q?gBX/SL23eIZuKMQrCsLPWmLVnOIF4vxhBIxKOd1G7N9vYYy1uE/oLpYmx031?=
 =?us-ascii?Q?++RBSRjn7FRXmQf5FR1QxuHHmy7KQ8/Y0T/9HjLM6L4+/KOTs2xZQhZvnyPJ?=
 =?us-ascii?Q?H0BGyIIblHfDEWTV3Xv/yYHWFa9asTeaorKv5uBKyvLVP4NW0/jdep758SKd?=
 =?us-ascii?Q?7fdNvZ/z344Q0iWxvE+Uf2p8/q2bCs2LSN8CEBCOtZuwEIxvxqxJNvMdY549?=
 =?us-ascii?Q?SKGvMV0mgvwrUSxIVVA5pbUtkYyv/MjpJbVwc7+byOrW4DVIfHEnLdOJKodM?=
 =?us-ascii?Q?ld+JFLbmOin3FbBs6+hsZ+tOotZ1bsxpXDX2g41lhuExZMLgxVRZDBWjgkuU?=
 =?us-ascii?Q?cUB3ZRRYFFDQBEaDM9uwT5P2LOlWLJYKcf1GEyNlP8hiQBIFZwPmItL3Qs6Q?=
 =?us-ascii?Q?iCnfKxE7WsbGvaxi+PzFYZL/SY3oO0ckPRq1eVHcE4UgYc1TayM9QVhc66oe?=
 =?us-ascii?Q?v5n7JJNopXeWNCNurcBYaa/MJefJeeAcZWU47Z0Ms8qO80YPD2N+YEY4akla?=
 =?us-ascii?Q?9lxnzc/DhVGtWxjGekp64GVzUa69AnYs0SYbT1IFwCX/ib0h6uMeLlr+vKf9?=
 =?us-ascii?Q?accED1ExVgZmGJuGTTUB8+dIdyH4Kf5YoPgY/47tz5p1krHBMYlUy3SNTar3?=
 =?us-ascii?Q?lQfw/tU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QW4kY6LjFCgsJfZqO9szs5fB6VLVjEAXYuqV/P2Yuw/GIDU6ZJXj3uYKUgwz?=
 =?us-ascii?Q?DFk1jndz5hpLNW+sfpQAlYlEf4KcNWcfo5SdrzpnR9r9QqoXMa3VFcC87qQX?=
 =?us-ascii?Q?+yGyckra/C0sILCbV1y5Iexr3AE4Oyj3kaGPBLYaVl9IoGUXtmNv8Twwl8mn?=
 =?us-ascii?Q?OMq5ItJTDYQiZcKsESJnQtp2925sFpNTtycsABZ/eaoTqlJrPItKVV9Qpudu?=
 =?us-ascii?Q?98lGxLLfTsrc4VgudJ7Jr/I6Acr972Xy0Pafb6utsUVSBbWlqBqLN0jKA77z?=
 =?us-ascii?Q?dsnUhvRNpWwU4RHCFL70JV2FXwUXyNU9XYp7BrhBCcw4HHNj+hAY1kJ8kQTK?=
 =?us-ascii?Q?iIU4lnp0AiOSY5ZtrSif1BLgtLmYSMhttQGFK6dkbeEkEW5g9tSTjF2Rt/F/?=
 =?us-ascii?Q?auJXCABiBCD0g6P3FfqWfGm9Of773Q1ndJk56QFvXLMY88HwUZoL7gnwSSwi?=
 =?us-ascii?Q?5hOlV8Fvkaa/H9qlcC3VxkZ9PYO6e9vje1wMtjl+kaZaFp138Mm5Q7xSA/FT?=
 =?us-ascii?Q?L4070iIAWIhFjnbHgIEwtOAbKMsyB1wkJbp6m2NfxkaSdn/TL8+dKt1D4oTT?=
 =?us-ascii?Q?CgPQAPGDFmgQvCEhUvR0HCaTgYrJWo1/iiKFoze6yAzLVh6zvWwjHvHgHcz4?=
 =?us-ascii?Q?WZADnOHZU6tbXDOXtDrCNT/Rk5LdAksJEhcfLBGLe9m6vtqqqVjsvyENygLV?=
 =?us-ascii?Q?etN2CpUsh3JCVwBPF8CTUGF1uXVvDyKo3nHvmi3O/c0XilM0+Oklq0nneQ9g?=
 =?us-ascii?Q?JJQNsFeA8FrzqsAW/tFAziwVxq3+o/7XHSza2jQc9J7dftretCtvqF7xLubT?=
 =?us-ascii?Q?2uTQPbngj5GSxyyiETS2IgIbPwWwzy+fCuZqeafTEsXPj/9JT3B5TL/klg5R?=
 =?us-ascii?Q?bmvet69OZcroM8TEpgp0pbZ4e8QJOQ8Rt9knMQHT+Ci667/TWp2BVUf5ZVGc?=
 =?us-ascii?Q?GgLVrvJU5AwyCwnJ0RiMvWFmfRwzdKj7pFiwi/etT13is045tBEp9yRjPc5P?=
 =?us-ascii?Q?8mdo7SfFI60qEOPwU2mZ4XUeTKMnLWgoQLOeV8KpdRgrV8zih3JIMeCuTxQ3?=
 =?us-ascii?Q?FG/jrTcJLGoG/mnktOhmbl5nc9g+BgAFzuSWxqSK6JRPFrJ6U0RGFYCFgnPL?=
 =?us-ascii?Q?iFm3jl8gy4p3QDs79JIcjdz+I2wC+knyxnnO6mXpmtHgg9IUCUi5Wn6fX19Q?=
 =?us-ascii?Q?KcXwP/Jh6lxb6FrbAaKaO6ijpDSaJIyF2BF/9AWciAe3CvF6hchZqehbudfA?=
 =?us-ascii?Q?LutnHpyRS5ZQwLxU/mcsZ7QEeJl/TqpvBF3qlKtN42KuLANk6rwIc/E/FnI3?=
 =?us-ascii?Q?QCyzeJcoQhbXIT6uQ/M03jCm1axDtObtuS3vw0z7cK6oKSIfZzl3Iyz5cgs2?=
 =?us-ascii?Q?RUavL1HFO2D76QhXiCC6LmlnNREQk+2lkJk4BpljzuGLRYCz2yQEeWJCp8O7?=
 =?us-ascii?Q?dpzU3GQzszWadRHflqhk1SaHkvAl5x9CAffwHcDUWIXdRJHAEdS/JaguF5LW?=
 =?us-ascii?Q?8xCN1TX8wnC+x0+R74wkBdSb0n2qlacOaTj4bwMhl+iZXFA8bjOLGhyJeSt3?=
 =?us-ascii?Q?J+vBE1pSoLQDYPkzyBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bec1a8-70ea-4bf0-4068-08dd02f581fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 08:39:22.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5zEwnr5IAwjJA15TzFp5OZRWBaMX+Oocoq6wznVrmST6XYtArAJiwfCyztS2L+14/13SNqk8sa4sMkM8SML2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6916

> Subject: [PATCH] clk: imx8mp: Fix clkout1/2 support
>=20
> The CLKOUTn may be fed from PLL1/2/3, but the PLL1/2/3 has to be
> enabled first by setting PLL_CLKE bit 11 in
> CCM_ANALOG_SYS_PLLn_GEN_CTRL register.
> The CCM_ANALOG_SYS_PLLn_GEN_CTRL bit 11 is modeled by plln_out
> clock. Fix the clock tree and place the clkout1/2 under plln_sel instead
> of plain plln to let the clock subsystem correctly control the bit 11 and
> enable the PLL in case the CLKOUTn is supplied by PLL1/2/3.
>=20
> Fixes: 43896f56b59e ("clk: imx8mp: add clkout1/2 support")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

