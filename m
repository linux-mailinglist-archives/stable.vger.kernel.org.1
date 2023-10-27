Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F907DA085
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346434AbjJ0ScT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 14:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjJ0ScC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 14:32:02 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3784E1FF3
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 11:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3HhjnUyP7fhhf3wWtGi30nP4BPbr8ErYFELWy+rjGVVGx+ggG7UbC0estveEenz3/XEe/VTURKGdFVLPapPmPgKBRvrvCdLK1lyb1p4t68FzFAUoGkEGAda7nUdFygHreeUPydhh0k+i8qiL4HPhU6SSHoM3IJhxA+ERjUjq1++tjap5Ek1T+B2iqBgu6A5HBMs8a/FxBn5St+7VyB/TiNuLERFC+RLPbz2OGLSvrScEVvOh5LAce5ydFDB88Vf5B/iJCf7rZtf/drPDsXHQn4+nB4eRMrOEYon5hz3DdtZHMiGiNKVguLmhVo5clu24fdFGq5LV0ZTwlMEnqrETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLqShgCXnlrgQbU6IzF8Jt/Dno09KQyz6CNGvAyjKZg=;
 b=fPBis2iuw0C5o/8jT0JnplrE2ovS7DhTNO099xqguIoOOfqlLCCj9vt2i2DyvAfZIznzZlbERg+5VKZuHe1/glN5JS/iXMgmQ655cX0o3GnatlhT6vSGBq22fVb8p0UBfEBhkkzkgQhBCxiPLPBSvDFn+/5VbWwqlU6Zb097iC86iX7ZxmWMCCUEHP4fGVnOM7iBMXdqah/g+XNtO9AnS/uU6zfYEI3HcQPapvNnIlFIaFb4oEp4tw5yzz0XCPam2yydhhty0+qqdEW1yOm524SsxqRRd1cumdxR3euUV7tViHoHhliKfgCuoWqpxuXg6pZctjeTLIKTHs+b3wgtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLqShgCXnlrgQbU6IzF8Jt/Dno09KQyz6CNGvAyjKZg=;
 b=Dc/eRM3l45ZJp17wOF/G48XG+EGy6Mi5/N8KUpRYC3PuiRcPRb8Ho9ZqQZ4ITqh4mR8MsaUvtK+mVMmPv5HjjMyf5PWuqevqK+NgD9e3v4xgrqkHvlUqdVztbNdWpB9TOXCcHNsIN0/oKyvDkecb2E6vUUTpIIXrjj0zGiu+QuY=
Received: from CH2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:5a::27)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 18:23:57 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::66) by CH2PR08CA0017.outlook.office365.com
 (2603:10b6:610:5a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 18:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 18:23:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:23:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.15 1/2] drm/amd: Move helper for dynamic speed switch check out of smu13
Date:   Fri, 27 Oct 2023 03:39:57 -0500
Message-ID: <20231027083958.38445-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f914a9-4d31-4ef9-55a7-08dbd719e217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTVXc4XTTTcs/D6s8S/uFVJOS6YtUkJ9zpJcn7HX/nugKFuAqU7SuNIZmFMh6symsZSbzNu+X+ct0vYkRqBKnFu3+T2KU5p4HLOgwxA43wbhxic4cdntZxGzAHEOro21P0Wz7BCNxbAwEHunJzl2iCwWHyPEv+olVCWBBnH3h8btYsOzrWmDynjupCk5zp9zJRlYH8ysuaL4S215mBqoMC3B/QCxr+n7bl4mYV+eZ3NrxIaSxAM6o+G164IUPH4BQHmg918ijShYVdHHbUOiNRRcCFioKk2sbPxucnEhrtGtFIEXHF+7KTDf71wtT1LZAIcnVrJdPvW68MHQGOByPu7+qVd2s/YjwhcTxzEPvY5vpAHaIgKSu3nyNc/tB1n+JyeMU0ISCl220YkFF0wZKYHrLx1heMU4jNPboeXFASpZGYSXOtlHU2NJPnYMNpCtyKbuBah3QwXJ8AEsfGuKQGLOHxjEfMmXqvtcTehUqxsGChMicJMICIIxDatywNFkjDFsVAebUA8EnpgQHxdQEmgpazE08rttePSu1FpJHChnngnNCh8lgo6e0KBzFCNqw5d8sOsYpPBhd9oIZI+BO6sQDyeu4oX608GUv8R0WFLPR/TI/IAHKPxgNiZq1DViyLtzPGOKOe70P77lD2fQQCpBV8K8zD1Fkj8M6WHsbFluSJDLwcmakbaTUbbc3W3PyrHhRBMkH+GTf+Xr1RvndhHcQzePHSab7CGwNTVWVnx8UBPZeYQL+fZyTMKdUYq0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(82740400003)(2616005)(41300700001)(44832011)(336012)(426003)(81166007)(40480700001)(5660300002)(356005)(1076003)(16526019)(26005)(8676002)(966005)(8936002)(4326008)(478600001)(70206006)(70586007)(316002)(6916009)(36756003)(7696005)(40460700003)(86362001)(2906002)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:23:56.9610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f914a9-4d31-4ef9-55a7-08dbd719e217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This helper is used for checking if the connected host supports
the feature, it can be moved into generic code to be used by other
smu implementations as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5d1eb4c4c872b55664f5754cc16827beff8630a7)

The original problematic dGPU is not supported in 5.15.

Just introduce new function for 5.15 as a dependency for fixing
unrelated dGPU that uses this symbol as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d90da384d185..1f1e7966beb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1285,6 +1285,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
+bool amdgpu_device_pcie_dynamic_switching_supported(void);
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
 bool amdgpu_device_aspm_support_quirk(void);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2cf49a32ac6c..f57334fff7fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1319,6 +1319,25 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	return true;
 }
 
+/*
+ * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dynamic
+ * speed switching. Until we have confirmation from Intel that a specific host
+ * supports it, it's safer that we keep it disabled for all.
+ *
+ * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
+ * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
+ */
+bool amdgpu_device_pcie_dynamic_switching_supported(void)
+{
+#if IS_ENABLED(CONFIG_X86)
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		return false;
+#endif
+	return true;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
-- 
2.34.1

