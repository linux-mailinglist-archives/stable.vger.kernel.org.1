Return-Path: <stable+bounces-69912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF895BED0
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9590285B20
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 19:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9C1D0499;
	Thu, 22 Aug 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3I09rXY/"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F31CE6E0;
	Thu, 22 Aug 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354777; cv=fail; b=Ug0hnT0CS25h12iHFlssgCDIdQ40f8mczYnOyk0NulwfklEb+C2mKReKQy5hmBoVZmSNGYYdqnlWA0El6tyXPr/1wLvGbSAQ0PIUmUyCcCh28oTeNYHG2GwvozChMx0vberhhOGk/OXCPtWey35THC0jaNDcqu4h28VnfgmDY78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354777; c=relaxed/simple;
	bh=C/SHcVmEuYGNN44wUVl5kM41QfjrR8VfsbQt4Caas7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhCYBBGP3obQzMMBkZN6GDIq+wckpEz966mdcSsvfppAf55JiZbnwfcWDFTCSAu2941GTIf1joGgWDG/TVny1MsgADPafpjOsoGDzz4jlByOdW5ugDN+Hkg2Mcq6Jt1ZvqizwLu8ezDukPHgi6Zc5oYrVi5MJxah4QrI4lFjqd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3I09rXY/; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qds66RAGGT/eu9fGL3DyVjt2xR8QnuIdXX2K+8x+2Px1shBu5vJb6mN+ghj4iL87YoeGl5ghxIofx99Zx4bxQmbLALVFrYWCW/m9ZefwTzLln7hrEq6+UdDADD5AfgJ2nHb61b6jI8R/Oz4d1fbga18VQXg972vpixmLx5ItyMCgsI2787gncloZVGOuUCspPBuaOZYK39cqLf9QuX7E0rEBUNHx1I66qLLhQRRKXxHUSfjR4P3udxMeC9H3y8QTvfPTPbPjynkZLmhJNsg1ysNO9mdVMNz5LhHQFbuelZfQINXrHjaClJtJ6e99hkKnY/13yu9Xwu4xFyneoeQlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB4q6vU448nn3qz8OtphuTEsKPHDfJtk59Q2Bw94288=;
 b=Z5kQshjkTDVhWaG5vnWWkURgI0bDRQUMjhevNHdUVEsSP+z3Ues3YkNu4f/aZ3H4DSyU8gE/t5KXMLi9n8FGkuKa4QNed2K7vUYjAXD+Xq+6UNaJluXMsl79HGfaFsqiWsIdldgiwY/OD45TaKqr5PUdIriswuFhs6h+8/RzdycBbMvSr6aSYOJsb7iLW3duBE+kxOIJt6KTrl4URTPbn+lhhcXQBLYUJBIQtAVU8RyOaUcddOemI4CEDM70NESRk7iuq9UNPACYhHYsw9sKYgoDWlp0KArKBT8IUy8jHW0inU3lTOqiFLrra1KgrevZjhhZTiKCaiVmVd+ViYbyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB4q6vU448nn3qz8OtphuTEsKPHDfJtk59Q2Bw94288=;
 b=3I09rXY/LDQz++/IkPMJrm+OuA/xaAABoX6gacY8aOb/YiWZx0x/KNyE9orM/44rEq5parEu5S1QcrNsebJ8BEl2WdD/QUeHmzKzWGdQXxXe86AUckJYkHatL+vD67G854iO0M6p+0WrNQwNQ8YRbq7qBh4SYbGMUYALEeRsaJg=
Received: from BN0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:e8::27)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 22 Aug
 2024 19:26:10 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::a7) by BN0PR04CA0052.outlook.office365.com
 (2603:10b6:408:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Thu, 22 Aug 2024 19:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 19:26:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 14:26:08 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH net v2] ionic: Prevent tx_timeout due to frequent doorbell ringing
Date: Thu, 22 Aug 2024 12:25:57 -0700
Message-ID: <20240822192557.9089-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: da1ffd37-83b6-4842-7300-08dcc2e046c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmICwprCzK6SJZDDZRqk/sw975AKFcXJC1KLm/Xs/j1xsYqdlNS/FnyU8vAH?=
 =?us-ascii?Q?NbX9a8qAnexDzm9sK9J5Un0ftkdfaHaEEp/eh/nC1CGnD5+b/RD8HfHG7g04?=
 =?us-ascii?Q?5WlRcSXyWjWWdzz5gKwUvsdINGmm00VAerDMLdghWtMfCEfUrDRJcpp9uESf?=
 =?us-ascii?Q?UORAuOqJ2N4+QM3PdFC8Tee/opOCGlmFZjXYid2BBIRgP8e/VCaaSdk82QyO?=
 =?us-ascii?Q?SKyfaUncdXammhtGyNHOBzrdkuZMRaC3p/M7IjF1ZN12WG1a7q8XLLUetrIm?=
 =?us-ascii?Q?kJocnT116ni/PdzEIpftaPUjHqRLjeUxNXuKmlg5046FHXTyND2TQoZAyTXq?=
 =?us-ascii?Q?Vg8jgn+VVDoTzS9sT7E82zzxlFK1aC3nOiGWx97j6B6iY+SC4T97WDWmcV1x?=
 =?us-ascii?Q?p856KAhUCoL2sGKUfQS82GVpBiVcChjynS2KJyWBJB0iB6Njj8n8+ZahZrNG?=
 =?us-ascii?Q?HukOe+0BMWAc2UI+0zYmkTt2Bse+g1dSMhQLaBvAy3d27mNY7UceNcugOWOl?=
 =?us-ascii?Q?4UJ1/KVc3puKHbT+LvBVUVacMOG60cf22g16k8jkdXRpE+9Ix6gd4iNUDV2D?=
 =?us-ascii?Q?Es4wMo65RXojv2fMLPowQDDd49WUriUnl4ceMGZLjbn7IOOf54LVyydzFLMN?=
 =?us-ascii?Q?AMPeh3VY19XKKNTVGdIJSaE2DN1/P2h+I661kXoPzmrY2PZ1EfY6SNoaxJ3n?=
 =?us-ascii?Q?psaXkpM5WK8EFlGXtxrNBMjRkw+5KRcn+9a2CMpIJDkMoOx/w+HzsN15/t+6?=
 =?us-ascii?Q?6fdV8xrrCdCYkJkyimOfXd3mioLNHCH8lapT7lb1fN4rgvAdm0TM8f9AdXjn?=
 =?us-ascii?Q?R+RDFEN3pGdaSsHBpDX96tUheTLvKrM1+JjiLXRBZImfMkUmXYme6cIzW4g4?=
 =?us-ascii?Q?yWORBI9cp2jqvuXGBR08EN4BPEP+mRp5QyuwVnBc9qHjE/wYtMqeoOnqOkUz?=
 =?us-ascii?Q?HpJORlM53RNUWSwRQKYV+uto3YRPuwJ4G9Xp5IZvPsRImxt1Y12QqbRuZWcF?=
 =?us-ascii?Q?hyarjYdyyCLDDVi63obysdEzfV6YvSJAmCLcGv1rEK/MjR4eteoQk+qsx1sW?=
 =?us-ascii?Q?ng8U6+evZJNUjUuBZdhGxVudM68dOOC1n7jt93bx0uSVnIK9ngDE1HUBJxhJ?=
 =?us-ascii?Q?FaFGGf1jiDAXNRN/Rqtqa5lb+Ey1DSJpqzqyLbti+NqqnasyqKqKXNHADxAx?=
 =?us-ascii?Q?GQX0GlvE41T1l3qyEN3JO47W4MKux/2u9n2aLtkmp5hT2FSZOOH78NSnAwQ7?=
 =?us-ascii?Q?1yvLtMRtZiha3uGZ6fbKVvRqk0wq9XHTODrs1yNNkwstFZaLMzeex5D+55LA?=
 =?us-ascii?Q?d8CLwVGlvecFEZd/JlR/che9YG25CYf51iPkDj3s819OApOYdBUbQhUSHwva?=
 =?us-ascii?Q?XmBXctqj02+WprvtUGL266FlRhjalBsJS2XJwXGsGc+84he/X3QFggOheNH2?=
 =?us-ascii?Q?hAgD83yMXNwpqT7Ye+LM9cRwLD5Yp09a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:09.4598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1ffd37-83b6-4842-7300-08dcc2e046c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132

With recent work to the doorbell workaround code a small hole was
introduced that could cause a tx_timeout. This happens if the rx
dbell_deadline goes beyond the netdev watchdog timeout set by the driver
(i.e. 2 seconds). Fix this by changing the netdev watchdog timeout to 5
seconds and reduce the max rx dbell_deadline to 4 seconds.

The test that can reproduce the issue being fixed is a multi-queue send
test via pktgen with the "burst" setting to 1. This causes the queue's
doorbell to be rung on every packet sent to the driver, which may result
in the device missing doorbells due to the high doorbell rate.

Cc: stable@vger.kernel.org
Fixes: 4ded136c78f8 ("ionic: add work item for missed-doorbell check")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
v2:
 - Drop budget == 0 patch to expedite getting this patch merged due to
   the budget == 0 patch being more complicated than we originally
   thought.

v1:
 - https://lore.kernel.org/netdev/20240813234122.53083-1-brett.creeley@amd.com/

 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c647033f3ad2..f2f07bf88545 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -32,7 +32,7 @@
 #define IONIC_ADMIN_DOORBELL_DEADLINE	(HZ / 2)	/* 500ms */
 #define IONIC_TX_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
 #define IONIC_RX_MIN_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
-#define IONIC_RX_MAX_DOORBELL_DEADLINE	(HZ * 5)	/* 5s */
+#define IONIC_RX_MAX_DOORBELL_DEADLINE	(HZ * 4)	/* 4s */
 
 struct ionic_dev_bar {
 	void __iomem *vaddr;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index aa0cc31dfe6e..86774d9922d8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3220,7 +3220,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	netdev->netdev_ops = &ionic_netdev_ops;
 	ionic_ethtool_set_ops(netdev);
 
-	netdev->watchdog_timeo = 2 * HZ;
+	netdev->watchdog_timeo = 5 * HZ;
 	netif_carrier_off(netdev);
 
 	lif->identity = lid;
-- 
2.17.1


