Return-Path: <stable+bounces-10047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F0D82722A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA101F235ED
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3094B5AB;
	Mon,  8 Jan 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQyd6AaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06F4A9A4;
	Mon,  8 Jan 2024 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6090C433C7;
	Mon,  8 Jan 2024 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726594;
	bh=hF3XMqu2a289Iz/o6eP5tXoMvumPFleZ3DBW23KSgBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQyd6AaKua46wIa6IPUdDUNlN8Qkj0vbq0a3paPemYBOhStdJApxyP2O0SprBf95O
	 /7ZqDVRZ2TjA2fE38h2EeP/UODFz4+BXKWasiIiMR5QgCFuTdChr2pbpJLQxVdTkFD
	 jIKmgbetrU+hpGiV7uD12FVzqasgGI9+V1Bcq1VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/124] wifi: iwlwifi: pcie: dont synchronize IRQs from IRQ
Date: Mon,  8 Jan 2024 16:07:23 +0100
Message-ID: <20240108150603.764747579@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 400f6ebbc175286576c7f7fddf3c347d09d12310 ]

On older devices (before unified image!) we can end up calling
stop_device from an rfkill interrupt. However, in stop_device
we attempt to synchronize IRQs, which then of course deadlocks.

Avoid this by checking the context, if running from the IRQ
thread then don't synchronize. This wouldn't be correct on a
new device since RSS is supported, but older devices only have
a single interrupt/queue.

Fixes: 37fb29bd1f90 ("wifi: iwlwifi: pcie: synchronize IRQs before NAPI")
Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20231215111335.59aab00baed7.Iadfe154d6248e7f9dfd69522e5429dbbd72925d7@changeid
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/pcie/internal.h  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c    |  8 ++++----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 17 +++++++++--------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 0f6493dab8cbd..5602441df2b7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -749,7 +749,7 @@ static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
 	}
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans);
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq);
 
 static inline bool iwl_is_rfkill_set(struct iwl_trans *trans)
 {
@@ -796,7 +796,7 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq);
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 4614acee9f7ba..a9415d333490c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1785,7 +1785,7 @@ static u32 iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 	return inta;
 }
 
-void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
+void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
@@ -1809,7 +1809,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 	isr_stats->rfkill++;
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, from_irq);
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (hw_rfkill) {
@@ -1949,7 +1949,7 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta & CSR_INT_BIT_RF_KILL) {
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 		handled |= CSR_INT_BIT_RF_KILL;
 	}
 
@@ -2366,7 +2366,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	/* HW RF KILL switch toggled */
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RF_KILL)
-		iwl_pcie_handle_rfkill_irq(trans);
+		iwl_pcie_handle_rfkill_irq(trans, true);
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_HW_ERR) {
 		IWL_ERR(trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 2e23ccd7d7938..1bc4a0089c6ff 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1082,7 +1082,7 @@ bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
 	report = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
 
 	if (prev != report)
-		iwl_trans_pcie_rf_kill(trans, report);
+		iwl_trans_pcie_rf_kill(trans, report, false);
 
 	return hw_rfkill;
 }
@@ -1236,7 +1236,7 @@ static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
 	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
 }
 
-static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1263,7 +1263,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
-		iwl_pcie_synchronize_irqs(trans);
+		if (!from_irq)
+			iwl_pcie_synchronize_irqs(trans);
 		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
@@ -1453,7 +1454,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
 	}
 	if (hw_rfkill != was_in_rfkill)
-		iwl_trans_pcie_rf_kill(trans, hw_rfkill);
+		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
 }
 
 static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
@@ -1468,12 +1469,12 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_stop_device(trans);
+	_iwl_trans_pcie_stop_device(trans, false);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
 
-void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 {
 	struct iwl_trans_pcie __maybe_unused *trans_pcie =
 		IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1486,7 +1487,7 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 		if (trans->trans_cfg->gen2)
 			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
-			_iwl_trans_pcie_stop_device(trans);
+			_iwl_trans_pcie_stop_device(trans, from_irq);
 	}
 }
 
@@ -2869,7 +2870,7 @@ static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
 	IWL_WARN(trans, "changing debug rfkill %d->%d\n",
 		 trans_pcie->debug_rfkill, new_value);
 	trans_pcie->debug_rfkill = new_value;
-	iwl_pcie_handle_rfkill_irq(trans);
+	iwl_pcie_handle_rfkill_irq(trans, false);
 
 	return count;
 }
-- 
2.43.0




