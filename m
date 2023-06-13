Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108C72E709
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbjFMPWf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbjFMPWd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136019BC
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdkiFOKsAoMZm/KJjUf6TIkzcU47sLiIArWGzcnWKR/Uwx5ggVm8oT77vgXG/uYV/VH7+m5cxQGJLb45EA6OkCk/tAf6KNOvdxVu2k+aXG+XbWlemwl5g3ytskxDeUCO85fa+HzPsyc+vC+jpadgQu1dRYcq8kaO+hgYYKFnBlwUbVnwB3jplQ9qclj4weeGDk169UiV4hlKV0/ydB5FBdPAMA+GS2s09XLst6K+UOsouVfYSj9KK4wGNqkd/6XTer7CR+kl5sq7a+KP/caQlROD4SH8qDRxcxQeBDXCv+Xl1JlMGvAy+fZmTLvx93cn/qcRas1vU0YKK/Rx3Mu0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB7vxH/NqUY+yMV8MB0J4I3Lm44W7bUpi6H0ufkjht0=;
 b=ltU62ONXZudELWtpm9WGzW54QKyi+nAWZQe+FYMwXmPZchCmh9KCUFe53rUGedUKbaVS9tuaCT8lJNpcC4UUNHbWKEL/zdeVfjNSuIOtn87VZ1PVsVx3APJuow/JruCSetBzttZVYYgLgHtRllnttKYhx7sCo9X2GCvKGxFLgVP60t85/ebIuR0w8SwjYoy48k8uQAlCS3YAi94c6a2r2EhJ5DfZg0q5HicKZON7fB66c6sPZJNf/uziyLUwhSJQCn0iygqHwsW1wfUUmEldFq4oihoYG9rYpIeYB/JNHS3kp34eZ3ox8LpfNMlmuiUqhZ8GHwl19lta0u99UGbqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB7vxH/NqUY+yMV8MB0J4I3Lm44W7bUpi6H0ufkjht0=;
 b=XkoKpA+kILgRB6onqmMeZ9sgJJDordTeeuMUNcTAddHXk53junrkRww/Ibkn+9BWc/qk0etsZ2aLYDtgtymKZKNv8TByEPMyjBlgJwhhmdkDa8C7WFVpYEdBWRiZ5+rPx0NbYuY4f6POEBud71pX0VUINhFaJ7ruHh2quvWiF7w=
Received: from BN9PR03CA0270.namprd03.prod.outlook.com (2603:10b6:408:ff::35)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 15:22:28 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::c) by BN9PR03CA0270.outlook.office365.com
 (2603:10b6:408:ff::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:28 +0000
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
CC:     Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: separate ras irq from vcn instance irq for UVD_POISON
Date:   Tue, 13 Jun 2023 11:21:54 -0400
Message-ID: <20230613152200.2020919-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a13c4b-8c73-44d9-0765-08db6c21ff85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xk9tKEQPWBnU2VJ3uCgfo+DEsOOqHA4r+rAni8L2QEnnRRhzTT+EbH7mQMaWNS41KVmTM/HpyF/DxSMp3FbeGCnTrIAWqmbIEkvBqYtxyBjtdqZcO/oI5veolEsSlEWWElWRgYm5DGguyOYO+UL4QKzFqyUmmgeKrWTrzBZETigH4QgPC5+AWX0CNJHAoabQb3xp3vECNmLXWZT1cncChY/MvZntgyyZXuGvHTyXzdFB5SLvMlhBmjE3VgYDn5I7fwLklOzAJMhbs7d1HGy0tLmI5bEjYYJahhdLOh0p6P/d5/Jypwm2CSRz6KRBjE2l90PJO7DIp2tUxJUghqYpwwY/3qJSmu42bCzUUxepTarEEFNdm8uXh5uRva8Juzbc6HPnd+MqGnkv61xQOXSppZ33aGAR0MRlHvwXX0XVT9omi1j0SqBV1MR2M3NH09r373md4LFBunKr9vbonn88lKA+Vj1jL2NrI65YzG5tS1YMBFrQP9bUY5d4UiDnO6WJGJk0oXQRY4TAD8bt87poU23pEBUqycuHozJl57wTbBN1B8PUjFNYGYbNrV1tNEdNEBfyk/MWi7x5GtDq5clK1rnulbC7KR9miozE/g0xpLtRwrpYGXTEsaW4BlnhcDg7K+5xXDnfkv0jqr7/6iVDe11r62kZn0ndzew6s8NAsB7viPYxh/RfTMpOEHz2DQhrJbe4/L7nqL9slPOnwBAcA3zV2LLufGFensZRZEjXm64=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(8676002)(2906002)(70206006)(70586007)(4326008)(54906003)(6666004)(7696005)(966005)(41300700001)(1076003)(26005)(6916009)(316002)(186003)(16526019)(36860700001)(82740400003)(356005)(426003)(336012)(47076005)(83380400001)(2616005)(40460700003)(478600001)(40480700001)(36756003)(86362001)(82310400005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:27.9217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a13c4b-8c73-44d9-0765-08db6c21ff85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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

Separate vcn RAS poison consumption handling from the instance irq, and
register dedicated ras_poison_irq src and funcs for UVD_POISON.

v2:
- Separate ras irq from vcn instance irq
- Improve the subject and code comments

v3:
- Split the patch into three parts
- Improve the code comments

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ac1d8e2f074d9bffc2d368ad0720cdbb4c938fa5)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e63fcc58e8e0..2d94f1b63bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1181,6 +1181,31 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r, i;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+
+			r = amdgpu_irq_get(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
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
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 {
 	int err;
@@ -1202,7 +1227,7 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
 	adev->vcn.ras_if = &ras->ras_block.ras_comm;
 
 	if (!ras->ras_block.ras_late_init)
-		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+		ras->ras_block.ras_late_init = amdgpu_vcn_ras_late_init;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c730949ece7d..f1397ef66fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -234,6 +234,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
 	atomic_t		sched_score;
 	struct amdgpu_irq_src	irq;
+	struct amdgpu_irq_src	ras_poison_irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
 	struct dpg_pause_state	pause_state;
@@ -400,6 +401,8 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
+int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
+			struct ras_common_if *ras_block);
 int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.40.1

