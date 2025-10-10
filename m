Return-Path: <stable+bounces-183951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E3BBCD322
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3C33B53EE
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F82F3C05;
	Fri, 10 Oct 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMx0+RC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507D21579F;
	Fri, 10 Oct 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102451; cv=none; b=EfpvNZXCRZd/WsUCjDT760ZZrbYOC9ACnKPY3p0vaTWzuSAhz2YnHnuiWKJB9XQPLnPnc1BEOzLSd1k1cOI0vTsoxpYNxjuB6Fk1L/9XeSgZ+QYB57NketUMMnb1GiFW2xrKCMBk0QKpDQI86FF5ObCXZWjwctdJZPxiChdH3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102451; c=relaxed/simple;
	bh=nFYu2EG9vaxoMom8i9M28Z9oUjYLZmkVegLxlel1K4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az09EivWhaL0exAA5fkRx+LVjKPLIzbrgoqfxkPAqqnQKbeJDIQT+2BElSrvBdND/nUGVGt7BkyfdiZqIdg/a4kV7POcxHs8UkOLzN/leHao5Fc6YjlwoZayeCTTziBsnquauLozdVRByzE6KsHNTmvCWUjsjQOVFrICyu5lyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMx0+RC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884DC4CEFE;
	Fri, 10 Oct 2025 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760102450;
	bh=nFYu2EG9vaxoMom8i9M28Z9oUjYLZmkVegLxlel1K4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMx0+RC6TWsDCgqMMoUVUvRjikPpdimGinV6J5qh9Nhvq1pG0lX6Ns/o7fZCwS0RH
	 Atnttpu+mwpZOPfEY6wjJbLzy2aGAcSr5ALl7vITca1evfRh1WzGgGzOSxVqLyFzQO
	 /VQW5MPuHlwE5m94DlkjiBHGAPsOWz3D5xb0MKeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shaoyun Liu <shaoyun.liu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 19/35] drm/amd : Update MES API header file for v11 & v12
Date: Fri, 10 Oct 2025 15:16:21 +0200
Message-ID: <20251010131332.488308541@linuxfoundation.org>
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

commit ce4971388c79d36b3f50f607c3278dbfae6c789b upstream.

New features require the new fields defines

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |   43 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |   31 ++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -230,13 +230,23 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t disable_add_queue_wptr_mc_addr : 1;
 				uint32_t enable_mes_event_int_logging : 1;
 				uint32_t enable_reg_active_poll : 1;
-				uint32_t reserved	: 21;
+				uint32_t use_disable_queue_in_legacy_uq_preemption : 1;
+				uint32_t send_write_data : 1;
+				uint32_t os_tdr_timeout_override : 1;
+				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t use_add_queue_unmap_flag_addr : 1;
+				uint32_t enable_mes_sch_stb_log : 1;
+				uint32_t limit_single_process : 1;
+				uint32_t is_strix_tmz_wa_enabled  :1;
+				uint32_t reserved : 13;
 			};
 			uint32_t	uint32_t_all;
 		};
 		uint32_t	oversubscription_timer;
 		uint64_t        doorbell_info;
 		uint64_t        event_intr_history_gpu_mc_ptr;
+		uint64_t	timestamp;
+		uint32_t	os_tdr_timeout_in_sec;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -563,6 +573,11 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__READ_REG,
 	MESAPI_MISC__WAIT_REG_MEM,
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
+	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+
 	MESAPI_MISC__MAX,
 };
 
@@ -617,6 +632,31 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
 };
 
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG {
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -631,6 +671,7 @@ union MESAPI__MISC {
 			struct          WAIT_REG_MEM wait_reg_mem;
 			struct		SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+			struct		CHANGE_CONFIG change_config;
 
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -643,6 +643,10 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
 	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
 	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
 
 	MESAPI_MISC__MAX,
 };
@@ -713,6 +717,31 @@ struct SET_GANG_SUBMIT {
 	uint32_t slave_gang_context_array_index;
 };
 
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG {
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct  {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 30;
+		} bits;
+		uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -726,7 +755,7 @@ union MESAPI__MISC {
 			struct WAIT_REG_MEM wait_reg_mem;
 			struct SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
-
+			struct CHANGE_CONFIG change_config;
 			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 		uint64_t		timestamp;



