Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AD474B3B9
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGGPIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 11:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGGPIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 11:08:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3AD2115
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 08:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwP81E6NH0NjLeUt/OhogwU7+wIJ8Siwpl+aOaDopI2VqThYnAoHuTEqqW8xgJHGq6mYuQ53oUu4it/WpF9aSNxT4CjXtuLubXMHEw5Jzhs3N0CmEDSYZzGanwPxkvGTgKI6obbHxlbZqsmV9afXya0HJqfwj6vQoqF0f2h6+wwz6GxXQohLTmYQTGKF6vhAhO00nmTQy2Y5fYpWHG8OgwhKD7I4csBDVha44HOl2K3aGrJpX43yK6THmODkc72Wf23nuZUPd6jhINzh/mPNItC5du3UASX5I4wz7M1PgMVwmlDoNEyCrsMBECdDqq4beAKxRS/a0N1vcVDSC4TMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5SBjpd+1NTrPelvPRg7HJqS8ZjrWEqxq9rq7Guq50M=;
 b=guqAiidlkX8rfFU1UZifc91MG5QaV7dOApRJV/pHU4eDemeV3ZO/XwiIlYWvu4YysTm3PO/yrUgifCVO3NJPXOgs4Dw8xeZL6NguDeYfFnPjmsa0xQTXkD1hJssecTjrvqIvxc8RSaVouP6U0hhHO0pYWqWfE8UM63iHR7l6gMZojTmvUTJggflvDuA5O1uHmn46EeUj8ilORav4FvK+x+8KryaV2makOtPXVKXVepUXMYo2Ijb9YnV44E2Fqconrw68Qig9lShLTPg0HhkMASLeAxt4dr9wE8WBlAQ3vXL6HE21DqDBPAabCWCAB12YWpMBxwe4QjU7xB69TRGZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5SBjpd+1NTrPelvPRg7HJqS8ZjrWEqxq9rq7Guq50M=;
 b=YrOqTpehQQMubOD3iy5GzbzP49bRT+lQj30gLd1b7p5vZQn2ycCwoiiYHfsMUubm4doUZKvkmm73CXWnI9705+cW9hVMbc5GUVUyO9+MaY4I+5xvOUNZZtLa5Ud/clqp2EBM8/lgVTJw7GFqvlhluh7jHFIZcuMeq+ybBazD5cc=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 15:07:50 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::67) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:07:50 +0000
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
Subject: [PATCH 2/9] drm/amdgpu: make sure that BOs have a backing store
Date:   Fri, 7 Jul 2023 11:07:27 -0400
Message-ID: <20230707150734.746135-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fc9b94-4332-4c11-bfaf-08db7efbee28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jvdEMxeCTU9VJ+hcz+P4Nij6F1pQ7qfRzE23EVeTlT2iQMMbjz7VysDtB1JIXTMJTd1i0zn5tb6qd8tEFpHWKpzIx7Yy1RNVhF0+veUYDKJq5/ZFGKC3r2opQY25NJ3iDDZY+HwqGY0nzQ95/Gc1kfWGsAGCUw0Ueo/iv8I/a+Mmiu3MfGdpF9sha9UmV7pGoKPlfrfyC56Rl72tFe678gEAiwescrrYib9X4ZGGNJcU4Udvv7Hv4CrxI7OZ5LJto05zrlP+L3Ta6Xud9pwEGTXWg+/UIipQ3/mUjz6HbgOt3VknYn8Ejbm4ugxxE35f6qvlbXptkikA0I61RseH80A2pVPOFxw8lr6hyl1QCXAVvCQiQuM8oo1JaebBLaiQQZO1BXkm4URC36D0y/Oj2f6PPzkgh/JvGKk0cGcV5NeDP/0OQYgueeRJJF8Ue7UbO3hDVVXP5Xbhw24BNxhCAGwO6pZVgKMQEDEUhxlB94bU+6n8eA7YGU4e9O3g+MieI4H4O4Csbq7LfjiQwhgKcFboibvBoplc5c9VzLPkq554SODFt2y/SogwkQRTlqy1UtLkrt5oEvxVcpKAwjqwx3Ajypang4sIu2Zjo51vEg0dWSei+GfCiNFpGDx+UsKXE5rEEqn3s5aAUB7X1mWQXISJXz3Qof2tW0lhkA8LrgDn7+z7RusjZgV8UIyuoVO+zm8Ju+09dVTQF394vg6f09epuSylMSclNM2HY/1Anar43ShYZtTwogNrEBRV3yPjciO08Cg3lwh97v0Z3VLng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(8936002)(5660300002)(4326008)(316002)(70586007)(41300700001)(2906002)(6916009)(70206006)(54906003)(7696005)(6666004)(2616005)(26005)(1076003)(186003)(16526019)(36860700001)(82740400003)(356005)(83380400001)(66574015)(478600001)(47076005)(336012)(426003)(81166007)(82310400005)(40460700003)(36756003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:07:49.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fc9b94-4332-4c11-bfaf-08db7efbee28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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

It's perfectly possible that the BO is about to be destroyed and doesn't
have a backing store associated with it.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Guchun Chen <guchun.chen@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ca0b954a4315ca2228001c439ae1062561c81989)
Cc: stable@vger.kernel.org # 6.3.x
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a70103ac0026..46557bbbc18a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1266,8 +1266,12 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
-	unsigned int domain;
 	uint64_t size = amdgpu_bo_size(bo);
+	unsigned int domain;
+
+	/* Abort if the BO doesn't currently have a backing store */
+	if (!bo->tbo.resource)
+		return;
 
 	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 	switch (domain) {
-- 
2.41.0

