Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0597DD125
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJaQFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJaQFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 12:05:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2934DA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgSpZxZ/MvaHzAegJ2Dm4Qx2AuTNv0gr3qi4au2xuJ5gI8tUklW8y3pxPcjLdEovge4oWRm5xpyrOV9P2bEo+HnJecadAvp+tt4qEdOInY5pGiKdSQlylCGySbZ0gR5Ev3ivmDgfalzpspz8LHRfahNTO8soN3OmGnY7XMpX8kTseElMunzoKx4/zzN1D9+2w0yX5YMwqN1uul8tEVYY1PTm8ZTsII7WEUBSgrJbDm2RTiabn5aqDoxaeuQjJbnH3zjQ20k9CfcGYXi8LSMOYrIRkiVUCk8au84eUU88mJuwAzln9oLr1c8IcqSMX+SE/TCO7Lk4QaVbwffe9wRUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyfzQTdgmOtMKwTyhoxuN+TUwfelWyYxVjZpOMTUsYs=;
 b=lc8RXZ8o/ZEC5YQIZ9J58Cw0Od836sBTYSaXKC5yCqTKgke1NakXW3wiwUYr6y3/khrlqn0GNcDtjKdLjS4rVY+FJePG7uaahP+2/69BuN1B3QgHdOJ1CcYZojx9wtyogYLh3ZMsz5whE7ew7ZnRqmBtX5bYl88HpjB6JLZRVhXG9N2/oa2AzKTBlRIlTM+M71gpSa3RID8JFNwh3FzDcTdT+GlwvXBz3BmehTS+0fguJCV3Sg7vYvm+TNpKt6ZAMFKXXae2kwEUEN7WhdkKJ+SxgUZArU3lYZieZVE0mTirSTNx64vM7JHWazFtauwID9qskAp61tuBsDrJAZBitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyfzQTdgmOtMKwTyhoxuN+TUwfelWyYxVjZpOMTUsYs=;
 b=bsQidwLV8HXm5CYoESPoVJflYKLLZtwZ+gcAkWnT/qfHHcNte+pfpw0h82dX+HTSA44drckXGjFU6dzNbFR2QpaymdXSSzdfQQJRJ7iGmenxhOkEP0q6+dBvEQK489y7nqjGZqRaeD3WSEfUarUf7rSPN9shurq1Yk8p5UWU4yY=
Received: from MW4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:303:16d::29)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 16:05:15 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::63) by MW4PR02CA0014.outlook.office365.com
 (2603:10b6:303:16d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 16:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 16:05:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 11:05:13 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 v2 1/2] drm/amd: Move helper for dynamic speed switch check out of smu13
Date:   Tue, 31 Oct 2023 11:04:50 -0500
Message-ID: <20231031160451.5429-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fdf9e2-304a-4b34-094d-08dbda2b2b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF9AitlMbCn98iIZulr9B5Bl2pCXn15rcqLULI5CISIQBtHhWBoh10W/Nc17cnR2lswbIwtABu06wgjdDy56U/CySxohc9nuiHno966n5nanMmqFcjSuc/rXzbvbyxaa7CT6vjqokkMferpZJpn90p8ewPx3pfTZLzklPWZNXP9fyOwbQa5RYxWgWjjn7xODUHDtKnguWmtbJGMVR6CWyhzlSIJyFH7RSGxI4XRosmGoK+koaj5w4TgPG3YN97nb4ZYBLK4Xk/XI+1uzAyWLIfiyaZgVUy/yoNLbahbwXqYrBVv39xax42AOMFhqXTCIJhYNOm/NF1dHKTANqKsFjuginvEIvKzQrgtju7mqUdzGa3ws7Vub3WT0G9yQDegcyO8ngW3pq9ovRrv/F3r3Yr1B2m/QgR0KAraCnshIAXvCkt3x0je7KYacaz1P/UeOf+Sa1ocQWWrApQBFT479EHJ6cE4tK8pmQlfhxOIeSyfOATYDvYRlyoK62X40Vvh8F4m9ekvIDV8i/nwrZWnEccW261TQyX77Guk795IIl9nEWdYORT/GMYcuJqWHHpC8MYd+glx0Tay793saLFISExpWdH9SPnr1i52xwqt90J8caVihsZNKZy+HGvG2Qsq/+d57dys473cyHEfYx6IXfj2NDU/wfiwCpDzzTb18LS/C9+CM1+3vCAJtemaMiqE2V6GHwxdrsQ0TsWw/VkzTPwr9YDkEqreboiaaZzAHQ+PQtbDibBH5UohGDLNaNd4l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(4326008)(8676002)(8936002)(44832011)(5660300002)(2906002)(478600001)(40480700001)(966005)(70206006)(54906003)(70586007)(316002)(6916009)(40460700003)(7696005)(81166007)(356005)(47076005)(36860700001)(83380400001)(6666004)(86362001)(82740400003)(26005)(1076003)(426003)(336012)(2616005)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:05:14.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fdf9e2-304a-4b34-094d-08dbda2b2b66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
(cherry picked from commit 188623076d0f1a500583d392b6187056bf7cc71a)

The original problematic dGPU is not supported in 5.15.

Just introduce new function for 5.15 as a dependency for fixing
unrelated dGPU that uses this symbol as well.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit to 6.5-rc2 commit.
   It merged as both of these:
   188623076d0f1a500583d392b6187056bf7cc71a
   5d1eb4c4c872b55664f5754cc16827beff8630a7
   It's already been backported into 6.1.y as well.
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

