Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B67E5E33
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjKHTJd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 14:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKHTJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 14:09:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5742117
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 11:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAvXtvYCnSy26PJfOlC754d5tJzYS7x8HJvCegx5bPQ/1tW7u4fFb6yvO+EpA3gxgueQfr9ByNJKZ0LDA/nY3YCFlUu8iyFWGVtHTJuAAds8Da7kujPEN1BKuNk2uiLiCWtOnsKjfOV3bqIc8CRNLUV4B1u95CMwNxWhfHliIe3zBN9MxkdgojJ4u+h4o6MgERDN9Tab3ex0PPkZPgXI1HZzVLLZvzTgR0oTBxOF5hLULNKS3vFFP5PJ7NXmLqlbg3ESXn+wIb/U6zqtAM8zYl8cdGjdF1WEvd2H7Ll4Alw8L+pa32yVcQ/c1t9ZslpCc4HsCJ2pkJr8ft+d+apxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL3l1/AkcmUPoXVtNLTLjEyp183HecvgSYsCRHgAd+o=;
 b=gA4J42uCHpiHY99eAjXesXoGO+L0KQ+M+miJ6JTM9SIJo1Qgap8LSkUE04iYZ6iZy7Oo7lQtYcwa2UvMGcTL+mr/hhssm5hlAEvY7bxVrawbulviOOS9crL2BRzvAWY6I/xe2hwcnzEw1JOcLKwWizXvhVlNvMhGshKi860QUQ1t5P+CdhV8rZ3AL/udAePYBL3z7iReCDrRhBIupXdGpGG0xrSVUQ3xeASGFIWidoor+68VFNlRfKXKK0IBCot7F/wyiy43I1pSqmioZgs4Gcch4HIekFrdI1wW7dX4donVNm6UPNeCCLY36GjljOPKhTPug74rmIotofn0UDfCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL3l1/AkcmUPoXVtNLTLjEyp183HecvgSYsCRHgAd+o=;
 b=ZGU6N1d+TCjWzPmn3pY51j73w2A1uhY5JPIt67cu4B9kre8nkVAcWc3rHotHgGMkF8V08vn2aa46hyepENDLV8OxTPzRBAahEgIBy3HEXNlrCIxU7tZnKNdHptkBbgjC2uzlIcHsfh1rJS6NLbATXySBsC1fPYGTwj1TOZRYpUc=
Received: from CH2PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:59::32)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 19:09:22 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ce) by CH2PR03CA0022.outlook.office365.com
 (2603:10b6:610:59::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:09:22 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:09:19 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
        <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
        <roman.li@amd.com>, <wayne.lin@amd.com>, <stylon.wang@amd.com>,
        <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
        <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>,
        "Lewis Huang" <lewis.huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        <stable@vger.kernel.org>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        Alex Hung <alex.hung@amd.com>
Subject: [PATCH 14/20] drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox
Date:   Wed, 8 Nov 2023 11:44:29 -0700
Message-ID: <20231108185501.45359-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1b98b2-2a8a-4954-c752-08dbe08e3796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34/pJ2H+150s/c1UzWCIIw4SYi6gW2FPwCl4jEtkgskZfRDKRzYhVe9TCXK1P5IfeVKfRXi7df1Os1Gic2dHwEnvr47RgiN7TBuzHgu8unAjsdyDPreUsZA/ZpuWuy/2FTFQx35UWj0CGlHGFoIqffNjnvTRXpHEhmCljwCmvMJB2n49VSeI49cIJ8i2P+kc/QTSgD3olFITOoZQvh7LfZa+ef9kf7u8I2hV5QigZRhB0eay16ekltXdf3qLHPWfeAuZZdMy541TeC8/MDpEkKFH7Zjl1XHpRH1j74tnOHsf3iwOO8Gp58grKzP01g3t/MuNTKl1+iWEhXd+7UqPJ6uUQNoadTUIjGIla3gaakmWJ30bnlJTLYR85i83UCBi5K5EghILT+mer12ASH81+710BcgDmNFyjyN1U4WRjg5pqcat/MGkVPdegHZpcRvn3xWWpx2Si3vBR0isI68XlnSvAjvH+RaiDYs045tZGh4mnhtP0oKYuHBcpLlEN5YnMNkmDwA+3dXjEU/iBAZjkbiJHJes614vvMGUL5Q9R9VnDTjU2my/mZWcJYFuhYhduD32uU+ARNFKtCjpV+ekcEKEGFS/gZsWgw4Z38FnOMWhLmj3WGdTq/TSZDnfKIGooh1PlWOIfV+8OvG6bt2AbTp6TP5Xks9PbmftWL6A3Csc9Wp+QIFDhAsYHkzXAILHvfN1V0A9nEluyjGF2diOPp8bl3W+6X4/sb56Mv4NDZszNzqd/GCSYR9GNEK/iiELy/ZRJYab646FL12WqyV+xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(336012)(83380400001)(2616005)(81166007)(426003)(6666004)(7696005)(1076003)(26005)(16526019)(478600001)(40480700001)(82740400003)(47076005)(36860700001)(356005)(70586007)(70206006)(6916009)(54906003)(8936002)(316002)(44832011)(4326008)(15650500001)(86362001)(2906002)(5660300002)(41300700001)(40460700003)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:09:22.4882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1b98b2-2a8a-4954-c752-08dbe08e3796
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lewis Huang <lewis.huang@amd.com>

[WHY]
Flush command sent to DMCUB spends more time for execution on
a dGPU than on an APU. This causes cursor lag when using high
refresh rate mouses.

[HOW]
1. Change the DMCUB mailbox memory location from FB to inbox.
2. Only change windows memory to inbox.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Lewis Huang <lewis.huang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++----
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 22 ++++++++-----
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 32 ++++++++++++++-----
 3 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ebdbfbbb691..6199440a9da8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2078,7 +2078,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	struct dmub_srv_create_params create_params;
 	struct dmub_srv_region_params region_params;
 	struct dmub_srv_region_info region_info;
-	struct dmub_srv_fb_params fb_params;
+	struct dmub_srv_memory_params memory_params;
 	struct dmub_srv_fb_info *fb_info;
 	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -2181,6 +2181,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		PSP_HEADER_BYTES;
+	region_params.is_mailbox_in_inbox = false;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -2204,10 +2205,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return r;
 
 	/* Rebase the regions on the framebuffer address. */
-	memset(&fb_params, 0, sizeof(fb_params));
-	fb_params.cpu_addr = adev->dm.dmub_bo_cpu_addr;
-	fb_params.gpu_addr = adev->dm.dmub_bo_gpu_addr;
-	fb_params.region_info = &region_info;
+	memset(&memory_params, 0, sizeof(memory_params));
+	memory_params.cpu_fb_addr = adev->dm.dmub_bo_cpu_addr;
+	memory_params.gpu_fb_addr = adev->dm.dmub_bo_gpu_addr;
+	memory_params.region_info = &region_info;
 
 	adev->dm.dmub_fb_info =
 		kzalloc(sizeof(*adev->dm.dmub_fb_info), GFP_KERNEL);
@@ -2219,7 +2220,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
-	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
+	status = dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 9665ada0f894..df63aa8f01e9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -195,6 +195,7 @@ struct dmub_srv_region_params {
 	uint32_t vbios_size;
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
+	bool is_mailbox_in_inbox;
 };
 
 /**
@@ -214,20 +215,25 @@ struct dmub_srv_region_params {
  */
 struct dmub_srv_region_info {
 	uint32_t fb_size;
+	uint32_t inbox_size;
 	uint8_t num_regions;
 	struct dmub_region regions[DMUB_WINDOW_TOTAL];
 };
 
 /**
- * struct dmub_srv_fb_params - parameters used for driver fb setup
+ * struct dmub_srv_memory_params - parameters used for driver fb setup
  * @region_info: region info calculated by dmub service
- * @cpu_addr: base cpu address for the framebuffer
- * @gpu_addr: base gpu virtual address for the framebuffer
+ * @cpu_fb_addr: base cpu address for the framebuffer
+ * @cpu_inbox_addr: base cpu address for the gart
+ * @gpu_fb_addr: base gpu virtual address for the framebuffer
+ * @gpu_inbox_addr: base gpu virtual address for the gart
  */
-struct dmub_srv_fb_params {
+struct dmub_srv_memory_params {
 	const struct dmub_srv_region_info *region_info;
-	void *cpu_addr;
-	uint64_t gpu_addr;
+	void *cpu_fb_addr;
+	void *cpu_inbox_addr;
+	uint64_t gpu_fb_addr;
+	uint64_t gpu_inbox_addr;
 };
 
 /**
@@ -563,8 +569,8 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
  *   DMUB_STATUS_OK - success
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
-				       const struct dmub_srv_fb_params *params,
+enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
+				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out);
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 5d36f3e5dc2b..22fc4ba96def 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -434,7 +434,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
-
+	uint32_t previous_top = 0;
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
@@ -459,8 +459,15 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	bios->base = dmub_align(stack->top, 256);
 	bios->top = bios->base + params->vbios_size;
 
-	mail->base = dmub_align(bios->top, 256);
-	mail->top = mail->base + DMUB_MAILBOX_SIZE;
+	if (params->is_mailbox_in_inbox) {
+		mail->base = 0;
+		mail->top = mail->base + DMUB_MAILBOX_SIZE;
+		previous_top = bios->top;
+	} else {
+		mail->base = dmub_align(bios->top, 256);
+		mail->top = mail->base + DMUB_MAILBOX_SIZE;
+		previous_top = mail->top;
+	}
 
 	fw_info = dmub_get_fw_meta_info(params);
 
@@ -479,7 +486,7 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	trace_buff->base = dmub_align(mail->top, 256);
+	trace_buff->base = dmub_align(previous_top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
 	fw_state->base = dmub_align(trace_buff->top, 256);
@@ -490,11 +497,14 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 
 	out->fb_size = dmub_align(scratch_mem->top, 4096);
 
+	if (params->is_mailbox_in_inbox)
+		out->inbox_size = dmub_align(mail->top, 4096);
+
 	return DMUB_STATUS_OK;
 }
 
-enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
-				       const struct dmub_srv_fb_params *params,
+enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
+				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out)
 {
 	uint8_t *cpu_base;
@@ -509,8 +519,8 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 	if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
 		return DMUB_STATUS_INVALID;
 
-	cpu_base = (uint8_t *)params->cpu_addr;
-	gpu_base = params->gpu_addr;
+	cpu_base = (uint8_t *)params->cpu_fb_addr;
+	gpu_base = params->gpu_fb_addr;
 
 	for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
 		const struct dmub_region *reg =
@@ -518,6 +528,12 @@ enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
 
 		out->fb[i].cpu_addr = cpu_base + reg->base;
 		out->fb[i].gpu_addr = gpu_base + reg->base;
+
+		if (i == DMUB_WINDOW_4_MAILBOX && params->cpu_inbox_addr != 0) {
+			out->fb[i].cpu_addr = (uint8_t *)params->cpu_inbox_addr + reg->base;
+			out->fb[i].gpu_addr = params->gpu_inbox_addr + reg->base;
+		}
+
 		out->fb[i].size = reg->top - reg->base;
 	}
 
-- 
2.42.0

