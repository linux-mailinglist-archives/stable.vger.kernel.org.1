Return-Path: <stable+bounces-217537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNhnOb/fl2n99gIAu9opvQ
	(envelope-from <stable+bounces-217537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:14:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85D1649CB
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96B7D305B0B6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2EB2F2910;
	Fri, 20 Feb 2026 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S7sMv+jo"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F5B2F60B2;
	Fri, 20 Feb 2026 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560805; cv=fail; b=Lx6WU8sBK7xVTQ3N4FB1prWc9TRw2I66SKt0Y1G5pvFp7G2pXJ4DvTV6t8ar84HpqjquHCZ7Tw1JezVdP+WVWwyetc2QtFrPxBeRvq18JSR37vGqYpa/T29cRck1K0UN902p451PyOPqUcUo1SEnYBvEPN6kmHg9GGs03LCZjRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560805; c=relaxed/simple;
	bh=/cnjBIuw+5O8W1NUrgbT9EGeVL0Qma01mG0pk3qTtGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3UGG+JgCUGhGeb7oVJ7c+kYL6639RzJFKZJK/pO19k/nrx/OlGqXrcnOKG1Tuc7bkY9UowGzhnDsaLj+OZVivVjL2Ny2wUdbBM+x10hMET68sDbSAPK6heb8Luasrc22hrZXrQt9KXbCz71acOpjLOwztg+c25r2KAMsNpUZRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S7sMv+jo; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDJ55o8fqTVFU2eLCR1eDL8jh1nWwkWVezztco2s4iifN185nm+igFl4UpuXdGqRhi5wkSIpjlH+AlWZmgiFSPbQMFabNnHg/JUV9PFJpohZIQCnU4vH4OYad0/XxbWXwxJwvdnh3g2oXTqoTFcj+l5+OW9qz0HKu4t+W2DLBYvda2EDZ19p0gkUFdpA3UgMWpQppsPTSGQRsR5Qeq/NohL5DAqR2ofC6F/1IqOO6s2YXuPRFAS9Ngz0ci+MS2miWgH3zUDFZczS8QduQMGzVTrA/d8TLe8d8/ODY2w46MgFeBBQ9fHbBMcq6i3fCRUuqB+9iLgFMrgbciTo8KeRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwqR6U0uAUA9etkv8NC5jxrL3tFPKlYVhlQDylF3Q1I=;
 b=PHYOJLAay/tJ3KzDVN5w7rbDhgsm+UyR3gGb0yGuCE37QPpdmp8q5BwA+8Po9H8sHgf9Q+ouvIMSWiQM+mf22nxzPzY/vRScn97l/yNyTzxZTSaOteEzti75s/0tk5syFHAUCQqFyMgm/Y0oM0WEwmzy28fmseW4c6u9hqDwRsups98I0SpTJZ7pBIq4pvDykT+w/ZF6LsBUlWRp5IZjwsoIu5/ie2jOU4qwJQ0DX/jO7J2P5VE4fg/9x+d5NPNarvclk3KnP+mEFNyVzhh7Xphk2kXM6p7Gc9luPwPvjhb3o7dufDSKYvVUK+j+WrZBnUFxUHMCymTss9Bkijjm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwqR6U0uAUA9etkv8NC5jxrL3tFPKlYVhlQDylF3Q1I=;
 b=S7sMv+joqpZ1tiuNn3XXt6H2AhCnLWQnLOZzlEzk/wpGF3qrHYdZgFwK8GzmgNuK89+q+8JIsd9/yV+3LMvDvGzGeXyP7/NpoEgVuB65cVojXezAlejfLA92cpFTuOwx0itbqSkxu/diyePnfFrLHj0Hls6iGpuWRb9YGln+LW4=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 20 Feb
 2026 04:13:21 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::dd) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 04:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 04:13:20 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:19 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 22:13:19 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K4D1Ss3237911;
	Thu, 19 Feb 2026 22:13:14 -0600
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
Subject: [PATCH net 2/3] net: ethernet: ti: icssg_common: set irq_disabled after disabling TX IRQ
Date: Fri, 20 Feb 2026 09:41:58 +0530
Message-ID: <20260220041431.372610-3-s-vadapalli@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a0cfff-0d34-49b3-4249-08de703661f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Sd6HMvgSziq48RqdIcwhbFxIrIKiFgSySbIvmbwWV7ykb4iNujz+NSlLekf?=
 =?us-ascii?Q?O92untfhOQdzqnkpAoc7/LpdIsvYaPRrP6+xdDw37bZlQoxaccMQQxfpYWCf?=
 =?us-ascii?Q?o2qpbyZUnOvO3WLSiw4VWJ9HStjc9QFUDTAN0BxQ3MAaqYJs51R5Et6LZXKf?=
 =?us-ascii?Q?kvn+eGEZTmSemkL+r8Myho0Nuv/OKq7NMMSvRwinAUb5g7t4djjZbeRWBxNB?=
 =?us-ascii?Q?1Gf0p3k/IEUErE18LORu6zQ0GZX9uhFW9xLOdcKfvLzursQNZmeSeL6RotPE?=
 =?us-ascii?Q?lkzKwh8QNSuK2VumMPz5pMxmlm6Aq+0556nFfblqBTw/VpkO83RDK0DCFDcI?=
 =?us-ascii?Q?2XqC9Q8EXile92iO4RtZ9ZdGBLfSBixUvSpqMMBf+TLBc/LQ9/Jt1T3VIP+/?=
 =?us-ascii?Q?njY9LhJEvGHQpEzM5gJlF5xsGfSSvY5VGow9v9Uw0EQLFDqUtdrfEw3itI35?=
 =?us-ascii?Q?PEqa+XVK2brgXb8q/pDd4ReVqvZl2S3nA/L9XYh7cUNH1H9L5s/x4yQWqUGj?=
 =?us-ascii?Q?l9s1r8If/NsyI5e6iD3vGj2dgLmBXYiOSGPn7UggblcadX03oFgMPGb/+nwu?=
 =?us-ascii?Q?2bmHL4Y6sS5SvywHHlw+fCrNhUQl79Kdam/1WNv/7XePdXlq9mKEQqZQIePb?=
 =?us-ascii?Q?1XYSjV+JsuREL1v8VL/mcwZ1yDp6rwk9xE+MygxJF1LVHdqlab643c+JFdEi?=
 =?us-ascii?Q?I4a8U6FAyrFUHZbZNz/3ehmV2CdzAmItZRGo4quKjvsUyCL4qtJwfXbsSBxD?=
 =?us-ascii?Q?+5zs2iqI3GDRT8haz99EHxL9ulNWSX7aanD51n0RlzCndjeApuxCXV11S32q?=
 =?us-ascii?Q?kSbSkEPcJzQzScOay0mQfkPQ3OW6EG5V8o5wtIDTRDYW3gvlnf72nLuP164c?=
 =?us-ascii?Q?hVHbdIyAf17iJjI+6P3MtejkeAGVQeOHA/W8u+2R2vk8gjZsUqjYliGZ4n7I?=
 =?us-ascii?Q?3/Or85Kzv3d3xp/qwZ3Y/jKv1l8XfmH5Xa+5ko4RHFyCEdEQGHWOZPHA10/O?=
 =?us-ascii?Q?6hIRVOcemH9ee3RRDJX33ToMjg3BA39dT+KujZRdl0Kao6sPUd5hfBEAkbgC?=
 =?us-ascii?Q?oW57Zj1NBJKKhiADU6sUb7auqeAC+6kzUbUjbtrdzAPEc4XBHFtKmewXIKAM?=
 =?us-ascii?Q?y0ULW9e+gHJNPjYJ9h0H0JL8lgYp/UW0hrh54exb6Rz+HVTWyxdwvV+h1pae?=
 =?us-ascii?Q?8eOynoKYwwq0zMovEJLWYfBZkcG+KZrCfKEkjfRL/v8RD9MQD92UOxcTCQ+C?=
 =?us-ascii?Q?5SwFdXZo0ai1jf+/CThttTBoxvG/hAEUu1Z5Q6CCrn2Kedsfx+kkE3lZeDzD?=
 =?us-ascii?Q?SLajtrb4As2Lplth1H72/jL3yvau4jehCzQlxtfvGZ9JI2jrmmkL3EF+0AUG?=
 =?us-ascii?Q?kchV5x+sUklauU0WKwX914tjIHr6VbLEHKKN/bZ/MZRBK5ykRzx7o+EVU+QI?=
 =?us-ascii?Q?LZ/XtSXbQpHppUzBk1wF45YIULxafh8c2a1YhjLX1lOTdozyAFcpeFkHPwQU?=
 =?us-ascii?Q?QpydryCbK71uNIq+YKYsonTpduHNqxxF1qFjxwk/BGzNJNoO35T//0YuWqvn?=
 =?us-ascii?Q?sU1mwRM+6rex7ITwpSrCwetWkL6m8z2L/1M844KVwb7yFsSi8O1E1cbrZJj+?=
 =?us-ascii?Q?Yw12v697GN5jLGJVofDn3AHR8dzVKL2+u8K1O9fZVaPMNged9Ys5FlNWnXty?=
 =?us-ascii?Q?nAtv0p1BmXuO+6eOpr8gP2u6mh4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QNixST9RM0BOKgo/F81o1+/ycec7fcVy0d/9eBzSucpgxu7dhrCYAslg65vJS0REBGUqUdKIlkhlF0gUfxoj1YLDx+r8yiqbcHqiTrTLX03uaOvtINljTI9vq+08O4D+r3t+GnDZpkroLbbMQG66iJZHMqs0m3lvsyYocCLgO2dlAn1fJQfVQAU5g22r7VcYDhzgaS3eTOj9C6hYVh3Pr3z4eq8+Ek9vTRp1eAI6zg7WWpcfqBkdSAs6gx+z4tvByF+tuLeKrvE2E8lwXzr9hk5HmjAMFzbTM5kVDtGkIumZ6HiJpE/QQQyet7m3zELaKVpJjYDBezMzbcKSM/7CvZQ5Aoe8uqaUZrfrY2+/c4KE8tjqNNNRQ5ZaIePCnTEI60paHgtfBVijuazQf/kkQTxTTxXBgNEIJNjN9Boxov2Urdl4hwBbN87wmMTuwvoV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 04:13:20.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a0cfff-0d34-49b3-4249-08de703661f8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544
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
	TAGGED_FROM(0.00)[bounces-217537-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8A85D1649CB
X-Rspamd-Action: no action

The 'irq_disabled' variable indicates the current state of the TX IRQ and
is used by the TX NAPI handler to determine whether the IRQ should be
enabled.

Currently, 'irq_disabled' is set before actually disabling the IRQ by
invoking disable_irq_nosync(). In an SMP environment, this leads to a race
condition wherein the processor taking the interrupt sets 'irq_disabled'
while another processor executing a previous instance of the TX NAPI
handler sees 'irq_disabled' set and invokes enable_irq() before the TX IRQ
is actually disabled by disable_irq_nosync(). This results in the following
warning:
	Unbalanced enable for IRQ ...

Fix this by disabling the TX IRQ using disable_irq_nosync() before setting
'irq_disabled'.

Fixes: 8756ef2eb078 ("net: ti: icssg-prueth: Add AF_XDP zero copy for TX")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 0cf9dfe0fa36..24716c8d7f75 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -348,8 +348,8 @@ static irqreturn_t prueth_tx_irq(int irq, void *dev_id)
 {
 	struct prueth_tx_chn *tx_chn = dev_id;
 
-	tx_chn->irq_disabled = true;
 	disable_irq_nosync(irq);
+	tx_chn->irq_disabled = true;
 	napi_schedule(&tx_chn->napi_tx);
 
 	return IRQ_HANDLED;
-- 
2.51.1


