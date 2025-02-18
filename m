Return-Path: <stable+bounces-116637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F165BA390A6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A117A2418
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A154670;
	Tue, 18 Feb 2025 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gim2CLL1"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB342C2EF;
	Tue, 18 Feb 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844172; cv=fail; b=gazQZQwiAsVhWgkQ/SboN16Tm6+hDkolwUJpUcKG4ilt+Sd0MCnujNVXf+ieJJS3r7Gp/Iqb/+xIhajQf8uPIG2RSojUkVSFinD7DZ+n4qBmICk/83PS5gGzXFwt2dLivHCg6i1x6qHvdk3jO8UQrY8mdyLujuzBRi5OFE4ZA3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844172; c=relaxed/simple;
	bh=okYipYZteUNSREsw/PVygNECAcf/ULUb+H5fefIoteg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlCh4BhpAdN/GNzzRPsSrmaa/sfExKEW7fnl6fvliIFGC6nKrwgvXHCYneaVbv5QwFOWI/sC+zTI5pImSyw45I4XMOfK0sVocGNECtipvQoqwIe3d22JvXYCEY0XwfM6eWXORdzuvMn8jsH/ymcDsu0dQoOWxqXEOzwYQ2qGvbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gim2CLL1; arc=fail smtp.client-ip=40.107.249.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ1gDhnV/4jZxtw2ONwDuuhX/OLyKcdloPoaDig7M3t6DLeNEmzDjKhR4/KxMBk9UcqC6AcAeP1i+flPJMMteEZACqQ2SaNGVmbuWZK4frYAFLOt3KjgWQbSHlH+/gVVY40IIleYRwL09n4/ZyJN4DFtDxM6ZYT1mjxKzjhbuqWXE6eMLyJs+j8Sb6JbM9eGN9TSZpXw5jngVGBsTMJOY2Lr9ctI9X5chA4TBjW0NV1lPZ/L0bJ5a0PZsDsq7XUuRh6vkm+Ros3gzmvsF2lxqJyeUZNBTiYiNdjeD9ASP8MVBwy434OnP/KP5MLjqXp0xcN5FtSE+JVSiHnUn75fSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/wP3tvF0muLQbruXobgPg26okswnEkNgPuHZkVmmls=;
 b=fQXTrUnuHME2Jizrf7SFD2b1FupPvH4vPH4J4h9A2x5mIW99B/f4PjYcBRpInR9TdDUUEtT35LiSWhLrZU2Q/fM3/C31XYCs4GnKxDJ38MCAN7owwn/oQ6oFCXhH3bJQ/osfH820VtA0PAgXOmxj68CWC/LS1gadsMfXior2rvUDY/6DiX8RGBlkCVoFfBn+X+RPqfF3Rq5VBejg6e6HjrQMihBMY5WG8h+19cQR0t16gne/N165qKoOH1xG27EizystLOZuvcOkQePaQONCfCbgrMr5KOv8QtRH2IyOXMkJJNI7eMtm62K0taMQkvaEDY2s5xCIoYRBMyB0NsaaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/wP3tvF0muLQbruXobgPg26okswnEkNgPuHZkVmmls=;
 b=Gim2CLL1Q2qMt22Av+10hmkU655nGEMyHMNDGP+xnVwnqAi6QcFYVtLBCml9eSX/7/Ww7BpTa7b1Q9ei03hCXmqMDniLrmgsWTpBiwbMH62Cu0pzmtnzMbgghfYTehJQ6e86/Cfhq8fl8bh6W+8tqwbCr3osiFOTqX1cP2agn884OKB+IWMM6AtN0uLIeNBnFNEUIk1mmV29eD2lO+qCrIbH7U/wV1OCjRFDMIZm1bRjVgf7HeDiISVmxQk9Oy9o5scDdd8+y9PGPp2YD6Dpy0LWZ9MA7/qJgZSBVjWb+Qgcw8qAFZk87+5CLgCDRzSwOvE3uCL1vZLc6UrPyL5uWw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8118.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 02:02:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Tue, 18 Feb 2025
 02:02:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIxXCrhXQUTvUaf5YMAXyCn+7NL+pCAgABPbpA=
Date: Tue, 18 Feb 2025 02:02:46 +0000
Message-ID:
 <PAXPR04MB85105B5C71672A828E8D6F6988FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8118:EE_
x-ms-office365-filtering-correlation-id: 8d7e29eb-8305-4150-e85f-08dd4fc05708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4g4Zm71z8Gyxd5GPe5MV+m3W1LqSQ7JOro3JjyY4c774nndNs0JW2SUZD7S6?=
 =?us-ascii?Q?bOU6qRsOhTONRwA7X0lGNCJsmOLDK/54B5Qix0fpRjHJbRUTKeXIuUttVQ0S?=
 =?us-ascii?Q?oMWKTSkh2tiiyPPimDF0NOzQkzXZGPX8sG+OKJvbBot4w4dWZPxfn/A1uyt3?=
 =?us-ascii?Q?cQ0697gqX+1QMQaqR0OZJcgnQzASnunDnXFz78woiat+pXnnzZTHZ1016mrO?=
 =?us-ascii?Q?OjXa13ZSqNaK0wMm/02LLdIPurKsh38bY9ZEWFsTB0w6zET1Hwq9Antk5R/m?=
 =?us-ascii?Q?1kYK0dAbJMnOdV8ToehOExCwsUeruM+EHSky9SmKCKpI2PdRe+zIlXIFJXZ8?=
 =?us-ascii?Q?NO5KMSzHC7aNb9xzncm5P19DozpX+BHDUeuR0zS00F6nCTvS1oGhOZTrW2+y?=
 =?us-ascii?Q?/B9njW3CVIdqiL4BcG1xYfmLhQOUkZXNmNW0I9VMbcUHl4x8Ar7GH71ROyww?=
 =?us-ascii?Q?+exGMAD2dzR/M2VtmpzW8lEjjMSOeYRPsOafNmJI2PCSUA9GJ7TYsKT4KSc5?=
 =?us-ascii?Q?UU1GbVabXwxe8uFHuTaet0hIpOsfgrD+zCFZOEwEmyWI6bHI0qlAHNQJxerV?=
 =?us-ascii?Q?pFlPEYl6aGVXosdVig/O0xhljFafvs1HpHBzDGsg3b5nlkmO6D9/91q8y8PZ?=
 =?us-ascii?Q?iLwwW1sJwpe2d1kDSIXzNrPi+wmcoWgs0nfNnnoMGrkA1Rg8eWoz7l47A11E?=
 =?us-ascii?Q?gZvg5aUksmhmZhMEtrvnZohQH64FZmrZEW5UBOCN/rWfbMWt317CAHOk6Gls?=
 =?us-ascii?Q?1E+O3Om5C5pIdwrTSCMncp4wR+pQ4wKsz1/RcQJ3kbcmEHTLrNfa9DTpo/Hc?=
 =?us-ascii?Q?FgpBZntGJwIBLscmpzE0o4UT0ZoAv7G/fFCjCbxsYC6yIz/HIacJD9djCHvL?=
 =?us-ascii?Q?uiSccsMsJRlUuM1hbkwHAIewkieaxB/LGaaYWj2001NTnvBsrDzsX7Ut8uI8?=
 =?us-ascii?Q?rvYJm5NsasNcKEtInBPIxhtXOf1DM8avIGcnil1QzToUxcEVxueDfEk7kPhl?=
 =?us-ascii?Q?76X+T208xa3TnYj3W7t+jbKZ6Wbb5vGVH1EE69hFgH6nlosuN/TkNLZChCOD?=
 =?us-ascii?Q?VFThWP+4uX2BzQGNWljRiou8jJwJUQxmBIZq2EQyqLRr66D5vXfPxvRfHg82?=
 =?us-ascii?Q?F6x2UTH6X81LLU2ouKA4e+gb30USksUsOdD3VnX8a21cTy68qm3UJD/gfk4C?=
 =?us-ascii?Q?Ji8Ch84Q8kqGBnF3Kh5YJEkA41CY0lBvD8rONN5pGg7cwMNMqU432Ie6E1kd?=
 =?us-ascii?Q?8XTRFjaiufwYVQQDa7i1aD3JpYEGhMXxLOk5wW1BVc6QQwZsVEXXZMPO4qr1?=
 =?us-ascii?Q?V+3CZCqptmcQFzdOu7RFPZnNIDFPhnbhmOlAfJHhVvnPO/767d4jsH+UVoh9?=
 =?us-ascii?Q?9ce7wKOzuL+egSBhSeMBVwqjOnUjZPayNHoqu3WasRfJWOxlw8ZJ+vufk6Y5?=
 =?us-ascii?Q?XpLY0ZBghXFJVM0BYxm+WodPNwTxh2yx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p8pLp0f9ey9l0rzIze9ygEsjo16K8HTTIDZALK7xbNBMGsUQ5D8myAQZtrC8?=
 =?us-ascii?Q?2GVqRF5vGL1XX4w68thG8snE5xvV0M7d4X4z6o4YEa3q2/jtqQonIWnFuNdf?=
 =?us-ascii?Q?AO8gkQyrVpHdeOfIQyDunXyoaUAPnkrQTmJS9TvmWIfPBFgLc4Feky2lPiD2?=
 =?us-ascii?Q?agtesCCtiHjAkzrU08NcdzFJAclpSmO8gJHGrFhER4QN7Nt01g0bEF3WtBo2?=
 =?us-ascii?Q?1dHF5/qrXnDJ6wKVHmnkzyPgfJ128KdJZNX49/xs+BHcIl9oVGsGjaOiPCxw?=
 =?us-ascii?Q?SwvBLrowv1cP/TXgY2I8E3UCHI2zjIskDz91QG1+Br+lQG/cjDnV9zbINPSo?=
 =?us-ascii?Q?Em+qv545nvqkHo1PZpc7M6E65v1sVmSdtWnZvaItDr5cF6wuriyLDdq29PH1?=
 =?us-ascii?Q?VOob8CRyNO/CS0nGgc4/UQzo4dm+rxtRsvmMja5F0ESINhftY1EaGwMU20dw?=
 =?us-ascii?Q?SMhhRqek9k37b3acriYKqg0n5CIcpA0OptS86yvOfD6jyIWACIX2Euv6pJkK?=
 =?us-ascii?Q?DUIs5AYhZkEEbFHSVtnxVLk6eWxNwKQaaGxm1GDaM3YLgqyR8Ddxm3eP1vr+?=
 =?us-ascii?Q?y7AU2OL1VjtzShLJ9mYDuijgQzoUm3SrjTS9Q0bzqxyYfOA6pL85mwTKf9h4?=
 =?us-ascii?Q?QISIAeavzhYKA6xqFbNhBT7zgLgsJIG0cjFmO32XsaW++fRmnkDiopEh21WH?=
 =?us-ascii?Q?MySBXPD/DF8QOrW0LTbNxmQWjzNRx6Bv2nTca/ES0iMkt7qDYAvmfRzawGn5?=
 =?us-ascii?Q?kbq+cNfBM0RyX8Vd6aF95Br8LmeleV7AjYmOKaepjquj1+SXf1RaMqDCIeiG?=
 =?us-ascii?Q?eGmEgJ680D9ybOXBYWQ2/NqkrsnUVd0KmG+duCRxoRniuYfc0JXljsriDZax?=
 =?us-ascii?Q?OqaZf31tIKd4ug2JJVze+zOTGVUySzZNTd+7cLcwSarv+SGxRVnBJ1/qz4I/?=
 =?us-ascii?Q?6xICzrNkx2zD6jXeEqLCMftHThmVo3KeGyysW2+kZH7cGQDvMciOmqXXk782?=
 =?us-ascii?Q?ZiOvTveDeRiyVTPdZbYfdpmwlTMdAYYT9PKeyqk8H6nhox5GPIqyWWcxjaJY?=
 =?us-ascii?Q?I8WMxT0wbYBNO0x5mhPCC17FOs+mt5ca/5MBSRWllwcy6beSAQ5FhfQUPYlb?=
 =?us-ascii?Q?iN3zmnAowVunqZq2lyXRmZz4kLa2bXem+0QmrE1SUjs2Ao7ScE4TRzTXaj/O?=
 =?us-ascii?Q?6WuXqCCx75Yx1b3QGnPpDLyQjfm0JiZydEC8JT6nqhePRU1sUOPujobInprs?=
 =?us-ascii?Q?a+ShO/hdR/aA+ROqo0W1pi6P1f9qCI40nQ8eBz+MU+1351BfrsXGBQQS83Rk?=
 =?us-ascii?Q?9YnefmWgNjoQ3UgXSgP1w0GH6JL2ich1chR1mkm02ngtiH9RF/hWBrf6NSyX?=
 =?us-ascii?Q?KcKrfjVqI2K2BzaOUDukRv3fImRxnXXztggFNC1LSGMZ7vRX8invrktaXIUf?=
 =?us-ascii?Q?pCN9IVx2xtCGz0CmW17yRnCDoEUERm7zEYSefCXCNYN5bC+TGeg8YXiIpEn2?=
 =?us-ascii?Q?t2O8W3Vo5NPhc1GgZNlUkzCCbMkF+CzRZmfMSn0cpKNae+R8XGW+yIoZZhKz?=
 =?us-ascii?Q?aVXkqaQ2hJvxxlvFxBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e29eb-8305-4150-e85f-08dd4fc05708
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 02:02:46.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdZR9ukAypIYE+dMv7BZWVJSpdczh9Ldu5Yk1smyGe2Irv/bpVfv0T2WEEkUgp9A1JgUcTjuxkQfwaDeG/HUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8118

> > -----Original Message-----
> > From: Wei Fang <wei.fang@nxp.com>
> > Sent: Monday, February 17, 2025 11:39 AM
> [...]
> > Subject: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> > enetc_map_tx_buffs()
> >
> > When the DMA mapping error occurs, it will attempt to free 'count + 1'
>=20
> Hi Wei,
> Are you sure?
>=20
> dma_err occurs before count is incremented, at least that's the design.
>=20
> First step already contradicts your claim:
> ```
> static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *=
skb)
> { [...]
> 	int i, count =3D 0;
> [...]
> 	dma =3D dma_map_single(tx_ring->dev, skb->data, len, DMA_TO_DEVICE);
> 	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
> 		goto dma_err;
>=20
> =3D=3D=3D> count is 0 on goto path!
> [...]
> 	count++;
> ```
>=20

Hi Claudiu,

I think it's fine in your case, the count is 0, and the tx_swbd is not set,
so it's unnecessary to call enetc_free_tx_frame() in the dma_err path.

But if the count is not zero, then that is the problem, for example, count
is 1, and then goto dma_err path, the it will attempt to free 2 tx_swbd.


