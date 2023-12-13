Return-Path: <stable+bounces-6617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C689811A60
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BB028285C
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C43A28B;
	Wed, 13 Dec 2023 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYiD+zRV"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB0F10E
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 09:05:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMOL6F1YUQJEsdWveJRER6bhm0B1y8yaL2qeq/SRvViATJydRebL+sdXTl7MNz7v99j83vkl5b3D28vvAqRtBXIiklG5GN9Y1GzYYd9BI9Zj6v1kikqIDLSWHNAepsRQ8EhKaahkPwwAnxthZGYLyal3AqcAEZmeF77/EpzABKYnWkeb14d1+mhchH0pk/7gMo9r7XYPKcvCBGmmX8Hp4LDrTeLzbuOwXOVfMvdqRVhIKWlaxruRW/0f+f2v6fpFJ4HElJFzxKNski9XDPBz7rwNIsWX4oArHwHTIRrQWjqHSvgoAK+bORSKEmzEsaog/PglH7Ck34k+vEQFAOBHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px99XqTrxq398VC48XCkrjLbB3LDF3Pl7CU5ScOzLDQ=;
 b=YyismHhEHXhWJlKYj5xjTcXJSZxV5eHSEYz60v2k/LvhxOxKjnfRtLRCcxlpbyxvVYL/yzI6AO6VuSLUeLbMqKeqc0fus4rUIHP7R2nhPi6LPqkCLvfOW23QKVZl4UMCEbLhem6XStGDxtxvJvp2zuu0u43HMcssJUjGBA2JyiZoWFtZUJjBG3EYk/to+X1WOa6NSkl2csbqqX4x+/V3hUMPVDT8bCtbwawtBM5lTMlKdu7P3vnIO61odtWPym2/a/JXI6/8jeKEUu7/6a8ErHuzufE4a6Wst+XtJhx1uOK+35j9HKAd+8nuOMzj3fGs4rDFsKCbrWzVIo/qFkbHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px99XqTrxq398VC48XCkrjLbB3LDF3Pl7CU5ScOzLDQ=;
 b=GYiD+zRVWAfzVdsFT6QAXJiuSMRyYvrxfzqxDxFukC8nrxyRwSsP5KBA+psTikk8BL756SdhhG3TOImvPvLD7f6WoThh+NLIFIlUUzA4ECYdmPH533mVKIp7y5RVmHnrj+eBJYZ0Y9XWOhxgKsPLQGxi5/N1JGIXE3c180oHrNk=
Received: from DS7PR03CA0130.namprd03.prod.outlook.com (2603:10b6:5:3b4::15)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:05:21 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::da) by DS7PR03CA0130.outlook.office365.com
 (2603:10b6:5:3b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 17:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 17:05:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 11:05:20 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	Tim Huang <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd: Add a workaround for GFX11 systems that fail to flush TLB
Date: Wed, 13 Dec 2023 11:04:54 -0600
Message-ID: <20231213170454.5962-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM8PR12MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7416236c-5c14-4466-e1ba-08dbfbfdb092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A4Tey9hL43cw+/thZ4DHC8ZdiB1vuUQtSQyiTdqZds8t5RJcgdj3ensHJD4/WnQNYgVzijosw9cDvBp/nPcEVsPk5srJ3bR730bGCM77dC63LsPL/qbwL84dji/CAGO0BSkBu4hrqLoTwvZFgtdiHrlvNU1+/I4/Nz2I+Pzlq7y4cxDrH5Wnf+G28sCR98EGCEOjr492zpBdcg4b5ezF7GIvZgTxANs8s+brce50lVCjRK4YnGyLu2aSqRzc1CGQ0frI0rwle84a/HqPRWnn6Gzvg714zjK5J/9eEyFz30u/bVcsbWAfnfQzGMjR062JCqRy7mE2mg5hNfkzm3Uc8yFmDiQtzwE8DEh5vFuHiuHvkWq16DwzxGeSfrP6fUquCVemP/YCS1a6usgJSbed618RlfBIVtXX9Wa1jO+izN2HBgypObQn//mUV20B+NE17zQQQCh1nAxT9Ba3a/kKnKMUtXS5j03Al1CfLctfYU400gyqVDQFJXSYzh9j0NrH2GEt1BUXO1HAFu91H6KyhNHZOy2GsDwX501/+x9cYWGJosm7eOUrJOs1oDFwRTHNcJL+7wO69sGkTgvWYsjziiquna5CRivS5rIGIzOxm0kOEU8sy9XsdFcqBdSkNJrx0k+Rz+e2gV8AxuflS+eZj7qW7mFW0lnS9hAjyuuKezFJrWLRlrhNMkuEMrgrJVvyqBkdRsq/oNoeGDg2N4QkfDp5THRVP+fEkfKmbFkCP9RtmiXwObDIPT+eTZXEHCGd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(1076003)(2616005)(16526019)(336012)(26005)(426003)(7696005)(6666004)(40460700003)(86362001)(82740400003)(81166007)(356005)(36756003)(5660300002)(8676002)(8936002)(44832011)(4326008)(36860700001)(83380400001)(47076005)(966005)(54906003)(6916009)(70206006)(70586007)(41300700001)(2906002)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:05:20.9833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7416236c-5c14-4466-e1ba-08dbfbfdb092
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416

Some systems with MP1 13.0.4 or 13.0.11 have a firmware bug that
causes the first MES packet after resume to fail. This packet is
used to flush the TLB when GART is enabled.

This issue is fixed in newer firmware, but as OEMs may not roll this
out to the field, introduce a workaround that will retry the flush
when detecting running on an older firmware and decrease relevant
error messages to debug while workaround is in use.

Cc: stable@vger.kernel.org # 6.1+
Cc: Tim Huang <Tim.Huang@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3045
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  8 ++++++--
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 9ddbf1494326..6ce3f6e6b6de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -836,8 +836,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
-	if (r)
-		DRM_ERROR("failed to reg_write_reg_wait\n");
+	if (r) {
+		const char *msg = "failed to reg_write_reg_wait\n";
+
+		if (adev->mes.suspend_workaround)
+			DRM_DEBUG(msg);
+		else
+			DRM_ERROR(msg);
+	}
 
 error:
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index a27b424ffe00..90f2bba3b12b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -135,6 +135,8 @@ struct amdgpu_mes {
 
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
+
+	bool				suspend_workaround;
 };
 
 struct amdgpu_mes_process {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..e810c7bb3156 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -889,7 +889,11 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 		false : true;
 
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
-	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+
+	do {
+		gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
+		adev->mes.suspend_workaround = false;
+	} while (adev->mes.suspend_workaround);
 
 	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
@@ -960,6 +964,17 @@ static int gmc_v11_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 4):
+	case IP_VERSION(13, 0, 11):
+		/* avoid problems with first TLB flush after resume */
+		if ((adev->pm.fw_version & 0x00FFFFFF) < 0x004c4900)
+			adev->mes.suspend_workaround = adev->in_s0ix;
+		break;
+	default:
+		break;
+	}
+
 	r = gmc_v11_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4dfec56e1b7f..84ab8c611e5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -137,8 +137,12 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
-		DRM_ERROR("MES failed to response msg=%d\n",
-			  x_pkt->header.opcode);
+		if (mes->suspend_workaround)
+			DRM_DEBUG("MES failed to response msg=%d\n",
+				  x_pkt->header.opcode);
+		else
+			DRM_ERROR("MES failed to response msg=%d\n",
+				  x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
-- 
2.34.1


