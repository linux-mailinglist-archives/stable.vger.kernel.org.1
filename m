Return-Path: <stable+bounces-1866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862727F81BA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADC0282FE6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B48364A7;
	Fri, 24 Nov 2023 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gkKilseu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BC2C87B;
	Fri, 24 Nov 2023 19:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BF2C433C7;
	Fri, 24 Nov 2023 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852466;
	bh=fMcjP1Y+WJ0ICf4JrUeskysR3v6b7jOHcl706cJJTJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkKilseuaqyHya3NrW5qm6vlRsneg402wi7fGAUB0yDpb1JeBdaQ3OCBUEUun6pvr
	 0+yAVS93Vtm/k9EUUoVD1vVsgvRnm3x9MWJflF/aW6y7WOTq6pnmGFqcXsiT9FQEK8
	 2WQOpGXk0N2NUh7fGz0oLrM7cfQRHcGOTQAD0CN8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Lewis Huang <lewis.huang@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 368/372] drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox
Date: Fri, 24 Nov 2023 17:52:35 +0000
Message-ID: <20231124172022.535457900@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lewis Huang <lewis.huang@amd.com>

commit 5911d02cac70d7fb52009fbd37423e63f8f6f9bc upstream.

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
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   13 ++++----
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       |   22 +++++++++------
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c   |   32 ++++++++++++++++------
 3 files changed, 45 insertions(+), 22 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2057,7 +2057,7 @@ static int dm_dmub_sw_init(struct amdgpu
 	struct dmub_srv_create_params create_params;
 	struct dmub_srv_region_params region_params;
 	struct dmub_srv_region_info region_info;
-	struct dmub_srv_fb_params fb_params;
+	struct dmub_srv_memory_params memory_params;
 	struct dmub_srv_fb_info *fb_info;
 	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -2188,6 +2188,7 @@ static int dm_dmub_sw_init(struct amdgpu
 		adev->dm.dmub_fw->data +
 		le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		PSP_HEADER_BYTES;
+	region_params.is_mailbox_in_inbox = false;
 
 	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
 					   &region_info);
@@ -2209,10 +2210,10 @@ static int dm_dmub_sw_init(struct amdgpu
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
@@ -2224,7 +2225,7 @@ static int dm_dmub_sw_init(struct amdgpu
 		return -ENOMEM;
 	}
 
-	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
+	status = dmub_srv_calc_mem_info(dmub_srv, &memory_params, fb_info);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
 		return -EINVAL;
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -174,6 +174,7 @@ struct dmub_srv_region_params {
 	uint32_t vbios_size;
 	const uint8_t *fw_inst_const;
 	const uint8_t *fw_bss_data;
+	bool is_mailbox_in_inbox;
 };
 
 /**
@@ -193,20 +194,25 @@ struct dmub_srv_region_params {
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
@@ -524,8 +530,8 @@ dmub_srv_calc_region_info(struct dmub_sr
  *   DMUB_STATUS_OK - success
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_calc_fb_info(struct dmub_srv *dmub,
-				       const struct dmub_srv_fb_params *params,
+enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
+				       const struct dmub_srv_memory_params *params,
 				       struct dmub_srv_fb_info *out);
 
 /**
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -384,7 +384,7 @@ dmub_srv_calc_region_info(struct dmub_sr
 	uint32_t fw_state_size = DMUB_FW_STATE_SIZE;
 	uint32_t trace_buffer_size = DMUB_TRACE_BUFFER_SIZE;
 	uint32_t scratch_mem_size = DMUB_SCRATCH_MEM_SIZE;
-
+	uint32_t previous_top = 0;
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
@@ -409,8 +409,15 @@ dmub_srv_calc_region_info(struct dmub_sr
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
 
@@ -429,7 +436,7 @@ dmub_srv_calc_region_info(struct dmub_sr
 			dmub->fw_version = fw_info->fw_version;
 	}
 
-	trace_buff->base = dmub_align(mail->top, 256);
+	trace_buff->base = dmub_align(previous_top, 256);
 	trace_buff->top = trace_buff->base + dmub_align(trace_buffer_size, 64);
 
 	fw_state->base = dmub_align(trace_buff->top, 256);
@@ -440,11 +447,14 @@ dmub_srv_calc_region_info(struct dmub_sr
 
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
@@ -459,8 +469,8 @@ enum dmub_status dmub_srv_calc_fb_info(s
 	if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
 		return DMUB_STATUS_INVALID;
 
-	cpu_base = (uint8_t *)params->cpu_addr;
-	gpu_base = params->gpu_addr;
+	cpu_base = (uint8_t *)params->cpu_fb_addr;
+	gpu_base = params->gpu_fb_addr;
 
 	for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
 		const struct dmub_region *reg =
@@ -468,6 +478,12 @@ enum dmub_status dmub_srv_calc_fb_info(s
 
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
 



