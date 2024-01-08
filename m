Return-Path: <stable+bounces-10188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8108282739D
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1821C2126C
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6205102D;
	Mon,  8 Jan 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSZ6sPls"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAC51008
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28d2be70358so674120a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704728268; x=1705333068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTq2zLXeu/6mNzKdUTt/Co4Ivf1tEzWrnhVGy1yLK+g=;
        b=eSZ6sPlsbJWCNRSwwO8WYz0mmpOEVvNdiWlhNcvhB+2ny2RZ6tBTiEM9JTwhKuocvX
         Wj8EMCrXCZhRBTUZYF9AystPnxHN4urjL+JQrpQEx4eOUrElY9SQSEL6+J30ANLJR/63
         jPp2MzrWdlBg77RVfYDtPtmpeSRbEDdP77fa6pNs3zuKFUc1yU85iQ6/4g0YYPxIDAe5
         uSMYekrnis/uByleFSIJq9kaFlYSIMqC9B3iSE6NmFA8g8a+RpQPRYZ8yR/BMF9hYQrn
         fjnYnZ0dk50urF3z6ecVBAbcYdKC8/trZLIWvwnu+od0AcfY8ndn5jwd1LFf38FGYuIr
         KsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728268; x=1705333068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTq2zLXeu/6mNzKdUTt/Co4Ivf1tEzWrnhVGy1yLK+g=;
        b=UokgtUvANSaNczwSdlS83/ku8LzqKedb0wqTZpCcKDIlmU6CfAhvapzKIpWADC2SNl
         WdaEfDqugc3Dn+AzCL526JJJTVu4Yvbfd400FodWcvKuezblzzyqtPeGSEXPw5SAQGNv
         hBKntjZ+iZnuxKJEX2oloF9hQ90q82VHwIopi7uFsSmNO2gmV9UeojphIMz5N5ZGq/Pk
         4r43p8nKSnuzpU/F30Xa5jsWvTfQx50kuOACUSXrnfJmOE9/63lbJpAijTl2h0bE81NE
         CCAwKla4j6eQPc1bEfSbkF9wELW5jL5LSPyNQ9GIAEZP+HHjPd25TU2bVutdm9wD/h7v
         /MIw==
X-Gm-Message-State: AOJu0YyQZOGtgXiyfOszlK5X3xXhOc40cgTpFIddAT5anhjV6JL/heTx
	EHJB/CczYC4eXDsxO9lcwH62GZYynWOH6Q==
X-Google-Smtp-Source: AGHT+IH7z+Ky7jPJYoWeHgxWl4J4uxFVZ8zWqiWLRQYltduE8Qa9R6g+CYSXGi5EllaMskGgS6I9Zw==
X-Received: by 2002:a17:90b:23cb:b0:28c:8ea3:26a0 with SMTP id md11-20020a17090b23cb00b0028c8ea326a0mr1191077pjb.23.1704728268263;
        Mon, 08 Jan 2024 07:37:48 -0800 (PST)
Received: from x-wing.lan ([106.51.164.237])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a318500b00286f2b39a95sm122218pjb.31.2024.01.08.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:37:47 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rakesh Pillai <pillair@codeaurora.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>,
	Stable <stable@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH for-5.4.y 2/4] ath10k: Add interrupt summary based CE processing
Date: Mon,  8 Jan 2024 21:07:35 +0530
Message-Id: <20240108153737.3538218-3-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108153737.3538218-1-amit.pundir@linaro.org>
References: <20240108153737.3538218-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rakesh Pillai <pillair@codeaurora.org>

[ Upstream commit b92aba35d39d10d8a6bdf2495172fd490c598b4a ]

Currently the NAPI processing loops through all
the copy engines and processes a particular copy
engine is the copy completion is set for that copy
engine. The host driver is not supposed to access
any copy engine register after clearing the interrupt
status register.

This might result in kernel crash like the one below
[ 1159.220143] Call trace:
[ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
[ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
[ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
[ 1159.220270]  net_rx_action+0x100/0x3b0
[ 1159.220312]  __do_softirq+0x164/0x30c
[ 1159.220345]  run_ksoftirqd+0x2c/0x64
[ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
[ 1159.220405]  kthread+0x11c/0x12c
[ 1159.220423]  ret_from_fork+0x10/0x18

To avoid such a scenario, we generate an interrupt
summary by reading the copy completion for all the
copy engine before actually processing any of them.
This will avoid reading the interrupt status register
for any CE after the interrupt status is cleared.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/1593193967-29897-1-git-send-email-pillair@codeaurora.org
Stable-dep-of: 170c75d43a77 ("ath10k: Don't touch the CE interrupt registers after power up")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/net/wireless/ath/ath10k/ce.c | 63 +++++++++++++++++-----------
 drivers/net/wireless/ath/ath10k/ce.h |  5 ++-
 2 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 4b4eca407671..3b1dd822e078 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -481,15 +481,38 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
 
-static inline bool ath10k_ce_engine_int_status_check(struct ath10k *ar,
-						     u32 ce_ctrl_addr,
-						     unsigned int mask)
+static bool ath10k_ce_engine_int_status_check(struct ath10k *ar, u32 ce_ctrl_addr,
+					      unsigned int mask)
 {
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 
 	return ath10k_ce_read32(ar, ce_ctrl_addr + wm_regs->addr) & mask;
 }
 
+u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar)
+{
+	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+	struct ath10k_ce_pipe *ce_state;
+	struct ath10k_ce *ce;
+	u32 irq_summary = 0;
+	u32 ctrl_addr;
+	u32 ce_id;
+
+	ce = ath10k_ce_priv(ar);
+
+	for (ce_id = 0; ce_id < CE_COUNT; ce_id++) {
+		ce_state = &ce->ce_states[ce_id];
+		ctrl_addr = ce_state->ctrl_addr;
+		if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
+						      wm_regs->cc_mask)) {
+			irq_summary |= BIT(ce_id);
+		}
+	}
+
+	return irq_summary;
+}
+EXPORT_SYMBOL(ath10k_ce_gen_interrupt_summary);
+
 /*
  * Guts of ath10k_ce_send.
  * The caller takes responsibility for any needed locking.
@@ -1308,32 +1331,24 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
 	u32 ctrl_addr = ce_state->ctrl_addr;
 
-	spin_lock_bh(&ce->ce_lock);
-
-	if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
-					      wm_regs->cc_mask)) {
-		/* Clear before handling */
-		ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
-						  wm_regs->cc_mask);
-
-		spin_unlock_bh(&ce->ce_lock);
-
-		if (ce_state->recv_cb)
-			ce_state->recv_cb(ce_state);
-
-		if (ce_state->send_cb)
-			ce_state->send_cb(ce_state);
-
-		spin_lock_bh(&ce->ce_lock);
-	}
-
 	/*
+	 * Clear before handling
+	 *
 	 * Misc CE interrupts are not being handled, but still need
 	 * to be cleared.
+	 *
+	 * NOTE: When the last copy engine interrupt is cleared the
+	 * hardware will go to sleep.  Once this happens any access to
+	 * the CE registers can cause a hardware fault.
 	 */
-	ath10k_ce_engine_int_status_clear(ar, ctrl_addr, wm_regs->wm_mask);
+	ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
+					  wm_regs->cc_mask | wm_regs->wm_mask);
 
-	spin_unlock_bh(&ce->ce_lock);
+	if (ce_state->recv_cb)
+		ce_state->recv_cb(ce_state);
+
+	if (ce_state->send_cb)
+		ce_state->send_cb(ce_state);
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);
 
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index a7478c240f78..f7afcd90daa3 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -259,6 +259,8 @@ int ath10k_ce_disable_interrupts(struct ath10k *ar);
 void ath10k_ce_enable_interrupts(struct ath10k *ar);
 void ath10k_ce_dump_registers(struct ath10k *ar,
 			      struct ath10k_fw_crash_data *crash_data);
+
+u32 ath10k_ce_gen_interrupt_summary(struct ath10k *ar);
 void ath10k_ce_alloc_rri(struct ath10k *ar);
 void ath10k_ce_free_rri(struct ath10k *ar);
 
@@ -369,7 +371,6 @@ static inline u32 ath10k_ce_base_address(struct ath10k *ar, unsigned int ce_id)
 	(((x) & CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_MASK) >> \
 		CE_WRAPPER_INTERRUPT_SUMMARY_HOST_MSI_LSB)
 #define CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS			0x0000
-#define CE_INTERRUPT_SUMMARY		(GENMASK(CE_COUNT_MAX - 1, 0))
 
 static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 {
@@ -380,7 +381,7 @@ static inline u32 ath10k_ce_interrupt_summary(struct ath10k *ar)
 			ce->bus_ops->read32((ar), CE_WRAPPER_BASE_ADDRESS +
 			CE_WRAPPER_INTERRUPT_SUMMARY_ADDRESS));
 	else
-		return CE_INTERRUPT_SUMMARY;
+		return ath10k_ce_gen_interrupt_summary(ar);
 }
 
 /* Host software's Copy Engine configuration. */
-- 
2.25.1


