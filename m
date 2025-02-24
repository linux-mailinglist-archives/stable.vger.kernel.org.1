Return-Path: <stable+bounces-118901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A484A41DC7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A73164A22
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BBF26657D;
	Mon, 24 Feb 2025 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kgTOixJj"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC3266564;
	Mon, 24 Feb 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396619; cv=fail; b=k5WKqEpmfu7V7b+kc/PMBCuouryZ10pqgFmD1GJYqH9UWhk8PE5Qt/NUG/tTqm7bZTWYrpfDWS+DAkOnhxzxgVyXdm+DXR397cBQ/JA8Bj6QRpOsAxOmWefxG2ldD4VgxK1RbZAV3NcPNTGP+rI6pcn+XYl0C8JOFB7Mqc11eoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396619; c=relaxed/simple;
	bh=d95uTb4E7SjfBKYC6VeqEdGb+02CUvsjO4h8I3h3iHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PIPBjK4l29hdoki1mwb0fdzgiw6YsQUWjKQfbmqpnVjLbrOlMG0USVW7gNyVN/nwWyg2hJJ8VtjGESGwhlSdyG9qja4qBmSZWG5ysUevkP8eg7ZPZYm301fI/a4AXnl5SpfkFMeLkjB45sUVJoWIURimMatAoGfexHJWw2cFo4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kgTOixJj; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4M6vexMeXP0YnaSIs3s/LqKnjYgKYYedYH5sSmQhq1CbvPRA8ihPmcg3GN8bPKBk5MtfyH92UsyRw8q6hNMEThudAJjFbLJIFYQny8KXlfYwmRKji5VUgCAN3uhnXTw9tjSnn/IdfbawyYRSx8d0UtnDerCJVyb1rjx/tBE9b+qXim1Ae/mFCsWVuX+wEdhDUoRmu1/iOPtOLuftwSuUYKg3QZ0TR1ImX7JjiOWCfth93a8SjAB5JIRrdk3q409cTTf5Obunl61oYqdp7UqX+csb6nNFzh9dCqm79hhMwXm9VNUhXZi+tA2JUGOB9OyqOw9RYqULSSgnX8VqFWcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij8UVt5/IyMuo38AK4TIiXaYZd4zaRYhb6VVENBCn74=;
 b=v2P0h2zEztXV8Q6CXPg9PNuI1R9nWFyuDrXe9w2HReI3+XLM7DD0YAuufs98zF8ms25m2zZMR2O02dbM5SrQE1YUMDJcG1nUSFoCsQyVHrMDx0UUzO1GcpH78JaRy0jCSEsDWQcN6aLWovB8ix/Io/CcK7SFqs1MDYXbwpBFoa2zKB1cIzFoSw0yi1KCp8BpIiEn9hD7q6iMCdU2BsSB+cfr/rpPr7f+cstVcUdvJ0ZN8Cm169XbTsiT0LA/aSPDAam/omjUuFh2l/a2su2xmWuK6uEOGOG28jY8v+2ciDH90+ZSjmtvQall1XHCyHwLQzpNhPuzLvCbcpAymBs0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij8UVt5/IyMuo38AK4TIiXaYZd4zaRYhb6VVENBCn74=;
 b=kgTOixJjydcqvKVzGl8F8kDsH0q74DcCf+LDVDhT8hptI8lwpMbL1cb4ApU/T+F3ynf4dCB5abWe0V8fh+9oJ4hBTIpd+Q7to2Yz0MntNjc0j6E8sG7SxuQbMyiLfVwJWY6msoCt5WKn8i2xCohUw/lJuyf+jDWM5vbyLYvREZEKPSVLGHIqM/exL2dJlS31UYJIKf1ydwQmKZ4E4Q8xP7AHWDM1rP3e8NskdaJ+Gv4uERum55EaILjbHfsxcNC0N1AsU4hRRX0JHbJIzdhXzv+3W9sctGXgC1/AC5cplcIYTU5CHVmMbIBezN2vbTl9oZjrrr8ikXVuA+7d9pMk4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 net 4/8] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
Date: Mon, 24 Feb 2025 19:12:47 +0800
Message-Id: <20250224111251.1061098-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI2PR04MB10979:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb36ff1-9b55-48e8-d0d7-08dd54c69a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ms5dRkBcZnQ/Pm9OIKVcSrM6LpN4ULwRBXqs4eW1FbWYmOlheDXkuvYWOKM5?=
 =?us-ascii?Q?/e6HSA9H4D1j+o/+ovr0HK95gX0QEBbRWQ7VOFdvyYV8eV2FOZOItheHscrB?=
 =?us-ascii?Q?0em31T3/qVXTTiukZ3DDeM1TVxuarUrjopAmMWOWfxT8f8I6KkHTUb6N+BWT?=
 =?us-ascii?Q?aSRhohnhLG40RwSm9XbwxdVKB3aezwKna0X6l57Id4sv1rPSMkXpukTrAhYU?=
 =?us-ascii?Q?m1HgSoWgkL014Q8x+EwICFzLVnNAg65K95Zkkg2IXxpZVjVOeJuS06EGGKUr?=
 =?us-ascii?Q?sY3z17tYWrvb9Ka9eLKiwKWr7xnWqGPvES0K1OplxsOXTBT6H9eamlPnXx4G?=
 =?us-ascii?Q?ruNghErHS0ShlA+qRm5AaIOyN+JPSComevrH/As18YNTbjBAEBE/yD3Z3d3c?=
 =?us-ascii?Q?d+Nou9nsBxR4ZICpEXmH9L/WRebTOFn5+cNxEAUonm1kvPvBhD9+eP07UQlL?=
 =?us-ascii?Q?OBel4lzHKSATnl5e1UQZ/2aivwkN7ZN5bHnRb305sAo4FdbX4kzOnBayoogD?=
 =?us-ascii?Q?YuwYbtJgKbT9vqF00kOf+v6ojsmjjGOAHNwNFwfSOO0OhfCFTLuqPNMYPkWx?=
 =?us-ascii?Q?aV9CibAnVTmU7NpvyaIaDBljrGrvh6GPVYG6cTsHTKGJOIcYNgat+Lh0D081?=
 =?us-ascii?Q?3u20sVZI6TzCAyDB7wJPnyfQfB15qVa8YoK+FISnDONd88PyG/EW54DMCD3i?=
 =?us-ascii?Q?oFzzci6hWjbol8Z55TxEo0y47nw6xwss+24tDJtyZwT0G6EfST32IdQIIThb?=
 =?us-ascii?Q?eo/GR0kgjjZ00Y/gFLS067poPmSbUvoLCB/Q9ccpuGP8C0RG411v+rdWt1YU?=
 =?us-ascii?Q?SGegebzFr/55iNy1xEb4XCYSfAym1N8zsjEXfNUN3+2Yd4z0NLODSMdsrG5r?=
 =?us-ascii?Q?ZC2Kicqxbk73ttSHYGIVeJVZHDbtcg23ZSWXnTO7gGNhJutao93Er4FGokxb?=
 =?us-ascii?Q?SB1vRNF3UkCfw+GdkFq5UNF+q3qYSwGBhhJGD0XGYrc28Wq/YrVs0UUdMPPH?=
 =?us-ascii?Q?W9vFCH9tQXFUU+tVA6Azgy3AiHzQCu5ll2jE/UvHW2R75VtYJRAJ+JdazAK7?=
 =?us-ascii?Q?dHd+i/sUmlUldDmhN/2egOUma4IktrqnPw6aKhVj4qacZWsr78leFkDmCPPK?=
 =?us-ascii?Q?pLDmcbV1z5UPs0G3Up5F4Q7KEfVVveZODO6W77fX/M6MLJYnakc8D1RHiR1S?=
 =?us-ascii?Q?nATB3sVgsBJkNpZZ3T+/Ylvbn4Wd9OdZNg4Pnhb5CYW8M3PUbSs0u/Vhb8GE?=
 =?us-ascii?Q?HTXcJq0zzRi2QH5xVnmlpAPx4jVMfFkY3AoIy7NTacPm70snAkqnFVbubW/v?=
 =?us-ascii?Q?ifFTUVGaopI9UXuxkvmTaR94CStXJqP+hQhzRgFxzwPDwpXVdI+NRtsYjTdU?=
 =?us-ascii?Q?aT4RLX/zZvEogZfgPKyzOahb5Xb7sf6Qf3ZzrKVzu+ukBgw14KybuCjw/k62?=
 =?us-ascii?Q?NNzfFhs2D8YmU3Hr5jKsegvTAROnHKL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sm/9B5PYinPd2R00i4nSdlvghfwSKB2LzioixRuDAly1gIf71ZeNevCTx1tO?=
 =?us-ascii?Q?5w7MxLVpw/hpvTcH87HdJxH3ibvKeDnxXGF93wnKZ9cdyLPjMceiS4xsAm8j?=
 =?us-ascii?Q?8Fk6Ah1iJS2wyOcP6JRKMEUtdpYl4azyK/gLheLWffSsTm0hRPvK1J3NweCk?=
 =?us-ascii?Q?ECa+1vh9TcZCtsG7lp7trOAkkTtmDFKUo+PPkjI/MS8kWAHnxKEZIKS9XjOQ?=
 =?us-ascii?Q?7dmbifdxLZa39RwrLg5Zvm3NKum+UH2XogB7BTDcQBOchLEK61pd+CB6AQpS?=
 =?us-ascii?Q?eXTeKzMdSZWRP00d4sVY1hcNkas0iAc/wC+WAxErv02HQlF2vpVwf3mNH31d?=
 =?us-ascii?Q?TKGk17BVVUSxePtfUUhF54lnDOC3675Od77BqYe+uFXj2FDnB+MH+jc4tkyW?=
 =?us-ascii?Q?RkDlYsIfOR9WhTLrFd1OFCTY7ViiKqMhyajMwk2UvAsTOBZxrQqlGmDV1okS?=
 =?us-ascii?Q?cqT/8pwpXb448rgDU6an9N4E89anDac15d8r5Ja5bdu0FCyNmYOsrvAcMBfE?=
 =?us-ascii?Q?4p+AqBZGAYaP8mJkWBmnvd9ptDz41yb+D7yer6evGKB5vcIVzKUiAhWtmMY0?=
 =?us-ascii?Q?lVkYaQV2DmHBE6S/2W5+HgBXjBCafZQpRczZCXULZXoQrkncQ5/ShHZHP/Qg?=
 =?us-ascii?Q?UuILt0gzHbspHDh4/IyDSs9LyW9tyrKG1/XhL3ZNZTcqtaWKOWhW6NJmLp0n?=
 =?us-ascii?Q?mBdV1G5k2dBACP3xbShTQB3K0RRRSrtDkeF1yVQvFPBlFr83ZavkJOOdN2Tz?=
 =?us-ascii?Q?2IE/iu/G1RP1DxzfrZJLVUvdw7B7eAu0k4GLo+EMAkrxlGz/jLvgqbj6OKIw?=
 =?us-ascii?Q?IjVqSv5LvDKo0DGLytHZDtQXj4ydV+BmyyOITDe6lnz1itW3DTlkFuhlDdH/?=
 =?us-ascii?Q?HkNzADj8YiHkRley3Zy89zhGnmlXzcUeqxznutzSmLFY+OOZLVvFebeO+w46?=
 =?us-ascii?Q?sX/UAb7HdXL0kdnivM2Qn1EpzeLoePjBa4t7jzuBFkMXR8PuK3rNIRFB1/wq?=
 =?us-ascii?Q?jKRH9iX9covM6HOTZRRQyjD5SCthBkO7p+SBImFz3kc+IgImMshBAp4Av+D+?=
 =?us-ascii?Q?eK86dQOLDOw7Eyj9NFt//zr6Vt4sX87c1l6J6jkWqyaSnzWrq27Gi7noMOdK?=
 =?us-ascii?Q?HV6oBjzjrpX3cbV+jivV/a7s2QRVD5J5CdyOtgJw0QYdQMs2J31FH9Pi4xZN?=
 =?us-ascii?Q?ha2pOEbR88PU8fF1qV0IjBVXl27ChixSn7EiEO5ubv9sA3ZgZM2dPkWdnznq?=
 =?us-ascii?Q?9X+7yTeDBeJBaUMg5uhQwnbUnTZUG9ZLWaY4YBN6oCWHmvsFMRFujrQ8Xe86?=
 =?us-ascii?Q?GQBRnwIzjt4ZCrzTLfNS0AMj0X1ii7zvuFkrRIOEa4r1e34BIl6nseW4zkmC?=
 =?us-ascii?Q?W7n8l5lMUlzfWXbAUISLZgFQLLy2qcN79/9SIRSxFxBsOC5uRMSb3kxDFa10?=
 =?us-ascii?Q?sW0h3qBvqdc4dPDm3j4j826lWiOi5rS/kcerC1LwbYtD1eMpCHM3Gg+HJr3g?=
 =?us-ascii?Q?t+uqRGr+VtyPZUG6iVSrcb7BQK+kPbLgQ8dmBCMRYhO/TfFSYR0BVi3iYFEA?=
 =?us-ascii?Q?a+mReVKCr9wmDCxcgXUK3j6gQkYC/SNsvzVjmyt/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb36ff1-9b55-48e8-d0d7-08dd54c69a24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:12.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiA/nSfrIYTbk+GsRljzeFekksfp0bnkYqQcE8XFVVsPlrX/NqGR5ZAkgBd+nxalVpT7h59YFHS9g0XRMGuFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979

Actually ENETC VFs do not support HWTSTAMP_TX_ONESTEP_SYNC because only
ENETC PF can access PMa_SINGLE_STEP registers. And there will be a crash
if VFs are used to test one-step timestamp, the crash log as follows.

[  129.110909] Unable to handle kernel paging request at virtual address 00000000000080c0
[  129.287769] Call trace:
[  129.290219]  enetc_port_mac_wr+0x30/0xec (P)
[  129.294504]  enetc_start_xmit+0xda4/0xe74
[  129.298525]  enetc_xmit+0x70/0xec
[  129.301848]  dev_hard_start_xmit+0x98/0x118

Fixes: 41514737ecaa ("enetc: add get_ts_info interface for ethtool")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c         | 3 +++
 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3cb9ebb13b19..e946d8652790 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3244,6 +3244,9 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (!enetc_si_is_pf(priv->si))
+			return -EOPNOTSUPP;
+
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index bf34b5bb1e35..ece3ae28ba82 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -832,6 +832,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 static int enetc_get_ts_info(struct net_device *ndev,
 			     struct kernel_ethtool_ts_info *info)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int *phc_idx;
 
 	phc_idx = symbol_get(enetc_phc_index);
@@ -852,8 +853,10 @@ static int enetc_get_ts_info(struct net_device *ndev,
 				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
-			 (1 << HWTSTAMP_TX_ON) |
-			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+			 (1 << HWTSTAMP_TX_ON);
+
+	if (enetc_si_is_pf(priv->si))
+		info->tx_types |= (1 << HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);
-- 
2.34.1


