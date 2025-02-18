Return-Path: <stable+bounces-116698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E40A39881
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73AB7A1C8F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7D238D3C;
	Tue, 18 Feb 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXfHpD6d"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F7234989;
	Tue, 18 Feb 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873630; cv=fail; b=jtQF5oplg6J2q1Bj1SBijq18YZgR+9DcXygq5dBjNlSiHJeuy0aOuRwWYSQ2xT65+o0Pu6W34+ehEMlq6pLRIYZ4pGMU1aekcLK6MchncJaeG5I/7vxZaKAEH/AlDjwZwO2VrIVXBQmiS/xtP5GJnAy0w1oL7/xoY/WluO8648I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873630; c=relaxed/simple;
	bh=YrnRRGryAya7JfUzICTDYyuuuvwXCQmxYwaVVomx/To=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=axBTL3oV7fyH9YOhJcMlMRy1sHpO52Wx1iGx0fdK8k/bAYrCCr9cPsPGn4zvxYfNf5Gq7jSUjIG+UCYa+pWdPjr3DeauBptWaPELVAAC6n6dOICwhGStcNeCffX1Xk+L1oJboRvlTUt7fEzLZkokDQ9MSOuIMJ6ENfx3q4GDVdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXfHpD6d; arc=fail smtp.client-ip=40.107.22.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTKX+UHfD7nZeEuz+7o9Nf6Sw9A8eEYZS2VxgUJpVwPA/EWYfpBmD364ri+p5sAJPBl8+AGcJ6BEpFWHUgj8zbrXWPwM2JPZLv7mekyNTatn9r43HAsy1qXF9LSW9+81PecTbVTqKBikPJLCfblExuiW+Q2Rg55dJ8ZWvWZPEyIJqpxn9IBOgUFJXeTDgBws81AsayJZGpvzm1WRqDgCluXxOz8yNRc/o+OxtgilieXsViu1BuRC3z1xKrp/0knvRsDbGCW7qkkHC0wzW/hQRZw51T5DJNq3LJwTTSZnh9YU8DVkZf85fdlGAtEO6aUdAkbWSPxOxZSA2oWJyB47LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrnRRGryAya7JfUzICTDYyuuuvwXCQmxYwaVVomx/To=;
 b=nedOyJjU2gmPPlGG0Wal3TPwcXStHa9hUCsZArZJmeAIuslnaUsRRNJCp6oUAG4q5xhqjK/Sat71KqrQrTvx4W/IIPjVBxHoZNkXg6KaYqCvatQUWlkncO0AfU+p1uK/LTvUh1rjT6M8UotWT5xOrQoQ5jsyh2ISqo7Oj5d92n+5s1bVTPaS2gAXJQChvN6zVMM2EabW8oc3YMmRZG6TyCfTd094/1VOU9UjxYob8MuW2m3/nYMlFzkjHbEBNs/iKynzEmEOG+v5nzyN+fXxra83sRYC1wmtheYdZ0k5dNSbdm+p02vzRuLhOqtZKKNqoq52cc27oDVVG2V0NExAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrnRRGryAya7JfUzICTDYyuuuvwXCQmxYwaVVomx/To=;
 b=kXfHpD6dFMRp7dDPs6wu1mkYy25R5As5+LEcAV4ou6W2GQ6/C5q1tA69Qyi/v+6lXoybZd9bZzgv7GlyFedFUE0TnKBZMaC+ow4EoQXEp9iTOXZSWBeCogC1c5r6CUBZTq4dByduXdWNlAW46pXTiWhNJuGXWW+rpImZxvYh45xxQGeqjlfkpGcHmZnuBYCK7cHbKtYsBTbiNOTUlPlHbD/k7u3e6qS3+UKJk5t0OglkLHZI9sUz6amHg5S+2tw8E0KvaqYs0qkfHP5nWubAjiNUGm5OwfAhgtcd9MD5XBSx/WwouNzETMQ2vUFmRefT/vt/SlrmvRaQOhjPCTcWwQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AS8PR04MB7734.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 10:13:45 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8445.013; Tue, 18 Feb 2025
 10:13:43 +0000
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
Thread-Index: AQHbgSIyYzp3wPB+I0SIp7LSGpxlULNL+EhwgABX2wCAAHR4YIAABTSAgAAIVgA=
Date: Tue, 18 Feb 2025 10:13:43 +0000
Message-ID:
 <AS8PR04MB8849C54C08DCAFB7C0196E1196FA2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <AS8PR04MB8849FB282339EB6D5DC2637396FB2@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB85105B5C71672A828E8D6F6988FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AS8PR04MB8849AC9B20849B615AD5B67196FA2@AS8PR04MB8849.eurprd04.prod.outlook.com>
 <PAXPR04MB85101AE086500F20BEAC67FC88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85101AE086500F20BEAC67FC88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AS8PR04MB7734:EE_
x-ms-office365-filtering-correlation-id: e1098096-327f-4815-b98a-08dd5004ecac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IeoHZt4ru7HVUTRTgtf/oZAIge81PVfAOM0O5NkMOKgBUubUgC9S+NCIi4bW?=
 =?us-ascii?Q?Fpem1VSIwsvFJzPhvlfPeunor4TAfNoYEuu/wqtaQZLCQJe91IHextGvMu92?=
 =?us-ascii?Q?b8viJggZH+3zuUblLFCKl0Kb5SfzsxtS+8r5nxe3doVxfip4iJ+Gy6xUJN/l?=
 =?us-ascii?Q?t/9cqbG2cg32aOVO/OeSrirQCqJCO3OBLDWVRHNnEAe492W5DYBpWCDpxQAF?=
 =?us-ascii?Q?BjrLLInGaDiZt5oJbihZDyAd8nNlTXBZUrc25C8qjVCt9bHw6SdaBtWqXBcE?=
 =?us-ascii?Q?+jxYzS5lFns9KQM8XyEltIONcqSXHf+U+nhUy9atkUutXUOqfUt+paLN7LnN?=
 =?us-ascii?Q?UDrq/rJlFJp9zHC7sHCOC6MEjyv2q8VxiuYEn9IYQ5/lqfG8IT6AixA8y/Pk?=
 =?us-ascii?Q?afMV3x5hI3DpOFUmKO7VgIBJqx4aBk6Mr/eDCpa3QzQH/0cA1CzV4yr9caVY?=
 =?us-ascii?Q?vobXBQL2K1Lv/H2P+SwLq8P08m8mMP9JtVZ8tWJ/nfGAho/poLCpLIS3yFWk?=
 =?us-ascii?Q?QqC8DhJhhqxVqp4mTQbzQ1vToxC97wJYl2MBhGxNFGHSz1ADj3XNxVgItX3E?=
 =?us-ascii?Q?3S1DQtZziZ19ry5rmQOAMV6uPni0OPE6KGP1ZzJnWltV3R47BGdVUv1QtIS3?=
 =?us-ascii?Q?Qkn0DKAsXv+P0AqOA++UcvvjPrxrgCbMxG7oBUCpveq6WKntXG0lVBJk1zuK?=
 =?us-ascii?Q?Vs6qSIUBRz74Yc8Ke9Xd3jm8XfE7WQqFmJNyoFzSYMzIIZfkZpEh+5G7aaxh?=
 =?us-ascii?Q?sqvQ9iaGM+Tbe/fsgoEh34Pqb8LLpuWngV0Ytic2giHrikz9yeOfxpDDTtzD?=
 =?us-ascii?Q?q1hDW1HBwjbti8wzY46ZyNRCxcN0IU+Yih0PmL6ptU9fO+p93O9+cW19o3D1?=
 =?us-ascii?Q?6NdkOKkVUbXL0JP00LR7w5ZR3Lgp9HEqIixnE7kbZWljowGaevljcJDqr3Rm?=
 =?us-ascii?Q?zpSGzyFVRhGSq7+ro59xbWSxXTBAZXF98p7xUULm42aWI6FJvimqHzC0Z60m?=
 =?us-ascii?Q?b1nmtoVskc4uwGJ2hnWbyyex9q/dU47FTXfHKtVGEFrbxF5BnYf5ZtU/notl?=
 =?us-ascii?Q?b3MFwCEo530nJkQiE+hFvkcZORD3F9eASB46XgEeGvGYPfriKNmMTi2h5CpX?=
 =?us-ascii?Q?kCMQd4mULAaSRx/WrYmZ8zyM5GGbcKWg/F4xubJ8hs2uhPuuxoarO/augDh/?=
 =?us-ascii?Q?LfB1Vn2O2QoQdGVYPSFTGLq7EcANP85YxVU0t6bpDDkYAx0/b2WqDbwXvA4A?=
 =?us-ascii?Q?M9FXV8uNCjJ4ZmT1HP0WM1j2rspDq6NENNyYNOPOF+HlvmMfQ075peGv8OUj?=
 =?us-ascii?Q?PyGOvncVqZE2SYMibk7TVeltSC+JHUzupCDxIjKw8aew2FHAW1boyPPs3LiC?=
 =?us-ascii?Q?sT5A42A1qLtV3PzQnEywb3wN55i0I+gjX1GOnqKav2tBnYe4dTL0/OTmbQf5?=
 =?us-ascii?Q?/V9lErL4wO2pVhSE9rK1i8ktOdjatNF0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LRXyRPlXmmraeBOdnC6DJO0l0CY/SIAdJOGH5g3/qjRtVaoaOtDCuEjeYsx1?=
 =?us-ascii?Q?vGj8e/vjWVYy4FHbS+8P+NBEIONHu2XwW+PQvwZXOpzlrAljZB2FVDWlEXra?=
 =?us-ascii?Q?bZ25H7wHs+OfjY3jvn62QbdM6RSwqnTwl4e8JlYyi2iZfHzqqaBEe0YV2GzU?=
 =?us-ascii?Q?r6uaDjftikIF0aXh3je667tl8FH1dfpeOmGFQM964D2D+lrSC+C2cx3vhIcK?=
 =?us-ascii?Q?KGisa8oRt/dhXkm0MimwUYs4Tfz+6kfM26yQbhzJ5d6+IlnytQ94Vz+19kWB?=
 =?us-ascii?Q?nGUYcFyYM9LtYTG49rF4N6oqz7WGxkeSSKQ72T+x95IMQ9TURjMlwJyJc3zW?=
 =?us-ascii?Q?bFLIH8o5suXIMrwAqPnYuT2z8kjWuzxZvPVUqk78Ecjt/5AvzQ/cdqLFQYAX?=
 =?us-ascii?Q?XjL0jA8oQRotQ0blnF8eQkhAsBlMNGvmLwKohg9+IdDvdHeWHBMrP9jSiths?=
 =?us-ascii?Q?Ui1q4RW6KY6S4c+XCI8J3dEgBeq9AWhr4DWh6mLhKq9zeqAR9gRh0NpiWp/R?=
 =?us-ascii?Q?oqiCbVvHcGRDwetpBS9Y96dRS9UJSteADimkBOjHe3wbm4M2dyYGPmSFy+NN?=
 =?us-ascii?Q?kfgkc+r0ppLbNKk2rYur292lSv2EN6OlBFIZmeENIVxYgCxIQluRvtBFzisr?=
 =?us-ascii?Q?oUhXsY2Fw8PFl/88iLkyus8vQVqFQiVh4fqsq9gWJ4YEwTizfCGqv0eRIFO5?=
 =?us-ascii?Q?85HuAA2REvEtuCzpvJ6iMtC3zKW/rCud75Y4vZXBLPna36yrDdXTghaOiP/t?=
 =?us-ascii?Q?Yv7LV0s2L9DZph3VaXyRhN0esDBcMr4vA4H2ahO0g/pkzvFSzPW+OqfJJ/nk?=
 =?us-ascii?Q?np5BeYOrLIu890hyDDjEE1e3My0Zgvy1FgiZPACep7wHDSv4Jm8Uy0ItLsD9?=
 =?us-ascii?Q?R8TchKgNl8E8aDg9wruqCBz2Yorh4JjKVOcxZWoQ0fqh0UykEzyx7DQN9I7n?=
 =?us-ascii?Q?MXUyAbQdjud8cyQSoYv38fvR8Vrab2TuGkD3I5cdL28BRceZfJOige2eC1mK?=
 =?us-ascii?Q?do7R3K4IzF0sC8iAbk9S7V3tOcDjThz2p4MhSpfhvEjioRlebs8qyQkcyhtU?=
 =?us-ascii?Q?wYuk6zUSesYUaH2mbOwEpQisdxY+SyDCw4zEjRWH3wxpbnhsr4u7tmctoacu?=
 =?us-ascii?Q?dPQW8+gjjFE7/xHT8ghjje1kq26pRYP0AeWvnn60aC3isX1XemjNsOERKlN5?=
 =?us-ascii?Q?pxZbSYBmm3rFzsw4VZIiK/G+2jLFbl75V6WJB/TOAChW7PENWabtWvYZbj2b?=
 =?us-ascii?Q?PTAyf8ZgFbUI3hdqG2biPiQgdkxE2rEoNj9W8fQYfeY3pM6q7WrImEnawQ7P?=
 =?us-ascii?Q?hLl9T0jgmhUg3s8ziulhrGOPqbpR7JkZNB35W6skveFi0/RuUk9ur0vh/Gs+?=
 =?us-ascii?Q?4wAE22U0LCeqJi9J/8HziL0xnUp6wOl8oLUPpfRdVVCbWb6/tNyLuFLIrNjt?=
 =?us-ascii?Q?yQZEBxKh5267wSnT5pvNhL9Q+iFD8+8gnMvN2iPD8q/FiTmCtpDqfH+EZbMf?=
 =?us-ascii?Q?XymZVQeOGbw6K5gpTkU+0slUr0/fwGSuP6up3Ad7Kud4sCebzjX/pCc9n5D6?=
 =?us-ascii?Q?0+R/1kX8Y9+KHb65RWu6Zk6SmrAssFPQ9gCUUMW8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1098096-327f-4815-b98a-08dd5004ecac
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 10:13:43.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYSnU3lWBnkpiBTCIYl4R6St6u/NkYD8E0muUKT2Zf2148X01LC2TFucINCf84Kk4ofMty0nNi4n46+9X9iPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7734



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, February 18, 2025 11:18 AM
[...]
> > enetc_free_tx_frame() call on dma_err path is still needed for count 0
> > because it needs to free the skb.
>=20
> First, the tx_swbd is not set when count is 0, so tx_swbd->skb is NULL wh=
en
> the error occurs.
>=20
> Second, the skb is freed in enetc_start_xmit() not enetc_free_tx_frame().

Yeah, noticed too finally.
'do {} while()' is not ok on error path here.

