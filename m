Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8641D72E704
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjFMPWc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbjFMPWb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD68519B6
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USfQioO3X/OWQtETirbAHf0a/5gpCIi9ky5vr3Uq8IXYl0GDEw3OoLH+7TApXVQdXpU5PJkQ/Grt+oLDKO4smDc2+ahBzL172UEgnMc7kDs6jY9tHgmMsohg9iAd1Av/7kHGEtbZe2BM0qzbvxwyfnLhQ/slWwfCNK1OAZzw6Pb7okI3I+0k9odVmU6zhXzU3LNTYVmyyR9F1n0MxpozC4XVv+FSpsCB2bxN5aycAdYB2VZF6Q2HhrGAvLG+8s4UZOd1YpLdFTQb9bgmGKBgQwJ8FuklaLPA4O152rc5hDKNAyBgbsT5fLwZMMoBe8b7sYWdqWm0q8bA64bvYfEPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDOxw8mqCFYcthSAj3MsepdXDt+2mm1pNMAgeQ4xoJ0=;
 b=ElTOprLrPmE/UrENYy9wQVlc+lNz2LcekooVS+zeaSSmmrKCpxdyfP+BeC2UelYG9ue3uZ3YGALlLZ+8xgDiBK2g6R9FyLqOOM77YGiHTV3QXi+Nc6d4je9vJCzQ/1xJ4Ulru/OMm/PuLAUdNcINnHuVbos1s6nblYcc3lWTMOU7ahWfzjJrCAnp2ueQN9EBz1Q4AqVnKJGh0y+fmhyevO6Cj2gezZ/VpUKHZlycE/1Hb3E3QkzY6bC0NMunLWcVXFo0FhlIC85EQkxeIje8g2+lQT7ruCFv+AyKTdWoiVedxm2JhTjGnfw7pBilfJw+YtbQ+MF4X4yt1FfDk8fa3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDOxw8mqCFYcthSAj3MsepdXDt+2mm1pNMAgeQ4xoJ0=;
 b=Ome2I4HR3gXYqer66LZLGpe8mTozguzWtAB8A0kOFep2Oujezo9lAFv/nus6SM00ZLPQk0R/5VaqVaMO6Gs2VIKcxCkbWW5GqxKtF/gY39YmXLxL7V+iY2a/Xk0XUshrTGafFIo46TFPeYNP6Wz3vA/pi1FTuZw4Jzhrvt5uVj8=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 15:22:27 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::6) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:22:21 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Move vcn ras block init to ras sw_init
Date:   Tue, 13 Jun 2023 11:21:53 -0400
Message-ID: <20230613152200.2020919-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c68a25-78f3-4b18-bba4-08db6c21ff57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzk5WDY9LtD73vcBqSNWk13bxWQNjlVYQOcKVHr/ivvMZEaXBhuWfAAj9VIlafB/1IVI6GxUyIkP1pR1TEsppu/fsL4kSFM3p5P9JALGTNgHBl2FPA9fwPSrKlhR5svwIHXshoPXdUs6XPs/6bw6XnLzBBmCvh4MeWvKbQ3SlxIuSB5OPC65Y1KLpQ5tlDE/Jwf4PPGl+UjbehdlV+jR06Sfi1WIGRIADt+5fAs+rVAG+DTpLgGSzBGBzXiJEvGJXwcnWYXtwTcCpJjg77ogu4uwWBnh+J4gkrch6T51vS3H1vmjj9jUFqOfy9Adh8W+svyZulr5fUgfXbHpImhNXgJzFsqcYbCj93+xk5NqtHieqv4Yxodv7k1Tuj3Z0TP2krMpFXjjYusG3rH1tC+iTwTYHfkTeuIwJL1yyUZD9Pk6F+1YJ3tQbjGR+/KXhDlr27Csps7wG8GkPkXprPipTjdX6KKXyfi8iLVw0E/q7+BfFa4zjHOasmdQ/6OKzWfoZeCSyVxtwYD3FdUQLasN2ezBVFRbUJy6Cco+LDHwD924IgeTvpEvC7KDxOz4aSd7vNfeoNLQY1vxeLk0sgPWjjFkzEGIz6AUaYiEWNeQFV7RJ82m3IKT89kxfIu26wUBw4IgbNhuKgNGN82cZ+ylugndTQq4ZUROJdX9zq5RhueWRlr/JcBkAEbt99rIvg1YTUo0lZYGD7gIm5Ai4PeRsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(8676002)(2906002)(70206006)(70586007)(4326008)(54906003)(6666004)(7696005)(966005)(41300700001)(1076003)(26005)(6916009)(316002)(186003)(16526019)(36860700001)(82740400003)(356005)(426003)(336012)(47076005)(83380400001)(2616005)(40460700003)(478600001)(40480700001)(36756003)(86362001)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:27.6248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c68a25-78f3-4b18-bba4-08db6c21ff57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize vcn ras block only when vcn ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f81c31d975b463c24506d817a48390621f057a57)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 +++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e7974de8b035..e63fcc58e8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1181,19 +1181,28 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_vcn_ras *ras;
+
 	if (!adev->vcn.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+	ras = adev->vcn.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register vcn ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
-	adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
-	adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "vcn");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->vcn.ras->ras_block.ras_late_init)
-		adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d3e2af902907..c730949ece7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -400,6 +400,6 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
-void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b0b0e69c6a94..223e7dfe4618 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -225,6 +225,10 @@ static int vcn_v2_5_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
 
+	r = amdgpu_vcn_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2031,6 +2035,4 @@ static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 43d587404c3e..720ab36f9c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -181,6 +181,10 @@ static int vcn_v4_0_sw_init(void *handle)
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_pause_dpg_mode;
 
+	r = amdgpu_vcn_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2123,6 +2127,4 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	amdgpu_vcn_set_ras_funcs(adev);
 }
-- 
2.40.1

