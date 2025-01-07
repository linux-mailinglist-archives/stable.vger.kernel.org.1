Return-Path: <stable+bounces-107863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6020EA04479
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C481883354
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B241DFE00;
	Tue,  7 Jan 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IvEiJLt3"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E09195FEC
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263783; cv=fail; b=CBRdzFqj66KzkNXs1lpMy5ZODaYBvaNT9Y8sij/1ZFheIHMFNBGoG4xJnqdHOy7k0McowZaFNOaZbt9rJ1agUWR6urv/NkcK72HaQYym502otcP1xe4K8R7f/LG+Vss6HMLrQfZXOCRQJqkR/8j9fR9D/K8Hju61PxVMrxWPCDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263783; c=relaxed/simple;
	bh=pcFDd+NlQ0Fh3N5/EIJc7e0DUMse0QTCqsu8hanxT4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsUuW032hM9CDSRZBtCwc0W67tvPhEsYr92HZ5+ZZBL1y/l1n+zpXFzYsqWnj48F5r6SyMVdJLaWYhwzivzcefsnFNndVSGG6cv2IdbuSvtyFXw0IxDvlJKJVG9Qh9vAXRgHptFlq4VV3goK/mQSp2Op0kZvqcO481y6MPkoF3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IvEiJLt3; arc=fail smtp.client-ip=40.107.96.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4ail60gZ/OKbVBuvYe/ZMPodPOYtjLVoH7j3MyJd+raaq47ZnoYwMt9lmW7NKqiBhTA+ejTFC4AWz6ULVALn1TsKfZJ7G+vRunc3m8ZKK1yyjuIjZ4EPZOC3sBA2RHP0uUAZ+2AhGsNk0JE7GlWN3lv1lulk6zJO/B1gePlyGj3kOlYWfrn4Q+ZtMYfihO8xUJxQQPwI3GxmVzOfMCorcz68KbV5D4DHZQ8bafGL+xQy6wL/9yY/EUBtLYea95NF+j8W4NTHYyi5Cvl+G/pJS39MHPkqbQ0aF2ylhREXce1GpJFVeLesQp+CxgcjwR0yBydyLULcfuJpJW1Q2u88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyK4kMBpzQTB5/B2G+7v2/OoT0lC1B4pIZCcRtMUQyM=;
 b=YQqS13LqvPTRlBR7aheyiNp5dVqcAbmSH/+6eEZlSC/xzbl8rQnQL+k/DTIHOT0ZN3NwW+G35eIkPrr8UZefK+HfUU1yZVFV0fzgMOEFypALKSzFzqDdeH1QfeIBrz0q6QVJa8uu/kFjGEQnD8SHfrpiHsqLQRpEzVFPa3XnwAL5gwK+AxgpoGq8arfK9Me5yEP+8Y8QuqwyTCZfn03T7gEnhXmrsGj3ZGeznAr1PyGPz8UDYQsrzLJ93v7dPMVRMw/dhn/iElbheZdktO8qa+hJ6XhcnwqayBWFPcW4OzV/FZUlARyHcBs2zDYjOqZ64IjmlbB0vXbou6n+z1RHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyK4kMBpzQTB5/B2G+7v2/OoT0lC1B4pIZCcRtMUQyM=;
 b=IvEiJLt30hMeCXVBkKnvfO1IbHG6Pf5g5aWeZ/6LBTI6rRjsNdxULgTOwbE4HQlkcfPzQzWI3ybfRZGgrpNr4AsfgevudpoFUcEcCu9Mqf+V5x9iWZg3g+ROk/6nF80e4RCQuK93qnLFZCaqN8qJGJQmcfoeUq6AAw5KlYOYolQ=
Received: from SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::28)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 15:29:37 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5f) by SA1P222CA0072.outlook.office365.com
 (2603:10b6:806:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 15:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:35 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:29:26 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
	<aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
	<wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
	<jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
	<Wayne.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 07/24] drm/amd/display: Validate mdoe under MST LCT=1 case as well
Date: Tue, 7 Jan 2025 23:28:38 +0800
Message-ID: <20250107152855.2953302-8-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
References: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 080511bc-3c98-4599-17f6-08dd2f301820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IAykNjtzP9P0yvm3ubAHist04bXTVuWdwd7S9uK3WlKrxkw84Uzlirbf0kjo?=
 =?us-ascii?Q?QYXV2hv2aS7VBQ/mJzrYiDJRH+r4zeMl0UzIY7tizVx/C4YSi+WnoXztxsFO?=
 =?us-ascii?Q?uCOrq4ko2T0ryx6Epw5q+KebKQbCCdtqqMdOAIlhpA9wF8KcjgZ4GMNdkLhP?=
 =?us-ascii?Q?8GKItHpG02j08UvEZNBQMHUyXoiFBswu25gNIZC42i5N28ajcwA9sWKtjJBy?=
 =?us-ascii?Q?VaPtz8bEQoqvuiPmebMHKLZWtWhVyzNec+AprR4GP7PtH+hS/4oBWnMwBk4B?=
 =?us-ascii?Q?ugXsZGKXOP4PYwpNcXvKaj0v1x+ueAj6qtyVKAImoVodKGPdnsMXAs7zpnCY?=
 =?us-ascii?Q?cqFsC8ggBWtu9v0fPZs0fNejB5g4PzE+GmdrRbrSokyZFMoEtAQtZ7NUlVAa?=
 =?us-ascii?Q?YRC4hB6OZjewP96YRIdWZn3xzNQ6LlwVYrnvY92onZlTCNeTZVnhsW0FRMUC?=
 =?us-ascii?Q?NX1V+puqvjucwQYzs40ZebWvJw6C0uux3+Ig4xIBOROPvaZP7QJmLDAE8/WV?=
 =?us-ascii?Q?qEOAfIZgcvIyIZbRAiykL6IPPSIeGrbEHBStvR/xBVSpRKDXuDTeoTSGCt1T?=
 =?us-ascii?Q?Y9DYn4z1epxGxSQh8XlOm/hloWFpTqM8ORh3wgwba70ea2MtILXrBbqL/9nf?=
 =?us-ascii?Q?xz6nfBApbftC/+6xNAODrIsWc2K0aBeXsLT+wvT5fMxxFebdnQt5Y+DDzkaP?=
 =?us-ascii?Q?SAITo3dJwy9HeY5DzQZ5MkfP4Y9/ZUUg1aJBK9q0s9+6YP2tRpp+9HOzkIKk?=
 =?us-ascii?Q?by++6KKits8r/6VodIZceu/FDPYmTJl0oM1B9ws7y/mGdoaBlQf8s/xH+w7R?=
 =?us-ascii?Q?yi3XqHf1ylhQwp9AZN/m9OzthNfm+Y1K9L1NbavRA+8Xnxa3nKWlF2Xskozy?=
 =?us-ascii?Q?x6dqXgcE0suSdlS9oejDIvp3SF/1583v1B3La6pES8qfK0eq+fDSnNAOra+u?=
 =?us-ascii?Q?gafTvlepHqS9IpWr5yXfT0I+x4+0URvZP2JHE1ic+dd+e60AjSoZpVpXmTmD?=
 =?us-ascii?Q?sGB7XkVJwe/CE93O/CcsJEKjVAgNIVGRRFrqd4AiSihwLNwKpZYWofXRq0h9?=
 =?us-ascii?Q?Ft606mGm3DLTwvNzqnfC4DH8T/B/buhQagtFrG2TWwGHAKED5tD2Elir8JsW?=
 =?us-ascii?Q?UXQtQoIHnB0WqR8WlIlvGZjCzXVNg4xSzD7wMDz5j6dT8mlT+wEGqYLul4kW?=
 =?us-ascii?Q?37qdExJrVuoqrUvSxk4o9vnKO1MerlBlna3Gqee22+oW8c/zjhUxxOsEbcPY?=
 =?us-ascii?Q?u/10Wo2r1IQSnoAW+ia4d5dQZUY4w4PGc1uztX56Iz2t+USV+gn/zdFRmDh5?=
 =?us-ascii?Q?yNcmAVkY6zIt3uCACUa3lMAXk772W2Zn4oYiPVpUXAHIyHXP8w0ej5JgNn7g?=
 =?us-ascii?Q?k/EbVOtpPkYImHYueiF3tDNFSHSz+xyAZty0PYrPDqt1H2l2HBx5eUiPtsJR?=
 =?us-ascii?Q?VqtXUf1VToQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:36.5389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080511bc-3c98-4599-17f6-08dd2f301820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Currently in dm_dp_mst_is_port_support_mode(), when valdidating mode
under dsc decoding at the last DP link config, we only validate the
case when there is an UFP. However, if the MSTB LCT=1, there is no
UFP.

Under this case, use root_link_bw_in_kbps as the available bw to
compare.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3720
Fixes: fa57924c76d9 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index ca864f71ae66..a504aa1243e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1835,11 +1835,15 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 			if (immediate_upstream_port) {
 				virtual_channel_bw_in_kbps = kbps_from_pbn(immediate_upstream_port->full_pbn);
 				virtual_channel_bw_in_kbps = min(root_link_bw_in_kbps, virtual_channel_bw_in_kbps);
-				if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
-					DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
-							 "Max dsc compression can't fit into MST available bw\n");
-					return DC_FAIL_BANDWIDTH_VALIDATE;
-				}
+			} else {
+				/* For topology LCT 1 case - only one mstb*/
+				virtual_channel_bw_in_kbps = root_link_bw_in_kbps;
+			}
+
+			if (bw_range.min_kbps > virtual_channel_bw_in_kbps) {
+				DRM_DEBUG_DRIVER("MST_DSC dsc decode at last link."
+						 "Max dsc compression can't fit into MST available bw\n");
+				return DC_FAIL_BANDWIDTH_VALIDATE;
 			}
 		}
 
-- 
2.34.1


