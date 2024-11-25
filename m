Return-Path: <stable+bounces-95334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725789D79E2
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289932825B1
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC6B666;
	Mon, 25 Nov 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ejmnNV+c"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCBA921;
	Mon, 25 Nov 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499748; cv=fail; b=XUkCDZrIAwMK9aAUxy8GCLhk1m4UeJxe0VD+KAU3zlcd73T/ykZBF6j7VCtIHsWnffj0CvnJ9SrKk0988kPl+G39MOqqZIrZhoGYFPdk/PBBl8nqJyOuAOz+d4RDR9ba1pXOW9ktIkFOc8VIqiox+vGB8g5U72UNh/swgSeM7g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499748; c=relaxed/simple;
	bh=xHX2h0TvCk7Z95epK6Xrg1Q9VZyO8YTfTRhq+8OZnfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+ylG0DLQz86Wc71GvZG5hWsXLLe8VsIhj78WceHp9DldLp6deXz9HfsPid81Uaf1EvjHGSULhJlw4SubadmgRYGdwPuX9M+h80o8QPSNMZlKGY/tYXR3sdoERWFwqVsIYnweK4OITxNf1NpxT8Hed8tRyesMD7bp1jyg2TkVdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ejmnNV+c; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Me/PPjpucBkEa4tuBFEF4MznRHfXDX5Goc/0IehtDyFfVhrr5lJXTqevrX3vi0inrjhq9E8LxVmgn0DqNwD/8vZDQG4L4juydpIjZtyrb8Mm7LAq4cnJbCG15mEuanlyR2cxz5IfcgIf1kKBkDVawb8gUAbo/OUj8MtW4+akNNNS7NWJ5l/HNSfdESicCA7xBEbJ6+RWdIVFEwGpurrQKPxaYethhSUCZ0BXn4SeOQm45+mFjf6mSDZiE5y34emcnlhFBuhsI1INVHb628r+opgYDm6bI52wQ0UeLcEzSeQ4WwsfMrLXg8mAYzmk+1Pyaer+CH92/6JPoyVdicmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN+jCMFw9IJTowUQAalvtEKvi0IIkJpW0Pr+OSBszKE=;
 b=NfDSRseCZ73mgV/7h9N8UkeowqaF2OcWCeZDzaHWCEqGhJxpVcGyLYQX1g8CJIB7WSjhRPqwBSkJ1wP/ap6l2hdo9HpGvbdxT8F/x/WqSrqcQPuyKlw6nFDXG4L6Oosms9MRRMwu9Vm//Tzhdbce2yp1dPCBYBwJhPMmY2pPZb9yWm2auHWxso/95sxSfVYynlZLLUb5fpvla043xEpnrqJlKQKzM0l6J16PW0cR4NctrMUqpdDzQ8PuId+T1+GbQiPAgwy59fhHkrkFqbl4xllGxTYCG4FVsTJW6J1DzeVy6LTaKaMB5dmJVUUbwv7icJYghmiOybM+9+RY0+GsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hN+jCMFw9IJTowUQAalvtEKvi0IIkJpW0Pr+OSBszKE=;
 b=ejmnNV+c9gU2IrWSuDbysjeDsnqU6o4cN1P8bNqD8oqexWYJyTjaDp6w5SWWf7ANUNcjDTIOZnPB7r1AyOH/br+d21Dt7J5Kxc6QSV8mZvip9liU7vU8bjQbK4458xMHo+6SuNbheYKFPFAXebajWoNaTSQFrZpkMtxwJYjyAKU+diLKI2BKVcwhYoXAs1reeYu0FQ9uQ4QhG6qfSewZ9UrTLiiqn8dFPOEocGxjwRh2tx1is1Ebsz6L0C7KlAKHQBDGMDD/9IYL/XJqxbR+epa0z/7yMK2qDaCLrFeTgPD4eJIoo2pBY14F/Qj85W63kmqqehcfcoQwga7J7SW5+Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9852.eurprd04.prod.outlook.com (2603:10a6:150:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 01:55:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 01:55:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Sasha Levin <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, "David S . Miller"
	<davem@davemloft.net>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 6.1 35/48] net: enetc: remove ERR050089 workaround
 for i.MX95
Thread-Topic: [PATCH AUTOSEL 6.1 35/48] net: enetc: remove ERR050089
 workaround for i.MX95
Thread-Index: AQHbPnftvcvt1X8cB0CvrZ78/6rZRbLHPPsg
Date: Mon, 25 Nov 2024 01:55:41 +0000
Message-ID:
 <PAXPR04MB8510602580EC63ABF4837149882E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241124134950.3348099-1-sashal@kernel.org>
 <20241124134950.3348099-35-sashal@kernel.org>
In-Reply-To: <20241124134950.3348099-35-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9852:EE_
x-ms-office365-filtering-correlation-id: f8983fc5-0e56-4faf-e6f2-08dd0cf44465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?z4cRGIRIzSwrUq7Mmg4Uvah0P+xaswsiGONuRBZRd+YDutfn1WObnnMUZGyK?=
 =?us-ascii?Q?LV4vJtug6Vy+DdtriSB+ea1JUtkT/P79FuDTLxAxv18eyQ00eoVhH6xEqQW+?=
 =?us-ascii?Q?yG4dyIjhfPBAcmICmYa0l9dVvQEZT4skowD9vchjd4n0dG6gnoEWGLxqHilb?=
 =?us-ascii?Q?Oh197re7hJdslUdcUt4GuDmogkcJN9HGZA5ZIbD2yMTeoZbZ8H5nNQxiPrnR?=
 =?us-ascii?Q?R90DxBg6giXCfhtozI4pjpYuYfaAvzJJjVk6inW8vL+NmAMkxqrHSMPK/W0T?=
 =?us-ascii?Q?tPc4/I306e8E/BIjN6v3/J8H/8yxCF4rVoY88J6faDrWhEKRWbbGEkC3rnSB?=
 =?us-ascii?Q?u0R0TwCUtx3eQjazT1ww4LRw2Y+2iShBy7ynI+BPDD4VgOLKtoAd/cu2bBCl?=
 =?us-ascii?Q?T0edLY3BFufXith8f7tuMr6uDxCASIujB/3y6D9u6hrStpno2CyQyRts/R6Q?=
 =?us-ascii?Q?L/N+wfrN85kUmTUllUcwGCorOvDurOfzWGVu5OTBljIa4h7ubxDL6r+oeZgK?=
 =?us-ascii?Q?gFT9j2rm82jkGuD68ibhH4SKksdhFTGNeZbDDHNyMcBH5BGbzPS9Y9xhsEJI?=
 =?us-ascii?Q?NW/mrkEP5P9W0ss1pFI5a1KFAcez1aSTPvy6asmhJa2sAD7ORbRf49LIinfz?=
 =?us-ascii?Q?1AQ0HBlyZqdN9vUyYsluV1LeKGLR+X/H5UHUaPiGUQoHI/4mcHgArtpr4v7E?=
 =?us-ascii?Q?Oq3GlWxBJuE6zcADeNC7SQAP+2Exi6/Rusj3bS07kfxDtELY1NG3bVb5gfO7?=
 =?us-ascii?Q?ns852Ci6PdFsyMGBowFhZQ86SxIPMT78FQu4DliUki3F5IItgSI+bwx4Tx9Y?=
 =?us-ascii?Q?MlgkqmbIGg5hDaPDK27FgyBXeuoX4uzK+NH+hKYB5O4tWBLdxieYGqUUXUfG?=
 =?us-ascii?Q?SZsg1w6n4JN2LrVLNSLIZtoGmcPVnfVk+7YN0QJhG66u5LM+JcAKLN3ceD3S?=
 =?us-ascii?Q?JvxfaxgFUbRF5LaLKsX2gwB4pPs6ytymr82PnhDWXN8PtAGuoMvmuwofdYai?=
 =?us-ascii?Q?btc4C+aa8LLg3Z/12nN4ykW25kXae0/PfsJ+zw+A6bIEm0hdE89SGx6ahvoS?=
 =?us-ascii?Q?LlsAF2LXtWktz4pa05cuHfqXkwVYzYVRzKt3yBOatD/B/QXdq4TCvIooMzBu?=
 =?us-ascii?Q?KQ114OVyyqY0cYnv6lc22grLWd+YGpmLxICXzvWzRJIXnqfLOS9RzmIaex+W?=
 =?us-ascii?Q?OuS9eli21wBQ/gVwRS68BB05nigNxACWQdE+LCqBtdYAXb8/GPfb+IxseFWu?=
 =?us-ascii?Q?+jL7b/Dee0kNBZOZhIbD9x2pN1KzGdNBNXuYQ69YlFMQEt4LLIJcfcVM0Uy9?=
 =?us-ascii?Q?tQVpCxC01StvQP4XY9ZUelOaGshsvvjZcuCW6UyApie8yxHgfv5oNGAaPOAM?=
 =?us-ascii?Q?aMc3LBb5D0ohjJMlaZcHtpNzyUcXCxzNvGSyCQzrSi+ETs0HxA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pkFCtzdGjkUsdZA30ZLxbGe2cZD0kkZVGEkgqqfSqyeZyUA119+R0p1DYQ9k?=
 =?us-ascii?Q?U+tTU1xCp4EuNQ/fWNTx1dnoJMogGxgINLeVSCgU5c3AUl7E4R3ZBhAU1ulB?=
 =?us-ascii?Q?3T7Dxp50xKF7peAfl9BxYvu6NEKFEcHReKBzOHBFJGb5p4oXdoiJ0XwG7x2I?=
 =?us-ascii?Q?LxrGE7Lm8srnZiF8Q9OKCQzEJkjNqlnPDWycY3bVj5eQoTzQVA1QTn7bWW3m?=
 =?us-ascii?Q?n0CitC5N2Jq4U8jt3oT6LYQBBZaA7zdzdm2MbZ/TqL89eKSpSTuJXIghKRdF?=
 =?us-ascii?Q?7LVjP0PzJgWeCik59EDgSbbJM1dLKP/cI8BS+JlV7HFXv5qgar9xQRHa6BD6?=
 =?us-ascii?Q?kwQNaRVkGzRNYbeEmUi+DYXIstbiHErYXjeSe/jk8MfLZ6g5Php+Hpydqj9M?=
 =?us-ascii?Q?M7oIvtmz4swwI9XJn7ogfYqRdd3vtRY7ZR/7XYy0rEZgy0PgD/RhLCxqvgw9?=
 =?us-ascii?Q?S63nqiSPEGTaFIyjwJU4B0SoA0rotPHel7DyXa78DGoNkaNS67MSFsUuYzJU?=
 =?us-ascii?Q?qXzUyOknPzCzrMv/i2QFGBaWHsJKJn4uq/PHS0oBiZTr6P3GelffR+XTRkMv?=
 =?us-ascii?Q?2NOJ4pShWMNGsY+DZQ8FiIDfLBbnWmn15vpVh3mh/SSvfSjByi24+nvKrEUj?=
 =?us-ascii?Q?8XPyHcTdCuL8BeMyu6bTmsHaQ5bLMUxaxiXOn85u9WJ27D5A/y2SD6SqcG7x?=
 =?us-ascii?Q?31s5u7ouQ/GEPMpKo+gih+B4DAZRps/HuU3O19iu7ulG0+gmD6TOjMbLc6ul?=
 =?us-ascii?Q?oGP8JblehABcDhJ51JJfkf2WwDraTv+gQcT/PCf96lCeUF+lhV4Ol4R3Uepd?=
 =?us-ascii?Q?fvvKIneMGxhDp3rDSbs92F7QZUHxCZdc3wwNUSTYNR/oDR4WG/jcbskegOSe?=
 =?us-ascii?Q?l66s+30atQBQSskBY5CO7ZFqUfjMw01rHcWuQHWYUpbcal/+EiZH7bCyCZxT?=
 =?us-ascii?Q?35EjEtX8gwuqQ29v96uHVuWCOQEu1ZXddB+m/SAMDKEtdkbe0v57O2UMztan?=
 =?us-ascii?Q?IGPLFTaXbfwIMDfoc+S3D/rLhQlfXCvz3NWRK4/aGCZbeJeJUBMaaJDc/KLs?=
 =?us-ascii?Q?OZDznJfbf3Sg3HqqA+E2V3D4n1yl9h+g4pfZWdLlMQVVZQp+rdmDa0Gfqb8q?=
 =?us-ascii?Q?fbdme36KvN6SH0le4hyuyOI0iTnYgtXemQlg6J9rlEDkK6VzontdA3ql8jMg?=
 =?us-ascii?Q?iosu85rEGbzy4wZTZrIbz6rNwVbSrvZlaLsmhn4GDC97ckA4Qd0rLgw7oAAK?=
 =?us-ascii?Q?YxMYbKymx9mi2tLnEowylDbcuC8BEN8zXJP0WsNFZ6eDgzbPraxgGK72Wve8?=
 =?us-ascii?Q?V3cTrXLU/2kK8IIX5ce0XhuVPtwpvhitMMIIZSft1nWvE3ABZP6B/bma/9GR?=
 =?us-ascii?Q?IsrYZmENxUIgVbCFIZetaJnxdzisaftCwarpcYWTIYMKMnIeHREZbzX1Hd1i?=
 =?us-ascii?Q?QL/mbhYS605jToX6kugG4/YWR5vRTm5vqMXT2T2hM1VtrGeYDQsBcQku9vsF?=
 =?us-ascii?Q?xy5wv9UlVF9u6s2LBI2YMq2L214DYOGz23IfkoHCEQQnBiLmXNAZbqdNJeJn?=
 =?us-ascii?Q?NabLaB+vdSNE6xURkdI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8983fc5-0e56-4faf-e6f2-08dd0cf44465
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 01:55:41.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNczUAG/tmziH1O98UzmUpQ2odsprcBXQypzprFlrF16jHAP1OvThSfBsZ5cCHLX5++jwnEkJj9m1Nr96DJ3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9852

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> [ Upstream commit 86831a3f4cd4c924dd78cf0d6e4d73acacfe1b11 ]
>=20
> The ERR050089 workaround causes performance degradation and potential
> functional issues (e.g., RCU stalls) under certain workloads. Since new S=
oCs like
> i.MX95 do not require this workaround, use a static key to compile out
> enetc_lock_mdio() and enetc_unlock_mdio() at runtime, improving
> performance and avoiding unnecessary logic.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 34 +++++++++++++------
>  .../ethernet/freescale/enetc/enetc_pci_mdio.c | 28 +++++++++++++++
>  2 files changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 18ca1f42b1f75..a5e38804e2811 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -372,18 +372,22 @@ struct enetc_hw {
>   */
>  extern rwlock_t enetc_mdio_lock;
>=20
> +DECLARE_STATIC_KEY_FALSE(enetc_has_err050089);
> +
>  /* use this locking primitive only on the fast datapath to
>   * group together multiple non-MDIO register accesses to
>   * minimize the overhead of the lock
>   */
>  static inline void enetc_lock_mdio(void)  {
> -	read_lock(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		read_lock(&enetc_mdio_lock);
>  }
>=20
>  static inline void enetc_unlock_mdio(void)  {
> -	read_unlock(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		read_unlock(&enetc_mdio_lock);
>  }
>=20
>  /* use these accessors only on the fast datapath under @@ -392,14 +396,1=
6
> @@ static inline void enetc_unlock_mdio(void)
>   */
>  static inline u32 enetc_rd_reg_hot(void __iomem *reg)  {
> -	lockdep_assert_held(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		lockdep_assert_held(&enetc_mdio_lock);
>=20
>  	return ioread32(reg);
>  }
>=20
>  static inline void enetc_wr_reg_hot(void __iomem *reg, u32 val)  {
> -	lockdep_assert_held(&enetc_mdio_lock);
> +	if (static_branch_unlikely(&enetc_has_err050089))
> +		lockdep_assert_held(&enetc_mdio_lock);
>=20
>  	iowrite32(val, reg);
>  }
> @@ -428,9 +434,13 @@ static inline u32 _enetc_rd_mdio_reg_wa(void
> __iomem *reg)
>  	unsigned long flags;
>  	u32 val;
>=20
> -	write_lock_irqsave(&enetc_mdio_lock, flags);
> -	val =3D ioread32(reg);
> -	write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	if (static_branch_unlikely(&enetc_has_err050089)) {
> +		write_lock_irqsave(&enetc_mdio_lock, flags);
> +		val =3D ioread32(reg);
> +		write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	} else {
> +		val =3D ioread32(reg);
> +	}
>=20
>  	return val;
>  }
> @@ -439,9 +449,13 @@ static inline void _enetc_wr_mdio_reg_wa(void
> __iomem *reg, u32 val)  {
>  	unsigned long flags;
>=20
> -	write_lock_irqsave(&enetc_mdio_lock, flags);
> -	iowrite32(val, reg);
> -	write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	if (static_branch_unlikely(&enetc_has_err050089)) {
> +		write_lock_irqsave(&enetc_mdio_lock, flags);
> +		iowrite32(val, reg);
> +		write_unlock_irqrestore(&enetc_mdio_lock, flags);
> +	} else {
> +		iowrite32(val, reg);
> +	}
>  }
>=20
>  #ifdef ioread64
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index dafb26f81f95f..d3248881a9b7e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> @@ -9,6 +9,28 @@
>  #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
>  #define ENETC_MDIO_DRV_NAME	ENETC_MDIO_DEV_NAME " driver"
>=20
> +DEFINE_STATIC_KEY_FALSE(enetc_has_err050089);
> +EXPORT_SYMBOL_GPL(enetc_has_err050089);
> +
> +static void enetc_emdio_enable_err050089(struct pci_dev *pdev) {
> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_FREESCALE &&
> +	    pdev->device =3D=3D ENETC_MDIO_DEV_ID) {
> +		static_branch_inc(&enetc_has_err050089);
> +		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
> +	}
> +}
> +
> +static void enetc_emdio_disable_err050089(struct pci_dev *pdev) {
> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_FREESCALE &&
> +	    pdev->device =3D=3D ENETC_MDIO_DEV_ID) {
> +		static_branch_dec(&enetc_has_err050089);
> +		if (!static_key_enabled(&enetc_has_err050089.key))
> +			dev_info(&pdev->dev, "Disabled ERR050089 workaround\n");
> +	}
> +}
> +
>  static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  				const struct pci_device_id *ent)
>  {
> @@ -60,6 +82,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  		goto err_pci_mem_reg;
>  	}
>=20
> +	enetc_emdio_enable_err050089(pdev);
> +
>  	err =3D of_mdiobus_register(bus, dev->of_node);
>  	if (err)
>  		goto err_mdiobus_reg;
> @@ -69,6 +93,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  	return 0;
>=20
>  err_mdiobus_reg:
> +	enetc_emdio_disable_err050089(pdev);
>  	pci_release_region(pdev, 0);
>  err_pci_mem_reg:
>  	pci_disable_device(pdev);
> @@ -86,6 +111,9 @@ static void enetc_pci_mdio_remove(struct pci_dev
> *pdev)
>  	struct enetc_mdio_priv *mdio_priv;
>=20
>  	mdiobus_unregister(bus);
> +
> +	enetc_emdio_disable_err050089(pdev);
> +
>  	mdio_priv =3D bus->priv;
>  	iounmap(mdio_priv->hw->port);
>  	pci_release_region(pdev, 0);
> --
> 2.43.0

Hi Sasha,

This patch does not need to be backported, because i.MX95 NETC is only
supported in the latest kernel (should be 6.13, Linus tree). For the old
kernel, only LS1028A NETC is supported, so this problem does not exist.


