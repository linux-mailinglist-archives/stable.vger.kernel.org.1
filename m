Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6772E705
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjFMPWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbjFMPWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9DF171F
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/EGBA8ZQ6/CwedhTzOBV2aeABnm0O+L8rB0b6uVSp9EzCHp79/DjujxYQjvwsDmveMzg3EodS0vIP3SFIg2Nia/HiygdKHFNZ8RcJIWEqGxOsHv9dFYyjOtrOWWR3JkkbgjiRSqqd+/25jwZdYgEQf0gL5N4NDR0hjc1TzvEeggZr0CJcwplTws8NwOeMC/qh4vxA0Vdfsa68f3HW1eQPcFH2PpJFMUjzwoP0Myp8nH0y/SacDWSd/RJ25+cT7VOCsPIWwQP5zo9n8pEmB+4g6OUVa9Em3xYJjMi2VfFKr4Xffb9AiaUebf9L5SB2udQBaYbiB2A3YHVSPIax6bNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsaZCj+/xtEH2vEGvkn+GMY/ryzAvI5KNwMjWquHXhI=;
 b=dEY90KngysenCZt5GJA6f9lQ8ncQyJrlPOJG3q6ZE6uKNOr14z7Fa68tHHwz+MPUAfjqwDU6hyGuGLLywybsieB6BffLgGtV4TfwhXQngR4b3YA3SCTE0oi1RsvHplBzNUSzFkH2hceI9S+yB4UYXZLBSeVzhC3TjKHBZk3CnXZi50UhqbPykmAoXNxo7hC6gZD+K2AKyHyLg43MT6Hmee2l+stTtuDUXMzqd52/Wgk9/O3WYS6LihrPkol5rJt6neLdCYDIWM22iXCoD0mBPlXchcdNSxfhGyqljWPSbVwXvmr6IzHgL+EhH2XULD4/bnPlEy3ziXj5ONiFoLx9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsaZCj+/xtEH2vEGvkn+GMY/ryzAvI5KNwMjWquHXhI=;
 b=ZqBKAJGOX48MSv2ezRTYBYizvJyqjokO8hBif6oOhv9PMo0iT7SM/MRHeqKytFrf3MQx1QPcXznD+yUey44OwJ7PeMFUAbO+iC10L4+o/maYH0Pn/kZkHAopuGfg7aB0cTuhA9GvEB2SNdhwWBPfDZlMM5uiKxql3Lhc46uYSAw=
Received: from BN9PR03CA0252.namprd03.prod.outlook.com (2603:10b6:408:ff::17)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 15:22:29 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::e3) by BN9PR03CA0252.outlook.office365.com
 (2603:10b6:408:ff::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:22:24 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: separate ras irq from jpeg instance irq for UVD_POISON
Date:   Tue, 13 Jun 2023 11:21:58 -0400
Message-ID: <20230613152200.2020919-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3c99e5-ecab-49cb-6c58-08db6c220092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J36LgP89vQB4gRH4q27vqz/FmonIbAZUjr+mGw6ALDXW4JkaI2TjtwQlDkM4dxiWcW9+E7/7FvpXWP2iNQlTe/3Xoc+Y3aHgbokEH73bMdb6o2WoKTY/iF2Ioqe4p2K0lNHIEEalxZA4LHdhuUz4pZwO7FHtLOTWfQlppte2WeRZT3OUHIRStYG8bUhdnR7bELFxkfg3GqPhWYY5XdVMjwmvdrIJa+ZhOvyGMyciKlf0OcbuSyhs/Rq8vn2E1A0LvOE/LqVbltCt/6TIWZ7H6dc6TwpgAJ6NCMsiQTu7JSKQjV3eDfIJS5S6aAP7JbnZocgdA8zwqTnwUWYjLT4knR9qp9OhB2Ohq4+KxAcO3MBJBR1UU3UwsdOcQXn7Izo8iMAVmNioA/SpeHKvvrRtdv/hzUWUvPdsomfe6zEui3d9tovzBubAXm7LCzjbihJWWiz0GM3ZsigMQR7/iwxI+ACylMUXDiukU+SH6TQ1vZKRvFU7Cy8Q6aoP2z+HjB7LSccJajWV+apOF9TEZKQxqsuL1muWw266Sd+FbpxFKRaETThq/K1q8K6/9OT0Cfam5BeO73F3OxIYF8DzSHJiMTZ6q4XB68GUhaHedNZhyJTSraIUAmKtIgeC6aP3wI2eMHfDd+DARtjwzR0V4IGSbsEULENNrrBoipVH4s3EhiyOidPEx1cPXbUX8pe5RMiRIsz46Pq5l343Lm7+ZadSOiYBnlRrPtmJYgt1VQ8DOvM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(478600001)(54906003)(5660300002)(8676002)(8936002)(36756003)(6916009)(6666004)(4326008)(316002)(40460700003)(336012)(426003)(41300700001)(966005)(7696005)(82740400003)(356005)(81166007)(40480700001)(83380400001)(186003)(1076003)(86362001)(36860700001)(2906002)(26005)(47076005)(2616005)(82310400005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:29.6872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3c99e5-ecab-49cb-6c58-08db6c220092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634
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

Separate jpegbRAS poison consumption handling from the instance irq, and
register dedicated ras_poison_irq src and funcs for UVD_POISON.

v2:
- Separate ras irq from jpeg instance irq
- Improve the subject and code comments

v3:
- Split the patch into three parts
- Improve the code comments

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ce784421a3e15fd89d5fc1b9da7d846dd8309661)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 27 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 479d9bcc99ee..6e3858bde271 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -236,6 +236,31 @@ int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
+			if (adev->jpeg.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->jpeg.inst[i].ras_poison_irq, 0);
+			if (r)
+				goto late_fini;
+		}
+	}
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+	return r;
+}
+
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -257,7 +282,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev)
 	adev->jpeg.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_jpeg_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 0ca76f0f23e9..1471a1ebb034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -38,6 +38,7 @@ struct amdgpu_jpeg_reg{
 struct amdgpu_jpeg_inst {
 	struct amdgpu_ring ring_dec;
 	struct amdgpu_irq_src irq;
+	struct amdgpu_irq_src ras_poison_irq;
 	struct amdgpu_jpeg_reg external;
 };
 
@@ -72,6 +73,8 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_jpeg_process_poison_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry);
+int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev,
+				struct ras_common_if *ras_block);
 int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
-- 
2.40.1

