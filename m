Return-Path: <stable+bounces-118536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55DA3E9EE
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9117E0E1
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657D4D599;
	Fri, 21 Feb 2025 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g23/7jZv"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85A4207F;
	Fri, 21 Feb 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101188; cv=fail; b=f6Bo1KR+BS8DDlCShU7Q6ZbWHOVVTIIyLH/0USK+lFl2QkjpxIWDFI/gHWZgNvtU7eWaT4XsfQkbnfXbTwPdvoHBUdmlXyGoZkeuwGlQD0iufoCBHGhDTAqdHs39SVomR32syO+kYmw7B3HMhg2Q0LdA4ITG0i30t2jlAXD9aw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101188; c=relaxed/simple;
	bh=zIWbBX0eswlhapR0ZO1xUXVC44yXbKwWwi0MqHeIW/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hH2IYNMmjoBeDkbnTQtE2aqw5gtj/WIDK4KpKbfsSPURjWcmGhexykyr3LCfSxrZa0+gD/KMjHfOEyAhg3+jcroLZkE1LCXJ/w4jNYsglwefrvcBsOBgiNR5XaXpeWReLqP5vWmSMSBIqEmCQVL8gU/pRuQWgiQeQVBJg6Laaf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g23/7jZv; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CilPv0lxExGIHzKiCWpU/VOv2Y73EyRzKAx/5In0zoP/PBmll3pX+/GmHKKie0IAGixHeoRSfNopoHv5cba5IGu2rLab6vRfzmPmv9qHvim4V/ys9qH+lC5z5v1mSz3UZ1H2QocpKlFHLDiHzCYW10aqMl3XxETIblkiIoI0jjW63P/OASmdF2Q4CLmCHuX/7nRO72HoHqYTGXoq0lii19RFmnSaqXwKkFkd8sSwfCzTKrBMyy/iqGYBnaEYLf62lktcicn/G8MFiiWsHYOu0HzfNsDR4ZkZpX2AwGbXFhvXhXZQhfecIlqTristzOhVHkt+ErcfXgGxsjAfe/ThgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIWbBX0eswlhapR0ZO1xUXVC44yXbKwWwi0MqHeIW/Q=;
 b=i9jKd0zp+CXru1GaySRNF47Bqq2XCm0xzRr5GY1F4AO9blC7c/8tWaPkRPjonqZAyKQIxa/3JHmXPipuFMUYe7G19HJ59U9RG8OS8f0wcV/OYIwwZprhs33ybYUtZE2G39xcpbBjKFWV4x++Aq11Cxgft95TzW2GCJmi8D71KLL2nPIl4Wjv+pxwCz2OUoe4x3fVEHWy1VLwg3S/A6K2RPlZv2+adXlxGWzFwlGnUYs9PjX44OtW47rSQVOLBeeHrWktQewVXnBnrTi0imP2s55EiEJvsc3Te6jIcE8XL8VVyI1PmFTv1O43rHeVUYsqEMZXDrBBQfkAxnd/ziFQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIWbBX0eswlhapR0ZO1xUXVC44yXbKwWwi0MqHeIW/Q=;
 b=g23/7jZv7BDbYs0Tpb/lE/N0WARpWrcDtO45GjtfnbrDbKmR36AeRUbOH+nIEWU+s0TzTXnj3hh3weEEnh1i+hRhp6PannNKvO2VYD9X5czaoyWlAg8QwxfTvkKeGCs1F/XiD8tenbup4h5Rab1PdOqiJnSFNevRzPMMtqz/peAAzbVzTcKS8iAz3Nn0TacMF1QCfUi2zZE2b0tg9B0epmvJCbje4a2UqZJGO4DjGfRGBINAIy+4IGQVY1XwzuZpHpmshDd/qIhpDtgPlmGJgwzzquXapP2WXKU0EshX89vNcDwf15XPM3QM3H44TiMJOqP+JJrb/d4dAbhG/2hB2w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10496.eurprd04.prod.outlook.com (2603:10a6:800:21a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 01:26:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Fri, 21 Feb 2025
 01:26:23 +0000
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
Subject: RE: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Topic: [PATCH v2 net 1/9] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Thread-Index: AQHbgpN84W/mqMIUlUSb3IBljHqV3rNQKeyAgADPmTA=
Date: Fri, 21 Feb 2025 01:26:23 +0000
Message-ID:
 <PAXPR04MB85100F961EBDAFE532CE026D88C72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250219054247.733243-1-wei.fang@nxp.com>
 <20250219054247.733243-2-wei.fang@nxp.com>
 <20250220130121.fq3irlaunowyvfc4@skbuf>
In-Reply-To: <20250220130121.fq3irlaunowyvfc4@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10496:EE_
x-ms-office365-filtering-correlation-id: 92aaa3b0-81ee-4e69-e5f1-08dd5216c0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wpdBRujGA9YqrjWsKegJJkKhAadrW5LdvXb8mc2SVpu4vE1mROzwtbSJw4d1?=
 =?us-ascii?Q?CdTBqaynW+11k4M6oERpqw4guyDaVhSQhQni8JLXwUpljfUXKkQ8k/zGXCfd?=
 =?us-ascii?Q?wRinpP+dCe6n3U/edEIHvDq2DaI9wWA6cmzQ40eE9NbfLc1s4DrCaC5BH4ii?=
 =?us-ascii?Q?hehfULUcVj8pC0wlcB3kBB587C+k0wEpv13cSukWG4yo199RJLba1xrzEs4W?=
 =?us-ascii?Q?MJwU9gLlFIQvmygOSahtVFDBGlb28kVLjRjY1LcA/Mx8VXEqqQgT6yXgvzbj?=
 =?us-ascii?Q?ETAzBXjuT7ca6rPnGYkQ8LCt1Z+uf8kWkjvITEE3LOJiV4QrmdxFGmYxK6LC?=
 =?us-ascii?Q?kcprtIeRtW04IvoOEUbu95ZRu95dItCWO9WnI9kJoYSoiHXT0BiFnUzScIP5?=
 =?us-ascii?Q?/piPQIQJgQEhyWg/Pnte9rxNLSBD0xX6go9aDDu4kQG2CXUNZrj+Bxx3GTUC?=
 =?us-ascii?Q?xYycUaXRCFR9LbEZmeHaWmluRrGFUEpUQ2EjruLQ/gSTNPfcb3sLrAho/U9p?=
 =?us-ascii?Q?Q6AD8jRPGsCLL4pWyAEi1ZYAvp9GYBvKQoYWmXEY2SiXm3kgmDFw/gZ/CFcV?=
 =?us-ascii?Q?SLUgRoYRPriWS5NuLrOGEPIpEcjZdS6QaOBqqATLS1hABqrGNZM1yn6ovo0H?=
 =?us-ascii?Q?Gy7DC0iVr8OcHHn8brahU6GVb0+XM8hK7fOBXY7t3FdJoTZyegqL3yPVALTG?=
 =?us-ascii?Q?dREFsjD/3liFUhN7TH5fpACXdEHqcQO24TDcEfhoj/TK6WP+cHXgVys7qDmD?=
 =?us-ascii?Q?xPEeWt4Zan5DThgmyuvX7UW3WiJYPLQCYBd0krf47GAp7e7K8NbxmXsVsApH?=
 =?us-ascii?Q?cwkWMhpkMQdZnpSIV9/J8o1MPwb5cb7O0z/x/psjcn0EqVudv/GmBMnH2gDO?=
 =?us-ascii?Q?U3rPl1iVs8Zrguev6gwgLkfevGZDqjAES9QqbziFzmdI0uPjh35GbU2nCp8y?=
 =?us-ascii?Q?JkQP5PJcVp0nAXutBQXvT1af4Fb/k9GKk0hxgXIGwtQ0vI3i3wTsa0ceCQKn?=
 =?us-ascii?Q?GVYXIPznqPpdFaUXkglG/zgIW6E8X9jrz8g8Y1HHpUO9Sm+6wSNlGuatw9+Z?=
 =?us-ascii?Q?mcfVU+KcS8vnU1hIzCi9DpY8q1hCC9UHTa6TuohwCsE/pqDhwfUqgagVaHu2?=
 =?us-ascii?Q?gSqighWRkN/dSSyr5nQ3GYZX1+vGed24jhuDtKTVj0T9zOAf3ow3cmJjNq/0?=
 =?us-ascii?Q?sgGDAYlbtn1Z9vfB7eHDo10DWuBtXs//WR8b7dQNRvHQV5h5tK+MgoQi5EHm?=
 =?us-ascii?Q?zI4WeJe++Dj3mKdP20lpIxjhPUENFgn5xKsqgVwfYiZzvSWPfuFvdL7Bn0w1?=
 =?us-ascii?Q?dRxOVdpy/rA7T/AWtZi+iBvYF7i872fqbdiVdh4jX3qzvKA5VOlEAomjuLow?=
 =?us-ascii?Q?hU1JBsCdfrMMHkeVteNsJ1IEbmRxo6sJjVzS2PgMBQIYXQ5tC80xJuY+76CA?=
 =?us-ascii?Q?VwEh9qgOHvg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aX/bMioWjp2XRhmZr+O29g6iPElkMAPtqR7e6jjcHfqwdiloAzv0Ugnjt60u?=
 =?us-ascii?Q?cSbyGrlL16qTdgVqZONheV5h6FSFmJq7OxR4Q6dP16QaO3aIJhBOjeN+gvXg?=
 =?us-ascii?Q?q0DH48Bgr7SdCo/cJtR6u1FcbtTx/7qPJM/AZp7uEcZDz3PqfyEJpE2md5GO?=
 =?us-ascii?Q?0I3tW4OhJVy3jmCebzGCbKiMKXTjs82kLZ5LlMWyf4+wUzDcHo5Iz7QOdO48?=
 =?us-ascii?Q?yaud3Pro1t7tfDpPnLAevg22o2m5EvcaDDNI23BsnA8CNW1bgn9UXQfhC5Pd?=
 =?us-ascii?Q?75NISA73KnfJUIbwyFbiV6Tgq14cMJsunb5nY/DXL0p1T73TYGKreyX8xdCQ?=
 =?us-ascii?Q?ScG41Trki152TUzEwZrqfPzE1sNAtLVONvTiBgdL/xFd0zDpfR0+6uXxn0K8?=
 =?us-ascii?Q?5E2opUUWgfixSSVPTuheDVJubSglDdKtMxSkQaprleNoVqUYEpLuWU0w9RC/?=
 =?us-ascii?Q?WcjKA+hIepk0r+nxnE5ofaEzHBZW8Xe+l08+4j0DUhJLt7Ka4Sp4/Wm279xA?=
 =?us-ascii?Q?DOmJgWaJk18ADp/DqXtOwDIk36SKLRxWVfg5Lz5kxWw8KOO7mjgK0BvvH2yP?=
 =?us-ascii?Q?kchUCyoUPQOyueU5hYSsr8HWWB16CmSdiz3icL+pSYcRZ1pyNWkEF3Ps4NPk?=
 =?us-ascii?Q?3rX8I5PDRuyzMANdINyWLsmhOtrJCy665Gv3eo88C8XIxNB4IPdlF92Sb1FT?=
 =?us-ascii?Q?uxEW7k7xgwStRf+oldkf4ns0BW4arKssGnv1TSmXWegOYDeV2ZDs54yvBVjS?=
 =?us-ascii?Q?/jYtHuS2EvQp3IvVAI8hcxJn6HUZfsyg1o1YLoVv0WLWH5rvB0BobXJ0SrBK?=
 =?us-ascii?Q?M2QJJlMrYFwuZu1AUPnYpXfcG6gKbEh92lSLOcetK/ONZg6MtmnlaxA0Esuj?=
 =?us-ascii?Q?IQmjvmeYCAyQ3V9KNJs1W9r5471Rf4ZMl93wzITeKq9mAF17L7SX+bQu+0AT?=
 =?us-ascii?Q?kfVI3ahQJw4mQqyVINFZSpWeHILUrlBKMzHwbuia0g3u+V6fxR5Jn/XsAef9?=
 =?us-ascii?Q?Y7zJuV6/k7JT2fXvO3DD2TH6dBVeQ2ILmKzh+NUDLL8IQxyyrApHc0N2YygZ?=
 =?us-ascii?Q?FlOegbXy50pWdW1Quh68gE9pxWlO+AvzApgIw1QdWkARGKjswDypdnsuS2oK?=
 =?us-ascii?Q?d9T4XNvgHTtpr3PIbBoYC2Y15z0yY5xYz/9jEgB7oyNHDoCOuJV0fQl5T+qp?=
 =?us-ascii?Q?Xo6qmg2jwAu5ppH2p5clWCxIPap4wIo4HpC0Tx1isPiDl4QrjpoW8X4qfIRP?=
 =?us-ascii?Q?N73Ac48lXtfhB3M8NU4Pg0vube/enfHKS9sjt5xHV1a534nMPjpqb/pqTqLw?=
 =?us-ascii?Q?wK7KSdeR8c4HhtyZhj9IuUTfT1SS1PIsSpG+sNic4ic+dD8wQ+xoVz1mmg7P?=
 =?us-ascii?Q?QkluYl35e8rh1rdWaoJZfKAaD91kPwUFH2oi6neV7ZGx6iFjC9UL22OukuY+?=
 =?us-ascii?Q?o18MJXDIRn7o1hOP+Gx6CLBKKfGc6AINKE40O54rTFa3BhPvBlpgAf7gAh6T?=
 =?us-ascii?Q?NAE87KAqXDI9fn45LAn0r2SSy4/rDMj5B3FBf69Yxj/STDWDsAe7chxoJIDF?=
 =?us-ascii?Q?QdFS8k4Tr3g61KrrFF0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92aaa3b0-81ee-4e69-e5f1-08dd5216c0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:26:23.2093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ahj/soiPADIjmFzfnAy9C+xXvqLwJp6ZG6iHnTdvZ0HPjkG1Wvcg2KXsOPGwVCXN+hH+ludAkUC0L3v7YS5FnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10496

>=20
> After running with some test data, I agree that the bug exists and that
> the fix is correct.
>=20
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> It's just that there's yet one more (correct) dma_err snippet in
> enetc_lso_hw_offload() which achieves the same thing, but expressed
> differently, added by you in December 2024.
>=20
> For fixing a bug from 2019, I agree that you've made the right choice in
> not creating a dependency on that later code. But I like slightly less
> the fact that it leaves 2 slightly different, both non-obvious, code
> paths for unmapping DMA buffers. You could have at least copied the
> dma_err handling from enetc_lso_hw_offload(), to make it obvious that
> one is correct and the other is not, and not complicate things with yet
> a 3rd implementation.
>=20
> You don't need to change this unless there's some other reason to resend
> the patch set, but at least, once "net" merges back into "net-next",
> could you please make a mental note to consolidate the 2 code snippets
> into a single function?
>=20
Yes, I plan to use a helper function to replace the same code blocks in net=
-next
tree.

> Also, the first dma_mapping_error() from enetc_map_tx_buffs() does not
> need to "goto dma_err". It would be dead code. Maybe you could simplify
> that as well. In general, the convention of naming error path labels is
> to name them after what they do, rather than after the function that
> failed when you jump to them. It's easier to manually verify correctness
> this way.
>=20
> Also, the dev_err(tx_ring->dev, "DMA map error"); message should be rate
> limited, since it's called from a fast path and can kill the console if
> the error is persistent.
>=20
> A lot of things to improve still, thanks for doing this :)

