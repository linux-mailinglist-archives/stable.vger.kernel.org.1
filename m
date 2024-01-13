Return-Path: <stable+bounces-10680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B081582CB2E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CD92825CB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419315C9;
	Sat, 13 Jan 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pd5I+sPc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D213185A;
	Sat, 13 Jan 2024 09:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B33C433F1;
	Sat, 13 Jan 2024 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139789;
	bh=CN1ib1r4Aq37cV0advF/cYy9nelKLm/J9Xws+527dSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pd5I+sPcoDyKKIjFTFnIiBKGUUFPXXFFV+Yx750Xl2i12B0BLpUZw+KtJpebr9ymh
	 Hnl0vh1VQHNRWy9A7JtjeNtUS9P4lGn4zgTpOkkIZagCIRXSFgcUUDt6wvAgXTfrkm
	 K8DCxTDMg27vHAUvUgmOfe3AIIrcyjRwqMosU6HE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Rakesh Pillai <pillair@codeaurora.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 5.4 30/38] ath10k: Keep track of which interrupts fired, dont poll them
Date: Sat, 13 Jan 2024 10:50:06 +0100
Message-ID: <20240113094207.378801613@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.455533180@linuxfoundation.org>
References: <20240113094206.455533180@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit d66d24ac300cf41c6b88367fc9b4b6348679273d ]

If we have a per CE (Copy Engine) IRQ then we have no summary
register.  Right now the code generates a summary register by
iterating over all copy engines and seeing if they have an interrupt
pending.

This has a problem.  Specifically if _none_ if the Copy Engines have
an interrupt pending then they might go into low power mode and
reading from their address space will cause a full system crash.  This
was seen to happen when two interrupts went off at nearly the same
time.  Both were handled by a single call of ath10k_snoc_napi_poll()
but, because there were two interrupts handled and thus two calls to
napi_schedule() there was still a second call to
ath10k_snoc_napi_poll() which ran with no interrupts pending.

Instead of iterating over all the copy engines, let's just keep track
of the IRQs that fire.  Then we can effectively generate our own
summary without ever needing to read the Copy Engines.

Tested-on: WCN3990 SNOC WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rakesh Pillai <pillair@codeaurora.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid
Stable-dep-of: 170c75d43a77 ("ath10k: Don't touch the CE interrupt registers after power up")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/ce.c   |   84 ++++++++++++---------------------
 drivers/net/wireless/ath/ath10k/ce.h   |   14 ++---
 drivers/net/wireless/ath/ath10k/snoc.c |   19 +++++--
 drivers/net/wireless/ath/ath10k/snoc.h |    1 
 4 files changed, 52 insertions(+), 66 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -481,38 +481,6 @@ static inline void ath10k_ce_engine_int_
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
 
-static bool ath10k_ce_engine_int_status_check(struct ath10k *ar, u32 ce_ctrl_addr,
-					      unsigned int mask)
-{
-	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
-
-	return ath10k_ce_read32(ar, ce_ctrl_addr + wm_regs->addr) & mask;
-}
-
-u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar)
-{
-	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
-	struct ath10k_ce_pipe *ce_state;
-	struct ath10k_ce *ce;
-	u32 irq_summary = 0;
-	u32 ctrl_addr;
-	u32 ce_id;
-
-	ce = ath10k_ce_priv(ar);
-
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
-		ce_state = &ce->ce_states[ce_id];
-		ctrl_addr = ce_state->ctrl_addr;
-		if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
-						      wm_regs->cc_mask)) {
-			irq_summary |= BIT(ce_id);
-		}
-	}
-
-	return irq_summary;
-}
-EXPORT_SYMBOL(ath10k_ce_gen_interrupt_summary);
-
 /*
  * Guts of ath10k_ce_send.
  * The caller takes responsibility for any needed locking.
@@ -1399,45 +1367,55 @@ static void ath10k_ce_per_engine_handler
 	ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
 }
 
-int ath10k_ce_disable_interrupts(struct ath10k *ar)
+void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 	struct ath10k_ce_pipe *ce_state;
 	u32 ctrl_addr;
-	int ce_id;
 
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
-		ce_state  = &ce->ce_states[ce_id];
-		if (ce_state->attr_flags & CE_ATTR_POLL)
-			continue;
+	ce_state  = &ce->ce_states[ce_id];
+	if (ce_state->attr_flags & CE_ATTR_POLL)
+		return;
 
-		ctrl_addr = ath10k_ce_base_address(ar, ce_id);
+	ctrl_addr = ath10k_ce_base_address(ar, ce_id);
 
-		ath10k_ce_copy_complete_intr_disable(ar, ctrl_addr);
-		ath10k_ce_error_intr_disable(ar, ctrl_addr);
-		ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
-	}
+	ath10k_ce_copy_complete_intr_disable(ar, ctrl_addr);
+	ath10k_ce_error_intr_disable(ar, ctrl_addr);
+	ath10k_ce_watermark_intr_disable(ar, ctrl_addr);
+}
+EXPORT_SYMBOL(ath10k_ce_disable_interrupt);
 
-	return 0;
+void ath10k_ce_disable_interrupts(struct ath10k *ar)
+{
+	int ce_id;
+
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		ath10k_ce_disable_interrupt(ar, ce_id);
 }
 EXPORT_SYMBOL(ath10k_ce_disable_interrupts);
 
-void ath10k_ce_enable_interrupts(struct ath10k *ar)
+void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id)
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
-	int ce_id;
 	struct ath10k_ce_pipe *ce_state;
 
+	ce_state  = &ce->ce_states[ce_id];
+	if (ce_state->attr_flags & CE_ATTR_POLL)
+		return;
+
+	ath10k_ce_per_engine_handler_adjust(ce_state);
+}
+EXPORT_SYMBOL(ath10k_ce_enable_interrupt);
+
+void ath10k_ce_enable_interrupts(struct ath10k *ar)
+{
+	int ce_id;
+
 	/* Enable interrupts for copy engine that
 	 * are not using polling mode.
 	 */
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
-		ce_state  = &ce->ce_states[ce_id];
-		if (ce_state->attr_flags & CE_ATTR_POLL)
-			continue;
-
-		ath10k_ce_per_engine_handler_adjust(ce_state);
-	}
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		ath10k_ce_enable_interrupt(ar, ce_id);
 }
 EXPORT_SYMBOL(ath10k_ce_enable_interrupts);
 
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -255,12 +255,13 @@ int ath10k_ce_cancel_send_next(struct at
 /*==================CE Interrupt Handlers====================*/
 void ath10k_ce_per_engine_service_any(struct ath10k *ar);
 void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id);
-int ath10k_ce_disable_interrupts(struct ath10k *ar);
+void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
+void ath10k_ce_disable_interrupts(struct ath10k *ar);
+void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
 void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
 
-u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar);
 void ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
@@ -376,12 +377,9 @@ static inline u32 ath10k_ce_interrupt_su
 {
 	struct ath10k_ce *ce = ath10k_ce_priv(ar);
 
-	if (!ar->hw_params.per_ce_irq)
-		return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
-			ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
-			CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
-	else
-		return ath10k_ce_gen_interrupt_summary(ar);
+	return CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_GET(
+		ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
+		CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
 }
 
 /* Host software's Copy Engine configuration. */
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2018 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -927,6 +928,7 @@ static int ath10k_snoc_hif_start(struct
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
+	bitmap_clear(ar_snoc->pending_ce_irqs, 0, CE_COUNT_MAX);
 	napi_enable(&ar->napi);
 	ath10k_snoc_irq_enable(ar);
 	ath10k_snoc_rx_post(ar);
@@ -1166,7 +1168,9 @@ static irqreturn_t ath10k_snoc_per_engin
 		return IRQ_HANDLED;
 	}
 
-	ath10k_snoc_irq_disable(ar);
+	ath10k_ce_disable_interrupt(ar, ce_id);
+	set_bit(ce_id, ar_snoc->pending_ce_irqs);
+
 	napi_schedule(&ar->napi);
 
 	return IRQ_HANDLED;
@@ -1175,20 +1179,25 @@ static irqreturn_t ath10k_snoc_per_engin
 static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 {
 	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	int done = 0;
+	int ce_id;
 
 	if (test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags)) {
 		napi_complete(ctx);
 		return done;
 	}
 
-	ath10k_ce_per_engine_service_any(ar);
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
+		if (test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs)) {
+			ath10k_ce_per_engine_service(ar, ce_id);
+			ath10k_ce_enable_interrupt(ar, ce_id);
+		}
+
 	done = ath10k_htt_txrx_compl_task(ar, budget);
 
-	if (done < budget) {
+	if (done < budget)
 		napi_complete(ctx);
-		ath10k_snoc_irq_enable(ar);
-	}
 
 	return done;
 }
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -81,6 +81,7 @@ struct ath10k_snoc {
 	struct ath10k_clk_info *clk;
 	struct ath10k_qmi *qmi;
 	unsigned long flags;
+	DECLARE_BITMAP(pending_ce_irqs, CE_COUNT_MAX);
 };
 
 static inline struct ath10k_snoc *ath10k_snoc_priv(struct ath10k *ar)



