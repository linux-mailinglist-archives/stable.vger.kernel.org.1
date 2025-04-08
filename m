Return-Path: <stable+bounces-131488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E6A80A39
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AC01BC0FF2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9709627CB31;
	Tue,  8 Apr 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdS47H9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEF26F474;
	Tue,  8 Apr 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116535; cv=none; b=UA93UAuuSBsZrSQkoB4SrWBHJEqYFNoHunpxLTbUQFKssPCq/UXPMGh79HmW0tgAtdOlAWVUGdoYMNRrXWFSpqMc3rbtZkwSIoikPfSlPPGljtLM7dN5lfoANktTsc6T6eQutt7FBz+vigpcdOWloKB8oMpnl4EFVsJ4HNbhFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116535; c=relaxed/simple;
	bh=T/JucrmunmwvfB+Hw3Ox98fFVD2VPs/vhOfUqAkmR9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbDJj/sS1WEsyFDXrNri4TOvYEHeB8nwsfhQjLXz2QqrRYh9EtpscyeQe0H7YmshLcdQ2VR05GOASrFPJljs+IyYu4UlxAsuNVOG88oP7JnduZ2xBZGZthe+hTu8E/fqRlp3Hr5uKFZ+xBcivrCnnqvLjmE+F66xrxcXb3RK3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdS47H9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBB9C4CEE7;
	Tue,  8 Apr 2025 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116535;
	bh=T/JucrmunmwvfB+Hw3Ox98fFVD2VPs/vhOfUqAkmR9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdS47H9pJh5KxPHnjAuhf78wvuVLYMAcPLIe5ELZPJ8kCNQNoxzR+iyfFya0DyAJD
	 Eij2bJdGbc20s2+EqRneG06qzwjW+80Wc+KvRUwJOG8cpGCdyyGm88M7CQScMuoUi5
	 d4i+B2kUuvuXQfKVwlzOpedjNl6a+UHT4/9y3uao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuanfang Zhang <quic_yuanfang@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 173/423] coresight-etm4x: add isb() before reading the TRCSTATR
Date: Tue,  8 Apr 2025 12:48:19 +0200
Message-ID: <20250408104849.772926835@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuanfang Zhang <quic_yuanfang@quicinc.com>

[ Upstream commit 4ff6039ffb79a4a8a44b63810a8a2f2b43264856 ]

As recommended by section 4.3.7 ("Synchronization when using system
instructions to progrom the trace unit") of ARM IHI 0064H.b, the
self-hosted trace analyzer must perform a Context synchronization
event between writing to the TRCPRGCTLR and reading the TRCSTATR.
Additionally, add an ISB between the each read of TRCSTATR on
coresight_timeout() when using system instructions to program the
trace unit.

Fixes: 1ab3bb9df5e3 ("coresight: etm4x: Add necessary synchronization for sysreg access")
Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20250116-etm_sync-v4-1-39f2b05e9514@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c  | 20 ++++++--
 .../coresight/coresight-etm4x-core.c          | 48 +++++++++++++++++--
 include/linux/coresight.h                     |  4 ++
 3 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index ea38ecf26fcbf..c42aa9fddab9b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1017,18 +1017,20 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific register
- *			state.
+ * coresight_timeout_action - loop until a bit has changed to a specific register
+ *                  state, with a callback after every trial.
  * @csa: coresight device access for the device
  * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
+ * @cb: Call back after each trial.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-int coresight_timeout(struct csdev_access *csa, u32 offset,
-		      int position, int value)
+int coresight_timeout_action(struct csdev_access *csa, u32 offset,
+		      int position, int value,
+			  coresight_timeout_cb_t cb)
 {
 	int i;
 	u32 val;
@@ -1044,7 +1046,8 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 			if (!(val & BIT(position)))
 				return 0;
 		}
-
+		if (cb)
+			cb(csa, offset, position, value);
 		/*
 		 * Delay is arbitrary - the specification doesn't say how long
 		 * we are expected to wait.  Extra check required to make sure
@@ -1056,6 +1059,13 @@ int coresight_timeout(struct csdev_access *csa, u32 offset,
 
 	return -EAGAIN;
 }
+EXPORT_SYMBOL_GPL(coresight_timeout_action);
+
+int coresight_timeout(struct csdev_access *csa, u32 offset,
+		      int position, int value)
+{
+	return coresight_timeout_action(csa, offset, position, value, NULL);
+}
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
 u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0c..be8b46f26ddc8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -399,6 +399,29 @@ static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
 }
 #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
 
+static void etm4x_sys_ins_barrier(struct csdev_access *csa, u32 offset, int pos, int val)
+{
+	if (!csa->io_mem)
+		isb();
+}
+
+/*
+ * etm4x_wait_status: Poll for TRCSTATR.<pos> == <val>. While using system
+ * instruction to access the trace unit, each access must be separated by a
+ * synchronization barrier. See ARM IHI0064H.b section "4.3.7 Synchronization of
+ * register updates", for system instructions section, in "Notes":
+ *
+ *   "In particular, whenever disabling or enabling the trace unit, a poll of
+ *    TRCSTATR needs explicit synchronization between each read of TRCSTATR"
+ */
+static int etm4x_wait_status(struct csdev_access *csa, int pos, int val)
+{
+	if (!csa->io_mem)
+		return coresight_timeout_action(csa, TRCSTATR, pos, val,
+						etm4x_sys_ins_barrier);
+	return coresight_timeout(csa, TRCSTATR, pos, val);
+}
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
@@ -430,7 +453,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		isb();
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
+	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 	if (drvdata->nr_pe)
@@ -523,7 +546,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		isb();
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
+	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -906,10 +929,25 @@ static void etm4_disable_hw(void *info)
 	tsb_csync();
 	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
 
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using system
+	 * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
+	 * self-hosted trace analyzer must perform a Context synchronization
+	 * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
+	/*
+	 * As recommended by section 4.3.7 (Synchronization of register updates)
+	 * of ARM IHI 0064H.b.
+	 */
+	isb();
+
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
@@ -1711,7 +1749,7 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4_os_lock(drvdata);
 
 	/* wait for TRCSTATR.PMSTABLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1)) {
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for PM Stable Status\n");
 		etm4_os_unlock(drvdata);
@@ -1802,7 +1840,7 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcpdcr = etm4x_read32(csa, TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
+	if (etm4x_wait_status(csa, TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c133425942785..f106b10251118 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -639,6 +639,10 @@ extern int coresight_enable_sysfs(struct coresight_device *csdev);
 extern void coresight_disable_sysfs(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
+typedef void (*coresight_timeout_cb_t) (struct csdev_access *, u32, int, int);
+extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
+					int position, int value,
+					coresight_timeout_cb_t cb);
 
 extern int coresight_claim_device(struct coresight_device *csdev);
 extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
-- 
2.39.5




