Return-Path: <stable+bounces-95333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A24E9D79DE
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15240162E3C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B04B664;
	Mon, 25 Nov 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDV0yH0I"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5C79F5;
	Mon, 25 Nov 2024 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732499661; cv=fail; b=jhbBQDTaJshjxmtKs2HN8Y6EBwU4wfmfzh869OwLLq0nQGi/01ZEsaAHQjlgv7YkXf4Pg4+ICjp2zt9JJxUCa13E0fUcQioTm18nOt4u1Dbdt7a0GFiP7EBOrjbMjKa9CwzIHcsdPk455qh/0eknPTC0UbBW8XosycpO7kVonRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732499661; c=relaxed/simple;
	bh=xf1V1SC1G3NIhOd/6QeYOvZabdPIp0wFeNsvEbl50cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hlm+UL0bNNEmOWocWM3XACDPQ+3E0wYqQY9jRvGSx5qx0DxXnPPdmywx94RTOeWFLi5cogYwzgyamnmcp5gQsZaj3bcmIbMUv1cNpctjmpGYQ6lwsLi/rap4FNblEnPSjctyP4i1c5vLwAuy1S731leHo7Rr3PKN2Xe8cZruqb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PDV0yH0I; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYE4QX1mBzDkrStdNm63MuUsm8QJ2+XETEuhuQFYrISIOQ6ixRVcqTQi6AKS6PUbIC9mOr3RLhbUkAL+Kx+XxcxMPl026Pr5Qj095/N7icf/plm5nsJ9jMDVp6Qu+wYOgQnamgLdPJtVHbnlrkKx/6cKCMJcT9ALUIu3hCNZOO2ayAMQDgp/gk/nvl5xVC9qqC/Ju6DxjfXeIqfxzRv0QIg9fOsUWis59dTgHArE8xQMI31hB048yN2p5FdZxXFwcCOOFcwx+6pjET/G91+YcM0QOT/yk0nah5gJ/uDFD60BS/iMhu/KyCObWmIANaTnVdGc1rAz3/QTIaO4xdKnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Mlbq6woTxHLhvVkn/oKiTR3CzB/0nXoWYauPnFCc8c=;
 b=j/HVvDtsbJRn9sjmwaDFi7MphIoN8sVgkMpKbkgujunFMmPIl1ZGzlFXOqSWTtiGeAqj7Vq67qmUQbRTwGAzKnnzxqxUDaD8esHp45ozDqJysAXDuXwsd0BD7NwWAbdTlWbQYgg1IciJqD2MJtv1votjjxGbSZ2Xq2VlTcpbJHbn/SkjmzU3vK+WNer8vFaumRK0g08hxWOhVPyJ/kiQhTZrk0Fmq9BQRzA0dRMSVsW963nnqjW6d9JSlfcCZscR+NIh2tkbaC1wfWaZjZoHzT8npeKOJWh2w33O502H4dWxrvirK3qS41gQmEgz9sNS2t4zwt9c+NJcbyW7yCpgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Mlbq6woTxHLhvVkn/oKiTR3CzB/0nXoWYauPnFCc8c=;
 b=PDV0yH0IHWOo5114IPv0WkN7VODOsshWKrHFF1X5jNHtvN7zkrf4LcajyZP1KibbkEbctxaP2jtRrcgv8ETtrCZRdrqRAm24qCX0Pji6PZrToEcjRRClXFzaoyzCZEHSFm+1vuXxmEZr4mo05OgO7CpojH1NfOuQUAglTK2J1HErf5ooVOYltFQ0vsjH4YS4LFirMt6DCLDekQBiAYK7BVtfrDCgvZKkh1HXSLTvoEfh48Kw/yDdKsvK4u3PlprEg9KDUGfj6vsVNQKsXSkGSgaXCAPNI/7iRi30kCncwqdQxaKnP+rlTlSjZGDjLea0kXaOHs0CbWHEMD/opXoFeA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9852.eurprd04.prod.outlook.com (2603:10a6:150:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 01:54:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 01:54:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Sasha Levin <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH AUTOSEL 5.4 20/28] net: enetc: add i.MX95 EMDIO support
Thread-Topic: [PATCH AUTOSEL 5.4 20/28] net: enetc: add i.MX95 EMDIO support
Thread-Index: AQHbPnisBKhoYEgXT0minTTdwKpVKrLHOtuQ
Date: Mon, 25 Nov 2024 01:54:14 +0000
Message-ID:
 <PAXPR04MB8510442A46C2F25FF783E899882E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241124135549.3350700-1-sashal@kernel.org>
 <20241124135549.3350700-20-sashal@kernel.org>
In-Reply-To: <20241124135549.3350700-20-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9852:EE_
x-ms-office365-filtering-correlation-id: 8e684767-ff63-49b0-12ce-08dd0cf410cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dDYgzjKHtNCCb1/n/TJjhXSNajtd1aVxzs8hw486k7uibQpHpozn/tlbXwDs?=
 =?us-ascii?Q?7lU/bJoBedKiOcdKPR7womOGR2HQoEhCLLqGSRTuRxwUv2oc4sJQlgIRSbdC?=
 =?us-ascii?Q?XQ7+NXbP88U044V/5AshaObGhDasPDmwlWwpL3iW9KhrwKp5UOpstD7+Tr7F?=
 =?us-ascii?Q?4yr8siHx64q3/w/efDOC6e+0WH78d42wNDL2sQAmZhQWMYVZ4ubYvgIZQIJh?=
 =?us-ascii?Q?AyjAx3VQQ9KkgseGS14sEhPmAbGth6zNcSAoyhbZF1LjUL+4AClumkoN0GdY?=
 =?us-ascii?Q?5WA3CdDWOziVpJn66FqJhI2UQgvPn1l4fGMvp9V1Dxb5bxAFt7T+4QQ5BJMM?=
 =?us-ascii?Q?7SeJvs5FlNRr/81YiouQARQZWcV7YvwgY7t3q8YZ+l+YUT51OEsMoN5hGZsW?=
 =?us-ascii?Q?borBMkZtyQcdm1ZWy16Dmcpp3FZRGgEsQ3jfYXlMkvhlPh3YuvVC2JPRxvTX?=
 =?us-ascii?Q?pth42ujrdt7VzOOLYRPGE6QEUrgWpBapF9Bbn1b8dGMgMEAKhdtdp5fblf7b?=
 =?us-ascii?Q?AI7avmndS4bOflwSGoPaKIhc9ps4n0ieH+Wy4RsiWJhIuiFsEUbpQeh/eBTy?=
 =?us-ascii?Q?cGE+Np0N5de1UmYYhLRjXdyJYkoe8T41NRmzZIucRRTjxHTkpX05g9CnD/IS?=
 =?us-ascii?Q?vUOF5+8Rlbf7Nl/FoKKR0uHNWnNk7mn3CV4xjPZPKYyr6WTk5uN5ICgS0aeC?=
 =?us-ascii?Q?iXa5Qm6+aWNNHm1CBsvQZyE/m8dRRFPgvZ5Gu8Wdpe4Iy8ZgY8E6RNRJxnWC?=
 =?us-ascii?Q?Qt88YsdQvPY6/iTq4fQnG0RHJ8s6WeXtSm3r+61nmDgMt7K3b0I73TWCLfIt?=
 =?us-ascii?Q?vCEqcZp2OCjnEmglDANYTvr2NhAckS/ExSz3KOSYC334B2oenuzNOD+FvFPp?=
 =?us-ascii?Q?p+ecAuJ3q1tnv/645VtQF2TB5eKTTcuUXOwpp9hDSYifcnw621nRN94ouRMH?=
 =?us-ascii?Q?DoKgLGM9y0gZlT5lrhhDUak4wjbI45K3hEsQwc7HI6dNtMmaKqBjBZpQz4s0?=
 =?us-ascii?Q?fAZqCMfMRSrQN24Tqqtpc/6WPCYnYZGWFF+ROtCszYeCSePQTccMuqa9I56y?=
 =?us-ascii?Q?1Z9vTH/jh+CzNjN56mr2Ys0x3S8BCxsv5x9aIBTGzl2BZHrRi9hI6YU7RbXg?=
 =?us-ascii?Q?HPxgG+xRXwvvArC9O6igCyWBBWiZ+lXiNlpq6gLRtUUjtbsHVFB+xUSWAcWE?=
 =?us-ascii?Q?vKOVBPk+F1f7ITmaWtTZGrktX25gP2tgMcGsH3xMQbkAhY/8FxhvIpNHBNFC?=
 =?us-ascii?Q?Qpqugz5dNXt+G4YmqbPVlxRsAaz/oX+nHuLHItI/vbTC/qhj/ONg9yjcXYHj?=
 =?us-ascii?Q?s08deV6Ryw3Cp+U1CiMdMKq+5PA7b8ur38kkIttsUjGrMDV2NkpJLPwXXYUI?=
 =?us-ascii?Q?7IjnNybpdGJZECPj4p7v6xNFi9u4YtJDiQsfzYpA3EAUrqOu7g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LMRpoZdjjRwPVhjnBjE955DyXOb8udsMBETMeD088Ddlz8E1oItGc6wtiQvf?=
 =?us-ascii?Q?wpEzOYrkKxpgtDHIxM/453Kh+mNsMiwPeqI3eHjDBBflXIpZDjRvYsKqbbq8?=
 =?us-ascii?Q?Y1LBF6vMiskgq/S6ZB+uWAt/AYL8slLb9P1D2mNowzVWB0E/5pHC2q81g4gQ?=
 =?us-ascii?Q?wkL3gGe+JtpWX85a3Bg/l/Xa3jUm99aL9OTrDZmc/E1vq/BCzG4808jejarA?=
 =?us-ascii?Q?Z5hhCDgWcpZhggYbQ8UhpMn72HJsu/KKKWgutwmYhfUb2cfXsyNmcVKy4jmZ?=
 =?us-ascii?Q?jwy8llBcd2jeGOdjyQSUlChCITD4y3Mme/c5ugf383uqwWCrClYacYSA1JZB?=
 =?us-ascii?Q?afagNS4ZTvf0dxieokqFa7z8GKFoQX2iOuFV7t6TkaLw0KKXCRuO3ynApa3q?=
 =?us-ascii?Q?g2ckgBb9a56UJ73+iVbVZBDLIOzIizXqus3ifmOZGzHEh7WWmFbSKXdSo58u?=
 =?us-ascii?Q?3G07qCfc66a62bjhmy5b+Xo6GK6Wk8JhipFBj2R2sx1BosylEGuJccLaxgW+?=
 =?us-ascii?Q?91F4vO5DBQyG8UyvGbEmv2JY7k3G24cEWPltScZBBT4MCtvjn9uttqfvwGnl?=
 =?us-ascii?Q?NUDF35HiLgkTCgVxn/oGayvnWDhtMfAfkiyD1ADYyvTgMgZgjXQUxqn1DHi0?=
 =?us-ascii?Q?ah9ROR0dO7zMfkD0S0Bkg7mzXlMT5tbS2XrdxGHF9CK2u0fykr68KbejrSQX?=
 =?us-ascii?Q?Nexze6cKlyDvYo0ZODhw5f3t/x6zxREXpux+mn8fP7rp7BeSdrUYyhPdBgag?=
 =?us-ascii?Q?wUCd7o7pgn0OgogDfxU6KFOUMKD6gJPa4Hr2xLngBozclLuL1AsEEbUScogE?=
 =?us-ascii?Q?GZpVSg2QlXq3npImK2aiAG7X9n/WKbIzOfhK/cuwJediQZqG2qQPxsdyJYc/?=
 =?us-ascii?Q?OYwI3i4zL6dzh0Cn1hHI+Eb0J6uOrTMkkh78AQ/PR1+vys4Os3RlF+sJhG8y?=
 =?us-ascii?Q?06bBPe8mZ7U1Ya39aTarJzUFGiF2c6tFZljCtFWSX9zbnrXj5ykeY19oSaqb?=
 =?us-ascii?Q?1M6a6XMicv/KRU0eymPKpAICPUk3wwItvHST7cRHnRSlp7J5sfICt+WosxZe?=
 =?us-ascii?Q?1nBzh2Qbm9qRqI1GKxxbhzXdu4Z8sRPGzZ2+lDkI8Imro2j9j3ZnwUXdexLm?=
 =?us-ascii?Q?Pw0vtVdnWBkjLAYfFCi8JPI/ZQUARr9Og1+d4QMGrleKXDRMscYlySQGd30j?=
 =?us-ascii?Q?y8TqfO/iIl6OuaRJaSgfKjJ12a4ARz/dkwNWWkckAW05otRodXZbdXK1z/Rt?=
 =?us-ascii?Q?1U5TD+ypvTt49jaP9igLw+anQRAm8cMSu+aA/TEf71pTPDAo9lXWfZrdarL5?=
 =?us-ascii?Q?R0x73BGmSbbP1Rs1l74Tu6rx+O7gDjYI9vs74sO6AmaWWOg8GK25siZSIReI?=
 =?us-ascii?Q?84gC/c3iggTNQZwbIJzztS9ZfYgtc4t629RQmaKt75eQKoajXWads877VdjQ?=
 =?us-ascii?Q?fKz7bhRCUNjHYci/4Ec+pbbGi28xV0Iswe1LJGEgDjAp2yYkafzo3QaDkfPD?=
 =?us-ascii?Q?BHTz0gV3arfqZ+oWNtXtrEY9VqBuVnLIj0UrQR6xX3eB6O5ee5wbG+1O4Snn?=
 =?us-ascii?Q?MPTpiLac6FEWj+EEeuM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e684767-ff63-49b0-12ce-08dd0cf410cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 01:54:14.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9IrJWh8/+fwxkKJ+XoeJ2F43o/U/lrl7NIV+HcBIVAisCClrk5rLggsUJi4xY9VK861ydhu8mSt3GJ0yiabAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9852

> From: Wei Fang <wei.fang@nxp.com>
>=20
> [ Upstream commit a52201fb9caa9b33b4d881725d1ec733438b07f2 ]
>=20
> The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
> EMDIO, so add new vendor ID and device ID to pci_device_id table to suppo=
rt
> i.MX95 EMDIO.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index fbd41ce01f068..aeffc3bd00afe 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> @@ -3,6 +3,8 @@
>  #include <linux/of_mdio.h>
>  #include "enetc_mdio.h"
>=20
> +#define NETC_EMDIO_VEN_ID	0x1131
> +#define NETC_EMDIO_DEV_ID	0xee00
>  #define ENETC_MDIO_DEV_ID	0xee01
>  #define ENETC_MDIO_DEV_NAME	"FSL PCIe IE Central MDIO"
>  #define ENETC_MDIO_BUS_NAME	ENETC_MDIO_DEV_NAME " Bus"
> @@ -85,6 +87,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>=20
>  static const struct pci_device_id enetc_pci_mdio_id_table[] =3D {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
> +	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
>  	{ 0, } /* End of table. */
>  };
>  MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
> --
> 2.43.0

Hi Sasha,

This patch does not need to be backported, because this is a new
feature which adds the EMDIO support for i.MX95 NETC. And i.MX95
NETC is supported in the latest kernel (should be 6.13, Linus tree).

