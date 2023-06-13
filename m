Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD772E707
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 17:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjFMPWc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPWb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 11:22:31 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF119B2
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 08:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUgFf6/td9xvXszpYNscU8SUf14CVCi3qHgUJIQbb/UPzDnk6VWPoLr3IEk1jlr7y0do7ZXd5mOpxKfocSkCUmx+reeSXe5c9iYJYXGnu1JJ9aEsFVnk0b/pGflJxKapAl3HEg0hPz5qGh6xyur/Bn/edHfrcOFjsqAhrl0Ub+KwnxpqB9x3dUFwgrhKNuKR3EfvXTjopj8BHW5ARcAVFgGpX5ClqehBHLC8SXlEWumenzOea8X9C/rOav5dmzLcNkhTwvAmrerHdZDLdQtwYYkyfqnEie/m/PS3yOMqGNEPXI9qKeswmEu+X8Cd2vFTAj3VPHUtu5CK0f/ZtRjGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdY5ElxD8Xoe9jLKQQUFa1pkOkl9sVwz1kAiCX/SGgQ=;
 b=eI1y8mxNa4nn6UinV4a1gK7VbOVz7A6MJJQNM/z/uLuQ8f92lRFm26eGUPpYR6biitGgNrhn/PuUjSAb7Nok8Vmi3+xrf1hn76nMrT1k948BUITS7tm/QbrwCNmP1GLET7Df06O+kE20lzhwAQ/FjOVnD2S5i1atrEFZ4MVpTDJfA5NZHggHmSrvt/+IhauYCHEOmTPAJCT5irMaizZjSpnTjlPTUzv+iw2cjn+Utlbo8xS8PhHdytzPwq9m+rn85kmfiXgOEtV0R8fEobsNRyNb8HljTXV1I9/KNFtQTiFtnsIUDHEH8RQxKL0QWll6Sjb5osjD92E5UNkRm4zQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdY5ElxD8Xoe9jLKQQUFa1pkOkl9sVwz1kAiCX/SGgQ=;
 b=B0e+SmOx3AMedgHYYgCNatvy1YScF7Ybi/nZNIk5rcVS5xjAobAqlbxJGPxVMm7PleExRL7H1fPH5NEWSzFMA5ZShuRCOKIKZ9jWq46FoAENZcWuhdiNb3hJNYqVCDFvo8VoJzcDxWXYgESzSO6QnorRiBFjeA5FzTJXiB2HSFE=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 15:22:28 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::87) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 15:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 15:22:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:22:22 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>
CC:     Horatio Zhang <Hongkun.Zhang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: add RAS POISON interrupt funcs for vcn_v2_6
Date:   Tue, 13 Jun 2023 11:21:55 -0400
Message-ID: <20230613152200.2020919-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: b9930476-24a0-46b5-ad33-08db6c21ff84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGvMpWnSGiTeGov9e0FOdh6oRSZub2jMMfe7vpYJRKPd56OzgQ5DT/tW8nZHO6mtzQpm4elX1kB6Mrm16X7REF+sXSsVyWkqWv3FyupfGl2nIHZ3JvN+SmvfdCCPHLCNgdLxyAS5CZpabOqN5rbIZeUiTbaq8cS3il10sVgHUF80Lf5h6NwBBCdw02xHQmAtm4se/0hcdrnc5VjGBihXqVZvNnh3ulb487zIoPSbYr6nUiSMA7QaXVlweNbcgqScG0M1nIIPvjr/l2c9nJUJbcBR0rmJj5lJvWsDwDEDG3g/IIsw5gFU+OOXYY3lvNSaKAZdyIvkOVgnpfbDmG6TiRX+4Itq2nfl3AXh7uJG/5IvSmnohZyLpVmQ+28o+NDHGyr8mGyFmij3yVESYuYkW9qBK95k/no7F0XURK9582abrLaro01fOCGBT/ZqFdwfpIuEk1AQg8UzCqFJCI8HnDydJABKflhwXBRqDeX1/W2jp2hGO2l7Sm495MThjmD5IAYcO1EH2JrRBggNkLhA7rdtOw1yarwq1K7+Cm2vYSK5jSzyWMrSsMJIWbIJ/Q2X7pKVLNJUwGHJMVXWVv3fTigyM6QJBfLdGX0Y84Ev7hG7rKXMtpfpFf5Hvw8E4yBKlBLer2+g7HljLDO0lYYoL0xPoHD4gGNSjAX7Cqx9AbfTwvO2Oi/rrN42VM7HyeqodUWUkAvwHI5dO5kVGifvHXbzDyB7OEu3RprQnHS50Rg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(4326008)(8676002)(8936002)(5660300002)(36756003)(6666004)(6916009)(478600001)(54906003)(40460700003)(316002)(41300700001)(966005)(7696005)(40480700001)(82740400003)(81166007)(356005)(83380400001)(1076003)(16526019)(186003)(36860700001)(47076005)(2616005)(26005)(86362001)(2906002)(426003)(336012)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:22:27.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9930476-24a0-46b5-ad33-08db6c21ff84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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
(cherry picked from commit 6889f28c736c357700f5755fed852a2badc15a7b)
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2612
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 223e7dfe4618..a878fd2c3133 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -143,7 +143,7 @@ static int vcn_v2_5_sw_init(void *handle)
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
-			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].irq);
+			VCN_2_6__SRCID_UVD_POISON, &adev->vcn.inst[j].ras_poison_irq);
 		if (r)
 			return r;
 	}
@@ -343,6 +343,9 @@ static int vcn_v2_5_hw_fini(void *handle)
 		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
 	return 0;
@@ -1865,6 +1868,14 @@ static int vcn_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int vcn_v2_6_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
 static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -1895,9 +1906,6 @@ static int vcn_v2_5_process_interrupt(struct amdgpu_device *adev,
 	case VCN_2_0__SRCID__UVD_ENC_LOW_LATENCY:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[1]);
 		break;
-	case VCN_2_6__SRCID_UVD_POISON:
-		amdgpu_vcn_process_poison_irq(adev, source, entry);
-		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
 			  entry->src_id, entry->src_data[0]);
@@ -1912,6 +1920,11 @@ static const struct amdgpu_irq_src_funcs vcn_v2_5_irq_funcs = {
 	.process = vcn_v2_5_process_interrupt,
 };
 
+static const struct amdgpu_irq_src_funcs vcn_v2_6_ras_irq_funcs = {
+	.set = vcn_v2_6_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1921,6 +1934,9 @@ static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->vcn.inst[i].irq.num_types = adev->vcn.num_enc_rings + 1;
 		adev->vcn.inst[i].irq.funcs = &vcn_v2_5_irq_funcs;
+
+		adev->vcn.inst[i].ras_poison_irq.num_types = adev->vcn.num_enc_rings + 1;
+		adev->vcn.inst[i].ras_poison_irq.funcs = &vcn_v2_6_ras_irq_funcs;
 	}
 }
 
@@ -2023,6 +2039,7 @@ const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops = {
 static struct amdgpu_vcn_ras vcn_v2_6_ras = {
 	.ras_block = {
 		.hw_ops = &vcn_v2_6_ras_hw_ops,
+		.ras_late_init = amdgpu_vcn_ras_late_init,
 	},
 };
 
-- 
2.40.1

