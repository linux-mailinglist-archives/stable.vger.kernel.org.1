Return-Path: <stable+bounces-118899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574EEA41DC2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4010D1889BF6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A105265CBD;
	Mon, 24 Feb 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BPu8HozV"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4126563C;
	Mon, 24 Feb 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396608; cv=fail; b=s+/zMeA6+iAp6ieN9fHa5JnsJhTFEwsHa2HVxMzfkf61rqnBj3W1aLXFwMGkYD8x11iS0dBYid/98Rb/Vvflf2lsthIWdzKEDLMmQNlCZfinc7bcbVjTBGwQCmrSETMVtcr4qnD1yn+IiHYjQE03Om1IKtQGSJZaDQEow/8EMRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396608; c=relaxed/simple;
	bh=KAAJDoalKTwsCpB7ZllPCcya0N68c24/H7dxq53ILQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9wLz9TygJgRWvYJeFB56ftY6DC6gpTCFikluxh2MCYpTUG3ICENw1yswT/g9qHvhJHogzTUoUFkjUoIHa8D3chSBpVlJRlWCSV3HATmCztMoO41JC/jIAKY5OTaHjckmtxYqd7m33oKQIQNQPNTKBrxnuXOQruCw1na61wCNko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BPu8HozV; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVSa8BBsgvYcycbzs9nodfTigM4G1KVPSkpDTz/VlEOPjweQpfoYS/T73EyOiNKoZbBi8niQy6d0v6F0X8vCmQ6OwFWERGHCyRwUKF5UpW+VuMqMfVO16rC2J6bnWhUFY9Y/ANNz2ENMgoQrlTiyWR4v2p0GvLRMOUdQ6rNcKksGclmTBF54YOvZKkigkjMvYw6dJyfWRrxeAKIgj+iHU3yqZlAavYfFDbo9rHAvcLEUqbaGue5eKoSoyGXXyHaUZVqTTW0fMP2Mm2j/2MXnpaj10YfGTLEO3xF4n/hkk8YCh5A1SINWUxy1wy1TGzHaNAIPG8MHXJe74f4Z2r7qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZKeshtd3yFn09Lnhe7ez6jtphUb3/BzQxKZFmJzMaE=;
 b=FZtTVJkVwK41KPhhD/tF1vUbya8Z+LfwlJDU3a6IHH3KXIwJBEHFUFCNx+9vt3AXSpRMWImT5NJW0447+e+uYTxzzWJfI1l0SIWybTJQyYR9RWvLg+SrqIkrEyHJ2a5e5pqUD14gUXbTsgy6ki9oG9BxyeMfwIytiXpTL0DzKedIR2Ae4L4IreWnZjmRDWMxiB1gLrgyeWMDqws5AKarTixfjcyRPH49joQYkXDFo/HukZup2SDOZuEaUe0TO4wCtoqxfNkKdIhuIjcQ+GshajxBcUiNYz7SZKQRnscevbcB6OEHymNmr3oVwOaqyrTPmYAflYXnUvz/3EUZ0YfwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZKeshtd3yFn09Lnhe7ez6jtphUb3/BzQxKZFmJzMaE=;
 b=BPu8HozVULE7zA9AWZfpZUUBpbZizj0vuRcbMjHl0xmkGCYQc1il3rJNp8Bz62a2vUgW5j+uExLXOH2zw1c7AKw04dNiz3w/yenGDGcyATwEQnBqbeOKDZXQJkNbKedpT0CTjr8cs4Ao9Vk+az03A5ex8dEjycyiwEmjOdWRMVkbxrLjqODciuhwH98du3PAPuDVJz8cY/g8GlzPX/jmXiKd4K4BQBdmc8KqELxwG/5lLCRzC8qJGCe4Lwm3HoPwpl0wufLiPvmzRGx0wRUViLAorplGEjF5CIXfv8kepRyFQ9hakX7JHsMK7UlGgbj5eyguqt0proNRD0exZjxhFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10979.eurprd04.prod.outlook.com (2603:10a6:800:277::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:03 +0000
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
Subject: [PATCH v3 net 2/8] net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buffs()
Date: Mon, 24 Feb 2025 19:12:45 +0800
Message-Id: <20250224111251.1061098-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7ea305a-dec0-4b45-8a36-08dd54c6941c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8ts9hON2lmqXfbome9ndJoM7kmDf0nUkgoVaAQnFe296hmeefjM7/uydosB?=
 =?us-ascii?Q?6hDYT6fs++8OcrBghTIOF9qTXvEJNn6ALxspxKWMtRTEjp4ZZGUmU77Hn3xu?=
 =?us-ascii?Q?E2g6WSQU6xDh4xq6Y5lyN6I6Qdpd9LVkGEfQOG2NnS580phpV7gtIOWUPk/+?=
 =?us-ascii?Q?lmVraIKdY9AjRjvsVArmn4eedaSjz/nxpERo4OwA0wH0Omugm7Qt6t11c/Fh?=
 =?us-ascii?Q?QSlWYfiMXtBbhMz6g9KIrO+k4gz6AJdit3fRkYoLa5bGleGQbiDlBmKcXG71?=
 =?us-ascii?Q?SMndfKiCx8wpjr2DQTPvuhUH8X8GaDcTGxaDztc2VsQHBhNClqmZ0ynG1ntO?=
 =?us-ascii?Q?7XJr6YCRfr+JhF5KH+CbbKCq4l8E0WVIabe4bPuBCvvky4mO8MDV8IQAdeZx?=
 =?us-ascii?Q?PqrOE8z+7lKSRm8A219iCldqVeLzCT+npoiaIuGtzSLjeXKgthZgIZJ58I5G?=
 =?us-ascii?Q?9tw4kTjqkkCoZL4sPvXpp82BGvXgtIlMKSe70myhlXIDpb0JgrlrNb2wii/3?=
 =?us-ascii?Q?ulSQRXVNoMz+iAf9nhDpUO5rG5Vsugj9k2pA28LemlACSOeu3fhodmFtTecY?=
 =?us-ascii?Q?F0boit59C1sjnltH7QVRDG68DpEp/hfWY6SMeapz6MbEPzxFo/dyBu/C4mqb?=
 =?us-ascii?Q?NhbxO8UxmzI0+EV+uiVm6mfUBcWCuqRjBkucNv5niKYlu1ioar/CHu+KFAE9?=
 =?us-ascii?Q?eu+zye5/Ga3qji+qDw2dSPcsqsVgWivTNfSCDlk02Oo0Etm1hWW7WbFy8vfi?=
 =?us-ascii?Q?gQOTRaZFoaoyGOS2wg2llShbJibvg5K09QjolXtP/IeMPnPkRV+w+khMnZ5F?=
 =?us-ascii?Q?UdnvHLgmPVWtonj3FLJLK/V+Dw5YfdWLXTY0a8AGuB9ZiqYWTqnSoqCG3GYX?=
 =?us-ascii?Q?Gp7OFSvTO9pef41n7ahmhyVW6d/wr2N3sJJCOsdkzI8gMc5hlDU/M+iXPTWf?=
 =?us-ascii?Q?gyQC4VG1jyAia/MIxPV/cz366tBwVDzczklbsSfRNtkU4bFvjlnIdar9U69K?=
 =?us-ascii?Q?aeqbieYu5eJRsQm+3j9PIz0WPoowDFP2zKCF9artsmh9iLceousnsjsgv4+j?=
 =?us-ascii?Q?KJYSoV5rpbbjvx+4fPgx9p1zjj6N53kfRQPGy3EnPubiJvNrZG1ogOVuZjBb?=
 =?us-ascii?Q?smeiHnYJn5QkUxYpxZrcZZ4NtwID/VH9H2B14SwzoIensOk1f9NCPMOeD0LG?=
 =?us-ascii?Q?TKSobmEzJaWVmoTrswLdmFHypCs6OVhTeXM/2qsGKZA0/IsknZhtL1QV+JWW?=
 =?us-ascii?Q?3EtEf77meAWVVk5B68/pN7gwtkvDatD4c7o4oWr8Sgd3vpyn3aq1evtlW/vc?=
 =?us-ascii?Q?ToOESl3AskGg48b1dT+tLaEEDeo3jIFe5ccNN/EEIHyGt9sbrpTYisfJjxxC?=
 =?us-ascii?Q?RXkOB0IHYGATgaM4+uVixeaRvlm6OmLCEMAbWWLZ7fn/ebvtDULY6pnXwX97?=
 =?us-ascii?Q?xIY44Dzo2PCUTGEVegaCw3JO8ZE/Y1xF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n3KeTlLUp/YFc2LHsE5aZyvcpfJSBOvyVAa78O4jCL4xRlzqNt+/nIF5I/Iw?=
 =?us-ascii?Q?5pQE8y6wltwd1YDdRQvqQp0tsOl22//RD05B6vKDjyInPaRyLrL2az6D6wQx?=
 =?us-ascii?Q?2Sb7fnh5m6qElP6yJmcQtqZf7DGafbApGw+Jtpg1JtVBz85W5vcCWa/BL2d0?=
 =?us-ascii?Q?Zt23Zoy2Z9c/973rotz2fhnBqkZYn2Hw9dABxr54V8ZPmDg9r9rYgMjrojfj?=
 =?us-ascii?Q?c66iFgFFXy/2solcTP0bOyQ4Eh+9GyVTt/jXyDzOTnVkQHGrkPAEgBeR/NXU?=
 =?us-ascii?Q?DsOFtjHZNdi14l+fgF7xTqFBiG8qBhJNmz6fJ25ogWHxaRONEp71YEKF5h8y?=
 =?us-ascii?Q?ys/64V1cHcI4jep4IPViZIPRb6wH6mNYWCJVn3yU6sWwaBE6NOWVdg8NTfqb?=
 =?us-ascii?Q?cwpGgIJd3nDLWpsc1SVFt3S2YJDsrXU9LuTrbdlgIfILWPTyj9K9ouCDpl8Z?=
 =?us-ascii?Q?VnSAtQsjVvCDBqfrVeSq/RSZakXytjhn09A6G6ErbsiWVugZTkiE3JuuQ40m?=
 =?us-ascii?Q?MeaH0AqAAG2PcOJGzLwkTTShor8quoscWJg3IDASeWtqvbvL+uuY0kSarorL?=
 =?us-ascii?Q?Eyjlr2gJqyqOCPo4IwXgXEiUT4okvS9GwipxcP4MCxJ/eQ4sLHfvwOo1+Q+f?=
 =?us-ascii?Q?YQr7VICIsPeMPrrca9Fnt4qZrh/oDtqTloB07SwGhqy6Wlzofp82GQkNQW39?=
 =?us-ascii?Q?QhzuFWyeInjdCwFecFIP6Cg02IohJfUCdZldNzjDW0/sdUCi1hiNODKokGSa?=
 =?us-ascii?Q?pZta/K08rg+IKtfsUpiNbpY0RLy5gLPgB25u7wanFbLfBfQtTVyLSuTO9vKH?=
 =?us-ascii?Q?r5hU8fkpYE2p2XbWU3Ik4ILOONje0WGTO9FDvnW+eCF5+wn6ztwYEcXmwm32?=
 =?us-ascii?Q?yrKIqOHEHd6O71IcD5l0N3XAnYnGGlUJP1R+HnrAlV+OZvl8npyk2LMjoj1c?=
 =?us-ascii?Q?c52Hu2xLG3BEfdiAomcQgsy4hSB5DkVJlKbIAnKNI/+TNAYa8btS3NU7XfsF?=
 =?us-ascii?Q?KWhhDHRwTRi1axzA08fzo8v4AewVWhynPPySKwRtWlMBDEFCJv7FVvPM4pzI?=
 =?us-ascii?Q?B+ptH4oqJa46JaPOmiZhHa3OS7y7q6kVqZbOzlorQ6LiBMnv2QpzMMUSQGDk?=
 =?us-ascii?Q?wyrBDlsdhy0A/jLS/x+J7qVVraaXL8XZAtIhPXll6bgyriGXs+jCa1V3oxS+?=
 =?us-ascii?Q?OjWVNXEMflBrKcOrOcN8fVOtun32NIIb4qKVORjPAmZg/hysH6x8AhKJdyUI?=
 =?us-ascii?Q?seoK7E0/5HszW7zP0RIDOB8GLK0s/34RyzTpLZhPmStjc0YQgrzY0DuTilvZ?=
 =?us-ascii?Q?YL/aQfMuM87kNMOHO8hWIG934efOQuco2kgy0E63nfdC7CuWaz3d25YfgIn1?=
 =?us-ascii?Q?FtPeEh3SAJv8sBc4uaKzORfsAgLhEuoKxKfMUmz5RQkdxRaFo87o+jyqu+q5?=
 =?us-ascii?Q?RVj2HUmGO5rlvt9mtc5zom0ZAtTHgjuO1BUlZFIYxg2ve7mAd2N+qDqTFpzS?=
 =?us-ascii?Q?wOsi+PE2w+ATXtN4fBJc5EeOxxlFhX8JAQ924EoVx+onT8g8c91Th7wROJeF?=
 =?us-ascii?Q?mDBMJsH0NVMA7VDXZyCDGiI/wyvBoGo0rXiddeh5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ea305a-dec0-4b45-8a36-08dd54c6941c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:03.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji+xDBtgiFOKY5Kxq+8acIm83NCdwSSpXNnfS3IBceno8IcbfdbAxQ+IAuvf9gOsRj3oIpKZ19mWXQswWFa+Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10979

When creating a TSO header, if the skb is VLAN tagged, the extended BD
will be used and the 'count' should be increased by 2 instead of 1.
Otherwise, when an error occurs, less tx_swbd will be freed than the
actual number.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Cc: stable@vger.kernel.org
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 55ad31a5073e..174db9e2ce81 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -395,14 +395,15 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	return 0;
 }
 
-static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
-				 struct enetc_tx_swbd *tx_swbd,
-				 union enetc_tx_bd *txbd, int *i, int hdr_len,
-				 int data_len)
+static int enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+				struct enetc_tx_swbd *tx_swbd,
+				union enetc_tx_bd *txbd, int *i, int hdr_len,
+				int data_len)
 {
 	union enetc_tx_bd txbd_tmp;
 	u8 flags = 0, e_flags = 0;
 	dma_addr_t addr;
+	int count = 1;
 
 	enetc_clear_tx_bd(&txbd_tmp);
 	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
@@ -445,7 +446,10 @@ static void enetc_map_tx_tso_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
 		/* Write the BD */
 		txbd_tmp.ext.e_flags = e_flags;
 		*txbd = txbd_tmp;
+		count++;
 	}
+
+	return count;
 }
 
 static int enetc_map_tx_tso_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
@@ -802,9 +806,9 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 
 		/* compute the csum over the L4 header */
 		csum = enetc_tso_hdr_csum(&tso, skb, hdr, hdr_len, &pos);
-		enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd, &i, hdr_len, data_len);
+		count += enetc_map_tx_tso_hdr(tx_ring, skb, tx_swbd, txbd,
+					      &i, hdr_len, data_len);
 		bd_data_num = 0;
-		count++;
 
 		while (data_len > 0) {
 			int size;
-- 
2.34.1


