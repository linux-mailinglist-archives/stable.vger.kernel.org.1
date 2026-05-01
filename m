Return-Path: <stable+bounces-242421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDqfFfue9Gm9CwIAu9opvQ
	(envelope-from <stable+bounces-242421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 371624AC728
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC1C3016518
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656A83A5421;
	Fri,  1 May 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q7ogW+Lw"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF33A4F26;
	Fri,  1 May 2026 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777639158; cv=fail; b=BqH58Blxrl4j4/XNGKOaRR6azCgb5fiETVJ2zkL1peAIwSxbZ2x7v5e1TyEs/b8YmUBJxsssKY7fVTMGRZOZ9jGEkUjsRJN6/AZyw0MGvNhTttACYgTYSkR2EROsFc8W567AgEvW+L4RVZ8rHZTcW2d/dFk1K8qGvPnpDbPShcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777639158; c=relaxed/simple;
	bh=G6TfgBDF7SfiuXIHRD1PhHBE31pgjilmdW0JQCQSsxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sr5v848F81GZIoK85ND2qZoctnI0syYixoFjc00RAnhSlyYCGU6Ku2aTt3+jvRLV+c7jLhaOuBPx3SgmdQ5qytaAaEQo0AsyomURp5F1+07CyLOCoXxLT0iZCPV7qlDO6laLhdfSfSGaB5HHxxCSA/baSpQ4e7AV+RLIAS9lYmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q7ogW+Lw; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOzCOhyntYdEt+3ZoqxVoCwen0Vq2QiDB8aKZVXE680XUh3ZK/Qpshc+OzO474qgvXW0E4SuEKQyYCToxzl8yAOQdVdsPRHgxOTk2oRrzEI6u6ylfMxX/0C16Qtl0WlZcodFqC6keI3a3NPd4K6p1SLWT0KSXCmN0MkkftXcPNbyrBYzikq+V7MldcDQORkmdZl4ZgJ4qS0gX6OopA9DwOhsitogbUgBeIAmcd3XX6GMIAbbr+lY9hPE9FgHETZhUc1q/YAhjMNBzFOxBCQmnes6LIHiP86NQILF0rDBCcErXMZ+XQdsEkvUvlgdKwCeZeg/F4dMSISPIlVJR/J8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aACyaqmLbG6zMaBNREfGn51LLQNDX4hs8m4Jzx94gAE=;
 b=v0ezhLUSJyEQpqHO4ZvQ4YdL/yepxd4G0nsk+RJtHn2QqWvMrfnJzKu2ECL+dh6582Ss0OOPV8CT9Vt6s+MiHHeaYkPli1AOfijX+dSam8rJCxtv2iS9EHm/CrGXNl80Vn1So2jgXt17XHq0VYpWmdJkWpo/M0Eqqguhstm5O/eh+uhUcvwD1owaf6uT7LmqU1h8xb4TAxxQHgCphsduNU9OIxDlWt7AJIIqWLMq86QZsX0kYyXYKnya8TXYlOAQ67nE3PdpcjMpH+TJ2PD7X9W15cX39/DsVrmTBOX5U5vxx6PRzwJySHiC/iBQHv75ShIx3Pm3eq7fwtCDKyPsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aACyaqmLbG6zMaBNREfGn51LLQNDX4hs8m4Jzx94gAE=;
 b=q7ogW+LwPRlKG1a9HvW3cEyQgcmh/gesFA9RGD40+/tDLTie25rTj/Yd3p5Q0tx5GB2FgrjNqvj/zFeiy3Uu8GkZeA3tu8H0su8yr6vJg84VfhMkdIqpNOStcjCb7makRlwxtS0gUYvg6EC7hBXmJCsx6CbrYrLlD9BrLoFFvgM=
Received: from CH5PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:1ed::15)
 by IA3PR10MB8759.namprd10.prod.outlook.com (2603:10b6:208:574::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 1 May
 2026 12:39:12 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ce) by CH5PR02CA0008.outlook.office365.com
 (2603:10b6:610:1ed::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.23 via Frontend Transport; Fri,
 1 May 2026 12:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 12:39:11 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 1 May
 2026 07:39:11 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 1 May
 2026 07:39:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 1 May 2026 07:39:11 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 641Cd8Y13498472;
	Fri, 1 May 2026 07:39:08 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <ssantosh@kernel.org>, <gehariprasath@ti.com>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] soc: ti: k3-ringacc: Fix access mode for k3_ringacc_ring_pop_tail_io/proxy
Date: Fri, 1 May 2026 18:10:54 +0530
Message-ID: <20260501124129.362192-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA3PR10MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fda247-88ae-44e6-7cf7-08dea77ea5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OyokKAzYKXXP3inctVZJvZQsjWARur9qkr/0vCecqMQVoxUGNuid/OkYOWnp6WGFXRyK5AtqYRHkwQa/JVkvKq2y2LojWsR16eqSgkGiFMkrP4wd6RFeah4mc7n04DdwyuO3WkwWNBU6KoGwRVyDgh+eisjyq91CLevp17nzIup/rNmqGBz/YM29EgbSx1XsD2i27rnBH0odBrOJZG6EOVYtIIFBN6OH0BIF1CaBSrbBDwbOZMF2QZ2w8K8pRpe+DX6V3S761qTs9Pqu2OpF1Bi5ndPv3N/mT003pGNTG4nCMgxYcTJDgZBLVZ3rsTtW4jB7J4mJRxiKgQRLblpSrIeSIHucy32kw0PuJ+ZuunBBQSh3TG/iy0XAJPKcsx07PdKzMRKAFQ+LJqN3Kg9Au1efrugO5NltSDjdai97fXvBFb3/lfbPvDp3LnrjZDPA2ZSNm5SwkGd1LWcarEkS6jAkBwVitEEOlIBrs3qNkS2FCobgZxdIB9+Ax9/hDLl27CuJ6fZ7LxDpwMjOuXVdX1LWrNylEecfN22aUNF20Vt1I3L1zXpFgVnAc+7CCdJP7wQXfJorGYhlFfC8/nNUOdLkTw6vug1J1CyMOCUfLoSIcGes7S/YQU3HD9mvxAHykKaeRdmXhyThkjKg0EH091HfyQd+TV/+2LEOZJNay9Aqd3zwD+t5jlKmbZcaaIlw
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fDPN08ECo1QltAf7KmJiy8CZ8f7LRb/a5NRU/ZftMRynMaeT5IXI+VSiJw6KXxsCJKkDqRUc3hbPOfr0dFv2XiAFWGeJp4FuZrjIQqH3yywdQ1vDYGLDjn88eZdoKdr2CBP77HbJyxoQfoEW1vBPWZ8hLj7utaVmzj3MYgZIPCW82ZQjWB2tCU2QX4ck9qi53UDmwsiRWmOuVzMGt3vVAUOxhdx+h5qZAcAPYSzdG1sElNDeLJDUq9pVDeHVB9xZd3tj2I8cVhPtRhYzx/zY2O9mwN6FBbflm9ul9Xn72uAn+d1mQmucvoG1wTTPVsojXK8/v/n6EN+qGUr7c+9J4nQenrC7NSVV8yDCiy8UnfWWgveAaj6oVnLYawnImA4oLuBqOHXHyYFXRseN1MaMr/OiCSZAKZJTBkBoW9CPc3VNpPxhyN7DuRsmdDXoWVRX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 12:39:11.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fda247-88ae-44e6-7cf7-08dea77ea5ab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8759
X-Rspamd-Queue-Id: 371624AC728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-242421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid]

k3_ringacc_ring_pop_tail_io() and k3_ringacc_ring_pop_tail_proxy()
incorrectly use K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
K3_RINGACC_ACCESS_MODE_POP_TAIL. This will result in ring elements being
popped in the reverse order of that which the caller expects. Fix this.

Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Patch is based on commit
26fd6bff2c05 Merge tag 'mtd/fixes-for-7.1-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
of Mainline Linux.

v1:
https://lore.kernel.org/r/20260413065125.627180-1-s-vadapalli@ti.com/
Changes since v1:
- Updated commit message and fixed k3_ringacc_ring_pop_tail_proxy() as
  well based on feedback from Hari Prasath G E <gehariprasath@ti.com>
  at:
  https://lore.kernel.org/r/d36239c2-98d5-4e5b-b99e-470f4d753a52@ti.com/

 drivers/soc/ti/k3-ringacc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 7602b8a909b0..e2ca380812d2 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1012,7 +1012,7 @@ static int k3_ringacc_ring_pop_head_proxy(struct k3_ring *ring, void *elem)
 static int k3_ringacc_ring_pop_tail_proxy(struct k3_ring *ring, void *elem)
 {
 	return k3_ringacc_ring_access_proxy(ring, elem,
-					    K3_RINGACC_ACCESS_MODE_POP_HEAD);
+					    K3_RINGACC_ACCESS_MODE_POP_TAIL);
 }
 
 static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
@@ -1083,7 +1083,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem)
 static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
 {
 	return k3_ringacc_ring_access_io(ring, elem,
-					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
+					 K3_RINGACC_ACCESS_MODE_POP_TAIL);
 }
 
 /*
-- 
2.51.1


