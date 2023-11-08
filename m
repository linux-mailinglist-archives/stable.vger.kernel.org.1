Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DF27E5E29
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjKHTIG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHTIF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:08:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B2A210A
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABTYh5O8BH6tf7q9iG+1pxh6CA5FlXnK6g55OsV1CDKNpNsyZ932PCTa2pQtmibs/lbtl4AfqVnGBKnmGr3GBVcUdM+MTsTLOpB4wAn22rrsyXv/DVAj4Bt+4HUpCQ7kBBdnufxWhxJUwX/5EIdPpGcilWHSiw4p7aHNPjVnQAuhklVE/kg+kqRHV6wul81hPQq2/kqb8LzQ0lv0tlLSMOGMMpgkZM4mXlYQuzFpHmLcFS+9UKypQjKmx3EbSxEP1OF4x7FsMcvNIX+KQXgRf4bQ2yN28oN480gpq70mB+uQo09ppsvf+o8xt1s5Yn+qwk5KAxtRWSdi0HwcujkPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPMQkLKHwkxxhN17CgCaS1iCnyOUIsnm9zzE3+LX9A8=;
 b=Odg2l2RpRLpXUQMPXtZsZik3qoFkdTkJB42+GRBLH0UkGUubaftNIJYiEveLcn3VRHX73sbWH3ONY4QRJIvMuumHGZ/+2+Js4D8i8p/7GKSRpYhU8vivNdORbNgG85BmZEajHP0RFFSkNDtfsXnoIEZ1b0a8SMENGlVg7bXjd2u7CZoVh1J/bBTdBRcCvYAOGcbR2nIYbK/9vwmevatWnO36krpfqnChTk9xsEW94Y73teqx7/LFk3ZbvNa3VzCK/KP4SKJoS9C6tTEpv4JdD4Czy+0kZYTB1gFZc3NYa65A3xmEhXB3UBGm/7VI248lrU5vIjhO7jvLg8a7rpbVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPMQkLKHwkxxhN17CgCaS1iCnyOUIsnm9zzE3+LX9A8=;
 b=4f6p3mRDTZ9rRxE6f6/+i6ZoDZ9plJHpvfuPSzMRjDPMIXkSHwA6Rq1P3yLRKvlL5CrQTyPRkD4WFkNw9HTrMNcN9AFwqDiPfJvU/WRSrFI+wrASVjZyDzGcBLsC0UGyOd5ShJE6CCf0abqWrTlq4KP65DavJcdf5WlU5rh2+wQ=
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:08:00 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::1a) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:07:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:07:54 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Duncan Ma" <duncan.ma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>, Charlene Liu <charlene.liu@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 12/20] drm/amd/display: Negate IPS allow and commit bits
Date:   Wed, 8 Nov 2023 11:44:27 -0700
Message-ID: <20231108185501.45359-13-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1809b302-3210-48b8-df10-08dbe08e0648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qa2TvnF+fBvMXb029B9G4bvSevYKiltXgLAlRsZHJby5QdG3kBjKbyk/1ffy1IIMQcFZp+sKRNdy8+UBaMPXyRs+TWByNgGd5pUBApFYyJY240gZbcKwCnVpyvHXiWqPP92g9pRA9bWB1f5/IqkvvhOrKzlGuHjqHXyhRX2MQ0rVYW7ergcQo1/4CtSv72eiIk/pet9PTl19SdJC3JkPFkKNY7XfpyP1FUCUSgyJtkF0FlhalphlTSejnMTOB2hq4eNoq5vyfSa5yw3U7F3eYsixKmHGOpI0gdAHQX0mjCag5SgsccEeqkI/HXLHpCQiZpLZf2HJQgvyE62Uuf8aqzGdDQ5GTmGuaK/iAOLmimVc1hzVn07FX65kepRjG+JcDMLyb0YRZRbe0veHRYxupEcGlOl7n9HRKz7qls8bwUEiwmY8xgoYhmDTO0paCS4y10Vvr9NmFIXRRYOYIxjHE9Dc4GFQOwjvDkjCVqBAUvJ8P6F7ytbsM0ah9LSS5vTBkvm94lRl5/BEkTUt6YQP4GOrf0O8nfl8EP7MBArFUWMRgR2IJBn18ze5EPLUrRlb4Oww7DOxHlV0bk8u9w+SELEurO9WUC8OPnHxIHXDDEhRn0qItVUsIs6HaSsYz/y1D+ywKEe0iMDi9iMINqalbtdzPif6LQDGJVv5a/YUPIGWiWbCjlbKxEjR5IvS41W9U/BhmAylODP8B6zlG4AER9CKRdrzjhYXGepDlh4zxGKZA/RNDOU93TXBIGYN4gfR8p80JcLXe228wjp5GmkBwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(1076003)(26005)(336012)(426003)(2616005)(5660300002)(70206006)(2906002)(16526019)(81166007)(54906003)(41300700001)(70586007)(44832011)(8936002)(6916009)(316002)(8676002)(4326008)(83380400001)(36860700001)(47076005)(36756003)(82740400003)(356005)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:07:59.7224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1809b302-3210-48b8-df10-08dbe08e0648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Duncan Ma <duncan.ma@amd.com>

[WHY]
On s0i3, IPS mask isn't saved and restored.
It is reset to zero on exit.

If it is cleared unexpectedly, driver will
proceed operations while DCN is in IPS2 and
cause a hang.

[HOW]
Negate the bit logic. Default value of
zero indicates it is still in IPS2. Driver
must poll for the bit to assert.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c       |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 0fa4fcd00de2..507a7cf56711 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -820,22 +820,22 @@ static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
 
 	if (dc->config.disable_ips == DMUB_IPS_ENABLE ||
 		dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 		val = val & ~DMUB_IPS1_ALLOW_MASK;
 		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
-		val |= DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+		val = val & ~DMUB_IPS1_ALLOW_MASK;
+		val = val & ~DMUB_IPS2_ALLOW_MASK;
 	}
 
 	if (!allow_idle) {
-		val = val & ~DMUB_IPS1_ALLOW_MASK;
-		val = val & ~DMUB_IPS2_ALLOW_MASK;
+		val |= DMUB_IPS1_ALLOW_MASK;
+		val |= DMUB_IPS2_ALLOW_MASK;
 	}
 
 	dcn35_smu_write_ips_scratch(clk_mgr, val);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d8f434738212..76b47f178127 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4934,8 +4934,8 @@ bool dc_dmub_is_ips_idle_state(struct dc *dc)
 	if (dc->hwss.get_idle_state)
 		idle_state = dc->hwss.get_idle_state(dc);
 
-	if ((idle_state & DMUB_IPS1_ALLOW_MASK) ||
-		(idle_state & DMUB_IPS2_ALLOW_MASK))
+	if (!(idle_state & DMUB_IPS1_ALLOW_MASK) ||
+		!(idle_state & DMUB_IPS2_ALLOW_MASK))
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index e4c007203318..0e07699c1e83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1202,11 +1202,11 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		allow_state = dc->hwss.get_idle_state(dc);
 		dc->hwss.set_idle_state(dc, false);
 
-		if (allow_state & DMUB_IPS2_ALLOW_MASK) {
+		if (!(allow_state & DMUB_IPS2_ALLOW_MASK)) {
 			// Wait for evaluation time
 			udelay(dc->debug.ips2_eval_delay_us);
 			commit_state = dc->hwss.get_idle_state(dc);
-			if (commit_state & DMUB_IPS2_COMMIT_MASK) {
+			if (!(commit_state & DMUB_IPS2_COMMIT_MASK)) {
 				// Tell PMFW to exit low power state
 				dc->clk_mgr->funcs->exit_low_power_state(dc->clk_mgr);
 
@@ -1216,7 +1216,7 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 
 				for (i = 0; i < max_num_polls; ++i) {
 					commit_state = dc->hwss.get_idle_state(dc);
-					if (!(commit_state & DMUB_IPS2_COMMIT_MASK))
+					if (commit_state & DMUB_IPS2_COMMIT_MASK)
 						break;
 
 					udelay(1);
@@ -1235,10 +1235,10 @@ void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		}
 
 		dc_dmub_srv_notify_idle(dc, false);
-		if (allow_state & DMUB_IPS1_ALLOW_MASK) {
+		if (!(allow_state & DMUB_IPS1_ALLOW_MASK)) {
 			for (i = 0; i < max_num_polls; ++i) {
 				commit_state = dc->hwss.get_idle_state(dc);
-				if (!(commit_state & DMUB_IPS1_COMMIT_MASK))
+				if (commit_state & DMUB_IPS1_COMMIT_MASK)
 					break;
 
 				udelay(1);
-- 
2.42.0

