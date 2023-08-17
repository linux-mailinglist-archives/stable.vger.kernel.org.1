Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5582C77F7F3
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351435AbjHQNlX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbjHQNkz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:40:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F42724
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgZV/9WQIiovUmKccpwQUIlX/KmJP+hgvxp8+OkLPA0kHIouiH1Iq795GxrRK6GrPXB533vIkcUV2dBFQzLXLqd6JVo03ZVpU6Iljfquth47QRz3WUzVrk4+51hqozA2adqIgCAobteicK0nMXnDnhXABsQXR0aMmgcixVuYpDcwvL9f/NGInkNUCIinC0ZayCy4djtLU1D+gEDu1mn3p7s2KtzlZyFU/t2Lj5f6YiiPdkNoJ8kT6JsC4rvVvq8muexWajdWPCgMoGiR87zxPGadYr3XzppM2rbPweF77JCfQrYakm4IAx+kJQ3Q+MEF0rJQaVzAEH9tBdfBPKUEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EMR/51V2P3PIvsktwPKqFFWoXfgzGgpbe8Kostlpqc=;
 b=SaBhpKIQKLxCzEK9Y4a5qRq6wysJibgrb+VeXYoNV7FKu3asnGsEHjxAWVKyB1K6KR9d5YNWdv1Aw6DMg11mLg5bkIpz372jszdF7o9EuBXWfBpwSXdMfby0tnWwceWzHKad5w229d+3Ir2FE7o4GMqSsRChj4ktqGjN1dqpAPk7ThAOa8o0cwLLNAtQxtXDWUP4NBzG9aHIisVI8NmWcodCFeroRifpLl5bPbopy7Ft2t1KKxxNFetZMK9EiyUZ1CaBZ5Gd5EYJS9+RIpE/r0NCCL2CoKO9BL/iDlpA2zlE3H5XI4wdoDYJLz7A5KvUJblhFhQoI3RmK3biLBB/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EMR/51V2P3PIvsktwPKqFFWoXfgzGgpbe8Kostlpqc=;
 b=x6gPBd9Q1bxjZd7Ep8kZu+Qg76u1jWqeyFlRyDP2E6wSTgyfitDujy5NXK6kIYbM9iWxhko37bNk3X3A9ePeB8vl5VMZ5lh0cGZc0Avgg+YAUCIe1Rp2C4Y/N8rRa5Dq9/UaiKGQ9fpdFk7Mc3x+UAI5CdiNIMJA9xTUeeeRCS0=
Received: from SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) by SA1PR12MB8860.namprd12.prod.outlook.com
 (2603:10b6:806:38b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 13:40:51 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::a0) by SN4PR0501CA0023.outlook.office365.com
 (2603:10b6:803:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Thu, 17 Aug 2023 13:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 13:40:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 08:40:50 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <sashal@kernel.org>
CC:     Tim Huang <Tim.Huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU v13.0.4/11
Date:   Thu, 17 Aug 2023 09:40:36 -0400
Message-ID: <20230817134037.1535484-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: bb615f44-1f6f-4cfb-2363-08db9f279293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwlRYtZ7KziqqlOCvnh0NGgkpjI7OMpf5JnJvz+Cy/dBqFOyfiOcuOIOLLQUMFcsV9rGO4VDanmy3wv/YgXCMuvhaLkwxSjXzXXivy30a7gaGS/6dmRs8ZdEcZGh53RziJ9Wc6rfGy9wYVezX2y0EgtwHI0pkpNydKuO9SR/2MkO0lOnflVlUPrE3kY5uYZ84xkiaxAjpZe9kU7ts0BLkgCtCYRdRanUNyLn7/fg4Rt90DDcEYfN0oJOfpPe8gR5G8b8KveqMu1+7eWAnR65XWCLQ8yuGOR1ehKfOWbBzTOMy7HTrIhCKU5HYcfKRd7ZxzbqU9aisqYPSoPbx98I3ku7GowklAs9ElAHop7cQg+/3wPm8rCSAgW7AWjs5SNXyTRxDXw74T2OHoHknX1iOhgte7kC+KjkNLBqJjLAfiEFoDdyBCE+kxGfYQhl0xmaC1p85YzeAPSene3DxYRMxRzJ2a3oxrZk/svm63Y5yCx4o4oYKQdprsxmKRm1LnzJr2vJM4OENMU3rNfOIppYAVY1GX7/RQqX0iKG53heUYYlgL182d/YaS7LVc7biIzp1Jhhpv6Ddy/kpFABPacgNnMo3XCVFrj0jM7HgtFsb5SbdK0d9CFspxEOumkKj3WVpcFcHCZuE4oViev9C9EV4nkSZwkO7US0aKPetw4T3qFYG+844caaGkvf/kDkvV+dM600xfyKb+W0UiqS6aEJL3P2paPP8Jbpx6seQQsjvYtgyfy48rw38T20a/rSnWkZzWDLniPJedmDYTSMrW8oaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(54906003)(82740400003)(356005)(110136005)(70206006)(81166007)(70586007)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(8936002)(4326008)(26005)(40460700003)(2906002)(83380400001)(16526019)(40480700001)(336012)(478600001)(426003)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:40:51.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb615f44-1f6f-4cfb-2363-08db9f279293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Huang <Tim.Huang@amd.com>

For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
the firmwares will handle that properly.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 730d44e1fa306a20746ad4a85da550662aed9daa)
Cc: stable@vger.kernel.org # 6.1.x
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ea03e8d9a3f6..818379276a58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1573,9 +1573,9 @@ static int smu_disable_dpms(struct smu_context *smu)
 
 	/*
 	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
-	 * for gpu reset case. Driver involvement is unnecessary.
+	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
 	 */
-	if (amdgpu_in_reset(adev)) {
+	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):
-- 
2.41.0

