Return-Path: <stable+bounces-183962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A2BCD3D7
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011C91B20ED1
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A99A2F5461;
	Fri, 10 Oct 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixfR5IF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535226A1AB;
	Fri, 10 Oct 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102482; cv=none; b=C4ZY5TfXojOUIe/qHkROE6CWfJ5U2GAD2y6bOvPbMAKIW7vMn+yMgSnMxeGCUvv03CNezDI/TCsnfnMwwxyh46Fo8HRrnQr0OeNGDr/vSXSKP0YSbErRhOfnNXOqwpUdRMIHpCqcY0IBZtfDUYsat6tACDTcuwrC/0wvDw7694M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102482; c=relaxed/simple;
	bh=BS7aS3JGTOPUjQveXb6xFH6/zFuvc/3HEWeDNoqx2lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re7MRci42WlVpPLw3C6tEMkwezXI1B6cTCGZHxQIMv0TuvJnT8163dBpiF4ya99qiOzryxnMOYrjVCkF8KRD5N3wA94vRV94Z5FeZG1Gvt3sdjQTS5Ktra/HeKvzJY9L6mmSkcvOGHCoc3ljNXo2Ihn35XSefhqqmdifYha4ZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixfR5IF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71EFC4CEF1;
	Fri, 10 Oct 2025 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102482;
	bh=BS7aS3JGTOPUjQveXb6xFH6/zFuvc/3HEWeDNoqx2lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixfR5IF4PSyU4Gfb8k9V8UKryyaOSQU7KnPYglJi+hARPQPnLBy4tOqkXdIOJqI+5
	 6pBMOdXhDpvZl6AuXWSmFMSR9TNUo0KVJrTfHRxGHQ/JFMLoUWheSvdn5I6qa6ctbg
	 cLoY/qYfTps1G07RHBnJSFlTM6UoxlN7rtQjpV3E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.12 22/35] drm/amdgpu: Enable MES lr_compute_wa by default
Date: Fri, 10 Oct 2025 15:16:24 +0200
Message-ID: <20251010131332.594720110@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 1fb710793ce2619223adffaf981b1ff13cd48f17 upstream.

The MES set resources packet has an optional bit 'lr_compute_wa'
which can be used for preventing MES hangs on long compute jobs.

Set this bit by default.

Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |    6 ++++++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |    5 +++++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |    3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |    3 ++-
 4 files changed, 15 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -677,6 +677,12 @@ static int mes_v11_0_set_hw_resources(st
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x7f)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(mes->adev->dev,
+			      "MES FW version must be >= 0x7f to enable LR compute workaround.\n");
+
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -610,6 +610,11 @@ static int mes_v12_0_set_hw_resources(st
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x82)
+		mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+	else
+		dev_info_once(adev->dev,
+			      "MES FW version must be >= 0x82 to enable LR compute workaround.\n");
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t reserved : 13;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 12;
 			};
 			uint32_t	uint32_t_all;
 		};
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -286,7 +286,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t reserved : 10;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 9;
 			};
 			uint32_t uint32_all;
 		};



