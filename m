Return-Path: <stable+bounces-118392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C1A3D35F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A77F189DC37
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127B1EB19B;
	Thu, 20 Feb 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdI1VtE4"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20641E571F;
	Thu, 20 Feb 2025 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040775; cv=fail; b=OYP7SVFwDUHLtP4zpJhDt5rbRCacYC+HPqjo6n6zgYuad8j8sYFPXIyHWTbCAINth74mn85dbZWtBESqSsauZJVP4rSr/KvtifpYC53zIpYzmN0xLDu4iamBxzubiv8plhL3PtEg6WoJFULk8XBTrxYN8y1VUVzBxGztZtLtt4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040775; c=relaxed/simple;
	bh=o1dMalkON8CjNu4+U+ZmyJPuMG8wMPz7Ct8Jx1y0LNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgtDHeiEa506x1Pg0HBSGxYhWYNQ9DpYZzCvPzHkb1H1waomjZp94nIIn2uFfWMWuaeI+TxNFGnQTw0zsDJS+Bl6x+/QQ8bgvXo6qcH3fzJSQfgJJADB5xiAZgS/NXiCME7dXY7dW/zrwhmt6ePGN8w1HArnzxVPj1p2WJZykrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JdI1VtE4; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKUY/dYvPxfsyUD3AzjgrZuHsKLJ27Hcvt6dwIKf716BUindHuEvXd/D2RiteCw96WX4L/hQj3+7pUeotnLTPDNVaOgpEToYpqEoAGqpafN6boTkbuvTJb4gkdFiK6FaLDyG58ZCxXm/e/u+GqmTvdfdV3/Q9Qkq4MLEz71JLeEMaPJc/UMR8zIC/Hk+aj72+iy16qpvF1kCIP/T0SeI1lVl2ERgQsQrm+Nist7Wfb1iaSUHjCC0ijjUh2MhlthP7EL/3YcWL4VBpxbfV0KRkdmQX4Jtr9EuwIyBQp9VChoIezc+o5yFTD5mrTybX67MJWy+57KxHiu9qrecD5gTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UKsuzgoc7p6vKdTvHqMpDTPbCpAAVnwCGVBtjUcKRg=;
 b=IXGlSn2B4CrOWRgSKv4yKIqZVx7MsJ+4TS4g7FtBTMF/U4jmbWPMvWFJ1whpE7zMh2BuJO1KZadVVe2ZUi/aExBe/zoyzxH2CXPKD5jpRNvwr2ca4/vvP8BHiEduDEFQhrhlO0HsDabpU0J6mQNNH3e7g7eazb24eBo5EQXWj/SwZKotWOlmKHoUZ/t6acHhS8geowpugV/20fbrBYaVG1qEspIBs5DjX/x449pXhHyCVF6GKo3IkXlGwWfglxDTo5KScglxI9YnvR5yN7GCfDqg1r4mCUZ4JMofw8lTpvgWlsmLnsKhj0gW2hSFzx3kBNdiFtZ+aA8hWLlLlE5Jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UKsuzgoc7p6vKdTvHqMpDTPbCpAAVnwCGVBtjUcKRg=;
 b=JdI1VtE4q3StlUKDAEkZMuL17Z3G/Aczogwi8z4PaMD9las/MSxk76q8fBGmjrRX2Vld6s5VA0j36o1zY7iNwUGl4f7WyA9skeDJ9FzS86JQp3mfKQhsDzUz/4+664dH72ARadImwiv7NjPzqoJA1lpyNrVhuGZCElARVzhAk8j3zxTTSkRpcMTCDuxZ0MAVdvUgBixb8vSFZz/EQwAtwk4jLMPHKrxwOdTpFymWXOD//bk74ja1s594NxKZaC17A8FNceuAHd9tQVoXnVQHLXbP50Cn+vVmVe3jFDYDSrSOp0MfhBmPTJgAx9B1uueZ0b2tMp3n1n4DLv3OsN2UdQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AM0PR04MB7057.eurprd04.prod.outlook.com (2603:10a6:208:1a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 08:39:30 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Thu, 20 Feb 2025
 08:39:30 +0000
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
Subject: RE: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Topic: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_tso_buffs()
Thread-Index: AQHbgpOU4gMYnZt/c0WSS3pD+9mhubNO3ySwgADGLwCAADs0UA==
Date: Thu, 20 Feb 2025 08:39:30 +0000
Message-ID:
 <AS8PR04MB88496522FC12613739B3AD1C96C42@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-10-wei.fang@nxp.com>
 <AS8PR04MB8849C3544A63C75E37D2079896C52@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB85106BF748386C843FE28C6488C42@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85106BF748386C843FE28C6488C42@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AM0PR04MB7057:EE_
x-ms-office365-filtering-correlation-id: 430c9918-c452-4de8-2d97-08dd518a1809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T7EQEzz3RdEl8k4wJYoSH7zVw5irfTiRqwV5F0zy508MUGLN/biXHlw/1F1o?=
 =?us-ascii?Q?/cGwF1F+UzzbjhIkefYHef/cEoQeJZNr2o27ljKuDNMlD9l/+c2aNO4U5Ce4?=
 =?us-ascii?Q?mxOyDurwfBaLmfBiPvd//2SbTQRPEUS+fjwvsCGJnKWZf90l1L4t4E6nPOB5?=
 =?us-ascii?Q?daL/UAaFoNQO6HhKD3NYkWlgmbB7EUbPSH6Dzqmb9LWiGvH9+XY+zrYMzGj6?=
 =?us-ascii?Q?hPOcgBSD34vYr2JiEU+hFxLU/PnEyUVOGDuZcZ7Re/LguwpcvIyF2Qbm/rkE?=
 =?us-ascii?Q?XxxuLuwb271SEP8fnkJM6kINfypXoleBj3nyzNZcWi2Vo9FG7CeClA6ZLUZl?=
 =?us-ascii?Q?9/j8Rp6DuI+8jM3XWvGJ4mW3caWrKb4nCAlUBaz/GhbyU3Od2myNulXXRMUK?=
 =?us-ascii?Q?v5uZWmY0dj51fea0qJdw0rpl0zS4ikGM3uWamZbLt/SM1nGvG44BoR1Vl2Tq?=
 =?us-ascii?Q?ZKOT218S0DWUQ1qS+QWrXcliYV78YDdSzShNwQyVix666EH46I8xOBRgWSUq?=
 =?us-ascii?Q?ydKFqWFjlMvVeypBYr//7K46TPJXx5vNS+Wmk3Zsh6HUptq4DmnFOZ7MVISk?=
 =?us-ascii?Q?L9tkb9w8CBsq9iR263bAOhrXCg90ZJFnQFNA2vAXzw3ISAHxsGr5g0eNWHsI?=
 =?us-ascii?Q?PxyMqGtcfxJtfjTxl3Z3n05lyj5rBJbOTwFf/cd9ceexBwWMlmBc8q25wWiU?=
 =?us-ascii?Q?o7drD0KEXpKM1QHhECjyaP2thAU+G0orwNFnkVjODpw/R1kiQXr/WE5Gpzyj?=
 =?us-ascii?Q?FZ9YoGse/XmyNlwptzGeM39bNd3KFCiMFtdfu5UkdJmvdy8Ex+g54VqrjqBV?=
 =?us-ascii?Q?9J1ZhDkaZXLQwOkkDb0uGbJLupYrwKhP3q5VfNUR/WQ8Y34ZRgbl41RIMcPY?=
 =?us-ascii?Q?42lHD9UEq2FR9dMb+AmNQI707cjiTeAnJvIvXhnLtWr0NdBka/gQhOgmLDLL?=
 =?us-ascii?Q?wmaP4YGo9IsEQRb8R+mKIkic2AypOKYOSmVIIMhkajh5nBCSj0d0SP8Kh7rb?=
 =?us-ascii?Q?3jczvN/PEOf2C49NxguYMlihLqEhRdZ+KJGoW8d9tpCrUU74AlNCR39GuilH?=
 =?us-ascii?Q?htphLOnd7IlaT+zK8u33y9PZDXt4U4XbrKsXv6bAJZqzdvHjNfg0Re6m4OLQ?=
 =?us-ascii?Q?uQ2FnmPNibgdOIrPHX699umF+5kwqSmhSooadt2EHRFDVMec6BuNnIQGtdEX?=
 =?us-ascii?Q?+0mIxe5A1Uh0LPPzNp1bChTSSJ7/tvUQBYXzFZf9LdpH1302nFoTyHGMEGwx?=
 =?us-ascii?Q?fCRY5iA/5aOvibx9Xo7gbK8udMi59HBwJwHUJ6hxmnuBqi1D1n8tkM3vz00J?=
 =?us-ascii?Q?kNF+sLeIQLITCa/c0lQQhXtmq1J3z8Q5e5Su7b+gZqSm+0VKrO5VKNjW+rhx?=
 =?us-ascii?Q?OUVZSpbDiug+9t98XjytQbzX6g0eoB1H9QgLv3UpgWXH65X7K7xF0r/zWUow?=
 =?us-ascii?Q?Vr9RtaXHh32GE9hoiCLsVqxPZ5Tt2coc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KNMk7BkEjieKWkKE8xWVFLstV5cBLUHNfUoEUSZbI15YfUgC6NtHgAjf2GTY?=
 =?us-ascii?Q?lNhvK9R1LPVApUbRtlbF1wUtJwohXZOP6FnRCv8ZpSBOh4c1e0OK+z0zhelU?=
 =?us-ascii?Q?ZIa74HuyhSv64v/vdyAqMdbnfp4WNK42kE6fZReNFcOf6Hw9+XPkjDOmf+PQ?=
 =?us-ascii?Q?ngIdkTH+XsV7G0PD1o/tytBgqvBP+1poEJLR4PzQ/99Zlefq10/c3BMoyEHD?=
 =?us-ascii?Q?t4iodLVOu7sICBot8f+mmJuCKca3yBBvI/ZZmeIKWRrFHK63L8TokKwe7F7k?=
 =?us-ascii?Q?y66z9ysl7QhFYXhk6JDv9L7K4tq+9ElFaqiGE0GMOI9xehxYkUlX/jHmA0Ul?=
 =?us-ascii?Q?BceD64/eESJFKcqzAixRQ8LHP9zk2haGEsF5Qd+54a2Y3fx0CdQS6hYhznv6?=
 =?us-ascii?Q?25htNxh98hpmLJpRVzkXq81cuKoO1SYbmzuA8pUPhzCMEMaz+M/JVbHuLeaB?=
 =?us-ascii?Q?yzwihjEyQna9esMLArotFUdqlbbS0DG/EIU6DullnHWmZA89OL4BeP+pNpD8?=
 =?us-ascii?Q?Ad7jUH+8MaG1evhcSk8d/w1pzdY4rVhjv7mm/xvoQrcVjIm0F2kVMGuTXi/P?=
 =?us-ascii?Q?LXxUcTC+XlV8B3eWDFDj/cNQVo5J30Ca/SjSFw5POWeHfs2nThQULOU8cl4L?=
 =?us-ascii?Q?7t/XevJ/YoQIOyZeRqfBPuZj7YowHhY/hQCzS4DVpIMFY8jSxs79hTA42/Ps?=
 =?us-ascii?Q?MA69juvN2alhr/J5Ktte1jwclQp5/Uj1ONikrsBgWJxUuiM6jlfNm1T+1pib?=
 =?us-ascii?Q?kg9irxSd4Hvmm1PvHS6/IjnHW/g6jF85l0LvuaMUD6RdKoxNaIRQhbAsa8mf?=
 =?us-ascii?Q?yZ1552XNVNaFn4oLh5KMFEmvZYwmUM6XJRwmcoYHRo7vZuyKXIrjVzIMzTHz?=
 =?us-ascii?Q?GfDh5DhWozT2K/lXE8NKtIoGqODm/LP8GHhnx1StVEUS67r0kCaDOwZB+cO7?=
 =?us-ascii?Q?qvAvx/YwtMczXnUOqE9JtLKFSJkttt75npWaZ/G7n0/UMq/TP8lfxBveUaFp?=
 =?us-ascii?Q?471LCR4lOtJBuObNvtfuxlcGjLALlu1atmyhVRMlTA+0xuakAKgYPUqbLfe/?=
 =?us-ascii?Q?S5duYF8sgxBkQMAbuQRRedHKJrThLJDghazterydV4lAROzRhpi1GNEB1+fo?=
 =?us-ascii?Q?TW+nF/2ISHDpw857nnWrbWzVzgUE4BYYlhfdDJG6XQS92AXq0oXiV3yjGw/y?=
 =?us-ascii?Q?Dd6VDM9/+j0PmnI6/R1oXfDQH/rJqfM8yMZBdqS1T4686v4KTF6powVXJJF6?=
 =?us-ascii?Q?vv3Yjq1C9VOZXRd6etv1RIeODOrqjLcHLywsK4IKt7rbv3md84pB8h4Scfwf?=
 =?us-ascii?Q?BLo3Z7Q+h59T3Z2qfPUM9SWAm7oxT+2+Ey+F9ZUwZGmrB5LJRMF/dIR00/qo?=
 =?us-ascii?Q?452xptK9X4MP2qSD+okcUNzXMeNRRkodWn0VkyzkJHaimIsZlXJh0oXdal1a?=
 =?us-ascii?Q?gt4BR6V0+kbjEYitVO140gMuExRivYYJI4+5rXnDmax62PIB+EAp1c4RbaCi?=
 =?us-ascii?Q?rA9xMQ+c2g6UEhhPuL0SWve1e5QuvgNxKixkvXkFXTojeM+XmGypYT1tDsWs?=
 =?us-ascii?Q?vgrLHt7QmHLnUWxpEfukrUUZWYYN4dRcLt56TSbE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 430c9918-c452-4de8-2d97-08dd518a1809
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:39:30.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCYQJbfjvM7IitITT7O9xsUz06Lq2Gp8H04RGI9t+Hs24EOHO9cop4icUS6pYljT7WpRPhhtGEleVQGVLhPhxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7057



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Thursday, February 20, 2025 7:07 AM
[...]
> Subject: RE: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
> enetc_map_tx_tso_buffs()
>=20
> > > -----Original Message-----
> > > From: Wei Fang <wei.fang@nxp.com>
> > > Sent: Wednesday, February 19, 2025 7:43 AM
> > [...]
> > > Subject: [PATCH v2 net 9/9] net: enetc: fix the off-by-one issue in
> > > enetc_map_tx_tso_buffs()
> > >
> > > There is an off-by-one issue for the err_chained_bd path, it will
> > > free one more tx_swbd than expected. But there is no such issue for
> > > the err_map_data path. To fix this off-by-one issue and make the two
> > > error handling consistent, the loop condition of error handling is
> > > modified and the 'count++' operation is moved before
> enetc_map_tx_tso_data().
> > >
> > > Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > index 9a24d1176479..fe3967268a19 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > @@ -832,6 +832,7 @@ static int enetc_map_tx_tso_buffs(struct
> > > enetc_bdr *tx_ring, struct sk_buff *skb
> > >  			txbd =3D ENETC_TXBD(*tx_ring, i);
> > >  			tx_swbd =3D &tx_ring->tx_swbd[i];
> > >  			prefetchw(txbd);
> > > +			count++;
> > >
> > >  			/* Compute the checksum over this segment of data
> and
> > >  			 * add it to the csum already computed (over the L4
> @@ -848,7
> > > +849,6 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb
> > >  				goto err_map_data;
> > >
> > >  			data_len -=3D size;
> > > -			count++;
> >
> > Hi Wei,
> >
> > My issue is that:
> > enetc_map_tx_tso_hdr() not only updates the current tx_swbd (so 1
> > count++ needed), but in case of extension flag it advances 'tx_swbd'
> > and 'i' with another position so and extra 'count++' would be needed
> > in that case.
> >
>=20
> I think the patch 2 (net: enetc: correct the tx_swbd statistics) is to re=
solve your
> issue.

Ok, I missed that. Thanks.

