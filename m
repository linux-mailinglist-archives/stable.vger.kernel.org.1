Return-Path: <stable+bounces-118695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FEFA413FA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 04:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13703A9DF8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773861A23AA;
	Mon, 24 Feb 2025 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mob3Ona6"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DC1F60A;
	Mon, 24 Feb 2025 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367635; cv=fail; b=bTaI3N1NLlsIdukS5Q8imsq0a6nzSvtQqL38lOmM34yvW/q1wVkPmMdhtfEI8kPBlt73ZYYCg0q2KD3JNoYOAMWw6NB4mkL+NkuiXu+/cAfBVCJtbCEw4dXNCdM1QJ+pnj1nHkYmDRon0Pj0rYXEd/RxlNgK74JSHqJWKLWuh68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367635; c=relaxed/simple;
	bh=UO7I4C4xQKPZrMIaZCXJE3y1evwo9y9j3OTVgqB+IMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCFVVczYEZU0WSa4+WVQLZC9NJDLI6YDC+O+LsTdsxNAm+Tyt/KohrkUOxpr2QAFZRUz/jgKqWWjit1OCogQXs8k3z6ZV4f+mpncdAUgiQ+1eeAWEQwjLmYLHBdxka8piL9oj4ar7J2MikQ6GwHV+P0MfwA9TtH09TPonKsI5ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mob3Ona6; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDhVhBRCPJGTMlfKYB7bRmVDjMQO4+1IYnuCvtYsVIveGXLNCIaZOQMq59eGbOdp4a/JSiFpAk4m1F2IzObM/hBpBnYRrmkPpsISTmdcrvLZvprw/8Ry3NvzM5xR+OO2SXov4ClS3ANwuLdypUk6Ur2ieovPSYb8EwGB6CLouAObU4U/44vqZUSGINHJI4e5hcwacuVEfeeqYFsIKKB3Vbgi6Wd/6S34pqYqi7ZQvCyRtnDmTnc17qmf5JlGvsBlGgzt7xn8V6O/mHg81AzpT2tPRFLe1Ffqw883NPpth0JTLMO+2fKTbBnTN+qWBxKnE4Aq+T0wK9sd45VovHsprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO7I4C4xQKPZrMIaZCXJE3y1evwo9y9j3OTVgqB+IMg=;
 b=t2DzixT5NPB2d3IVTFE5r06SLZdXzC2c0kirZahChyfAr+6fP1N1nVdInwOp6gnMKQ4B8YKF+x02ntipclpNp9MhsdRSzNIjtnn3GxCOWjzxDASiBXZzerly8KFhdke9QkvkAi1kjqKt2UWFGIFE/VpUdf4X9nimYQN/uywzNyklYF0W2/+s7WzzJABlK2FwmyncGFgvcMy/Q/xCYSnLSo8KAbmmOy1XK5i7JyqFwQmNcz6XRFUlZi74hZtep0NBehHtuNpftGWYcwcQunOJ7+dteKzlKan1tina5ndgf98EcgyXjFUIHjsVE/Y9AqUZFVvyCUpOlavywVio1QLrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO7I4C4xQKPZrMIaZCXJE3y1evwo9y9j3OTVgqB+IMg=;
 b=Mob3Ona6sebitd5+b0GJv4qcDRQ7/C4yX8D3qW7Wia87H3RuSLu3hlhO0xMxkaBE0tyjdfWK5E4EY6sv3bbeiriztISonGWXMRUMgV9whLLgQlkII3Q9+5fn0iPNcFP3snQkG5qDyh7tP6POpvmAhpF6QcsDa02Do5i3R2bCguA+xjLJxLBNs4CVXmgbchMLEj5Yg4J6iy04vj0S9fJ6YjWQZWpyAC6szDXTRSTErE30KpQTvW7hlvgpYpPlCbYHG+UVAqusIshSWjwWLe4sB1Cz1eyDMej/8htoRjUKYZ/4eXR1NZEZu8F3Lz4xbgr/MO+verPIQ8kBoewZRcGVCA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10555.eurprd04.prod.outlook.com (2603:10a6:102:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 03:27:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 03:27:10 +0000
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
Thread-Index: AQHbgpN/Xw1oIgK130OBsitj8eB9+LNQXDmAgACfT2CAAIJ7gIAEVFAg
Date: Mon, 24 Feb 2025 03:27:10 +0000
Message-ID:
 <PAXPR04MB8510EA8BC58E151B178F684188C02@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-3-wei.fang@nxp.com>
 <20250220160123.5evmuxlbuzo7djgr@skbuf>
 <PAXPR04MB8510D3ACAB9DD6C86AC87E5488C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250221091835.g6ybtng4wiltg4ii@skbuf>
In-Reply-To: <20250221091835.g6ybtng4wiltg4ii@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10555:EE_
x-ms-office365-filtering-correlation-id: ccd0df99-ff77-4971-bca6-08dd54831f73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FYOw/2fZ/Z6JMZrP5Y74JK21yT/G4SDQzrGbRIB4/FkeKgU8K0YYZf7H/j2L?=
 =?us-ascii?Q?q2cktp8iUHAEoCuBGwULoXuIHdLsdCOEUBsuiPUdGEuQaS2eKYyauzNkV3U4?=
 =?us-ascii?Q?7OEUhDOWv6zDnjT8KV3PoUlxQWijAYgEpL2por06OUdclGn/w8CiDs4cn2lA?=
 =?us-ascii?Q?4VBmSyvfWCDH6ZLtx1cFlP58JHw+smdTgP+Xukw9A3r902oYXURH3+HxEPFy?=
 =?us-ascii?Q?PF+VwgmeX/CRcZSG5O2rtVNLax9domzvLQQHr7dfML60nmnUtgUtM7pVxW7b?=
 =?us-ascii?Q?S4tNhMuTWcXGFzKPvKlp/rKDALP+sN4m2zfnnUUQbpcPE+nIdahQ5EyTlqPf?=
 =?us-ascii?Q?Nzi+8PP156hlLBkoCzx+P7qXOm68FK77GJyaVQKd+zNS+dK15AI1Rm9bZUPP?=
 =?us-ascii?Q?PKp3GL7BQkUlkOkaTehAebggDfZ3V/a1qX6mzhiN1LEnEhHHi07iO0UshgId?=
 =?us-ascii?Q?89XDsiwSLyhnWLbEz7GR5PSoxrystJu9icrbdxN9s4FQEliWfUR11DvxtnP/?=
 =?us-ascii?Q?4/l6ooA/Jh/gosPDIWiO5glVErSd+8/SlPgxOYmSjZdr+Z5lD4Ydj8YGMCJj?=
 =?us-ascii?Q?rSkLVAX+9W/+AUqMtJ1X6Gc1MqLRlHsllEacxAtty0qW/GNldsUjgkLdtNIs?=
 =?us-ascii?Q?/G1DjrEL9SMdlgmX7K/XWNLTfS1YPVKKbUegy3ny6fU+RKoxe7zMwrF34nS/?=
 =?us-ascii?Q?4DYpiGbUtnGi1kh4G/7YEfHudtTn7uEW57RauckeE4cQxBUTQheRHyzRmr4I?=
 =?us-ascii?Q?Xqra6J7qwPvc5s4J/dxMeBYLPIk31XbZZsJAjmAlIrcZ3bPHiOEpdxbsyphc?=
 =?us-ascii?Q?JsDh2tY6fCYgkoJQG/b3yRF1zJcJy66gwe4s7idxHlT4BrV7Yay//+74cZW0?=
 =?us-ascii?Q?ZAUXmRa3gVztyZksraJnV6tqkvx1cbiDC1T+upxB1jfxO/U88yn0DQNybqxp?=
 =?us-ascii?Q?98kkNOHOr8lSqHrUjffTqB9lijkn1Q96Af+ZEwtp07dHrvWuZoPYf3fPSNFZ?=
 =?us-ascii?Q?SJjmpG+CQb/OqepIJ2RylmRKuwfZHKk7t9v2yCw9v7FzNmEPNTenyqEygJK6?=
 =?us-ascii?Q?VyIAjp/JkYRUrVNh8R289zQe0ivNBDyVlTmsUJ9fIEiZxWcIXIHrflgm3nsu?=
 =?us-ascii?Q?ysL2IXM2gIGYEfpA1o5Y1EzXZqds41V/iEIez3q4C0bbYb3hj39J44vL2Y2O?=
 =?us-ascii?Q?wP/q+Dedr2UxICnF94cfPtKkN1A7ni805QQR31raQrC4kXm4B/uToLOvWDy7?=
 =?us-ascii?Q?YnE7poW3Uv3ru1sLC5qhUyCrFHb0mbq2nehnt2FEcH/0BrUIVvidVtxUBra9?=
 =?us-ascii?Q?yW89NAcc6WVXxyYLQnogsRoEXA9bAd7EeE6TGIpUj0Yx0GZWgega8Ta+HvwF?=
 =?us-ascii?Q?UHRymD3RuWc9M95T4qrVsp/ymSKFl6rYUD3L0nbpN4O0NBmzCy1bC43pivzc?=
 =?us-ascii?Q?JwI7SnxTsVSNBMY4Kw+At0zkUHn3hKQc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HAUO1z49CKP9KtakeCkxUMg1N93njy6hzNiqoS3J/6ZdarZlENVUlO0cWYhZ?=
 =?us-ascii?Q?XSp4VQpL8wBcbsUdziC8NS2Bm7IgyQJINP9I10j/AIVe/1HBfbSBazD34fgb?=
 =?us-ascii?Q?GEuJs7RWHGFGuAsD4ZOSaalLVjCy3TgLYVsf7lXm+9AW9Tf8UwN4n6GXFaPm?=
 =?us-ascii?Q?NkCseppOIgDQ1LS1jGBkMBlVNLIR0ETDAoo7YuruhDj9GtBx6N4doGDXRP1R?=
 =?us-ascii?Q?1SC7t7yk7mF7Pb3WG2t09WpOt+aTuvvqMay/ehgK+KcS4shu51XYSXiJH8Dj?=
 =?us-ascii?Q?Xp+tnc0LDzLlVtfKQl8s1mIi/bBYgEiZ1S7okEQ3RG7IMMGiLVh7eVVSl8tt?=
 =?us-ascii?Q?z3J/HOgMd3AP22gukcNEd/lLu9/a+WkzcGoKxwyB82QdM11+CfC2DnUiSFZl?=
 =?us-ascii?Q?F2Pn9QVdA+AZ2JblFunznPwZ8BsxqpQsBwGyOEpUyB6rbaCbzcbqy0Uxtqps?=
 =?us-ascii?Q?uO+pco2UTx+hXDsH9SEBcDFcykjiSdY16NF3oSzfvi6We3440Cd8w6j7+xqg?=
 =?us-ascii?Q?s5ohHzT9abAF15wgPpxR80hm8KpNoE91XPATpfk2PsrZln8XWfgqIWVpU5mY?=
 =?us-ascii?Q?+kt7AlVSe20WTtknl1H9QRVbrNhCg9o6gFFGwFDlYfhoCVLQqu9BW/21MNqz?=
 =?us-ascii?Q?D9JNSmR7koATCtckUBda+bCcMcFTc30N1sGIS3qQP39DEGahYahWxBCPGE3w?=
 =?us-ascii?Q?/VnRUWsGaLXg5jENzBBMOfcETrUt2/vGEGtzbDc/T53/3NcNLg1AMfSdtRh2?=
 =?us-ascii?Q?85QQIk7kOqeGmMsDiqkApwrYf9PV+/QIWFJ8JQ/Ls/qzEzI5e68c7OwjhFAV?=
 =?us-ascii?Q?VRW1BFpi7ewUUEeYNDKUBPHklBEUvqUh8j73T/Xbbdsxs0IhENY4RhQn9cVn?=
 =?us-ascii?Q?M0bxBVddhjCuboHATPXgBD/ZdLLGsVUs/kxmAUMWMXDSU6Jk2v4h4lQT6+6X?=
 =?us-ascii?Q?ayZ+Z3tymeFiQsJ/OCajL5WQHxAcI0geBClT3voO5fOzEXjXSNqSKTtpJ6YA?=
 =?us-ascii?Q?QYjbfdOAPe+EHMtJAvQ3zWPYXQgqtMyLdXGmQRUTvNAhmepK5xQKVs1LVFVl?=
 =?us-ascii?Q?kP813kT0+NViyIxTv2E+99YVONGUrgxY7Yf0p18BR5/ACgeUXQNnp/umwW6C?=
 =?us-ascii?Q?ghdYj67H1Mz1mDlkWYjl8+sB8ZZLTIti7SOTp9cnx5s5rYZNCkYG4lSjFxip?=
 =?us-ascii?Q?cuMNd3HGihTYSkPt5+TnN0XrsJGl/PISSZsaNC+lwIL9I8ZXCN9tiAAdqlzz?=
 =?us-ascii?Q?1Vu1bA2Sv1kjcQga8mEY0tsUDQKtEAY+//XYy9Z1Nbq5IvvFaxgjPs3WvOlQ?=
 =?us-ascii?Q?Aw+RR6hNBWj3Wu3RKAB8BYUn2FAfwZVtPT+SOmW4B6gNMQTQ8J+Ua79TqrpK?=
 =?us-ascii?Q?VLgk7+qHB2VhKZr6SVHtmyhq6nuQVDuRs99IbfDi4rrLVaJEcZr5LRNx4oxr?=
 =?us-ascii?Q?Um8oAkI+4Y0DRqC0IC8xklLw7q2GFYXDYGogyrSLZ2Zb9Wr13gSfAg9L8IBy?=
 =?us-ascii?Q?pcIaFPeeQ95benOUv+rl4kJxW2cz781+ngYDZEHenItlylVGTP0C/eQ6CQrH?=
 =?us-ascii?Q?vxtAiSZqhTftCnlcXrU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd0df99-ff77-4971-bca6-08dd54831f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 03:27:10.1293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D3n3R8SiO7fUYBZbgN1hQt3Fe/EG9h+CfhhIqEPtM9JJVtdgSobDrwZkt5sLWF/Z5vFEj9ghE/xzy8yb7sUSGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10555

> On Fri, Feb 21, 2025 at 03:42:05AM +0200, Wei Fang wrote:
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
>=20
> You are saying this in reply to my observation that the title of the
> change does not correctly represent the change. But I don't see how what
> you're saying is connected to that. Currently there exists a "count"
> variable based on which TX BDs are unmapped, and these patches are not
> changing that fact.
>=20
> > > stylistic nitpick: I think this implementation choice obscures the fa=
ct,
> > > to an unfamiliar reader, that the requirement for an extended TXBD co=
mes
> > > from enetc_map_tx_tso_hdr(). This is because you repeat the condition
> > > for skb_vlan_tag_present(), but it's not obvious it's correlated to t=
he
> > > other one. Something like the change below is more expressive in this
> > > regard, in my opinion:
>=20
> It seems you were objecting to this other change suggestion instead.
> Sure, I mean, ignore it if you want, but you're saying "well I'm going
> to change the scheme for net-next, so no point in making the code more
> obviously correct in stable branches", but the stable branches aren't
> going to pick up the net-next patch - they are essentially frozen except
> for bug fixes. I would still recommend writing code that makes the most
> sense for stable (to the extent that this is logically part of fixing a
> bug), and then writing code that makes most sense for net-next, even if
> it implies changing some of it back the way it was.

Okay, agree with you, I will improve the patch.

