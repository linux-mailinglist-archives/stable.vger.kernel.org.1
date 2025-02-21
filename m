Return-Path: <stable+bounces-118542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD0A3EAF0
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 03:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EBB3B237E
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D391D63C7;
	Fri, 21 Feb 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GnY//pSJ"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA202F3B;
	Fri, 21 Feb 2025 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106569; cv=fail; b=ODkPTkD/1iKXG94XiXF6eOQVjPkmGM+fqBsVeUhQuMr8OD2p5Oh9D7At3ZzJmkV/drWU550npqAfYkLKLaadojjSc7ae0gthpTMLakVaJoZv+m5XG2FApCYR3JAfHFS0yMpawzLoVeKRiioPDRDbT/Cs71CICWKGyzzj3L+UPSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106569; c=relaxed/simple;
	bh=dpB1wlxSs/CRaK2HnwPVc3IvJga8qSHPNXQMGdBD5HY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSQVEd/J+hqQ8GATGLiAtm6LUwSrfP5gefy629ubP66VjrHaa25feV38B6w+jmXw3V6blb+715yrtFd8g8qswHVmOl/Io5aJOUD7ms4sN5xPBGy0/I90Fwf1jv8Lb0VaYhHTT8BipoTx1OhNR87uN6cZJlaxsZvapyktiBZ+jsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GnY//pSJ; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAEb7RB6VBwC8K2AjOGaWaUmlX68GCxPWHPY0u4Zj97zfB0po08vTPQzmG/aBGDrFnYwmF6gvqhi/xkCi+Mopd63UgnIEc4WXm9FH/qhsPNrJE7T6gfjYvS28oIIzmZkp+fn4M+Bsy2wg/m5sZaM1sUvi5Y85ZU7FBfU7wTmG8DtBlLh6AiGutY579nPhssgEDPsXvnZq2yUO375LTC3wg9NrTu1M3Qa5Agwj9yDDyGeV7q180+lv+fkntryYAdzU1zEM5fqi1ugUuRwkPzkrvlWSAa2pv5twau4Sbe2X61NoWNSNdBCuAHH79HRAvi+cqo4OFIvXZozKAy/W2TQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkj1/7q3VCjNd4gT/zfnP7g/0xxnsgXlNckBMP5r1/E=;
 b=EBTa56wWbm05uxgnmfKhsqWFyq3/yWCTVuj+lrh9GpM44Qz7LmQbIY/sxfzXG8my2oRM/wRE8JCydYHTTAD6/e9F+Cn7vwIfEnnfDPnNDhDXyG4aHAFL04Jf9x37bf+1XVrET0WnRZCEyIX1Jgc9XrG07WnHcDHKcSDafIwLVwwVEKYBV6DWI97WmubDOkRx3k6gQovIbsT39tpp3NaLI47LDGG7ZJmQgnP40UgtZobcMnJx8vrrRWRN26/r5tJwGIT8UbnSX1yp1/EOTr1aUaXeiQ+8RPyumtzBi7J8eMlH/bUCdq2nZdFJOBn25/NFTChZHpmBSWxWL9T6u9T6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkj1/7q3VCjNd4gT/zfnP7g/0xxnsgXlNckBMP5r1/E=;
 b=GnY//pSJdpb2BKXJQXQ/K3TLOLuxCdj3XYQWn77kBknHY6OyqyERGepiiBjaAIOrAxKRMfBf256Bs8rm1MCeziWpKZXH4nHWyjKnBizfsT/C4Totj7SLf4IVFTyQ+s8g1w/SOP2uAcT8KrkHGxEG9s18RYnXv5Bll8hQ+zVh2AoHuHV4Tq+3Fq5kHEu0254QJoTqVWkTibz6s0tXhwZ0pAqBFyMVy6TOnA9bfF1uEMN2nct7R413Gd6yQP6lXz64QX8H/egycROrcaFUPZdr77nGVT5g0F7MF1Oh/BzVb9dF71mUQ1USyZpnaSvr0838hh2CJLCfxf+PR3mHJARW8A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 02:56:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Fri, 21 Feb 2025
 02:56:03 +0000
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
Thread-Index: AQHbgpOTkcGlUe2F8Uqdee5IlYnyh7NQZPOegACoNSA=
Date: Fri, 21 Feb 2025 02:56:03 +0000
Message-ID:
 <PAXPR04MB85108B76779CDD5C6F862A5B88C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <20250220163226.42wlaewgfueeezj3@skbuf>
In-Reply-To: <20250220163226.42wlaewgfueeezj3@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9710:EE_
x-ms-office365-filtering-correlation-id: 0929a42c-2ff9-45b4-0fb3-08dd52234776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+40Rx6NHiNy1S0Y6j1qttkI6OmU2DrhBq8i14AYfHmlS5CUK3TaygV+9LuWM?=
 =?us-ascii?Q?wPTvLQEwG9v/yY0mTWP12Sx+w312eQAK5vRzcr0/RfEKEC4xoUtm1Dkw7rDI?=
 =?us-ascii?Q?4IXCjUppfX5EQLQHmuITj3Ii9clzajVUuI9MjNsknzHa/sAsEMRbeievxyFj?=
 =?us-ascii?Q?LZwft1SJcpYxVrmU6x2tp4j0+6ZJZvNoQXjrT2D3xFHSR6jiFmPGTYze9h5m?=
 =?us-ascii?Q?WY7LqNgzxNFJ/xyEzi+YpBxoDCdeuNfVhiyW1fnYW1LXk8FeyOGZWcvCzEqh?=
 =?us-ascii?Q?L87YJFkbLt6fZ4lkkjBfcrEXKOzorDSwYjqxqlJKm4dt1lzQIl37Mp3Rpq7/?=
 =?us-ascii?Q?R/EqnZTeoS4mQQN8X+kzMSdoGELVELl3gaiKtP7rTlNbmVRBMJGT1A2ZKLjt?=
 =?us-ascii?Q?5B3ZuwiIWSO4lI3bWN8eY5uj5F88Wtt79hhm+SzSo1+yg7s7TrFIOIPw+LOm?=
 =?us-ascii?Q?N9Bh9Mrc23p38tznzBS4ZLgS0o4ZwfJr31S2Wp4yDxWtH0pCCcvoEKntwe1g?=
 =?us-ascii?Q?YY8vkEyg1EjKrSOk2RI/1sw7WyJ5o+TNOdQMq7edS9frQjADNLyDrcG70Jmk?=
 =?us-ascii?Q?qcv2QJGqpNdInWQToo4OVGM1JJYDIQs8Cx8lzl/c0KiJ9Q3tnU7VnFo/jebk?=
 =?us-ascii?Q?JAPzEIWAxHFQdsxOjfWXxgrfelR5WWSgluG967A8xuTKFOmBxic9SSi5IohR?=
 =?us-ascii?Q?vrskYx8t2NUQJ5IJB+Yc2GQGLz6zGjlJuO9xpUifel0Ffn/0gE5AU8h9CbIH?=
 =?us-ascii?Q?JtoRAuSOvU2PLxB56XOZCTRbNcxWORc4QXzsVv5QxAhW6EVOrDZx4NABoqj4?=
 =?us-ascii?Q?n/hsciLbappxikxuMLsQaFwBvU8Ld3dN57R3nKtexd4VVbBn3h5/lFkY1fBW?=
 =?us-ascii?Q?NwTDKgioxmJSoEqoeFc6xnW4ebtN/7xIt2hH1RKOuTzxvYLbNaoUycYtAgqm?=
 =?us-ascii?Q?CyVP4QltGzTGT7soz5D3KbCfZu9/d//AhW9MtSg3qgpnC1bCESpOigd7veAN?=
 =?us-ascii?Q?GU+wDB4912Y8Rzjd4ZYNhkPu1zHTnwj8WZg8qJseDy5UeG/KjdK+mdKJq0L3?=
 =?us-ascii?Q?Xul9iayvpgoS/ijS25tI8Uj2aK9xarc3kiVC6s3evCDwRZxmzZh8dksS6S9t?=
 =?us-ascii?Q?kYwYSeihqMJXaA520FY9qGV0MP1HZnLwzDBAIDr7tuGqm9emGL0D+5SqRbUr?=
 =?us-ascii?Q?8p0QYZsX5p6Wx0aeHEaqiStFyNXhPs/gCV6V3v4yvDJlK64u2r7rd/gL/qOh?=
 =?us-ascii?Q?Jr22Ry1fhl+6HMbh9IbwvdK8dIV0bdt11A1eAN+i6LzMh2v68i4NVCayw6bS?=
 =?us-ascii?Q?bhRGMSViW7TiatO7yRHejZHzL+uB4C88E17CLd+9+N01knP/fPfLzC8twXMy?=
 =?us-ascii?Q?5JIYiqRzOKLxPLgUYQKBqKcA7iit/a2qhZo41IzrFNUK3SayktHkIL/2kFVq?=
 =?us-ascii?Q?Meb+MNtuO/dxfp/E8PCZlcw+MUD/9JST?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F4lts+cdibUZXgTQRg0B87lYzxGuzIlqpfo7dv+V6BfiR7ERKy97I26/92jB?=
 =?us-ascii?Q?p4tjU43cSU+JVTmm5pr/npD4cSg8CL6+g7a9SMOnrOLKAlPABmgDqaJSKIiy?=
 =?us-ascii?Q?lbfbfRz1/g2BR3r0Br1mqRon/YDnMlwCV4rmc2gyTNo5nGJMUw8tgXVDOzmV?=
 =?us-ascii?Q?9EgeAyNYMLYQGe4rRUSl8C9iy5dDqwOAITSINQqMKvtwfHLtBY1oIos5O33r?=
 =?us-ascii?Q?efkxakRpjdnGzn6AFZ0zbgd6A6+AqNKJnUlx8Gd2ui18BzHJwsKp1NsEB3Cq?=
 =?us-ascii?Q?1nbKswhKKgZeiBwtm1v9a9WSJk29BHck7jaC2eB5lSilQ0OihJfAyfFwVpUc?=
 =?us-ascii?Q?J4+bJTf5pJu2vv/mfnfiM29y+EnC/PqMWDNTP86/3tAc9hSmZb5nEh2zGD8X?=
 =?us-ascii?Q?u7CcsIQRGpt8vI7YUyos6JU875+lAbvxMG/rpPqnOU6M7Cb5zRl4S1uCMooN?=
 =?us-ascii?Q?zEjdVZeZ6ATXmuABXxuo9QK7I4y5/6cy2tXNe7lG+OFAckBTpnJvTYVoJjqu?=
 =?us-ascii?Q?j5IheX2chGHfgBUx6y93ILkxizkTdK3ndPmSkt66P4MaqopO+jhbhVBf3es5?=
 =?us-ascii?Q?wxuNLKKhWXStcBdtLu44tbrSg0v9xY5bPernaSssm1dvZmJjOW+wYqjmwO5a?=
 =?us-ascii?Q?wNQ8+9wRPAq3jFp8PXUYm9iJiPOk3CFNcT+ta9yRp0t/zbTeUQqm5/Ilconr?=
 =?us-ascii?Q?tEgBG115pAWxRBJNd76v2HHnc0fBIFoaiDe2wuNS/1QKlDcTkdUqu0PkMv9P?=
 =?us-ascii?Q?6xRanfIM0qvvbhbSk3a0vCKtiE/GZSzaZqOdroDDWeEOoXcRhi/OPXll5IWE?=
 =?us-ascii?Q?ofUJlfyEX6Hl8vgFs96MlnLOpNVpMsvn1L9+VTWQogf7mbFNZnkSY+1+TtSs?=
 =?us-ascii?Q?6HmwSuDIAEqQ8GYWWMrtpEAWrguhb2f+et+8AFGbO1aDzP2cmYSqgpftCA2D?=
 =?us-ascii?Q?67bxqzBJcdRSNm1/I494HCOzPCY8ll3Q35fokO7t/cOzF9t/l3geo+CWEsDO?=
 =?us-ascii?Q?bgR8zUSACgsHU2jlqW/ODr3n8O8dXfWQY+WJLPpmSbim6gNAm4k2/9FSLM4r?=
 =?us-ascii?Q?++JJVAg5Lio7yQPIfOmacOBi7AlNTt2RC/hRFWoMge1oQ8kekKpBcWub+RLx?=
 =?us-ascii?Q?0EkJKtv+OFP2S/5GCDpm1SNTpH3o7hjEvrOcS9yX7KDOhqD/jP2/FwrdNaXn?=
 =?us-ascii?Q?w+qVt7oc5ZnwwuxqXt74YV5QUM4fpxWVbTq7uwPM5sPx1cv3t6R3IOQV/JVh?=
 =?us-ascii?Q?GWYnNCsL6hguNx23Cv73Rv7CGkdWoj9+JhfqcdnZwJLh1L9HAktkr8rplymP?=
 =?us-ascii?Q?CzW5zfKLiAtCxQX5jh7Db2ucBbf91/K9EZRPl159kH0Fja3sagZRP+2ddUvW?=
 =?us-ascii?Q?JZQXETkE9zWkrZlLc3/l0VjwEFr3k5indGD8ujJnZAcb+zgQRp2kRzgNn21y?=
 =?us-ascii?Q?w+YEOAG1CWPa+MEqnd8oflAnOGx6Xk8mYABkZSvgQC9d8/c0zaZWTMTiSvhr?=
 =?us-ascii?Q?JZ2wGG4Bac4/b5gS3ltpk/Hsu5ogn6cwRF8H7sVlUbwFA9++eDPlf7nmXb7V?=
 =?us-ascii?Q?1FR9hdRhXkJe245tNX4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0929a42c-2ff9-45b4-0fb3-08dd52234776
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 02:56:03.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuKA6iS6s55aJVXKdrYXYhof7jqnHwN6QYYk/pD91eDkHgeT0FDrC+dcZr0qiENPWcMO9k4YXKT4O1TtDhGVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710

> On Wed, Feb 19, 2025 at 01:42:47PM +0800, Wei Fang wrote:
> > There is an off-by-one issue for the err_chained_bd path, it will free
> > one more tx_swbd than expected. But there is no such issue for the
> > err_map_data path.
>=20
> It's clear that one of err_chained_bd or err_map_data is wrong, because
> they operate with a different "count" but same "i". But how did you
> determine which one is wrong? Is it based on static analysis? Because I
> think the other one is wrong, more below.
>=20
> > To fix this off-by-one issue and make the two error
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
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 9a24d1176479..fe3967268a19 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
> >  			txbd =3D ENETC_TXBD(*tx_ring, i);
> >  			tx_swbd =3D &tx_ring->tx_swbd[i];
> >  			prefetchw(txbd);
> > +			count++;
> >
> >  			/* Compute the checksum over this segment of data and
> >  			 * add it to the csum already computed (over the L4
> > @@ -848,7 +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
> >  				goto err_map_data;
> >
> >  			data_len -=3D size;
> > -			count++;
> >  			bd_data_num++;
> >  			tso_build_data(skb, &tso, size);
> >
> > @@ -874,13 +874,13 @@ static int enetc_map_tx_tso_buffs(struct
> enetc_bdr *tx_ring, struct sk_buff *skb
> >  	dev_err(tx_ring->dev, "DMA map error");
> >
> >  err_chained_bd:
> > -	do {
> > +	while (count--) {
> >  		tx_swbd =3D &tx_ring->tx_swbd[i];
> >  		enetc_free_tx_frame(tx_ring, tx_swbd);
> >  		if (i =3D=3D 0)
> >  			i =3D tx_ring->bd_count;
> >  		i--;
> > -	} while (count--);
> > +	}
> >
> >  	return 0;
> >  }
>=20
> ah, there you go, here's the 3rd instance of TX DMA buffer unmapping :-/
>=20
> Forget what I said in reply to patch 1/9 about having common code later.
> After going through the whole set and now seeing this, I now think it's
> better that you create the helper now, and consolidate the 2 instances
> you touch anyway. Later you can make enetc_lso_hw_offload() reuse this
> helper in net-next.
>=20
> It should be something like this in the end (sorry, just 1 squashed diff)=
:

I agree with you that we finally need a helper function to replace all the
same code blocks, but I'd like to do that for net-next tree, because as I
replied in patch 2, we don't need the count variable. Currently I am more
focused on solving the problem itself rather than optimizing it. Of course
if you think this is necessary, I can add these changes in the next version=
. :)

>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 6178157611db..a70e92dcbe2c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -106,6 +106,24 @@ static void enetc_free_tx_frame(struct enetc_bdr
> *tx_ring,
>  	}
>  }
>=20
> +/**
> + * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer T=
X
> frame
> + * @tx_ring: Pointer to the TX ring on which the buffer descriptors are =
located
> + * @count: Number of TX buffer descriptors which need to be unmapped
> + * @i: Index of the last successfully mapped TX buffer descriptor
> + */
> +static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, =
int i)
> +{
> +	while (count--) {
> +		struct enetc_tx_swbd *tx_swbd =3D &tx_ring->tx_swbd[i];
> +
> +		enetc_free_tx_frame(tx_ring, tx_swbd);
> +		if (i =3D=3D 0)
> +			i =3D tx_ring->bd_count;
> +		i--;
> +	}
> +}
> +
>  /* Let H/W know BD ring has been updated */
>  static void enetc_update_tx_ring_tail(struct enetc_bdr *tx_ring)
>  {
> @@ -399,13 +417,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
>  dma_err:
>  	dev_err(tx_ring->dev, "DMA map error");
>=20
> -	while (count--) {
> -		tx_swbd =3D &tx_ring->tx_swbd[i];
> -		enetc_free_tx_frame(tx_ring, tx_swbd);
> -		if (i =3D=3D 0)
> -			i =3D tx_ring->bd_count;
> -		i--;
> -	}
> +	enetc_unwind_tx_frame(tx_ring, count, i);
>=20
>  	return 0;
>  }
> @@ -752,7 +764,6 @@ static int enetc_lso_map_data(struct enetc_bdr
> *tx_ring, struct sk_buff *skb,
>=20
>  static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buf=
f *skb)
>  {
> -	struct enetc_tx_swbd *tx_swbd;
>  	struct enetc_lso_t lso =3D {0};
>  	int err, i, count =3D 0;
>=20
> @@ -776,13 +787,7 @@ static int enetc_lso_hw_offload(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
>  	return count;
>=20
>  dma_err:
> -	do {
> -		tx_swbd =3D &tx_ring->tx_swbd[i];
> -		enetc_free_tx_frame(tx_ring, tx_swbd);
> -		if (i =3D=3D 0)
> -			i =3D tx_ring->bd_count;
> -		i--;
> -	} while (--count);
> +	enetc_unwind_tx_frame(tx_ring, count, i);
>=20
>  	return 0;
>  }
> @@ -877,13 +882,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb
>  	dev_err(tx_ring->dev, "DMA map error");
>=20
>  err_chained_bd:
> -	while (count--) {
> -		tx_swbd =3D &tx_ring->tx_swbd[i];
> -		enetc_free_tx_frame(tx_ring, tx_swbd);
> -		if (i =3D=3D 0)
> -			i =3D tx_ring->bd_count;
> -		i--;
> -	}
> +	enetc_unwind_tx_frame(tx_ring, count, i);
>=20
>  	return 0;
>  }
>=20
> With the definitions laid out explicitly in a kernel-doc, doesn't the
> rest of the patch look a bit wrong? Why would you increment "count"

Sorry, I don't understand what you mean " With the definitions laid ou
explicitly in a kernel-doc", which kernel-doc?

> before enetc_map_tx_tso_data() succeeds? Why isn't the problem that "i"
> needs to be rolled back on enetc_map_tx_tso_data() failure instead?

The root cause of this issue as you said is that "I" and "count" are not
synchronized. Either moving count++ before enetc_map_tx_tso_data()
or rolling back 'i' after enetc_map_tx_tso_data() fails should solve the
issue. There is no problem with the former, it just loops one more time,
and actually the loop does nothing.

