Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C07ECEBD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjKOTog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjKOTog (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF651A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP2KUUPiNfqP3QUzNx7JPxYGB3G+V1C4PIsyJGVZ/6FvCASK0Cve1RfuwD8H4ROFKlGIhWF01nzR/8IsN62RcpCYmKXI78jR4QacZGMTxk4J76h34lXod+M9n0AedDJyi2YHMCRO6d5MaWRo6VSkG/0w5KryHEdXvccjZu+qwK35mB/ChFD9zYxZvKmdYswLLOYpao58KQcIAZJuBAvAOOmZ3LIgPXoMh9EKOPdLDT572EmzLPZ6FaZgSVnQD7+6fVGgjW5z3A48qYy6siJbrPtW8mTNVt92/05iQ5aLdUdMvXoDI22Hn6RhUecNno4iTkarIdq2oTkzTgBJWLG4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GarMhW3j3h1THDuRtxnOJMcYKR8YECMZGwAitTkJuc=;
 b=SxAOP4fy6rzELKOPomTQchgZpKn7oAj2Zp2xdBFWxFwzvCQDANo9k/cKPqAjq8H2vwekeGyqodvRWySSoNVndwZzI+yrnkBCUydJzRdyUKr0bcfctNRNoVVhzY91maOlELb6OZGkJclDM0lIOslIbBUHzuxc6c/JNJmIpqmSEFOJUBD8UcF4fe5G24HP4T7hBR1ioRcgOk7DEaEM4RSzwcU0l0Jvwf+dikiq1K4qp5gmdfPGbDuhP5KpO++6mUMxNDTX3teg8eD80tRF427cnHsv2CxmWVe2Dpetd0YJWzpYIyYUDq+aL5pw4hCBHJTn9E//A6UDUJ0Cn5SLqv+wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GarMhW3j3h1THDuRtxnOJMcYKR8YECMZGwAitTkJuc=;
 b=nbpgslL+SflEIN6m9vHk9S6gEtw4a4EVWQL0GhSjQs5lQdwXSWVo+EaAFN56V2Hka7pUPtSPCYUCwUHo7wDZciisWP9R5R+BWUSYjvX8zfGW1/fEL3Ae73qTL29T15WgVNMUU6KQsLavjUKgx3lZgxTw0YVpFONBK1Uo4/i9O7M=
Received: from BL1PR13CA0104.namprd13.prod.outlook.com (2603:10b6:208:2b9::19)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 19:44:29 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b0) by BL1PR13CA0104.outlook.office365.com
 (2603:10b6:208:2b9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:28 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:25 -0600
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Alvin Lee" <alvin.lee2@amd.com>, <stable@vger.kernel.org>,
        Samson Tam <samson.tam@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 16/35] drm/amd/display: Increase num voltage states to 40
Date:   Wed, 15 Nov 2023 14:40:29 -0500
Message-ID: <20231115194332.39469-17-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: b8be0f68-3829-4f8c-6925-08dbe61347ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEHQ6jrjTe50irtONsOPTzN/l3VQPg+B8cNgPlw87qN5p2LcSHYQSdmlfgRUxxWub57Uud8FRbk1TCQ7l7JIFjIF7p3S9qw4WdkWw+xN3wtek9NRcEtZNvjgxGEuv7iel0LfUCIJ0SWc5gQjhllJAW3d24oKke9gKXDHCf8czjHoCFZBcE0SaE9rwPUuYug8o8RtQrxfLrnpJBuIWqhylPe6aLn6sW1eGnLl+rEgq0nUFByn47XOVgeDVVXrHQeuh1UkYk+h+bxdVgOtUnOaMauVxrnIuuCMC+ocqz6DfzvxWxM+VpnGDXCo4GVcW1MrOMJIKePOuz1pWMDQTTL/v10KLTj6l1W60JwHSFOHcdPboleQ3vTTJnoeQpUDb8O8TIUegoWk1k9MNUuts9Ayy3odPOx2n4yVuEhwBChs+6HZdmoqORR8yDD65t5NWVlaAvtCnMmyxgC52OKMEL0m5CKzb4A1uGAQJ79ovHs9Lwo9Un35fLZf4hfxoshlbOtqhAijysmm7Ht517DYNQFaT+GYdkv5oLKTKAma9Jnw6xq6vvdv2XcW4sIrGlBrXNLv0xl8nBqNQ14wmECNvj1qUTKNbbibYpN5kgcmR9ql5GzRwJ0nz5T4YSvf7Q1QSb5mRyy5B1rWdyfhwVSzMf0qPsZ77Wezg1akEUpB4kqrLR/iRB5gZEaMJ6/LSDUQy9ER7aTo7tATjZHDtmuuS2ABGz2TSV2UZFsLWLpKQs8VwD5z/jXGeFGtBMZojd18uG+Ez2kQG0pa1Oy46LhaMDndXLfnRfAwSJEqGziHTZMfo11dHdNbEMwtLL3doR/Sb2I1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(46966006)(40470700004)(36840700001)(2906002)(44832011)(41300700001)(8936002)(4326008)(8676002)(5660300002)(40480700001)(70586007)(70206006)(316002)(54906003)(40460700003)(47076005)(36860700001)(86362001)(26005)(16526019)(1076003)(36756003)(6916009)(2616005)(336012)(426003)(81166007)(356005)(83380400001)(82740400003)(478600001)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:28.8031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8be0f68-3829-4f8c-6925-08dbe61347ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
If during driver init stage there are greater than 20
intermediary voltage states while constructing the SOC
BB we could hit issues because we will index outside of the
clock_limits array and start overwriting data. Increase the
total number of states to 40 to avoid this issue.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2cbdd75429ff..6e669a2c5b2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -36,7 +36,7 @@
  * Define the maximum amount of states supported by the ASIC. Every ASIC has a
  * specific number of states; this macro defines the maximum number of states.
  */
-#define DC__VOLTAGE_STATES 20
+#define DC__VOLTAGE_STATES 40
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1
-- 
2.42.0

