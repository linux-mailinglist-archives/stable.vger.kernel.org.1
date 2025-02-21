Return-Path: <stable+bounces-118560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107BA3F021
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D490A701508
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1589201017;
	Fri, 21 Feb 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4vbagJx"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB28200BBF;
	Fri, 21 Feb 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129759; cv=fail; b=TXU+GNFHDCdqGJLbai3FRhvjDyCao/16nJjKQBx7YBO4MSmr8yddpNuRF7/J9WlzPN3WEX3C+MHdkey7xmID+QKsbWQcunjI/pN5sDIg5vdpMwyy9bmJyd9K8v9FCtjMzphyul1NAshOTmNze7Nst2MH3EsvyFTRMz4cWNRIW0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129759; c=relaxed/simple;
	bh=0r/xeRBuHTF1/L8g1xGtBwZKfEvG28aCm6Q2Pgwgc3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msp0sUtFKN0YxsO7A/6dRtdOPs0nEuDWOIxrgvHRVgobvagaQAzvkxgnNw3Dm0Af6hpUpfMCV6mxDMX90/jh2LkgDLCQbZg7C1qASicVU9/KJZdnPIKoZic6zDBwoCJbg3+zKEcYDi7J4r7Dhqe/qlKjJVU0WG0wc2T/xyrycgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4vbagJx; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9+ReYcbofuM3hTUzdhk2DDAdh851+yZKnWKHkFDox9j72WwT4qcPnnPEJxkmbMiD4ZTejFdqGz/jUbwUD9yvuDfw3eJzMwRy7tfZ1j4g7MWtOE20tmZoUosNte1HX363e5IHhQZgVnYJV8Z/UsDqSI046SkD/FHG+IfT984v4a5D0wDAZs9Lp00PW18zToWSxorVWJZ8EnXvBa/xl3YhtT8r502hSGnQYa4WLQ0GIBJwbNKq5bCDpE+rgXadqZz3xtQBuSHJXBfH/Uy3cuUIK+WVQABo3NLwZIOSEdEguStGSKEGw/tA924vKZAnaDz92AbqKsiz+81cTFuB2XdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r/xeRBuHTF1/L8g1xGtBwZKfEvG28aCm6Q2Pgwgc3I=;
 b=YRj8qzeDo4CtpDVvSn4OLENJPdTlr7mo0aEIoK5j9FRjyyIJY9m9SNJS4mtbdP8GFLTOGDkW1qitwg39utzO86h33umomR4e0yDNJe3V1weZEGHilTMHTp9Jn72ZHlv6x28tKcykiLWhOfmnLgC/W8QWJOG+I1O7tEFjKxZlxSFNnmFRO5t3aHVSTH7h2aw+T1UfAAgc5OL8jCn40wzeShmNNsjSzs+yvNB85Hs8Y656t3Wh/Gx43M8cmt/9E4TuIgh6dQYqsvWIdXc9c+eL2e0yPeehnCCX3K89AGWEBMRccO3ZBn2UhsrSzi8LZoXY9m9Px8bqMwLsSsxFDELSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r/xeRBuHTF1/L8g1xGtBwZKfEvG28aCm6Q2Pgwgc3I=;
 b=W4vbagJxOtfPjS4fHBOrwy2nCK164GncNtBF1zSzphTZkp4AJ3Dk5d29uH1pWUaqjpEK5JjK7mwGNqS8Edd1bwDCZQMUUxYIJt13c+ueLZFbpzfiaubMUPO+3tem27yNXl7cLa9iKc8rLTB12PSZoAXLKgqycA81kdloHNrkXaezgL57ZmrbfA7EM+N5ztNseumAipCvGa0+kc4CEwPvO6AkPG/CcTCzxwuGxCYb+Alj0KkWCqeadu/+zIuhAOV3VhgRUD2n+UMo8oRH6rUMX8t+NE1xBwYVunw51K54FkwOLc+26llkIRkR2OQFEvvWzcicvMuCFZeMWVdiNKbmLg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by PA4PR04MB7662.eurprd04.prod.outlook.com (2603:10a6:102:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 09:22:34 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Fri, 21 Feb 2025
 09:22:34 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Topic: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Index: AQHbgpN/wLtM4lMuwkuGi4ZYC/hIXbNQXDmAgACiP4CAAGZqcIAADMYAgAAJXMA=
Date: Fri, 21 Feb 2025 09:22:34 +0000
Message-ID:
 <AS8PR04MB8849177C48CD9D04641D777596C72@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB88497C415FE73CCA84843CAC96C72@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB8510ECBBA69BD5E50DB1C03088C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510ECBBA69BD5E50DB1C03088C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|PA4PR04MB7662:EE_
x-ms-office365-filtering-correlation-id: ca08bd1d-a6fb-4dcc-9680-08dd5259469a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KTm1run0iEWGAgmP1AUratyaW3ozqgLfJu/9KlxCSX9/9jd2Z52Q0c+V3iXN?=
 =?us-ascii?Q?GVVuwwhvRi8Dn5KwpyPLVCglvkfuJynIeRDJwfSirmH86qJov2+ivtORts0d?=
 =?us-ascii?Q?+gZrSpKih1ivwDJSjRWyWuXBSA07K3JlF5itB6g85hLwyPq2/Y1CVOOxZ5Tn?=
 =?us-ascii?Q?v3HjBzP+09RG+yflOu65EDuZq5sMBGQg6jbenk2r0MYs1V7zChaccmbkaw/y?=
 =?us-ascii?Q?Jdgw9HaDNJHDRcaB4UUIC2Gku3xdzpcisF/2X+9jv0X3h2gCwE4hiO9OUTU5?=
 =?us-ascii?Q?aKQWOutBGWf5Z0fBSjkyvWYUtrclB6zIaMlF4me+NulJre9D+/OnYrFSx3sq?=
 =?us-ascii?Q?Zw7JimertqItXtJOkJ8zT5EOITUH82+4Lb7inv8BIgodXxPG5v/YvCPZml/s?=
 =?us-ascii?Q?aA+ZxIKPSoCSXjWRjmgiwa4Zio5SfeCfDcYov7BdKSApBaH/HwyrbYf/N4BF?=
 =?us-ascii?Q?/98jfIumJRVwRGzO6JBu4vvCx2Rd82KDsxb5Y+neY6wjyX4uJeMq/Z8WhmvE?=
 =?us-ascii?Q?yTNOT+tTtB41D+C9p/E3CK1mxiZ35JBSh+6IFPtD4++YU9OaUVF2c3ekoW8q?=
 =?us-ascii?Q?KUwVBCwoPSgdMtClZdosdAkcdoeNblAznCG2E2V6mrJL/U8qd4BpaCiVdgTQ?=
 =?us-ascii?Q?YfduLgo4+2X3W+mUe9DWPViAqL6Ow/nlv3GDxv/nhEpPrqCro2C0siP4YfQy?=
 =?us-ascii?Q?UsvqfpfQauoZDUJV3pzLfkeAPMOUOLsByfk8NixaByMwFVub5wT2kxyyuV6/?=
 =?us-ascii?Q?L9Uv93kBnW0KrHBRsNBovX2QD5/UhnLgTfXLNAkgmptfO2IilqzT+41ZLszR?=
 =?us-ascii?Q?KApQQQJ2hblkRMreiRJqbIXrWP/cCJJ0mPUW9qjUdp+9BiBTwMn815f1YDk7?=
 =?us-ascii?Q?+mN31IMEUvi0Vcf1PhpuP/sepwrV9/n1r4XLAHcGiEtzP1B1gCTt4/PLwk6N?=
 =?us-ascii?Q?cKCcAUfHwaIvVrL6ity9jVFZH+kub2dIYIbhxVmHACvNKOk0sol25u9x2Tal?=
 =?us-ascii?Q?K7z4sUK63zkiea0ULct49xwpHJmVX68nzWICD8f/Livi4RZE0x3HsZNfgaWo?=
 =?us-ascii?Q?6R+4XcXkThaUSxSS2pGzQeKjxsTwHC91gGX5J6pstdIBQVeKtGaPwxtI1dWx?=
 =?us-ascii?Q?lK6xN2OBoZICJ6axQqzeKHCDCUEkAWHYUfXqlPZTFX5zRZpknCCevSKmqKT4?=
 =?us-ascii?Q?XVulYpZPxT+atxUoLnUyvGdPkXhSyuOlgHgAEKo24L9lY21mxW/a4KwlPLCk?=
 =?us-ascii?Q?zLCTyR7KeXfLdgwn7ZWu9b9nZlVVzbMAac3Cix+KD+YYushUnaSHcC6PBt4z?=
 =?us-ascii?Q?GRtlcHYhd7mNxclhtospIzCev66uFTAhpxqc0MfuWWSuMUgzZUa8ph6fUllW?=
 =?us-ascii?Q?4iN3CPV9nJggghvExUTSxLdBPg/+NxB3Zm6iF8e2JwbmZzCoOSu/smOV70qK?=
 =?us-ascii?Q?yWiqYJyrvPP6edkWX2AMT3s13nxuGuET?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ig8YFzAU0poNimtjZ+dN23Mr+TIo5hfntsXpUK7jL9bphfXx2RDGdwrGeozL?=
 =?us-ascii?Q?gegY7Y+5vIzmD15Hdci5alHKRHE3ciFJhGctxq00TfofYRCJuA4cVu4RgWac?=
 =?us-ascii?Q?eJMg6MAlUpLtBek/yrV2cMCuaZJBamkKDICSR/HNfu9ZPnEYaQFe0/fEYoTS?=
 =?us-ascii?Q?wmFAKW1H7eKv8S9cWir3RDMub4KZDTL7warRitr3HLDT6DwmsCWZekvpb6bw?=
 =?us-ascii?Q?7QVXOpGBcBBdwRzjcCodU9Qips8eUFtXeiSw/GwTC9Hioazp2FNVJCBSfsDw?=
 =?us-ascii?Q?Wnjeht8zygZbXZ3fXBG8KTzul0y6fV1WAPdgzlw+vrD7wwR631sPNcmr57e9?=
 =?us-ascii?Q?oL5UHzlLmuZuV3nrPHGdkV6I2XK+pO8PCw4DinFONjMOIg6FxCUMHY0amIz6?=
 =?us-ascii?Q?msVKdEzCGwh9UOfRBpLZ6ZZychvJRoyyv7YoXBWZj7oirox505/u+QfyDK6e?=
 =?us-ascii?Q?7xeA9nUGWHMZN/4FiL4Mi3A0wkTQiAr/XvCnLX01pGD0Zaz5QXsq+WCbOuRq?=
 =?us-ascii?Q?0O6gVaUTlZwmsmUaIGV4mhZDfh9/MbAGUo7CK7ZfOG2ZbzCfstmveGCUvEeZ?=
 =?us-ascii?Q?Ln+sAtpLtPlLaMJYlUA+20LDR9pmYdHwYNefxD84S20w2SagL9r2JRCQbCcH?=
 =?us-ascii?Q?k3NsVqfZvQp8RrZbvOnR5Hy9gAg4GuwrqNT5y3GlINQGYzhvtFiz/4rnJGdI?=
 =?us-ascii?Q?tkXH6aHqr0szG+XdZkgfP1CuI3o8qJN/TssZOhr59JTcELRrQ20iBtbRaYij?=
 =?us-ascii?Q?cDN9SOr7o6OY8GSDTL/lQ1lM6faBcmbXVXRn4L9BUXvnkVWc68humAZAkH/q?=
 =?us-ascii?Q?d4JEF5GRiIT9v6T2kTxJFduX7sbDI5L9sV1Es4L2HfXmN8xZMtAhBawR0ZKQ?=
 =?us-ascii?Q?mxn/UZGeJ9oqMdKbyr0UNUF0JkuwTAK5bOPcKjwnrbTDz6jLvXxWDYDYr/B+?=
 =?us-ascii?Q?PXRFLQkLK3KVZavjrniXBFc8d866iWQPSpSY3Hvb9+0BVW+UWAwCpeEX+5ju?=
 =?us-ascii?Q?p13YrL7ZrR6lvvWVDvAaasyiUDCV0lQla8Xyi6jc8KfcHOAbv3mAofEo0UTt?=
 =?us-ascii?Q?H5uFHVI1PHQ+t6q3SRICG9Avk0Wc6ttRA876ecUoD3y5e7OI63J5GC+vMXy7?=
 =?us-ascii?Q?C6QFE5o2pDNKG2QffIzdwXJhKd44OMWECvm/FnJFbpK/v7JBF6OlNzxA1R6P?=
 =?us-ascii?Q?qrGhvwxK72GomyN3R8YlTLfbRNTkzepNjWhD9rd1YsYpIZu3H/Jnni1ynS/7?=
 =?us-ascii?Q?kiU1QuW2tWGlsGLzSgEaVhxbC5HLIWHYjht2a7Okvzqve0Odc20IxGDtkZFP?=
 =?us-ascii?Q?b9CAwqaYDrkdg867DR92RBozRAg2FcFFRRyk7XUXrMz2J8lc3KyGgibxyS3X?=
 =?us-ascii?Q?WvjRbe+x/UfPRpWillZNt9Vtq0OKSzjEIl2mRoxNMIaNUNorUpkcFzifI9+3?=
 =?us-ascii?Q?Y4agle76Cjx5wI3r4jwCkIQi28huXmX5cExOsXY1IxartsHLcCNbPJPVPooa?=
 =?us-ascii?Q?g/ns1Plf191VQIpVrKNsWTSrMkXOu9S1xHsW5aI8aFdqxAI9yGhmTpl8zs/T?=
 =?us-ascii?Q?bFIzybgazXGApwEwwrc4C1/B7IBggsl3iYLswVm9?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca08bd1d-a6fb-4dcc-9680-08dd5259469a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 09:22:34.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lq6XNFoWvc5KyrODnosDuVikiK3jomImSLh9gWQruI2l7cwoBaAJA0pD2ZncEXBMF6giyBdKEj78UHoRYoQwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7662

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, February 21, 2025 10:34 AM
[...]
> Subject: RE: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistic=
s
>=20
> > > > I'm not sure "correct the statistics" is the best way to describe t=
his
> > > > change. Maybe "keep track of correct TXBD count in
> > > > enetc_map_tx_tso_buffs()"?
> > >
> > > Hi Vladimir,
> > >
> > > Inspired by Michal, I think we don't need to keep the count variable,
> because
> > > we already have index "i", we just need to record the value of the in=
itial i at
> > the
> > > beginning. So I plan to do this optimization on the net-next tree in =
the
> future.
> > > So I don't think it is necessary to modify enetc_map_tx_tso_hdr().
> > >
> >
> > And what if 'i' wraps around at least one time and becomes greater than=
 the
> > initial 'i'? Instead of 'count' you would have to record the number of =
wraps.
>=20
> I think this situation will not happen, because when calling
> enetc_map_tx_tso_buffs()/enetc_map_tx_buffs()/enetc_lso_hw_offload(),
> we always check whether the current free BDs are enough. The number of
> free BDs is always <=3D bdr->bd_count, in the case you mentioned, the fra=
me
> will occupy more BDs than bdr->bd_count.
>=20

Ok, let's see the net-next patches and discuss then.

