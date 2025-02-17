Return-Path: <stable+bounces-116550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B18A37F3B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C304E16525B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D8218AA8;
	Mon, 17 Feb 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVnDIyKa"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17C2163B9;
	Mon, 17 Feb 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786205; cv=fail; b=sHPf4SOBvKGHVIRW7V5etHeFCrXlgsa/vtBBbM0fi5zSS1uBon3tDKwYPuWKtpsFTbgaf6N9Ijoo9OQyL+i0Y6wFi097h3Isz5Cx+s/bHTyf5XWEJ2hjbhERT0C8qrBzNsnEu5SRgpw2U5lNglVc0/i91BCFxrRlz/6mzaH4BTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786205; c=relaxed/simple;
	bh=DMiOOiAtmShOkFZj8EkZvDqHtnacJDvRRcqJ5XMGTZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PL1/HDWEPUkdF/Xj8WwlZkNtIOBHzow7FmgMow7tqJwrRHicOySHeUwGILVbNRMsEhru0rNbftumv+8qqFIE1od8JprrqTJ3FhCYcC9xCafYj3QAhWCXxVwhPw+Qnj0kp9cmv1972dOeuYaxQAUuk/9l2vHbsT/fj/m2ZVMmkr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GVnDIyKa; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL+92HGS9F1W+ecsVBy+CDYwObYEMAvotquO15nt6DKelV3L1pCsD/OAwcyBz1w9TiFR6ueoIDgMjbdbkWJuObvEeWBmQ/gLHpXGeQvnKsaN5nZ6W2P8Rlw2aqVaGOiWcFXm4Mp2102U2rU6cm9oTsg8+39LZg589SKdyoEx/6nfhrQwow2sk7G0Ka81c239zCNvmUwOQxRYxwgqGX1GQVKDfCIcFSPefQFWxki97vTx5T5CMhPwYjfVQw22xbiEXmBDjxpPpkVzp5tuIhs3ij7COvx6MI+Jg1EfZaOznlQVRikyFfvSo4moslTbBjg5B9KVuomMUUiAwqWcn6re4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Md4iT8uDmV1FgPKEe2IVNAh9iF53foUzVdVmDoC0GMg=;
 b=KVEnvsZuhNRz1Vm0IjJHR/qujNylMpn72w/9PmnzpRPqml+o3XX7teC96UfKH9lQnub9OBUDdscS3Hx03OA1tlOJ3PwOxlJaizGRWyHI7neZnIJH+MB6hwwfs1tCnYbYu3K0RO872E5EsG1vzUhZmF0BtvClsUO8IpxO1oRY3I4p9hMNNlAjV+5harSV0pmh9NFdo/Eq3Z3Qz3/CYWfwXRIOPIALHkVHbIWfzbOwzgYgawhy04SGLhMm4ISzZmPetAEUXkqoEKCyR37Y0bL6aOo3203+APGAJgAhOXVSdhcMEOfbsIPm/VM6iOSXZiRqSoVALitMBWHA+uc8sfPd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md4iT8uDmV1FgPKEe2IVNAh9iF53foUzVdVmDoC0GMg=;
 b=GVnDIyKaGBAuO1C3KR4RR0skWsv9c/MjayiNFud7KErHqHDGNM81OEJNMDOSAwUS4ohqYaKNCAKOk6TJ8ul6DxMMjxmo53i4ThHt4oGNTP16DfwtuKMm9zQpXIA32KdsKRsji7NndnEFmrHTZzcGfXJL9etLW7si0ycVpJB0Wp6GJsBUNF6LQDHJs7do0PvDfd5/TKokw9ElK6XtaDDnI0/U63CVaVX2GtoOhMda7FFrkqXBKWKMKY69b0WqJ7wnKzvz6fTuaj73ykjU91w8lIsxqfhCHlcdGRYRa9m/6VQRi0MTakkV8FTRTKyFvw3WIHcpZpq8HR57cF0IJqvWCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10240.eurprd04.prod.outlook.com (2603:10a6:102:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:41 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 6/8] net: enetc: add missing enetc4_link_deinit()
Date: Mon, 17 Feb 2025 17:39:04 +0800
Message-Id: <20250217093906.506214-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217093906.506214-1-wei.fang@nxp.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3593be-542a-4875-94f9-08dd4f3960bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DIFWxGh3NLWNpvM2xt762EQZTmaPChCPpwr7qKineh4PvV8qFURrNHTLYpSv?=
 =?us-ascii?Q?T53ZbyyYg+ts5jo8P0ck3ar6cw6/ELkwV1j8t9e9lm+memTWnBsygJdJJNsF?=
 =?us-ascii?Q?f2pfO45INjrHmZ5BfZS7Det6Ju6gdkpK61wIEoJRbx9D8Nb7yG0Ul9ibD+JC?=
 =?us-ascii?Q?FJjjkcA0eCGheyhLnVPpIauAgKla1isu47zy9qd+UXU8m7Wcx1qAHAkwLslp?=
 =?us-ascii?Q?eblV+TpahhWt5no4Zwehjz0nu/z/jLDPQOA+nQKMF/23Mv4G1vzPVOHNWIbY?=
 =?us-ascii?Q?suxYwBIEYMQVBq8ak3OwnjSZvdDYPlrDzmP5hZ5KZwLxj6BDprQNddGzmvdd?=
 =?us-ascii?Q?75frZBnivOXmUG0xByGEWs7IyPOq7d0QK0GAoykpR3xL3lVOseLf/sPyKemn?=
 =?us-ascii?Q?YqsCClHcQGddqLlBhYfrS9XXBc0suL0iXXudeERihGs64WHQY5tR2cpZYGag?=
 =?us-ascii?Q?E+3MpfQ3u0L35eTKbYLdtRWLHqYA1krWIwwMQBKL7lQRMigx3SOk4cSYE3FD?=
 =?us-ascii?Q?JR64x7n8oQC+x7/YYLRhXL9Fwh8moBO5hNrvCy9q8z/w3zgxhu+dIPU30UYE?=
 =?us-ascii?Q?vo66h+U8ag2bfzc7TbcFIQMYhJVLxPQXqTkXjOga/WN0YhNLG/dH7CpWxLYv?=
 =?us-ascii?Q?U3jbAJr0naX8qcRu2a/IVjbnb0VkpZM3nMiwWQPTDEyezFjj4WOFrvKXxoAh?=
 =?us-ascii?Q?/M71jK7+M5Fg1t2xFX2PcIEKh6CiGMXEYuOa3EH5neiIelRHBIOjxDPxfj5S?=
 =?us-ascii?Q?y6hnMARx8tr9w6OhhDqz9BexxTrMmCEvDolUIwvDveaEdl2L6oqYmq7B+jrU?=
 =?us-ascii?Q?UGIkZ8JZh14Qflt1FR3Xwf3RTCG5Xjq57IJwrkNYNEBf04GW1b/mpoeVbi40?=
 =?us-ascii?Q?7pjyeTLM3EGJSNzgECdyporO+xy1eMyoZsZXxvjPfIo203t6nFou67pIy4Tj?=
 =?us-ascii?Q?HzojXeemYBg2++EQWBY7ugEjyS02MCVT1QXqbsIJ+/xPl9H8UUDeFqxdjHLW?=
 =?us-ascii?Q?peXQrRZiP4/UR03Uu+Uje37nVeqKLuGc/HC/eUN1VL50neT7GgpKCBx0nlCg?=
 =?us-ascii?Q?bXSC2vxVJ1OuH18sGImLY6kH7QChRTgBKL4eDmIjcFNQT0uwm3IZcaLZDU7F?=
 =?us-ascii?Q?1Pg39cuY/a/L3sUtuucUW6bzRmOuMrUbHzJa7KX5i3xBCavlA1l9rIv2Uv/V?=
 =?us-ascii?Q?OCxGtWRCSiQ/9Xn5eUcLvC7RHh7cWlNOO+PXPsY8NxzEuqTi7SUyskCNH2F6?=
 =?us-ascii?Q?ZgCAZBsgxbPX/GU79kJnB1sIYCF5ZscbilwPkzEGd9+Mcx3PrxwJDKus/uIq?=
 =?us-ascii?Q?AEubFOqBFsTXiVCxCS4OoT2EhR7r1Q70EEwGkx+Diq9krMaJ3Fp2obWbajvX?=
 =?us-ascii?Q?Me+g0o3UFAErgd5zVFUQA+ZjIVEDZbJPjuuqlxcGs0FANnxVA51Ym/xGTJ15?=
 =?us-ascii?Q?MthwE0lSxucsyQMqufYMz0Xb5xUHKr/i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BDkp6Jy0NHnOENI4CJ5F2aPcjHOsKIllRaZV7qVDd6cVDhE0daL4sv2rLQlg?=
 =?us-ascii?Q?7OU/N8R5KIzgnTE2MBNBzk6RSpmlCRU366Jsrcm3JY4GDCuUd313mH6PSg4H?=
 =?us-ascii?Q?v4dXTh/GByWpiU6ayufqjMwTLpEpDa8yIRmCTmNkLz9y9EKuP5Yje0dAIrI6?=
 =?us-ascii?Q?yh5ID3FsMIMZVWE9OJczR06P5sy2oYfZRGHRrN1JmYB9gdjCwLOEndWQ8so8?=
 =?us-ascii?Q?7lMobO8zVEBtfpbLo0sfp7RrdUHUajDwed2Rtn3iv8zXNZGWchswH3p+tseN?=
 =?us-ascii?Q?U8r4cM0Zcu0rUS6fszZxZo5chYLAigYLXoBetDrsNX5pDhLmuryse19dL9ND?=
 =?us-ascii?Q?hP5HzGcHwYtpfgpbviHT5n+pMEA4ZO2YQQM60qK3ogCPE/jRaJy1vL1XvNrB?=
 =?us-ascii?Q?dTHRUM7LLc5jyMklVR/DoBQXH3bQ0tWl1OX8HBwUTOt/L64JmI1dTM4xBK1j?=
 =?us-ascii?Q?crQ5PxSdGq0Elsc/KJPwBwT6ZF389FNvr0cY33LX64akzvWgrb9mNw5laAvK?=
 =?us-ascii?Q?tuj5VPc6TE3nb25tLybDM1uKw2dYXSqKfoI/fJiTd5ZcUuRHfHHvxaqJw1oD?=
 =?us-ascii?Q?jYs9nJfZT/EQ5g5paHUyDnxPbJJj5PVm8WsAOQiyBgXyB53YCK+xZ4jAyMIJ?=
 =?us-ascii?Q?c2bPIG/6T+kdiRMznnqk5y+czkEuo0aXeEjI4cfQ/xoucd3USclm3m09vsol?=
 =?us-ascii?Q?MhN1ic2Busu8ALYes465uA0KzP9XiT28XpxvyrJPkibuuK0GeKz5G3GFLSNb?=
 =?us-ascii?Q?Ca8Nbu00UHZdyeCXinnHXOj3zQcoqyBT414cHtugSFaswXm54shVmLlM2640?=
 =?us-ascii?Q?tk5og9wD0aSTbBMDAW0tI/2Uqf2C7uKIKu84VPgxH7wZZQvxdwgpk4fYFEU3?=
 =?us-ascii?Q?N0xLkDM1//MSvcqb6EHLmXTkojq3UyqTVaZ274359o8jS+ordjlaVmJoG1tE?=
 =?us-ascii?Q?bzwjlMTbsxTPJKbjgj3+4V+81vAXA9S8QbX1+Cw/VtBg3sosOS5Uj8dAh7TE?=
 =?us-ascii?Q?8xzapZ4c8yk45+SQoKxgJqi18cDAfwZiwx2IA5g0xMsTnuNjitAg3oQy2mtg?=
 =?us-ascii?Q?vEKLBV4GCjgj7EY95F0A8YJ8rozTnIw0047YYmvorSdegdX8ivCZam/+atWD?=
 =?us-ascii?Q?f5IWOrCj3dIg0ITP53RV6adqPurkaGRas6xUuk9WsJkzNO4w3UD1+kV1BHBW?=
 =?us-ascii?Q?kwgypVgs5Fzo42VDUbZKUfzm+HGrL0KPDWeoFRFlycj3aA2SV4Uu/1bQggdj?=
 =?us-ascii?Q?tO1Z0/1oyzq+S6F9iwjfKew6Eg4TjB7orFcxYfnbngbfkklMB4bi98AOENp4?=
 =?us-ascii?Q?EZgRThyBB6Lyw8Mur1KBGaJB4K0Az+isHwZDHTEBUqFoP2i+N7bLBClT8uy6?=
 =?us-ascii?Q?PozTh+VVq0AvPFdfcn0rmMVi02pD4gxJZNPopYBZRpPBXzooUrjbvmCikfUc?=
 =?us-ascii?Q?YqZo0geWUgLB5w6evvm0itfUuq6dzlKPnzqsZx0skNDkM1n4WlmD7hjOLYVT?=
 =?us-ascii?Q?aYqLXZBzpXT/XwAoj30/BeK43YgNSttOqG41WZEuj70E14hy0v+EDibGiaPG?=
 =?us-ascii?Q?ogtxLwmw9+PEuN4+FkFdVJn8kk905lQXQFAN+Tme?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3593be-542a-4875-94f9-08dd4f3960bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:41.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cc/gDMDkin1tNmvbxv43N4jpaI9nyPCsETHInDcYhIxj08Ri8PYyYk+4YWsIdtrYpUs/LMW+6RJelPWwv/vLlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10240

The enetc4_link_init() is called when the PF driver probes to create
phylink and MDIO bus, but we forgot to call enetc4_link_deinit() to
free the phylink and MDIO bus when the driver was unbound. so add
missing enetc4_link_deinit() to enetc4_pf_netdev_destroy().

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index fc41078c4f5d..48861c8b499a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -684,6 +684,7 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
+	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
 }
-- 
2.34.1


