Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3D785CDD
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHWQE1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjHWQE1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 12:04:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D571BE70
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 09:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kse3IzTcVSAIe695dNINYmhUjawCCUMNbHb6RqaVNN10u6vcpuEIfVLeUK/uGkprpJQDZYumLsE5+87/wMqZIwLskl59dxeEY/zaKEMFJWFZKRBlRtFicij46tzEG24yyFb/xtBFZ+wmCjhWlMMpx61D1hgDgiEAfpb9qbREzqb522HYHYS6rqt8SnKMIxDxdienr3FevElZRV5DIk+7dOLuXXiCT1FUVNgEhaP8a4uks/diE9jYqKvAq7AYVVUAKwgg4dpHI5KppyvQLiR7bXlJI6Q1c3aAyxp1Xrh7hrlb+uw5yP4aTh4rryTAQ8uvni2DZRiKytCSnDO0Ty3bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtN2tKF/oNtmUjFzLVHfwwZCM/17ysgNFvkadyhgNok=;
 b=dgwR0XQV+UavzqrYIjCLsfLWE5dzC9GTuHwI7qdwz32CFPSxc5HvsinZp3P+iacnoCyhrL2USEcqodwQKKTV0sSaDey+HH/BNkAkxKW1bAIINqN/CkutFUIVGvR1/C9QSW/wlZWo5lHNk/H/o2s4eqhuWA5gbl4PHd87ij4pu2TD2IkGzN5k0iZrn8ynsHqv1+BcVzdnkeEYZUC6cRGt2YGf0f111MKKauqRYfRScFGvFKvoxV/1YqHWS4z6AniL3dooFKJNpxl9XJXyw8jSiHyE6EkJDquF5tLtLT0cxZ0ceDkhAUHVqb8Y7kM2Mpev6IRdG+CRva68ki3YXjiLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtN2tKF/oNtmUjFzLVHfwwZCM/17ysgNFvkadyhgNok=;
 b=2Gm8KH37v+y/XKTwL2Ydu1Lzma1PWs4Z6YGaGKS9cg8fygsPhWlqKSG0HY4HgD6peOm0k+r5GDruKhD6eOQcD4VqsOrveqxBas3v4fUX3nQKl/4VhlcXFXJOiknVAWlzVwC59O+h2w05161IlBl/IiCVbUAYFVGANN97JVOJlCM=
Received: from SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:21 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131::4) by SA0PR11CA0145.outlook.office365.com
 (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:20 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:16 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
        <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
        <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
        <hamza.mahfooz@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
        Fudong Wang <fudong.wang@amd.com>, <stable@vger.kernel.org>,
        Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 03/21] drm/amd/display: Add smu write msg id fail retry process
Date:   Wed, 23 Aug 2023 11:58:05 -0400
Message-ID: <20230823160347.176991-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: d1229f66-c766-45f3-e3d6-08dba3f29cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVv3FRTdRiD0N3P72EO/kyqlo+RN7BWTphq7UW4hbSUBK9OBKz9dCXmbKbbMA7v48LM/0zfZYXHe51ykarZTuliFzJ966XXfZMTzMk9toc4M87pm6n6btCSbxwHLE5gQlPMzjxiNin+wtkmndNJdKNtDMx1qlUHUEP9sg7SqkospVGQWeClIEEQd+J6H9gZ9kyIcS4m1v4mathXGDLOgtf6SLEdiBgpmjZT0zZN8oZxmrp8EFAlWv+CggOzmdnSYD+22qCADEOkjwM/ltRhUXCBUxTBmkYN8eaoI+ly2rIKNg5dm8YFpLUD10ft/4PPOxXO4YMPYYAZpOdkMY1IG1i7bFeJxiidyCh6X1mUQwKiy1KcFHrpNUD5x7sks1tExyL91NCFLZLGinYp5+ceYeFGkhzrcgK56M75WEHXRn2reUNs3usIkqfcu3tYHS/dIyEjfdmomYzyt5DDGVuyfk+R0xFN1t2m4CNi/2ZZcsDGPYDQ3yPQsEUDilYxjALRgEABOsnXmPlBTawCR3EPhKnEHVVXAgjB1KhlEhpOCxRlOCmnsla7EoHmEdT3PQP6fAb3bWb9tnj/B4ec0ynyawvqCNEEhku9Z8HcNjlDCI55D+SLFqB83JYLTiSxdimucsbR8WU7AAezRYTcHM2hrXEGKKaisovjXj6qul9kcmBqF45jATLCkOEJ+EC8ZJSWnER9hNqDzseonE3DjmVTMVcuSWYmFf26NdYoYkwBl3la09hN09l/F1kDak5cYLvW5p6olLoMjpn/CAWiUKqTnwjAEg0BVosUxTGSrP+m+lHZht53gnDvMn5jI2w4PKyT5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(47076005)(40460700003)(36860700001)(83380400001)(2906002)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001)(41300700001)(70586007)(54906003)(70206006)(6916009)(316002)(5660300002)(2616005)(4326008)(8936002)(8676002)(478600001)(6666004)(1076003)(26005)(16526019)(336012)(426003)(44832011)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:20.8880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1229f66-c766-45f3-e3d6-08dba3f29cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fudong Wang <fudong.wang@amd.com>

A benchmark stress test (12-40 machines x 48hours) found that DCN315 has
cases where DC writes to an indirect register to set the smu clock msg
id, but when we go to read the same indirect register the returned msg
id doesn't match with what we just set it to. So, to fix this retry the
write until the register's value matches with the requested value.

Cc: stable@vger.kernel.org # 6.1+
Fixes: f94903996140 ("drm/amd/display: Add DCN315 CLK_MGR")
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Fudong Wang <fudong.wang@amd.com>
---
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 3e0da873cf4c..1042cf1a3ab0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -32,6 +32,7 @@
 
 #define MAX_INSTANCE                                        6
 #define MAX_SEGMENT                                         6
+#define SMU_REGISTER_WRITE_RETRY_COUNT                      5
 
 struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
@@ -132,6 +133,8 @@ static int dcn315_smu_send_msg_with_param(
 		unsigned int msg_id, unsigned int param)
 {
 	uint32_t result;
+	uint32_t i = 0;
+	uint32_t read_back_data;
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 
@@ -148,10 +151,19 @@ static int dcn315_smu_send_msg_with_param(
 	/* Set the parameter register for the SMU message, unit is Mhz */
 	REG_WRITE(MP1_SMN_C2PMSG_37, param);
 
-	/* Trigger the message transaction by writing the message ID */
-	generic_write_indirect_reg(CTX,
-		REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
-		mmMP1_C2PMSG_3, msg_id);
+	for (i = 0; i < SMU_REGISTER_WRITE_RETRY_COUNT; i++) {
+		/* Trigger the message transaction by writing the message ID */
+		generic_write_indirect_reg(CTX,
+			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
+			mmMP1_C2PMSG_3, msg_id);
+		read_back_data = generic_read_indirect_reg(CTX,
+			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
+			mmMP1_C2PMSG_3);
+		if (read_back_data == msg_id)
+			break;
+		udelay(2);
+		smu_print("SMU msg id write fail %x times. \n", i + 1);
+	}
 
 	result = dcn315_smu_wait_for_response(clk_mgr, 10, 200000);
 
-- 
2.41.0

