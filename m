Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748207A545E
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIRUtR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUtQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 16:49:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206FFFF
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 13:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaoafgPSn02GDYBI9dWMceOcNkYcLNTXCkbRugjdHMVMsdqOEw5ngeGC/o94d1Q7/+Ukvd4ZVl/On7FmqArkBaOKbDH4ynKv2fRyMaRHiSrV7PX2EqtXPxy6GFfvwHN6zsHhwoHa3aexH0gK7mPXL/g2BWUQiv+RsQztx67aLrJdUO3N//UUuYBGU5BWR0cUxXqz90olTKBD9oyryQ3t0Os8SZylVboDBrblBtGpwJC7c2tTDCA45tbKl20Nq/g0A9pHS8fyA4QD96lmJmwXY5L3J+z7NDuWhQouNk/Ebw2jtItOOYx7+WfZe89n7vW1KYQNiJSLWr60AnNcgj3hbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWXc1misAc+QfMnZKPwuvqbteGJ5bwrFM8rzk94lopY=;
 b=Ts8qlzAyCP3a/GHhy6Vez3RxVlepsVbirVlLeSdRRbq6Ba/D8A1EPHP0S3od5tQ6qAczjp5JAzxxlRVAmZEbAH9Lct1QE783usM2DutyZVn7NcAh+PST2YgKeO1Sl1AE1y7Chqxg5DGDhJ+TdZ37fy3/E5rfl+1iApHUNFQHNV4VT6RAqfSEpuDKVgOe78Un9UoV2wvXLn3aUERqAbQMUe2fjvUPzTzjKr7BL5hhAL2Cq/odkPfKJwttmW3r7mma/3VLsGItJxoPeb6z8andPxX1LpZcWzLOkLuFNmpeGW3QNj9JU+Sbex4Q/0gxE0nEc2hRihefRhOdWns1UDsSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWXc1misAc+QfMnZKPwuvqbteGJ5bwrFM8rzk94lopY=;
 b=ubH7TLFH8awkdckqbiuaYP7b6e0BdqNkkh1VFvVmTwPSeeQu7aWKCuQ9ewaVQsRrack716hgOHgwLE6RI6po9IbXdPFad+5Gj5ez8UnZ3iqEUmgUiOHkOS+3Y1SGjsrMXB4hHLUotUXJDFAgLkxNqy2zkXWuS+S3llr43dxAA/M=
Received: from BL0PR02CA0090.namprd02.prod.outlook.com (2603:10b6:208:51::31)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 20:49:06 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::50) by BL0PR02CA0090.outlook.office365.com
 (2603:10b6:208:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 20:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 20:49:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 15:49:03 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_cs_p1_user_fence
Date:   Mon, 18 Sep 2023 16:48:31 -0400
Message-ID: <20230918204831.2270796-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: c36ab71e-c7b3-47a2-4720-08dbb888b320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqKuVX83V4M/7ctfsq/21+j0aJ0/pSpEwAwGlgsP9l+lm9VsAHksZzy1gHrAG2+O5Inq8Iz/AXH8yFC4yN2ylqCyN8GiIaM6GCk6XVGySF+1N1YKI5CHLtAh7+gwbPMjqwa8DgI3xsiLViAVL2nbu/5Z4QGaI9s9NcD1K1wOv/JpOyBKh5naE6YMwGdD63h7ckrEciFztsIB/403r+t0eodaBVH0zpVZ9Ji3atPWCEK72qtZ2QCqHgDVKLuJFcPzF0T1xfHCKRGQsJsvDZgOMndF4qC6gSFuL3lIcoE9g+lwgTUv95pdOZLL4mSJsLFuBIdh7lnwKTISKZr3mdoUfu+TjCNYjYfX3xKDNevrxELHkUfYAcDS9bUslmBLuS0wmQpGheXnr+1j5y21/0PZGc4rMQk5QZ41QUX9NCRpdJIVyErfQ71DB6IP2ma+cgVwoEzKBxlxbw42zYaU0wk7o7l5JG3Yz2yKJmAb35S6LUsdm0inM76Xfw7kceKWj7Nlao4nyDHeV4TPNpNHKNpnKMBqlWQMW6TP1LlonwfRE/g71GNDz1XCswl5MAY/A/SaFLjiUvxEVwVguwnA2r7fWhyDcYNADOoWlxB2Bhg6wblGeXxtRM6p88PKZ+cMZ7/gq46+P9oAGs/Lv7bswDnVPnHBnODbUIEbfijsYsFAswTCqANDduD0fz6h6xGIfOTHgMINshgt/wvyHeE5n4jbpj3v8kJfCLOmZHj1IMVYrfMPWOhMc6fGLQmg23dLbZAVeTpvq17R/GTIkXkccnCeDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(16526019)(26005)(1076003)(7696005)(36860700001)(82740400003)(47076005)(356005)(81166007)(36756003)(86362001)(336012)(426003)(66574015)(83380400001)(40480700001)(110136005)(5660300002)(478600001)(41300700001)(70586007)(70206006)(54906003)(316002)(8676002)(4326008)(8936002)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 20:49:06.2888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36ab71e-c7b3-47a2-4720-08dbb888b320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

The offset is just 32bits here so this can potentially overflow if
somebody specifies a large value. Instead reduce the size to calculate
the last possible offset.

The error handling path incorrectly drops the reference to the user
fence BO resulting in potential reference count underflow.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 35588314e963938dfdcdb792c9170108399377d6)
---

This is a backport of 35588314e963 ("drm/amdgpu: fix amdgpu_cs_p1_user_fence")
to 6.5 and older stable kernels because the original patch does not apply
cleanly as is.

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fb78a8f47587..946d031d2520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -127,7 +127,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
 	unsigned long size;
-	int r;
 
 	gobj = drm_gem_object_lookup(p->filp, data->handle);
 	if (gobj == NULL)
@@ -139,23 +138,14 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
-	if (size != PAGE_SIZE || (data->offset + 8) > size) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (size != PAGE_SIZE || data->offset > (size - 8))
+		return -EINVAL;
 
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		r = -EINVAL;
-		goto error_unref;
-	}
+	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
+		return -EINVAL;
 
 	*offset = data->offset;
-
 	return 0;
-
-error_unref:
-	amdgpu_bo_unref(&bo);
-	return r;
 }
 
 static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
-- 
2.41.0

