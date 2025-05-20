Return-Path: <stable+bounces-145662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BAABDCB6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032B81BC00C0
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D725C839;
	Tue, 20 May 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wNFlf0BT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86124679D;
	Tue, 20 May 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750845; cv=none; b=JOV7F44BIlWDC6jCL02SBhROEG2y8FYT/tMlWzVm9uFILi9z1Ms92zZEGOLpR8W0WEWwz3K3pup3TyQYGEFUGUwlEJqBR7QVI+oQaFb0SnBuXPc6Us4LuyHqJVIuHaTfVU1++3PE2nF5G5dHWEkBmoqKFlO8ktWta7ysu1L9qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750845; c=relaxed/simple;
	bh=e3PO174W8lMOE0NngHeztkw4bknm/y3t1Hd/eONUDHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfKNd67bZS1E2wP2FU2U2GwtfjA3VpsYLFb5iq+/6D0ofiKw4DF7uSifKIN5wICtgGFk1iIa1W5YCdTG0NPTm+6tX1wTuqxoJ3Sw4LPMX2SGtquPrtkd3Qrl1ACod/g3xgZbHD03qFinyYMq6LC28b3xu6IuTU3C73q9BLLlXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wNFlf0BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2893C4CEE9;
	Tue, 20 May 2025 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750845;
	bh=e3PO174W8lMOE0NngHeztkw4bknm/y3t1Hd/eONUDHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wNFlf0BTHDgjfMIFo3KDDWzOM5PBO+JkxU2JMO6PtbTvdvcv84neRsyPnW6JXCmYB
	 lo8e/o2lf/LBFLckvKG/2/SGtiKO4Nlz3hWulNypR0wc3LboL0YnLxZCQ/oXhPHzOr
	 MIp1n0DVHikJDrjpw41jvPst2xs2IF0O7djYlFJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Wachowski <karol.wachowski@intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.14 138/145] accel/ivpu: Move parts of MMU event IRQ handling to thread handler
Date: Tue, 20 May 2025 15:51:48 +0200
Message-ID: <20250520125815.947178908@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
References: <20250520125810.535475500@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Wachowski <karol.wachowski@intel.com>

commit 4480912f3f8b8a1fbb5ae12c5c547fd094ec4197 upstream.

To prevent looping infinitely in MMU event handler we stop
generating new events by removing 'R' (record) bit from context
descriptor, but to ensure this change has effect KMD has to perform
configuration invalidation followed by sync command.

Because of that move parts of the interrupt handler that can take longer
to a thread not to block in interrupt handler for too long.
This includes:
 * disabling event queue for the time KMD updates MMU event queue consumer
   to ensure proper synchronization between MMU and KMD

 * removal of 'R' (record) bit from context descriptor to ensure no more
   faults are recorded until that context is destroyed

Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250107173238.381120-8-maciej.falkowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_job.c |    7 ++-
 drivers/accel/ivpu/ivpu_mmu.c |   93 +++++++++++++++++++++++++++---------------
 drivers/accel/ivpu/ivpu_mmu.h |    2 
 3 files changed, 69 insertions(+), 33 deletions(-)

--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -17,6 +17,7 @@
 #include "ivpu_ipc.h"
 #include "ivpu_job.h"
 #include "ivpu_jsm_msg.h"
+#include "ivpu_mmu.h"
 #include "ivpu_pm.h"
 #include "ivpu_trace.h"
 #include "vpu_boot_api.h"
@@ -360,12 +361,16 @@ void ivpu_context_abort_locked(struct iv
 	struct ivpu_device *vdev = file_priv->vdev;
 
 	lockdep_assert_held(&file_priv->lock);
+	ivpu_dbg(vdev, JOB, "Context ID: %u abort\n", file_priv->ctx.id);
 
 	ivpu_cmdq_fini_all(file_priv);
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
 		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
 
+	ivpu_mmu_disable_ssid_events(vdev, file_priv->ctx.id);
+	ivpu_mmu_discard_events(vdev);
+
 	file_priv->aborted = true;
 }
 
@@ -849,8 +854,8 @@ void ivpu_context_abort_work_fn(struct w
 {
 	struct ivpu_device *vdev = container_of(work, struct ivpu_device, context_abort_work);
 	struct ivpu_file_priv *file_priv;
-	unsigned long ctx_id;
 	struct ivpu_job *job;
+	unsigned long ctx_id;
 	unsigned long id;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -20,6 +20,12 @@
 #define IVPU_MMU_REG_CR0		      0x00200020u
 #define IVPU_MMU_REG_CR0ACK		      0x00200024u
 #define IVPU_MMU_REG_CR0ACK_VAL_MASK	      GENMASK(31, 0)
+#define IVPU_MMU_REG_CR0_ATSCHK_MASK	      BIT(4)
+#define IVPU_MMU_REG_CR0_CMDQEN_MASK	      BIT(3)
+#define IVPU_MMU_REG_CR0_EVTQEN_MASK	      BIT(2)
+#define IVPU_MMU_REG_CR0_PRIQEN_MASK	      BIT(1)
+#define IVPU_MMU_REG_CR0_SMMUEN_MASK	      BIT(0)
+
 #define IVPU_MMU_REG_CR1		      0x00200028u
 #define IVPU_MMU_REG_CR2		      0x0020002cu
 #define IVPU_MMU_REG_IRQ_CTRL		      0x00200050u
@@ -141,12 +147,6 @@
 #define IVPU_MMU_IRQ_EVTQ_EN		BIT(2)
 #define IVPU_MMU_IRQ_GERROR_EN		BIT(0)
 
-#define IVPU_MMU_CR0_ATSCHK		BIT(4)
-#define IVPU_MMU_CR0_CMDQEN		BIT(3)
-#define IVPU_MMU_CR0_EVTQEN		BIT(2)
-#define IVPU_MMU_CR0_PRIQEN		BIT(1)
-#define IVPU_MMU_CR0_SMMUEN		BIT(0)
-
 #define IVPU_MMU_CR1_TABLE_SH		GENMASK(11, 10)
 #define IVPU_MMU_CR1_TABLE_OC		GENMASK(9, 8)
 #define IVPU_MMU_CR1_TABLE_IC		GENMASK(7, 6)
@@ -596,7 +596,7 @@ static int ivpu_mmu_reset(struct ivpu_de
 	REGV_WR32(IVPU_MMU_REG_CMDQ_PROD, 0);
 	REGV_WR32(IVPU_MMU_REG_CMDQ_CONS, 0);
 
-	val = IVPU_MMU_CR0_CMDQEN;
+	val = REG_SET_FLD(IVPU_MMU_REG_CR0, CMDQEN, 0);
 	ret = ivpu_mmu_reg_write_cr0(vdev, val);
 	if (ret)
 		return ret;
@@ -617,12 +617,12 @@ static int ivpu_mmu_reset(struct ivpu_de
 	REGV_WR32(IVPU_MMU_REG_EVTQ_PROD_SEC, 0);
 	REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, 0);
 
-	val |= IVPU_MMU_CR0_EVTQEN;
+	val = REG_SET_FLD(IVPU_MMU_REG_CR0, EVTQEN, val);
 	ret = ivpu_mmu_reg_write_cr0(vdev, val);
 	if (ret)
 		return ret;
 
-	val |= IVPU_MMU_CR0_ATSCHK;
+	val = REG_SET_FLD(IVPU_MMU_REG_CR0, ATSCHK, val);
 	ret = ivpu_mmu_reg_write_cr0(vdev, val);
 	if (ret)
 		return ret;
@@ -631,7 +631,7 @@ static int ivpu_mmu_reset(struct ivpu_de
 	if (ret)
 		return ret;
 
-	val |= IVPU_MMU_CR0_SMMUEN;
+	val = REG_SET_FLD(IVPU_MMU_REG_CR0, SMMUEN, val);
 	return ivpu_mmu_reg_write_cr0(vdev, val);
 }
 
@@ -870,7 +870,47 @@ static u32 *ivpu_mmu_get_event(struct iv
 	return evt;
 }
 
-static int ivpu_mmu_disable_events(struct ivpu_device *vdev, u32 ssid)
+static int ivpu_mmu_evtq_set(struct ivpu_device *vdev, bool enable)
+{
+	u32 val = REGV_RD32(IVPU_MMU_REG_CR0);
+
+	if (enable)
+		val = REG_SET_FLD(IVPU_MMU_REG_CR0, EVTQEN, val);
+	else
+		val = REG_CLR_FLD(IVPU_MMU_REG_CR0, EVTQEN, val);
+	REGV_WR32(IVPU_MMU_REG_CR0, val);
+
+	return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, IVPU_MMU_REG_TIMEOUT_US);
+}
+
+static int ivpu_mmu_evtq_enable(struct ivpu_device *vdev)
+{
+	return ivpu_mmu_evtq_set(vdev, true);
+}
+
+static int ivpu_mmu_evtq_disable(struct ivpu_device *vdev)
+{
+	return ivpu_mmu_evtq_set(vdev, false);
+}
+
+void ivpu_mmu_discard_events(struct ivpu_device *vdev)
+{
+	/*
+	 * Disable event queue (stop MMU from updating the producer)
+	 * to allow synchronization of consumer and producer indexes
+	 */
+	ivpu_mmu_evtq_disable(vdev);
+
+	vdev->mmu->evtq.cons = REGV_RD32(IVPU_MMU_REG_EVTQ_PROD_SEC);
+	REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
+	vdev->mmu->evtq.prod = REGV_RD32(IVPU_MMU_REG_EVTQ_PROD_SEC);
+
+	ivpu_mmu_evtq_enable(vdev);
+
+	drm_WARN_ON_ONCE(&vdev->drm, vdev->mmu->evtq.cons != vdev->mmu->evtq.prod);
+}
+
+int ivpu_mmu_disable_ssid_events(struct ivpu_device *vdev, u32 ssid)
 {
 	struct ivpu_mmu_info *mmu = vdev->mmu;
 	struct ivpu_mmu_cdtab *cdtab = &mmu->cdtab;
@@ -890,6 +930,7 @@ static int ivpu_mmu_disable_events(struc
 		clflush_cache_range(entry, IVPU_MMU_CDTAB_ENT_SIZE);
 
 	ivpu_mmu_cmdq_write_cfgi_all(vdev);
+	ivpu_mmu_cmdq_sync(vdev);
 
 	return 0;
 }
@@ -897,38 +938,26 @@ static int ivpu_mmu_disable_events(struc
 void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 {
 	struct ivpu_file_priv *file_priv;
-	u32 last_ssid = -1;
 	u32 *event;
 	u32 ssid;
 
 	ivpu_dbg(vdev, IRQ, "MMU event queue\n");
 
 	while ((event = ivpu_mmu_get_event(vdev))) {
-		ssid = FIELD_GET(IVPU_MMU_EVT_SSID_MASK, event[0]);
-
-		if (ssid == last_ssid)
-			continue;
+		ssid = FIELD_GET(IVPU_MMU_EVT_SSID_MASK, *event);
+		if (ssid == IVPU_GLOBAL_CONTEXT_MMU_SSID) {
+			ivpu_mmu_dump_event(vdev, event);
+			ivpu_pm_trigger_recovery(vdev, "MMU event");
+			return;
+		}
 
-		xa_lock(&vdev->context_xa);
 		file_priv = xa_load(&vdev->context_xa, ssid);
 		if (file_priv) {
-			if (file_priv->has_mmu_faults) {
-				event = NULL;
-			} else {
-				ivpu_mmu_disable_events(vdev, ssid);
-				file_priv->has_mmu_faults = true;
+			if (!READ_ONCE(file_priv->has_mmu_faults)) {
+				ivpu_mmu_dump_event(vdev, event);
+				WRITE_ONCE(file_priv->has_mmu_faults, true);
 			}
 		}
-		xa_unlock(&vdev->context_xa);
-
-		if (event)
-			ivpu_mmu_dump_event(vdev, event);
-
-		if (ssid == IVPU_GLOBAL_CONTEXT_MMU_SSID) {
-			ivpu_pm_trigger_recovery(vdev, "MMU event");
-			return;
-		}
-		REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
 	}
 
 	queue_work(system_wq, &vdev->context_abort_work);
--- a/drivers/accel/ivpu/ivpu_mmu.h
+++ b/drivers/accel/ivpu/ivpu_mmu.h
@@ -47,5 +47,7 @@ int ivpu_mmu_invalidate_tlb(struct ivpu_
 void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev);
 void ivpu_mmu_irq_gerr_handler(struct ivpu_device *vdev);
 void ivpu_mmu_evtq_dump(struct ivpu_device *vdev);
+void ivpu_mmu_discard_events(struct ivpu_device *vdev);
+int ivpu_mmu_disable_ssid_events(struct ivpu_device *vdev, u32 ssid);
 
 #endif /* __IVPU_MMU_H__ */



