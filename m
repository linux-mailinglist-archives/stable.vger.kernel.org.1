Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC38A779936
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjHKVIx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbjHKVIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E72CEE
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhSpM7DsqZmSLOv3dEgLrxtO2oKesVnfefmAALV/vvCy6bGRCoH6D7pZwjbSvs3/8QCHojAsUSGYEY04+7SX8i+8bXoOx8TO5a+CpCrtxg8VZj/Ly4BQoY+CzP+5d31LpEMRUbEkkhFflNraZLrAPtLpOzXL1HdU8WX/ijXpRSO7b7FehIdKNB3PsGXdQNWDAZXMmGHKXjSnS3EVv7Ug1CWmXK4LW033tzvuw//lyGXesRk2U2ibl/f7OBgAqf3+KiMjsKRBkPB/Y071aJA+aQFnUEeBkBRbK1gJ8hK2S9Pe/72A+LYyQaFOC2nyDSznkYw/3T7dKEXQ9hhk+TnbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+oVUOY3ePihFSwRH2m2pM9I45TzpbQBwT6V/cb1X+U=;
 b=NkYYFKSBJ1bCCrv+89MoNyIX24NzZnxxHBCt1meE2Lu0ewHigZLOQdI3pHRZj+Nv7d/b9bJELFIG7RZmgpveVmrNGXdCTnUUSYbZHtYmEMWBzo+1mihGfunq6L1kxJXpADmTHwS3MqZ08pgNeYAvJ8TorNSlp7ndRamSwPYSgzfB0rPCinPa5ZM5OUtbAVVZJaWZA6A6aqZNoMXFkWTuHBmiG2kLO8KMEdljkOyczQphWPZs61tkfAwqRSjdLCamYF2e7+j009kIgJsuUIRCnizrmflIt9aeb2LpRUmpyntnrQUKfzQEoXFe34tK7G9IIVthdSBarP8c51Xgi+erzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+oVUOY3ePihFSwRH2m2pM9I45TzpbQBwT6V/cb1X+U=;
 b=El9GOSE8FZjYoSNbcofjqiyyK8cqf1tHzaCdC3wvIrvQiC6/0FX1N6Azin42wyPA7TPH9GA5EAGOvgK9wJsDkNd0WzOmfh779kzAS6BFyGSbOBfXDTjDq8vh/UgdWdRIZ9bdXB5UTYLB0X9aewh+8QX7bKkcwquHcRFnExosqTc=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 21:08:49 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::24) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Fri, 11 Aug 2023 21:08:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 16:08:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <Tianci.Yin@amd.com>, <Richard.Gong@amd.com>,
        <Aurabindo.Pillai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1.y 10/10] drm/amd/display: trigger timing sync only if TG is running
Date:   Fri, 11 Aug 2023 16:07:08 -0500
Message-ID: <20230811210708.14512-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: ba03436b-e7de-488b-c9aa-08db9aaf2863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boJ8jxcmZrSfBb6C8d/sMzj44/3b/bQk+qOPGq+MKM56wxUlkgp+H8qQZKI5Fyb1kzZXs/yl6sIGUDaPGGtWwtD80bA5552olMA8XG80nfXHZKNRffnMc+KfvBg99KVFrD/8dRARjBKGV/yaxy43t5j9Uaw2PtEZcrK6rKZIrcOG1OZRn97UCt7SviAlRTVbu8BRkoXIGgKFjyoc/forJXS9hIb3+U6dtiYdPKNVpl/FqY6AQpodU/4i3DMSI7RL3YFey4BjZhw2lAqWskLHh2VY5s1wFOuGQkg5COrfRaGSy76dGMtfyFHloS/89cB954HNKl6C8se5Qtse4lQEBA8cWsE+AkQmSrhP08M4ilEEm71jaixHCGjR801RfqSF0tstrvs3YtHJ/UIOpVoojsCS211Q4L0A8dGh1bv0IAkmlH03iT4WsuKFWf7pEThyai7ZIx4pgEZlmAfkFFrBrja/FapHDWriW4+srAI++tphEnSZ0fuEixub662r0BxeMFJY2Mi0OFd9zRiponHMnndnIgElRdC1ez0bA0Eve3CvgLJBFO0PwcnINAD+kDI5r//Yb4SX0lIaGOMoNwXs2Yj7PUMoOyXDklaIKfyg3p5G8XiuySSlHjpmAVbNUY0v0Adqbq26f0E0xsP4mAb1eaD07QDihGMVPuC0jlcNp85zrefdremITq95S3dgUnVqEh862vKyKND5DQ4CgKmCh4fcTwRA8I+fhE24/ZTWaStX41nbJt1aW7w2WVFMUAiYjIPgkEWvrnyi32QrokacrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(186006)(451199021)(1800799006)(82310400008)(40470700004)(36840700001)(46966006)(1076003)(2616005)(6666004)(7696005)(36860700001)(47076005)(36756003)(40480700001)(86362001)(82740400003)(356005)(81166007)(16526019)(26005)(40460700003)(426003)(336012)(83380400001)(316002)(54906003)(8936002)(41300700001)(8676002)(4326008)(70586007)(6916009)(70206006)(44832011)(5660300002)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:48.9233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba03436b-e7de-488b-c9aa-08db9aaf2863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
If the timing generator isnt running, it does not make sense to trigger
a sync on the corresponding OTG. Check this condition before starting.
Otherwise, this will cause error like:

*ERROR* GSL: Timeout on reset trigger!

Fixes: dc55b106ad47 ("drm/amd/display: Disable phantom OTG after enable for plane disable")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6066aaf74f510fc171dbe9375153aee2d60d37aa)
NOTE: This is also 5f9f97c02dd2 ("drm/amd/display: trigger timing sync
only if TG is running")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a6fde27d1347..394027118963 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2284,6 +2284,12 @@ void dcn10_enable_timing_synchronization(
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
+
+		if (!tg->funcs->is_tg_enabled(tg)) {
+			DC_SYNC_INFO("Skipping timing sync on disabled OTG\n");
+			return;
+		}
+
 		if (opp->funcs->opp_program_dpg_dimensions)
 			opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
 	}
-- 
2.34.1

