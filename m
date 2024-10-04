Return-Path: <stable+bounces-80822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37008990B76
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E395E280E9F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538891DE3C4;
	Fri,  4 Oct 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVe6GwoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608D1DE3BE;
	Fri,  4 Oct 2024 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065988; cv=none; b=Tm93n4dvw06KFvs8+G9RVzA0gjXp4sc9XhJakvviO97lKPitJZHu0IyHO4ZuJ32T7msfUZ35ooLn7PsvKcymRyDbmyUbZ6hqZGYKK1yZ2HGVgzDORWuCrvkh5d/dXVAYYOx5VgYpCa9z1hfE+khtZ9aUHro9R1GOi72EqP8OcCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065988; c=relaxed/simple;
	bh=5Sirsl81FiH2D48MYd0spz+0sJvGdZ/Tfdt6W71no2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtM2NUEnjtGVLqGJB8aeEJkAKQBSOtTcoazgm198qngLy+Rh4yl8jka+lFLLLVI65Wey3wx6UbNylylzX5jFSVWXsV2MsZhhULnXIVC6Vm2S5h6UXw7621cftRNIhsv+zV6J+AHLvRdggKfjV1jlgDcXkQVvz7DV0HMYT+RD7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVe6GwoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D56C4CEC6;
	Fri,  4 Oct 2024 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065987;
	bh=5Sirsl81FiH2D48MYd0spz+0sJvGdZ/Tfdt6W71no2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVe6GwoY4KqMxvXwAJDVs8z54RtUPTd0akm5YqTthUU1lgnQ1beTRfL/1Pzzp8QCe
	 pLgtYdZLZG4hnup41JZnCKzqRXszl1v63XmHLFeCuHwpwnF7KPV3Cr78PBlp+qL2aH
	 VaCayZt4v9pMBUmiYT7SjzZ6jTCsks4R4as9fY/R5T8ZzpMgOoLwk9pCkuClzbTxp6
	 ku1+S0BX4OaSDji73ypMLQA8YoU16LZHlcUvoNfR/TWC1H4naS9dzNbmUqX2za4pJX
	 cfqiqLqARKIrfPbl03Xuidv2ESikd1UtO+x1OMFf95rlpF3buxIXlzT30q0wX4Kem1
	 rA2J8HAmXyOnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.11 42/76] soundwire: cadence: re-check Peripheral status with delayed_work
Date: Fri,  4 Oct 2024 14:16:59 -0400
Message-ID: <20241004181828.3669209-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit f8c35d61ba01afa76846905c67862cdace7f66b0 ]

The SoundWire peripheral enumeration is entirely based on interrupts,
more specifically sticky bits tracking state changes.

This patch adds a defensive programming check on the actual status
reported in PING frames. If for some reason an interrupt was lost or
delayed, the delayed work would detect a peripheral change of status
after the bus starts.

The 100ms defined for the delay is not completely arbitrary, if a
Peripheral didn't join the bus within that delay then probably the
hardware link is broken, and conversely if the detection didn't happen
because of software issues the 100ms is still acceptable in terms of
user experience.

The overhead of the one-shot workqueue is minimal, and the mutual
exclusion ensures that the interrupt and delayed work cannot update
the status concurrently.

Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20240805114921.88007-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c   | 39 ++++++++++++++++++++++++++--
 drivers/soundwire/cadence_master.h   |  5 ++++
 drivers/soundwire/intel.h            |  2 ++
 drivers/soundwire/intel_auxdevice.c  |  1 +
 drivers/soundwire/intel_bus_common.c | 11 ++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e0683a5975d10..05652e983539b 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -890,8 +890,14 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		}
 	}
 
-	if (is_slave)
-		return sdw_handle_slave_status(&cdns->bus, status);
+	if (is_slave) {
+		int ret;
+
+		mutex_lock(&cdns->status_update_lock);
+		ret = sdw_handle_slave_status(&cdns->bus, status);
+		mutex_unlock(&cdns->status_update_lock);
+		return ret;
+	}
 
 	return 0;
 }
@@ -988,6 +994,31 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 }
 EXPORT_SYMBOL(sdw_cdns_irq);
 
+static void cdns_check_attached_status_dwork(struct work_struct *work)
+{
+	struct sdw_cdns *cdns =
+		container_of(work, struct sdw_cdns, attach_dwork.work);
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
+	u32 val;
+	int ret;
+	int i;
+
+	val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+
+	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
+		status[i] = val & 0x3;
+		if (status[i])
+			dev_dbg(cdns->dev, "Peripheral %d status: %d\n", i, status[i]);
+		val >>= 2;
+	}
+
+	mutex_lock(&cdns->status_update_lock);
+	ret = sdw_handle_slave_status(&cdns->bus, status);
+	mutex_unlock(&cdns->status_update_lock);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: sdw_handle_slave_status failed: %d\n", __func__, ret);
+}
+
 /**
  * cdns_update_slave_status_work - update slave status in a work since we will need to handle
  * other interrupts eg. CDNS_MCP_INT_RX_WL during the update slave
@@ -1740,7 +1771,11 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 	init_completion(&cdns->tx_complete);
 	cdns->bus.port_ops = &cdns_port_ops;
 
+	mutex_init(&cdns->status_update_lock);
+
 	INIT_WORK(&cdns->work, cdns_update_slave_status_work);
+	INIT_DELAYED_WORK(&cdns->attach_dwork, cdns_check_attached_status_dwork);
+
 	return 0;
 }
 EXPORT_SYMBOL(sdw_cdns_probe);
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index bc84435e420f5..e1d7969ba48ae 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -117,6 +117,8 @@ struct sdw_cdns_dai_runtime {
  * @link_up: Link status
  * @msg_count: Messages sent on bus
  * @dai_runtime_array: runtime context for each allocated DAI.
+ * @status_update_lock: protect concurrency between interrupt-based and delayed work
+ * status update
  */
 struct sdw_cdns {
 	struct device *dev;
@@ -148,10 +150,13 @@ struct sdw_cdns {
 	bool interrupt_enabled;
 
 	struct work_struct work;
+	struct delayed_work attach_dwork;
 
 	struct list_head list;
 
 	struct sdw_cdns_dai_runtime **dai_runtime_array;
+
+	struct mutex status_update_lock; /* add mutual exclusion to sdw_handle_slave_status() */
 };
 
 #define bus_to_cdns(_bus) container_of(_bus, struct sdw_cdns, bus)
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 68838e843b543..f4235f5991c37 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -103,6 +103,8 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
 
 #define INTEL_MASTER_RESET_ITERATIONS	10
 
+#define SDW_INTEL_DELAYED_ENUMERATION_MS	100
+
 #define SDW_INTEL_CHECK_OPS(sdw, cb)	((sdw) && (sdw)->link_res && (sdw)->link_res->hw_ops && \
 					 (sdw)->link_res->hw_ops->cb)
 #define SDW_INTEL_OPS(sdw, cb)		((sdw)->link_res->hw_ops->cb)
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 8807e01cbf7c7..dff49c5ce5b30 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -475,6 +475,7 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	 */
 	if (!bus->prop.hw_disabled) {
 		sdw_intel_debugfs_exit(sdw);
+		cancel_delayed_work_sync(&cdns->attach_dwork);
 		sdw_cdns_enable_interrupt(cdns, false);
 	}
 	sdw_bus_master_delete(bus);
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index a75e5d7d87154..d3ff6c65b64c3 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -60,6 +60,9 @@ int intel_start_bus(struct sdw_intel *sdw)
 	sdw_cdns_check_self_clearing_bits(cdns, __func__,
 					  true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -151,6 +154,9 @@ int intel_start_bus_after_reset(struct sdw_intel *sdw)
 	}
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -184,6 +190,9 @@ int intel_start_bus_after_clock_stop(struct sdw_intel *sdw)
 
 	sdw_cdns_check_self_clearing_bits(cdns, __func__, true, INTEL_MASTER_RESET_ITERATIONS);
 
+	schedule_delayed_work(&cdns->attach_dwork,
+			      msecs_to_jiffies(SDW_INTEL_DELAYED_ENUMERATION_MS));
+
 	return 0;
 }
 
@@ -194,6 +203,8 @@ int intel_stop_bus(struct sdw_intel *sdw, bool clock_stop)
 	bool wake_enable = false;
 	int ret;
 
+	cancel_delayed_work_sync(&cdns->attach_dwork);
+
 	if (clock_stop) {
 		ret = sdw_cdns_clock_stop(cdns, true);
 		if (ret < 0)
-- 
2.43.0


