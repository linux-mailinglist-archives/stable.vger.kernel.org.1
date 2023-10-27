Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCF7DA084
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbjJ0ScP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346368AbjJ0Sbw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 14:31:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EA199D
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 11:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf7V8ha3xbnNt3T3bB071I5wrzpXDfMY2CPs722hg3MOqM+xgDEar/sZkc1DENJ00TujVwkIDRIque1Zz8snI0ld2ktTKdOImJi5v0agiKtkE2sCAr3LVHkZPV+4XSdbvCfyO3y7k+vCgGrIVvpG2kU7PBbe4uRaCNalljvq6OeOuLiRPy8LElCXeVcLqzHXrlX75t3CX5ipD5a9xAxIVt1cf15OhxrxpDdU3cSytbWaFsyuDL6gNMSeQU7UWnXFmQpFoEfiB2dQlRitYv2naJI1eD7DfMrynFbJ88yS93THoVqqUSylLvi5cbpXvl5tsOo8HGj8jYd388Y6yM3ZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQDNZA+F3Psw7E3xk+u+nIXcPveOGeP96VUCNB1RRiE=;
 b=kMKBPn+8ycVa0Laup+RimcLmgw2m7IUwOhgyTcVlyhGqygzH/a6uEbxScYT8T1ksnG3NlJ2TeenOzc9HKh1sNBH5fo/qHWMpSzvuiy/02afqvJXz/E2sWMp71n8G6c9IIvcMh9wP0FBDhKRed6RE2QhYTuTMUvP/5NcnV4mfK6dDqdjb0DXpDTp5X+GU+sYMa7CBcoeuj9U6kMZqX6qhLEpGsbBfRuAz6GkIidQttFTddqwwEAkhxyZKt+5VM51oew3JiAMMqQPk8DFIIMjeJcBLakGKVQDxuAaiMLcOKXwGNP3lhbKuOPdAFrOw7IVLONoTwgx+7B9TgdHQmU3txQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQDNZA+F3Psw7E3xk+u+nIXcPveOGeP96VUCNB1RRiE=;
 b=kfTvLsABHFfMNLEewDIn/Uq3CpbxoytZtvEWIFGTeNZR04Lgxd+cJXdAY79Y/DNzYkOfM6ECkfNoEvEBuK4zxJfJIJ+tjnVd3AT7w+6Euv8n2g579R/XnQr9qenMH7zKd0GFtfC+lDmIp6ICHI0TPofE4b+RAkONXTBjt9ei9XQ=
Received: from CH2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:610:5a::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 18:23:58 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f2) by CH2PR08CA0012.outlook.office365.com
 (2603:10b6:610:5a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 18:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 18:23:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 13:23:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <stable@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.15 2/2] drm/amd: Disable ASPM for VI w/ all Intel systems
Date:   Fri, 27 Oct 2023 03:39:58 -0500
Message-ID: <20231027083958.38445-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083958.38445-1-mario.limonciello@amd.com>
References: <20231027083958.38445-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: f41aec34-6328-4c70-c335-08dbd719e2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pXJEMMCuk6zKrLrzzxg5kv7Aa7Q195E4Vq+D77QD03BdGNxd9mZlanILrFq+HudvnbhYb4alO7xkxVCgaWyYfj2xZXNRKSOX7LaI7lhyrQcUBgJHZ/egFnRfG4D7wzSU3a86PdnXQWuMP9dWoqXyb3fZ1L46ifDX8oQlgbuN1aOn0PpPF+t7rw7JePiEczBanxoQeNzIfUSegHPpa464ShU5MfO5hqmgOi1FPoarhJedC415EC8QwR6toYwwKTj6awU8uz7+q2EBY/C/7K7g/oeZrxadPPjdoLUjsFJyC7VZByes2M1dtQ/37yhXJJhvCynxuvDDa71Xupu6N7WC45kyHEjQLlLbDmwl5vhoDiMIKjFRvVyNmqvGy8W50cLOznkgyOFUfJFHw3R8YkIy9TFG9ilixCjw3S56kt4LEzPCCVHB5bOezZ6wucRzpFhku2Wh14rdogec4sMjakbILGCJCtlGYzdYSYqgaU+565WtDUImzMJVqQgMe8cxlFaQY7iD09cKkgbrvGMs3N4MhPJfWx8P2Iu9QRC/10mVyUYZGog5lbyIUJQ4iSYdnoYoa+nekbCv8s5pWOiyJSzZmYe1FGdskd7wRvKb2yI2nnS3p9LJU4KCtQhZVw8lHzFP8Yx+cpF4/LL7Ef7FCVZ6D8VfKKy3wk2JhtngJnpdf1mW3/eCJ8GMtUpS6ueilJoAqr10eBdOKuwPcr/nEhbnNCh+txz5H69axwoWmPkF66HVdxQ3kv/j/xqpvzmJsoZYXq/JGGRz6icHYhW+8/DgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(44832011)(40480700001)(16526019)(7696005)(478600001)(2616005)(70206006)(36756003)(1076003)(336012)(86362001)(966005)(36860700001)(426003)(47076005)(81166007)(82740400003)(26005)(356005)(70586007)(8936002)(83380400001)(8676002)(4326008)(41300700001)(5660300002)(316002)(6916009)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:23:58.1172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41aec34-6328-4c70-c335-08dbd719e2c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

