Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFC74B3BB
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjGGPIR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGGPIQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B526BD
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9w/2Pw8Y3GUn/lExlrJXga4xNQdBr8mmngXejiB07b48kqoCBLPhnNJBX+Re3hfeESCEqIZLWmHwnZrY6cd1yXxg3P/Av/MZQXp22f7h2hV+C/Hnv5JIK7WxRR1+0NNVSXIMWFGDBHmC9VHeapWh+TzaUbmFtUpO5EsRVwYceQfEEAqQsalejuryRSPryGJ5S6ss8aVI16hst4RBsZJM7yUxiUd8bwCO9urTX6bEWzwLXGWPnWP78Nl4hWIQyXk/muMk8q+5t6gkiIYwEvvJjBLYxKAVvTt9Lzb0LejwdfIO9HozHoR9fWLAo/qi7aJjeyAds6zVlnKIXppIrg9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl89irmez69gJCXQogMzjQGQ6nNIzRrZ7gLsrF8DPt8=;
 b=ZIvSzMNHlD1o3QPNGcrLgvgSKkBN74PAjmkCRrqON89fenvEIFXBGRwvgS9NPbP046S4RI78wWxCW8XZlnGIY5Rq7B/mbMFBAFBeDijlnc/IYaJOwEaguIA/F6k8Cf8aFENqaBc9kq7AcueIrV8jx0g7fepn7gCgG6FrTgiJ4xEe4w7JcNXdeo3Jwh/cHpVQoLbqT01RbR3KBhz0ogPcnb1Hu0OmYven3fKVsVoQCYqIs54CJr00hZrWMJ+qLb6cT/dnIEB+vb8yCysfoD8wksZqkAv1+BgzlJeEri0eHo/lHtz9aIuJiyU8gqIhxxi65QCubvYSDlrx5polQVWqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl89irmez69gJCXQogMzjQGQ6nNIzRrZ7gLsrF8DPt8=;
 b=sIu7/xzOs9aGZdctw4fCxXu6e3/QjJi7Y5tIRr4dlruWGGR5/TKNX12alIHuYbHZ4acrQtj/+ZkwGMvNldNL+T4rSIKXR4875mtWSJsS1719kNXlu51jegd9qh44zv1KHjUUiZN89Wees6AkWL1yzcoAMHB1ohPrKGssOwxRxvg=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:07:54 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::a1) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:52 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 8/9] drm/amdgpu: fix number of fence calculations
Date:   Fri, 7 Jul 2023 11:07:33 -0400
Message-ID: <20230707150734.746135-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707150734.746135-1-alexander.deucher@amd.com>
References: <20230707150734.746135-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 272b4ca7-b676-47cf-e4d1-08db7efbf0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o55+Tmcu2BMFE06zbdYvjwglMJOzB7csynJX23OTyHaC/rCsqhRo/DXegxI4ZHUzbxlu4EKRjjWIOYKgPr6LPMl62/M2ymBChpkT1YE7yynnkrJR4j+igXHxxuJPJ++9CKTCERJihLnwqtG30N6BYWYSYWjT9EKwfS3k7mNBxbFTGoeJhY0e6Ehzgh3Jfzf13mPE3FTWUYDb6Di9Sddxh7I5ZleuYsqiv4TuhZMPDbBMXNQSF5WFkvlhzyb24M/vhcSTKnZ/VhgFRq92fwMkdGj1rWtHm2hC1jzlIlqOTCWvWQEb2AQFpSevJnMJHIP3sUDvmog+0irf0Hue+AIilM02PL1WIHnkha0+wI8JCAsnl8JfOxvbvdmUhfKSzTpu66L1xS7sFb7sejeDo8ghYgwACm1UqG5gf8fXarANFWXd2OhWW4wnESaf+v10HWxnbKubkFRUp4rCpWY6wv6sI5n0hqjF0yuMlsf2JMUmj7DkJpX+KcTNl7+u7RXUpehHS0j0ldAwTHwhX1yHEFor05H/9AieZuhdF4FjQjN0z30qpxHEOWs9TEggCqG6RMr+LfxlnEPZ3VDZFfpuass043dNc1G4v8tljxdrdjr09+nJWU6ZF/yHW2k6kQR4ELzSC49OiuptV2Zxm0UtmWUXUWt1u0MRhOiOW+kFyUrIdTL/Pr5jJ1UGtoGmQn0Aw7Ri8hOR3fuWnp56RaR6T37O044pUtnFZTJ4meq8ruhHSHDdK/vm1bfQqiMQ8YdiCLQt3Qy0m/cw+e8xugch+X+3nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(36756003)(86362001)(82310400005)(40460700003)(40480700001)(8936002)(8676002)(41300700001)(26005)(5660300002)(186003)(1076003)(2616005)(2906002)(16526019)(36860700001)(336012)(426003)(66574015)(83380400001)(47076005)(70586007)(70206006)(7696005)(478600001)(6666004)(316002)(54906003)(4326008)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:54.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272b4ca7-b676-47cf-e4d1-08db7efbf0c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

Since adding gang submit we need to take the gang size into account
while reserving fences.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 570b295248b00c3cf4cf59e397de5cb2361e10c2)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2eb2c66843a8..5612caf77dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -133,9 +133,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	p->uf_entry.priority = 0;
 	p->uf_entry.tv.bo = &bo->tbo;
-	/* One for TTM and two for the CS job */
-	p->uf_entry.tv.num_shared = 3;
-
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
@@ -882,15 +879,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 	mutex_lock(&p->bo_list->bo_list_mutex);
 
-	/* One for TTM and one for the CS job */
+	/* One for TTM and one for each CS job */
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
-		e->tv.num_shared = 2;
+		e->tv.num_shared = 1 + p->gang_size;
+	p->uf_entry.tv.num_shared = 1 + p->gang_size;
 
 	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
 
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
+	/* Two for VM updates, one for TTM and one for each CS job */
+	p->vm_pd.tv.num_shared = 3 + p->gang_size;
+
 	if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
-- 
2.41.0

