Return-Path: <stable+bounces-217536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPCWE43fl2ne9gIAu9opvQ
	(envelope-from <stable+bounces-217536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:14:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF23A16498E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C069B3042B74
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8EB2F39D7;
	Fri, 20 Feb 2026 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qgYW17rO"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C82F6586;
	Fri, 20 Feb 2026 04:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560800; cv=fail; b=LpBoMW42AumAjdgWEed6JbqAFTR+8Oh8WgQd722ThXO3AY0JIdBXdd0K6b8I87RBqa8KcygSOYwurGJ6cVBCB6vajyEondhbblxvfLy9c0X7KrV0SzOY0DgwM5U8nY7dc/ITBCuec9XIHD5VTOG+3ShAbzysuN5Zf5TXoW6HztI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560800; c=relaxed/simple;
	bh=45DbB2+XcHOZRiwEnU4kPPpUoDYAY9mZT7zVAxqqamw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVzu4R0fk1Lpnt3CmW0ZGQO/Puyp+vyPFoIrhbil+AvJwQFil+8Y//BS/omqjynHnBiKp4yK4KhBQ2rg8YxXzL95Qg28DAdijazGSCYg6hL2kLY+CQ4GWxugPKafMygQsZ1pRwe2652xz++VGlwxV3BWKQjAGVnIDSrqFhhUkKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qgYW17rO; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RInp3b8Rv5+A+c3c5TVieSEVFKuU5aRZ+vm4Xtv52inqHnUt6sQ6dvge4L2Bkkj/xlzcEDi5MoS1Bd0IkRQuA3yzIWkaRlcSfhc84QDjWsQ0wL/EXrkiQ/7rBI0E88nI0kuKfxkGquc9V+FqutbvI/Nh7tEMJcphICd/rsTkrVCnAdkkvIdMRZPGfzusRVQG4pWYW02UK8xlPoRReK5cCFjURKRiJW0MbA20ZzvCK1rSMv6pkbnawe8+sTrvMWqdjRJNAHjAFizOidzM3Lvqj5VTlYUBeRoWyKHGB7rtKkFgebzRNEzWy6qMbMXBZdACXvoYrAVBJl3EkDbhZAACNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0gtT/kRNEogjqBMZHK/l5JZWAfMZCG6uWxXQNhaULQ=;
 b=RLOTrx+xGvtIhO+F8trAMGx6hW6p2hJ4D0X9SQ2oGSLQdovs158rez0ZRiKdq+RL50HAP596/DBIzLwlqVkx+PLjNwts2kS/uunBrWR9p6z0igFbIMP0NdW7OqBsnk5+dYzHDQgT+HcHkynIu4K39TOil1gUYeSf7S49h6lE3bzlxyyJBVqhzQYD/Gr5ch3iQPp7UIt1SnVIcnh/7Nvvryii/izkPU4B3kNb1yKtJ5FDatslw0LKZhJ5HuKbK+qiMGOixF6qRqHZuhK57qzBabgQVohITKcpcyYyfvqSXdMP9DtYE81B0piCLAEzk6O8h6PWtRiopEDO14nl5+lCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0gtT/kRNEogjqBMZHK/l5JZWAfMZCG6uWxXQNhaULQ=;
 b=qgYW17rO1UoqYnMBmXKbM0bo6glQcMVz79z/UF0DjYzOlKrS5rhkS8NodLAOlT/zFRHD/WtLHtrztDnqDu8sKSn1HKgORJpJlZAZkFFvXHY7mWKOEDxXlpffphV6O7nJqz9ti6dfNY0mRRDL6m22yuui8fDiK6gAbXwBQBK8pRo=
Received: from BY5PR16CA0002.namprd16.prod.outlook.com (2603:10b6:a03:1a0::15)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 04:13:16 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::bd) by BY5PR16CA0002.outlook.office365.com
 (2603:10b6:a03:1a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 04:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 04:13:14 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:14 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 22:13:13 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K4D1Sr3237911;
	Thu, 19 Feb 2026 22:13:08 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <danishanwar@ti.com>,
	<rogerq@kernel.org>, <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>,
	<v-singh1@ti.com>, <vadim.fedorenko@linux.dev>,
	<matthias.schiffer@ew.tq-group.com>, <vigneshr@ti.com>, <m-malladi@ti.com>,
	<jacob.e.keller@intel.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net 1/3] net: ethernet: ti: am65-cpsw-nuss: set irq_disabled after disabling RX IRQ
Date: Fri, 20 Feb 2026 09:41:57 +0530
Message-ID: <20260220041431.372610-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260220041431.372610-1-s-vadapalli@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: ead8d15d-ce05-4e48-6b58-08de70365e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/aqMflTFZeiHIBw3yTSB1Oeb7uJmDtooDPHMe6L9XyTlsKKlexcKGvRQLgC?=
 =?us-ascii?Q?j7VbZKv1qYcWzpxfsScO0+zz1f/coxFQMpYkvk3fI7Pg7R7Jg+tUHRR6EmvD?=
 =?us-ascii?Q?BWrhv98kMaRoIhzyU2ifcqzIGCPcbMa3YChl3PEXrF0pF1AtqltXT6hg5Xl5?=
 =?us-ascii?Q?ZXLDVhVcjeDoLJ5RrGqolmMAEn6unTU0RxdY/u6SnkGm5iu9wYtnOp0yaXVt?=
 =?us-ascii?Q?O1x6VqVxY9X70PoR8owZ4leOBn3yv+M4/DMgAnC+RYefu4qLrS8yit2sWoY6?=
 =?us-ascii?Q?h1AGFFzw9/9twMnHfA3mUJG7ebDxzPm7r0d0U1G1FJ8wzTzrX8oN4WKrbC5v?=
 =?us-ascii?Q?24aHvI4rnK/vPActq2zUrT3PPmX9PDPE6Z9tgwSNLAqfvKtc4yGToXyafW1h?=
 =?us-ascii?Q?M6WyM4RH7UAt0Yz9GqVzvHi/ppI0CB4o60oX0a+kESs6m2YtTvK9lRJfy5CT?=
 =?us-ascii?Q?FDOAPN+3VqvAanHNQfTHKqLYcp+KOZUq86Z7tTt6WFbDCXCkJGxFJUVaJY1c?=
 =?us-ascii?Q?NVFqWK2vQQISWWn9GhGpJIv33IK4TMxMJIOVOaJyq9bpWV9UQITuNO9S7tTl?=
 =?us-ascii?Q?/Y3oUyVHyXcFzyJhqBPyvXIu/xbZB9JH47dQ6sYygW4QOIPxEyOL1mpwSf72?=
 =?us-ascii?Q?+vTaTM1kf8vlzTelVETlh9wy4pzLh7QLtpZlxdN8S7fzIasDE72wBpLqpFvu?=
 =?us-ascii?Q?wVVTMqJhtCBQ91nga75UjPPFSxmTBacPAeuxs62asWKS1zUCkWPvWjtzfTEB?=
 =?us-ascii?Q?4tsZ70iZavggAtl9/A3ugPgjLqZRWfJly0DpwNJVN56RCI8LwRWirywbIzLl?=
 =?us-ascii?Q?pD5SmNYOfJ0sa2zXIsEvFG4ygFVQ/Hv92mJhGGSNcnPHGB9RE++fwyTa3RWm?=
 =?us-ascii?Q?xL3Sar8bQgiGHfPTXMQzzHAh4mRzGUcqU7q6WsudtdfKgjBdwT1YDYJeqPTs?=
 =?us-ascii?Q?UJeJonkKDXTRCpLVYprAkqDX89n3mh6Cg6AHsJEKiUF3zVOP+OhmpSSA8tkO?=
 =?us-ascii?Q?sF015OXhKcHE5P0eOrrZtWUgCwTZgw7u3im6z7bSEDan6gCiXZyEsAREBRDZ?=
 =?us-ascii?Q?bua0gjqb721/ylFSmYP4wQh96erEIuM9eXJb8DNPZiVaU7BiOztch4ZUU3WH?=
 =?us-ascii?Q?HanrZwlMvQnTxL+G1VNYsaFLvc2RyRFZyqplCJ8R/3Y7GYmijewoH33rTlSz?=
 =?us-ascii?Q?Sht94IEBpmXbo3FHbNcVzYOMEczsbLEH98ob2Z9nzRUt3laO3K3L03WH/rbw?=
 =?us-ascii?Q?3JeY32A1IPzPiC3z/A2jEY3QCwA419pYyogCd3oaaNalONJMNXipyKT5l1v0?=
 =?us-ascii?Q?8pQrJUw8ps5KSKVwqhm9IEkI/QC4O0Y+YZxdEDWWBAL086nT9m04rteT/0ib?=
 =?us-ascii?Q?2eIsl2/LnaLlJK7TY5dIr50Xm7naxEld8PSYMA+kHnqI7lhjn/1Pfvd+hpUL?=
 =?us-ascii?Q?iVZhfeAfqqtSimUtxhyE6uAaFFgxC7VfaQFwXq7cifwXVhrio1sMCe7OASig?=
 =?us-ascii?Q?BwtSywFRwpGsY+9m8Vq7RZySXe37n/6ajY6p/ZyCGooSWDvtawJVLTo7d3o9?=
 =?us-ascii?Q?xrA4JmMRl7cOU5Svh2wKbV7MO0yUSkmCx+Z5evrjzlG35ziOnR9wPmD1er2f?=
 =?us-ascii?Q?kXdSOrPMLKwcMXtUYwQ1uLpI/KmQhrsc0WnEyxrKqNxbMGVZhTa+PUdwCCF2?=
 =?us-ascii?Q?QSeUhtSokAbPKMDd4R4SYcxMa6o=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gA1x/yw6jb/xatCVMNIdiX6KJzfQjZLLh6ZjqdLtjOvYcg9vBWRXz7dW2QuaJ9uhQC7YjcXMn0+yT+1R0S8stfZgT+1hhzfrPWdUEUfK6wdq+ZPiUS6ZU1G9A8IMAgzwAwE7zOsBaff4pEckLG7MtwxnAzxFrfDyGjeY53c97D6z086R1GjWyf0ylNtNnnATXCN6Z4ZDsIBbzqciedCT3F3qQqArXt5psMz709a0+IBJc2M/xg1e6zirGN7fvx8pt4RWntj5uHY71gj5Npq4UMuV8lFUw2aGHpZ1gayPLOGehB86wlEBa5o5xc0EQKFHy2pLBLT0K3IKITNG84xPx/VhVJJDCW3wb6Bv5EOeINC3NSWfIns1nv8ewBmwG9I1x88fDRg3rCS789575Q9sQHK8RC/n8rb4+0I44JUaQE+cLud+wEL0WcBVPO4mmgh0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 04:13:14.6254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead8d15d-ce05-4e48-6b58-08de70365e67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217536-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EF23A16498E
X-Rspamd-Action: no action

The 'irq_disabled' variable indicates the current state of the RX IRQ and
is used by the RX NAPI handler to determine whether the IRQ should be
enabled.

Currently, 'irq_disabled' is set before actually disabling the IRQ by
invoking disable_irq_nosync(). In an SMP environment, this leads to a race
condition wherein the processor taking the interrupt sets 'irq_disabled'
while another processor executing a previous instance of the RX NAPI
handler sees 'irq_disabled' set and invokes enable_irq() before the RX IRQ
is actually disabled by disable_irq_nosync(). This results in the following
warning:
	Unbalanced enable for IRQ ...

Fix this by disabling the RX IRQ using disable_irq_nosync() before setting
'irq_disabled'.

Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
Fixes: 47bfc4d128de ("net: ti: am65-cpsw-nuss: fix RX IRQ state after .ndo_stop()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5924db6be3fe..8785ab40f157 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1570,8 +1570,8 @@ static irqreturn_t am65_cpsw_nuss_rx_irq(int irq, void *dev_id)
 {
 	struct am65_cpsw_rx_flow *flow = dev_id;
 
-	flow->irq_disabled = true;
 	disable_irq_nosync(irq);
+	flow->irq_disabled = true;
 	napi_schedule(&flow->napi_rx);
 
 	return IRQ_HANDLED;
-- 
2.51.1


