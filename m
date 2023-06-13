Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE172E708
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbjFMPWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbjFMPWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251D19B6
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F87w00kyQ1vTW6WZMnAqgXgiNRMXZ03Y/3Vndw4xoXLAVEPGFgOQ96bmOdWpZuO+Sx7ykziu4hAs+dVTVWoL778OTZ/qWR/FmmdJO9vnQ2Kn6Uaajc/ZxxOPvZ36SicDX3mvM4bIohHPyopHIa3/04RS5wqMTEt++kw6HOu3CadU2S3w7D1+RoK3chDS32kcVf+/rNunV9e/HV1vbLvcNOhGOo+sL7GKA3V/Ff+wYTFYB12AwtmwCnpqbzX5A4BHwvYisoPyIlP8tcU01j8+OKWDI/7027RAlpGU21O3XlSYbaNDxihrEob7e+3QnQNat7Ep18Vqeku1+DkFxSFx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT+QAn5HehFn7vVVqnYGMU4lLC7SizNj/g62qKTU1VI=;
 b=jVWr64pWVHfsYblNxgX8Ksk8zda/4odVgOVeayZ51Vif1gCFTfAD5NVWJaUbaFIYVVI0H8h/fP/rfmnLQhqS1DeDaF5AUgIqDRsME6a43vp9ceNlyMYn4fSjN0sKu+WJE6qxljBFZqbd98ELFJmWQ8ADWH86VDfa0AVcvqlaijHYoq2BhTfXTVtSYkv5/ukd5pHVs9EndAXBFr2K0OlavVADRkoaNMHtMeJIevCZmzCzhZP0HZH5R3Nm+ghC69lNRqCKzKpYqmCsAp3IhEEQ0AUTSYP2+Qgh8iETDCPkRxInWDeDfVk8LorZd7dT+voQ4nitHEQi83u9JBdk9cFKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT+QAn5HehFn7vVVqnYGMU4lLC7SizNj/g62qKTU1VI=;
 b=oOFl1JA+mrlShT9BhEw1GoKtW7KFruLEoSvpmRa4pCI5KMqfGMTtRBxt8qvGyPJxTtFb+qzcPBbX4LI/taNayEGKsqsnEnUAjb+kC6ozeFAjEXo5RRmSHjYcGS/9wQ6C8wTVKelKSAtOmue044CcrLVtmGSB4vrExJ97GyVbNIA=
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 15:22:29 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::58) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 10:22:25 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v2_6
Date:   Tue, 13 Jun 2023 11:21:59 -0400
Message-ID: <20230613152200.2020919-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc2fde6-2df5-4d80-3967-08db6c220099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mLMW9/pO8CIoh/k0ByVaM+CPRzbL3QXeANm8Fpayz2og52tWWdTkAB8+r/5VFW9d7og+ErBkQALMrrg7qsA1uoUKCXfISYNwGBB0ZV7TfnbM35SUGSKF2H5lvtlMdrK0OqnAMceJ+mQHri4VDztJf1ilEVw3UUzV1R+/2berQwt9sUYDy4lqV90imVbeTFgZud98cepFqj6GajTq4RiPpxLBDZBefaY3iEu+5rbzCAIIBe+4bOXxOvw6iWt+lF+Vtk2bOrul5PYhkiLp+aoO1NeYDU7lZ/cQntZkTu/S8t3vIbab++kzsC7YJkN4tjFriPXfj5l1vXyoCIVesz3DGz/ZxB5hsq1j4BYeKFN90ezSEcfU5Ijq/ZwSDHoo4dp0ZA1SfTRg7tAhiHymR2rU39ToaZtnTNcufmNoB2vC/1vLk3Vs2ixkhJfCRqstkLxgLTGYbmCm1vQd72N9mjNwqn9o1Q1xh18bWUJSBlvVTeXcsJNWr0I2WluNvPjR0nVyC8F1qvFQcMpfBh6auf7yEAToTZIMJFvoN24F8Z3hTsAdJMs9WhtSMklwmEXyQhJssSHgX6TSa5MfBesEyipl5RrdR2AU6rxZpBvhnKEMF92lbIJDAh+bBrSikoBWwZOpwI59YCiQXBJb8ewdiJRNnOAD1TU4VqlqJlahnpacuncCZ/EDt85eVgy/iaT/I+SIXcHnTZMGVrMkIFVZZ5uwNTKv0b5LWdQOsV6rimb37o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(5660300002)(4326008)(70586007)(70206006)(6916009)(316002)(54906003)(2906002)(41300700001)(36860700001)(40460700003)(966005)(6666004)(478600001)(7696005)(356005)(81166007)(40480700001)(426003)(336012)(36756003)(186003)(16526019)(83380400001)(1076003)(47076005)(2616005)(26005)(82740400003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:29.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2fde6-2df5-4d80-3967-08db6c220099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5974
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

From: Horatio Zhang <Hongkun.Zhang@amd.com>

Add ras_poison_irq and functions.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 30b2d778f629d51e2ff30beb6d060a0bd7f70104)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 28 ++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 6b1887808782..0df8b9dbf13f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -102,13 +102,13 @@ static int jpeg_v2_5_sw_init(void *handle)
 
 		/* JPEG DJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_DJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 
 		/* JPEG EJPEG POISON EVENT */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_jpeg[i],
-			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].irq);
+			VCN_2_6__SRCID_EJPEG0_POISON, &adev->jpeg.inst[i].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -217,6 +217,9 @@ static int jpeg_v2_5_hw_fini(void *handle)
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 		      RREG32_SOC15(JPEG, i, mmUVD_JRBC_STATUS))
 			jpeg_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+			amdgpu_irq_put(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -565,6 +568,14 @@ static int jpeg_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -589,10 +600,6 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst[ip_instance].ring_dec);
 		break;
-	case VCN_2_6__SRCID_DJPEG0_POISON:
-	case VCN_2_6__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -723,6 +730,11 @@ static const struct amdgpu_irq_src_funcs jpeg_v2_5_irq_funcs = {
 	.process = jpeg_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v2_6_ras_irq_funcs = {
+	.set = jpeg_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -733,6 +745,9 @@ static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 
 		adev->jpeg.inst[i].irq.num_types = 1;
 		adev->jpeg.inst[i].irq.funcs = &jpeg_v2_5_irq_funcs;
+
+		adev->jpeg.inst[i].ras_poison_irq.num_types = 1;
+		adev->jpeg.inst[i].ras_poison_irq.funcs = &jpeg_v2_6_ras_irq_funcs;
 	}
 }
 
@@ -798,6 +813,7 @@ const struct amdgpu_ras_block_hw_ops jpeg_v2_6_ras_hw_ops = {
 static struct amdgpu_jpeg_ras jpeg_v2_6_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v2_6_ras_hw_ops,
+		.ras_late_init = amdgpu_jpeg_ras_late_init,
 	},
 };
 
-- 
2.40.1

