Return-Path: <stable+bounces-120400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE1A4F65A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 06:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AE7188D31E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDE1C6FF9;
	Wed,  5 Mar 2025 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riviJQrO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155744A06
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151692; cv=fail; b=lWIaVx9bqpUrWxcf2MArQ0DhMO7j+H1MuDtj61PGxjzzpGHxXa+e4LHUTqjW1d4QsFKsLQv90S0vXONTFHuUZts8rAnegNCV58xw54KhDEtZfOQ0kQGhhuJYOBSi9UEz2eVUG+0pGc75GEt+/deydUXXDeNyl1kD0DjyZ83+lGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151692; c=relaxed/simple;
	bh=+Mzy1iIun6JUsqH1UkKgRO2GDRQJZrXDuAMj0AAWJiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGJdI6ItFhiKp8m9HM/GYkMMhIWUItMazVumA8CmELPgw+APjA6I8cPvbIKfErJvjlYLuC1RH8if+Q2aqhbNxUfe4IL+RM9nBDAUAZett2qDHkbgicascNXeZu//CCLSPVr3nAVC+aH3D8R2SviMLVR0y7DuQlFYDYnSUVoSyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riviJQrO; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFdVfzM8Eev5aCFd4YZMUfGtN+JGPMI46dThg92DrCOUpL66V3bq2Zf9+ffFv9z6OoewKEjcPYY1xfV/Q0IVjyNpQin14cxa7/erX4Q32lLRuHNInuSELO8uuXurRaLJAkBNfFvfM5nCEpskit1jePEykmqbs35om8ISTeDLAGg1PdfvaF489oVc/WnIwM07w9sf73fVXZvUXHeznP9l3hPpkZd/8OkdyvscNZxetRVCQIqZDOqsGftKEkXvPfiaUE8PMd/Gbz/pGDTDUdkRQvJc/RLMNrU94MFgZERP9sQplIedMNzHPdQD0EaGutnI1ZQwD1TMgp78Jqw6HWrB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrE0NmJQxMPEeRKhUlbzxYeKnCqD6NBt/msUVq7QzHY=;
 b=faTVgdgfudyPxM76tvk3B0dwEHmyx56KxBTuGrqlbpuw6v8xLzQXo5h1o16Se0rOO7LPkrSjMC/1dI/KbQYos/pRbUOUwcXqEGa1gSEx7SH1VqYnZJPoo9TvikvNxAi3q3VxKSmZSEki6RT2O9QTiWP+NNLuXHUoZIY0UBwgweX5zsXhm5CmvNY/R+w5ZYgT/h38Eu5YeblW4EINpOaSbGSNxkLGzMpN1H5bgaq8tWwS/3cGg/btAW8GBFMoPYJcNIk1YKYn7LztLZLhFcVCWFt5iJdR21MLJvCb7U1i+lGfmr9Kp+9xj/cvaegK43JNnMa7QLI/Abynq27gPAkbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrE0NmJQxMPEeRKhUlbzxYeKnCqD6NBt/msUVq7QzHY=;
 b=riviJQrO69UOxXeycEYnSOcM9ZKA2BGB3OJzUeKXw6dEh1MysQK3p8+hPv/s2hhl3coHtf78IMhq9pWnFmztPA0EF8LH7AE5k5feG3lypTM1D9Hi2FuiDyY39WaAAmyov5qTf5+El973BPDs3itqBz/hXJ9YGte/4i6hSbKyaTQ=
Received: from MN2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:208:1a0::23)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:14:44 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::bc) by MN2PR07CA0013.outlook.office365.com
 (2603:10b6:208:1a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 05:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:14:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:14:25 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:14:21 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
	<solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
	<alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 02/22] drm/amd/display: Disable unneeded hpd interrupts during dm_init
Date: Wed, 5 Mar 2025 13:13:42 +0800
Message-ID: <20250305051402.1550046-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 43aaceba-4afb-42c0-ab4b-08dd5ba4a3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iusFTLXWmDxeVA8ES0Vika5WpuktxPIh4vebrjpB7JO3qDRwo4y7uDIDpCB?=
 =?us-ascii?Q?Cclt4SDgeYXlTxFMxa7MjrG+OAVIXVC0O61KxqjqleePTkas/KWBD8tBmNon?=
 =?us-ascii?Q?t9HU+94oC6F2GtWO2e/kyXq0SmYRw47za0q6UrqU5+7UfQVGpjrLqYGcww4R?=
 =?us-ascii?Q?sMWcgFejPd4pNkZes8/E9zdx9P2bEtmMeYk5+zXA34Sm/aDr/XhwQo5RTy2j?=
 =?us-ascii?Q?j4Orfnrg0zt2gF+Cx9R7BE/CwzVml/bFtMhJ8josvvvAsM3LpoR6zGAbdDWR?=
 =?us-ascii?Q?/E+PPiGXPYfYVNY8nExdWFEDENeIgNRDAiGZq+P94CfALD4pvTuugEXSfHCQ?=
 =?us-ascii?Q?oSYvQvCtc05jmnTYUjjC5sVSfFIAgvcZ5bgU59Zmj/2/CYEEUGnBUTBvbq3+?=
 =?us-ascii?Q?OhQeHxiFu4tygSzDMeyJOevk2enWnQ1o2QJVHsj5A+YtppAvBpD6GAbWqwIs?=
 =?us-ascii?Q?gzvi0Xb8Nlk1CiDfevuXfGuEzNopSg3Bx6AzB0s4kmNeYIEQY7RBCVwz2nn3?=
 =?us-ascii?Q?aIgmhLBGuCaiSyEQe5wpW8qexzRRHa3NsbFxZMjCktmu/kLSPUzcFc/1aXuj?=
 =?us-ascii?Q?UTQdGVztvYotad+3YV7sWs6SGLqsFqUHKychDwehioy/lPZQFv6PEDlheFEO?=
 =?us-ascii?Q?Te8ocCtxOMHJ6lBQgbIGAXQn9GQIik7GBCosht6ofVeUEL2duvai4/LFMK8X?=
 =?us-ascii?Q?cNfUdkNM5QcPcoP0I2YBIErl0LR1JJTkNUR6rwEugAU0Bh2a/6NVhid4JH8D?=
 =?us-ascii?Q?n1jzn7lP6QYGV2CG2056xtcdGLF1VbMiwOVN0mVa8U+j5qy5VHGWQnAE7ajV?=
 =?us-ascii?Q?IrCGsF01HiVNdHhWypZmV45naXxMGPG4MCgWjzOm3lo5OlgREbEmIR23FeHq?=
 =?us-ascii?Q?qdsy7Rj/Z1aaRGvsrUqgaVZQne7sxzBWdovCh0+KIjoZtENlNKCuHXDgHV+4?=
 =?us-ascii?Q?E0N70S7olXOvJ6uUjCAPPFEDIf2aB41vnEZiF4yPFbdUDgVJt2XjJbl/82M5?=
 =?us-ascii?Q?ccY9Ze4OR1bhdTDVKwPZMxo+xn0U5L7BPip6Ngi4iM0Wmt/SA731sAW8Ijr4?=
 =?us-ascii?Q?majA6ocdWOxu4qvkpt+QAyf+cua6WDt6ldILks2JuTdDavkrXv/pwWpKrNkU?=
 =?us-ascii?Q?T3MSrd7PyUdx+wn6Mm/tfDNHIGJdo2NKGnoNy1i4tVc+qsj7pyIvgk7vAeTB?=
 =?us-ascii?Q?zpQ14ihld0WIQMnk7xXFlvN9JxARVaENOoxPA66WQd45CK4G+DxDNxEjpmFT?=
 =?us-ascii?Q?r9ZYDVZex72cpVuC/FeJaYXfxquQfC6itItsoc4G6ehcLl+gnM51rWIY6FYR?=
 =?us-ascii?Q?T4geKG6pqx9jAVne80+mnndvCKKtyjOwNFJqAUhITcRsmZ5+S2TDEFZDcNfy?=
 =?us-ascii?Q?Y8f6FZNrkHVT0k9fWVbjmjZvGaTGdWNdf6iC8V2RR3tNPXd4DNNSw0ofIW9V?=
 =?us-ascii?Q?VEJUCdHBA3NFFVVyQ4RGlYdygSktRO7XgkHsyAAraZZM3+RNgmborN37jV4o?=
 =?us-ascii?Q?FQOyv0P8YQk0Foc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:14:43.9101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aaceba-4afb-42c0-ab4b-08dd5ba4a3ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

From: Leo Li <sunpeng.li@amd.com>

[Why]

It seems HPD interrupts are enabled by default for all connectors, even
if the hpd source isn't valid. An eDP for example, does not have a valid
hpd source (but does have a valid hpdrx source; see construct_phy()).
Thus, eDPs should have their hpd interrupt disabled.

In the past, this wasn't really an issue. Although the driver gets
interrupted, then acks by writing to hw registers, there weren't any
subscribed handlers that did anything meaningful (see
register_hpd_handlers()).

But things changed with the introduction of IPS. s2idle requires that
the driver allows IPS for DMUB fw to put hw to sleep. Since register
access requires hw to be awake, the driver will block IPS entry to do
so. And no IPS means no hw sleep during s2idle.

This was the observation on DCN35 systems with an eDP. During suspend,
the eDP toggled its hpd pin as part of the panel power down sequence.
The driver was then interrupted, and acked by writing to registers,
blocking IPS entry.

[How]

Since DC marks eDP connections as having invalid hpd sources (see
construct_phy()), DM should disable them at the hw level. Do so in
amdgpu_dm_hpd_init() by disabling all hpd ints first, then selectively
enabling ones for connectors that have valid hpd sources.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 64 +++++++++++++------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 2b63cbab0e87..b61e210f6246 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -890,8 +890,16 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int irq_type;
 	int i;
 
+	/* First, clear all hpd and hpdrx interrupts */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
+		if (!dc_interrupt_set(adev->dm.dc, i, false))
+			drm_err(dev, "Failed to clear hpd(rx) source=%d on init\n",
+				i);
+	}
+
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
@@ -904,10 +912,31 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 
 		dc_link = amdgpu_dm_connector->dc_link;
 
+		/*
+		 * Get a base driver irq reference for hpd ints for the lifetime
+		 * of dm. Note that only hpd interrupt types are registered with
+		 * base driver; hpd_rx types aren't. IOW, amdgpu_irq_get/put on
+		 * hpd_rx isn't available. DM currently controls hpd_rx
+		 * explicitly with dc_interrupt_set()
+		 */
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd,
-					true);
+			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
+			/*
+			 * TODO: There's a mismatch between mode_info.num_hpd
+			 * and what bios reports as the # of connectors with hpd
+			 * sources. Since the # of hpd source types registered
+			 * with base driver == mode_info.num_hpd, we have to
+			 * fallback to dc_interrupt_set for the remaining types.
+			 */
+			if (irq_type < adev->mode_info.num_hpd) {
+				if (amdgpu_irq_get(adev, &adev->hpd_irq, irq_type))
+					drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n",
+						dc_link->irq_source_hpd);
+			} else {
+				dc_interrupt_set(adev->dm.dc,
+						 dc_link->irq_source_hpd,
+						 true);
+			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
@@ -917,12 +946,6 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	/* Update reference counts for HPDs */
-	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
-		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
-			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
-	}
 }
 
 /**
@@ -938,7 +961,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
-	int i;
+	int irq_type;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -952,9 +975,18 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		dc_link = amdgpu_dm_connector->dc_link;
 
 		if (dc_link->irq_source_hpd != DC_IRQ_SOURCE_INVALID) {
-			dc_interrupt_set(adev->dm.dc,
-					dc_link->irq_source_hpd,
-					false);
+			irq_type = dc_link->irq_source_hpd - DC_IRQ_SOURCE_HPD1;
+
+			/* TODO: See same TODO in amdgpu_dm_hpd_init() */
+			if (irq_type < adev->mode_info.num_hpd) {
+				if (amdgpu_irq_put(adev, &adev->hpd_irq, irq_type))
+					drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n",
+						dc_link->irq_source_hpd);
+			} else {
+				dc_interrupt_set(adev->dm.dc,
+						 dc_link->irq_source_hpd,
+						 false);
+			}
 		}
 
 		if (dc_link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID) {
@@ -964,10 +996,4 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-
-	/* Update reference counts for HPDs */
-	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
-		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
-			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
-	}
 }
-- 
2.34.1


