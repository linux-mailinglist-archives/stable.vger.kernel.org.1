Return-Path: <stable+bounces-54736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9188910B93
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0762873D7
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E81B14E4;
	Thu, 20 Jun 2024 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tXzcwzT5"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA4F1B14FF
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900012; cv=fail; b=K0E+09djC0cRe+024DYNNx+y6rKRxKydGtEzB2E4Aiy9YTCPLBOSxgZ3YgiA2gpQ3vQhS6LZKSMJcqYlDxcoVy0uAEoc7ZHNPNJxkFz+Gd0tWHz3WoTj4whIEgJBrZj6lR7RVSUYJ+UxSn4hCX/UatB7ruVkbb2R/P4ZDoKtuxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900012; c=relaxed/simple;
	bh=K5qPSwdcIqtuc1WHCqYigt9izLKoSdq85Jq89Cr5xGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slm59KXWta2u++mQ2P2QM6YiqjKyn9WnxnY83h7xQ/I/mvel1ZLYS01AzpU6wme3N9I8bciEpr2DW29xtR+kbqDvLWsLmYmJ+rc18Ukw6jcAG6hqvzDxJOET5RFqQDyO+KCStfFv0EgJuH/3HXZGB49b4DqmwWrsuwBk0CYPxYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tXzcwzT5; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE8cdptO/bX/VuiiEgcWFFNrvg+H53arFpW5rgI3mxOHjXlazTLyKwgY51UHkqO2rOuHraZ0UYNZBFI53ii8c7+5uIOcsaCOKCaeapzygwmDTbK5MQWQYIhb0mRyr0qi00fiL6Swdh7HtWvptLsNyLtc8kuFaqIu4Tzowx7UQdXs9aqe7XMTAAVadTtGcmjLWgqENbLJ6vXmRsc7ss9l/DvQVxinTZDdaglIwz0e48P+JiH0CN0Bd6q8PZiE/puhaFbg59mIs33Cz3ravAj4itHEvf+HTQSo/3gY+Kqby4N5OtAxA4NeWn59h/PsoN8NVuubZgarETJ0+ocGzRmr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAdHIv+o0bJhUA18Qw6sqkMiprPPc1UYS7J4u5hr2Ho=;
 b=XAflgLuXdChl2rYj86u4pp3EFsyLMgicC1xq/PwdZh0wMq6+rfpnOUZhfth75NZpRlmQDt/k7qQgHb6eosR5yrs1bu59JL0xx34Unr8g6+FEZT6yxI1501Zw2UUKPCeWwuuX8m3NbFyVmACKuAZAlhlTU2IZYmKEF+AULgcHCljqik/IEeKUJVvnsJfXb6IujlNrv93T7UXjO+tGMH0qkz5ynI0XMJWLyVsAKAaUoIFwJmeMEpURmSAglUgqaVeD0/Wdb8dGMppY+cxAQg/PQ1MZKM3mwSKtqNGYgjUdnsPZuK6ZXdM42uuTGNvkzO2JVHcvG1LuCJs70SgRe62IHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAdHIv+o0bJhUA18Qw6sqkMiprPPc1UYS7J4u5hr2Ho=;
 b=tXzcwzT5eG5natDV0h5CZ0n6/0e8C2VxH92Otyl2GukF78PnYgE9lkBfKT0CYV8fLSnAQgEkIW/1o59bGInK46hZHAam45oJB+J28wX1IC69qUm4+y4NCVP7QhEbDm0UkBLsydsZU062ch/YohKM4+/ruIn4E9NuDo68pky6qMM=
Received: from SN6PR04CA0096.namprd04.prod.outlook.com (2603:10b6:805:f2::37)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 16:13:27 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ac) by SN6PR04CA0096.outlook.office365.com
 (2603:10b6:805:f2::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 16:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:13:27 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:13:24 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
	<jerry.zuo@amd.com>, Michael Strauss <michael.strauss@amd.com>, Wenjing Liu
	<wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 06/39] drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if LTTPR is present
Date: Thu, 20 Jun 2024 10:11:12 -0600
Message-ID: <20240620161145.2489774-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: b386ec6f-eec5-4948-f6e3-08dc9143eb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|376011|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpmEU9jDoP+7cDE9g6iAQU50A0Z2Yn0AhPvXyx4dz1eFgyrp/mM4sRJ/R6Id?=
 =?us-ascii?Q?CiBnPD4tR2DiAI3aWb80F3BYKf7MIQcNfd8UvuMvCeVa/s+WGvuZk/KGW4q+?=
 =?us-ascii?Q?r/jcgIp0JoqWU0K3uv6+rCBOPWmgATVynkhgQ5PakiP/MzgwpNH5Lk/iqWQ1?=
 =?us-ascii?Q?jKLErIZ6VzVdpbVjS+rpg3q5b9qwLnMvlgWKlhgOwFVaHPCkYuR7zqCW+aCQ?=
 =?us-ascii?Q?Z5pnwrvTC0Sih7MLN9rNf2nMH1DjubN/Vt9bZ+1Fj8ro8rxhliJhA0fC2xSg?=
 =?us-ascii?Q?iUofn/veC1CyLOgQTnX1iWfIEhQ/DLKu0lXpw/tvUK1EImq4I1PpGXa17rKC?=
 =?us-ascii?Q?O9rHe+auqAHCMgNxMT1u7qz8GH05zXsXfqeuHBmvo+FL3jDEf20yWvoIrfbQ?=
 =?us-ascii?Q?+WonHznof3bUxTJKF/4kRZ9QyMbgbU51yFvNhXFalBbdSKBUoZop9yAScoA8?=
 =?us-ascii?Q?lIjocCleBtfXUbaHRrcMsyexPHgkXcN+PtvtLydaTiPUek8jmS5TjZ+QmKoB?=
 =?us-ascii?Q?8mhAQrt6pC4lelhAaaSCgjawMajTTaBt9WXq/lArtQmEaHFkG34BSG+l/Voa?=
 =?us-ascii?Q?M9+mlKMKhjvxzpehlYCJ9ND54eKjMHhtCsTTT6WgC7rViRFkwVWMh4pemxOE?=
 =?us-ascii?Q?1Dtafy4f54fnuLM7I385yK6pmelI3od6RoSZ8A8ln4UZXSV6stdTVCiyVBTL?=
 =?us-ascii?Q?7ixZe7ft/7+H2wdxjLQ1z30gMF2ZJTFCncx1flUSy6rAqn7mZey20DzLTogR?=
 =?us-ascii?Q?tLEs9qr58IZOc3HBwiGM1VkSV1/xtFilA9b3xREgKdQemBR+AlAxlJSwYo7i?=
 =?us-ascii?Q?2GH1dZP7vBO5q+ZW1sYXr3XWQlyVcOGF2bkglKJo/pO9XipSqQjtfBuBQaKr?=
 =?us-ascii?Q?BQI5FNw47jpSRUJgEUpy8XthNNIl0/fos8ABpA7BXiHe0CuZuC0NM0uxOK5d?=
 =?us-ascii?Q?zpExRKEQIj8esJQnJYiOjr8dx1gO9LaYLQyMkTlrVljH7J7R/MZORVdlTJrc?=
 =?us-ascii?Q?XvWeb9UMwT/ptqDuk2hTPxr5WeFGf8nkrUoZuzBmLwKqrjvjSvysbLBZA80x?=
 =?us-ascii?Q?n7kIl6o141KaM1BenIPAq6tedIDsEYbfBrFYtRMQv81NBl1KQvSw8uNG9zlL?=
 =?us-ascii?Q?7YErJSBBmq5j3uMkXmtMoVtV44ovYinCk/lB5w5/ebWmaiOA9KTu2+MncZPu?=
 =?us-ascii?Q?UWl9CKYOP8BW15Y/A9ABpZ078ef2zF9gGAmIXda4p1tR6k19Kbc/iPvDAbQB?=
 =?us-ascii?Q?++0XhEOE726OpW6VAEtFvbtLRynKefUHC5sJh5cc4yNBu6Lcnmp0HZdaaiZG?=
 =?us-ascii?Q?KUDUdgiNxxJQ77sNPnNTzL9+rPMzPHTLRpXDtyD2Rfx9+DDkoDS/N/mxQl0O?=
 =?us-ascii?Q?Y7M/a18kwQQgh6zSj3FZWNnrRmHkTy1TwUeHnq9ucuEKvI728A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(376011)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:13:27.4242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b386ec6f-eec5-4948-f6e3-08dc9143eb3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
New register field added in DP2.1 SCR, needed for auxless ALPM

[HOW]
Echo value read from 0xF0007 back to sink

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../amd/display/dc/link/protocols/link_dp_capability.c | 10 +++++++++-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h        |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 00974c50e11f..f1cac74dd7f7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -1605,9 +1605,17 @@ static bool retrieve_link_cap(struct dc_link *link)
 			return false;
 	}
 
-	if (dp_is_lttpr_present(link))
+	if (dp_is_lttpr_present(link)) {
 		configure_lttpr_mode_transparent(link);
 
+		// Echo TOTAL_LTTPR_CNT back downstream
+		core_link_write_dpcd(
+				link,
+				DP_TOTAL_LTTPR_CNT,
+				&link->dpcd_caps.lttpr_caps.phy_repeater_cnt,
+				sizeof(link->dpcd_caps.lttpr_caps.phy_repeater_cnt));
+	}
+
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index 914f28e9f224..aee5170f5fb2 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -177,4 +177,9 @@ enum dpcd_psr_sink_states {
 #define DP_SINK_PR_PIXEL_DEVIATION_PER_LINE     0x379
 #define DP_SINK_PR_MAX_NUMBER_OF_DEVIATION_LINE 0x37A
 
+/* Remove once drm_dp_helper.h is updated upstream */
+#ifndef DP_TOTAL_LTTPR_CNT
+#define DP_TOTAL_LTTPR_CNT                                  0xF000A /* 2.1 */
+#endif
+
 #endif /* __DAL_DPCD_DEFS_H__ */
-- 
2.34.1


