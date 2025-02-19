Return-Path: <stable+bounces-118240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42818A3BC05
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 11:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB651777C6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853B1DE2B5;
	Wed, 19 Feb 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AoHQ1jSL"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932F146593;
	Wed, 19 Feb 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962138; cv=fail; b=W0zDgCbTJzlJnauSQj92W0nYwZTVoZpYbbbG12vJbecUNs+zybWZjTgQ6L5gEWE6dCbcQ5B3OZCQPbA6xZDMWoqWYYYt2L9vCqxeICpSRCRu4uxhKH1E66bFaeiQH4eOyQEceV+quBmDhCOLMLeVRzc8bWIm3WlYwgWnOk+ByNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962138; c=relaxed/simple;
	bh=aukH7N2j3WH4GAOKsHBrKxqruQ5xUGnA6058ffTvWPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlPr+Cd0lwsmByqt1N7TooseP+VhGYLSByeCRi2A91wMDRKYUAR6QTmT4EPOsUNtTtx+/fVnsesd+Dk5VIyCXcPbc6mdCXl0Q3XjhDDSlP/1bkUtiatPRz1oJyPanJYGiT9fsFrKX/NL42BwaZCtOEk0ZDGsIYE8cEPaefB7oPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AoHQ1jSL; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0B604cXgzy8XXcDHapHASgiPubjYMZU7IP+hX10RPAKOQIZiMdURMvu3jsIYY2cTO/1VQ0xxRYQDvgeN2C464x8WNu2/JFKrNDFXs/Tk6yEe1rbiyw/TBPnSDOyEp3jPuNyI1iwjSmbpy+5oaFfXyObScqILi7KlkWEUNazni7IUkXAlA3qC1MDz3H4jsLhy2qhhzxK1X+FY9Etz3c/cexAxRc36hxxBr//IrBMMzPr14P0/KLhGbBRC4r/D9/LYE6wGVhH2nLJk+Un5thnSUeEfXVYIzZarchAfJcdJpUzgu15klsnARTp/Bbo1B9n/1cbI263NgDENgJD/dco4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aukH7N2j3WH4GAOKsHBrKxqruQ5xUGnA6058ffTvWPc=;
 b=e+LgTur0/Uubl6kEXG1HXeyJTUJgVxAOdX1qsA1NCmg8R27UKtAMvwJlx4uKaQsslzZ0cUggbC8XeezABHqToI0vnOi9CLGlYncACIDB1e5qZCFgrzrOh/V69KEhAgtOnp2nT8INYOhUCBfG0unWwtYwdTloYTf72vXU2P7koW39VgbhaVOUINLeYWwqzIoHv73DJ0jeuBsBFrzOx4OMJC65vEyNNwB7vtI03F+/J9hHXrQpGZTAcj9U6XZyrFDwStKmQEX0XufDAr6Q5SQJT4MmQEeaKyP11iWDfli3gFmr7ZdHd68pLuThryBwCh4UyNTvjm+5tOw7QXs+u9RFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aukH7N2j3WH4GAOKsHBrKxqruQ5xUGnA6058ffTvWPc=;
 b=AoHQ1jSL8SNyZmBUbtZqZ0jzvHALqH1kEwKrVRKQ7QbdU5eDQBFqKVu6UF3B/J4UvYBlkSr+hzr9d9zIEhNfjwtnTW9lNlOD5g2I43JFmcpdRRHafjb/L1gKiJmR8bLa+3bq6MT5RrS1BzI0tq+Jx54fKXYKsmxn4iHFBEqsZRba8Eo82z8uGI85pNbhZBbWTz8rhTPA1uk3UY2Wgi1DjNHjM+8xmm0nWUNvnMqi9Mybm2IgVloY8VcynwFJItZE0XRFEAK56RwM+HU0c1/z9DMHY6xaBF8M/AIEIz8MLul7S4QEKiCWHkWaTWsl5TWXHCWbA7tfqVTl2UHn76scvg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Wed, 19 Feb
 2025 10:48:53 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 10:48:53 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgpN9LrDy2Tkoz0ePKFm3b/dRG7NOcjeg
Date: Wed, 19 Feb 2025 10:48:53 +0000
Message-ID:
 <AS8PR04MB8849FDB7BF68783ABDFC9EC496C52@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-2-wei.fang@nxp.com>
In-Reply-To: <20250219054247.733243-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|PAXPR04MB8640:EE_
x-ms-office365-filtering-correlation-id: 6fb4c3cd-3ca7-48c9-3f17-08dd50d300a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ShoYkkuCV6H+VsJIi6jqWqShBC9UppFfslIRWZviV9/A0BQ8nqXhhg/tUNci?=
 =?us-ascii?Q?Tr9TAmpeIIgLvsKN7KAJJJUWzvO2vo29UR87r8Ivu5s9GYWLIVab4kqbVq0T?=
 =?us-ascii?Q?aMVk/OE3sqQ3b5o2/DCUoOryyLTtfJVn15HyCrrkzbhio8KP8+hEhUTIIOg/?=
 =?us-ascii?Q?mc2qjBF+1m52/7HCNvzQV6mhCJ+l8q+BypzXizQRlrq0hxjd7kLxAIEz6YGa?=
 =?us-ascii?Q?Y6Mnh8pt13l/r284iChsZz+msap/GJZA+6LRx+2iaINM/rr38GR+B/GcBiRF?=
 =?us-ascii?Q?3BFqpMD98qxdsQtITouxY8Hhy73Bju1oUU596plMDAxns9+LLe45OSRf60eA?=
 =?us-ascii?Q?HyQ1mG//eTvIvmwyAQJOJmVdzdWr0cQ+s69VikDDekxk4VY/0GNzKpOQRv7i?=
 =?us-ascii?Q?nsp1uhT9BPf8Su5KGR5kUcrHie4nxCCxnwRBBs5mmvADk+5ahZL1TkJOahS5?=
 =?us-ascii?Q?lUo0rmg3fU3qtT7eBI8ZBNGlRVGDucW56wFHMTBLDyr0QGBt1zKx4m+Acdqb?=
 =?us-ascii?Q?j54+bBJtCHfHKszK36r6WFOQ0Nd5PlAj364ckObbNaOvqCcNVpGEACnY8wqa?=
 =?us-ascii?Q?EYRAoPzHoW4MyJt8MD+ZjoFvhKU1QOGKbrBMcXhOoXQZvNA0FpBWEcAKbcNz?=
 =?us-ascii?Q?bH2utlLMxXDc2e87pQeN9YaSO0rjlKDuAA/RtZ/nVm5c2Q+eFwL/pjjoQlF4?=
 =?us-ascii?Q?FfSDIk8x148xAzHqjj2txwCqoQYKHM3F+kh9iLoMVQ47pdUpMgpAbT9x3yU2?=
 =?us-ascii?Q?JkvsRGRuZJr2cwOas3iNUmduB6W8FoUF5BXhQtDOLqqsquOmI29hrbuzT7G5?=
 =?us-ascii?Q?iSmCoxMcF/c0H8vtCzz7HOo95AdK4+6dd1csyxgDhkvW8VzVLbiZgUkt7EdD?=
 =?us-ascii?Q?lDe+l94myzSgLLjkoJsYm/SS8B/Ecnp3DYqqzajhG/xFH0KST4/MloXjKGXF?=
 =?us-ascii?Q?8Y+jzpTBz2cSxDSAgW7GguY5KU/PNSIVBI24ccO4lPLSvdRAeaNRTUvuvhSe?=
 =?us-ascii?Q?OKs3lkxDenz1P/80DhVbDbdDXQXmgAubNfu8iR2JkC5w5N+f/uyKf23YoIzP?=
 =?us-ascii?Q?LKNS06fr4Bw94BB+Eo39PWRfwssJ7OWLh8X1gbjNfL4Q1Ck5zTZk0LoajIyO?=
 =?us-ascii?Q?Dlxdh+/DcM48E6C9nvYScU7GIJXhMZOh1FbIp3OgxzMHiTLr/l9PRM2rfaRf?=
 =?us-ascii?Q?v9h92ruAm3q5BDK9SYMucl1mrTmENU8HKT27J3CL8phXuYLMsf/xGcmA+1LM?=
 =?us-ascii?Q?eAWZsp1bZRbPPeE7VkYEcdLMD+g/AH9xSB4wcndf+VO5yn4anbqENqTkBuKN?=
 =?us-ascii?Q?ZCtNfMz9MpRzCDwzSUGkZSioizaThGjQRTPrHgHI09aNMztOwxMXo6YFXJLA?=
 =?us-ascii?Q?w2l2BHgLmTAsE4P4gRDoU9OUuI8gLplgfn3a+FkS0dVi9pFTPbRmBBmVZN1e?=
 =?us-ascii?Q?8ySeuD0TNRNPJg8uk8guamdVXdzWw/ii?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bJi1cFzFgBQc2cYoz5iuO21WA/ZVsUzXt1S9l1aToEoduP8w1D5JBbUTvjxu?=
 =?us-ascii?Q?OBUde1oIjXTjRJ9Ulmj9VnM4hTd0wnbEanX49f7ynObOajY9hOxjYW9KtN+i?=
 =?us-ascii?Q?22GlgJ1MypEkussjoZ6FyBwJib7GQyT3gen4nVRPmd0N6/4oMc4N6pqQpmyZ?=
 =?us-ascii?Q?iLSDIZODILZs8z1KgdRHPwGlsw777Sk2Sy0k9E/J9FCuC3Gw9mhtSXnuiOzi?=
 =?us-ascii?Q?xfdo0k2KpGCm1e24yGOLhjhh51KhhUPRdp9Y1cAWANr/slgAUruaehAGpgzH?=
 =?us-ascii?Q?/lLAhBgy7Lr3cORObFacOSfgP8KbLR9fJuRRjFQK84OVU+zy7VI6QjgtmK63?=
 =?us-ascii?Q?eaUmIC+sQW969zi0Kn9Kw3vYiU4RQIh6j9fkiC5zOmU3I7Bnc/flchcKUvIY?=
 =?us-ascii?Q?29IWAaYFB4u43EpSKcaYgPKVyA58tXOTiAxE9suKllM2V90Y2OzydzfbvPSG?=
 =?us-ascii?Q?SdFUGoOSNLgzruQyYPpJFwj3Rgf+q0f7qRJPxx7G7Qri68aV86ZJI21qd4X2?=
 =?us-ascii?Q?xzxFUK6O4e3wKgcKqlSTXU2w8rldxTvtD6qbJl+CWgKydDzATjha2KlUzs/G?=
 =?us-ascii?Q?ykmPwRrNglldiAPtBCQ4GHOmCJXX3Op8GRtlkgXIb+X1Na3wvcghiUUyNG/q?=
 =?us-ascii?Q?iCkiEEKVQhoERzOo4ScpJq4DnvWOpGOUgZBFK9LRfEjgzGYFDnwEa3MajEoJ?=
 =?us-ascii?Q?OAqmzfnHglcZNEmKSyxivsZqOkLzhS3EVfM3wefRrVEO+B+coWXCOda+yx3X?=
 =?us-ascii?Q?/zdBKbz+c0ybIrWEv0h30hjRZXHX3b4ksXqmajLCRc7yztgkrQIbrQLLHbed?=
 =?us-ascii?Q?M0x0LjMqe0Eog6QuftDzjD8xuwFeH5SlHW+DyQTid02PPxxCYdKwXDJzHr/X?=
 =?us-ascii?Q?foLPLaKqM46jCHkUFeseNBZAZZWKrgX/PYXXJnHqMzkUra3DYNk23YXuTyZ5?=
 =?us-ascii?Q?nVEfgAUw+pk8jNpqrfb1jnDF8oHL+p0A0zuaK78plZvX7pbO5WFR9pa2ZRY2?=
 =?us-ascii?Q?uTsABdYZlRfnsCq0D/rF48b6kFUeE/TedHUPQ0dAHiUiTCMu2OKG/EGiZNKD?=
 =?us-ascii?Q?95dQ3oKQSRu+z9Mmdlw5op3lstt+HvYER2MLkCQgzTeDCz1MZvJkwHGysNBP?=
 =?us-ascii?Q?rq/DkxySJL3V860i9ZGf6u2FOnVy4bImuLJjbSHzcJlRO56kC5eFq4cvp3jN?=
 =?us-ascii?Q?DXCmwAYsQ/lQ1XeGVL0/4E8r8cwAsM4QUBPoYLYUlqzHOFcDsI2s80qwFRYo?=
 =?us-ascii?Q?3XAcHa+V2VTAbbVFnoYtJU1pXgUTD12M6o5WKQ3dRJCQOwiKv5jwXzuGGxbu?=
 =?us-ascii?Q?aeg1R7s204nZdArF3MIZak+xOewErNTcvogiwscTFIaR+BxhcMDgqv4rAAVu?=
 =?us-ascii?Q?P2zEdfWfGXZJW94IUe8HBqHoHOw2NoDxGiyZbj70g7tRr4mYKlRGUd8S5orr?=
 =?us-ascii?Q?YNyut/bRzgn3MEFhbpQIP8EdAppFF8Y8fWnSzzJhp1A1BU8BM7Zn3voOmgQz?=
 =?us-ascii?Q?3i9K5jzvHTX0Dntjm9cTi0UUvbloym43/2pu1d+Cn3uQEebGvY9phaBZgvjO?=
 =?us-ascii?Q?LtFzfZ8+QEdfBhNHpin27F8ldXXkzPdKm2d9ECu/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb4c3cd-3ca7-48c9-3f17-08dd50d300a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 10:48:53.5500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKNFP3FirlDhrWRfNefHDft0cLZR73Y7LzNlqtjBz5TsVvCVpZlHuNFrfQ/c1aqGVE6TmBewOpQ3RB4iZyIslA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, February 19, 2025 7:43 AM
[...]
> Subject: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
> enetc_map_tx_buffs()
>=20
> When a DMA mapping error occurs while processing skb frags, it will free
> one more tx_swbd than expected, so fix this off-by-one issue.
>=20
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>


