Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55779FFEA
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjINJY0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjINJYZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 05:24:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4D1BEF
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 02:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epANlAk4vIkhGFLreNH9wy6xasaj85O/Ll6WonpcMokImOTAXpb+UoBhem/fNvUBcacqYSHxWqjraMKWBPyoGtlUhlNlCVAai0EoJes/Jcld4afN12hqGBg9Z0R6aTaDchvk+gkeYSmYL/FheHwX+AucDWomk9piX2pq8iY1jXGmyK7F2hb9LeiArSbuGNJX+tJXlMDcRGippZp8wH6pGvJTzerMcGMbx7b5zyDDujdEteHv1dxgJEvt/967mgpYaX4tbVdyjDsKr7AuBDqUNSQ4GMUH5WD6kP08gZaA08tXa7jYO6mJi60zLrby1Lj2mSuGBEuLuthm8iVavqxyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8QdQ6RzdXYESEAugsWnptnzHGaDmmKvRsZSB7gIUPA=;
 b=mKr3OjnYLD0dilSMgW7WUug2yW8MVnJFn3FBcbgA16Zt4+Gkv92/auvWOed7XxVnnGJuv3uV7KXElIH9A8481bmseJeq/z8QybC4PJrrfaT9bjhFYCuNgG8tjsG9D1BIPNX46DRWb52Ux1bjapkJca19eV4jpd3CouO1b/Cf4D/0ofbgt1TrbPIqMlWMmnqm2wB9yuap0kUESnFEs08rSPzfXk3K3G3M4bb8iZPpfaN0u2/D/2UyWUh0VHqDqOf0sdHMg8AUuybO3N7SinAg3zIbxVFrTpwa5ZbWsFI9epPmNoMyrXUDRCbYIOuIzF+C6i5hTalzkVDQPeOYYyeXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8QdQ6RzdXYESEAugsWnptnzHGaDmmKvRsZSB7gIUPA=;
 b=nyGkRQLwx8HiZk/C6GyVFuHFSctByNs0QnIOCDXu1p00lwoSIk/KjoP69+4kXSwuQCHJz/RuMRfkZpZ7Xx+NcRei9SStlU6ddQt0Xbo1+n7zjiQQwwaY/PMIYkK9U+MSJuBxTaYm0NJU53GEAK0GOQ8IGO8L8A+JEVSIeFf/ca4=
Received: from SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48) by
 SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 09:24:18 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::76) by SN6PR01CA0035.outlook.office365.com
 (2603:10b6:805:b6::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 09:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 09:24:18 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 04:24:15 -0500
From:   Lang Yu <Lang.Yu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
Date:   Thu, 14 Sep 2023 17:23:50 +0800
Message-ID: <20230914092350.3512016-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: b6894035-c276-4a5c-40dc-08dbb5045f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkMoi1/q0OORPOT/Yo0VgiczQvVWdnJzQZ0hZevZ6CIeZQBaDqknHUKOpqIAenFt89fkkVqVxGG1eyq3kP5h938STnXdSmZOEl3EGa8AMfMmUsMezi9ozzhwnLr4w84WP1zpBFrs0qOIMuD118ZgE9PPZV6s7GbQfQUeiNCCP3i3dnjQaFkIoKXroQ+xwkxjO5lzWgiJk1yYeAVpc9NNjxLlIR/cxMMXkYyIegi7XOPbxSZaUdv/nDN9aEbrk0a7wpMdKULSJMI+B9W33NypHPzAyimUSWskx1KP39MxrSNt0l4fZOGHhEbl8PW9ze6uQSOYCOOgctvFI/ZPHvecsSOGhqUa7edxTM78qrU65+kR/OT3boMY/GERkC2omF/TXeBTtwllQ3dz80PU7M92mwPjl+qOXjICtiAfO/4grnLxYGxH3Hvgdhcso8Wed2Ya/wqFAFOPgRjkYlcM9A+c8wqOciryryDy1HYyPcba8liG/UODiD8agxsvky2F8FE0sQhLEWiADx9LWDp9XNJlVDCP389E1AmXS52ISu3XzOhUiM83LZuQe7oZPuUAQqeVazUVpsZhBgtpmwamVGnJyKO6iFWnffkiJSQqali6qCFPjh3LvbQgFDZnviepn7VOBpbeLLJhki5ePdSKMrQS9Kn8ks3KKytCVP4RUnoBoYjiNwqQZfp6k3eieJRuZWWGAYyJWsoSh7D97zPYNcTptdnmBOIB1E7AoGMEb8qipMdp7FIl2521z/lvyuz7ACpSmgJn+pBH9izhG+I5H3kpnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(316002)(16526019)(83380400001)(6666004)(7696005)(47076005)(81166007)(36860700001)(36756003)(86362001)(356005)(40480700001)(82740400003)(336012)(8676002)(426003)(478600001)(2906002)(40460700003)(1076003)(2616005)(54906003)(26005)(41300700001)(4326008)(8936002)(70586007)(5660300002)(6916009)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 09:24:18.3009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6894035-c276-4a5c-40dc-08dbb5045f22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

cyan_skilfish has problems with other flush types.

v2: fix incorrect ternary conditional operator usage.(Yifan)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d3da13f4c80e..c6d11047169a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -236,7 +236,8 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
+		      (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0);
 	u32 tmp;
 	/* Use register 17 for GART */
 	const unsigned int eng = 17;
@@ -331,6 +332,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	int r;
 
+	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0;
+
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
 
@@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
+	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? flush_type : 0;
+
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq[0].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
-- 
2.25.1

