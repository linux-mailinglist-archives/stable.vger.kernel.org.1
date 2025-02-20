Return-Path: <stable+bounces-118373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593ACA3D0A1
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A158E7A8CB5
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902BC1E2823;
	Thu, 20 Feb 2025 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aUqrAG2Y"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1898919007D;
	Thu, 20 Feb 2025 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740028013; cv=fail; b=SmQDGIj8QUyUiYZvoDoLTwpBQGBJ30zr6s6cxtWdxDjKFPEroqMysujYqS0tDslriMQ/cpIWCuyGRhmkZS21HCFgkP3QmiDKEbBFB10wcKrX1doKbPnEhiU9FU3OIYxya4XbZVq6z5ereEmoe8ME/QcTkODPnNOXCjJnPsTGM8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740028013; c=relaxed/simple;
	bh=qIb7vCV5MbatAnF8fCAgh0vjbxBfpb2lQo0ivcZkKLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+BGB4dc2w7ybGrT3uzeD29XC8slrIemlok4NjjTenxbR5Dj+WXjsHJ43eLmwQBT7qqewuO5MBOkpIzDVPX+X+xtRS8ISDdT+f3vstjGmTjLEfNy1SB8bmV3b/fM//CaAjOLd91kZJY2+T1r0BtWyFzRLCUq6q/dFPpYLdIg1rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aUqrAG2Y; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9zXXP2CElOgdjC/xHjzo/xgvL8TDKQPUkI7qaWYa4zEfCor/8g4P8Me57DCCX0rK4VzYHTAHlGtEeb+6PeGs9rG8aHYsgifhdHgnnYh6aOwErr/qyLXevy8iclx5TTgTMhflsRF2LBBsHj1FZlWgJibKnLbqdg1vtHzfxX7hTGU4Lzqlb7rxvyJHTd3LB+dSJdlEhhkX7qWsRGj3tKqgE5ImYdKsgC55+PyY00gm1zfNkKlpfeyXLbeXg5udkWZpH2xT6PxIZ0CQeOwOWIsPs2A8hw7M2p3VC+ArTYax8QeGz2Hd4Vj5PM5Nt+QU9aTd8ou3hDzfW9Hvemfoe1wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbsUFkK1kcdhpA/5zyW3NNFJc6lULpIYiUta6EKClNQ=;
 b=e7/GIHWEMywaxLJyJpTW7lUIRU3jrV+kUx3OdWcSZs/HSjpwCUfDoicdSHEC66dLDj8+JIRaXMJ2h0WQeTLSB+5hP9YqkiyB32pGAHUOrcXuyCdcuCd3zGPraRcCvKs8v1CZOQBwKXaPeVXv9jjxhO4T14S7dr0rXGPV0DgbKat7dnosinvz6RYyyVYt6O80i7+2vq7jUFZpYQ7gYZelFfNmiHyU98FR+jUBFHQGv/sDQvm8oYvPUYswSKmwqjQpjCAxmG16kq41IwgSIhkjqRT/uL9WpiHJEqL/Fo1E3e8Wn8NUislS9mS+ql1ghQeXiRCLt5t62q1samxqEPu5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbsUFkK1kcdhpA/5zyW3NNFJc6lULpIYiUta6EKClNQ=;
 b=aUqrAG2YmY6Et1cLRMh0UIiUP2mvOPqca826ybgemIj/7GvgV4Ri+qaJRUfZXrbxZQM6dyXWAa+hyU4ePNgbBYm93/AHGS8AVq2KiGYx/vCOROF6KmIKBUTbwGuG9K+JwbFYKcXDZOddMqWAefNXGkv/+VUjELklZcMohIqBKXx5hlxUBEK4/Df2ZoYVgw95tLEqXGuklBkUqaWOs04Zr24lGrCUMUHLSzE1nZaKf6wuuf2GmhHMTz3NuHn/Rb2T0lQe9xqtJsvUKyoFtxSwyQrhSsQk2Y9PRuBe3nca/Ns0lPEAujC+MMmaLgpUFnzwM9tCbE9B8ueHgEc527Ci3A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10826.eurprd04.prod.outlook.com (2603:10a6:150:226::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 20 Feb
 2025 05:06:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Thu, 20 Feb 2025
 05:06:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Index: AQHbgpOTkcGlUe2F8Uqdee5IlYnyh7NO502AgAC9p2A=
Date: Thu, 20 Feb 2025 05:06:46 +0000
Message-ID:
 <PAXPR04MB85106BF748386C843FE28C6488C42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <AS8PR04MB8849C3544A63C75E37D2079896C52@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8849C3544A63C75E37D2079896C52@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10826:EE_
x-ms-office365-filtering-correlation-id: 04655384-733b-4158-e8d4-08dd516c5fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P0F5elpgwxqYRiOJXIh7wQdAOVrpNu8BdlZm8EHucez5WlXVEkS82uj3sIPc?=
 =?us-ascii?Q?THWhLyc63wfaWJTf9xhxcmtsD0RZSuPRjSdgPDpndExwk3T4xivtX3WMUFZy?=
 =?us-ascii?Q?u6VKACRGyk17BizMNTpvJZYl4yEXx9BNXgRFcHyeuwqzlj+bD79ca0YE4CfE?=
 =?us-ascii?Q?wWGX3vksoIl5nKn04eabbmMPllVzlPiiYbo/EB/561YX2+7Um9MJSwayzy/R?=
 =?us-ascii?Q?/eJRhe0uB7HzS76BXKjbFz8l5QEj9YA5krka4rzi0YHfRDHPV+Ra1uEOW/dc?=
 =?us-ascii?Q?wbk/J27jrYX1QkBPXlxEEeiOfGCFY3gEXzEqAb+b5qoXwnyzonvDhWx4KuUI?=
 =?us-ascii?Q?MTdPlLlpLzo74cs5gLhsmry2mOiqqhkjgdr8m2j+GBCUdzamdYfEVdLJGA7D?=
 =?us-ascii?Q?oJU0Cp/N96R86agpBLYxZnwynvQZEFPLdhF9Yal+gxBF+jeHviQwRzQQs50V?=
 =?us-ascii?Q?QXp6SEHzWEaycH7BO/u8oTJaBXIBoAZECpHyTL3XKe0S5JaeSlAFs3ByI7Mt?=
 =?us-ascii?Q?V6k8FyNjsP+Yz//HEN90uZ9WxylK2rE6sMo5RFSPPRhkNYjlvUnwuEAW3VtK?=
 =?us-ascii?Q?FZk+z/bT0mvAXH9lyx+HLFHx0e8h+ezumrxcmRqZJkI1uZxNkkWBicDR2zJr?=
 =?us-ascii?Q?hEZu80MXaCz77oEXEihpgNqp+bHDQbqxL59x2f2Uc04qn8Pyeq8eYqUkZB9e?=
 =?us-ascii?Q?P4j56u3qiNY7b6yvUewVNN5Zx/LpBn2ARjvB1tqgN1ampJKfkSvjeSMtmyIz?=
 =?us-ascii?Q?CdGflJVJB+cbXcqcDhFVQ/vYSqvXB2MhI7/bSf5Pc2LmneoHtAZxIMtw1hXK?=
 =?us-ascii?Q?Z1FtY84IcIowpHgDBqARRbANC6sRwpfWmcvHCvjQssHrz3KyyhNUW9EhWpB0?=
 =?us-ascii?Q?/1bR0xi0KkHHYmJDdFw4Btlm3zyPKvEyrVEWhs0MJ3ZLVhrWoRxLsDfMOgAV?=
 =?us-ascii?Q?Wc9nHX5b0TXfgaTeq3bv6l+5wsC3WGIretn2VCt51esIp8c5QUwovAeW0bWY?=
 =?us-ascii?Q?MM9v1rIC/sHQcd8gZ8aaOWrnvmQUD6WJmMT1nAddrFzAi11Rr0kls5z8v3mc?=
 =?us-ascii?Q?8Dsj/UvQTUm7KNYAvOQrXS/3FV/UIHBmexYzQNvtuaBZGD8wTp8+2K+hY0zk?=
 =?us-ascii?Q?V5t9IHZct3OcVnhpA/C8LrGDkD6QMB2a1Qavdqyos084wAAGAGOlWajtkvrQ?=
 =?us-ascii?Q?nu1F+0N4eI5MG5tUp3zfr0tjU9cPNUYxP6iSJ+DI9+KLQr+dgUKF/xC5xEAc?=
 =?us-ascii?Q?mG+dCwZJvjYsH7NTELXLwS4in6V/U6AFnpgqBvCdTcjvcDH1Uzgg5pKnaMDb?=
 =?us-ascii?Q?pbvNEWTPqxzdZh+82VwKr5sBKKjlB8vrIP/u53L9hToyeXt2CrK8jxgYpTu5?=
 =?us-ascii?Q?IIPD06irWscaixE9rrQlPZ2GbQM1b8MHcDCIETXCKnEbMFD3F5x0ovpdCL75?=
 =?us-ascii?Q?TsrsHBVBLRxooI6kznHf4ubjnN025F8p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6fSEPtAfRTGrNXNLvabS7cp7vku45wKUnbMzRIyqaXiUh+2a71yPaltEM11P?=
 =?us-ascii?Q?XrA16w9oQgGYlPrvrcmBCKgxS13qeuB+OkTbD6/dZ/fTEDn16Lz0RRdswwry?=
 =?us-ascii?Q?TO1UX0ZIM0i9uJ7A8iRVzMVudwQlE8g7f9jspzc8wVDzhPCaLGFwaq9xeB8S?=
 =?us-ascii?Q?134Z7IqTi/FRePe0B5r1+2qU60+uFAnb5nFJuDjqikv0xmnxiD/8P/mFjXnf?=
 =?us-ascii?Q?Tm5NRnRntQZMdiHcl5Ec0WwWMrP1dokW2aWX7nN/SKIKVPK1vdx+of8G8auY?=
 =?us-ascii?Q?ySsiKjaXu8AgHlyoGeQdkoTn80oxE7QDPoTjRGhYgeYOmFZnGYu+r4NMHOmT?=
 =?us-ascii?Q?lHB/ZSYoyNQT5QEm4JUf7R5aZvCeeTCmeeg8xcigrTj53pI1wGrbqSlCmZIH?=
 =?us-ascii?Q?GpLDHxj0idqXUN2onxThuaDAuvntvCRzQJn3CrEBOU++d0PWFP+PuHo5Yu4A?=
 =?us-ascii?Q?etjg+Xlp8x0sZXhZmAmAcu711UYO0dGOF5N9ShQfmW6eUsmiZcY/G8jTkK3A?=
 =?us-ascii?Q?geiCN4Dvut3BB62iKdyfxcUw6CcUUE8/MQoLse+jchxvmO5gYvChcjMhOs0h?=
 =?us-ascii?Q?BDqVoqrvAyvi3o9gdDxHV2YwuaDxT1GyFmjoNTKI/RZJpHP5BG8v+7sVgEhi?=
 =?us-ascii?Q?Pb9jSjV+kjPyV5SoMa6NBm/NUZL7oBdnngCwMiLW9nw9V+kz/1sb3fTYn/69?=
 =?us-ascii?Q?nGDHp12tcDopgnzhs6RNx70REUmTlg8nF7xRseaJRtGlaS8By6R1rFH6TVKO?=
 =?us-ascii?Q?zNDrokuMvJnV9qZ/kh/Toj6Ek5uA8Lw5RRDtglubLRw4amWomRbUzAyj7cVX?=
 =?us-ascii?Q?8S2enV4ECcCbHjRntd9XDSqeNYaq6/VMrJwcA6kGWfT/TO/WO1JeX3ZtEHy4?=
 =?us-ascii?Q?kUktBqiZj34TtHTmozATc4OO/PPPqOLNeClNDJLjP2yvRIwlVxs0S7b9VGmZ?=
 =?us-ascii?Q?DkNc39r5PQHQgdHaboa2lE03ZWSUlMn/UyFV44S15fRo/CDNJR/AYNWIFKNk?=
 =?us-ascii?Q?WFjGtoG/G9KwUnacQzRtvIuggznMZNDRhbxcOG05c4JTKDtV1aAmdhYa8ZOm?=
 =?us-ascii?Q?fjkNRROdY7iVwbEXEkz+hjRlzEtYwhjQTV0Erzhv7mCpVCo7Uz+oZEGC2BYc?=
 =?us-ascii?Q?nn7axZzccl9W7r9YMNdgwGm9VsEoxMP7DGVaZBEgGMAVvS4e6lpn9QJZe3gt?=
 =?us-ascii?Q?74aSv7qsDnFoTCpthsl9FLEo+2rCru9caGbXbLp4Vm4Lv1N8Lp1shmkA6E73?=
 =?us-ascii?Q?n0pBuBoFycfqYvK4DkaNZ3tPmfeR47kA69LRZWmXm043YMyBEnlZvN4JV8As?=
 =?us-ascii?Q?vlBRkOBbqnWJn0ZSM1Am0zbm7QZuI6lZIDufIofbcdsZihalJDMoWIIeInrY?=
 =?us-ascii?Q?xKqX70Uer1IeznkMRAaUqfwRqfhWSmKFVaoX6zw684PtGohSwPsxjilW4mxN?=
 =?us-ascii?Q?W1NUeIRv5uL6vD3Qj0y0CbR27//DGs4L0JjKp0YBuZ8Etojr4FLP2U/1q1w1?=
 =?us-ascii?Q?G2j4BfwSnYBzQVJlXoMEjfL3RHliws44lFSDuqfGpHXCz+ZheGd5O1gZXtGK?=
 =?us-ascii?Q?XnmNCyIu3NU1zFEUAkg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04655384-733b-4158-e8d4-08dd516c5fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:06:46.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1bJoA+qPgGoNbnRV8prd/tH01Cwb8QrLvgYgMhA7GfMjOZMoHxorbbH1hZI2wUrG5UcwS5fXkwgQcCRbvfy9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10826

> > -----Original Message-----
> > From: Wei Fang <wei.fang@nxp.com>
> > Sent: Wednesday, February 19, 2025 7:43 AM
> [...]
> > Subject: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
> > enetc_map_tx_tso_buffs()
> >
> > There is an off-by-one issue for the err_chained_bd path, it will free
> > one more tx_swbd than expected. But there is no such issue for the
> > err_map_data path. To fix this off-by-one issue and make the two error
> > handling consistent, the loop condition of error handling is modified
> > and the 'count++' operation is moved before enetc_map_tx_tso_data().
> >
> > Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 9a24d1176479..fe3967268a19 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb
> >  			txbd =3D ENETC_TXBD(*tx_ring, i);
> >  			tx_swbd =3D &tx_ring->tx_swbd[i];
> >  			prefetchw(txbd);
> > +			count++;
> >
> >  			/* Compute the checksum over this segment of data and
> >  			 * add it to the csum already computed (over the L4
> > @@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb
> >  				goto err_map_data;
> >
> >  			data_len -=3D size;
> > -			count++;
>=20
> Hi Wei,
>=20
> My issue is that:
> enetc_map_tx_tso_hdr() not only updates the current tx_swbd (so 1 count++
> needed), but in case of extension flag it advances 'tx_swbd' and 'i' with
> another
> position so and extra 'count++' would be needed in that case.
>=20

I think the patch 2 (net: enetc: correct the tx_swbd statistics) is to reso=
lve
your issue.


