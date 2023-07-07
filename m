Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7474B3B5
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjGGPIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjGGPII (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C218269E
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVIA5OuTQbWLDDz8reUKQg2ejpVB5Zq1KDtxPC+1m+gu9Fkv3t2a50cqiYZie4mVHIXw8BBcQdcexhG++QgIqaC6+ORmFPChR9/TB41+nv6oZNl0hnZZPBFZXUZiyJodmQafV4I3PQgGUPB2jR3+rG/mQtudsnYX1jHyLxXJfibQmOUMUdttNIOeMTbZqHWDw1foIwNh/qw6kJMkIdzgvyueKq1Gg6iMTfrwhr8puFM+44MVAk9bTFa9oSF6rsgFYzfumBJpoD3UikWgMtZ8mUf/izC/O7XN8m5cP9ne2WBRLy3ZeeeL77gsXik/bN2amq8yZReq8znIHNp0xZsPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBJGXvC7ZbL4ELN4C2ruFIGBBdqhFoYj0iYi/ft6H/M=;
 b=fwbnvjuRBKadcfEQoRECfddBkg2dahaQjZ5E78r7N438JTn+JzCDvZIIYWWYMH0cn2kDwNr2tOF6sSATnQTeZ3h0F26UOAfbhK2qFxbLKBTi0fj7793h/0kyw8oLINnZUaVERe/ZpEdsGQ2Lpp7DkL1hTXU6mn+5EXh0w2qb9RcUm5wwwbjjnO94gT8ABVCZ6b/JQShRS5tuER6uE0lYHKUxQT0BB2gYgyiks0qBul44mTrbohAblDNA1EmF8oRfQd9RnmMkirpZ+hc4Pr1EG7j9bDiJRNqMTvDh2Rtw6kvwaAdYpMPCsfbAK5lP6IQSFtKvT+QHISGLwC9gRoaqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBJGXvC7ZbL4ELN4C2ruFIGBBdqhFoYj0iYi/ft6H/M=;
 b=LvEpPvV3e03bzY8GjIpxcOUenLdvmup5aaoPMkg0qixdab/JLXI3MrZG0Pyy724CpH3e7uDDW49SUcAp7dvvjT4DxF0EILQrkufkkW9Y8o3V0Kwh+gr83PA5/IurJONeioMHE3j5xZrD7pWsp1PDak2Fkl4gNuxN6rKP/Y+VRIM=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:07:49 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::8c) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Fri, 7 Jul 2023 15:07:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:07:48 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     <mario.limonciello@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Guchun Chen" <guchun.chen@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH 1/9] drm/amdgpu: make sure BOs are locked in amdgpu_vm_get_memory
Date:   Fri, 7 Jul 2023 11:07:26 -0400
Message-ID: <20230707150734.746135-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cb363a-30b1-4aa6-ec79-08db7efbedd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPv/nZGmTaCkaZQsQqODnaMmGS64pjt4yrjY4hBGzHxCY5rDYqnpoaUme+q7SGBmzuZIntXNUgc5B5qQibcWUwHGt/YJFmxG6JnrNCtfpFau6IR/BKOkpUvuBLU1oOdTi+fSLF77h/Rzf4TkA6/dECEAmgVvzsIzAy5TSRvdZrUf04kThSejPHLLmJQVaXQl/b8/lpWEhuX2bJQVT++Z2wnVIS84kiQStpvXwWy5Td5os6IETlIGqBUutPbzgz6dTpLAIR3q3SAaSFhX5PppUyGwPeZKrZZeLWTmElPpSoRWaOsPchK8kvGSjdLBPocAxU8vV5uVpl750I/qnG3W7cQGHMZYKZKuaF3G8YJXEWEB+oVk/PYSJcp0IMYr59ZtbAibykJ0BbGETPcVfesj3FLtFe3U8A5esQ/Xy4CFGncVCsxvW0tlaZfYUr+FNP8ZgRd3pVg+aO3Kk1zN6quM1PebvKwIxV/MyPU2l+ubdwkjSFRxrrvAxhwhVsNo1VzvYTSj+rYMmN72uuTdt1pDfgvvtgTXY5LlvgxXDlyyzI5oSpT57h/XXDvLGATuRoP/TPMJsJeYa/difXDiCvR4H9ARPylSO1Rc73lL0XQfm1Q/7FdbpBCex5aMu98yAGcUx3One4YfGCxzKHnLVLv516UNbS/EhDyBo+02+VVjzP5z41oJ5uXuXmr6lC6/XeHkjGWjwKFnjFkO2igj7amXNuGY8JlGiquaZvQT0ZrXYwIp2a+eWem1sgANspIqfO2Q3dVNtSEllQPV/rb0IXC01w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(82310400005)(2906002)(86362001)(36756003)(40480700001)(186003)(47076005)(83380400001)(16526019)(66574015)(36860700001)(26005)(336012)(6916009)(426003)(1076003)(81166007)(82740400003)(7696005)(356005)(70586007)(2616005)(54906003)(4326008)(478600001)(6666004)(41300700001)(316002)(70206006)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:49.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb363a-30b1-4aa6-ec79-08db7efbedd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

We need to grab the lock of the BO or otherwise can run into a crash
when we try to inspect the current location.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Guchun Chen <guchun.chen@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e2ad8e2df432498b1cee2af04df605723f4d75e6)
Cc: stable@vger.kernel.org # 6.3.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++-----------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5b3a70becbdf..a252a206f37b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -920,42 +920,51 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
+				    struct amdgpu_mem_stats *stats)
+{
+	struct amdgpu_vm *vm = bo_va->base.vm;
+	struct amdgpu_bo *bo = bo_va->base.bo;
+
+	if (!bo)
+		return;
+
+	/*
+	 * For now ignore BOs which are currently locked and potentially
+	 * changing their location.
+	 */
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
+	    !dma_resv_trylock(bo->tbo.base.resv))
+		return;
+
+	amdgpu_bo_get_memory(bo, stats);
+	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	    dma_resv_unlock(bo->tbo.base.resv);
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats *stats)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		amdgpu_bo_get_memory(bo_va->base.bo, stats);
-	}
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
+
+	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
+		amdgpu_vm_bo_get_memory(bo_va, stats);
 	spin_unlock(&vm->status_lock);
 }
 
-- 
2.41.0

