Return-Path: <stable+bounces-116684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDC7A3965B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBEF1886B4F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D222B5B7;
	Tue, 18 Feb 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iP1FX/rX"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5B14BF8F;
	Tue, 18 Feb 2025 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869382; cv=fail; b=m7w+8OUG8R40GQ+5w0pyB11esF5JCIhPC7knzRclnQ4jwU+I9ft4eZORnttlCUArDZhQ/+BQhFLrFSaU+gpEOEgf4gjx8IPrVfMgMqKHuRn2UoiPpQ3CJqOdeWL0osLR5JsJhzBV4tE1gn4CRb9FIU6ijWKZAMziZi+Uc5PZTy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869382; c=relaxed/simple;
	bh=+/muX+jACRdg8X5lc5fWYPY1SFAgZDTPqHqiBYWmHDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtQJjVuOHIQXGonV/noymNg/MVL1xhcJxl6QwEf+vV/Bn/Tm0zCQnu+2jBvOxlRIhxuNgJfipPOBvLQPzxHh2x7H/h2Jn5Zwb/JEucKg6NCfgz7Ljmlt9bezM7P0zRxwWZgJ81B7qgaZS9t52vu2Dr5WmH1O/RyH548sQ/iWh8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iP1FX/rX; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbaexMh5pT6V36q6h37yOvTWDwnx9UOZLL5/Q8jcYQcEsZVp4APRQYFZrUfNPgA1UkYoJMo+NpIT5jzbXc6aQz8EvzunBEDhCf1IXRAqahISDPLfxj1Wm7bQwtIoQGc1WbuSxqkZPg4XJCRpRs0UISCju0eQUuExdxLHgqfX2tuYoF5Whg3jlUrdCt95D6cxL7yf5gFP2roMuTiT1jI4vcBg6dFueNUh++JRhgS2y+uHy6k/bsmb+EARoAQ8+Eb7AB54esAA1ioaHErw5QaodINlXWnqsuUHpgKQcPGv7jFFUIKS9uu0wvh04v622G9EPlrIUYx/vW7fLzp/Gu4Fuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtSYWhz4/vyG9Zvm4iJE1k28LbEoMSY2xGgS+AnN22U=;
 b=GDBD94XmWPblLSseZlKxFJhONOTnIF2iAi5IjKi2NvYPqa817stKwx5qnFetvRVZk7Jo1LlDu0Uo6zAZaxdTYO/6tlNvxBpLmDUlQ800QJdpdOKlgjvuY+1MFVAxW8pVRvqZHU7SC6+XIbrVVzXbhTbGSm8kRiCCsNrGiJkNxHoR6Yk6L/1D1zCEKPNKTcJtGLadVFG2ptJV4tkIqenhga+1nMT94Lx3C2x3skwiApBTMuiIBXEd5b3mbw7NuCTbsxaJJQLfjzmEVng2/bl6O1qOIDIlsYkfO4xrDh1NjySND1ioi/0/KMFQ0jysj7UsnURF9XykIC0m0cE3jGnR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtSYWhz4/vyG9Zvm4iJE1k28LbEoMSY2xGgS+AnN22U=;
 b=iP1FX/rX+EJdQz9gsBGvDhaxwt38/AUNJuqin/7K2GIsYvKD7rbyFXFiwcwD2YWpXCcdZ4ZtWsWdmuW+EMr/WxFfXwMirfXLJ6xsHMTXMNWnlXYHCb+O5fZ1OwHO++L8tK5KmGHf/DbOALDtrPgJsjWePOUgHFQCDc2UL55FP4T9QA6W+UOjqY8XpP5LSD8K6HTzEouCt0efhURTnFGi3CtjoEMVmMlkljRIphFutgwrNH8veS0UxhPRPjVJJhPQ1SsGvuZtFHOuLS+NM74BmpV7RegaWYnqakghl21Teznxugrc6nuvpqlb+AZgbpGaKw5BA31KI//QMB5ryEoEaQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by GVXPR04MB10636.eurprd04.prod.outlook.com (2603:10a6:150:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 09:02:57 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Tue, 18 Feb 2025
 09:02:57 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgSIyYzp3wPB+I0SIp7LSGpxlULNL+EhwgABX2wCAAHR4YA==
Date: Tue, 18 Feb 2025 09:02:57 +0000
Message-ID:
 <AS8PR04MB8849AC9B20849B615AD5B67196FA2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB85105B5C71672A828E8D6F6988FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85105B5C71672A828E8D6F6988FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|GVXPR04MB10636:EE_
x-ms-office365-filtering-correlation-id: d3519ebb-6b1b-4b28-0f50-08dd4ffb09c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tYKRZQjHFg0lXgxKmGgBI1uMs/jelnIo+4HmEiDkrgoM0WvHWq4fT6/Pz+Nb?=
 =?us-ascii?Q?C9sRTAAMPxqlm6ENy7UkiYVvr2sofNZESRrLAjiiViifWY/1OdDE2g6h9Poa?=
 =?us-ascii?Q?BnjV0jcGnlCl7NCxE8shLcRL5DxnoWbi4Kw2la4FilKu5tTDIrDB+HpIwVlY?=
 =?us-ascii?Q?/XnLDa2ndJyGbe5xzdocfKSvu/lmUQIG6ZdP7yBSkQTw/ldqLD+bWXEUjwU6?=
 =?us-ascii?Q?o692jagqhSc+bsxsehE3m19QT7gEO44xY8p0Yw5jjjYhziSmK74MqVABIfPz?=
 =?us-ascii?Q?/8GaT/Hfi99v7PSbqa2w5wjnVmHZOvSIIKOq/r6XxJPFr+gjgIN+gMzrCx+a?=
 =?us-ascii?Q?JKNnrXM6vWQ/MM39tU4XFwNUEUyB1vOU4VodG9Bfg1Rsd4RTHvMJuniP5wBQ?=
 =?us-ascii?Q?rNr1UaKtjFen0lh1SwEXMllv0lN70jz/2tGegLiTMa63rSX9uFkg7VPaJDZC?=
 =?us-ascii?Q?9spGlMJlGjg97VEMYhPKGr0vbp8k/3p6kScjkSci1zSuKVZKGEIhAt4Aw1Wu?=
 =?us-ascii?Q?tE6zJhNXW1TlJYgqVA96OSgRl+PGdW7BdMcJjniOyWhybmpPK4AHERhiXMl/?=
 =?us-ascii?Q?pwosuSgpb4sqUxpPESbZSghXjTtzvV0d/6Wt6cLFZW9gNXsj/85EBiiSqJDI?=
 =?us-ascii?Q?wAoRuKM2I4ll3+wcCeOPtNurWA2Y6xNLPeEo71unEQEhsMcvWg6obSOjlLq+?=
 =?us-ascii?Q?j2YqDbgJmUdtaA33hAUDLDwh4uJHevKBgyrIi05xPkYIRYq7U1CZifCUMryM?=
 =?us-ascii?Q?gwm0IffUr2QbcuVjGavFHrK1ARrQJX8N0u8U2o+UGgAwcipcQ+XRHkni4jKS?=
 =?us-ascii?Q?ufhOMIM45bac+mwtJffU7LnPooS4kAX3UDUpCG2KZFGC6M+lxGel1Snn2G2F?=
 =?us-ascii?Q?W3g3/9Nb8qnDVbBViqSuj0OaPSLm8RTd+ncIZjlgDT5rLNbkNQ7kJIZUY9Lg?=
 =?us-ascii?Q?j5iA8ZDI22juiWyUPuyKp4VyXMW4W1ouPOqazlKu2x0I/7+JqCSeexX51+4N?=
 =?us-ascii?Q?3iQ9lZ7xpvvEdwHp92u/NHy1THIN3GQopfoQbf8SrfvLhBMN4IttV1D5NikG?=
 =?us-ascii?Q?Poxw+CSIwBPpW1MPL0TUbGQ65NxBb5431DGXjNt+ok4rnIGK3KhiVFLzHrIF?=
 =?us-ascii?Q?KNxajjBOcQXDx0g1Ts60oByeMdxh8v+6QvwX0F/GCKStVapSw36puk5TNWhU?=
 =?us-ascii?Q?5kQ6mFF+fJ5gTpKPq2K58A81fqJDk0E+EkzO2X7Hv9EsccA5lhK4mEn830wH?=
 =?us-ascii?Q?qiqr7Fl0HxRXiHJf2wR3AppV/ksIG2K+1vDLcaJdVzLqPFinKd1MNqPRdusj?=
 =?us-ascii?Q?Mf8v1vojJTKPxFlbdVN5hO+s6lFXt3oOm934CpIsJcwXYOPVvl0wAtSFBz8z?=
 =?us-ascii?Q?5rM/e899CraWVVCE962gakB611E27LtfVKaUY8m81S8HOuAw1YtKHX8qBwas?=
 =?us-ascii?Q?ipg4FzwjrKJTImJkn6RitNJe0MVnfWkr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oOFfywZtao97auaTv3qPHA28IIk2tl6ziRM5NNT2OctyDdxrZgOReLOKWfa9?=
 =?us-ascii?Q?I1ZTdwO0etmlOrNoJhwWoPi6UUHftXrziI1iOARRww9+gJQLPal6Pe1/Xu0D?=
 =?us-ascii?Q?AC5IJUFB/+sTvNFPlf3eJuJ7/cTxnPi+od0sSKLAfZxk8XZ4i6refxax6yIW?=
 =?us-ascii?Q?CtMyZujdXfk73JkbuFAIMtaXn0XPALQ9E40XWmKr3l4OdNl3Hq5fx9utlrn4?=
 =?us-ascii?Q?iKLtHAvY0qb5pFOG+HtN63ZUtdwL44BooYd31OzSfROGQ6DYuKwYAmwmT8ad?=
 =?us-ascii?Q?FNAGQuCOD0pi/5ntT9mJGfGH84gOqf2x/E9ilrTOmOhfcWXK8eGxk00s/T4f?=
 =?us-ascii?Q?KCj/HlmLIT8IkIJP8rbX35VnRg91iVKTlDWi2aJBuy9PgkCizNnMZFkG32FX?=
 =?us-ascii?Q?GZNHocGN6v1M5IGy4g2a6s2lL/JJNDEv6H6pO7aMyPjeNj0zuhn9r9q0EQRQ?=
 =?us-ascii?Q?kLPsRpnWlajlFKgdvclks0UydUiBm/kUhbFzpU6KqsNH9D0MW/TjxPEqC9rl?=
 =?us-ascii?Q?YKeNb/0ZjfuU9Bcslq2LtwYp5GzHIXSNb/s881SUcNGPQHDKkX4VRv5lFfSC?=
 =?us-ascii?Q?7mT8xjg/FierJbgFybE1SUUiFambNQLyv3LfRPfCJRkKk7xskN3JNnKf6DzN?=
 =?us-ascii?Q?FMYr+dVoLDyjhi833zD4nFk2Jzp3cliZIs24dpmZq70VrsQYseZ0wHTe6BNi?=
 =?us-ascii?Q?K443chjPqnohO3lIzJAIDtXhqlz6NxFPqa/uWS7q60WvLIdEO+6sw02GA6vA?=
 =?us-ascii?Q?M6SqBDmt0dX6GHdQFmIsdljGmGqTgUTTvzDYcxeaaLSi0Thlskbp8nAJRp7X?=
 =?us-ascii?Q?u2RPPAeCuLZuwvp/xaGJg7S29ClN3AeBE2JDWKIbbICkuJhDC0uCg9wgZXUD?=
 =?us-ascii?Q?0OzKA8p445dGaZCraxHgIK2AGwlveb9cKjxYMU/IOI0OBfPEtcDGSO9k4MP3?=
 =?us-ascii?Q?1jv27svwRGlpaviAH3NaKUmo0akHayAcXsyv8eLo5FH6zdK2Ntsej6B6lkWe?=
 =?us-ascii?Q?NGqNFexJKMfV8tZKyjgDLmF9ZkfCLmaX2ujwGv3RD/Vjm4zTpF6Vs0qrYR4C?=
 =?us-ascii?Q?tvGdxb/153LOQcwfoOxvFhVrlh+I1SoqKjaAyfSVQZgMcEdXzokyofJl9fVa?=
 =?us-ascii?Q?UlthnRX8hFd0W+iNTSrg+OSjljDTfALwUeNd3A3EbOm74zKApdpEzY3SmuNX?=
 =?us-ascii?Q?KCUNo3kJii+O0zyq1wBAdaKtI5RyGLDMPpAz9WTbwzcEPyrfzOyKSmFN+tXO?=
 =?us-ascii?Q?Q6r2OyUq2x9Vo1GsFVLliC+e1pktuapG8l8XR8n/3SeVmzIuySfbRcaTsUf5?=
 =?us-ascii?Q?pjyKy53l412X0ONXljheCS7qqKfH/wWCF5qF4AGNfRYS/8lRx5C4AiJBjnbS?=
 =?us-ascii?Q?suaZXpRj/Ug/p1cdoAcLJbahrJtCxzlXadeuPleuiaDYvzMegteQIX+dQycE?=
 =?us-ascii?Q?DJngEiYmrmYQOYZeLdtldsyCKUe1Q0qge3KkipjnJNIH/yNHeS4KehcbDEZU?=
 =?us-ascii?Q?8RXE5yYgY5wVdzVoh0tkjv+wdBbyTKNV/rddTatQciKeyJOfllmfGTMQwTr0?=
 =?us-ascii?Q?TQjR+ZEemT88wzYKI323OfTfaEIe6Sd36H+6h2/g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3519ebb-6b1b-4b28-0f50-08dd4ffb09c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 09:02:57.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wU062eGn4D+nxzGNpuhZp3XbAVCd3VM4yg+CrjKQ2sae7mevuNB+oEVvo3Xi5WhhXy5Vq0g3vcOHcWC29hZWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10636



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, February 18, 2025 4:03 AM
[,,,]
> Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> enetc_map_tx_buffs()
>=20
> > > -----Original Message-----
> > > From: Wei Fang <wei.fang@nxp.com>
> > > Sent: Monday, February 17, 2025 11:39 AM
> > [...]
> > > Subject: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> > > enetc_map_tx_buffs()
> > >
> > > When the DMA mapping error occurs, it will attempt to free 'count + 1=
'
> >
> > Hi Wei,
> > Are you sure?
> >
> > dma_err occurs before count is incremented, at least that's the design.
> >
> > First step already contradicts your claim:
> > ```
> > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff=
 *skb)
> > { [...]
> > 	int i, count =3D 0;
> > [...]
> > 	dma =3D dma_map_single(tx_ring->dev, skb->data, len,
> DMA_TO_DEVICE);
> > 	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
> > 		goto dma_err;
> >
> > =3D=3D=3D> count is 0 on goto path!
> > [...]
> > 	count++;
> > ```
> >
>=20
> Hi Claudiu,
>=20
> I think it's fine in your case, the count is 0, and the tx_swbd is not se=
t,
> so it's unnecessary to call enetc_free_tx_frame() in the dma_err path.
>=20

enetc_free_tx_frame() call on dma_err path is still needed for count 0 beca=
use
it needs to free the skb.

