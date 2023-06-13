Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F372E702
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbjFMPWl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbjFMPWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51519B7
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVir77J+sp3q8j7S3RS0mzepr9QZjrZz96FKk1730PLXAKMa7aWpP8k/4keZbPknBl0P6TIDQmny4hpV0UL713fy0fmdT/R2m8MTza8uMjhdPEk+KyMptNeoAhhWy0B9AiExudwFeuk5aKGppoN6OHRtU9bBxeL3uKg/qXWQsi9v0l5O2bShIA7QVtfPgHem9iJxYYNWllJi22q9dKjqhKCnl047/DH2MDC+Yedc1gpXlUV9zGJwBAlZA0erYLQC4GeuaTaG4NPsdnBLlv0DHJi3AzmiPy0V9r905/yTgEPcERCtouAZ/Ng7tI4eMfzcz/RxC/q2ayf1DNhavYoYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S7jeSpwXBfRXVONnZ5ZaMFuIou6+TNeRMqQoeRbZrU=;
 b=kjiV8pZANcdfOTjNel+rHHQLZ0nT4RKF2M9TuGZvqukjsF5pUJGaYi5bLgh30jaYDw9F3ygXje3TLlTGTphzOw18TR1mgOpuoQgaew/P+IqkYkbbLmJaQ+2bTgXChNMphdqvJYednhldDIMO9jC2s/qiVDfXmJVZJJ53WAdB580UEo8BrDwNspPs4/Wvk05lBIAGL9asunCIduR9lOmuUjFBx6zgfdpmzlWFuK7OjqZsFWgiVi+cT8cG+PJF+wnF1AnJWjGQBiivT4Ptq2W/zLvy+vrfdhmMd7aTUUpzy8uO4cOnWPWn9ulXnYiaciuHsBMnBvXw606eHl5rFqT4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S7jeSpwXBfRXVONnZ5ZaMFuIou6+TNeRMqQoeRbZrU=;
 b=zKoZDQPTnEGCvpz140iPzX6f1vxSr1dLVnFfhAnH8SGjNChsTPYBOLwzQqEu0ctDib+1oL6CWjTMIbKlMPSCMDk5fIx6J5+55vqqKaEyJTeMFkPTEMcXoLt9AT3NXQj/FEmvsnkxfkvNJoPoxiKNu8a4eDgugDmvp+x9+HzTQAI=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 15:22:29 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::b6) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:22:23 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: Move jpeg ras block init to ras sw_init
Date:   Tue, 13 Jun 2023 11:21:57 -0400
Message-ID: <20230613152200.2020919-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613152200.2020919-1-alexander.deucher@amd.com>
References: <20230613152200.2020919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baaebda-e4ec-4583-8b34-08db6c220069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkUPNGg2UKq5QK2rZB7qwXDIyQ9Asj1VROQSZPE3zrznv+sszvp0tLnFHWWTP2tYzp315KjBt4YTk8aQhzSVjYh3wyOqVzEh31GWJRtv891zuFChmMScwTQXEiQo4xPb11omr6YTRFL1J/YYEs8Y302ZrVPnPEBdfwYI+X//D+ssIq1JcdPPr/0coeW4iFYAWs36BexsZBojKQKW7zYXv0buRF4H9ZkOMBfphxG+b3JhNVXopomxjwRSie1xF5X/cjn+KO4AKzmb710SVTv9/KMSVpvG7ocKYX4x2wT6hpnYB7XzsdGlh7BrVdqezyNMKNFgUUK5leciUd77qDlFmK2CSkPDSRyExuwzdPPYA4lQMNyLe046GZppTdjstc3wjk7KRVWwfEGWirlWzRfpr1BP8G2b07EI9xAkUHFK/n1ml3zD82U8xHsXTcH/N3KsVKNTYMzQ9ZhWcJx8F2wgHn4ZjrJ+HBBmhOgr6WIt9eqCT8yFabnZb8UO8vhQ95MURh9OuBCxAEcJyI28T39zcr3aqB20TDBolFi40BNe6iPUuuszBw7CGrwglFgmhAobIFT2+kRy4iO3n5x3cH+pSxkciYzNPkoHu0xrSIuMsyeqZQn73I5mqlahGD+Zq79uFljWgR7kr9FxUw1pj89/Ln1MCEkG/PY5PyXp5QJ7fw92gvUaeR80giGPLVAt7APS+GS0rkDYqpseygSP87xtcix8okph1Skv7xTbslRwnDY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(6666004)(36860700001)(966005)(47076005)(426003)(36756003)(83380400001)(336012)(2616005)(86362001)(82310400005)(356005)(82740400003)(81166007)(1076003)(26005)(40480700001)(16526019)(186003)(2906002)(54906003)(4326008)(316002)(6916009)(70586007)(70206006)(41300700001)(5660300002)(478600001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:29.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baaebda-e4ec-4583-8b34-08db6c220069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
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

Initialize jpeg ras block only when jpeg ip block
supports ras features. Driver queries ras capabilities
after early_init, ras block init needs to be moved to
sw_int.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5640e06e60198d9abdf6c618c54d982d8ec9cc0a)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 29 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  6 +++--
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 6f81ed4fb0d9..479d9bcc99ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -236,19 +236,28 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void jpeg_set_ras_funcs(struct amdgpu_device *adev)
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
+	int err;
+	struct amdgpu_jpeg_ras *ras;
+
 	if (!adev->jpeg.ras)
-		return;
+		return 0;
 
-	amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
+	ras = adev->jpeg.ras;
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register jpeg ras block!\n");
+		return err;
+	}
 
-	strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
-	adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
-	adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-	adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
+	strcpy(ras->ras_block.ras_comm.name, "jpeg");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
-	/* If don't define special ras_late_init function, use default ras_late_init */
-	if (!adev->jpeg.ras->ras_block.ras_late_init)
-		adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index e8ca3e32ad52..0ca76f0f23e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -72,6 +72,6 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
-void jpeg_set_ras_funcs(struct amdgpu_device *adev);
+int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f2b743a93915..6b1887808782 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -138,6 +138,10 @@ static int jpeg_v2_5_sw_init(void *handle)
 		adev->jpeg.inst[i].external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
 	}
 
+	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -806,6 +810,4 @@ static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3beb731b2ce5..3129094baccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -113,6 +113,10 @@ static int jpeg_v4_0_sw_init(void *handle)
 	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_ras_sw_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -685,6 +689,4 @@ static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 	default:
 		break;
 	}
-
-	jpeg_set_ras_funcs(adev);
 }
-- 
2.40.1

