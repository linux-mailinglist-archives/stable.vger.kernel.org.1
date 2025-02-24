Return-Path: <stable+bounces-118697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA1A41480
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 05:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60151885A25
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 04:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21881B21BF;
	Mon, 24 Feb 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WJUFfAEZ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF294400;
	Mon, 24 Feb 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372155; cv=fail; b=eGA3tX7Nhr8zcxI4zvuaMzwv0N6GqxyySSnTZOZXy0qD/Q32YiK0EGdotMvJ6lh+R6jcmxxNdQtElkLqPFaC0f7nrmdJ/17/7i7IMs3+6l3UWajNPcsc7OdTMJPFicaR2vZmgTBFmMJ+e2BZ5LGTvpvA2f2jLBusiSBA+mFLBpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372155; c=relaxed/simple;
	bh=3rhsFTLyMiRKg9ryY3mhM1a32PLUESJTSmRLCTxf1G0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ps+NH0K7neQXxhHNI8jwGIC2d3U/1ZYmR9+IQDG0Sk2fbrkM2KsEKAnktkMfrbctmnLKszLGUwTF+81JJGZV4aEs1Me5qdWn7zs09FPHtGX/Sh6O5dU1C2M1bljZmKMBGpfsMJnDHX8pcCq9D51tMsuGSyCKTIHkfYPIkQusNps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WJUFfAEZ; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWrh++VgV7MqZXOJCB/Vblut+Y3YbPbaANdtwTSkTIWOkEhsL1tdVXHzkfTWSsPAkINsFKSd5nv45JJbkmpp65I63Sr1r/lAphQ48xtFYPa7e5Egoy0ucFeA6ueSIuA11AgdqtDt2ylkvtoHi7TtlD6kOFp8vajAR+c/spjagMTibXF0NLOyf8vXz976FikdovnKzE8nIBpl1NHpHxM/xDU/xLfhVTzdoI/q+cXxKn3kuc0rYW0j94MtLS4e2YZWkeFGC3+CxrHrQWBwddNuHgBszmeo6KK7Ug5+q/+RKdmxEbQiO9U34qJRDwR0EPqv4dAHSjsaaCeZCd/TJzMn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNbJj+c2ivj0Oh/FmLJuUa/K3dvM5X8j33mZZ2YUlec=;
 b=i5BgLiatz04ltdwIC3arI0Qg7WvhVeyTtJHxkSARSb97O9stkuhN6za5NQAl5gRFzdgkr/I77BejAU+OPtN8vdLDyCGUZ9q2M3jSwyrzh6idIQ0LKby1vBW8Z1n9Rn2Y9yavR3UbMN2hp3EGu1eePYuZd2Plc4vj7fmDGtiK0/XOt/h7mnZDjowlklWSft/LiYDRfXZD8YNyoFg6HdxWy/RnpGtlXkeHi/IlB+lL9D8ZVG1v9OxuOZjzGjQsQBlC7tl7+urrYU5bh6a5V05NkSXymKEDKUeh8hxdRXgAEZI7iqF/oFACCiV/yrdEdERWOgTdLMwQqEEFSZRhiRDBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNbJj+c2ivj0Oh/FmLJuUa/K3dvM5X8j33mZZ2YUlec=;
 b=WJUFfAEZ9F/n+DWBRMfsfRPyNLWrWABKRW4hzYj8B9/zbFzcwXGaadSuZU7RdvPRsw3XY2qWAR8vmdNyvaDqW289Nc1SJv0BkZET/miFZU2fRVj4rvhB7Cdf0ckhhrqTXw/00wLu9VU9iMx1SR9AfTWg8Nuqph7Y73i7Lw3HF8doM7pH3WYCgv+LyE2P5qgEr9KsaR/Sbih0A6kBzQ4I00O7/oAdWsHXS94qzy1PzQNksQPrhiQt/iwGBimusdh4Zj41gWBHRN20puCDRSjI8fuqdimeeZg5c2OYp9aB8ihHeiDbOZYQLxlYT7ncyyNi0qGomFMdeXta0rxIqnGW5w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10596.eurprd04.prod.outlook.com (2603:10a6:800:278::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 04:42:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 04:42:30 +0000
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
Subject: RE: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Index: AQHbgpOTkcGlUe2F8Uqdee5IlYnyh7NQZPOegACoNSCAAHQsgIAEUdIA
Date: Mon, 24 Feb 2025 04:42:30 +0000
Message-ID:
 <PAXPR04MB8510A88FC949D501E5767FB888C02@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250220163226.42wlaewgfueeezj3@skbuf>
 <PAXPR04MB85108B76779CDD5C6F862A5B88C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250221093027.wo74lqkbycky2vu5@skbuf>
In-Reply-To: <20250221093027.wo74lqkbycky2vu5@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10596:EE_
x-ms-office365-filtering-correlation-id: d62e899c-ff3d-4aa6-ed60-08dd548da59d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Evo0UJ3wN3lnTuLAhXtCq4OHrEuDXBsdAkoiGTRPlWmE9DNzk9xEPMDLIlF?=
 =?us-ascii?Q?D7dRhCj4xbylqOJ7+C9x+teXVIZdk7C8hbSUT89hX0zlA1IoMnAY0tv2rWI4?=
 =?us-ascii?Q?tKm7dtMqvjT+OU2MqU/0sbzPcLSJ6pHpIq7FvePTbIUjbBNYo86aj62cHoR+?=
 =?us-ascii?Q?LU0aOLndIPqhdwhvQk/Shvd2iaIK2OO0UZMFLP02d+nzo4oHxodNBgQoHr1B?=
 =?us-ascii?Q?gnaG+I+v9vFGfSCS3Sd0Tz6bmCSerCwrCIJUK5PFLBFvO3f+nNTIcnK/aOm6?=
 =?us-ascii?Q?Fg3PgwVPt6bntAdH016S4Nwu3sNXpqf00geLPpVdsAsmDLiqpC+ViboG1iNv?=
 =?us-ascii?Q?kX+rr7xsSM/GsAau6CnC/XsqdpVwmyP0tuFBT8GLDkieQpg8L8RNxTmR40EH?=
 =?us-ascii?Q?a0jpaY8o9VxsbQcuy4hMGL+D/PbX4Oj7DqSKO1T5nxUcaLOfz6L3NaCcz3Kn?=
 =?us-ascii?Q?3wkSsYge1N6RIlqNamoQANGq18+ctDmiD/fWsaG1NVFQ1gDlwVMw8A1lWxA7?=
 =?us-ascii?Q?MGlAvTzFch9FvdULmcE91ZHI+omUZCOsw11c3/LkWTYrJuFjJcphPQxDVd+t?=
 =?us-ascii?Q?iE7vZFdDnY4H/K+T4RjEGX6H5w9szutKG3ALsS/HgrDEhSfTeBqX9hUmpx4G?=
 =?us-ascii?Q?zhzJ7Ww+bbKXDGrtzIKsQ3IXvSLZEHD3Vx4UhG/lhkMPfSXp3G5N7T6Bpbma?=
 =?us-ascii?Q?/hB6YzWGcnghzHc5+nE4NdvXDdZtpCJHQNDii9yYqwwbu9T6mMoDEoOhtCtG?=
 =?us-ascii?Q?yqcTw8eKy0EUD2ZmAw1VKUHNEGSN4+Bn2LwQc/+qMUIYHB9oMyY2dIUWc7j6?=
 =?us-ascii?Q?ArP6uUvn+PGVaySnx1Yd5mZLMJgsmqNf3ljsmuktbzLOKPb+StN2CVXWt+Zd?=
 =?us-ascii?Q?5qaLknVTLHCOkLjoySmihepbJBWYntERdDrQm85wQZpLBHisFEjviTgecML3?=
 =?us-ascii?Q?7msZhCiwLzmplNwdLcd9NleP/mftG9WdP7Kv95ICBp0P2i+yHWCxxXCpY0gs?=
 =?us-ascii?Q?mhB6UwHI+EZD8PW2X009s/AmQ77xs5+/8P8AqMx6kY889EaXaKqV1Q8eDmXe?=
 =?us-ascii?Q?wO1tcRweANACWYri8x79iQF3PRPbT9PfSj/LauJ8lxZNjRJ0ySiF0+1FXStx?=
 =?us-ascii?Q?YFPr7mWXu6qUqxauNqK7216RKYi1YzmeqWcLZzioM6Jrm7wB1F/G7pZS98kM?=
 =?us-ascii?Q?SkKUwUskccjWOiwhtDMT9YGeCOI6hsza8e/TjkoWHy3ffrlkdeE0jGo5foqw?=
 =?us-ascii?Q?ZSkLBrU6hQf3rJd2BptaE84uevTuF7q8amCTtvsquaY1bDbKwWnJOIDjNvtn?=
 =?us-ascii?Q?iWwI2BTfou6vv1XnxuQhEGStIC8ie9aZ10FZleJGx8W1z82W4Sj4wl/ZWPMB?=
 =?us-ascii?Q?g9OFmns+9QF1jgLmffDQRiN9S4jJrGrCtdXLrwc7FU0nMFobRjw6QDEYPQ4S?=
 =?us-ascii?Q?xEI8JamPRF/0qP1ZNiHLJPDLRqYWvQXI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8FyQckGxPNaF+5GUBcJa/IJnQuUITNxC3lo7Qg0vhTesrY17gu8aKVJ7HofG?=
 =?us-ascii?Q?p5q7VFrLAO37QZJSXr98/VG2A5y1yy4ruUAkd3uFWqW/0azmDMFT5gNiicBa?=
 =?us-ascii?Q?0B1oMSuzd6Ug44mGjSuumvzefMxgRX71VmEvgEV0ej4jb3gwt9qq0LMF/eOC?=
 =?us-ascii?Q?mAVIAMIyBqMY3LZ9oLc6lcOL/ebu+e0Z5QAx04vaVxJdTt4+F/liPy99N22r?=
 =?us-ascii?Q?YrE/OhaYe01HlFbw3pqgpAZG1QHBaAAIzW5ytFLptFfRAiats8Ki+4aXuoee?=
 =?us-ascii?Q?hRrV6La1WpbbzBnUUmTfC+4riYyEvDUR0cgR8Y9Y9qJp7ntyu6TVGpIrsgB2?=
 =?us-ascii?Q?rlUyD2LRKNFb7uLLBibuZxgea5iin50QBgK2aXWqhC7aJ+yAQ0nWGBjjKq7g?=
 =?us-ascii?Q?YHhAfWv/UTtCeAKMZGlhh0hVqdiJjU77zuVbfm8GTqr/TPBlLYyMgMBc2s8Z?=
 =?us-ascii?Q?8DHmukhM95miT4UbLzUARnshkeX6JovKdOgX8MP2Ccgabub2X2kNmAksc2R2?=
 =?us-ascii?Q?EEIe7wAy7ukGeWz6M/CPL3eNvIwG407/7t9yZVeRmWHWws36ksCx+DcMqhoF?=
 =?us-ascii?Q?NFVOQ15WKxxIA81BJvWdO4ZBstGl4K5/EKpIAcYb6JtQ1a5LYIB8nVYAAXoE?=
 =?us-ascii?Q?UjRIR8le5Lo0nd9moyyVODWiGJ28fiqt67FhjaU7DdYDn2mZRoIQ1YvV8IHQ?=
 =?us-ascii?Q?6XUwxHFreAqz4i5cbFuB2PXEnIwoX5GNqANGfiZ1j/j7IdzSoMuM9okGHIzf?=
 =?us-ascii?Q?Qwk/9rR1UadsIZHJOOBW2NvKB3D/rYsmAsybDEerSuKA7ESaMOqRgePDYVtx?=
 =?us-ascii?Q?LXzUCH/6luoOL1r5k2lt6SbatHVKyIRHpR1jPPNlEanyhVQbHR2YDRCKrkbY?=
 =?us-ascii?Q?cUtDnlajPiAbJyRSDNXgBt1rqYwuBQUqC/iEaKt1cJnECWPBDHdxykCMA+Te?=
 =?us-ascii?Q?WU68dSJpNA7mfuq2NT7xm9zduSJiFI5K0OCCPSak5FQhQolDGjwhmw0w8TcF?=
 =?us-ascii?Q?RhhsJxGcJZr+OeqrvP4iJy5kjoNUERmPu5sdfu8IyY2IiikN8S4szjfTAkcp?=
 =?us-ascii?Q?24XfzilC5Ymas0VRasRzLPOGl6zbhNUPBwS4pkZm35mxlL5GsDJDqLu+zs+p?=
 =?us-ascii?Q?agWh6UXPiBRTG5Lu84hDiaXRqAzKuuM+U1R86gp+DjShg4/+4pIZUHJVp4Rb?=
 =?us-ascii?Q?mpGCjjxELGXM9aWegpO0Coal/wCIOfuRy4fUymzbsFphwAmAlCixP8/xG8b6?=
 =?us-ascii?Q?81yHV0JiZnX8pEFGYNvoDcNXmruB4kltmIvF2UHB6KwOuJneLnKbQM3sUzWQ?=
 =?us-ascii?Q?TOtVG+fImzMP3t2uQ04MvwH4UPHqSMEkvsdf+CPiwYEkFMsHthrTbNTqoFbp?=
 =?us-ascii?Q?/HQta/ViIKd3T/9Dims+d6P5dYcA13/O+jJMnQQUB/fF3Jh0kuKUI9mpNoAq?=
 =?us-ascii?Q?dM8+uePO9Jy3Cvu6ayNIxA89jlun77zMIBGkMYOvtIUlVWg6QHVeIcSwq6wI?=
 =?us-ascii?Q?J+35JljPx1EKEZjnRb3vtK0Sin5xhEy3zy4fTS15vNld9zRK3RoAW4kw1iXR?=
 =?us-ascii?Q?yOmauxv/ZVx9WNZh3tk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d62e899c-ff3d-4aa6-ed60-08dd548da59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 04:42:30.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Og6mKJgpTLyEy4l/dIuFpzHP3lgiDKj/l9c3qeGqbV79IPrW+0fc+kRzPjwK/yqvbx6YcPayuW65kGsadtxCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10596

> > > +/**
> > > + * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buff=
er
> TX
> > > frame
> > > + * @tx_ring: Pointer to the TX ring on which the buffer descriptors =
are
> located
> > > + * @count: Number of TX buffer descriptors which need to be unmapped
> > > + * @i: Index of the last successfully mapped TX buffer descriptor
> > > + */
> > > +static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int cou=
nt,
> int i)
> > > +{
> > > +	while (count--) {
> > > +		struct enetc_tx_swbd *tx_swbd =3D &tx_ring->tx_swbd[i];
> > > +
> > > +		enetc_free_tx_frame(tx_ring, tx_swbd);
> > > +		if (i =3D=3D 0)
> > > +			i =3D tx_ring->bd_count;
> > > +		i--;
> > > +	}
> > > +}
> > > +
> > >  /* Let H/W know BD ring has been updated */
> > >  static void enetc_update_tx_ring_tail(struct enetc_bdr *tx_ring)
> > >  {
> > > @@ -399,13 +417,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb)
> > >  dma_err:
> > >  	dev_err(tx_ring->dev, "DMA map error");
> > >
> > > -	while (count--) {
> > > -		tx_swbd =3D &tx_ring->tx_swbd[i];
> > > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > > -		if (i =3D=3D 0)
> > > -			i =3D tx_ring->bd_count;
> > > -		i--;
> > > -	}
> > > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > >
> > >  	return 0;
> > >  }
> > > @@ -752,7 +764,6 @@ static int enetc_lso_map_data(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb,
> > >
> > >  static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk=
_buff
> *skb)
> > >  {
> > > -	struct enetc_tx_swbd *tx_swbd;
> > >  	struct enetc_lso_t lso =3D {0};
> > >  	int err, i, count =3D 0;
> > >
> > > @@ -776,13 +787,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb)
> > >  	return count;
> > >
> > >  dma_err:
> > > -	do {
> > > -		tx_swbd =3D &tx_ring->tx_swbd[i];
> > > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > > -		if (i =3D=3D 0)
> > > -			i =3D tx_ring->bd_count;
> > > -		i--;
> > > -	} while (--count);
> > > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > >
> > >  	return 0;
> > >  }
> > > @@ -877,13 +882,7 @@ static int enetc_map_tx_tso_buffs(struct
> enetc_bdr
> > > *tx_ring, struct sk_buff *skb
> > >  	dev_err(tx_ring->dev, "DMA map error");
> > >
> > >  err_chained_bd:
> > > -	while (count--) {
> > > -		tx_swbd =3D &tx_ring->tx_swbd[i];
> > > -		enetc_free_tx_frame(tx_ring, tx_swbd);
> > > -		if (i =3D=3D 0)
> > > -			i =3D tx_ring->bd_count;
> > > -		i--;
> > > -	}
> > > +	enetc_unwind_tx_frame(tx_ring, count, i);
> > >
> > >  	return 0;
> > >  }
> > >
> > > With the definitions laid out explicitly in a kernel-doc, doesn't the
> > > rest of the patch look a bit wrong? Why would you increment "count"
> >
> > Sorry, I don't understand what you mean " With the definitions laid ou
> > explicitly in a kernel-doc", which kernel-doc?
>=20
> This kernel-doc:
>=20
> /**
>  * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer TX
> frame
>  * @count: Number of TX buffer descriptors which need to be unmapped
>  * @i: Index of the last successfully mapped TX buffer descriptor
>=20
> The definitions of "count" and "i" are what I'm talking about. It's
> clear to me that the "i" that is passed is not the index of the last
> successfully mapped TX BD.
>=20
> > > before enetc_map_tx_tso_data() succeeds? Why isn't the problem that "=
i"
> > > needs to be rolled back on enetc_map_tx_tso_data() failure instead?
> >
> > The root cause of this issue as you said is that "I" and "count" are no=
t
> > synchronized. Either moving count++ before enetc_map_tx_tso_data()
> > or rolling back 'i' after enetc_map_tx_tso_data() fails should solve th=
e
> > issue. There is no problem with the former, it just loops one more time=
,
> > and actually the loop does nothing.
>=20
> Sorry, I don't understand "there is no problem, it just loops one more
> time, actually the loop does nothing"? What do you mean, could you
> explain more? Why wouldn't it be a problem, if the loop runs one more
> time than TX BDs were added to the ring, that we try to unmap the DMA
> buffer of a TXBD that was previously passed to hardware as part of a
> previous enetc_update_tx_ring_tail()?

Based on your definitions of 'i' and 'count', you are right to say that it'=
s
necessary to roll back 'i' because the last 'i' did not successfully map th=
e
Tx BD.

Regarding to I said moving 'count++' to before enetc_map_tx_tso_data() is
fine because the increment of 'i' and 'count' remain in sync, so 'i' will n=
ot
roll back to a value less than the initial value when err_map_data occurs.
So it does not affect the DMA buffer of TXBD which was previously passed
to the hardware as part of the previous enetc_update_tx_ring_tail().


