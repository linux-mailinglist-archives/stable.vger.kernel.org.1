Return-Path: <stable+bounces-116551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13449A37F3E
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52CB1883DB1
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99068218E82;
	Mon, 17 Feb 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntk5eibK"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE8218AD3;
	Mon, 17 Feb 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786210; cv=fail; b=larxY9fWL9eqF0cmweuBs5sbVHx6mutzfpVq6BxyRWX9dxNRcXeGs22ylVGHaep+UkGEuC3z3JKJl6DGDSlOjmwbUVu1CjZ+FeaTFFZXrAaCnBKCvJL/pzX86OOyZDZC1lsWG3Ma2Bh1FYmIvCRf8d9E5scojQF2MutFnUUg3kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786210; c=relaxed/simple;
	bh=TK8zzb6lcx/7EwiJ6LgbkUB1e++wKy3OMXfT4gTWDT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NpbNNho0DMQf9Uvd3Rb3Q6oSkB66+zuw0UNjha8aIvmUPswpPnfpqFxVtG+KSiTgv9Ud8IKz+PjZ4igJYk9v8VZKVlNCHI+ptzzw77W71aVUVZhDgbuXDQ5QE7B5XV7LrKqfWAT3MUiNVtor3mHssAlTe28fyXXS7+kqwyWVETE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntk5eibK; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH4T4zrUWQBOkOPncukbebq8JwnoeYUmYRKVFAEbKa1CYNu3Bjj3CTFZ0ag738c+SkJG9rQovo4KOcB+PfWwPR//P0VwZXirDw2U32AmD4+5PGl2yuh0bD6GGl4Qrla6PhyPXPtYqTqub1BOkqPfehMII2mp1i2Y8SfzFHpQVOrvctaHIKW7kgBFa9H3qjiKYAbX0Wee/3pu5r1ll9SKJrf8gkTpM5PcZ437cIL0f+L1gTDDkQSwX57bK//EJAw4czL7L66eWDLxOFybQi+G0Xb37dwy6l67R3sxD2D50khcy9oUyermx7E9NHoc5neMGcAEuCKISJWSIY0DIYInqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhIb1Li+AuFtuyXvissZeJNMe2D6w6MVfz0Fj6OzTZw=;
 b=Oud2W056Awd7GWjBGscA9VwYiAmf7BPGZLVamZBu2WOgdinD5Eo0UvXUlh9OI+JRgEDtrF9YaznOQJy81sYrDL4M4leH2+in86vxw3+Ndyz8lW3YyUvRq8exLRfmvMqDORh9RVA/YX8iWp6oaBdJgHTKSE0vMfvZGiZzkCWoEI8xNO1CiBGwUuaGoc9KvoruGW8/EPBU8HoI5/9jQjl0JgD2c2KrveHTGAM9aJcalaquje2LqEg9aA1gx1oTqTobOx4ebf+ppUzPFSeqQQwhvYLfjVm8h0ktN8Az7090jgggiN5Fo6e8bS9mhpOLLP4E6YlGrSRRCvTb0adDM9Pi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhIb1Li+AuFtuyXvissZeJNMe2D6w6MVfz0Fj6OzTZw=;
 b=ntk5eibKIDKXu/XGfVsEtvFhMeH7FTpYcRwtSViHzMaJA4tPnNdE3/tNHTsjkVsBeGuGjxhqkr7J2UwLPx22E1irrWc4+IUFT2gRZaMS4xgD87ISmreOV2PTWpB3lW39Z2ISR5WND8R1dWmA8fX2g72S0nTMhzvgkeCfw7QOPMD69gfBzbohsp/kCISW+3mF6mNblP1+eIFaXcoZ8j7DhyThVRuwv23K3T9ZzV0h5iLJUIi5H1PiJlXGh3h289xNTboGhPjKU4HCRbwmXHhMRTZbkEn1Yn2Mg0qZ7wtLkW5cPa7DNMWzDWYiUIwkMTMBFXmfbyJzNuHGZff+omcDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10240.eurprd04.prod.outlook.com (2603:10a6:102:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:45 +0000
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
Subject: [PATCH net 7/8] net: enetc: remove the mm_lock from the ENETC v4 driver
Date: Mon, 17 Feb 2025 17:39:05 +0800
Message-Id: <20250217093906.506214-8-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cbf49ea-f964-4b32-492d-08dd4f39635f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emMPMpEaOR85xQuWtHeZkeccwddCJIHY6U2tkUTzk6XmfbRKFRdb6PhXi/J9?=
 =?us-ascii?Q?nAb2kb6PYSxaVmxlF9amnXNu6yo63CYkay/ihDAowicvmYIfd49dX1Rlxg8c?=
 =?us-ascii?Q?mGQMtEhJiRNvGh190MlZLiMR4dtcghAtyuNsiDTXzJdOG9Jkcon1uVMKC7Q4?=
 =?us-ascii?Q?vY1ZcFOfSmussbz1vnJXACMqNdEoFtDROwY16fPlC3FWDPfwUTsk3XeUMSmH?=
 =?us-ascii?Q?9DO3ke5vhZth+Ll/2NaSE2zaOhc8Hk6liUdj/cP0oWwrU03UR6QmAhQzqY37?=
 =?us-ascii?Q?yaQukbl30HWbzmBB3NvcFGapD9ihP/40oeRhNKFwx+l/ry2Nuteu9lIXOk/1?=
 =?us-ascii?Q?EB//Zji1Eb5Z9gvbBTS2k0rzlL33zDCcSk23cwcekBrCY3fk0g3p05JSsvbQ?=
 =?us-ascii?Q?e7LPLkx947otjA+2jQyxYiM1AUsv05sPL9tkIuD7k376BY5+q2K7u79SVeWG?=
 =?us-ascii?Q?vhbgLck9iIOMa/sTynSGW8kzt0ORFZZbP3tSdxAdqMcgNeZ1P3dKR+drVNLt?=
 =?us-ascii?Q?1hnzeElXWNoLhz7nh9rbR23aeWt+53c7I1BfoLiovlVsS0aMTq9yHUFGREOi?=
 =?us-ascii?Q?rP9bZWiDXOQzrx9BBDZC8+Cj5Y6cH352Vnv58/GpWQ1rkHCAJt+Q9sMcH36Z?=
 =?us-ascii?Q?5q9NfYIldtGLY6S+4YqIj3eEYOajuufV7JDGxHzqfmY1Cy05cgVoSRO0V6Ad?=
 =?us-ascii?Q?WLLo7Tytc/BxyiMoWtgCd8+5qkdo+beLyqVlnlXA3z6nh+rcuEogABOliZfO?=
 =?us-ascii?Q?HbfFOpPpJjWbL4l+4N5b5xbtIn+mn4+koZYEehaFoSP45cBK1cbaNKhyE0kI?=
 =?us-ascii?Q?lCjXOhrg0lYT6zMk1VWDSGo7ndZx1DXbag6pV/M+2zoXb3aG7YXp9AKUWmo9?=
 =?us-ascii?Q?kLM6OORq8aVu7ASqoe2JV6eGdiSGX+kFC9AK9YO298Shd1KITn3vy7pW5aop?=
 =?us-ascii?Q?Bpgc1x1q0FZhIWZCTSlFMP5HCq2gRaZ7LGYJz1alDqNMl/DL3AyPuqmBvvZA?=
 =?us-ascii?Q?LP+szP1yKNoYqOhiGmKfWQ3mPM+RDRw5yMm9Xzyfb7xbc2+ZRw/EgvAesrNL?=
 =?us-ascii?Q?7HuwNZ590oPn4wUQ1SDyafaSpsQdD4x3Y9btRSoYkM9dLt/WNR1kxqpo3Igd?=
 =?us-ascii?Q?YoDGVUzIs+2ECN7TzihSZnIHIx9ZCwjw1LXefMTIt6ZCY8MtZzH/ZZjgOGVd?=
 =?us-ascii?Q?29X+U/smNQLhTYIzBzyc9UH7+UL1vsTRMkDTNZE/H4x19TQb0E2uYDur6aQa?=
 =?us-ascii?Q?kF3HS1A3T1b/9KfX1gYsHxzyR4/c+OWaD1aSQAzttVx0sON9qtj0dlrpF05b?=
 =?us-ascii?Q?haVUMD6IScJHmbFLLF0pHBhiLWJdy8J6z3T5IdWM8ZitNY81khRs3jicNEY/?=
 =?us-ascii?Q?ZLEHg9QBX9F7JgdQMP4ib/DwGodW5Qk3vWnnYxlK4J+w90QtQP3AMWp3jyrI?=
 =?us-ascii?Q?ozY92mE5xJwZY9HIDq4P3CTrSqMJDQzK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cq07yCRnchWk94gqeUmH0JWkrwO/hGq5EPs7Kf5zw9y6uI/Q2t2iCuEj4mp?=
 =?us-ascii?Q?PkdnL9GSPd4X1fhe7/DNw69e+PwpTZ1Etpx8V5u/L4FhUregnEKfnIRMJGYY?=
 =?us-ascii?Q?+ur7DgPYMPSE4P1aeKPxT45xgsFJSHWeGPIGG3bNj7u6wRyV8asGlB5NVBZX?=
 =?us-ascii?Q?kgta8A6zbeEygv6zdVaweebJn1T04qqQIkVAew9yZ2UpUWjzARA5OT2xOUcU?=
 =?us-ascii?Q?I+cQFcEgTCBmAgwQijLpoMXPM5Et6OcIEUexbpCaAKFBvJWLI7IBlWqIuBlC?=
 =?us-ascii?Q?KoLYRvW/c9c0YUjMy0CMMpqd0uN4lEsMqAksOxnATKQGlRqhRuJ74rfjvIQa?=
 =?us-ascii?Q?S7Kc/PfHf9U+6D3lBImqCK8XpqoFi8jHSWIJJ1gET9HXtVsIETH5p8AIY6TV?=
 =?us-ascii?Q?cCxPVdRUr8VZYHkTYzu0tPCaR4kcoeXFzQQ+6pyw1nKHWG2gi89nwhL07H/P?=
 =?us-ascii?Q?5F8YJgUsAwZXqvPnrVNy/YeoOGJgKDOB63rScQWANpxDtsTqZ+PyI1afSyR4?=
 =?us-ascii?Q?Y3mWxfucFMVv1IbctDs0mEjmFh7EVdCIPVfHmKA0Lsa02n5rasSo6TVWtRE6?=
 =?us-ascii?Q?NvUYQ7kMzBfi6qpFlR9Ed5EdqMlng+iki3KIiuLHTV6e/bJvU/gPnY7NkBh7?=
 =?us-ascii?Q?Q+dquJX4iTGBREyNTDp5oOpjRPCCjb9gbi5c8gFWkDuyGeMZstPtfakpQQzN?=
 =?us-ascii?Q?Cpx4PtI2RviiQI3fAQYmTVgMvMay2LNPlWfeGbiBhpSu8gOHsG9H69jMADZ/?=
 =?us-ascii?Q?m/OFrgDgIiUiJAhT7r7ECDSmMf6ZD9/C7KL4ZfMFFBobaUFglHs2CscOEUbY?=
 =?us-ascii?Q?ajMo+8AQDiKeJC/fww8dHpEH2UNLtOSFHje9glgP4sO+VjkQL7jFb3XLFHuD?=
 =?us-ascii?Q?15ANjYbOuz0d/jDdGKhsOrCvXjvRh50nKvsNluOd4WyHV7nesuurFZVFIWt6?=
 =?us-ascii?Q?BXMBpv5FlErvxesrJz75tnv9oiJ2KejFBH3p0yyWDvlkhDM1g9vzbSfIK+hQ?=
 =?us-ascii?Q?OiRPkW49eMV0BpYqHVmeuLjcueXvKIxu/BKO1SE3ySdJAx3FS+FcBPy7C+i7?=
 =?us-ascii?Q?OTxaDW//HQvazjnvx/9Edlx3oD1x3WRjzyeYCXVY7cqkXczb9/9yLiApqjBG?=
 =?us-ascii?Q?+pvrOrkm/HBB/QFzg12WpZUDGXslXh/6lribW9RjS5HJ9BU+o4nbkEL8EEHg?=
 =?us-ascii?Q?8zYHm/6QLlrdSypeiSEfFsk7xPbblrcXTYku4vxkCRjnaDerVOH9Dbph8WtF?=
 =?us-ascii?Q?kqxXlCcYad4gPby7W+ni3/CIJPuyFoW7tZ2rU7vWXxv++oIceqlRVcI7R7HE?=
 =?us-ascii?Q?Mod+TkAGR2KIDu6uWn5gXLNFhuZ11D2Z6Iy2xxByTtmi/UmoeCcvWLzHyHQJ?=
 =?us-ascii?Q?ZAWiaDS00uV3+ZWQ278QflRflbA7NHjMUDjLK6OTomSTd4VXHQKS6tYeozu/?=
 =?us-ascii?Q?IpwC688vFBupfaLww3NcJ7oWvN4A768znQ78lqT29V2gvhvl9fi3KV0h9BY0?=
 =?us-ascii?Q?FfqVkTBN1IZFG3hZ8UH1OyEddFngojj1qGuDRGzQi5V/87HoLY723zwRE6y6?=
 =?us-ascii?Q?hsnzb0dqWGnG9+cvwkk9aRAwpZhd3MBAfPUt8twq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbf49ea-f964-4b32-492d-08dd4f39635f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:45.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgqESh7ny5tOmEdMN4xSYuyTEoWZWhC6GpwSK2siLtQ9P6tOWV/mVp4zIeguE4El3zW/L2XDEqti4KXWakNWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10240

Currently, the ENETC v4 driver has not added the MAC merge layer support
in the upstream, so the mm_lock is not initialized and used, so remove
the mm_lock from the driver.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48861c8b499a..73ac8c6afb3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -672,7 +672,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 err_alloc_msix:
 err_config_si:
 err_clk_get:
-	mutex_destroy(&priv->mm_lock);
 	free_netdev(ndev);
 
 	return err;
-- 
2.34.1


