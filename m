Return-Path: <stable+bounces-116638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B092A390BA
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE743B2D32
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86F1474B8;
	Tue, 18 Feb 2025 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OShlQw5O"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B7482EB;
	Tue, 18 Feb 2025 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844679; cv=fail; b=KIJhM75jrid4UH4lX23m3G/WxZWTX6if9slParE3FkASaoDXrNCNNsF2BonVhbrAwdjMZklimzRTmK3mDe9+epQl6UnHv/00BjzamXJ4IAxUvud0jSL8X44e7/lNdb/TbeUWp8I89t/Fwjc0xqtlEvquz92OdjdaSx+aE4BUdZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844679; c=relaxed/simple;
	bh=UZRsx4Wz9A1EZEFldKPduqUA0ehNb4flPz9Dn1UZ/GU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d75Agdupc4qPLFaYvAgULS6HGLnCLm4o0jiNg6Ro6JTN9lP/aZaGuKmNcQQ3TYgEZz3hD7FXR0YG52ZzN4cmGU5NJz52eqNA0yvDr2o0JN0zyhghUgRNijA3q2k/2lCr11IskzhYOeIjMmDeZ6lmvoKkw8MEwLXhs3lE/UqS6M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OShlQw5O; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtBEbA5O2zHrcEREgYme6qbiAVcUtACO+SGST4ODGRh/FSpznmfRov0D/80YCIrp/ao4Dhivqf3KeLwcZWh2OUG8cqs57sDMyg5B5hDukJKqpy43AOuEr9Uvx3mTtgj54GFljLElAOKY+MDAab3vvc5TNCT7mzeVe4GO5NqtPcycr8uhQsN7GS0KFNwg3U2su/wvYELSyg7/USGVQQQ07h4ggwlbuWK0k/wIARbGXsGPmLIxEZMM6PRhBY1cP/zwmOOcCzmB5GNwFdwuaXbq6K69rm30fx8OItsBfZN6/MDC1vvhYpNadsSB8JdTLxY8Xp3w3viEf73PXqLYN75lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+FhcdS6YVEnSfWVuN6TxVZMIj6ku0r+zzgnz1A2Qgw=;
 b=GeddcStZjXEAMY3j9WW3IJmru6uDtIlIqpUC/D7AWPK8I5hC15Va3rO0ZZV6tFB7ozYMb4r8Zo7BWodsOe+RVuqvMh+UAbLzsoOhrVw7UQU/yvfa+lviS4sJNIBxclwRFSKTCqO+J2E1Nx38I+I7azTJKw/i5pT+DDUnoPndHgXJwWZF56ng54y7j4UqrrKjj1xBSGWFPm1t9reEihFT36k2xo7uKHq7Rl8tgd0kEOlcwMKn5oMJ+iGq0pC8+WjfqkMuQq4sB/daD30vfNJlIwEKFucyv/A1deyrou1wywyXshjlBwnYrgtes4ef0qrcqM6gLn379rlb/HhtTF3mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+FhcdS6YVEnSfWVuN6TxVZMIj6ku0r+zzgnz1A2Qgw=;
 b=OShlQw5O6QAmnrgKFv32pwsVD3VnMia9tNdvimJhXy/uN91YHZ9AH07rpN4s1omVypo1q0dPlHTcsj1qJB/oP0obJFvtxmU9Yvdaw9sWCObpdxpp8JNVmV+PFHKQXgdZiIoc+I5Z98HiJJvjsvGKIHS5Yjbhd9qWHRueT3GC7JPlinK+tVeWv6X+xkUDhCse41vC+ssSGHDHFaHYsqzL6TW6P0UO7ozA018nMCrpJ0DJOt0eAo7LLDXsoU0PJvqAl3aEEUn/DkUv3Tinjlppg/Ty1HL2eo7/qub+yLJhWmugkQFL7j9eUcvo6PzX7Oo6BSipCok4sGDP5sJkaHlL3Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10495.eurprd04.prod.outlook.com (2603:10a6:800:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 02:11:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Tue, 18 Feb 2025
 02:11:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIxXCrhXQUTvUaf5YMAXyCn+7NLeKmAgADXyvA=
Date: Tue, 18 Feb 2025 02:11:12 +0000
Message-ID:
 <PAXPR04MB8510AA1D5B596B4382873A9F88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <Z7M1hQIYZGWAZsOT@mev-dev.igk.intel.com>
In-Reply-To: <Z7M1hQIYZGWAZsOT@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10495:EE_
x-ms-office365-filtering-correlation-id: 474cf44b-b21a-4999-5794-08dd4fc18459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YvAaKrPRspuoxl5xM2TTGhHuFGFcEzLd0fDNEQ+0XeoCWengHvJFcuwnhNF/?=
 =?us-ascii?Q?4FNMAbYATtJtlaTzLYECyC6yWN5/coRAJBLQsWDVrXMKFAcYGLqx3Fgixgs9?=
 =?us-ascii?Q?ywi8lZnBIYE5Kc+Xs71s+9CqNrOkiL48MUeEHgyL9/oz4+hsWC6B/HiSnbjm?=
 =?us-ascii?Q?4Nqg2J0uaBgGLXPdxxWV1kpNRrvfC7S+gzVVs2G9jveCL2XpLN0HomYYuGB7?=
 =?us-ascii?Q?PPvAMnghaRXm7O83WzL2z00z0wZ+a0vwfJcu/YEWiHrLvBDHY9c8pOw1QbrV?=
 =?us-ascii?Q?f5vCxlCRqetynwvwTP+MQ5b7eHHRVus9uVN4x/7xGc3XsqzfhYBQhZUITapx?=
 =?us-ascii?Q?Lg1bnEGOQ7hTsDYgF2kcyNFWtJFwZhy+WkuPVMxO7m+ss0dx2Rtkb/t9eVLn?=
 =?us-ascii?Q?Kz4ko4qEJwywcrU0uIm9TITyb6AjgeXF36gzDha9EozXw75h0l6ayqhFRuGR?=
 =?us-ascii?Q?HabF2DeinQyEnb/Zsi2dDXvrIau9fMzyHV2ySsAFvMlrkpMSS+5uITK3JztL?=
 =?us-ascii?Q?VUeCGSZgGtAJ020bC+KovAhmndvfu1hIzV1Cc6SsVrp/OsGYox51on/amjhb?=
 =?us-ascii?Q?P6SWIWWNFeF2ybHqyDUfVd3ATuUKtrFqt5C8fX3949+ZML4UTESZjnfICvlF?=
 =?us-ascii?Q?Vz8B0+8kWgSBY4afLYRXOtFLAgvNZWPbuLo6YtxnJuKRyqcLxeE9y8EXEvEB?=
 =?us-ascii?Q?2+/B5GlQ4YD/MAZEYmiu2gWos9idywSH/Dz5zHKMC+Jq+imm5sPagJS9uPUO?=
 =?us-ascii?Q?D25w29516SjEh05kjzoiC8e3KSvL0BQ2PQozGzc48XeqCrWYAYKdJu9h+5g7?=
 =?us-ascii?Q?fFW/8GBL8lICOU629JXZoila8CTXGricO2d0GxUiYZWHDbojew0wIMtAEDRp?=
 =?us-ascii?Q?vkQZSZE7yKZJh5Yhegl047CfMEQK1ODElpLIE6MKU849cTl2V4uWlSWcDYuw?=
 =?us-ascii?Q?zsg1RMlok7XTPfPO+gDiawKwmmCdaUxNLJopISBfMgcdslgjwCltpPHqDfyI?=
 =?us-ascii?Q?hhaRAA31UqLP6BJL5Xtv7+vl0oJs+WK56pv9e95oC408/yIpdqIxoz1+DeDU?=
 =?us-ascii?Q?h+xyq1sowMNlQlrLC8XhD91UUkfuISXgr0ryijWmyVqRW5O+ZR6Gkuvi3N3k?=
 =?us-ascii?Q?hm26ljSLqo4AT2XBS/kDsmG9A8TPb9HdzLSt2GiM7OCXNZUjsDmrZsGznPnM?=
 =?us-ascii?Q?8tpiMCM9AycBUISCvSTYHGJCMvo2GoiTscXkEaLwE6NLTJEQYG2IGpj4HCK3?=
 =?us-ascii?Q?/I7zleENUNpl7BoMytwdfEcFbHsKwvm4LVWxvRHfYEOntBDHcrFkZAE4PY41?=
 =?us-ascii?Q?NGrkRateG5K2Tu0mhenviQp9RBGtdlyLpVTmANBcbhMkyfQ1KTRETVyAMZlC?=
 =?us-ascii?Q?5z5w21HsYEuZlIhYGaRqFHQPUaDZAzWmdRD7ajUiYfuepG4Gk1017nt6P9zR?=
 =?us-ascii?Q?n6ryQAzfqP/Au1+PGqQJNHaTl+f7nncs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kMgobJZJ207ef52iWp0iPR3Zdkd9wx/JbXmoktYIvC6ksSPnr2cwq6IUv8wJ?=
 =?us-ascii?Q?28l+CnkkFAUgJU4bXRW/y/YKQoZqXZUiTyv6TcaZjGi+/uPezN1YMwPB8m0I?=
 =?us-ascii?Q?HlKOn2HBfhvqak8VSv97yiYwBJjUQQGRxEWoiasGAcZndXSDIcwAf/WR54D8?=
 =?us-ascii?Q?YVmbO1s45d/idA6sx+03mkXr5Dhy375NUMY1NxDipAzawV0xVFEqfT9NdJSO?=
 =?us-ascii?Q?/j3jL9x6k8lUVgJLtsSrIohlzNte7/HgZw4yJEyo3l+NkjrNN5+cDXmI3cub?=
 =?us-ascii?Q?fNxoY+a6R37UidtVcKXXt1PrxkAHBFl0s+KD4KURBqM9X6+dnImOmHTdSMMX?=
 =?us-ascii?Q?naWx+Wfby2n4CN9F5F7bcwZ0n0L2G+aDGNytiHTnE+U17joJ7WdtHKa5vfGf?=
 =?us-ascii?Q?sRNQAMSeJJnyHN44b+3zPfgonj708B0W0Ly7TlYtvG9ywHFaVSqgWcvc18I2?=
 =?us-ascii?Q?SPP/hezQIeSNyeAl1WHq7b/E9pgLITtS36hQ/mtg8VlCjGKz6diEuoL31xmX?=
 =?us-ascii?Q?2wTT8u4bC/xFzOwKc03wKWDg/vgMJmanyPRUA+TQm+i5Smra7NU+nlpF/XFR?=
 =?us-ascii?Q?c4pUWeW87vv+aTIms0sUYgHJ/hpS8hNl+VCeBsKyu/VzOONHEc+KjGmpXe6v?=
 =?us-ascii?Q?pytVGFzdEL14GJVC9Fzex65Cm/5qggRpu7nZuSw75WczLXHsCARwSi7tRmgs?=
 =?us-ascii?Q?XKLSaJKC3i/JLKXo3QHKdwG0UDtg2Doq3qp5Zmxe6YLZviHVSdLroCi0i4O5?=
 =?us-ascii?Q?zUkGFKDMLgTiJXXVwMzNPaaqPboQCfqBywUuW1SYpLT3Uz2nm0IM7X1bw42x?=
 =?us-ascii?Q?+TgtHRDb3hcXluEApr+Jf+Sy1C2fymjou7vXt/c38JEI5rb+q/x7nM+duvlN?=
 =?us-ascii?Q?/nH3T4UiuhmWfBg9VdfUOxGHbfPTWObn0FrpNjgLNw0QWtXePIImBjFSbgCS?=
 =?us-ascii?Q?B+sCq0g1/J1WtX46zEownG7UXJ+oJGdl7RB9UZpVPCY0J/bmEM5iYEHogi6U?=
 =?us-ascii?Q?sO9XdnKlTV2U+iO3/oVncydo+lYF3s9ZSSG0bQVKfElGi3GYoxBtwGxj9NUf?=
 =?us-ascii?Q?TgppyrSezz3I9DUVjRwdWXIqdkbcoao6471BdOaXJ5kvJit+XucgGKtQqnsb?=
 =?us-ascii?Q?wMG4d/KWZK0UMo90eKirnuXO/Qipt8JCY8eSdaFKPk1rfp0iMkOF+Slwyg5k?=
 =?us-ascii?Q?ErdK6CYmNOXgNCd0XUFfAKmR1ORU8McLmNTaiYMrHpisj4eON59byib0YwMv?=
 =?us-ascii?Q?p7/wTd5Zzr9+5W+CEe1wlAvJ2iZHF/dpe7nDKYjVrvN96kGouZDl+TQIAljV?=
 =?us-ascii?Q?KlsCoqVAP6qcFYpv1mqNfgGIYR58XCpkiT7nRWe4dXhkwzDse0cUODTpY/m3?=
 =?us-ascii?Q?U86SnCS+HBqpEiUrb5E6sinKVrmF2YIY5ZeCBtLVhvc9BJWmqLyKK8Vw/jNQ?=
 =?us-ascii?Q?03ZcxpPMtaRFyskofzgSdLM94daOED4iKu1fPGLzX8RaHFZy1hMc32uJVXwm?=
 =?us-ascii?Q?aAonuH/KLf/0CO1CpWSO7jFk4GdggMuVkDVsclJLU+cwDm/J8MaT/dVtZaa7?=
 =?us-ascii?Q?FL0LNBT8hTMi58/fjjE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 474cf44b-b21a-4999-5794-08dd4fc18459
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 02:11:12.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qofE4Att7zGmmcILiRztf6NV5Rek38BPBqVK5si0HlzSrrfhbd8dUjPtf9UfAGQiOt5HcTg7fYa4tUIIrtskYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10495

> > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 6a6fc819dfde..f7bc2fc33a76 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -372,13 +372,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  dma_err:
> >  	dev_err(tx_ring->dev, "DMA map error");
> >
> > -	do {
> > +	while (count--) {
> >  		tx_swbd =3D &tx_ring->tx_swbd[i];
> >  		enetc_free_tx_frame(tx_ring, tx_swbd);
> >  		if (i =3D=3D 0)
> >  			i =3D tx_ring->bd_count;
> >  		i--;
> > -	} while (count--);
> > +	};
>=20
> In enetc_lso_hw_offload() this is fixed by --count instead of changing
> to while and count--, maybe follow this scheme, or event better call
> helper function to fix in one place.

The situation is slightly different in enetc_map_tx_buffs(), the count
may be 0 when the error occurs. But in enetc_lso_hw_offload(), the
count will not be 0 when the error occurs.

>=20
> The same problem is probably in enetc_map_tx_tso_buffs().
>=20

I think there is no such problem in enetc_map_tx_tso_buffs(),
because the index 'i' has been increased before the error occurs,
but the count is not increased, so the actual 'count' is count + 1.


