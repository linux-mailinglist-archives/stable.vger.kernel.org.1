Return-Path: <stable+bounces-10463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4C82A3AA
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8B4289CC1
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3B4F61E;
	Wed, 10 Jan 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KELKhpYx"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F98482E4
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMp4145+2cBan4H4m7exhF0MRHw76bBWQsDrAHa8igt15N+ipQU5mArUZwdVfWjMxD2iCXCzn5qPq/0zJX1fepPmYDAm/2tv5dKmAStRPcqHJ9mV0++pwxOpukwyzTMEey8E2EFhXe9GeNIzqDqH0RiD+ojJ05LkY5JIgY8FUzbjYrilEHb3ciOPoB/8obooHSks9QEYZmgWTqtXXZh6rgEfaonWMfZ7dnUVQy6l4LAEFwBf/fknEE4XzNFjT0gINGURK87PlkLOR4gkbWj1zsfpH7Yo42xKu/wOygtuT4CGsEM+zOBgo0B5VbY7f0JmS3Niw7Y9oWrLzuJehU75Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/vIuXJUIFfH8WogDXbhAIIZdbwRvR8Reoe1LkNk+KY=;
 b=daMWVD4SEsU6KpnCwij50Ccq07R4j6YU0NeyPE0wsPwlLdSc+/mw0OzsgEgDtw6gTifEpxuz2ShRSSkkAIvRlwVyHCdDGy2sO0O5J5DM+ZJjYw3Gvns+mN//KT5fOLIBApIupKRy7b0h6Au2O4DK9sPCGTtjaz/RWOTZqpXRSlvylsrdTH0HKBWiFRkHnHRqy3pwKc59xOTrJUpZ6+9Ep1lJ/NVTnm0el9xQ4SMLGPK1YxLDlJauzOcqi4BvdBwmYlHkGkSjdnW1x8DG2xwWaRX8i8sQ7IzPE8FaBzwixg+6ZLD/fZnfBWWUq53J6YiOpir4ans0nYncu61JgfKBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/vIuXJUIFfH8WogDXbhAIIZdbwRvR8Reoe1LkNk+KY=;
 b=KELKhpYxvsP097YBa5tQDXDFPCSaRvLp835Gk6bQqOf4Ny1oo13Pmhy3UV2fDZTZK9e5/HpRs0MBPJcoL08xXDwdU3VM9Lpi9dQ3dKSZpucJ7Xrk4P8JdVq+Rj7xTosEOBIqzwXql4qu/LACnBp/+YwMzozVKCsGCX/5JNFy8IA=
Received: from BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::30)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 21:55:28 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::7a) by BL1P223CA0025.outlook.office365.com
 (2603:10b6:208:2c4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24 via Frontend
 Transport; Wed, 10 Jan 2024 21:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:55:27 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:55:14 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
	<Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
	<wayne.lin@amd.com>, <stylon.wang@amd.com>, <agustin.gutierrez@amd.com>,
	<chiahsuan.chung@amd.com>, <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, "Ilya
 Bakoulin" <ilya.bakoulin@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>, Alex Hung
	<alex.hung@amd.com>
Subject: [PATCH 07/19] drm/amd/display: Clear OPTC mem select on disable
Date: Wed, 10 Jan 2024 14:52:50 -0700
Message-ID: <20240110215302.2116049-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: da31a593-75a2-4a81-2ef0-08dc1226db65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WHncJltTzg9mp2QmchVeJPCZkHQSNhYpYpVnSiOSRP9feIXhxmKBbfidCh43sw/ZFAHshsRzR8Vbx6aFFV1ekYA9mRmUZdX98TLyrYzlmaA6bpis+5xWNem7g32yvinoSV3geYQwZkb+Hobli4ysN9H1CLhzecQJtfSwwv2D4EYD6KGbK5ccYeJRcYUPZifgB3GKA6kG+uUmsZsm3CnQQoIhtkkyY4SYfY3YYbpLByK29aU6U/lD2jk8jM0KNcnI37UWw4L8BZ44bkGq9RV2kI4yZMpxM/uH1oCwNV/6MX83yFca57fy7IgWEqr+c5fkgs+o3x37Qy07J3r6/Ew7VxsAWcnn3UiW2TIcbPXZrCVMAbfN8TttvbvPokMn6+zARse8SZE8qqfM0PylKB2VjiZ6bY4meiPfPbQ6edcJX1IhCKr9yZjKMvgatl+1jO5WY90MVdIaA1WP2z6tTZ+llDC2Oxk1LP54VZDws0yrLExxlz1d06BCoKhMIv0i75R3v+8HlRRmmBx477QA8DSncKwETpsHGTlZXKY4IwjMhbl2HBIk3MTi8xGQytS2tpIh+eYv6qoC2TjWeXwjPESDBSh4A10xMVE5DQXCVtTDgrRdq4ScCJSrxofbWaaa9zARoHnQWUfJk34PNmkCuI6JdiiULLCq3IcbB1zPFMW2acSK258k6U1JOuAWwLuU9b9xtCVNW0nZ3UxXprrc7vd4BIpn3fiobg07Iiz9Mpg2MK5Lg55fy240iG59bi4b1f9hR5tF4mCyZNllUJFmDGQaKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(40480700001)(40460700003)(16526019)(44832011)(4326008)(8676002)(8936002)(54906003)(47076005)(6916009)(70206006)(70586007)(316002)(82740400003)(36756003)(36860700001)(336012)(1076003)(2616005)(426003)(26005)(81166007)(356005)(7696005)(6666004)(86362001)(2906002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:55:27.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da31a593-75a2-4a81-2ef0-08dc1226db65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
Not clearing the memory select bits prior to OPTC disable can cause DSC
corruption issues when attempting to reuse a memory instance for another
OPTC that enables ODM.

[How]
Clear the memory select bits prior to disabling an OPTC.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c | 3 +++
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 1788eb29474b..823493543325 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -173,6 +173,9 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 3d6c1b2c2b4d..5b1547508850 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -145,6 +145,9 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
-- 
2.34.1


