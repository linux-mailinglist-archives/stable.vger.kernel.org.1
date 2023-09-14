Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5179FC72
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjINHAI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 03:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjINHAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 03:00:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8FCD8
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 00:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buYX6QWfkuVzdXcPm73iPjNNR27m3ADlNuAYxbFDr7vUSfHPpjYHyqM8d3aeRaDwuLFTPyxUqyKQLiZZEVd97I9zyvBZnOZfTJUaOwUeaYcc/YduemPtDIp24yqsFMRMjCujs82iYQphCOeQoUj0DXjV7eo2p1t15aQhAgsur7bVMOibjoPUIkTRn+M6v/osgKrTwyZ3Sxzi2RzxgrZNuLh2bts3XEYcFEOKivsA/UUrAAuGtrqjbqqyZsmgomFqw+L8dNVqDe+7eT7XFHbKxba9YC7D8VJL4gQgU//+XLQZBUn60ADlqH6dvirNSs2wbt2WSucraVwIyHxdKRQ8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6onXFTNkr4j82FH66/cjprmjkY/Zola5dfjGL+BtM4=;
 b=VrBMtYNpC7NK86K0BBKn8U7HSArs4gBjTEtifm92UO4ECVRuiDSMw6vs7k4LtC3TPy9wl3NA4bq3Zw64hoTKZDpn0OGgydysjEad9RDj7NWBhMDTrPAkbS8IT8taF4ZQekFF2WNrJw2VHphx1JymSqLxIN7XykewluNJCBJ+VUQmGO2HioWe66wApZ0g2j9YTd+r6Qo9yV733eV5C5HViE4NnoXhnMt5P+j07YCnEMqTnh6xOF2GqWMHFqogLD3VmfmX+a5jZITZcCLxk9jJ14QPKBG7BAcZlQpeIA8Wxg9i7tFxTJDXlmdir0GcaDc1AOjtvchIMNuZqSWRZk+N/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6onXFTNkr4j82FH66/cjprmjkY/Zola5dfjGL+BtM4=;
 b=ezcQP5tMiRS2UarhcLT73yqKlbDh8yF2r/fhqZ8meWUeEHSKFhYY91feZVCHCS1DvveBkoCwNUCevSFlyVs9ICLR+86jKe8Jb3tdOkJPfi0syhmzijPB4bSoBupAHfZlVb1GGLtMB0vKK44vvqdPreuMGSytCBRP0UTBf6ubI8U=
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 07:00:00 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::10) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 07:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 07:00:00 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 01:59:58 -0500
From:   Lang Yu <Lang.Yu@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Lang Yu <Lang.Yu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: always use legacy tlb flush on cyan_skilfish
Date:   Thu, 14 Sep 2023 14:59:45 +0800
Message-ID: <20230914065945.3508261-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 035e957d-f7a7-4a31-3aac-08dbb4f03683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxhtB3DKR0ufsrfeY2+EEvbXs94y+MVEeWaH/wAcupy7oWoaAUmosifIpe9q+ceKRDz603tQrTa2dOPa25IQkYONm9Ho1e6/YGTYUtB6TLbRdvVZbdMQaMyKN6iE87tvQYQV6uiTvAmDYo2iX/YMALYoAs1/YDWtEmDAAc7lbz4M6xRBWX8XozQXTwGBnrJpZufoWGq3mFS79IPa8aJA5yPN9I8xbOUTDmeo0dukoVy/a/MMYIl7Wyxx/VhdQlOr1Z6J51PgDSTNzxTQ4ddv861L1d3+Fu5y+0PYHSZ2H7DF97rmhVncr10lzbAp7NEoeuior7G/D3ZmPkqr7/6y4MW7BuYAYCzph5yXhE/7SdeKdgU/3lCkvm3uajOuFdfS5Yi4tigFSaNGdge3AOLc9o3DAJzXw2Xx6HTsHGeXCd702SObbs0QU/co2L3jsFBBYJ78TyDAOTkXj1VH2rRMtIdJ9s4RNuLIAluUNfiAEjrx9QvRa2zwzP+BHXAu7vc0hs80cjgF+vAbMFZSFIfgvFrElsqdDgimvCcysugH9S1qYx5Ksy4iPFT0KrRJc93utPkAEGWguYlY0+J+3PIvbSHk8VgqxxzBnTgnMVIlucAcT8ohLwfdJfI7SlBAp5tT+lv2AuHlOTV5kle81XDohJPwL0MtTsivdCaTDmqFsPUxuFn+C2mcoeB6v2XfPu23gUMBvWeA26s5cAHYSxSw/7zNbOASA07i92t+risT06F2nySmql0oC4C84AGpZbPFQHiL4h6RPi3sEj1kSDK8vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(70206006)(336012)(26005)(83380400001)(2616005)(16526019)(1076003)(426003)(47076005)(6916009)(36860700001)(41300700001)(316002)(70586007)(5660300002)(8936002)(8676002)(7696005)(54906003)(2906002)(478600001)(6666004)(4326008)(40480700001)(86362001)(81166007)(36756003)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:00:00.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035e957d-f7a7-4a31-3aac-08dbb4f03683
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

cyan_skilfish has problems with other flush types.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Cc: <stable@vger.kernel.org> # v5.15+
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d3da13f4c80e..27504ac21653 100644
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
 
+	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? : 0;
+
 	/* flush hdp cache */
 	adev->hdp.funcs->flush_hdp(adev, NULL);
 
@@ -426,6 +429,8 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 
+	flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH) ? : 0;
+
 	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
 		spin_lock(&adev->gfx.kiq[0].ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
-- 
2.25.1

