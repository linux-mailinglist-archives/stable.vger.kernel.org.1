Return-Path: <stable+bounces-76017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D2976FCE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 19:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670BEB241A0
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7071BF7F3;
	Thu, 12 Sep 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="axWQtc1y"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759EB1BE85C;
	Thu, 12 Sep 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163384; cv=fail; b=sF0FAFUyssCE96G/f/QgA7VscwK+gBo1YlBVviyu6TN7gzZRPBWdwYxp477fKXsSIc7+tXgvllCwX9rv3sfV6qhmK4hAnsDRyNPIxMPOPbQtokJdtWcHZjJddfmwhPRuca3Qkxbfup/V+zyzIgBqRuN+RpizSRHXKBvCgfWDDt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163384; c=relaxed/simple;
	bh=wM+ar2m646XQn+DscnCZRNwoupIcB57xayLYkFNAAoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QM7hReGOXfNoxwOfQIGsZFkvdsCnawtJttP77ksBXYdaSOPSQIjsuzNNQaQrIqKB2TdYJHM4l0asHsqa1KkqzvRiXf5G5cRfGFzQAloDXgj0nRmH6RM80B6draIUmIwS4s57LprDdfEj7h+QvPlqpVlQ/J5kHzCQfDuVN7vmwMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=axWQtc1y; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRzW0jMmVHJuKzLHRTEe/hAvhzq+2FWmg8xK/UuED2v6x5/IMOIBPgixhDI+eKbfd1W/oSlID0jCUxlP8DkdulAlMO9SSD/A8VeLrUEjcc1+ARXk1MzvonMNIje4nVAkxk7hVFxKBs+xFfaopbkCpJBClbFgShicUG/jdWkBUO+cvW1I8dGX4/Hb4i0nDNSNrF2qVTN40XaC4V7Ca0EOQnVBzmQ04YGtFPjw9gWutF9fZcWaj3/3bDWY0+11y0oYsRd21ksGe8jN4dxySLcItEXf1oGb/gqekjQdskN24/xsa4Sse8Ktw/K0xQAMHw0wfEQszpzqyABjmcctHpySsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vljwI1YkJJTCGlA4K3W3vwOWwnugRRxtvijlNs7OzrA=;
 b=jXVgANRoCjKY+TmW3QAjicbTnloLg4hh4z+pBoB3oEJvBPGouJucH+yBK+EBZVwM/KhQ/4yqBS6ktKdgPqthBFxYu0eFDHrZnHFoDvAFNO2l78PztQyVppEdH7l8jXm8Dwgq+OCrMZuQXVTcv3p+8jn0Ii3UQh7RCWaSLM5STA8F/5BR0ZaTJJN6ebBfN3bXFxDWKrdLJJy//VaS5w/4W/PLMB8osRdpMeleJWEaLm/2pJIdPasmTBD3XuqXuH9oWWeGUh9s0/2r86nugmq879d5ZoJr5avpnQ82hYn5CqDacMVM3jL09QGMzNFIykdeUmcJzCgOXxuZQlRydtAgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=fb.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vljwI1YkJJTCGlA4K3W3vwOWwnugRRxtvijlNs7OzrA=;
 b=axWQtc1yEg9/cQCmegX+Akqo+N6BWSuWVVQZt+yx4ImcoNH50GeyCDpJQRKqYPoi7NrX2hfzEvjW7lfBzbE5VPk1usWMCTjlp9yFPNk3zIYlALB5tIqShga9iQMYWc8U2VWs83qmdZNxXtlHzD2251Zc50hXDbMLUpoFttjKGbI=
Received: from BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 17:49:36 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::3a) by BYAPR06CA0035.outlook.office365.com
 (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 17:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 17:49:34 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 12:49:32 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jdamato@fastly.com>, <brett.creeley@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH net] fbnic: Set napi irq value after calling netif_napi_add
Date: Thu, 12 Sep 2024 10:49:22 -0700
Message-ID: <20240912174922.10550-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a59d9b1-45b7-4b94-3152-08dcd3534388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIoTBXrBERJp0OQQUUFDVNOvzPBkrep8jNP944tyrfg9UtQ8AzfrS3BtTe2h?=
 =?us-ascii?Q?AGty0PC36usKDoN+OvLMFTp75NUDLFW3ULzApjnVNY+66/k+Nl9Ty2t/zm9x?=
 =?us-ascii?Q?t7X89YGXKlBaKTajd0CkIBT6bKHEMVfNazgCJgBo4oZqxo91aGs3w8TbiIST?=
 =?us-ascii?Q?QbHnhfYmSRkuozg2paaMX1a7ayg/kS7SJXpS2H/xfRNMpnZxGCi0hVpG4SYd?=
 =?us-ascii?Q?WQEevt8Jf9wpzyIahCGMY9pidJqGLagEPHTcihEm6r5sOVsEl6lJluGXLW33?=
 =?us-ascii?Q?i/t4hCFR9xm6pgSo69c4N2OMsZzYI+ngzESD+xDBiOuSmM/sav1wuUzH4Dxt?=
 =?us-ascii?Q?41cp7mp4+d3cHGTEVGAwiGsCc65oTd/eH3pwmUsnMdQceLR4Ql76I7wf29tt?=
 =?us-ascii?Q?cgdIyTd38tJpGlHajX5t2xNWLZYUeBm9Yk6/MBX5JsaG5FLxq35wPn+hEu/u?=
 =?us-ascii?Q?PfFsporWPNwJoDXdof4VAUfBbR3uN9tOsB0tKYQXwnQFAnAFeBea2NMEOSGw?=
 =?us-ascii?Q?aKia3vLRF66oo13xPJEUa7XhKZusswC40ckBu2Q7n1aODcLdD+6nXEgKSFcI?=
 =?us-ascii?Q?it58FyfIKYQis9/xdT6y7uwNUF5x8G7cjTrUweEdibNnFZBZF90noQ/DIdUe?=
 =?us-ascii?Q?UNLOYasr1nBy1iTi1wQf3i1KgTyWYk+VNfBidBm6XbTDWr/MFNCHqwtCXGbn?=
 =?us-ascii?Q?Dovc6oqgau6v9Df/MjifS5tT90JH1gljhtqykYUdMSNFhdaPlyA29Z8+H+2b?=
 =?us-ascii?Q?YyMQHE18athmSjTmT3I+7pWFl84CtR2+FyhFMxHyzvRoQO5b66Qo6+XZni2l?=
 =?us-ascii?Q?yBpsRmBD5OdgyJExDkauWwIQSmniAgYKbmIe+TlZPEIx2MOXxtgSp0tSIpHJ?=
 =?us-ascii?Q?JAN5G1J1IFSVuVjwCIfJcSy1F538xqsFk2RFVu5sEJ1rMNE5nI4HEB9i+uuv?=
 =?us-ascii?Q?IrkDnZ6v+ZcRD8FCYc6Ov1iwdkSYmukSrmNyD0MB2oOd6X8Va+PtTKTNT6jL?=
 =?us-ascii?Q?FhSrYd86P6Y6hd9NIVYhW8353qorCukBFQ+vjRg0YFNI7oalZ2ZqPFCTkCtH?=
 =?us-ascii?Q?3XuQn/ruia9IH+XGwmW7co5Cg2AlNL0mXSzHDGbQuK7N/67rOLg9NYtASu6n?=
 =?us-ascii?Q?+c56kYTcYsEuddYdiqTrMeYRO23QzCgfP53wziFOJnQ/PqXVk+2TF02wOdRs?=
 =?us-ascii?Q?HNC+JnyHQBIyCdEREWgyoT5m//zqQShVzzcQYhDHChstR9Q9klIZDMQrZ4vF?=
 =?us-ascii?Q?lOlIj5JMPJiiJmc2Zh5/yZXuBLrrTD7SI6OWLzFxv+FW7JaltC+LjFP3hV1m?=
 =?us-ascii?Q?yO6DAsdAw0ldT4+CwCCw3v34fvXeIhiu0b4KIeYNulidXUFk3E8cp/hKzjH7?=
 =?us-ascii?Q?taw+LZqxtRQS/MwQW4vhGN7gVIzCEmjbGFXXyI4TnO5dWjHhkLvDdOMcfPp3?=
 =?us-ascii?Q?GuW9U2EP51iqA4EgJHTb9MU//T6azq28?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 17:49:34.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a59d9b1-45b7-4b94-3152-08dcd3534388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
which calls netif_napi_add_weight(). At the end of
netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
clears the previously set napi->irq value. Fix this by calling
netif_napi_set_irq() after calling netif_napi_add().

This was found when reviewing another patch and I have no way to test
this, but the fix seemed relatively straight forward.

Cc: stable@vger.kernel.org
Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 0ed4c9fff5d8..72f88ae7815f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1012,14 +1012,14 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 	nv->fbd = fbd;
 	nv->v_idx = v_idx;
 
-	/* Record IRQ to NAPI struct */
-	netif_napi_set_irq(&nv->napi,
-			   pci_irq_vector(to_pci_dev(fbd->dev), nv->v_idx));
-
 	/* Tie napi to netdev */
 	list_add(&nv->napis, &fbn->napis);
 	netif_napi_add(fbn->netdev, &nv->napi, fbnic_poll);
 
+	/* Record IRQ to NAPI struct */
+	netif_napi_set_irq(&nv->napi,
+			   pci_irq_vector(to_pci_dev(fbd->dev), nv->v_idx));
+
 	/* Tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
 
-- 
2.17.1


