Return-Path: <stable+bounces-6665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476A812007
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7875328271D
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCB381BD;
	Wed, 13 Dec 2023 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JYSsCsXN"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9965F4
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 12:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSvVcWgSYxlv8HdIEvzwDRiSKZFTzTW7YfJ397m2+sWxHqT90cacGrfjI+Qlxzt+jnaWoiGS+j5RKuzvhnmXRkBp44BHjB3zYQDBv6VwjgVyu1o7mHsRI0+9QXgOcg9foo8oRPfYhon+k1MBrWtuyHUsh5TGhLkl1EW6FMYG1yMLutLwzDNB2jYKQueOkbgue20BYLIel6TpYcsYIm7rTjmAc6ozx2xRiypg6hz0r4p+ys43acn3CVN5k92Lh9JZKHwZsHPFNoD4rWVKhc1hPraoZLKfKYqSpVH/p899ufrDB+zHu3BuAAb2cyk5/JmiQhjq/Gt64wLq8HT0g8R35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhJlwcTRCoHiwqbj584NQJIEP/pW5TCqJgbuBJYnM4E=;
 b=g6AOOR/bqvieIt64o/ihW9QPFMiuvrQNoqK35VPeoXRGUGgE4L9ZwpQoWyyt9CJgL644BNr77YfQwk1NVizIVZinjIWe7BIYmery7ek3GI1LYgMWyrFNrvruD0KibVXBomn31WQ6FMt7wynxEAN8G5UcYyqvvUayoQc4QB+GgjFUkGSV7xd+xuANPKffPbWMGWgLvzHvVZwP72TSaNbCzRFJdTxIgE9Qv0C+hV/Sm0rb822FpGMEOGmDwpYpG2G8Cp0B/FHJpXJQZ+vWGWCA7+WItPSQBChNKrr5IFM5ty/X2X36uGHDNqK4+bd2F0yEEQZWiil0riYGH43itQW9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhJlwcTRCoHiwqbj584NQJIEP/pW5TCqJgbuBJYnM4E=;
 b=JYSsCsXNO7Bz1uYibkqTf+YrpSh3zMFq7CQwARlO5lTcSRnzKb9waYpTZAxG2BTii8atOvvB1VQgx8S2Ua1Xz9TFNaGcaugSTtwKDFUBWfK18x3ofvZ/wa63MviE0m8Lja1lVO/1K+y6P+4dJapr6r7Fg/gcvR9F7dCOsH7hugI=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 20:31:33 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::78) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 20:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 20:31:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 14:31:32 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH v2] drm/amd: Add a workaround for GFX11 systems that fail to flush TLB
Date: Wed, 13 Dec 2023 14:31:18 -0600
Message-ID: <20231213203118.6428-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 721fea56-bbd7-4a68-1ac7-08dbfc1a7ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KPd0OETMGlHxNflpkJ9TIZnWujIsuvLYpMr0YL1DyyHWDxB/Cd8QWGAzj9bapv6BTI8fn9xecTRz+2FQxhwbFVI4wWYZaFUZay5mQGKPOi3iqy9YHn9FohL5PfAmcfrLm2vTA1XfbT3n/KUcu4YYRrkbHN5dKHK03UFy08Qf1i8w3pZCJvkJZBo9Hg9GjWTXbMKPCEwdc+zLfa+R3d+HBoYQ2++NIFliHlQJ/rDYDNF+DN2iSy5qGvL1betxpR0Pr/egY0yutd1vtDnG7Uz8Nfz18MfGnilSXLLFLhQoQkpBAJzauDSU0u8SHO4IjsH4oQvYW+AQdUlDcVInvfcSTAOjW127VZ92c9qPdlvPsG1/PvERRyOV6ICAmQtF2ovhY8vWsiQ1seAFIaF0Ssrlud5oxUm646QA/MmQBKC14J8K413CpYzxYoVElxSJjvD6W0LTDxXkUWWKk9EpU1yVqPlpbDo6CHEU/rD+v/RQ+wfpwZi/objEzRHfH9TOSjZmRCs5gE2ORLZ5rYIEAuM1xgwOjCRzoK1qkZ5SlFLqLtf/C6O/pTRp+Q7P7gIAe/IYImkhjRdV2FRUFJ5R3+xXEKbVL425N0C4VzofBK2/HO40B2lVBtkQZ6AO9yhfQZ/woNA2vQq9TBE2QyrrUfgcNEVl/PLpiy43peVA5ynIA0qy5Dgljn7ZqsLP8S3g7smRWRyhVw0NfqHn3WOQmyT2v5VVsbmLeWcUL8NEN+0VNN3lZf4h3j4y8j0rUIv+o/dF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(6666004)(44832011)(36860700001)(5660300002)(7696005)(966005)(40460700003)(4326008)(41300700001)(47076005)(8936002)(81166007)(82740400003)(36756003)(356005)(2906002)(86362001)(426003)(83380400001)(336012)(8676002)(70586007)(16526019)(1076003)(6916009)(70206006)(26005)(2616005)(478600001)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 20:31:32.8406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721fea56-bbd7-4a68-1ac7-08dbfc1a7ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
causes the first MES packet after resume to fail. Typically this
packet is used to flush the TLB when GART is enabled.

This issue is fixed in newer firmware, but as OEMs may not roll this
out to the field, introduce a workaround that will add an extra dummy
read on resume that the result is discarded.

Cc: stable@vger.kernel.org # 6.1+
Cc: Tim Huang <Tim.Huang@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a dummy read callback instead and use that.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9ddbf1494326..cd5e1a027bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -868,6 +868,25 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 	return r;
 }
 
+void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev)
+{
+	struct mes_misc_op_input op_input = {
+		.op = MES_MISC_OP_READ_REG,
+		.read_reg.reg_offset = 0,
+		.read_reg.buffer_addr = adev->mes.read_val_gpu_addr,
+	};
+
+	if (!adev->mes.funcs->misc_op) {
+		DRM_ERROR("mes misc op is not supported!\n");
+		return;
+	}
+
+	adev->mes.silent_errors = true;
+	if (adev->mes.funcs->misc_op(&adev->mes, &op_input))
+		DRM_DEBUG("failed to amdgpu_mes_reg_dummy_read\n");
+	adev->mes.silent_errors = false;
+}
+
 int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
 				uint64_t process_context_addr,
 				uint32_t spi_gdbg_per_vmid_cntl,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..d208e60c1d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -135,6 +135,8 @@ struct amdgpu_mes {
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
+
+	bool				silent_errors;
 };
 
 struct amdgpu_mes_process {
@@ -356,6 +358,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  u64 gpu_addr, u64 seq);
 
 uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_mes_reg_dummy_read(struct amdgpu_device *adev);
 int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		    uint32_t reg, uint32_t val);
 int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..a2ba45f859ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -960,6 +960,17 @@ static int gmc_v11_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
+		/* avoid a lost packet @ first GFXOFF exit after resume */
+		if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900 && adev->in_s0ix)
+			amdgpu_mes_reg_dummy_read(adev);
+		break;
+	default:
+		break;
+	}
+
 	r = gmc_v11_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4dfec56e1b7f..71df5cb65485 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
-		DRM_ERROR("MES failed to response msg=%d\n",
-			  x_pkt->header.opcode);
+		if (mes->silent_errors)
+			DRM_DEBUG("MES failed to response msg=%d\n",
+				  x_pkt->header.opcode);
+		else
+			DRM_ERROR("MES failed to response msg=%d\n",
+				  x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
-- 
2.34.1


