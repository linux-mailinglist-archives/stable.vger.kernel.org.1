Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9923F7DD124
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjJaQFV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjJaQFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 12:05:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F5B4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 09:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUpCeP4iga5aQL7xMWKL3D8o3HZzby410yn5/FWehh6q2T1/dpauWuqyTIAwqnZN5Nhc7LgoNmHY4HkWs8bkT44W+ELrAZV+gqsfJQcsEUZqZuNIuTb0VNWoiw/Kt8/RhJ5/KOBvwZ0YXx730Ra4k9w2sUlrHB7wWfYuPtF/cz9aRaVB5JkYboF9QLV0rkqdZSWSAhhrQlZ9PpM3KdYM7g74+9eVH+OPkJ+nFw2GfaD4mGKoA1EN8VR6aU4jujNrzwiUGppPIzlev4Rjw7dfCNFXHMz+s4QCYKSe5T3urCLvHg1L5May4tkvDBx9M4CYs/ZXryeSx65Pvz52tci7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQDNZA+F3Psw7E3xk+u+nIXcPveOGeP96VUCNB1RRiE=;
 b=GO5/RnI7y2hfHVeuXbX5JAS37DbKfR6V7tGoEPtDeXCIxmh7Ry+y39kCnSTp0K0agexC+e90yAYUSvLDU5BAILdoD+A6lzWKZhRGdWWaADcCtF6waZCXE4g7mrkFGAViVxwf/5nq3pPqcsc/N2z0LWLuRTR6i41zo/goLnIeXZxYcJoYwgpD4Z6oxFEKKl5f4b3Aa7dPAdTHgaKjHF6UXKR7N4hTsmqvyo4+928f4pt/xql+Eqmg5QvcY4zmSKFnr2CgpA/qfgkIaVFHoVBy8lgIZIrkeACiaIOPCXFTtNFw8QhizsOYIIa+hP0V4KtgX1O5kVkMYl+gYtBplzekTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQDNZA+F3Psw7E3xk+u+nIXcPveOGeP96VUCNB1RRiE=;
 b=Vlp8QdvcJSUY18yUh72NOFJdkoUyQ8Nicp94hlLDC2AceRdnmUrZ4IloEudvjCZuug0lvL84/s9KqPkLquRPUrDWl9FqZhvMFvmE8UBPBNMVnj/ug9HmcEUVxlHX6Fjeu90aw9403+m+0+BT8yaV0FxGMMT8Sf3mYngGpLOrrZA=
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 16:05:15 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::7c) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 16:05:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 11:05:14 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Paolo Gentili <paolo.gentili@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 v2 2/2] drm/amd: Disable ASPM for VI w/ all Intel systems
Date:   Tue, 31 Oct 2023 11:04:51 -0500
Message-ID: <20231031160451.5429-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031160451.5429-1-mario.limonciello@amd.com>
References: <20231031160451.5429-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e8d93e-5874-4f47-0573-08dbda2b2bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72FvF4OzhZ/fhy+6RlmV+RZdGUzdxDSVHFRHF39QyKCj5sYxkrrCcdcZU+mPLXl6x1dtvmhzP3uEVL6cIcqB8EdWr6SSwnhy+OhM/0NVNI9lNTo49eOJtP8wh4xEsPUneJLTFBEpquKYdaLOUilWh5R5MmbTw2RIRDGpzf2PsCJt8M9qvv0BUmD1owWThxxySgSHdjoy9zUISTUY5k42RFaw8JkSaT8aBLMRdK/7on0afsuihZMh0B+oI030aOm0diCj8tVvUld2tHIbkTy0VZ4pzzmJDzKUDQMWscVnlaeYITTQ8kKDah5GCTG3i2QG0uMkIGbIoIfbfolKSbs4VHUYL8slQxBrv9xiv1HtqNUVVNGK24l1/lxWG7MbErZGUwJ70aeYNnOOgcBSwPZXpFigtsndFoEvHARAz5Anwcxr7iJjur3bSNgpmtWda3qnOkb9XjGdz8EOG8MOwLBL5pM5ec1LI/NQ6Mqh6ShVMm1+4eH0U5wanTGqPYZIWH1jfyHLZ5jaK9Ak9UWZ+7xwKLZXfqrShD21SrFXMYJbBG0VfIUbGm7ezoOOyQPF3qJv1JSXGWs7/5JAfnUTfRMhftmUuUw+pqkjDxdmzi9wXIsD3mioQmtw914dBanNYQj5eH71qO3ZYYN0k7o4DDez/pzr8Vp1b80nTCizOhYs4XU/QAgWbxJzKh0Qy1Xn4P64bafeJFio7A058gvUco+XDbMOiBC6ho25qHFnefVKmUOo0yoGUIEv98Rhxb7y+L2+BuZXtddtsfvjnPSvXGEH3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(8676002)(2906002)(83380400001)(70586007)(36756003)(36860700001)(4326008)(426003)(26005)(16526019)(1076003)(82740400003)(47076005)(81166007)(8936002)(356005)(2616005)(336012)(44832011)(40480700001)(7696005)(478600001)(966005)(6916009)(5660300002)(316002)(70206006)(86362001)(54906003)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:05:15.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e8d93e-5874-4f47-0573-08dbda2b2bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Originally we were quirking ASPM disabled specifically for VI when
used with Alder Lake, but it appears to have problems with Rocket
Lake as well.

Like we've done in the case of dpm for newer platforms, disable
ASPM for all Intel systems.

Cc: stable@vger.kernel.org # 5.15+
Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry-picked from 64ffd2f1d00c6235dabe9704bbb0d9ce3e28147f)
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index b9555ba6d32f..6d64d603a97a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1147,7 +1147,7 @@ static void vi_program_aspm(struct amdgpu_device *adev)
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||
-- 
2.34.1

