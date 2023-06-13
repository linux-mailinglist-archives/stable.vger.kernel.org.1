Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6478672E706
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbjFMPWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbjFMPWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70531BC3
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc8WHxgKthpeMsdiWm8oINC+QaKoShNuqx4o27O2bsm6gu+35IewM8PpsP+ELlaYNbb81VJ6tCung6tXBvKSBaAimi8vLXYNp2vh9FZM2wrYZwCaIMfMRh901EmqZPH4t9Dey5JUcUo0l4gGAbRKnZCjXU/K6NmJwmdjQ5IYSKPGxd/WKrlIWi5QDnm7huXok4oNSisijJcufVBBj5YiXSzeiMH7OXO/1xPF2mTjCgEfu/WMfUYdIajp/1IX/Fmeuxnftv6NB2ywx0V6xdredvzQhMVAE5cJVN7F1t9eyRg9b8XWUztbZ4V5iUd2B6HlX/7HjDCeceWqGo8NyP1DFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLmP9376kpMNNEVsPCOFVQ9IQ1+ZWg0wQkF3a0vCoKA=;
 b=Bk0SZ3DCfm49Dsbbxx3hStSWCTs8KFwmUZhthEwr4OkKhrkwP+FoStjSkK0FkBaTCsOK+M1bdBtd8GPjEm8tfg1vcbM3tl3XMIqvq9ZtX2dPPZsY9CNx5NogHsfwOaclZPfcORdWv6hILM3Y0pA74LdXtvDC9ekJb2mim3frRMvxyeFfEUaLKcaE9/vi26BoEyec50wZ3JVIGlq6sF7d8TL+BOz08HtYeqCCMffPyv8C0FekMTgIi1yxBOUox6LucKS6j2H88CvPgfqru5rA80CepvfIxLESmJ0n98TiehpmopY8u8JbT7fcr0XsbiZGDch2hhAMaXXGTb8uvxrOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLmP9376kpMNNEVsPCOFVQ9IQ1+ZWg0wQkF3a0vCoKA=;
 b=Oe0tt2HlCGRRLLTxoynLfv1LfIQQI9wKy1+uEXNDhroBn2CYj/2kxMvPSyAMfHQ/qRVRJColgd0/Co+JXIFQhpEHnyTgtAaf8q8OkDzbQ1LLz77tq0prflMteQaO7wyHfiBqcvxDd1o2FlNWxRcnf6Ofs8NAbUnuHAGK4Ih6sIw=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 15:22:30 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::7) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:30 +0000
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
Subject: [PATCH 8/8] drm/amdgpu: add RAS POISON interrupt funcs for jpeg_v4_0
Date:   Tue, 13 Jun 2023 11:22:00 -0400
Message-ID: <20230613152200.2020919-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2378874c-535e-46d4-0e96-08db6c2200d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCDbUS9KhNiQoy8IkjmxgKg5W6CD9T/Qbvtt4fGnPmK7qspIEdqhFMmJNos6K9VPRr/jHSxwUVV2n5Rpqay4ZQyhcMYBU1Tiat87dI12SFVi/nBucQhEPt/42WFZbUCQeGtx5jIICYEcW8NaX4eZHSsUK7BaqZ4gDX/foii+jQqCuyj0IlnJkatrNub3DR88+LIwG5GpuRABFNSzkqmDwU7/S6E1RqEwBdT9WtexQWHU5lVHkce6EppaG86Zn+DLkvWkDD4dzCYWHKEvjiU5yevCpr9etzaPkYhiN8oPwSbg73Q+adlCEAu9ITwBW6GU17/2MyeOHBJQouAZWaAu5JSVyhgdqcjr8+lRnktTq4o6JbwoxuQvGX6gmTGOZW3P1BVQ9gO6FkSxmV79QTO91N0in2x18ZWCRqht04/vDHR8VJkZKDX76LZs3Kw+ZhXPWCPeTVtMEDgPAIZPQ9hSW4mnx+7EJS+wy+pyHnxWv9oL1fjowkuWzANenUDmBGAPVK/jsYIDvBul5fC+2rc39VshXrnw2oj71yYbhincv5x0Exo338yLPEfKzYB/rzitnjJv4qjKXNux8VBkOgripQ7RYdp2hroaGYwPORE8ALfEfzFudS0MC2hBjrRJckyzOrGar97QTfpypx2TOeIJU2aIhIYcONsNiSyaqSTi7GBhxmNdKi1jFXRfS0fcRupRW/qDfeNMo4zfqg1wKO/bcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(36756003)(41300700001)(6666004)(7696005)(316002)(966005)(5660300002)(70586007)(4326008)(478600001)(6916009)(70206006)(8676002)(8936002)(82310400005)(86362001)(186003)(47076005)(16526019)(40460700003)(1076003)(26005)(82740400003)(356005)(2906002)(2616005)(81166007)(36860700001)(336012)(426003)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:30.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2378874c-535e-46d4-0e96-08db6c2200d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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

Add ras_poison_irq and functions. And fix the amdgpu_irq_put
call trace in jpeg_v4_0_hw_fini.

[   50.497562] RIP: 0010:amdgpu_irq_put+0xa4/0xc0 [amdgpu]
[   50.497619] RSP: 0018:ffffaa2400fcfcb0 EFLAGS: 00010246
[   50.497620] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   50.497621] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   50.497621] RBP: ffffaa2400fcfcd0 R08: 0000000000000000 R09: 0000000000000000
[   50.497622] R10: 0000000000000000 R11: 0000000000000000 R12: ffff99b2105242d8
[   50.497622] R13: 0000000000000000 R14: ffff99b210500000 R15: ffff99b210500000
[   50.497623] FS:  0000000000000000(0000) GS:ffff99b518480000(0000) knlGS:0000000000000000
[   50.497623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.497624] CR2: 00007f9d32aa91e8 CR3: 00000001ba210000 CR4: 0000000000750ee0
[   50.497624] PKRU: 55555554
[   50.497625] Call Trace:
[   50.497625]  <TASK>
[   50.497627]  jpeg_v4_0_hw_fini+0x43/0xc0 [amdgpu]
[   50.497693]  jpeg_v4_0_suspend+0x13/0x30 [amdgpu]
[   50.497751]  amdgpu_device_ip_suspend_phase2+0x240/0x470 [amdgpu]
[   50.497802]  amdgpu_device_ip_suspend+0x41/0x80 [amdgpu]
[   50.497854]  amdgpu_device_pre_asic_reset+0xd9/0x4a0 [amdgpu]
[   50.497905]  amdgpu_device_gpu_recover.cold+0x548/0xcf1 [amdgpu]
[   50.498005]  amdgpu_debugfs_reset_work+0x4c/0x80 [amdgpu]
[   50.498060]  process_one_work+0x21f/0x400
[   50.498063]  worker_thread+0x200/0x3f0
[   50.498064]  ? process_one_work+0x400/0x400
[   50.498065]  kthread+0xee/0x120
[   50.498067]  ? kthread_complete_and_exit+0x20/0x20
[   50.498068]  ret_from_fork+0x22/0x30

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bc3e1d60f933f823599376f830eb99451afb995a)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 28 +++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 3129094baccc..230435d30deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -83,13 +83,13 @@ static int jpeg_v4_0_sw_init(void *handle)
 
 	/* JPEG DJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_DJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
 	/* JPEG EJPEG POISON EVENT */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->irq);
+			VCN_4_0__SRCID_EJPEG0_POISON, &adev->jpeg.inst->ras_poison_irq);
 	if (r)
 		return r;
 
@@ -186,7 +186,8 @@ static int jpeg_v4_0_hw_fini(void *handle)
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
 		jpeg_v4_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
-	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG))
+		amdgpu_irq_put(adev, &adev->jpeg.inst->ras_poison_irq, 0);
 
 	return 0;
 }
@@ -535,6 +536,14 @@ static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -545,10 +554,6 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	case VCN_4_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
 		break;
-	case VCN_4_0__SRCID_DJPEG0_POISON:
-	case VCN_4_0__SRCID_EJPEG0_POISON:
-		amdgpu_jpeg_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -619,10 +624,18 @@ static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs = {
 	.process = jpeg_v4_0_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs jpeg_v4_0_ras_irq_funcs = {
+	.set = jpeg_v4_0_set_ras_interrupt_state,
+	.process = amdgpu_jpeg_process_poison_irq,
+};
+
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->jpeg.inst->irq.num_types = 1;
 	adev->jpeg.inst->irq.funcs = &jpeg_v4_0_irq_funcs;
+
+	adev->jpeg.inst->ras_poison_irq.num_types = 1;
+	adev->jpeg.inst->ras_poison_irq.funcs = &jpeg_v4_0_ras_irq_funcs;
 }
 
 const struct amdgpu_ip_block_version jpeg_v4_0_ip_block = {
@@ -677,6 +690,7 @@ const struct amdgpu_ras_block_hw_ops jpeg_v4_0_ras_hw_ops = {
 static struct amdgpu_jpeg_ras jpeg_v4_0_ras = {
 	.ras_block = {
 		.hw_ops = &jpeg_v4_0_ras_hw_ops,
+		.ras_late_init = amdgpu_jpeg_ras_late_init,
 	},
 };
 
-- 
2.40.1

