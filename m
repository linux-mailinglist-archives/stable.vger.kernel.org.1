Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C2E7943FE
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjIFTzk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 15:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240806AbjIFTzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 15:55:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F669171A
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 12:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk9tD6R4UfQTsG/JRHw7PK2bEBkMBkL9oR2y1Y+YAWZ29htV/5QIH38PfVagM0a3OpEs/JiA0gbJEcnWLg+GUATIAQZy+iu8ywD5FqKXmxcMv/QMIqJt2FRWrpNBqmJr3uthOZ8wEV1f2+dqu0sM85KNRd+zjCnL+SZz9ieBf4f9I7cAY54k4mmu6SL8JtYZd7ivS529q0Av9HAagGQIxRpEwxvhv5y/osG0mErxaKS/E0zIePtJYM7zN5TknoJ/r7tn0ZdV42+oOBPaG3eZnrZ5pkxGsUX/myHRFmC8us/bKWAbUWcNn0O7qmyn3OHaXyt82/M6CN9/cxW4tulaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/AwCbfxTN6tLx+nfaULnK/cXzIDi4FJH9HY9AAa7o8=;
 b=JqsR6Sodo5pa3iegqPiCVWJtnFf8Zu/G9/0uGRC84F2R1Xpzoh2RlhSDSZaPNWfrBnNLAK3KcGnkC4IU9qJaDHhSKqzlKh65Vp85KzrXMqcQt728vm7nielPA9WfmnyRKEZmOQkpgtOH9S2lnIfIycPkMXCwJmfrw/6XQGQavuAuHe4Gl1MjBajsE6LVLzKFdQz+oR6lG4DQfHLimmU+xWR8Tj6R2pQN1FIf8CqOiKguf0SsxSMYkYHk2FgctZdceNRdiOnyqQe+pSrekv0jJjxzQEkvP2EwpSDnHDHJx2O5CMP6JvgmU3EF3e/+axp3kwetEZdaf4zQlMw1HIRJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/AwCbfxTN6tLx+nfaULnK/cXzIDi4FJH9HY9AAa7o8=;
 b=fffEHnjklWr419ZW7ROxXZwHNf1GMFUUsfkj4Df3DxF0INmjYJ2Z3DCL9DRC1HENy3YVIPdhwXm9uIXQmmwdwHJ6diFhflYARVJazOYhGyBAla3JyA1Mthj08RzpbgU3weoHDBR9l/cqrRwV4JN0f3eObyY3G5IlMbs+bh/rA8M=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 19:55:33 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e7) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 19:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 19:55:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 14:55:31 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>,
        "Simon Pilkington" <simonp.git@gmail.com>
Subject: [PATCH] drm/radeon: make fence wait in suballocator uninterrruptable
Date:   Wed, 6 Sep 2023 15:55:17 -0400
Message-ID: <20230906195517.1345717-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae86ef8-66a3-4d89-48fc-08dbaf133aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEEKMJbzdc4R/xSfoPzVwewEgmT9J8wlrbWau/dr8U5/mbiEWmXzl17Ru/Ivxn0/6ATwKwvBUqalgvscd95A4NRbMtTFE2glECNOn7d3v+BwqrGjb1oRrKDfxZ5o1eUCV15RSmztr3FDrD9kCY0sIGdQYp6Ef/xK2S/fzUlZyPgr4GhGhA4K+zF8ahZwLjDBOjZ8kylKDdZlVdwURl7vY/ndJZ7rjlZ7Pf4oAogIjsL+O9Hee2yXXV22jL98nVs3JU2CSPW90JJcOJ91ddbxL0NA+PiI4s8lzpEzQfz9MJehug0uykAqPnm+32bW61O/yG1Vvq6cbcxYRhKfLitRy6E0tqONfLGEdLsUrckOvaJeBG5lGoHTaaYvXbeniCdgn3/E/VEuKYpdQ+7PhxuxUrvxmTtFusPn5tldAfMuweXUCUQiqiESiQl6IAITcy/q8kV058BhvEMf6QcYb3YWiztX+mMb+NYdu5Ue60VTt5C2VX0/QWoDVJfVZiiw/KenNpi0hDLvQqP06Frg7uyuVLTXiDVLDfUvO+sty3VLbCkvgePpxy1oWDJjHjx69OUU4+//sxcLYQynw1KfGFyUiA0SRYkTPqiJgk7DU+VwBta+m1VXe1bW5EPfWWDWAc5hX5JGG9taqObeNzigW9Uy39+FyAUzYIMoLxi3TvuYlci2Utpefe/e2AfFRV0cukXUt4XRv76lmw3AOIdVAhBH8ANIl0zss7mHOYUZHqtgJfBp9jShpMvhcKRfWvGpTwEY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(7696005)(966005)(41300700001)(82740400003)(40480700001)(70586007)(70206006)(6666004)(6916009)(478600001)(47076005)(54906003)(316002)(16526019)(26005)(2616005)(5660300002)(1076003)(86362001)(36860700001)(8936002)(8676002)(4326008)(336012)(426003)(83380400001)(36756003)(40460700003)(2906002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:55:32.5687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae86ef8-66a3-4d89-48fc-08dbaf133aa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
code to handle an interrupt. This caused the kernel to randomly explode
in high-VRAM-pressure situations so make it uninterruptible again.

Fixes: 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2769
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org # 6.4+
CC: Simon Pilkington <simonp.git@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_sa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_sa.c b/drivers/gpu/drm/radeon/radeon_sa.c
index c87a57c9c592..22dd8b445685 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -123,7 +123,7 @@ int radeon_sa_bo_new(struct radeon_sa_manager *sa_manager,
 		     unsigned int size, unsigned int align)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, align);
+						   GFP_KERNEL, false, align);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.41.0

