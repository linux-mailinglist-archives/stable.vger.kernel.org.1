Return-Path: <stable+bounces-144273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89774AB5F25
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 00:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6EE4A376F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7F1F0E26;
	Tue, 13 May 2025 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhbjLkRA"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C2198A11
	for <stable@vger.kernel.org>; Tue, 13 May 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174357; cv=fail; b=l/uz47ZsQi10VlRzZqTOhKPVujvmSFX+cc/TjqX4AKdY5lTVfjcEdaALVVGX+CozRalDBk85zoPAxkodlWmmMQChNdDIZzxm4t9EI84H+sw0ldMYeINGMxJxLYzG14YExZoRI+KTZzYe2pymJW1vYL6VuFbldFgTCbda8OB62fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174357; c=relaxed/simple;
	bh=rg9s4cETAqnksMdDRFvGKdU626lxcWOTKLrHbU2opdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lm9fINVnbcLJeCnFrMlNK6NTOxpQZzBlDlP1tUe7L9+1A3yYViGcT6KD/R4n86OFjAEl0f1QqRYaG/r9MQQXM6nm/aUg1Xen9oTglavFJ5PJIaklxyq6elh3nPNd7KkpnzbqXN9F/XKyId3obPOI/bxpO/6WFsjK9OvnbLcDz9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhbjLkRA; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9uJpv9/28M2cPjB89O9BVAEFaWl9QCS22DOq7+csiiWnGX/DG3zpx9osRJN1zxSNItxXpFRK/FMIBJPrnfwfSp8dAkmy1LmUbhOO29WmfOtM7QYwVL0C0g0WPqtjU3LilHgFfDEz9Zu2hhFOVmXWWPq+x74oS9zGZsEKA7XGvhs7yHjjjQv49tlmEoFmd5CeEOcssb5qrVWzGOhOj+bcy3dyMYarBW8c1YslG5vj861fQLnoSzFL7Os1QffN+6UNpNSirRM0+NALaltUTEyOcw8FFNQKeyqe/jVRii9iYv98Z3FCDW7kxm7bEyhHObdNH6/yNCYAUdQq94wNWmaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XsNRlPUzCbxiUZDqmacr3niB+psM9YciK4rH+gi9c4=;
 b=TYQTtCDYLx7H3gB/UzQw8ItDkJje9BfnjwkJDjsPMlPtnDD+x53eAk9XEr3nVBy+/ZkcSbHrBsBd9hG5UbQjRLttBGmeRIYx46Q3a+gvXtXwMTvgfq2XpNpAXA3T1MxhSx15uAmxd10LOfvnphZaup/E5O5CRyLOvVHSj+Wc9kZ5WIrk75FoqYWH15SjjX3x2sZLVE4nIm4dMVQx4IrOoW7RPYLBXulKJ54VgnNxy9fG0a7AFl5yCYAc8ZIW2W2WFYwAjXPn8gAh8NHQF7KOMvuJOm8fE6x1ppFUB7XzJai6SlR13zeDEtQRJOQmNrpx2JWHkHNkIfy5pvC3yTllaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XsNRlPUzCbxiUZDqmacr3niB+psM9YciK4rH+gi9c4=;
 b=UhbjLkRAVpnrltZpHyhXvMlCGablTuVrnU/xyj+GPO+5ejFQ+/ifiaU2LEhZ/bfWPE0EzCpxOQhI2pif8+v0Qi9tkVwssmiL1lAbcn5WGBUlQ107mUY1SYKlUrvIBDnO5tHqFqUsgNMAoUes+9CeWooed2H5A1s9+PP01KqaA/E=
Received: from SN7PR04CA0169.namprd04.prod.outlook.com (2603:10b6:806:125::24)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 13 May
 2025 22:12:32 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::2d) by SN7PR04CA0169.outlook.office365.com
 (2603:10b6:806:125::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Tue,
 13 May 2025 22:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 22:12:31 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 17:12:30 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
	<ruijing.dong@amd.com>, <stable@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v4] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Tue, 13 May 2025 18:12:18 -0400
Message-ID: <20250513221218.654442-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c70ad5-9ed9-4e7d-027b-08dd926b4164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mziErlgnJ4n8KTfPlwER1i3SRQB8aN9gQFLNWVsSocdqzt3K8Mh41ZQ9ljUc?=
 =?us-ascii?Q?QA62dk+DZNL92OM7ZtjvVLq4k83GFYY6uM23QuXYISkH28FmxwNz3g9UDPmU?=
 =?us-ascii?Q?xGibrzIhb0XkoX6JY9wCowmHeSSPXs2Qig1DuOnILnH+Kq1QvA0BSNLfort3?=
 =?us-ascii?Q?oxRA3HHjNJ1PcZ9aeQS6Cqjgk/WqRXiVKiuddR/QreeBOMayE2v6IvHjlhCP?=
 =?us-ascii?Q?wA+8vvd2OUjiqy0mZS65bre6e6J0BTGrolCvTdNonhdQg4pFbfpK6cykuTgP?=
 =?us-ascii?Q?dSTAxO7LU+zYo/ceHCnmWUjnK94qUdquspc+QST1/B3mvAetmVzJKBZp00F2?=
 =?us-ascii?Q?8bjFOTJGQElhvDauIyB8cyPoO8noQGxC+ZBw+BXNGoQIjfSR+tPRg1GaQe8k?=
 =?us-ascii?Q?KBFsDeMA4Ta84USWPOy7Tg935PGc+oHZtvdmGhZ1fb8WfzC8xptycfxBBMKL?=
 =?us-ascii?Q?PWdlf8M61VSdZusEdI2hqnprdDYk+Frt0zphAEftocV2lTBhhfui4RLmJjxY?=
 =?us-ascii?Q?LuNn3mRi7ofVdSItcWi5BK0CMFepoUzY/EwWQCM4LScP7HU7XiBLJrvMTpAf?=
 =?us-ascii?Q?bQScGE2eSyrjNHiEEW1qf3DMb8ilXFnm9RVBNWSBAnJibcXNIVrO8/MeSV7O?=
 =?us-ascii?Q?Of8vloh+YStpd7ctZmu734A29Gx/vW7FgwHc4u/hZ7sqChT+MK1Jp65Ftk8k?=
 =?us-ascii?Q?LVgHpcEIkGIOiJ8hp6tXUqJMPT8C0Gl3vbMMyT6n98aJbPomuizGkaobPDVj?=
 =?us-ascii?Q?tKXT2DqYCpxXzAWzAYs8Dg3Aa1a2vUG0ScQh2to9Y7+oChDhw1anHzv5hHVh?=
 =?us-ascii?Q?cjjpfqBQYBlnQy4p5psi1VuflYOa/kUoSCiogv8X84o7ci/t+byGgjAeUdfO?=
 =?us-ascii?Q?lgbpEm9URWw6fZPQjWyTY4SrdjFcQYt5WE8gRWh9jjqGjsGQtfNZevA9nREQ?=
 =?us-ascii?Q?FWX32YFfqHco6XIEYbE5zdrKmJk1fpa6YqcdaVOTXqaECU3FL7jENfsj5fc8?=
 =?us-ascii?Q?whX8rcQrDab7oRf0wmYnF2jLNQdKCpBDovj2mz6U/5Vj0GJIpSHbjN0wxUHB?=
 =?us-ascii?Q?t3uOJygyKuLbWtJvmmadcx/U+tFs/cEBKObICdpI/VQuXdkFCEZGuHcc2rvO?=
 =?us-ascii?Q?K9Qo+KSBnfPvEunJVBQuIF3mZr92CFl2C8sKXxaBVo+Wq1B3pzrg5DE0OLGv?=
 =?us-ascii?Q?giJrr6XnUIkDEM833+26ccsZUzz7CgC6xRGNu6Uyd2RqKvs4pWqw3WLphsju?=
 =?us-ascii?Q?RjukoizGTGa56lemGVxGEDRN+5K0eum9VEjUUoX/MIxKNVdArx5MCUXPqzIL?=
 =?us-ascii?Q?M7B425RzS69tjIrFJyO83WdUHniEKDFQijSctGt4hcNtOflfKe1VTy7JqBiE?=
 =?us-ascii?Q?6Zh2kk6gHBfUGBBuDt4uKAEBq908cvyHk0jcBN8bk/m2WmTTf7CkNku0v1WV?=
 =?us-ascii?Q?dBob3Fu+erEyn3bUKCNg3WdY/ZoziXpINzaLhgPj6Yq2Mv/8MWw9gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 22:12:31.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c70ad5-9ed9-4e7d-027b-08dd926b4164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

V4: add read-back for non-DPG case. This is for protection
    purpose as it is not used for producton.

On VCN v4.0.5 there is a race condition where the WPTR is not
updated after starting from idle when doorbell is used. Adding
register read-back after written at function end is to ensure
all register writes are done before they can be used.

Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Cc: stable@vger.kernel.org

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ed00d35039c1..a09f9a2dd471 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1034,6 +1034,10 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
@@ -1216,6 +1220,10 @@ static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+
 	return 0;
 }
 
-- 
2.34.1


