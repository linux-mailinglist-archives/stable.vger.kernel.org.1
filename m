Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300BB779932
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjHKVIv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjHKVIu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE7C10F6
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVvP/3W3iphQZ28CX1gHo19dvJHIQFbnqJzehPPfCvTwMcTLLykeKEMV2NI4UIvc4uSAyVLoaWaX312T0nGsEZkS4WZF/4AEpH2aeR7ASebSzOjk97ALrXGNliQKX3XroAIOxrVmdoiV+ZP2FglqgPKuf1W5i+WqgKpEvPTx9pZJGmmwHONA5M8N1nMjIUG2E1AAhpkeLdFfzHcrTXsxGzhy63uZneMts8nzmbht5EhLL5yak3kyav0YLtv139BR+kUm/ShSUXqJwy/K9btWU1P9CQykQ+80MpyIcanHTycOJzKT6oVjIeqf9GyRXy/xM7ngM+Vp9VkqyK5dRMPW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dN3HzJMXGL/GJmVw14MymIQCuyTD2g61hb9oxGRCZA=;
 b=B87Ff9fT+mngzDKz6i+Cx0DpXCmIw3SDLJN0teJiqbUpm4BwJ1blcVDTMznLoMg9aQS4Al1jyafpSwTpHnJNsHrKOL4DBhPpUIlpyFvR3rQaiDFEoxwuz6A3HBBLhWfg88uFkaeOGmVbg5NBTDazdjUEw4F03GIKAvxDIp7wX7wQL91MQ6NK+ypVfwA1kxkKnRMzP0Zzv4quaU23yq9HH5aSBPjGo4RkqHk65XtG5TF7u948XNdeBTMUWMsdy44WBrt5QGxjU3P3dbozUGe+PAx8rAFR4rNBVZLh7VHGcFeMpEjvJsGBNCOJhTkPOOS4++jada5uvOdCRuDSamvHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dN3HzJMXGL/GJmVw14MymIQCuyTD2g61hb9oxGRCZA=;
 b=I/EEPli92Ay7o8cjLJaL68/eLeZwaCBBFSlMVvf62rN1robXbsY2UNbv9LU7LSOjZ3DRNqth0yMrnkjqlIoQu4w9AzBEpuOKJ5TnCOSRdxWSiZ52hrZhoRiOZZ67hew1JLZl6fFV9kv70kdR1oJhl1bS64D0ys7AHqRo1qfcCfc=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:08:47 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::7d) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 05/10] drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
Date:   Fri, 11 Aug 2023 16:07:03 -0500
Message-ID: <20230811210708.14512-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811210708.14512-1-mario.limonciello@amd.com>
References: <20230811210708.14512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8399a-8579-4ef3-7583-08db9aaf272b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: golSyPql1L/3keo/NWuZbvYUOGNrM2Cd8bMHgegDkUayCTyEKB69N5NuMD2cAjpJuF4wSWjHicw7D6Ye0VSgzm9WQu6oWWpmNaBD44IrpbKAyq5Il9S17dtMSAwsq99LQ02krQdMh+hmPa1M8raruaEUSZHhaGjNtTidMA5DS5L1vP1YWt6v1Vxb5lWpUGysEx87kXneivDuKGpFhmJQeS91HbpuLr4qukySr5UYaN3OwmCN4PZTaMxYvcAfBDm3jEkt8RDsrpeFHN7iSY1bV+wcdfj8IeiqLlEf2MPtszAqD0sPtAMZYWYftwjmgDIWf4htovEpmWE1cleKq0OfeRNBCKVzvIsjuiOo78RtmCP+Qz3V8QaGcbJ+jgbNVCoZhrIqy7d+aPYT3nMHAGGIGLl1D+MM17HZj8J7xEXsHPmRk2pH2lmUCI26cpI6cGmIJrnaZN1fkhpwNFpCVM6YwNUaIa99w5RHRQiXtug5RmoYL+4F2bQfsH7PgozSebr/AD+rYNL4otX/HYtF7ALnXJ8URsgFkmTCK1g/yBjbh/CYmViOz2nw1aD9ZxNA211Q7VrRHFa+6L9ExnH+GVBROtrvDfXcybn/6wn/QAhhY5/+07kQViDE3kimg5Nj+a+61p6rfdZir3oVTwVL6ZVbcLb7NzAogT35Viow4saYZabQjV4wV7sUbqwI8uOdACfPNLyBCAdZunE6K25IcAmAwO2uLegrgjx8czB9n9NzeD6GCyxAyJq0WoVmPzs41lYXTlQ6tSHaXxqfnoGmzw3q0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(1800799006)(186006)(82310400008)(36840700001)(40470700004)(46966006)(26005)(8936002)(8676002)(1076003)(41300700001)(40460700003)(36860700001)(36756003)(2906002)(83380400001)(426003)(47076005)(356005)(81166007)(2616005)(86362001)(44832011)(16526019)(336012)(82740400003)(316002)(70206006)(6916009)(70586007)(4326008)(478600001)(54906003)(7696005)(5660300002)(6666004)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:46.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8399a-8579-4ef3-7583-08db9aaf272b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

ODM to combine on the eDP panel with ABM causes the color difference to
the panel since the ABM module only sets one pipe. Hence, this commit
blocks ABM in case of ODM combined on eDP.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7fffb03b4045c862f904a88b852dc509c4e46406)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5d0a44e2ef90..8c9843009176 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1996,9 +1996,19 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	res = dc_commit_state_no_check(dc, context);
 
 	for (i = 0; i < stream_count; i++) {
-		for (j = 0; j < context->stream_count; j++)
+		for (j = 0; j < context->stream_count; j++) {
 			if (streams[i]->stream_id == context->streams[j]->stream_id)
 				streams[i]->out.otg_offset = context->stream_status[j].primary_otg_inst;
+
+			if (dc_is_embedded_signal(streams[i]->signal)) {
+				struct dc_stream_status *status = dc_stream_get_status_from_state(context, streams[i]);
+
+				if (dc->hwss.is_abm_supported)
+					status->is_abm_supported = dc->hwss.is_abm_supported(dc, context, streams[i]);
+				else
+					status->is_abm_supported = true;
+			}
+		}
 	}
 
 fail:
-- 
2.34.1

