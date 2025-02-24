Return-Path: <stable+bounces-119395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1AA429BA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB09916C4DD
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CE1ACECC;
	Mon, 24 Feb 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oG5JBKWt"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2043.outbound.protection.outlook.com [40.107.103.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B17262D37;
	Mon, 24 Feb 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418041; cv=fail; b=ugdIqcT4JHkwixYj4EcisuzWUOArgVhPQw+Yg3eW7i/u6RFh71UTpu2z/NNOSIDwp0o0BZ3E8TpsPzu6hgnpc1x0F+ZyXWSoSk1f7PYPvjZzfPnkZ47oFDiVID5D4FKQbBUvewptGGNX1UOfgfYT1ZKnkKGu3+ypKx4VLluOBs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418041; c=relaxed/simple;
	bh=5KCBV0ux8UGCD1/wmChbl/z+nPJjN19hatRf9RBQxM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rupkq9CJzo9oaptiuCduATy1A7PL50rLHRKTZGiv5NZYxYLFoGgz2+oi3Gdll62eYMTAYzOUhTGGn+5QHOQgEtDtchng6HHroGZAPRA1MxiEvjRSzMQ2WtZ0wRihmIrULFjMkc1hCnccnGZZ4FPIBeOL50VyuQMXZZBo8ztDPsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oG5JBKWt; arc=fail smtp.client-ip=40.107.103.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBsaPIxfMOTv72ZbWcYLM2dZ/MTjsfC/Fa2edRUXnnTjsJJ9FfRZRTy0cDdh5y3UZCyXHRldmHrz+Mq7XnVYLky6rKoFBKcQ4ye2vPr6/UHWyrjdqP4OI0zD6+ijODXp+LtXa/UVOeW6MGLt1PYLSTp+rFPd8IYuxkm860NgjXm4+WLGjo/A6/jcgIXmGipzOEW0xc11P3Dpur+JASGK0QANfKgyAMWBOEnUbt/04mgnNrtkYRW/RMl4njaAtQJ0kMLOYoEDBIi9DJOtWoaaVC+UsPMEJIo3WD5g66cJXhsmYXfiG92rR+vxcNP/DpDA+WQsBfTnip99f2eanuj2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KCBV0ux8UGCD1/wmChbl/z+nPJjN19hatRf9RBQxM8=;
 b=wGgmgaE+aPNcT5uFfUeYLHnO21VffGnf6mPzEFeUqHl7UVkCwgWHtW8XfXyEIHA44RVWu0UjmuYN1hQy3i7+UKVa5NKaSR+BBq5v7C5gTt1hg4th2jT0OUetFjj3WV0LSidS0rLLLbMvAuZ9EvdMuwdZSjDbODj2FvlZaMMEwMJ/kb0Wmm/Rqm2F1o6QvhBmoaf9qMgpDjFP/DFk8dYjtgI8/SgmEXL03tqBGlCZu8uIPLQnY98fLQdxAWAnA/G0Ubk6cKoAWpTFGfNz5LH6ILlnwjDfEeWX6ls/y6m7Xn1jWKLzkYaTirKWM1un0xHmd5FXa8rhz6gr6eCGDzSTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KCBV0ux8UGCD1/wmChbl/z+nPJjN19hatRf9RBQxM8=;
 b=oG5JBKWtqp3axCbxgepowTu81vxInrO3NJNGhn0ySfZF/akRW70rudZpHAM3U6G7ki4TUJtIQt7Ee+RFICvgecBYxQUW6MqzXbyECjXdJM4I12AVGEPrP3fp/evUz/MMlphV/MuSIWaoORoJ9t1zl3fBqHH67N3cVvpoT3ExwujmcCgZLicteirx05c9VPJls77JdqIGW5cI8w/044RVijTaxOBlp9xC5jWnTy8TX29Awpw6S8vfUlRikNANV1pChGwjIvZDfxmmtmp0lLjYSMrTuX2aDsbShyqC+R7qnyj8W4pZ0ifkDNVqMAFpHD8fr8nOiTQyxBBkJjpAAYMEZg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by VI2PR04MB11169.eurprd04.prod.outlook.com (2603:10a6:800:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Mon, 24 Feb
 2025 17:27:13 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Mon, 24 Feb 2025
 17:27:13 +0000
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
Subject: RE: [PATCH v3 net 2/8] net: enetc: keep track of correct Tx BD count
 in enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v3 net 2/8] net: enetc: keep track of correct Tx BD count
 in enetc_map_tx_tso_buffs()
Thread-Index: AQHbhq9y+DDo2BO/uUaRTnlkOTNY5bNWtP4g
Date: Mon, 24 Feb 2025 17:27:13 +0000
Message-ID:
 <AS8PR04MB88498F1FED4B4BD367D4B9E996C02@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
 <20250224111251.1061098-3-wei.fang@nxp.com>
In-Reply-To: <20250224111251.1061098-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|VI2PR04MB11169:EE_
x-ms-office365-filtering-correlation-id: c84e7b31-9fa6-48fa-00fb-08dd54f87a18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hVDTsSsyk6KNwrGWHUgHQDbWF6l6HBinnmwR99r8TbBNq/w8u2QtiBVZxAIA?=
 =?us-ascii?Q?Y0F/xnQwqUrPAaSvjuxaS7pRHOCy5Su8oRQnHvFfDDqjaxETcd03ghevSZu/?=
 =?us-ascii?Q?5Z83RuThgzef3C3TPUx+ARNdRuH5P00Di0C1bxq+O7i9bRVd29ppbu0bMEos?=
 =?us-ascii?Q?BxLbd48Rj+nwFG32kGmv7IdtNrhPzf4hm0ZzHMt3/631MvlZfHJohzKeJH/0?=
 =?us-ascii?Q?PrgakwVmxD42Q8f9/hV4LJm4AOqjlwkpAeC20Pxu3Mr0N6BvPWvUUA7YUPrd?=
 =?us-ascii?Q?uJywDS/HT5O4vGaaPUcWL4HgmEIgjXaQOx1jd+ukkJpJk30y+AMBvFh+91B9?=
 =?us-ascii?Q?APFF5yYhgyDgJ5ytnzobzyGWSxZJ+uptLyAcsdlEpubDzLRaHPGma4xU5vB1?=
 =?us-ascii?Q?utNSj/e4ub3YwlzYYvMflB1tBFwd3kBaYN1gpWZeYEoCxb02jRnHEnA9Gn2V?=
 =?us-ascii?Q?N6jLeYce0h418hIw81enRXBhFfAcdoiOlAjM8j6wNWjAyQPjt7xix0blHsSq?=
 =?us-ascii?Q?XatPYp1Zn24Qz8bQo+Mtzsnw3TSZik6lPViJ2T4VrxVY1Y80q/YzoJITZJHZ?=
 =?us-ascii?Q?SdfjbkVquUN55a6xUK7GwqNxP0yF5cuVfp1+GTmGrb65PNgIHSjpWifkM/99?=
 =?us-ascii?Q?Uts1GtTrfCT5cgRBd4mTHGP34XyjMbq7ELErmhLdKzgOQvTPjj0Re+hfknej?=
 =?us-ascii?Q?keSx2vj1p398dI/Z9c2eBS68Kk7zjzFEQHFXDCAea7R+Cz4OSFt8/vMW97r+?=
 =?us-ascii?Q?rgcdQ1MG1fd0icOXi+ftmLYE0boYmoB/zB4L2IHSB1/KFkCrGlqVC+J++MlU?=
 =?us-ascii?Q?PR3GLRYgBr9VWxmj8ttYlQhEVub2njbrKAIB1Q3TUbQ1+FjjKYJO2Og8kJBI?=
 =?us-ascii?Q?Lht1eWJhbk0LKJdPQCWW6vytLdNtiadqcYHdLQTFEIO8tqf1Q0PYwj7TfUTt?=
 =?us-ascii?Q?ERVBk9eRWtENPTWFE1vDHDu2O/0uYChBsEJoKx237UWD8ne8U215Wn891w5X?=
 =?us-ascii?Q?yy9nJq3BurLIKRgvzC7j6EATm4+3Z3FgTZNbaPH6vaFWuLQ7vrvwB18aD6cc?=
 =?us-ascii?Q?f3KAIsoUExRAfaza6O1sFhQdwgSNGu40f/GxfsR2Ohq+kRiFZlrX8cDBV9AF?=
 =?us-ascii?Q?tjq7fPMyMBz0RSgLc4qH63eKZze6dixgorjlJ08F8aActqnappq0nbuJ6Tm7?=
 =?us-ascii?Q?4eIu58CdNLMcLYtNQPrNLm4qIfwxGo/E7aussrF37YmyOM2nSoVu1hC0tpAG?=
 =?us-ascii?Q?U25HmemrQAQpnfYkxFgUh4gNSR/wbDPIzy9GLiM2hFeaJ5GVypxbIKAfH/9L?=
 =?us-ascii?Q?KTigLr95zShGlVwDD2xGjtSDzXaz1x4S9QuH00JPPQBLQi/Cgv0moFO2Oh/1?=
 =?us-ascii?Q?U+9STbbC0VxlQgNpDkzOjKzu0MAaEdrOP67btzB2Itdsxp9jl2NRC+Ekb3wO?=
 =?us-ascii?Q?bqQDP0tW6C8gq4I5LVLiqaL4gV05ci1J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Iy4HqYjrCYQ+NAUGHnoHZszPtqrnl3IuDfF0gA+HkGZeu5+bgNczKHPohZpu?=
 =?us-ascii?Q?S/92g8I+11Zu2zQW5/NGhcHbJf7EITYKSCEmcX1sGCol44JHU3A0saglLLyd?=
 =?us-ascii?Q?7aCIjDKAD5PxGGjkXoGhg56TLFTDcZUCXtX+qu8F/sIlDdRjGd1ojY2qmwul?=
 =?us-ascii?Q?HUdWLX8GyoOpc4n8gBs5fI2m3LQ2lFO2kdRhtjq2+jRnpS+sVVkqKhmR39hB?=
 =?us-ascii?Q?yUlQyllWwkqYlRl6mVPzEuBjw+ClK8ld/DgZe0j9gMlf7n6ex5L7wRFgm4rh?=
 =?us-ascii?Q?YZwiwHavoJ0vmw2WM041mhNub0iNOSPNeQsftxkhU0uJ3nLWtqaKSnRnZ3Y/?=
 =?us-ascii?Q?jBrRKfatdS1pL2E6XIvkfdr5XHNCYpodUJB7rqYrut6O+5b1jTKYp8MJlyFG?=
 =?us-ascii?Q?mWBOg/9/vLeqcshcnmTY6nGnbyAt5YT7SEWNbr0IXK6GlZJUlEju3j83RDp9?=
 =?us-ascii?Q?nSjEQXxt/Q27Yfm297WG/Jr0dic58V8U4AIyj3DQGT2Is25hjZaDYenDeURZ?=
 =?us-ascii?Q?CLzWbyLn0I1Pf7hzwpeucbNMhZ+3bUZ09XlbzOpDx/Fo850acEh0zbh48Bcj?=
 =?us-ascii?Q?fcCaXMiTnG8ngxXR98VeOZCucCybWfrKSkIZTBMq09v9eLThKtIM+KJIzqsE?=
 =?us-ascii?Q?bRrh3KVI0NRwraAz0v3q/NOHED2vBpzwxD07SipNnzm1s6fc/4i2ERtTn5ki?=
 =?us-ascii?Q?Heilci935Aa/mabW62h9Ydfq9BM7Z1iOQBz6nerG6veU6z1Ysqhvfy9h5C5q?=
 =?us-ascii?Q?/eZPRWYa1UCyPNTayeBYSet4/qEKhjin6cpBOAL2G+/fkQBd2g8kIfSDagxR?=
 =?us-ascii?Q?Km3VpRX+gfo++dHXCETAZiaiTyrM0W1u3EwdnS7YlvDwEIeTrhhd4V2rxH+R?=
 =?us-ascii?Q?jpNUeAIsUUsDJwTJeMgw2v1tNr9/0mnuSpO218o0F3xPiOs2evbqUMsE9CER?=
 =?us-ascii?Q?G7tru6lfqtXw7X2sMs7kLPH/29atpYllf3VZUgGhQSel7vCb155Pl/MpkEKY?=
 =?us-ascii?Q?bSJ03oqz8xHtuoLmKukclskqL8+vm+LycpU1tBGO8p4zz9xQqpYPSFdYioAT?=
 =?us-ascii?Q?k80NAcpJ8xtkT3rhgz/cnzEEG8R9qxR+B/S4gQ/xdMbCmA0icz0m6RWE7GCd?=
 =?us-ascii?Q?d8MMWucRV8L9Q02nPuSPXKtkZy/ij7/r5H74+6N+HLGW+4p6BdTjPob3JYAz?=
 =?us-ascii?Q?zkr5tlSNf/R5HoJWgr9nzMTbe3QxtKaseWTxX9rJLYjrdPB+JeORVmkoDL5S?=
 =?us-ascii?Q?KIVHSBdrQRNZvbBm0RHXWEHFiKiAkTrE6Ycy/wY7ZSxcvYlULmQ+XwMokk+D?=
 =?us-ascii?Q?T2gjs0qzJARLhZQrmPI4v+NHQ5gkVYKzJD5FyGszDKN776JEwU15sTHxie1/?=
 =?us-ascii?Q?0hpGXUAHFcOFS0AN/RKeNQwK3vLUwNAjaWN8U4H8kr17OCLQRWuywG7Z053V?=
 =?us-ascii?Q?9Fo87hm7SsxQo117ZNFlVcc1pE8QT/DF8amwUGrnq4QXOLNsTOQhLDBCra46?=
 =?us-ascii?Q?KHPEHjJO4UzB8rDR7boWoeBZP/Ag1xjyQx46XZrFje9ALvUi4V3tpy5mglnV?=
 =?us-ascii?Q?21/wksfKM0ArzJsTcgEvBk1xKLrXBW9FPwK4aFxK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c84e7b31-9fa6-48fa-00fb-08dd54f87a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 17:27:13.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hk4UjGoMcB9RO9K59DXInwQrQIpGNk4UbIKgIb+tGaWuUaGDuGjJOS5v0j2uv3Gt7d+UU5249QEn7JbADOv41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11169

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, February 24, 2025 1:13 PM
[...]
> Subject: [PATCH v3 net 2/8] net: enetc: keep track of correct Tx BD count=
 in
> enetc_map_tx_tso_buffs()
>=20
> When creating a TSO header, if the skb is VLAN tagged, the extended BD
> will be used and the 'count' should be increased by 2 instead of 1.
> Otherwise, when an error occurs, less tx_swbd will be freed than the
> actual number.
>=20
> Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> Cc: stable@vger.kernel.org
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

