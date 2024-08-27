Return-Path: <stable+bounces-71329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47CB96144E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B0282EA0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3391CDFCE;
	Tue, 27 Aug 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x7RFsNs7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B061C6F5B
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776882; cv=fail; b=FwnpYC7jFoV8VXTDRYBetULLGlm67Fk8Ql1R0DZBv5iL8vL88R559myc9YwlkChsRuXegZ9mBQhVAnzePvThaIBpyAn6d5igfOwzfrLTBdPyiEstyk6buAovFhAXUKlq1+7bRnnZkT9odkEYhOz7C93K31o34QCXtPAOW1jwDOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776882; c=relaxed/simple;
	bh=05QYbMlb4BiQiFNvfspPcGSp0uCvMz/q3TeWfXVU1mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZOiR2CCRdPNV0Cn8N49cZ0P7+oTjTxyOyckORW1Mty6G2XibgasJgoea/vjKKZPg+nLrIg80eha0A8mtrPYE1nHOwHojcOj79N9YQ2fObnrDOhG6k9wStmvtYKYVEhv7q5sSV3accW8tiAXiN3ggLW/6mbI/IQUhWLbA6DfjNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x7RFsNs7; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFE9Ug10R18PYbmN9wWpha3AcB7SiZsKL4WPm0V7dGMQ/havfsZbMXxVQmMh80VTb3D//NLMXM1GehcBjV7oSZ/sY1f1dcYzoHtjMJ3kQEW0SWzAQEe/PGenzUZIHG2mGGLBpp8HEEg2v7fQ88ZB4WcEl1hsq1zNV7OYrVgRY6mAQnjMTTtK1hjPPIvOQW2oBPKcxzGuVAJyWnM7ty+v9cRV0pLpvTp8Js0tK26jWnwkaBI5JfOLkk5zHc38qy6iPb/+EtpeY3tXYZ4kg5NnEqy0N/OoMIoqdGTefveqvmMTIgi6Gi9JBbjC5+hsUCS1z0Fx6bZwuKj75CWINWa+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0SukB5Sn49Apdb60V39ukkxD52N5UUFYOZ477Zp8Kc=;
 b=iYJdaYAE5H0bnTBTOXphq9hyvhhmY7/y5T0+5Hhs7j1sGvStSB88yxbKIwZqZGAcFzcWRXWThABXcA205ZthkFJTeLzRDxlIQsqSzhclmjcXDLRG/liER+XpUUooKzmvPigXhCk66mEVkfHCibUfaYy9Q/8cPv4gO839+n0UAmU/M7XZDntzJ+5l5v//0XvY6lvCxjFcoeZs0lmKDgy1B1wm9pnGQpwL5PZOu2CYq1WVlxe5fF0MjIJV6UA7BrUT2aiM6BXIaGn/wuIgghBOpjvz45Xty9x0dxAoZjqhGgDl28xzdYsj0UVXQDIgw3Ovqw0s/iV0GP6S0D7FS55DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0SukB5Sn49Apdb60V39ukkxD52N5UUFYOZ477Zp8Kc=;
 b=x7RFsNs7824DgW9jRmsdx53sdAz4M3szfhGoiMinToj+AKN8fQDXqy+OTmRZ/vSLOHdJrWoWx0OplcIIori9kHVGP6og2WBG7zEr6AwYVjT224sQRHAVHCqz4WE91RJhXJs51rjTI1KvCCzNivkKcq72zSvmzaAJZphr71HMWZA=
Received: from BN9PR03CA0702.namprd03.prod.outlook.com (2603:10b6:408:ef::17)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:41:18 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::2d) by BN9PR03CA0702.outlook.office365.com
 (2603:10b6:408:ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:15 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
	<aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
	<roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
	<chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
	<zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, <stable@vger.kernel.org>, Austin Zheng
	<austin.zheng@amd.com>
Subject: [PATCH 12/14] drm/amd/display: Block timing sync for different signals in PMO
Date: Tue, 27 Aug 2024 12:37:32 -0400
Message-ID: <20240827164045.167557-13-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c169913-815f-4aed-de29-08dcc6b7130f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqvpD/Hp5zMiVlcL614tRplpkmYIQkKg67PmBnW+jBxA83bHvBp2ZIDCHXei?=
 =?us-ascii?Q?8kiaGwvML/kkRx0GALLv7I7/gtcdtHxKwelJKHQnejfYEQCQY1GbYKKAz2WT?=
 =?us-ascii?Q?MA09puZgmFNG7e7pDNrTYnpDlam28nr9KkUY10g3Ad1hscJb/h/A2C0cDIF0?=
 =?us-ascii?Q?fy3FISdTGKXq06UEo0Smefd+B3xWJ1IecM1JuzwxCsh81nSYFIzcvDNgoaUv?=
 =?us-ascii?Q?ASlPC0NgMR7Q/1lTF70vOe368kqZ7fvtNK90v45rKFzriPsu6uhz5uN2c36y?=
 =?us-ascii?Q?mEHtWDzTLqJ94+T5wGWXvGJANS4thl/1deOoIzHv0wr4uh4dL69VXotcKr6e?=
 =?us-ascii?Q?pEcEnpkOi/DKBC61MKFt4iMAynR29j2m0pL5UNKk9Zk9pc28wpoW7ev2mGx+?=
 =?us-ascii?Q?oNl4kRGSb9bgAqZD3FvjDCBIJyWOh0UMSwU/eQySbX6PPl4Flmwj2cu/Iy2N?=
 =?us-ascii?Q?kq0gF7+nJ3rgGP4NeoJ43Ey51K0CYLbiHWCw7BnA+BpMvzFB1BfHHTsQzH1T?=
 =?us-ascii?Q?6RhBbPcTK52alHByNrow0MSxIyge9N9bXzDcCRk1y833suMOBWJ0WWWMWC6V?=
 =?us-ascii?Q?2UVdGW4kxzwtAAOTsH6WdH+f404XWiEmcNSpXVLYkj4i4IXQOgQvnmoCeqPz?=
 =?us-ascii?Q?B1UBBSlKxJXvhgImsjSMSPVvhBI3dzfMtvSf0/c4Rbc/QL9+yg05eGn+Pxpa?=
 =?us-ascii?Q?dPnvYWwwxIWM2WNKyv6zcuohuRx7HPhlXhlr+Cysn6LjeR69J00nUke0MrpL?=
 =?us-ascii?Q?ePnon5gXdlMMwlj8vnE7Tgr54hNCsygyT4LYBWw/03xDJz4g+1n2ItbX5Hpu?=
 =?us-ascii?Q?F5nrmmGE4/eJ4Xe3RqgBKxvSprttaoVVPlZWfki+iNnlpJ7HGiHwEfMJZlJ+?=
 =?us-ascii?Q?c22SEmT0ciYp6HpLMZdz5uQVA+42w+EaH4ykB3nyGSEw/BNj901H8JTkGU6S?=
 =?us-ascii?Q?rSw4ZoKTMDfuECznrr5CrNBDbHqUwgPdP45fUC7ez25NXj8b1sIjnEpvH7Xw?=
 =?us-ascii?Q?JNfeCNxKuqWv0U73SNLaxo4qhyE31DcPMbfgEE8/v0VHddPJkiZ/JgJd9Azl?=
 =?us-ascii?Q?Q9aOfUk9Vn/wyRo0/33rHqFSoWsOPzj6xCPDcqdJO7T8AY07+2VbM4/7Y4zJ?=
 =?us-ascii?Q?13w5ftpofBEXp76iuQIsr9Qafiiirxno3T6/ISKgSEBVVMdVUNsS65mykR4b?=
 =?us-ascii?Q?/toLDjnXn0pTfJS9S/PpYK6qAzYAVqU7Jtf0R4lkUoaNVAWcveua6MV7W76L?=
 =?us-ascii?Q?j6CQLiBB3D9k3j+1Neqn9I5PpvEfLCIKTKGWPmHnibZhQ4UK6gbNJXKubsQE?=
 =?us-ascii?Q?6su/pgKHMqFDQNzFrY8JS8vRDSjRC7B7HGly3ZjTO0SHZSCERnJcFFt2xYu/?=
 =?us-ascii?Q?lGmcUu8jF4eBhQWBgwpiJ7+eqp6VJjHY1nk4eWxo3neYB9/iBDUiJLz74R34?=
 =?us-ascii?Q?i66Gd/549FkvtaqNzjZDs6EkZpgyUP15?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:18.0264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c169913-815f-4aed-de29-08dcc6b7130f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

From: Dillon Varone <dillon.varone@amd.com>

PMO assumes that like timings can be synchronized, but DC only allows
this if the signal types match.

Cc: stable@vger.kernel.org
Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 3bb5eb2e79ae..d63558ee3135 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -941,7 +941,8 @@ static void build_synchronized_timing_groups(
 		for (j = i + 1; j < display_config->display_config.num_streams; j++) {
 			if (memcmp(master_timing,
 				&display_config->display_config.stream_descriptors[j].timing,
-				sizeof(struct dml2_timing_cfg)) == 0) {
+				sizeof(struct dml2_timing_cfg)) == 0 &&
+				display_config->display_config.stream_descriptors[i].output.output_encoder == display_config->display_config.stream_descriptors[j].output.output_encoder) {
 				set_bit_in_bitfield(&pmo->scratch.pmo_dcn4.synchronized_timing_group_masks[timing_group_idx], j);
 				set_bit_in_bitfield(&stream_mapped_mask, j);
 			}
-- 
2.46.0


