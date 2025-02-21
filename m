Return-Path: <stable+bounces-118551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C62EA3EEBE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E0C17840D
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62231201004;
	Fri, 21 Feb 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1dLPTmW"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72A1FE470;
	Fri, 21 Feb 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126867; cv=fail; b=u1jLVQrEOhw4D0+Ezvsvx9VGXi9hRJUF20+A1hUvR11U2wjMTbNDZYVJFn//d2QXQSraEdG1Nc0t/7QfRGEw9qOt9X0rsmNPezII2sP8YivnI1y53NtElUc+4m1ZTENj9saBKHEAqcW/aDB4C8/4mozj3/r7JzWse6PArZkTCRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126867; c=relaxed/simple;
	bh=Zuw1C0J00DwoGpDHdLZlzdoKkJROU4M/D/hHzL5n5AM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRFfRPLx2uKHQxoOhSEznTAJnmAnfEv9jXtc2lj7Z7x/c9jh30lVVHJK5uU+RBzOsnW2ronL0Z9kvlUxq69ic5Q7AeJJR3P1jRXBg/LKPyQjaHVlE/QdkmjGAp75c5aiwWgatEKbzZ3/6PZDJyAUXAIYwLmFV1nG10uhVJbOoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1dLPTmW; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuyHdE0ZEBNIICCBDeGU0VMzC4d511BsusNw4vGA3qSrZCY6pLyUEexC0+QFHBly/C0y9FX1V90UYdsDiSqkVc6DpxYbNsvsBdW8fkosa3alw3ktcvzUeuCbSsyil9/vP+v+llIDuLfgFAXXDlxmiS9fI8PLgr/jAFwC7BqjvQ29SGUbFWlHNPVMGBvK6ke5rCOs3QaxXzUs3arJ1w3wlLgp1NnlQFYcHyFvscRVyVsxusz7r6ZllDijcWdCo/1pOJ4i+OPceHrXN3tEkO/xKoAyUFU1//TdRsROU/HAMPkp874ySrL+bxnuLFOyxW1A/u67TLgl0ypZnvYu17oZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zuw1C0J00DwoGpDHdLZlzdoKkJROU4M/D/hHzL5n5AM=;
 b=oZQh6pxLTxkL9LfVNFYUtUA+mNIl7QgCi4Wker4zuQl4p03SUPLaTypQ/DtGMNiTPlk0bHKrxvyTX74vnuwNFBMseODOilLnNGMtskf0UbtBuDCartXJY3Ns5pXVjYaCdt2Z8lP3EvtmyCfepT5PF+5hmmu7LfAoDJWuZsQwl7a0CGZdE/0wew0zdzBi19WUYEpvCIO4FnWElP9wAJvAhA4H78yAWuF90TM4UIbfGMjyusYzSC4akJDchrfGaKCtv+EQrB14Fc22lqHbH/cW9HIJiNQAywU/r5xvTsMsSJs6qmFG47dFvnigZNasVQYQKYdSTFCb7RX60E3jeqY4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuw1C0J00DwoGpDHdLZlzdoKkJROU4M/D/hHzL5n5AM=;
 b=J1dLPTmWRLutg8uLzOZ+pc34NDcbD4KxJ0c/wesYtgLEZbtMF9rclzbpv7x20QOpq7I8adMQzA5jWkU46WjSLMfzKBx0B3NMvCRLE3WiQbuA42DyvUk+iGLX3Zhsx9O7dNEAX4Qm6FjFYJBz/kepTQtNLF2NB292BBS4B50JdXES0HoFOlNH9MI58U5Vm9WEKomUd1woKc8ncWwgNY8cwvaG+IvjeQ7+7NMhtFt5jFMkV24KFTS09tUsMSecApGHSpkuI2mu524aFLTXHLJdi6O+ccwALJuvU4HG0CQbJPqJVOp1eyg21ZfMw5Fmdj2LTFTZI7XRDz3I5Zg/lTukoQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8654.eurprd04.prod.outlook.com (2603:10a6:102:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 21 Feb
 2025 08:34:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 08:34:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
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
Thread-Index: AQHbgpN/Xw1oIgK130OBsitj8eB9+LNQXDmAgACfT2CAAG2WAIAABN7w
Date: Fri, 21 Feb 2025 08:34:22 +0000
Message-ID:
 <PAXPR04MB8510ECBBA69BD5E50DB1C03088C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB88497C415FE73CCA84843CAC96C72@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB88497C415FE73CCA84843CAC96C72@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8654:EE_
x-ms-office365-filtering-correlation-id: bab1eab8-5ba7-454b-2b16-08dd52528ac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SkRzJfiTo38ysOReFMKX8MPTDSfXhUVy2HXvKKDTDpZoyPiTIj4T/Ddq9MID?=
 =?us-ascii?Q?da9EBaXVxdYbcCSPmVnODD3jEhmHIVvHu4IodIhZ8vlYlQKxGL0axg2hD+Ra?=
 =?us-ascii?Q?8z3P6AnDx39IXDnFC9eCn2C0qe+uC/P5cL4Aw+DUEQh/KkwYmqgJ0I94lH79?=
 =?us-ascii?Q?uEgNrqWC16mVGIGaVBAxQ0a/up83fJdyc8/ZspZ5UqHsKPzN4BEWY8ceOb6f?=
 =?us-ascii?Q?0lmSYias0EqsMAu3r0NyZaeC7PK8mJqSxAhd7uJiWeX3p1ayoUVKG4N2M9TC?=
 =?us-ascii?Q?0gqSYKBIaF0hJv+DUatLEVlprG0D8317589856AbItbWIPW5BD3JaC+Tn096?=
 =?us-ascii?Q?gzHf9EhUq+XxR18cLx3uwXYOZRl121/L2frY3KCkZPHUmf3rAwm83+47phCv?=
 =?us-ascii?Q?jbifxchy9fFT80yRyce5Dt47oTSmXWbLGTxbYo7oJYv3ifrQkkO3hs2mzcD8?=
 =?us-ascii?Q?BhhT9oou6Fcant9HOu5A0Ejf2PKzaiX7NZ8qSu++LdO3eqhi9EqudxODItLx?=
 =?us-ascii?Q?Yrgu0enB3fbqhEHOHDJliWVNqq7yb6ZMBiIdoIJirRfXwFKr5dMLTVkd8nsL?=
 =?us-ascii?Q?qe4QHKB9C0GCKYItcj78doVxn8QrMe+uXs7cvyC5QrQM+BjrBg5cQY/wqH+e?=
 =?us-ascii?Q?ZWytOj+adgdjvRM1ikzFQNfhhRQPwo/w2BFczxpVgEYXBAmCEU3qsxQpUH0U?=
 =?us-ascii?Q?PiLcV7RkZjXNagp2mtA8kHstceoeE6cUHvfxfJFlQ71f4p33ranBz7fijgsq?=
 =?us-ascii?Q?3pVJiVt9Fs3eRCdjXICxyigp9ZmiLIA9vAs27c8UnOYK2CHJi/KYh+N0jZ95?=
 =?us-ascii?Q?vJBFF/2Ui0uM5Aa3RRV21ye+2JHgUfDUtqsgLOTnVie7pZeRmEtdIWu3Sh1L?=
 =?us-ascii?Q?LU9aZHEVg5bAkfpmD1rCj4otvH0JoV48wXpb1vCEsQIHYiJ4urPHyRhdlTty?=
 =?us-ascii?Q?xGlzDp2monUBswQnV0zgWxsq1AwhbY8SVW9NdNRL/MIJjyhOGxl2J3GWpzPn?=
 =?us-ascii?Q?qNWqx7yTEebqPlFMpWKySC6NWtkD/QlX77ZXITOZEokGVOH3+SNBGRJQLdo3?=
 =?us-ascii?Q?Lj7A6drjaITRD7sFTOoBWOYR/awLTgUZ3z7Zd42kWV+RMBncTKQZZ74+mOO2?=
 =?us-ascii?Q?Y5Wtuv73PPDVwHzqZXiIdNui7hE0wNWef33B/n/znUNvsC0o/AL5UZFG2gSN?=
 =?us-ascii?Q?/tHU9zZT2dWKb3y2686+xtpe/bfz1+12OIV3mLYkjo0YzAYXIpSq/Oa8C8DO?=
 =?us-ascii?Q?4AcWLNWHCoDziNwKqb8rpp2baPsBgfmn42PIx6U+ioOuIDfA46ontbb8PQjf?=
 =?us-ascii?Q?vjuhSIsjRm5CQEqdayMOyCxENU4DztEgzpE9RlYerB729NJifgVWLgpUfuHP?=
 =?us-ascii?Q?cWgVcUIznMvN4/1kyOgGNuicF8Q1iQVR3tw06HF74AJ6fdPBbg3imzYj8ONJ?=
 =?us-ascii?Q?2apk89enOSE2or/h/Gt6dXLnh/yumBmQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bmFIBcrcMw9wSwzetRyKgQOjLA1/hFiJhGpdzncBfYUHZusga8BdOoAT0fSW?=
 =?us-ascii?Q?63QMUEDjRHGCbW1JJ+sLgT20XCrG7nbclo3YbjQEZIi5R7/NDUIea87xnhYR?=
 =?us-ascii?Q?hZqqvLfXnyjjK197iQvjRqAlavkmHfTqzojIDsM+A8HdoLPGDTskD949RgVe?=
 =?us-ascii?Q?Ra8VRCln1/nf2LQ0efo4c1lNJPiMlZK73ws23PBWCC56Hp/Ah18zrgTIwlK7?=
 =?us-ascii?Q?tvBS7ANGG8cFdW5+uBZ7KUWDutFwQKd/AD6ougAo8DCoPNJi8HC9z0y8laOm?=
 =?us-ascii?Q?y6i7N5N/8vyMDtgKzfxc3ExpdprFYXYlzAxaBAIyRv5bTdouJ2lCUqeUzYN6?=
 =?us-ascii?Q?XxFOYmvfLoaESY/Kkfuy1Yut9SlkwnmW2dqKNHEs4N0Vlk6cIYXetrxOeuDY?=
 =?us-ascii?Q?Jhjr5L1m4ubySD3tYv+rKfF4m1KJTjarI/mxOoKE6J3wwLDIBshzI5BQZCum?=
 =?us-ascii?Q?K41guu96oEEb51Ug5iuLGcK5wecs+xTPsVZTzpWbuJRnAHZFYo07SQjOQPL+?=
 =?us-ascii?Q?q+yEuLjVr4ucERwZY+n7/SVGHi1ecR8NFjvUBPclxgB2D/ya65MT0wm679iL?=
 =?us-ascii?Q?y/VRj/6MHA5VGWAzUqu91ODBYcitYdxERju8IQTFWmfj9/nx+sdkvjaRW6LH?=
 =?us-ascii?Q?zmZ0eXACdEyW7mSxHW4qOTqVK/muCJa7GGUTs8lyJ7LunpCepPBQ743o3EFl?=
 =?us-ascii?Q?h7jbNRo3Ifh0+NA1T8k6FgeaBB0QMyQqicPKdy7KAr4WZROTg/onJepqrMfV?=
 =?us-ascii?Q?5BlaVYVWPHLaLPtLXIon/V0hdkXyP6xaUcD3v4tdn/kg70CPUVeWvZUdcDRV?=
 =?us-ascii?Q?F8UJxAnegbshSFyYBOcSYGW4uAowOvlWapY7m94hd4ZP8wbxOzoPaZxyjTiy?=
 =?us-ascii?Q?gD4rSmleZgN3NTTrvBTTbVMd3MXwQ85OJN/npEVlXjOlKSxSXhI/K+VikJNg?=
 =?us-ascii?Q?5cMgFMY3IFdbPRqLNv71rPtJHpsHQiCcrgj8+3vxerWW+MCMoMT0mzDgIMyq?=
 =?us-ascii?Q?mkK/VHH7N5SOUKRcaYJCZm4fPYMLhjOYHTge1ZRIfE0FpjcP7MDAvOV6n2vm?=
 =?us-ascii?Q?pd9/1a/GmuQW4693p85iwYXnOMzjbn9HM8A1maw6vxNXqYuYCani4UEmjr/b?=
 =?us-ascii?Q?+uhrghFlIbNR8YHmS8JI+HzXnfTvpphO8kzhmpRWuLqKKVeHpH6+Wzp9ECil?=
 =?us-ascii?Q?cRFNyQ3wuFH6aU8RxPJCBHb3Ozvr91L2lQ1gMuQbxHeGh+XINhpVKzX6/RMR?=
 =?us-ascii?Q?7DZhYgibbIQAuNrL+6PYskS5Cd8cYARxlRhASeh6NHCnXpFCrihJc6lLOZ3l?=
 =?us-ascii?Q?uReOvZSdGHk/ehIBFILAM3tDqZjO6ae15aGL0OM0qyPREUuLa8oSVwlvzhTB?=
 =?us-ascii?Q?/7+6PJgDE8hs54fdsfgvmy4fUgdARz++7vFq+1TEKUCNUUWtETg9dHJWpIwE?=
 =?us-ascii?Q?dSECnCpLGiLfvDC282fKdrashp1pR+JBN+iX+obIbu5rHT9UwsoOc3E4P2Uj?=
 =?us-ascii?Q?tOJXdS6l0e87yHXzDISoHpYyBvS8nihZ8vw/BdGQZ5yZ3UIa3q7NurQVwOij?=
 =?us-ascii?Q?AlKCbUVoSX1QLPCM1R4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bab1eab8-5ba7-454b-2b16-08dd52528ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:34:22.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uepsqOEeBUwYGvqiM2mDr8MDTa7JgCQJO5tdTpjqMA00IAQPX/51U5eYjj+A9PBAP+KVMwYhehAhHPY4rUeaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8654

> > > I'm not sure "correct the statistics" is the best way to describe thi=
s
> > > change. Maybe "keep track of correct TXBD count in
> > > enetc_map_tx_tso_buffs()"?
> >
> > Hi Vladimir,
> >
> > Inspired by Michal, I think we don't need to keep the count variable, b=
ecause
> > we already have index "i", we just need to record the value of the init=
ial i at
> the
> > beginning. So I plan to do this optimization on the net-next tree in th=
e future.
> > So I don't think it is necessary to modify enetc_map_tx_tso_hdr().
> >
>=20
> And what if 'i' wraps around at least one time and becomes greater than t=
he
> initial 'i'? Instead of 'count' you would have to record the number of wr=
aps.

I think this situation will not happen, because when calling
enetc_map_tx_tso_buffs()/enetc_map_tx_buffs()/enetc_lso_hw_offload(),
we always check whether the current free BDs are enough. The number of
free BDs is always <=3D bdr->bd_count, in the case you mentioned, the frame
will occupy more BDs than bdr->bd_count.

> Even if not possible now in specific cases, there should be no limitation=
 on
> whether 'i' can wrap around in the loop or not (i.e. maybe some users wan=
t to
> try very small Tx rings etc.)

