Return-Path: <stable+bounces-118385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C972A3D2C4
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598283B2E02
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC91DDA34;
	Thu, 20 Feb 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ta0UCM+b"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934C1E3785;
	Thu, 20 Feb 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038746; cv=fail; b=RTWh0D34gW8gtzPlK5qwmqe2SKfTp9T3vr+QlonO5LPBSmA0HnT3i7XUXCenQyAnpiBxgyr8dQJ5U3ta4S4+xQvO1rsmLKIifcuDWK2NGRUIG8e1J3t13Uf7OU1B+19GytHXHIv7/tTFaziht6zlS3bE+1yL8VYyRR0yRpjwMto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038746; c=relaxed/simple;
	bh=ri2bKWnclF/VkecTKT4ntXlptpYT/gtQfhLy5jh5jmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBUkv4Zx++9XwjMJMi9aB6/qVO7ww2+MCUwJerqjjm/+8v36AfonPRHGOr4ak+MZcaC2RFeRcocumj4CDdl3q+JN3ruXewZ4VmUpt6uphzTeC4U51wd2P9oWRySjMqt4+pQOuu+XTsHM4NNzMuWa6nsTqlGOpUbPoeTtFCP77tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ta0UCM+b; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvDfw7eUS4gqvYGw+VESJSM9nK/zMlqbChbi1iVbp8IUdBcWz81Y6JJsfLLjJkDtfmDdkCS0XB1nNq3Lv8Xbmq9wPnZY67ci0slYoUaPUEC2Lw4A7VT8fDKhVovL7e4JRdVeN8jpWjcT0BEWg0s4fW4iQkVshcQVSrOxwg+UfXdDTEhv1RQ+6uZx/8D3bScAER98RN6fEunhQCv4FH40okbPyBoJItXjcZ+sKAOMmD7xrBYDCeQejvPFCJz7ViyYpxMhM2y3Ap8UDlMbfw6+P5iPQuKTgjTgQID92bd/CAiuTu8S1+/L7uZLEdVu/9q4B5lHyJINu/S4nDk/dU3Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri2bKWnclF/VkecTKT4ntXlptpYT/gtQfhLy5jh5jmM=;
 b=NvGLlBSlXcjmyAPWng6aQ/ewufJcmMZNF4TOYZsQ2b8VshPoaN9Q3/QNsb3PfSFzb0AKf4p+BRis4GehSfle7IGDH/sk6lx0K1tGXolnrOhHi7tyRk9TQRmLUrWFF2+hyLmoOtJ1DPjRSHQ/VP2HnGsSh9mQ3Zmgwib9BoI+h9PAkO6EiaQ5iBn2clfjcaVCJ8D7WUVpLUxtryGn/NQEK1nwVZmJrCf/s7zDJNHrCqUkPJ08d9g6Zcy3vMGH17bx18LXlPmNn49RwrHDzEVqkpSZLQtWeZUhvC/3AeinUD756xuIiwilZ8f6d+HwpEX4H9YAcqsjEcxwdNm8Vs/dgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri2bKWnclF/VkecTKT4ntXlptpYT/gtQfhLy5jh5jmM=;
 b=Ta0UCM+bQOXyscBN+EqUK28YuLDw322nrg+hi2yAKq2sN3LCCtk35iHj3nGmj09GfX0LVRZW9kZ3kWgPfLxmtiYVW8PkKFaubFYb+XQbDayC/YCeuM1/9+unOCuHnTQhu0pT2H9ICjfv9cGZZtXqgGmdWZvHvl6J1pK3RIx0d1S2fHBN6tDNccGhnnf4KEDH3tGNrod2uGVDUSD/EIvljY3jxLzxrrHRmnFV8bnFiKkBX60TwM8T10FwTpLxJUZffF+X7UsoOHftSM9Al4/XdSEAdEEA5+dpx8w7uy3Y1qlbZSVoqS8xNeEWxxeb/PT0g/n8uxVdzX4XJxlit9HPAQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 08:05:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Thu, 20 Feb 2025
 08:05:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 8/9] net: enetc: correct the EMDIO base offset for
 ENETC v4
Thread-Topic: [PATCH v2 net 8/9] net: enetc: correct the EMDIO base offset for
 ENETC v4
Thread-Index: AQHbgpOQ7qQwH1bh00eEvoDH4p4so7NPGGUAgAC656A=
Date: Thu, 20 Feb 2025 08:05:40 +0000
Message-ID:
 <PAXPR04MB851046B5C1F8935DA49EE5BF88C42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-9-wei.fang@nxp.com>
 <abe49f9e-a1c4-424a-a96f-0793c0fab57f@lunn.ch>
In-Reply-To: <abe49f9e-a1c4-424a-a96f-0793c0fab57f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9639:EE_
x-ms-office365-filtering-correlation-id: be95730e-029c-432e-764c-08dd51855e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JuPwTG/YvWUT6OLqCKvMEO2tIV/yQeL6eOTVw1HBLaPo/hOG2G8RCWLz9BQ1?=
 =?us-ascii?Q?KK++v67/KLK9lgS8wxdNUL4i0QvcyAIA2iWP3E84fngnx44Wxp0T0g2sIx0B?=
 =?us-ascii?Q?Y5KXW4je+pxcF46D0JUdrUmap2UFfI46390EMLWDutBa7zL4pjoZF/DaGJuG?=
 =?us-ascii?Q?rEw609YpxXwgm3cTkOi/JaLAEtykz32I+geqRuPMxZ8o6LJcnSkdaoYA9H+e?=
 =?us-ascii?Q?I/4OEPfRZHYo3nzmL+x1ApurFY3RVebYMvupuHi39apqbXZfHtRxavMphXMz?=
 =?us-ascii?Q?M8+QWPJlrvJa9cFiIv4JpdqGJToFhB9ckHu6IEcPn37H6QNFT0AGd28ifxnY?=
 =?us-ascii?Q?t9PEA8awR/0KjdZoZKllA6IR+/CwPGWHZE2Gj9XAgeXZ+9PotCifzA2kbqSy?=
 =?us-ascii?Q?Q+Pm65fVRH/V7D746Q9947k2c6Hyelsb9tBca4UGFnIAg8Ow+Uzk4ozZ4BRg?=
 =?us-ascii?Q?roK3UHVwg7LUN6EHHoxsBdauJ+8i/XfQVm43rrC2eOKwR5+2qOyYDKRgQgUc?=
 =?us-ascii?Q?3Twn4z6s7x/sik5vnSg6fPuuTpxcFjoil2vF9tsyc26rWnU+00IoPXPIfr1V?=
 =?us-ascii?Q?9Ki274II4j34Uuvu8t6h9nvM1X1/qb9qs5QXcCIZPTgDDv+3lyDKoY9OZnTX?=
 =?us-ascii?Q?OoW76E7tKorwgc6MJMXxScZtBxBWKpGzCwqxObkMVdGnmHtna68E4EYA+6Th?=
 =?us-ascii?Q?PPFfWVlfu8AZjZqWTupyW+SAXxpGZ+1ywVdJNv4uv+DGi3WSxbPkAhnRj8HT?=
 =?us-ascii?Q?3SqnpsLiSKMXVPFm8aDACRWrj5r2iWDFlcBZ4hKu2hN9zffV4zaUXia/piEK?=
 =?us-ascii?Q?f9WnvfRDDooPls5DzZl8Hgt7+NrlR4/dw6eeq3FMCskX3nNKs7fNjs22D1Nr?=
 =?us-ascii?Q?N3EzRqei4CYhJHTmRHRetN5HelF4GAoOx4M8Rqm+CNn7ZmZGYrhUW5gWKCk1?=
 =?us-ascii?Q?AsLLvAyJDRHaLFX7yAsdg1s5I43u/7+e7EDQrf+mt9GO9hmYOJc3uFZ2rIfp?=
 =?us-ascii?Q?9i7qERxTPL38UGiOxUgrsC1SSysLeFABeoMIFBS5F++TqTVtp/GpAAlUmXu+?=
 =?us-ascii?Q?/np4R252aw++35NcZrVKFouyha9w4wcp3f76U1x3SP3greGBVFh5qqdubdNe?=
 =?us-ascii?Q?N8m+qSV2Q403/KqXf7cDjXpNvS8oiUluJomu70yUnc5BMkU7X9iMHR1kR2st?=
 =?us-ascii?Q?rC0YXccITxA5FuVDC74YAQQBRfdPpPOzema0lLL704VWCWtlfADGOjXU6QPY?=
 =?us-ascii?Q?yDJ5YTpi6HxLqk1CvAWcpex/RmT2TEZw6/yFFn6ZJCRl+ekt0xYCPhsJFJgA?=
 =?us-ascii?Q?NrKdaxGOD8u22w7QU1wZzChUzGbCoWG0utcGQVi+hVK+segoRLhemfS0Pplr?=
 =?us-ascii?Q?na7b3tUt7W281loK8SDADpZRg3PoAeLt2Y2+VE5NQhNHt7eOyOKZcuNjQdh3?=
 =?us-ascii?Q?xOyqciTXUPFa7sGYbIm0PKUXZez3s1ty?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X5hq59vDDEQh4wvq3S2wPAGHmxkMfNGD8U5lZ9NERG7OawZXEDfPu0cxHaHh?=
 =?us-ascii?Q?nSH+a3qUHH6eQAIvrtnlUK2ZQ2uNdF/l/UqPOAGy0qFtJeGrUuew01CrjDr3?=
 =?us-ascii?Q?2qTv7Bspd34M2g6cXQllufLBVsbM1j8WYsfIq24Ri1E/AQQ1RObJPRCN0MzG?=
 =?us-ascii?Q?KDCk7PP+JmfAhCMO2h//zGB4UtEQMkkii7jBGX//0e7WeSe1LFYBZeMbs/yS?=
 =?us-ascii?Q?nx0PjedWaY1ab4wKfHL7qLz57Y1uJVkMFscOWNVj9c8+LoxdD5P7JnZobP26?=
 =?us-ascii?Q?GeTy3jIDexpfahIPFIttmIpe7tSk6CHRpzC0Pp9xHXmy6/hPF3mC6buHrcTe?=
 =?us-ascii?Q?n3ZdMITvxCPcw+bHYZisKm5dPfSPai0AZ6kMayNt0mJCXSrPkuRXCi8iUWtc?=
 =?us-ascii?Q?9KCOgdhcomhHOMoJ9VWTD1t+BwYjKitluuBpdoS/CynZQX6BfcNIMcanXHZV?=
 =?us-ascii?Q?iSbtfYcVQqjrdxU5jsOKFbvr+8GL+afxdh+9LClpdKzv+jiAsLqnkceup/Z+?=
 =?us-ascii?Q?c8ps8Ym0+l21mwrXDhFVf0gISKkP6r7Vhh8ASy1X593NgL5ruufaScIsSP5J?=
 =?us-ascii?Q?le2gv14ZONx2a7Oah5JAZb+KLTmlEQhrhRwvQfeJx+IHLPO0Ls39kR4wP9nf?=
 =?us-ascii?Q?0eN7cDwh4T9dVhf7rhOE0CBfq7ReeINwt+JOypvgRhyrMw2ZW3DMXnPkjJEz?=
 =?us-ascii?Q?Je6SZerTCmBMzOpk8D9ziwNz58iSH0MMVVRyfRU8FR/idsL3f449N1lceYRr?=
 =?us-ascii?Q?afZjRrf8O0GqFjDZYBataKMY5kCaLhDMRk7bcunpUxKNel0Qn7omVdemLngt?=
 =?us-ascii?Q?xVZbUXI/gfnwXMP24xN+L4S06udaHagI33rCGK97NBEzkJGWPAMJ294joqhR?=
 =?us-ascii?Q?LDgNSWfOt48rMdtQzbgEnTf7H7E64osN8YEXtaa4MVvrcd3CTRRNG3luFmyp?=
 =?us-ascii?Q?rO0xxq+8hrM2S3VYatIrwtK6XgQ04fEsBuuwYBidENcVQbZvx6PccKLCLcQc?=
 =?us-ascii?Q?BytBiAY5ZqFDtxn0unkW6PhiOPcE59ErQB01amsMexelBM3V8gSoZTrVCCH6?=
 =?us-ascii?Q?iaBk9vVdk8uRT2r/gQpkFypcuwAUP4kGiMvsh0JQDN/Yv+48JpzYcmw5NC+9?=
 =?us-ascii?Q?2v4TRuvXI8bzOOtanj11CMlpqUuZFPaORzBYiKWyDPbjHJnEFCg3WcgM+/Js?=
 =?us-ascii?Q?MZPCm/Gziw4SDqGChkw8nDngSWtwQQjO7dq3ufay9KGkjVu3DwSGQX0ago8n?=
 =?us-ascii?Q?Lx77uME3ww/LRJ1WR3H5IhXqBNTyPClkBpxMNaPTMZdvqB3U/0Ye9uuPNz3g?=
 =?us-ascii?Q?JeqzZifAnnDbX8tuReJfst0M32WTE8eGFgioli5tkVFm4ZWZ33Z9cs/h4iEB?=
 =?us-ascii?Q?9I8xOuoYK283iLrRWlLTsV0ZPKZDU5WYFGVfrOfJK6UuTveV9r8Ms7X44e2j?=
 =?us-ascii?Q?d9s2R2Wv1wPY69doAqD7eybyfCxlTxssH3AlEprs3eCJj/IJ5Bp0JgJUsXjr?=
 =?us-ascii?Q?JAB56b3OhF8eLvm4ilQqoXv4MU0wYUjF7rEB64FEj6QyyU15QcUmxVmL0eQ5?=
 =?us-ascii?Q?ZSuGhG4rk9nP+LSLgCM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be95730e-029c-432e-764c-08dd51855e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:05:40.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+W3O8H8xPa5iAleMCo8hSsd5c/5p1jDNCBhplZUfhPNYDYFcBZ6RJlOZu53tUQ/oG/o7tvRH3oeowA44aCF7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

> On Wed, Feb 19, 2025 at 01:42:46PM +0800, Wei Fang wrote:
> > In addition to centrally managing external PHYs through EMIDO device,
> > each ENETC has a set of EMDIO registers to access and manage its own
> > external PHY. When adding i.MX95 ENETC support, the EMDIO base offset
> > was forgot to be updated, which will result in ENETC being unable to
> > manage its external PHY through its own EMDIO registers.
>=20
> So this never worked?
>=20
Yes, for i.MX95 we use EMDIO device to manage all external PHYs

> If it never worked, does it actually bother anybody?
>=20
No, just fix it at the code level, the offset of ENETC v4 is not correct.
So I will remove it from this patch set and add it to net-next tree.
Thanks.


