Return-Path: <stable+bounces-139158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F24AA4BD1
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6941C07507
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F425B665;
	Wed, 30 Apr 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRqfm4P/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635B23815D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017312; cv=none; b=eDu3yVQS1o9+VCp+vpoBACHtfG0bFDmBAqB11Dil4GcFA8MDpaxa6gwPQicswj6n/P3A4+oW879OkHCMQ6w5xM8e/U6Ly2QDJgACYU0B+51XahT7l+3jLK/hXk3IzVZ4//RXsc+27Q3V9b+RgDE7f6KUN1heSdOS/4lyhXHAdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017312; c=relaxed/simple;
	bh=igjYp3rpSMKBS96aJ0Ha9vh1nWbriq1J7epDbbdnzoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsJrSGMDcmkHT8XCLi+KmK7ZOX6MWG6hqN50Do6i4PmKjOM3s4SbHbxerUY+BizfYwcJqs70otumqVpL2iFZMljZWLvQU3vvrGkb4fuX34s1mpgOHtXRpjBEWqkwV3B6ys8EueTmoVMgYxHJufb2zog9CSLd4N96b8AI+K3wgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRqfm4P/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017311; x=1777553311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igjYp3rpSMKBS96aJ0Ha9vh1nWbriq1J7epDbbdnzoA=;
  b=HRqfm4P/c3JRLspriFHPzF/7eTR2lHcqF7jMtt4K0VuoGvY4lf16udqV
   MLVniRvVDYxhwhxQejbf9Vhu+3L8vjJJYJg4r0dT1TeKbBIw/9A9fqd7C
   YbpBly4Wv3if2PF6NhSkC9l0RDL7gdr9bPsLCbWTp2/q3Rv+loYsI5EO/
   3DiViM1McQvISkkWmrHCu91Z4MiisNqmN6EIa3q0oisPKBQLwr30E8ULl
   QMjqitvaSkhvN8FsDajFeJxs8gPqdweZ57uFYjtfdHDSbqGVqvCAxrGCZ
   HnUD7gbMBulAh3K7MST8ppV0XWFehUDFWKqT+4fatIhZh44HOaMbPweNi
   A==;
X-CSE-ConnectionGUID: VT9w5boOQ+eifeNiuxy2Sg==
X-CSE-MsgGUID: d81M4OvBQRGqQEeE7uKrSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488511"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488511"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:30 -0700
X-CSE-ConnectionGUID: 7ZIA5qU9TuCZ8MAS1kGtmQ==
X-CSE-MsgGUID: mC3yH/yiTYyFjaEsALnb2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925415"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:28 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 4/7] accel/ivpu: Update VPU FW API headers
Date: Wed, 30 Apr 2025 14:48:16 +0200
Message-ID: <20250430124819.3761263-5-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>

commit a4293cc75348409f998c991c48cbe5532c438114 upstream.

This commit bumps:
  - Boot API from 3.24.0 to 3.26.3
  - JSM API from 3.16.0 to 3.25.0

Cc: <stable@vger.kernel.org> # v6.12
Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Co-developed-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-2-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c     |   2 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c |   3 +-
 drivers/accel/ivpu/vpu_boot_api.h |  43 +++--
 drivers/accel/ivpu/vpu_jsm_api.h  | 303 +++++++++++++++++++++++++-----
 4 files changed, 292 insertions(+), 59 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 9767cde4ccd4b..c2108346c4c9d 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -352,7 +352,7 @@ static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
 		return -EBUSY;
 	}
 
-	entry = &cmdq->jobq->job[tail];
+	entry = &cmdq->jobq->slot[tail].job;
 	entry->batch_buf_addr = job->cmd_buf_vpu_addr;
 	entry->job_id = job->job_id;
 	entry->flags = 0;
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index f7618b605f021..ae91ad24d10d8 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -48,9 +48,10 @@ const char *ivpu_jsm_msg_type_to_str(enum vpu_ipc_msg_type type)
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_HWS_RESUME_ENGINE_DONE);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_STATE_DUMP);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_STATE_DUMP_RSP);
-	IVPU_CASE_TO_STR(VPU_JSM_MSG_BLOB_DEINIT);
+	IVPU_CASE_TO_STR(VPU_JSM_MSG_BLOB_DEINIT_DEPRECATED);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_DYNDBG_CONTROL);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_JOB_DONE);
+	IVPU_CASE_TO_STR(VPU_JSM_MSG_NATIVE_FENCE_SIGNALLED);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_ENGINE_RESET_DONE);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_ENGINE_PREEMPT_DONE);
 	IVPU_CASE_TO_STR(VPU_JSM_MSG_REGISTER_DB_DONE);
diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index d474bc7b15c01..908e68ea1c39c 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * Copyright (c) 2020-2023, Intel Corporation.
+ * Copyright (c) 2020-2024, Intel Corporation.
  */
 
 #ifndef VPU_BOOT_API_H
 #define VPU_BOOT_API_H
 
 /*
- * =========== FW API version information beginning ================
  *  The below values will be used to construct the version info this way:
  *  fw_bin_header->api_version[VPU_BOOT_API_VER_ID] = (VPU_BOOT_API_VER_MAJOR << 16) |
  *  VPU_BOOT_API_VER_MINOR;
@@ -27,19 +26,18 @@
  * Minor version changes when API backward compatibility is preserved.
  * Resets to 0 if Major version is incremented.
  */
-#define VPU_BOOT_API_VER_MINOR 24
+#define VPU_BOOT_API_VER_MINOR 26
 
 /*
  * API header changed (field names, documentation, formatting) but API itself has not been changed
  */
-#define VPU_BOOT_API_VER_PATCH 0
+#define VPU_BOOT_API_VER_PATCH 3
 
 /*
  * Index in the API version table
  * Must be unique for each API
  */
 #define VPU_BOOT_API_VER_INDEX 0
-/* ------------ FW API version information end ---------------------*/
 
 #pragma pack(push, 4)
 
@@ -164,8 +162,6 @@ enum vpu_trace_destination {
 /* VPU 30xx HW component IDs are sequential, so define first and last IDs. */
 #define VPU_TRACE_PROC_BIT_30XX_FIRST VPU_TRACE_PROC_BIT_LRT
 #define VPU_TRACE_PROC_BIT_30XX_LAST  VPU_TRACE_PROC_BIT_SHV_15
-#define VPU_TRACE_PROC_BIT_KMB_FIRST  VPU_TRACE_PROC_BIT_30XX_FIRST
-#define VPU_TRACE_PROC_BIT_KMB_LAST   VPU_TRACE_PROC_BIT_30XX_LAST
 
 struct vpu_boot_l2_cache_config {
 	u8 use;
@@ -199,6 +195,17 @@ struct vpu_warm_boot_section {
  */
 #define POWER_PROFILE_SURVIVABILITY 0x1
 
+/**
+ * Enum for dvfs_mode boot param.
+ */
+enum vpu_governor {
+	VPU_GOV_DEFAULT = 0, /* Default Governor for the system */
+	VPU_GOV_MAX_PERFORMANCE = 1, /* Maximum performance governor */
+	VPU_GOV_ON_DEMAND = 2, /* On Demand frequency control governor */
+	VPU_GOV_POWER_SAVE = 3, /* Power save governor */
+	VPU_GOV_ON_DEMAND_PRIORITY_AWARE = 4 /* On Demand priority based governor */
+};
+
 struct vpu_boot_params {
 	u32 magic;
 	u32 vpu_id;
@@ -301,7 +308,14 @@ struct vpu_boot_params {
 	u32 temp_sensor_period_ms;
 	/** PLL ratio for efficient clock frequency */
 	u32 pn_freq_pll_ratio;
-	/** DVFS Mode: Default: 0, Max Performance: 1, On Demand: 2, Power Save: 3 */
+	/**
+	 * DVFS Mode:
+	 * 0 - Default, DVFS mode selected by the firmware
+	 * 1 - Max Performance
+	 * 2 - On Demand
+	 * 3 - Power Save
+	 * 4 - On Demand Priority Aware
+	 */
 	u32 dvfs_mode;
 	/**
 	 * Depending on DVFS Mode:
@@ -332,8 +346,8 @@ struct vpu_boot_params {
 	u64 d0i3_entry_vpu_ts;
 	/*
 	 * The system time of the host operating system in microseconds.
-	 * E.g the number of microseconds since 1st of January 1970, or whatever date the
-	 * host operating system uses to maintain system time.
+	 * E.g the number of microseconds since 1st of January 1970, or whatever
+	 * date the host operating system uses to maintain system time.
 	 * This value will be used to track system time on the VPU.
 	 * The KMD is required to update this value on every VPU reset.
 	 */
@@ -382,10 +396,7 @@ struct vpu_boot_params {
 	u32 pad6[734];
 };
 
-/*
- * Magic numbers set between host and vpu to detect corruptio of tracing init
- */
-
+/* Magic numbers set between host and vpu to detect corruption of tracing init */
 #define VPU_TRACING_BUFFER_CANARY (0xCAFECAFE)
 
 /* Tracing buffer message format definitions */
@@ -405,7 +416,9 @@ struct vpu_tracing_buffer_header {
 	u32 host_canary_start;
 	/* offset from start of buffer for trace entries */
 	u32 read_index;
-	u32 pad_to_cache_line_size_0[14];
+	/* keeps track of wrapping on the reader side */
+	u32 read_wrap_count;
+	u32 pad_to_cache_line_size_0[13];
 	/* End of first cache line */
 
 	/**
diff --git a/drivers/accel/ivpu/vpu_jsm_api.h b/drivers/accel/ivpu/vpu_jsm_api.h
index 33f462b1a25d8..7215c144158cb 100644
--- a/drivers/accel/ivpu/vpu_jsm_api.h
+++ b/drivers/accel/ivpu/vpu_jsm_api.h
@@ -22,7 +22,7 @@
 /*
  * Minor version changes when API backward compatibility is preserved.
  */
-#define VPU_JSM_API_VER_MINOR 16
+#define VPU_JSM_API_VER_MINOR 25
 
 /*
  * API header changed (field names, documentation, formatting) but API itself has not been changed
@@ -36,7 +36,7 @@
 
 /*
  * Number of Priority Bands for Hardware Scheduling
- * Bands: RealTime, Focus, Normal, Idle
+ * Bands: Idle(0), Normal(1), Focus(2), RealTime(3)
  */
 #define VPU_HWS_NUM_PRIORITY_BANDS 4
 
@@ -74,6 +74,7 @@
 #define VPU_JSM_STATUS_MVNCI_INTERNAL_ERROR		 0xCU
 /* Job status returned when the job was preempted mid-inference */
 #define VPU_JSM_STATUS_PREEMPTED_MID_INFERENCE		 0xDU
+#define VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW	 0xEU
 
 /*
  * Host <-> VPU IPC channels.
@@ -86,18 +87,58 @@
 /*
  * Job flags bit masks.
  */
-#define VPU_JOB_FLAGS_NULL_SUBMISSION_MASK 0x00000001
-#define VPU_JOB_FLAGS_PRIVATE_DATA_MASK	   0xFF000000
+enum {
+	/*
+	 * Null submission mask.
+	 * When set, batch buffer's commands are not processed but returned as
+	 * successful immediately, except fences and timestamps.
+	 * When cleared, batch buffer's commands are processed normally.
+	 * Used for testing and profiling purposes.
+	 */
+	VPU_JOB_FLAGS_NULL_SUBMISSION_MASK = (1 << 0U),
+	/*
+	 * Inline command mask.
+	 * When set, the object in job queue is an inline command (see struct vpu_inline_cmd below).
+	 * When cleared, the object in job queue is a job (see struct vpu_job_queue_entry below).
+	 */
+	VPU_JOB_FLAGS_INLINE_CMD_MASK = (1 << 1U),
+	/*
+	 * VPU private data mask.
+	 * Reserved for the VPU to store private data about the job (or inline command)
+	 * while being processed.
+	 */
+	VPU_JOB_FLAGS_PRIVATE_DATA_MASK = 0xFFFF0000U
+};
 
 /*
- * Sizes of the reserved areas in jobs, in bytes.
+ * Job queue flags bit masks.
  */
-#define VPU_JOB_RESERVED_BYTES 8
+enum {
+	/*
+	 * No job done notification mask.
+	 * When set, indicates that no job done notification should be sent for any
+	 * job from this queue. When cleared, indicates that job done notification
+	 * should be sent for every job completed from this queue.
+	 */
+	VPU_JOB_QUEUE_FLAGS_NO_JOB_DONE_MASK = (1 << 0U),
+	/*
+	 * Native fence usage mask.
+	 * When set, indicates that job queue uses native fences (as inline commands
+	 * in job queue). Such queues may also use legacy fences (as commands in batch buffers).
+	 * When cleared, indicates the job queue only uses legacy fences.
+	 * NOTE: For queues using native fences, VPU expects that all jobs in the queue
+	 * are immediately followed by an inline command object. This object is expected
+	 * to be a fence signal command in most cases, but can also be a NOP in case the host
+	 * does not need per-job fence signalling. Other inline commands objects can be
+	 * inserted between "job and inline command" pairs.
+	 */
+	VPU_JOB_QUEUE_FLAGS_USE_NATIVE_FENCE_MASK = (1 << 1U),
 
-/*
- * Sizes of the reserved areas in job queues, in bytes.
- */
-#define VPU_JOB_QUEUE_RESERVED_BYTES 52
+	/*
+	 * Enable turbo mode for testing NPU performance; not recommended for regular usage.
+	 */
+	VPU_JOB_QUEUE_FLAGS_TURBO_MODE = (1 << 2U)
+};
 
 /*
  * Max length (including trailing NULL char) of trace entity name (e.g., the
@@ -140,24 +181,113 @@
  */
 #define VPU_HWS_INVALID_CMDQ_HANDLE 0ULL
 
+/*
+ * Inline commands types.
+ */
+/*
+ * NOP.
+ * VPU does nothing other than consuming the inline command object.
+ */
+#define VPU_INLINE_CMD_TYPE_NOP		 0x0
+/*
+ * Fence wait.
+ * VPU waits for the fence current value to reach monitored value.
+ * Fence wait operations are executed upon job dispatching. While waiting for
+ * the fence to be satisfied, VPU blocks fetching of the next objects in the queue.
+ * Jobs present in the queue prior to the fence wait object may be processed
+ * concurrently.
+ */
+#define VPU_INLINE_CMD_TYPE_FENCE_WAIT	 0x1
+/*
+ * Fence signal.
+ * VPU sets the fence current value to the provided value. If new current value
+ * is equal to or higher than monitored value, VPU sends fence signalled notification
+ * to the host. Fence signal operations are executed upon completion of all the jobs
+ * present in the queue prior to them, and in-order relative to each other in the queue.
+ * But jobs in-between them may be processed concurrently and may complete out-of-order.
+ */
+#define VPU_INLINE_CMD_TYPE_FENCE_SIGNAL 0x2
+
+/*
+ * Job scheduling priority bands for both hardware scheduling and OS scheduling.
+ */
+enum vpu_job_scheduling_priority_band {
+	VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE = 0,
+	VPU_JOB_SCHEDULING_PRIORITY_BAND_NORMAL = 1,
+	VPU_JOB_SCHEDULING_PRIORITY_BAND_FOCUS = 2,
+	VPU_JOB_SCHEDULING_PRIORITY_BAND_REALTIME = 3,
+	VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT = 4,
+};
+
 /*
  * Job format.
+ * Jobs defines the actual workloads to be executed by a given engine.
  */
 struct vpu_job_queue_entry {
-	u64 batch_buf_addr; /**< Address of VPU commands batch buffer */
-	u32 job_id;	  /**< Job ID */
-	u32 flags; /**< Flags bit field, see VPU_JOB_FLAGS_* above */
-	u64 root_page_table_addr; /**< Address of root page table to use for this job */
-	u64 root_page_table_update_counter; /**< Page tables update events counter */
-	u64 primary_preempt_buf_addr;
+	/**< Address of VPU commands batch buffer */
+	u64 batch_buf_addr;
+	/**< Job ID */
+	u32 job_id;
+	/**< Flags bit field, see VPU_JOB_FLAGS_* above */
+	u32 flags;
+	/**
+	 * Doorbell ring timestamp taken by KMD from SoC's global system clock, in
+	 * microseconds. NPU can convert this value to its own fixed clock's timebase,
+	 * to match other profiling timestamps.
+	 */
+	u64 doorbell_timestamp;
+	/**< Extra id for job tracking, used only in the firmware perf traces */
+	u64 host_tracking_id;
 	/**< Address of the primary preemption buffer to use for this job */
-	u32 primary_preempt_buf_size;
+	u64 primary_preempt_buf_addr;
 	/**< Size of the primary preemption buffer to use for this job */
-	u32 secondary_preempt_buf_size;
+	u32 primary_preempt_buf_size;
 	/**< Size of secondary preemption buffer to use for this job */
-	u64 secondary_preempt_buf_addr;
+	u32 secondary_preempt_buf_size;
 	/**< Address of secondary preemption buffer to use for this job */
-	u8 reserved_0[VPU_JOB_RESERVED_BYTES];
+	u64 secondary_preempt_buf_addr;
+	u64 reserved_0;
+};
+
+/*
+ * Inline command format.
+ * Inline commands are the commands executed at scheduler level (typically,
+ * synchronization directives). Inline command and job objects must be of
+ * the same size and have flags field at same offset.
+ */
+struct vpu_inline_cmd {
+	u64 reserved_0;
+	/* Inline command type, see VPU_INLINE_CMD_TYPE_* defines. */
+	u32 type;
+	/* Flags bit field, see VPU_JOB_FLAGS_* above. */
+	u32 flags;
+	/* Inline command payload. Depends on inline command type. */
+	union {
+		/* Fence (wait and signal) commands' payload. */
+		struct {
+			/* Fence object handle. */
+			u64 fence_handle;
+			/* User VA of the current fence value. */
+			u64 current_value_va;
+			/* User VA of the monitored fence value (read-only). */
+			u64 monitored_value_va;
+			/* Value to wait for or write in fence location. */
+			u64 value;
+			/* User VA of the log buffer in which to add log entry on completion. */
+			u64 log_buffer_va;
+		} fence;
+		/* Other commands do not have a payload. */
+		/* Payload definition for future inline commands can be inserted here. */
+		u64 reserved_1[6];
+	} payload;
+};
+
+/*
+ * Job queue slots can be populated either with job objects or inline command objects.
+ */
+union vpu_jobq_slot {
+	struct vpu_job_queue_entry job;
+	struct vpu_inline_cmd inline_cmd;
 };
 
 /*
@@ -167,7 +297,21 @@ struct vpu_job_queue_header {
 	u32 engine_idx;
 	u32 head;
 	u32 tail;
-	u8 reserved_0[VPU_JOB_QUEUE_RESERVED_BYTES];
+	u32 flags;
+	/* Set to 1 to indicate priority_band field is valid */
+	u32 priority_band_valid;
+	/*
+	 * Priority for the work of this job queue, valid only if the HWS is NOT used
+	 * and the `priority_band_valid` is set to 1. It is applied only during
+	 * the VPU_JSM_MSG_REGISTER_DB message processing.
+	 * The device firmware might use the `priority_band` to optimize the power
+	 * management logic, but it will not affect the order of jobs.
+	 * Available priority bands: @see enum vpu_job_scheduling_priority_band
+	 */
+	u32 priority_band;
+	/* Inside realtime band assigns a further priority, limited to 0..31 range */
+	u32 realtime_priority_level;
+	u32 reserved_0[9];
 };
 
 /*
@@ -175,7 +319,7 @@ struct vpu_job_queue_header {
  */
 struct vpu_job_queue {
 	struct vpu_job_queue_header header;
-	struct vpu_job_queue_entry job[];
+	union vpu_jobq_slot slot[];
 };
 
 /**
@@ -197,9 +341,7 @@ enum vpu_trace_entity_type {
 struct vpu_hws_log_buffer_header {
 	/* Written by VPU after adding a log entry. Initialised by host to 0. */
 	u32 first_free_entry_index;
-	/* Incremented by VPU every time the VPU overwrites the 0th entry;
-	 * initialised by host to 0.
-	 */
+	/* Incremented by VPU every time the VPU writes the 0th entry; initialised by host to 0. */
 	u32 wraparound_count;
 	/*
 	 * This is the number of buffers that can be stored in the log buffer provided by the host.
@@ -230,14 +372,80 @@ struct vpu_hws_log_buffer_entry {
 	u64 operation_data[2];
 };
 
+/* Native fence log buffer types. */
+enum vpu_hws_native_fence_log_type {
+	VPU_HWS_NATIVE_FENCE_LOG_TYPE_WAITS = 1,
+	VPU_HWS_NATIVE_FENCE_LOG_TYPE_SIGNALS = 2
+};
+
+/* HWS native fence log buffer header. */
+struct vpu_hws_native_fence_log_header {
+	union {
+		struct {
+			/* Index of the first free entry in buffer. */
+			u32 first_free_entry_idx;
+			/* Incremented each time NPU wraps around the buffer to write next entry. */
+			u32 wraparound_count;
+		};
+		/* Field allowing atomic update of both fields above. */
+		u64 atomic_wraparound_and_entry_idx;
+	};
+	/* Log buffer type, see enum vpu_hws_native_fence_log_type. */
+	u64 type;
+	/* Allocated number of entries in the log buffer. */
+	u64 entry_nb;
+	u64 reserved[2];
+};
+
+/* Native fence log operation types. */
+enum vpu_hws_native_fence_log_op {
+	VPU_HWS_NATIVE_FENCE_LOG_OP_SIGNAL_EXECUTED = 0,
+	VPU_HWS_NATIVE_FENCE_LOG_OP_WAIT_UNBLOCKED = 1
+};
+
+/* HWS native fence log entry. */
+struct vpu_hws_native_fence_log_entry {
+	/* Newly signaled/unblocked fence value. */
+	u64 fence_value;
+	/* Native fence object handle to which this operation belongs. */
+	u64 fence_handle;
+	/* Operation type, see enum vpu_hws_native_fence_log_op. */
+	u64 op_type;
+	u64 reserved_0;
+	/*
+	 * VPU_HWS_NATIVE_FENCE_LOG_OP_WAIT_UNBLOCKED only: Timestamp at which fence
+	 * wait was started (in NPU SysTime).
+	 */
+	u64 fence_wait_start_ts;
+	u64 reserved_1;
+	/* Timestamp at which fence operation was completed (in NPU SysTime). */
+	u64 fence_end_ts;
+};
+
+/* Native fence log buffer. */
+struct vpu_hws_native_fence_log_buffer {
+	struct vpu_hws_native_fence_log_header header;
+	struct vpu_hws_native_fence_log_entry entry[];
+};
+
 /*
  * Host <-> VPU IPC messages types.
  */
 enum vpu_ipc_msg_type {
 	VPU_JSM_MSG_UNKNOWN = 0xFFFFFFFF,
+
 	/* IPC Host -> Device, Async commands */
 	VPU_JSM_MSG_ASYNC_CMD = 0x1100,
 	VPU_JSM_MSG_ENGINE_RESET = VPU_JSM_MSG_ASYNC_CMD,
+	/**
+	 * Preempt engine. The NPU stops (preempts) all the jobs currently
+	 * executing on the target engine making the engine become idle and ready to
+	 * execute new jobs.
+	 * NOTE: The NPU does not remove unstarted jobs (if any) from job queues of
+	 * the target engine, but it stops processing them (until the queue doorbell
+	 * is rung again); the host is responsible to reset the job queue, either
+	 * after preemption or when resubmitting jobs to the queue.
+	 */
 	VPU_JSM_MSG_ENGINE_PREEMPT = 0x1101,
 	VPU_JSM_MSG_REGISTER_DB = 0x1102,
 	VPU_JSM_MSG_UNREGISTER_DB = 0x1103,
@@ -323,9 +531,10 @@ enum vpu_ipc_msg_type {
 	 * NOTE: Please introduce new ASYNC commands before this one. *
 	 */
 	VPU_JSM_MSG_STATE_DUMP = 0x11FF,
+
 	/* IPC Host -> Device, General commands */
 	VPU_JSM_MSG_GENERAL_CMD = 0x1200,
-	VPU_JSM_MSG_BLOB_DEINIT = VPU_JSM_MSG_GENERAL_CMD,
+	VPU_JSM_MSG_BLOB_DEINIT_DEPRECATED = VPU_JSM_MSG_GENERAL_CMD,
 	/**
 	 * Control dyndbg behavior by executing a dyndbg command; equivalent to
 	 * Linux command: `echo '<dyndbg_cmd>' > <debugfs>/dynamic_debug/control`.
@@ -335,8 +544,12 @@ enum vpu_ipc_msg_type {
 	 * Perform the save procedure for the D0i3 entry
 	 */
 	VPU_JSM_MSG_PWR_D0I3_ENTER = 0x1202,
+
 	/* IPC Device -> Host, Job completion */
 	VPU_JSM_MSG_JOB_DONE = 0x2100,
+	/* IPC Device -> Host, Fence signalled */
+	VPU_JSM_MSG_NATIVE_FENCE_SIGNALLED = 0x2101,
+
 	/* IPC Device -> Host, Async command completion */
 	VPU_JSM_MSG_ASYNC_CMD_DONE = 0x2200,
 	VPU_JSM_MSG_ENGINE_RESET_DONE = VPU_JSM_MSG_ASYNC_CMD_DONE,
@@ -422,6 +635,7 @@ enum vpu_ipc_msg_type {
 	 * NOTE: Please introduce new ASYNC responses before this one. *
 	 */
 	VPU_JSM_MSG_STATE_DUMP_RSP = 0x22FF,
+
 	/* IPC Device -> Host, General command completion */
 	VPU_JSM_MSG_GENERAL_CMD_DONE = 0x2300,
 	VPU_JSM_MSG_BLOB_DEINIT_DONE = VPU_JSM_MSG_GENERAL_CMD_DONE,
@@ -600,11 +814,6 @@ struct vpu_jsm_metric_streamer_update {
 	u64 next_buffer_size;
 };
 
-struct vpu_ipc_msg_payload_blob_deinit {
-	/* 64-bit unique ID for the blob to be de-initialized. */
-	u64 blob_id;
-};
-
 struct vpu_ipc_msg_payload_job_done {
 	/* Engine to which the job was submitted. */
 	u32 engine_idx;
@@ -622,6 +831,21 @@ struct vpu_ipc_msg_payload_job_done {
 	u64 cmdq_id;
 };
 
+/*
+ * Notification message upon native fence signalling.
+ * @see VPU_JSM_MSG_NATIVE_FENCE_SIGNALLED
+ */
+struct vpu_ipc_msg_payload_native_fence_signalled {
+	/* Engine ID. */
+	u32 engine_idx;
+	/* Host SSID. */
+	u32 host_ssid;
+	/* CMDQ ID */
+	u64 cmdq_id;
+	/* Fence object handle. */
+	u64 fence_handle;
+};
+
 struct vpu_jsm_engine_reset_context {
 	/* Host SSID */
 	u32 host_ssid;
@@ -700,11 +924,6 @@ struct vpu_ipc_msg_payload_get_power_level_count_done {
 	u8 power_limit[16];
 };
 
-struct vpu_ipc_msg_payload_blob_deinit_done {
-	/* 64-bit unique ID for the blob de-initialized. */
-	u64 blob_id;
-};
-
 /* HWS priority band setup request / response */
 struct vpu_ipc_msg_payload_hws_priority_band_setup {
 	/*
@@ -794,7 +1013,10 @@ struct vpu_ipc_msg_payload_hws_set_context_sched_properties {
 	u32 reserved_0;
 	/* Command queue id */
 	u64 cmdq_id;
-	/* Priority band to assign to work of this context */
+	/*
+	 * Priority band to assign to work of this context.
+	 * Available priority bands: @see enum vpu_job_scheduling_priority_band
+	 */
 	u32 priority_band;
 	/* Inside realtime band assigns a further priority */
 	u32 realtime_priority_level;
@@ -869,9 +1091,7 @@ struct vpu_ipc_msg_payload_hws_set_scheduling_log {
 	 */
 	u64 notify_index;
 	/*
-	 * Enable extra events to be output to log for debug of scheduling algorithm.
-	 * Interpreted by VPU as a boolean to enable or disable, expected values are
-	 * 0 and 1.
+	 * Field is now deprecated, will be removed when KMD is updated to support removal
 	 */
 	u32 enable_extra_events;
 	/* Zero Padding */
@@ -1243,10 +1463,10 @@ union vpu_ipc_msg_payload {
 	struct vpu_jsm_metric_streamer_start metric_streamer_start;
 	struct vpu_jsm_metric_streamer_stop metric_streamer_stop;
 	struct vpu_jsm_metric_streamer_update metric_streamer_update;
-	struct vpu_ipc_msg_payload_blob_deinit blob_deinit;
 	struct vpu_ipc_msg_payload_ssid_release ssid_release;
 	struct vpu_jsm_hws_register_db hws_register_db;
 	struct vpu_ipc_msg_payload_job_done job_done;
+	struct vpu_ipc_msg_payload_native_fence_signalled native_fence_signalled;
 	struct vpu_ipc_msg_payload_engine_reset_done engine_reset_done;
 	struct vpu_ipc_msg_payload_engine_preempt_done engine_preempt_done;
 	struct vpu_ipc_msg_payload_register_db_done register_db_done;
@@ -1254,7 +1474,6 @@ union vpu_ipc_msg_payload {
 	struct vpu_ipc_msg_payload_query_engine_hb_done query_engine_hb_done;
 	struct vpu_ipc_msg_payload_get_power_level_count_done get_power_level_count_done;
 	struct vpu_jsm_metric_streamer_done metric_streamer_done;
-	struct vpu_ipc_msg_payload_blob_deinit_done blob_deinit_done;
 	struct vpu_ipc_msg_payload_trace_config trace_config;
 	struct vpu_ipc_msg_payload_trace_capability_rsp trace_capability;
 	struct vpu_ipc_msg_payload_trace_get_name trace_get_name;
-- 
2.45.1


