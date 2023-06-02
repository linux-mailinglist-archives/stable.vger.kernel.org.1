Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30899720742
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbjFBQSd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbjFBQSb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 12:18:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9AE50
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 09:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+SOTVrtj1vhlP4CORJd64hIaTn/P4GKMfCHbXu0R9oZcypPAYQMJwOmH2ege4LcZR7Fx+Wtynpkcmbo7FaWUBGyTng8jqAe0+6FjVHHeuGgcOwSKP9SPaEXVAIwnmn584y5KAjHeJyJToES1SNe6CniSmrk+tE1NVLSB74bHFnKJDCBbntOqueFysxRXHgllXEn3jwYYezBTpS3VtW5Ca8Daez09SLIWGjpmTLlZf0sR21PZXAHdH1X+O7PS8J/6aEzuyRkOOqkGTYkN8Gi7hMeFN2XUCgSpMzSJLd9pxRuvvfGpuWaiCfaGb3grggFjsTOiNWzZVyhjcbk+JW/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlEKpZm8NEEx3i8XdeEeWgRg7nslSWON8KNktFL4wqE=;
 b=StLPGneOuTcn5B0CUGOeptBl4p6Pw0QjY9RWl1du1iY836bRKSf2nEqNS13Z1EFhLULYiupNl6znSnn4f7AGxc/sPlDUYgXZFNJzVfjSqwhZRMNCLZmp6ZcgzQ4ALzT/hBUisXb9SeiS510Z1DOQ/L82TxZfKvzFOT3XnYENzj+s7JCWdgvMId9HGEa5m9IQllZjUjhyx04wFSHWq9RhqUae1phJBDYIVFlGYreohF3TpJOR+3AqlOT5BmHfl0cwcQaGp25yKhzf/7nf4WJ11MVXeoXln6biS1H375FW9ZjoPcr/Aj8LKA+QZ6HyJtuN64m94/NCHY13MbIc+knc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlEKpZm8NEEx3i8XdeEeWgRg7nslSWON8KNktFL4wqE=;
 b=PGh38d6J2OnIvtiVrQ6wPQHcb7TojQbt3VnZiQZHZb3JlyBMjNevEGY8Sj+PHCkgufLTgl8jI8LIvNJfx0J2g/Lh6mX4u/QEtP5GV/XiwDoFMWUBAIgJ2s9aOp1NK+292sx8qL1cfBrbJBxprXSTaatVNFVCHP9C5vd95tbb5Ow=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Fri, 2 Jun 2023 16:18:25 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::a7) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 16:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 16:18:24 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 11:18:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     <anson.tsao@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Have Payload Properly Created After Resume
Date:   Thu, 1 Jun 2023 22:59:52 -0500
Message-ID: <20230602035952.22551-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|DM8PR12MB5478:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f7f090-2e48-48e7-77c1-08db6384fde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9vAmUm1tK4/cpyM92W2pO0oTdDbDyzXofyYjhV7VR9VQq3UhBCIrU6TI/iNxXlJjYusHyP8FoAGYbSln8b0TVFQYExo1QhWNwxWkVfthgJ4kLMi46fOsP3Lb88XRrsNQ/Bxh9aWokKbusgZ1PgEdUstAGr7f2sGZSr7vyVRMiJdbuHYrGS4WvX5mOegjRd87rmPXM923oy5ALN3srOWO5d2P42QscRCT63YDB5rLjAkZgcqV0GzN1wuWOk8khkQwK9FbetmP2XKx33Q9Wnhk3+/lpHaUricgZZ/yRdf0GBOXUPfBtiaOiZnb5cE2GyPaJxUIlGohKXTcdV4nXxpmVL6NFBrMrBM6HLvnmSRBHCan2Br/kH263UTxWCn6dOIOBAyamZNg09bSWkIMGYk31mVHZq6FNjqG++HImDfr3iI0xFT1dDpoansut8pe1U3LSZvNsxmgpqF0LEkDf8TdA9+Dbh5JxCKpeqSVjAaI0CDifa6vzZ9jUHObxJNUrdQOzrxs7aRq/+0R6WtC72pgGHkT2UhoSyDJ5S2iQ4CYPhoEspRzEunu8dVlbZVijxe3OIEMC6nqmJbcUOWpp8FTO3pf/X5LUGARXhli+fiZU0JNEw3SNAieKgsNBOSfMKwJYIFw9BN+MvexmtvJLQ9GFBhN0uRU5oa/ecLV1Aug0Llr75LN/0FJdgekLAoEnWdZ2uWw0m58yfwX0eMZryMjh7inOLduejo0B8n1dRpR66eYKW/xHaq9NuGek76YupNaQALpo5+ybWfJ/xziZI1hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(40460700003)(336012)(47076005)(426003)(2616005)(83380400001)(6666004)(16526019)(186003)(6916009)(2906002)(70206006)(4326008)(7696005)(316002)(36860700001)(70586007)(478600001)(44832011)(5660300002)(1076003)(41300700001)(8936002)(26005)(54906003)(356005)(40480700001)(81166007)(36756003)(82310400005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:18:24.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f7f090-2e48-48e7-77c1-08db6384fde6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5478
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fangzhi Zuo <jerry.zuo@amd.com>

At drm suspend sequence, MST dc_sink is removed. When commit cached
MST stream back in drm resume sequence, the MST stream payload is not
properly created and added into the payload table. After resume, topology
change is reprobed by removing existing streams first. That leads to
no payload is found in the existing payload table as below error
"[drm] ERROR No payload for [MST PORT:] found in mst state"

1. In encoder .atomic_check routine, remove check existance of dc_sink
2. Bypass MST by checking existence of MST root port. dc_link_type cannot
differentiate MST port before topology is rediscovered.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 52b112049e1da404828102ccb5b39e92d40f06d4)
Adjusted for variables that were renamed between 6.1 and 6.3.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
This commit was tagged for stable but didn't apply due to variable
name changes.  It's important for MST during suspend/resume so
I did the necessary manual fixups.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b46732cefe37..8ab0dd799b3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2763,7 +2763,7 @@ static int dm_resume(void *handle)
 		 * this is the case when traversing through already created
 		 * MST connectors, should be skipped
 		 */
-		if (aconnector->dc_link->type == dc_connection_mst_branch)
+		if (aconnector && aconnector->mst_port)
 			continue;
 
 		mutex_lock(&aconnector->hpd_lock);
@@ -6492,7 +6492,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 	int clock, bpp = 0;
 	bool is_y420 = false;
 
-	if (!aconnector->port || !aconnector->dc_sink)
+	if (!aconnector->port)
 		return 0;
 
 	mst_port = aconnector->port;
-- 
2.34.1

