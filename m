Return-Path: <stable+bounces-128783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB57A7F174
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB863B6944
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3B822A7E5;
	Mon,  7 Apr 2025 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXN2YmcF"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63022A7F1
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069430; cv=fail; b=F6E3Bdfx+RIgcDljLhxxIQEgGCrvfgqy7GQIhK9l74O6/A4VTwrB83JPuxJvNdtghkP7WJh7uF7euJBIm6vpGpK1GxNNI0aJkAiIhakGIBJmtKDcUOH8FpMG/hu9A4CBr93VappQBv8HUmSIfIJSDUeOMLGc6zWQv7nHUIs2+h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069430; c=relaxed/simple;
	bh=i6qzl6Mzlip/eto4MgztzZ/9kITcv0WHFg6fjZcOWOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bWq1uK0vV4LIdNn7Rt1HVoGZWeVXnzx3ZIHJx544zua+5BL3QPR04hGxFLKcQE527vMqr+1r+48iDIx+TG5zakBg2Hr4HPZtChBrUy13aPRuVsyBoiDdJn6SJI5dkqj7C67tFWfHctrvKYlP+TcL5ujKe2p2q9H9urwDD/Rx4LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXN2YmcF; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBdfjiGxC3AE8q2CvxAn/5HTij5HGuLgAfz2hCOFM5APFQJqV9u+PXE02nUwgTVf7Z1DS32miCt2GZMGZZhHfMV+o0rsODqLthFpTLn+8xEk4Hiq1vTxMl7teHF3he2TvrsJD1VM/KYATb97RFB9rKe1hU6Soy4wsIROHc5dCwpW67zJsT3WRUQwgZFnVw4yrb4paalEHpyhujk1TefacXH7cHg+sBrNYbcAq3rQmDCidr7n0mQGHqwkNeqffDCOuPZ5/qCGHmywFC8AldQ0jgNI9oOtpvykYCJzAhxu8By2f/Nz1ls7i/bXMQBUEn5V3z6fbvMVMsZukUd7gwsONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBOGG18bTfVzpXpUlPeYkyoIh2cxdrxk3liTnd2eZoQ=;
 b=WMXGtuTRAXWCyxsy4/d3i8hQGyWMDaKGGA1xxL1hAZgJZ2ePds6djFj8TIgOR3NOlzov9sLLY5eajVLosJ5huAPMwhY0zsdDFjlueM6Rc7m4nw9SN9JYtZUR+U1DtyGq27PZhr2tV6OH2rrh/cNGeZQrLSWS0t+8pftG7o6OYo2i3sav8vruqpz3jRH7kESkveM9NI1hK8gkEzIlc2DhhWl2FBg1KeAsjQlf6SMNnXkAqGlw2IULDFldEZPh9kQSSYw7473bsrWej+dKgLM1n9RTKj19Tw0VqWARhJL1aTkPmP2ZOEKqDc0N2ZkhynfZ14s84Hj4QoDH9uWV+Ca3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBOGG18bTfVzpXpUlPeYkyoIh2cxdrxk3liTnd2eZoQ=;
 b=oXN2YmcFuCUcQDPnYQr6x6kwbVOysSXXrXiOrP4061VgHMIUv1RTBVY7e9WVT1DYp4KveVK1CyC+g2tG1fqfVoQyr7asTS4E4/AP/QJBwpzlsOkKpBB0YARs2I4811YXyncHeeKsG8wtn83w1f9aelWMiKPSz+cCcZ429N9ND8U=
Received: from BN8PR16CA0021.namprd16.prod.outlook.com (2603:10b6:408:4c::34)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 23:43:45 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:4c:cafe::b0) by BN8PR16CA0021.outlook.office365.com
 (2603:10b6:408:4c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 23:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 23:43:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 18:43:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Sun peng Li
	<sunpeng.li@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
Date: Mon, 7 Apr 2025 19:43:29 -0400
Message-ID: <20250407234329.2347358-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 38704651-def8-473b-910b-08dd762e08cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KpfB8mmgmOQRRtayf6O55hyvyR0y4lm07BAE9NRFSuC2F1jBHMAFFyt//1Xv?=
 =?us-ascii?Q?rjbM6a2m1DtZ/yRmYdkGTsS+1obVS7Rblnqxf67nFavU8jMNxKGvetT2W5wQ?=
 =?us-ascii?Q?BZBz+cHVPBCeyTmHIIyubWG2hMmPpVQtYlrWZGgQfzwJ+7fBtYr4b+KYvRm2?=
 =?us-ascii?Q?HnL33FWk42yjw6Vj60YxKMCreeiDc2OLJ6/ph+vPs2+sNcfORXT1ZWm0rIWp?=
 =?us-ascii?Q?jYVytsFt3mLaGDA4Ia94x+PcZcuQ/zlIRxrcZNYVfGYmgpJE8Q7fHUwvLe0+?=
 =?us-ascii?Q?ULBKYBvNakaEIaCFqWt/RF1Au7YuNozqW0TX0h/BuZOwldjuLMQPYWw39CTb?=
 =?us-ascii?Q?mCJH4gL2I9P35WV+/AXzgRnAjNYIisXnZZgDh2JxS6S7Hb3q2Y5N6Hj4Rq3w?=
 =?us-ascii?Q?ERAmbYziJgXkhj09mC29xZFbaZ0gikCwPUWueBtiEfOtk9MqUxDIh33gU6Ap?=
 =?us-ascii?Q?bQomX14bhQJ35Lh5Ez5cRMBJpiDsd2GRYmHb7kov12afMbpENT60P195Dmtx?=
 =?us-ascii?Q?PEEN/mi0FQz278PRjFxgwn+0UO2fv/SGlXZfyEC9JUcmh0OXCvZh1pSbDR0l?=
 =?us-ascii?Q?oEK5wrYXrg5/2O+Ysy9zy1i6QDbWOXVb5CLuWsEQub1z0bHj/SImsJIAkn/T?=
 =?us-ascii?Q?nPN+yxP4hCpLYCopNxT7uCBQD0fa2/rn4emhe3+zvSqoFmqFwfsyi5INKUSX?=
 =?us-ascii?Q?/eRMV2pCx63QcLydtHKDEEpGRXExfbrPwZ9LGTwPuY2xCM/PvXv1Yqz9bM/9?=
 =?us-ascii?Q?ROTtGcwOgObYXTH5EYKbEPq0GXjV76NW0lyCYcC3I6yYaolHNvnUHNf4e48H?=
 =?us-ascii?Q?Hv7G6WIiWh4Q9CWQ01Y1Jbx7P4JdpuDYIps6YE4a8xBSXqc1FkV7RcuUjYmI?=
 =?us-ascii?Q?+KRBaGevUMQcu3jMgN1knBi5WSKCwMqP0A7wkZTPJU0OezPw3kAq7O2tLyzX?=
 =?us-ascii?Q?7oL7qC+MI9YItJKLZ67z7XKFIQRAE9Qjb6wGWdZvuCC297yw5RxWdIVPbSin?=
 =?us-ascii?Q?qBSXUwuPxiNR0S63AkA1xkZnXDBnwGS3Dpy9/Iopy+pEFpVEvYPLktymLZq0?=
 =?us-ascii?Q?5fo751xLia6onm8uKEc+Kw/s8VyK7lw5BkUnBVdvw3tbu7FGMQny47TfRfzp?=
 =?us-ascii?Q?8byV0fhTjT1eikD+Kr19ZsHyvE1bTr67nbclQIBABNQw1Ov3opt01sxxnju1?=
 =?us-ascii?Q?9N2DBu4QoC8EcdOjdj6Fkdl5CB02X/UK8GSP22XeN2zdMToBSUbkw6H2oCLX?=
 =?us-ascii?Q?nLn+mCjk8VnizBX/n+wL8pfn0qeQ0TD8wSLTaQM6kyGy7JTILkZP65jNTWsC?=
 =?us-ascii?Q?GX2Wn/a6gKY+QdmKOvPOf6rQtlM/Y4eYNEjqr3gOweRNQCUvy61ywGs6HSpu?=
 =?us-ascii?Q?sCWsDiCdKZ7b+xTU/wYP0tyB7gpVlk1t76EwgSxrXCex84bzouPOtxqnU6BF?=
 =?us-ascii?Q?IomYeqQ5x8++8Lva/9Fk2JxD2QAzr9xAgasRpse4dqRikyxL1PQLT6lmgYAl?=
 =?us-ascii?Q?knYnymXu8X9PqR8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 23:43:44.4272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38704651-def8-473b-910b-08dd762e08cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

With HostVM enabled, DCN31 fails to pass validation for 3x4k60. Some Linux
userspace does not downgrade one of the monitors to 4k30, and the result
is that the monitor does not light up. Disable it until the bandwidth
calculation failure is resolved.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ba93dddfc92084a1e28ea447ec4f8315f3d8d3fd)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 911bd60d4fbc..3c42ba8566cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -890,7 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
+	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 	.using_dml2 = false,
 };
 
-- 
2.49.0


