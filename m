Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867C779939
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjHKVI4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbjHKVIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 17:08:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC71EE
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 14:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyG6bkZDjB6HezY9y7SCWlSjKz97JAaBIKksZdc7wjqATZ8GZ+iQl0e9V3pOVWoRjr6eMvy+Buwgodj7QsW50Rq62qqniVT2Zdi2deiEWOr4+9mjAaU9Chcqf8cyc+MOlV8BrX0v0dWnf1Znbu2o+le0gBeo7oHF9bnGPqWyyszu0d9iETLk2dhAxbSFT0/trtKXJWcXTOiP2GRIOKhlYv6JF+7JUBn7UTJzeyVXedoiyuPaMZcdQi/tfUJ4+UAOY2l+2DiiUItyouHchitfCaWfO1XNQJ11vhsNLPJrnX38a4+/uobCqSULjLld3/mhWZG/sOgBzYYV1CxgqLB2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvN1DgT6CzqSxkLfCD7FA/cFcXVI4FZZZUXDm7Fg0hQ=;
 b=HjCBBP7jxWf050VqWqvph1ovk5jn3ARGiO8wJyAwC0Tb8UCZl1xG3MJd0EjTxqdPpyypUJMAiGT6kdNGDNj8UxPISI6dqtW+mi7NeTnjiIZWHJia1RifhxHT9WTtXWdGvgpeH83n6Hh0/pNRoa9FeR4VeCQhUKPD9jCPA4UNSj/L7Vd8OauGqdgFj5yzDFF7EaY18Z+RYBvPjxZUsVPAuEGYO1t47OqBbEA4pFm+0Ys5m3e6+haX6BOMHDnMfFuu7C0eR1FpVmGdzTsq30T3gEaJpbs3bMtwcex2i7uAHlA/R7CKYCcyKSNvpcCH+fHQ5+fFzUthvmunzAsL2fF22w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvN1DgT6CzqSxkLfCD7FA/cFcXVI4FZZZUXDm7Fg0hQ=;
 b=blyErLvxG26/i7uE8vDOcLB2DtrJ9fvGnbD/RX6Y1ya7nTIrOvJDl6Ik+V1UsQ/KLaiPwGoZhtd9vO5Q720YyCAejCiJd0yz+8OnuHWsxsLQQwSbnWi88BCn+r9phPR04Bcrbb3vykCVeeDHl92y9fbi3Q1jXfP405BKPrG+W1g=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:08:48 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::d9) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 21:08:48 +0000
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
Subject: [PATCH 6.1.y 09/10] drm/amd/display: fix the build when DRM_AMD_DC_DCN is not set
Date:   Fri, 11 Aug 2023 16:07:07 -0500
Message-ID: <20230811210708.14512-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a08042-ffbf-456c-a57e-08db9aaf281e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7lYEIcYcB5H7mDCrXWa1JlUPiA65KyNZbWmuqfrLSg9/cq51YIBwsWgun9+A9Bce5pkTp7Q/BBiveff1uHeDUULF8njqdf2c9YN6R2OEhZ2ZwZh1wMR4iYEpJNmtVvHgGJuMiwnxB6g1fqTmZdZvFECPGMLT/3Pa7TQUVhc6nuCA9VtRCuW92ivTCu8Z8BMiCoLrOKiq5ZMqBQVNtpgveZkqKes4MaxH5tN2XN3XuDPgAT8QyCnG30Ja1pQvTM3KJutF0jmW9BfVpAP+HSFc3KIIEP2PCkFr3zG/1X0xrM9X+lZ5LWaGTVGMeP18avKx858rn7NNNAmDC4x/70V9bDe86tyyDBr8Is99+HxAyV2i4J2vXun7JvhnDj2C5yNvC5XB5edEW9MLDACS3Kf5655tALz9yhIOJO5xGmPBmjdZlOAxky7SY7akMqSQ1ffkyGnd85MkZexxnbvljv780Cdy7hiMzknmG1Li9bSdE7z+7ANF2gSYh03ert92HsoB+rhoBgq3h9gWlMC6Ada/Lm0DkfajX4Eq3OYEgZUcU1XXBcRnaEnDiwhZFznZX9DHXbMHvfJluc+cx9U/7THeJKSl5y+yzPgMHKjn6pz0Z4ZBFYJ0N1/kV5zzdG4ERXblxufIlJ1YZYdiF5uDIyz+ly2b+s+BnFUfus3s661mfmAeSx9FhCwWBwHWgGYnZAKdzNtZoekB7cL8vhZptrr97ryDEdfLKmGtve927DEFv6J5sSBdZc+nrHI1feEm3dxwVd1yBnl2UyXgxqdHvm5zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(1800799006)(451199021)(186006)(40470700004)(36840700001)(46966006)(47076005)(70586007)(8936002)(2906002)(8676002)(82740400003)(4326008)(6916009)(70206006)(478600001)(54906003)(41300700001)(44832011)(316002)(5660300002)(86362001)(40460700003)(7696005)(36756003)(36860700001)(336012)(6666004)(356005)(16526019)(81166007)(1076003)(2616005)(83380400001)(426003)(40480700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:08:48.4546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a08042-ffbf-456c-a57e-08db9aaf281e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

Move the new callback outside of the guard.

Fixes: dc55b106ad47 ("drm/amd/display: Disable phantom OTG after enable for plane disable")
CC: Alvin Lee <Alvin.Lee2@amd.com>
CC: Alan Liu <HaoPing.Liu@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5ca9b33ece9aa048b6ec9411f054e1b781662327)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 974f2c118a44..789cf9406ca5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -184,8 +184,8 @@ struct timing_generator_funcs {
 	bool (*disable_crtc)(struct timing_generator *tg);
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
-	void (*disable_phantom_crtc)(struct timing_generator *tg);
 #endif
+	void (*disable_phantom_crtc)(struct timing_generator *tg);
 	bool (*immediate_disable_crtc)(struct timing_generator *tg);
 	bool (*is_counter_moving)(struct timing_generator *tg);
 	void (*get_position)(struct timing_generator *tg,
-- 
2.34.1

