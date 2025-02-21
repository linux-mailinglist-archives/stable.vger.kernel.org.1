Return-Path: <stable+bounces-118537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78419A3EA43
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F73E188A605
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733AA13C3C2;
	Fri, 21 Feb 2025 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/OiunM/"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7E84D2B;
	Fri, 21 Feb 2025 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102131; cv=fail; b=OVo+PSqD8NRIeM3jy+LY4J8pl7Q0SM1cwSqfDnTmudkaEUOdfxBNWiyKjP+r+wwI4EQ+WA+B1WoE7DRzsOW8r12aCV/GW5EZnZFzo1bSa+HDLcCTUO3qzBtpHo5MDtLs771KFEVlrISZa1sV/A+D5ORAMVMpab7nFQrE8L8Q0gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102131; c=relaxed/simple;
	bh=Gd6VnTzJQETJsY4POptwaj3yXCLKwl8yHrjkZrObgoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjGcDqRvPj3HIbZihulDX+Qf8M+wsBzcMyN/TyaKXJ93EDbRBcoRtdBPg/TMocio0WlSilGgUk+AC5GO3mLmbbxeWt2T0707E2I8hOSeIWCjBTykuHye03qf4msmn7DlREcXV5zIJSOKVN1C5soWtEQ/phRWwJMpyWW6N0c5fhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/OiunM/; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NagRE/AMOyP7KOouhciZdsDy9fA0ezYo2Lk6EruN8uya4KUV//vb0cqtpd7JNsFASTqvNNh39yQNtEG2Qs4zJzAyHpUggB85LGu0vDIZ+D1YGckxebRTPzE5mmZWLMGAGLhOJdRaRiPjW15mUovSqQqPFcm3ysnpL2R4qYGUELEzD7zbMJfxrKW+8A/CiUwlymDse9JkAV/u9J0BauV5IdtoN+s8tVmDnRCJclk9l+k8mI8HNGvU7UL2R8SH8akjvlwcSb55uFXO4aCUcym5zGoyorZf/0X9JAuPF+1USo+BKKpOB6HFn3djEYiqLj6kawmjY2ZoyRdyaAaAxJUPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A1yt8UIyJnW55/4H1TEUpUr5BF2rENadQbNNuT1r08=;
 b=kHNJlmIzllbMEKcfHEZI7TtSPl6/RI+TOl8YytSs3Pd4XsqNhGtdAP+YjvxNEUElQCy7V4bPWa0gYHLRHtGOotGBPEDLSbpEs99Y4kFH+FSwgAL1kNSROYrAXm+MAfLQOx+ex2betitG42symgo1Ax0bBbYLBYGrK/oo+LO4Ljzy5m4TrAP33b1dGHSxxJOVGcyZ7astQYJhYnH/CmrRV4fl00YpZsqIlGmm7M7zRxhlq0avBC9QdNaBv5QtRUNx1shAqD2KxaguR7FCnJaMIj4t4THP660PWA/2Byynwybo4RGQ699t3yKx+xDctfftUpk33TauWUh6tl7r4Q0CbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A1yt8UIyJnW55/4H1TEUpUr5BF2rENadQbNNuT1r08=;
 b=i/OiunM/miIpG59UvJn3GwnCsNBiC+l6AAWtt66da18HbByezr1gf2Cx7pSXqjvOvcvUK9jcfFA8g9xcz/jKdv/5pPu73U0mH/hb41NEKlva+JiC4G0aRO8Qs+hn+ALpwmSWW098tXP2TGX5s4RzXV0Uk33HX1huqZ97RbKkyMePsJ7cF73TSNhk+L34JbHIw2SvJvlnMhPXednLc+U+qxzyZ5wGEfSKKkcgGNPqJV51tlt6DY2dl/HgckZx5A9SFWe5S2QqcmEi+Vv2WSj0WYsjwtE+v2CXgkBe8RDqNIQS2jU3HSkV++TwA2IHg1BBiKNIAWBhoTETUTi55BSBAQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10371.eurprd04.prod.outlook.com (2603:10a6:800:23a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 01:42:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Fri, 21 Feb 2025
 01:42:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Topic: [PATCH v2 net 2/9] net: enetc: correct the tx_swbd statistics
Thread-Index: AQHbgpN/Xw1oIgK130OBsitj8eB9+LNQXDmAgACfT2A=
Date: Fri, 21 Feb 2025 01:42:05 +0000
Message-ID:
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
In-Reply-To: <20250220160123.5evmuxlbuzo7djgr@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10371:EE_
x-ms-office365-filtering-correlation-id: a93ff65e-4f13-42e7-f58b-08dd5218f216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6ArIi51xwmJHZLVvo2gQuJIeiS6aLgqHxd/YAPDCp0y9QjIY66o4VgFpoxuY?=
 =?us-ascii?Q?GnHweL8ooEyR7Uh0+beRFs56ot88bFNCHWo0/dlmwUdlQkhbvsN8rR+VykqR?=
 =?us-ascii?Q?lkBw5MJc5IJETiSKjIoy/r+2lHxA6fp4BAdW6lpFzDpgl4steheyAto+yzL6?=
 =?us-ascii?Q?t01lcYD+EnLpotctfcj2+a0VHDiY8rVkLNp6T2sw8ACeCnN9dnK0T9/Dfte5?=
 =?us-ascii?Q?f5vjbkYQy7J68VJGkxk988GrDEY4lyCDyj1HWgUQWrG63PD7xyCh0jiX/z4u?=
 =?us-ascii?Q?HUtDo1GAN58+RtIkG/JrWijsgs6p3j9Mm6s8cCQRCfqLo1a3AMrmu6OIikl/?=
 =?us-ascii?Q?J4VJMAwOSUbPW50G6T5E4f0FdE+k0tL94MvsNech4U8pIPMOquj653wV+CIg?=
 =?us-ascii?Q?s4PIDHsg5XPi5da3mo3vELRjpp6ejgJ+gjuhTPLhijIwQm5uOklsIo4Ep/hA?=
 =?us-ascii?Q?wxJDg8f8arntiCnneF4e//6vfbvTznWBvPnkUj6AS58HMs4qrO5sEyQ0FkIY?=
 =?us-ascii?Q?pjVA+AptUsrL/Dz1Xs+yElFwyo1iEjgAGXQ3vbL+ufDXzVbOntxhOMX6O6WQ?=
 =?us-ascii?Q?5JkvozFXZ0mxUm7lKEvAxg5HVRjk9ZLOrlXufs4x5hOGPT0qa9Yvm43vT431?=
 =?us-ascii?Q?PHBqNvKmcg1j1IQqlUERPKMSxUr+aF24+6hX6EtcQMGT9J+AY+GdYdI4fPN7?=
 =?us-ascii?Q?X29dV5WnhChQq0G6zwUgC/J8yB8rhHpRPsXqjxDZmK4UJb0ibvjTM6qaxI6w?=
 =?us-ascii?Q?PIL+CtmvDAOUaeABUukJ+OBEH5GrX6cKqW0PUtRUFAaAHIXR9rtmd3bQg8N6?=
 =?us-ascii?Q?rkf7PVkW1pvhaGDk5r1Jpsu8QBCDqD0WvGmLw6c77P4dLZFv8/jMn4dQECbv?=
 =?us-ascii?Q?R+Wq9frGRSlewMt7etCWbMeerD00fY6yb1Ol/acAAFtxXZvctmlvnGkq8iFm?=
 =?us-ascii?Q?d9Cq2tgIB1jGyBzq/Kg+F0nHK5NEJHLBb2TflDTEHkE01cAB8agu5ghy7T9B?=
 =?us-ascii?Q?Th8eHYA/bZbElfwvJnCQsblYV3oqyEVkvvIPrvJnNREt9qWFCfD7P9/ByIuM?=
 =?us-ascii?Q?bcPinbHDN+g9Lpz7hUpPtLBk1rCwT8uIE+P85iOW8uFHp+l0sR7JQrvpY61J?=
 =?us-ascii?Q?xLPmahNIihOmNHZ9QIexyaGIqByNLIgQ8yl681uFwRszDpTVUSU01K6hij6q?=
 =?us-ascii?Q?Hedv9veZwR8TiOYKWZgjFlnnf5m06up1wvewbiSK2h72pX4AxlBK28IHFuQc?=
 =?us-ascii?Q?rPWrk992Up6tvJhaCZD0dnkQtOmYbW3Empdn//KLDA7eQuaHr3KKpm9dq7vC?=
 =?us-ascii?Q?cSPCQFei0PiOjAHQWJhthSHQDuWhC+w4faN4BkYfnnIwr5bHeLatDumwRJig?=
 =?us-ascii?Q?zzq9EbzXHMvJsG2XAtARlCg3kzwDQAtXWhy/20dxFNhVOaXrodTjR0PPii+5?=
 =?us-ascii?Q?/XqzjzG6VpjosVs0688HmkcRvu7oylfw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ViE6qLzWxsebbiPiK62R0gKDsbnvriDIP2Jc1GoO3TiNVuAH9dn1xHdRRKUD?=
 =?us-ascii?Q?NdMvchAlLjji/C3nOTzlj4v5s/kXP6COhbxZpYS119Fu8eIh3Uu8n6TRsPtG?=
 =?us-ascii?Q?GIwqfkW1rE6/mmETd2SyRB4YwOKAz/9G5F1PH+n/34LuZlQ9r5460hWmx605?=
 =?us-ascii?Q?++INEf1jJwtaFyrb40Udi7e/KZ8KUC8Gl/7LW3yraGbPH3OG8oFP6/NOI2Fj?=
 =?us-ascii?Q?q4t4HF7b5DAwZIR4so3EgSJCHh431la46o9J1JHBFfBYOIhYasxOYA+p2OET?=
 =?us-ascii?Q?e0sO2f8aebY34ygr5kr0DwDuyKsmkp6iZxdTUaOicntKTs7KU4QmfXtsGKnm?=
 =?us-ascii?Q?2BFmw11hKVoTLkHxiKETwyIre2FQM2Kz5MFkvj7saOl10CWxlnC6yDISfUsl?=
 =?us-ascii?Q?NnTdT9A537uFVihxyS28b3Az//ZUHKdgT248V7UrdXIhlFcXLmyDIHqU8NNR?=
 =?us-ascii?Q?3RBr5T4u7SmVZ5kl5he/kLrCINMlu+caB3u9gIorXM7yV6Wgnt5d2h9bVWx3?=
 =?us-ascii?Q?fCZOOb/k7+ig5SLieTrhLPRZtODdqOcBFp4mJhi7LeIowGCl/BZuP8a7XouA?=
 =?us-ascii?Q?cDPcUQZMW3V/2TdUzyIZF4m2e6BoBhdQXbBR5MSpPCU2LDfB+Ui43VvfGl4Z?=
 =?us-ascii?Q?SnIrkjh0BTKr+idUSH06gVYXs6mKVOffQBxc+gz/V5PqJBi5lVHBt4W9/Zuf?=
 =?us-ascii?Q?bEWjh1L3cfuLuspu+G1tQqRSfjB6k6m6sPHSGmP9YPRf2VZq4JvhwrTivTXw?=
 =?us-ascii?Q?wXDMKuoGDkGzpOMMBU/+LkxcQgScdnF9EHyxqkU7Id2Co7yt7wRaH8vMP2cg?=
 =?us-ascii?Q?XP+KdSH1W2XvoEWgrlJJkTyyVZ0zzVnbTBpKKi4SRjF/PyermbR7YkN5Y1XW?=
 =?us-ascii?Q?0z+2tCEpId+G+NC+oIKPK/UYXjsjbAa/U8TBCKNK3uZrjeZyYUDLiaYKE69n?=
 =?us-ascii?Q?pyJhjCP9Jeq02PhbvDod3d8Lrc0xcW2TOY490nSkUoBtG5YjTyFIvZO3Z2n/?=
 =?us-ascii?Q?nbN3SCJu88Fb38SgpAFHg9yvJ98lzQxytOJIiWPIpZGaGSRHeVnzrBi0CsCc?=
 =?us-ascii?Q?lCwd+jmHIyenl7TC8vSqJYaDHAa47VIBKpXDqxFzbQTeV72QGKE3eromVE61?=
 =?us-ascii?Q?uWkYJ8QYeOyifw2nHUKtixCrYynx0H/Sy4jxs8tnlrgmLX5yu7l4ipjWXB2W?=
 =?us-ascii?Q?SyPluBVHsrMZdFlDrZkSI1qpwFtiNzIhSRyr+vLflxEdUWZiCs2G6NHDT8hK?=
 =?us-ascii?Q?+bZm3QmYW2tUpMVw4NTxtrnAwtBFDudLjKvBZttvEQh5l/0uQ0GIirwpP2A1?=
 =?us-ascii?Q?nLr/Fd2MZRdVuxSv1UfFzrlUIitLEzxV4CkRh+Bky2TuaZoDnPIotIdKLhvQ?=
 =?us-ascii?Q?8bNrAsYv9/fS6XxM1CWOcoMNK1mkao6n6oBcjoF2t8kqPdJeql9mHu1Ojez7?=
 =?us-ascii?Q?TvZw/RviApgA0aaXTUicGKgRFA85aYfKQTZiYQSrtEWpZta6K+78ACeTJF/m?=
 =?us-ascii?Q?FzFBSjYLiJbxOTWv5jSYg9AZrAZEfTiiXZ2r17M08T8tWeAqUTXnC0JfqfSl?=
 =?us-ascii?Q?LXnktKjfIT8e8GgUItU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a93ff65e-4f13-42e7-f58b-08dd5218f216
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:42:05.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Offi4S4yhZUpg/lUAukhGNEVZ5c6Q5MyzY5cHTcHJZTeaLhJCQ+RG6eJl0exBqJkiRQdKZO0qVliAZqA40KZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10371

> I'm not sure "correct the statistics" is the best way to describe this
> change. Maybe "keep track of correct TXBD count in
> enetc_map_tx_tso_buffs()"?

Hi Vladimir,

Inspired by Michal, I think we don't need to keep the count variable, becau=
se
we already have index "i", we just need to record the value of the initial =
i at the
beginning. So I plan to do this optimization on the net-next tree in the fu=
ture.
So I don't think it is necessary to modify enetc_map_tx_tso_hdr().

> The bug is that not all TX buffers are freed on error, not that some
> statistics are wrong.
>=20
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 01c09fd26f9f..0658c06a23c1 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -759,6 +759,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk=
_buff
> *skb)
> >  {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(tx_ring->ndev);
> > +	bool ext_bd =3D skb_vlan_tag_present(skb);
> >  	int hdr_len, total_len, data_len;
> >  	struct enetc_tx_swbd *tx_swbd;
> >  	union enetc_tx_bd *txbd;
> > @@ -792,7 +793,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
> >  		csum =3D enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
> >  		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len,
> data_len);
> >  		bd_data_num =3D 0;
> > -		count++;
> > +		count +=3D ext_bd ? 2 : 1;
> >
> >  		while (data_len > 0) {
> >  			int size;
> > --
> > 2.34.1
> >
>=20
> stylistic nitpick: I think this implementation choice obscures the fact,
> to an unfamiliar reader, that the requirement for an extended TXBD comes
> from enetc_map_tx_tso_hdr(). This is because you repeat the condition
> for skb_vlan_tag_present(), but it's not obvious it's correlated to the
> other one. Something like the change below is more expressive in this
> regard, in my opinion:
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index fe3967268a19..6178157611db 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -410,14 +410,15 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
>  	return 0;
>  }
>=20
> -static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_bu=
ff
> *skb,
> -				 struct enetc_tx_swbd *tx_swbd,
> -				 union enetc_tx_bd *txbd, int *i, int hdr_len,
> -				 int data_len)
> +static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buf=
f
> *skb,
> +				struct enetc_tx_swbd *tx_swbd,
> +				union enetc_tx_bd *txbd, int *i, int hdr_len,
> +				int data_len)
>  {
>  	union enetc_tx_bd txbd_tmp;
>  	u8 flags =3D 0, e_flags =3D 0;
>  	dma_addr_t addr;
> +	int count =3D 1;
>=20
>  	enetc_clear_tx_bd(&txbd_tmp);
>  	addr =3D tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
> @@ -460,7 +461,10 @@ static void enetc_map_tx_tso_hdr(struct enetc_bdr
> *tx_ring, struct sk_buff *skb,
>  		/* Write the BD */
>  		txbd_tmp.ext.e_flags =3D e_flags;
>  		*txbd =3D txbd_tmp;
> +		count++;
>  	}
> +
> +	return count;
>  }
>=20
>  static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_bu=
ff
> *skb,
> @@ -786,7 +790,6 @@ static int enetc_lso_hw_offload(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
>  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_b=
uff
> *skb)
>  {
>  	struct enetc_ndev_priv *priv =3D netdev_priv(tx_ring->ndev);
> -	bool ext_bd =3D skb_vlan_tag_present(skb);
>  	int hdr_len, total_len, data_len;
>  	struct enetc_tx_swbd *tx_swbd;
>  	union enetc_tx_bd *txbd;
> @@ -818,9 +821,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
>=20
>  		/* compute the csum over the L4 header */
>  		csum =3D enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
> -		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len,
> data_len);
> +		count +=3D enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i,
> +					      hdr_len, data_len);
>  		bd_data_num =3D 0;
> -		count +=3D ext_bd ? 2 : 1;
>=20
>  		while (data_len > 0) {
>  			int size;

