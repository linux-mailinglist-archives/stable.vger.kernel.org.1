Return-Path: <stable+bounces-118898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D53A41DCF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162FC7AB985
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46439265CA5;
	Mon, 24 Feb 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UuHfgihc"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE66265634;
	Mon, 24 Feb 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396605; cv=fail; b=f8+eQFXVD9LaAEVEaNbury+r20kF7gJc2+LhyyhlxhXMuqsf8WWff4BciXnRLxvdxLF7ogqz3Frmm9mny6AO2VXfmFvyNWfjvzlnVL50tQpQIjjyiFOYnbn+8hfgBeiFCUJ3NcFTcT4+WXye5X8OVcqlie4KAMrGVvX2U0JzU1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396605; c=relaxed/simple;
	bh=NUy+ZJm8Ui6giZ+exkhf4/n7Qk2OmUqy+MM2O6DhyGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RSGvTfeJKh8b+dDFhSZd5LaB8owLyCcuoVCgROmTj6qGeRuUJaHZNfevdyUsDeQ/pVLNsZdJ0zmb8Ec+WSLToqBro7T6W2a7QvdIyvexnwBqCgeXt58opoyzeZPIGkwm5xAp31cztIR7C5nmM0jgJrbwlCIoi7jD+cKWPPXEbCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UuHfgihc; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZprzPD5ZMxCF+7DeGwUc/C8692owjwgPhl5NkBMe0RwShnq0SzT7CJmtS4R4akRadurgSSx0gXcyK0STta8ENz6jqIuM4bqbS+qmDidGNibHT1SYC/gH9nNqj3amplKBymqcxoyYyoSPURS1CZK5AnnPY+Zy+Bj2pTia/kk8tZNaUIhRQgVwVRvkN/m9p7HG6wuTqlXBi4HYD0y+H56/8RjmsdaGWSgPfXZC02Ya+Ww6nkgF+ZLfbFggJEhRiKSp0Gw6XQE97a1kIsvSb0g7WEbrWrvXtIsm17JfQAL8WJ/KeltZKoy2N39R4gehumxrlB/DLk+z3IFQe8XiGVK65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQpt6bOxgYoaIPTdlOEuQ3MWYTCAdZjfzIU6wchEEIk=;
 b=kMRVMlDPPUcdejLqyW6etMFJrBuatc/90sNsKfRmIfMdUlst/Sezi9/Spo4xzopEgiE2WeuFvPT8if4m5ih1vfxlfRovVtFvpQqqNxQINYLCIzWP3ODjYZJiahf3Tb0aGXgAOPi41UxIRtScEbb2cLp389A3712Q+A0hOmNW4EZ5tEget/nfUFOs+epLjaEEfE/+Fy0SAzFYzRwhzn5wxiIfcDR5ZdDLdvuvU4xIA4J6tnlMr6bPRbKRQVtZf4sGKh3sJnx3Pc7NwaDx1JHROoVcQhsepwRbjs7/vJCrLiWcvzMJnntcv97WD1veVU74669CjQMgRs+kyPT5zKQSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQpt6bOxgYoaIPTdlOEuQ3MWYTCAdZjfzIU6wchEEIk=;
 b=UuHfgihcnLGrmTZF/Q2fiwXBCZj5VwJ/2dibc3DBFn6kxmrMMq2ZaZJxTFuJPglX+B0jIVHTYjbSd/eNK86wG/SUXz1Z0vHKK6lQFphPTR2kyKadDQKgNXh1sfiLuWe/dBZjnJT3WXscFXJi25kpq3pxq6gf1K8DJg/AZRWyMuBbUkPrhKZkdtF6lWZWEnL1A4Jw5B/rH2481x1VcB3Y5sp2UDz+fYlD0mgsFchOfIc2gj/ZhoDh/rkY4O6CapjKguWNNBZvO9OWHRUclRW4LeLFsPgQ779TXDZVmi4rzOtKhIG+6zbj1YhF9y9vD5km5GSi53LpCf17isu75ED5ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:29:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:29:57 +0000
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
Subject: [PATCH v3 net 1/8] net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
Date: Mon, 24 Feb 2025 19:12:44 +0800
Message-Id: <20250224111251.1061098-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 306fd9ec-948c-4406-aa1b-08dd54c69152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IefXTgseQHGQT8oU0b1TlLHOTPuHS7q6kkdU0Rs/OFzkBAyvCs0udykmunY?=
 =?us-ascii?Q?kFyaHQGYm3ve0G0eumG/fu+WVgqfaxnZvJhitgWlaGPHNYY3HmwDgoQGhKDz?=
 =?us-ascii?Q?gvD77xgvLxJd3R7qgqGJaaEjaRVAgZgr3IbG3rWYDGh03x0WkRHYqT5W703u?=
 =?us-ascii?Q?ZMPu7NfebUE4UgnLMlv7Djc1zwJPVr+lUAS80kS5ee13S897l07T4ld0cHGM?=
 =?us-ascii?Q?Sx0F+dtnsus2YsBlGmt+jprAWj7bD2zCWHfpLCL2Cp6HzFPERVRYFZeUOgkV?=
 =?us-ascii?Q?uLZ6FM1NTlg77gSxQseyV9RV7Zm3R7Sm02SEeC7KjQSDJ/bKQLVT1+htj5iE?=
 =?us-ascii?Q?OjcQVGGpnui+uFtLcpCOwNIonKB0nzYkwDJ0GYwSHP7u0k9nk/2RTBbjBUWx?=
 =?us-ascii?Q?H0Mi39iLT16JEyQAn9vGmvXEbitfaJWtoFB0z8SD/8gzIaM+VfYgyZ5FeMht?=
 =?us-ascii?Q?jLeoIFlVjGRGtM6CFKGty/BRWiw6UEKJsge95Is74HhFHz5UTNP+6xMlB17y?=
 =?us-ascii?Q?DOsanNaELXUtTprsRrDIDMcHvIyQHzGIXy98r3Rj62Bf1UH3PIj54UKy+kXm?=
 =?us-ascii?Q?ypmWl7xOdsIDYtE/l7Ov/D6MiMYc+vYl+s5vlEl9auEk6yagK77poTlBtDn4?=
 =?us-ascii?Q?7Yd+vyGz7mW06yNveraBl1J2PSGRtioMxZJTwRGUCtG0Su9FqLb4fLCoEYWu?=
 =?us-ascii?Q?g7uxs9+xn9n0OGIgJNANUsnvoTY7G54v2XJdOWzYaXjlXRvzeIFgvg8SyYjK?=
 =?us-ascii?Q?r/fiPTt9wv13Z8pUzUqvvYo9Ao5R5AMQ3l9c9q3s1ugGAzWqeiKFquuUryLe?=
 =?us-ascii?Q?tLmJ1VeWjq5AzUMKT4k2U0bvFMP8ab2hCH8hZQPCZZx4irELgxYy3v0S23Yq?=
 =?us-ascii?Q?d5hUPg6+grV97pyWT3+bU3E2TEJICCfdpxby01Dq1xo4uubyYXf8vTLbjWoq?=
 =?us-ascii?Q?vG8O/XEMYBdxHJM1KZzJHkgGQgVFnjDEE+c+prvwoNlZ+Rr38pzTzzyju04P?=
 =?us-ascii?Q?2K0YD+IfBAqMTEBx71KmYysWS2Uwdt1LainUnlCV00bixqVFDdDXRoKa3fRO?=
 =?us-ascii?Q?8fIMiZuTwo/1DHjWl1ZeAi70mJLz+H8gfwlQeMTvS7Nu022ATgVHnBmj0u3O?=
 =?us-ascii?Q?RjDbMlG3BglapLE7T6F6iwOU3LP+CA/8L3dsJvpvu0tlTEtLc/nCMPT2r5q4?=
 =?us-ascii?Q?EjQB7yHFyaxVHPzTJxoPjMWLvtOK4RqBo8iYx9l3KEAa7TsCHsO5iV2MBHjt?=
 =?us-ascii?Q?YMLe43CJ9YfiqjM1PDbuivp8DoJN3G4pa+L3RC4DNvNR+yuKmRk4Zoinww3V?=
 =?us-ascii?Q?UM0h9YhtgRmN/CAAx01JV65K9Qp8pfrezX4xHct5ea7D5oC7XVsAjzvhJJDK?=
 =?us-ascii?Q?4+EiSZMXh6t+nqjnZyU0jcauJiBZvTHZdhAqne3BkI690Qtts8EwAS+85aFv?=
 =?us-ascii?Q?gsLwEHx2lo9mg/WIpZAU/H80TCnIJBhH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbBL1WeqE8HeEYVdNrMag2HIBmSedu47VLtsdrxgnhyMUGNtWuNGDx/r7m7y?=
 =?us-ascii?Q?xvZBn1tnmMPbsmwjFlcKrjikZaIFxKO8OUMN35fc24gs/MI5SWm3o/55XpLA?=
 =?us-ascii?Q?0F7IhWVom99gRjH7ejLTlziEzK/9TfGCXOiN4jD/1idCqTeLSCXopW0Xpdd4?=
 =?us-ascii?Q?WVdJBGCLJIBMfEak4yrLFYxXTd2Dq5eKL3UB+cxBk4JuaR00uT5KEBXxoNu/?=
 =?us-ascii?Q?rI48DUXWV+lxBf4vLjFU8KkHewobQ663BePcnZ/Db8sik0otY3NMQfA/NCZ0?=
 =?us-ascii?Q?iLCMsnsXvHCoX0ks9gITHJeeMW0hRCxAiuUMlqNG1IUcER6bga8Y6PdNQGJS?=
 =?us-ascii?Q?c9GaChsLYPvwsEeEy1s/67/6jOQUqqn897S+DueapT6zop83KPtPETpnhnQr?=
 =?us-ascii?Q?UT7iZWYeYtYPqpKHCCmgnsHFvIQxpMjWQkb4rwFWrBAGhXYzeyNYrMBPeYV+?=
 =?us-ascii?Q?z0fks5ixCcuOBzdwuXd/tQYczxbu1ePKvjRQ4iiruH9Db10I9CQ3Nz+v9F6n?=
 =?us-ascii?Q?nNnYxOIHgQGPARa1le3m9RqY4/aXkkrin0nXOrTaHBYx84SN+4ScQeITe7QS?=
 =?us-ascii?Q?jzNprUD29DT1aGKJmme7YZzRI1yvl6GDvoXgsRTclmuUVaRBBUdrjQjhEV3Z?=
 =?us-ascii?Q?+L9iJOHFOyrenwyUt+7SkQlRgbLmP1s58zXRxEm3rs8dhsocMJJVNrpUxdZD?=
 =?us-ascii?Q?NKkyrjv5M9/pEQA4h9PMvmhoTFCE507e0JpXnpBJWdUNfjGoq4sNJqRKoV+m?=
 =?us-ascii?Q?FmFzzbgTddYHOsaMMMnLTXCPIMtTBic7aAPI9bHgPC82cHEHJHC7YMCvL5T3?=
 =?us-ascii?Q?BxF+14EcrOIYbE3ddlWajdCYQYcircBdIiN1pk8IQ7MepdfpnO/tWRFC7TXF?=
 =?us-ascii?Q?EQv6Uc8ji+wAEe1LzFSLuCakEtpujqSX1pk5uNcOe5UXXkdoSRa4iBF6COpW?=
 =?us-ascii?Q?zW51SvZLfsnxz3pFUatKTuEtvGJ+Sksc1uduxf4CdvuZ+hszHRtMAKj44oTm?=
 =?us-ascii?Q?fdDEbdILkNKtGV8KP7O/UP3GpzpQW+PA10CQZOUhXp/NaBj8ct5GzlogCkqL?=
 =?us-ascii?Q?qROsEUtzswLnXfva543HDcxNgVTM+ciOgf2r3RsERFsloTG68a0cS4uCC5jL?=
 =?us-ascii?Q?pNfXGR8zuwLZ7oRWmcTZJd2NEQ/tunLmcTTTqIbc0m/+6+Lm3M79TshMQjG/?=
 =?us-ascii?Q?qlKxNWndztWkrcbqNfCw3nwgE2NJkZ433/VaSlTjaJBC+VnqTAr/ahKjT1wm?=
 =?us-ascii?Q?FKw+cPFRvnVBMJ275+TO6E7GsXP0cDdN3gls8B/lo/j1pzuYADjfxBz9ChZR?=
 =?us-ascii?Q?DMzmL4gY6P7ZCR7pTndmiZhj1czGGiQ3FZcZKX0XsrjP3RX5rH8fv3auY6GD?=
 =?us-ascii?Q?eynPDnH3AX+OeVb7CbI3khRZ1eIFqB1lQ/Vxx8X9ap15nNSCyLSnFJ/qf/qC?=
 =?us-ascii?Q?c/ilFkLBILtMziuDdFgyKH+YsdYsD2JhHVdYh8r/d7O4y/3v/870mmbQr53i?=
 =?us-ascii?Q?IqQG74UHP/rvv6fcXWVMJIwZMmpsc3FO9DCn12G83n85HvjohRuAtJY8SNOO?=
 =?us-ascii?Q?FT/kaknuVI8cZ++aNHmVf2jX7PZK7Fi6QgSwFJMG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306fd9ec-948c-4406-aa1b-08dd54c69152
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:29:57.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+mzlKkdOf3FCrw8JzU85lf4rXRMJA/wqfXLRsn7f3RSH3F1mF6mehq1gYLCDrCtS9BKFTZnezE0ge/AdEgGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979

When a DMA mapping error occurs while processing skb frags, it will free
one more tx_swbd than expected, so fix this off-by-one issue.

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Cc: stable@vger.kernel.org
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 26 ++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6a6fc819dfde..55ad31a5073e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -167,6 +167,24 @@ static bool enetc_skb_is_tcp(struct sk_buff *skb)
 	return skb->csum_offset == offsetof(struct tcphdr, check);
 }
 
+/**
+ * enetc_unwind_tx_frame() - Unwind the DMA mappings of a multi-buffer Tx frame
+ * @tx_ring: Pointer to the Tx ring on which the buffer descriptors are located
+ * @count: Number of Tx buffer descriptors which need to be unmapped
+ * @i: Index of the last successfully mapped Tx buffer descriptor
+ */
+static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
+{
+	while (count--) {
+		struct enetc_tx_swbd *tx_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	}
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -372,13 +390,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 dma_err:
 	dev_err(tx_ring->dev, "DMA map error");
 
-	do {
-		tx_swbd = &tx_ring->tx_swbd[i];
-		enetc_free_tx_frame(tx_ring, tx_swbd);
-		if (i == 0)
-			i = tx_ring->bd_count;
-		i--;
-	} while (count--);
+	enetc_unwind_tx_frame(tx_ring, count, i);
 
 	return 0;
 }
-- 
2.34.1


