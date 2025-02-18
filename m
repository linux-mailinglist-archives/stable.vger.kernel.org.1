Return-Path: <stable+bounces-116687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0FA396CC
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509EA188B5B9
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0222F15E;
	Tue, 18 Feb 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aV4MCFGR"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B31FFC48;
	Tue, 18 Feb 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870301; cv=fail; b=cM9qVCSU3vfII8Y6kicOlepgOcUuuRCKTFby9WTpxiu661n59G5UkSeFNLiA5dlHPyd6JSP1kseLyweN6S/WmbjxHGHaMyiw/Zw0l1tilZs7G88w39uoJhM0k2ijWIBy1vlr2Sv3wNx4LCJGOhkfFMb9EzaWm43j6S0CqM75njk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870301; c=relaxed/simple;
	bh=jigOnKF80AJz+BuZcohqGvOUz88xljvDU25jJ4jd2Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cDiJ3ejE7nTgNMCsi4OObH1WA4EHXxbzP9vU2qfaswB0jxs8Es811juNoo6oFNUIwOpbptLNWucr08mygsoAHsgjgTvE9yY0rEibIxtG8+W/ZZiZnrO2OLufBrDHRuX8OCClwBHUdhdadSrFR4nSLCSppDPiWo+NVWYT/gg+5Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aV4MCFGR; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz5cJQ5Hf17k0F265fLOqwRSvmlffhfuzTFKSXI3HH0kqBBpu/uNs2DPnMfuIhzFZWDuAvC378ThT+dtUIk5/BocWTenJaShimGVVn23nTIWnCVROwo7SJfMcO74Wt6CuMNC8mqJnTVlX+xNbUB5pF2B8CXoVDcXm9kC5QaH1op6l6FBW92JmUkH5tXcEpxcZc4IqQgzM8RBpgQwilGLHScp0RIcHp9bh/DTOct0Fl8kbTsSFcAanCkIXXkHn12SXTG2sw1FSX+Lvft8ACzbh7AE6uYIjAR1oANb9Au76D1rg4OERg75tgz9x5viXEzvpVwu9ktwcQ7ru/o1iE4/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJz1c06OAWIXa2/UelhdY1GVy9KuUCshqbAyfrtw76Q=;
 b=I3afFWdsQjNOlqgLoR8oDat0X2CaRjWIN3ccbavKkLTSzxhwPvVkOvs/nnkMpF9fXzbNXx4M1l2EP4Hhcv4JWcrLF49yjz0qRt6CuiFYNoE8NMPb8/fgnyBR9VAxqaSVHpWChmjYAyR7nQthVrhOJILc+iBpjKskD0sWxj4wldpbo6kUJ1aQVc4qyg2TygBN+BSKcnQyDBdB7N573nTyxz1akwpg7D3of8nBS8C9vlbPDpZNHcZll43V6s/4YvfrywneKdAhCyN6pBUXgnkd6iIu/0g8hpTGXQp/Wxh9HiLnTkm/6IpoVTEgxZilFP08WhnnnPOEEYuXQ0AeMsnRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJz1c06OAWIXa2/UelhdY1GVy9KuUCshqbAyfrtw76Q=;
 b=aV4MCFGRJMcAKgHLqlH87IqvgqN/LiwBMMUINU+X1riy1FcnxVBx0rBw8Xe/HPwu604jv8/dVnvi86jlQ04RTwrUZFiOwg5YJgy6bCjAvgYpw6L/dJWD7IUR1xVjZpx9KOAC6oUrlA/1/P0HtosqX+GkUB5ovPHB5Bk/rJ9a12XZjDDCrhZ7tguoDDGj4O9lnTBmvhFzO95cf0MX2isQpXAEYbrfrS8ESt+m04U82+QpcDcf8Ahi260USmxTgL7WpxMQso/g9iNXeO29YboltuWb3MLFnoURd3xLUQ2NwLsK0kZzj38WfDe2G1Wq8WQ/Yz80TCyLaJun0kuaWksPvA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 09:18:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Tue, 18 Feb 2025
 09:18:15 +0000
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
Thread-Index: AQHbgSIxXCrhXQUTvUaf5YMAXyCn+7NL+pCAgABPbpCAAHuLgIAAAcgg
Date: Tue, 18 Feb 2025 09:18:15 +0000
Message-ID:
 <PAXPR04MB85101AE086500F20BEAC67FC88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB85105B5C71672A828E8D6F6988FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB8849AC9B20849B615AD5B67196FA2@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8849AC9B20849B615AD5B67196FA2@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7638:EE_
x-ms-office365-filtering-correlation-id: 7e9671fb-6ddf-4ae6-1e4e-08dd4ffd2ccd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JvGJS1jXcsKavblQWrUz9RU7i2K4lfcw4o2aKjToc6im0U49uKyv66HRVAzz?=
 =?us-ascii?Q?LGUk062FH2eDXoVOrhmxrRFXGRn4oKhlDi735Tu/BD5FLWn/90Oa4pcKDP6R?=
 =?us-ascii?Q?NlSkETsaPz+Ee+Uz8XCUAWTlE/7UhHyj+heo0kSLx/POa22gYyJZawenfTAJ?=
 =?us-ascii?Q?HA2iZIwyi1LcZGJp82xu3tOzg3F7GqnCMD62x1pz3RwxFdjXDi4XnRPmu6Vk?=
 =?us-ascii?Q?+1O863a9amwceV7mJV1MboFrVWzoq1cGpsaol+drFqIULkkTuRg/kJny6Oya?=
 =?us-ascii?Q?VAqtKe4SPBEWSr+iwJS9xVGfWP/LMuu1uhTzdCtqx1mvUasBYMilOnZxiOz7?=
 =?us-ascii?Q?ESfUg01YEhHEkFgLXkLnZc57MvfLZzS2HAHXRlJiCDPTj1ZyQUlfWNZ1qhFF?=
 =?us-ascii?Q?F583k71JM1f5GghOC8Gb5bJm+5nU/CA23hJOJAGS3NJ22j674+0DXNPrTV4T?=
 =?us-ascii?Q?wPx5AObusObKig1hLoEywEEVgPy040tZKkidk5liDKfVhvr8VHdcffRaTquf?=
 =?us-ascii?Q?h5QT/rcunv3tKv+5XNdLTE969Tf2O/wqicwgP7xTBozD2zkYzjh8Ig4HMcKn?=
 =?us-ascii?Q?C2WXjpEzRooYq2XB+g463nWQkygDLCoDcKjD1VO+CuWSDQETgDfM+4hw2p86?=
 =?us-ascii?Q?XvU03vRv2S5wH51s6HDrSoESihW9sYCICGfXou6TrELhRoTvWoYUWAwcl6n2?=
 =?us-ascii?Q?ouvuSeejsUFoBwSk58Ng4HenVQl3Tg2z+IdfSeGzZKLToJMv0+f6jnYvtp8Y?=
 =?us-ascii?Q?IoT+aiST5Fhm8BN++eW5/x5npGBdt/GYTyZ9wviSxzcjewf1xAk8CT8SMpPr?=
 =?us-ascii?Q?hZXn11Co8WGEEnA9sefNtScfZDM3beaawU0oZOB/KWHBKIE2nMC0oQ2/5ls6?=
 =?us-ascii?Q?4Vas/MiNk0w/CW4wyzg80dJ7c9s++AXyXnOfNTbNqc2y7r71fCxdVWp9khE/?=
 =?us-ascii?Q?hc93SuJuWJzBiUZoR1J32DQA67vumwkqvmV9/cmLqxrIV54o/5+xW+94z+vM?=
 =?us-ascii?Q?kDw/0CAatADDcvXYkJw/kYVe+WoIBchZ6nAThxj7vOjUO1vXsGsK4Dpgx5di?=
 =?us-ascii?Q?5VkwLXu7nj2JtltiD8PxQiZPRSRxXdsmpKO+jEqAfxp6LCqKg31P6cE45koQ?=
 =?us-ascii?Q?BJBDWdES2JiL/XRcX5vJDFl1jZ+WUXLum3PX/5aUyQkVMlj9iYHNhLydS+Bg?=
 =?us-ascii?Q?zO8WPtU737xUq7Pig01yADUzXwIgUZmhXGK4gDL8HNS3XmLA+1lHwdGN3lZ3?=
 =?us-ascii?Q?nBc2vwUQ9YBzZfrlKMIUkd2hWWmx6U0DZ3HPJpXbS+7/7KcmYj6kaGA7OEQ+?=
 =?us-ascii?Q?JKny5ah+pNm+lauOtKUApvj9ETeJEdnBSAMaZUjNn+Th67PSyvcYV/I/P0Bc?=
 =?us-ascii?Q?ep6+APNAYSb8waKn1iCTZjqQAZHbuFe5hfAcpqtPN9nA8LD/h1RvNksF8IEX?=
 =?us-ascii?Q?BpftyewZYjmQNlZcHezO6hnVRe7m3PSH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nAfE0RXwNdxrLxWupln27SFVD/OIlXbKO8G3LWUjnupTq8KZXXmMWQLREYCE?=
 =?us-ascii?Q?m2FiHCYIdrfHwGntmrCbh9DTYQZ7agcfRsXmLlSihfr+VfQOlIh+p5aQaySm?=
 =?us-ascii?Q?L+Rx2GmBzGgibi3Glcsk5JDp5NrmNjlfEat9NCBpFRrqYO/e+nzeDB4xII9a?=
 =?us-ascii?Q?q24vu3FZR767z4xglbeY0n2q1CyF8MLiB67Fxk5FB9djCNbC8kT/1cDIoMjo?=
 =?us-ascii?Q?yZJh0PinKC1VXFrbSyOhswB6KK1viiYpULIhbBzm+fPPcrQ/0rHBmyzeTWyU?=
 =?us-ascii?Q?ivh78dbGy3rR+s2Stw1TG3pc3w7JdBNX87qyVZIyNpxA0j0lvw2a+T/p6SI4?=
 =?us-ascii?Q?S2z9wHiv8LFG+GPoLfaDDO2jevNaRqB3P8qtydlG1DeM5leIr0cJsxkeAZKt?=
 =?us-ascii?Q?UUqSOspVHybFW+7/2uA66dfuQoslN6Dzhkj25KyByuBVSCfZNoRSlcXGHJP7?=
 =?us-ascii?Q?iUOzc9dg6bKV9Q5pO4wkcEcaXipsmRKxhFyMGFifg6Cd23UII+JXDmg4RXmq?=
 =?us-ascii?Q?UAVH4CdPk2HHBaxWmKoimu2aJZ8qtIVIYBfRbfiYOOMXdt1HfBnqkc6H1xey?=
 =?us-ascii?Q?A43z5g6heWfh9vkEbl9U9WaSoImtWq2FMaucrjRBaTLpRy4BErk/K7QtpzWT?=
 =?us-ascii?Q?sk9JeuqQOHpdDrAnMvCJ5IHIRc+muALdtJoFYwXqt0rgt2M/vzY/E8Yr0ves?=
 =?us-ascii?Q?IrAuIFxQYxlAlGBzA47aseAIXj9cTY/cQhCfEN4YYwAL4pknR4Hmrwj+U8+b?=
 =?us-ascii?Q?iNJNFTHjzNYf+SC7zIbSLtF5Yd8k1TxJFw7pj1BbXbe0KkgUqACsXF6+1ssv?=
 =?us-ascii?Q?BPali10/jmBqqIuFSge+mpsSE1ZqRJgraO+6pM/K+yrnDN76JrpUGKeeu5c1?=
 =?us-ascii?Q?GErgw95NhiXWJ+J69ABtq5uRwnIfJq06uxjoyl167kuJrPmJLhehumBa/twV?=
 =?us-ascii?Q?WvZUqUlb8hL2FZZXteWOE9H9OQTWUfGVMO4nWI8YKgJ36J66JKmefTgxRhhH?=
 =?us-ascii?Q?+4BPryOcxmCw9CUBG3kO9kjc2YPX0vI3Oap7nyjP2kIpiOYQ2d57Mp56F8Oc?=
 =?us-ascii?Q?+rd53NPThSDVPxpCRmZVcxt8kv61uKutYiJCVhhr0KS0Qg442JOeUfwTTQL9?=
 =?us-ascii?Q?RdL1m4qZIUwnbNF4fPzjgCOWSWO1al3qMXRsbB/nXfTrjiuxil9cERVgytTz?=
 =?us-ascii?Q?jKOgQ7CddovHRA9/omwlnWYcS+clcdzqEmOD2pEAPld60HlQw5XdAR2VXf4e?=
 =?us-ascii?Q?vRU/S7MdgliJcMfqctxjZCwNpEIabSCF0pRd4tg4pgdQyexkqjSOL7w90flh?=
 =?us-ascii?Q?pRyh3A0kid5kr/8sB28hBW8Fxf7geYnkf7cglAoAgeOsg3vTrZQUZznQ3v9o?=
 =?us-ascii?Q?9STBwHpeO9lCfQFOwR9NfWYpydT7f3kX7d8mmWj4ifefrPEI/Zuhs8/KBizC?=
 =?us-ascii?Q?3GDAZqVWitGIpmyA+edf7bQqazWT4bCrHPZcCHoEeJCk1986syspwlYDEkiR?=
 =?us-ascii?Q?AWeFY2BQHU2qTpCFZPlN+Uuronbgzin0sNtoIA1NiWsSO2yOvuy0zaS3sH0J?=
 =?us-ascii?Q?yQUusHj/OnCHwrXdIEU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9671fb-6ddf-4ae6-1e4e-08dd4ffd2ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 09:18:15.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8eXA5VhM2rx5jT4MTtfYXauUtw+SKIWfdTP6oSD8bnJ9jo7BYKul8NwAq2c+P9ACVV8jGPYsnJ2fGsgypHSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638

> > -----Original Message-----
> > From: Wei Fang <wei.fang@nxp.com>
> > Sent: Tuesday, February 18, 2025 4:03 AM
> [,,,]
> > Subject: RE: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> > enetc_map_tx_buffs()
> >
> > > > -----Original Message-----
> > > > From: Wei Fang <wei.fang@nxp.com>
> > > > Sent: Monday, February 17, 2025 11:39 AM
> > > [...]
> > > > Subject: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
> > > > enetc_map_tx_buffs()
> > > >
> > > > When the DMA mapping error occurs, it will attempt to free 'count +=
 1'
> > >
> > > Hi Wei,
> > > Are you sure?
> > >
> > > dma_err occurs before count is incremented, at least that's the desig=
n.
> > >
> > > First step already contradicts your claim:
> > > ```
> > > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_bu=
ff
> *skb)
> > > { [...]
> > > 	int i, count =3D 0;
> > > [...]
> > > 	dma =3D dma_map_single(tx_ring->dev, skb->data, len,
> > DMA_TO_DEVICE);
> > > 	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
> > > 		goto dma_err;
> > >
> > > =3D=3D=3D> count is 0 on goto path!
> > > [...]
> > > 	count++;
> > > ```
> > >
> >
> > Hi Claudiu,
> >
> > I think it's fine in your case, the count is 0, and the tx_swbd is not =
set,
> > so it's unnecessary to call enetc_free_tx_frame() in the dma_err path.
> >
>=20
> enetc_free_tx_frame() call on dma_err path is still needed for count 0 be=
cause
> it needs to free the skb.

First, the tx_swbd is not set when count is 0, so tx_swbd->skb is NULL when
the error occurs.

Second, the skb is freed in enetc_start_xmit() not enetc_free_tx_frame().

