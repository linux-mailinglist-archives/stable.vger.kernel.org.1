Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069C37E5E1E
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjKHTEl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjKHTEZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:04:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8142735
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:02:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGnE/iYv0vnApmCDSyyOHBMKujfINrCa3YPplvUF+1EIcgCSQ3hlXGZ3PRmerMr3YteMEVmCo63WNVTZhJqLk926S8YbJuXdhtxfKGlVSXSCp3f4wd9MmbbQZQTtNGI83ZD/6CPqsFsSpAYjyW3Iq0KH17ptZZfynm50ujr9NWqjjfsClZBWgwaszQETCnhJ8GckYhBvcTS8AM/2y3mUm6cPNYDKbf40tcDxoJDNDoXZ+sXS+DELyL9ZTIZ91xEXJ9X7Mew7ky8bMBtdvoQ9QM8rDhVI7rUIHPdLVIv4XG/MGdffpSecAvLd2h8aYEW4k6qZF5umBqUz4pOKkopf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8UITPErEKL7A5dUZOvlV3pHkaeIKg74YphxHHNsDbg=;
 b=TF9ur/OHL54u+oknMxG1FbOoKkX7pnsNaqxW/kjviJN8pFvjQx08xletmN2aXLoZNAyBepyCtNgcQQM6si8u5o5uqLMju66uPJY1J7ti/tPifpnvjv2GjAQauqakbQ5PcDCi4/ccWu2kpS2imXdc2ER4Xrv0HCHMzfXHxpRPvIFgcIJfg0T7uuBbbuwI+6VspTDHuszVY+UKa5l1uZ+J3ONl+uYg//M1Ks2+HY4XfYeC+K9PFZaGye2bvI8/5BTo1LtjNOoSx15oAq+JtCpvDHethmdLe2oEOVp+Ex3Vxx8JgWWoPqKunOR7pWt2dhtuyy+3xNd1+RCc+5PTZOQtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8UITPErEKL7A5dUZOvlV3pHkaeIKg74YphxHHNsDbg=;
 b=gGsTCYsZrhz1hw+olFsImzwMV4e9Barw6GYzExD3WoyUZk1+y6DKX1fK8aK7A6t1pLqeg1djkIDx2k1k54u+vvMpXwOmk5jUrbuA47VsHUMtmsigPcMsItNjNEkMsF5lqFvYD7kek11klz8BqXZkDna8t6JsRtYeS06F6gh6IK0=
Received: from MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:02:16 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::e3) by MN2PR06CA0002.outlook.office365.com
 (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:02:16 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:02:11 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Hansen Dsouza <hansen.dsouza@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 03/20] drm/amd/display: Guard against invalid RPTR/WPTR being set
Date:   Wed, 8 Nov 2023 11:44:18 -0700
Message-ID: <20231108185501.45359-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 610cf2c3-e686-44f8-b551-08dbe08d3968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqaNiq5UMSaqcKZBsBgf4vMsMm+PqWudouDq6Hq5pYd7mtpG0JYzh366e7Fj62ckWRzWimg/LyJXuiV/oBegD6d6KilcmVt4+wknKLbBNjv54ax+KQ0P/MJGxIWqHH9f7wACN0uzAyjMxExrXtvkczuvhERC/4jvbJyxXhbBr+ssHNMLO6JJgXD+DKcBNIt3UcTWYMaPSV2ZL/xAUsDlHjw83VCuRIAotms5MnqUMqUOl7Z1TCI6KjtV/mVGNKfU7Fn7oHnpdp5TqUdc3rSkZuDr6Fn1kU6P07AdCXuqwQSRmie2ssWxnY4qSuj+l0pag1erJe1QNpfmeO5aqT+MaQ5sxBahGDhd/Rn5dRhzQjYctNpYvqqCf27FlaPhvctvf7cfCh3Zk8Xasc+DIrho4m0E9kpVnG/Gnt618GSjyU4O8Tn/IRp5M3taT0Cf8eErIXO33rDVCmEPMR/SRhj1ajtlMyjotkE5XM312w/GSoMNdGA1ETYp/JmBRALG/70/MqNLTkAAl7mV7piVdsEkpn13JqYONwCGOeDi2OwU/34zWp29r1ZXmqR0LIWGx3sshb9zQbiJhp2sH0bgcNRBpft/XArRqkOkcNChj+v5orRDSKDmYL32TAnvtyizycZqc2ZlOdMqzDhAP4iYYJXlrOeBD/U+wJjZHIM/rO5rKU4K7bAr6gbKNdnls4WEiQGDXyB3fI/kOYuwgpUI+59K/Omm1MWFDHchlEy+g5I43Qj2l5UBZMkiTBgo9N07fTH2Vj46PnlWOv0iWsSYsFV34w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(316002)(1076003)(16526019)(82740400003)(83380400001)(70586007)(2616005)(70206006)(336012)(26005)(40460700003)(7696005)(478600001)(426003)(6916009)(41300700001)(8676002)(4326008)(40480700001)(8936002)(86362001)(36860700001)(5660300002)(81166007)(44832011)(47076005)(2906002)(54906003)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:02:16.0762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610cf2c3-e686-44f8-b551-08dbe08d3968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[WHY]
HW can return invalid values on register read, guard against these being
set and causing us to access memory out of range and page fault.

[HOW]
Guard at sync_inbox1 and guard at pushing commands.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c    | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index e43e8d4bfe37..5d36f3e5dc2b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -707,9 +707,16 @@ enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub)
 		return DMUB_STATUS_INVALID;
 
 	if (dmub->hw_funcs.get_inbox1_rptr && dmub->hw_funcs.get_inbox1_wptr) {
-		dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
-		dmub->inbox1_rb.wrpt = dmub->hw_funcs.get_inbox1_wptr(dmub);
-		dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
+		uint32_t rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+		uint32_t wptr = dmub->hw_funcs.get_inbox1_wptr(dmub);
+
+		if (rptr > dmub->inbox1_rb.capacity || wptr > dmub->inbox1_rb.capacity) {
+			return DMUB_STATUS_HW_FAILURE;
+		} else {
+			dmub->inbox1_rb.rptr = rptr;
+			dmub->inbox1_rb.wrpt = wptr;
+			dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
+		}
 	}
 
 	return DMUB_STATUS_OK;
@@ -743,6 +750,11 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
+	if (dmub->inbox1_rb.rptr > dmub->inbox1_rb.capacity ||
+	    dmub->inbox1_rb.wrpt > dmub->inbox1_rb.capacity) {
+		return DMUB_STATUS_HW_FAILURE;
+	}
+
 	if (dmub_rb_push_front(&dmub->inbox1_rb, cmd))
 		return DMUB_STATUS_OK;
 
-- 
2.42.0

