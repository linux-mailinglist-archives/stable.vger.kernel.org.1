Return-Path: <stable+bounces-10185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320C82739B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A061F22581
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A05101D;
	Mon,  8 Jan 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2Ky1Rws"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ECA4121D
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28cc07d8876so962304a91.1
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 07:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704728264; x=1705333064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nLbyx15OK/Ut65BLZiDxnkDEQWNCZ3L30jSUhtPoLs=;
        b=L2Ky1RwsnfloKOG5hIFKYOcvWDVktYVn8t+bGE7lqUY+r+n5ZoDWwJIz/nunfSyKTR
         sqAwSmgGENPMUnTjJqcdu1ydOu6Xjqii/7QyqRN5oqcCXI3EQ/bOGkR7O1kr8trHAiDw
         RxvF1VTJzAFMQdj4ubsMyCKr6kKkEK38990YeT0ZA0HsVqjTWqFhS4njPf6B+37W5Uug
         tN5u4bzYTjiPyhbX5byXjI5rg4mzUOd65Tewtu3JN1tj4SOoQyHv2B+9g4HEv1R9vzpF
         LNXGf0TXd0ZiJsz19rH8NAATEfGAvjO7ipQPS8I3h7Z1dlalvQ03Var3zQ4asZ0+in0L
         IQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728264; x=1705333064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nLbyx15OK/Ut65BLZiDxnkDEQWNCZ3L30jSUhtPoLs=;
        b=eZt+wyZMbh7cBnBMpuXCpicGuiDFP5SmjoRUn6TpHydNPzklZlIySVc+BPf48jwIG+
         1n9xoWYJQ08UAs3O0VqQUZxg8m1Dm4OGFcULMFpuYyk0+foadNkAfdYr0WCIOU2+M5hI
         iJS0eBY9t3th+wjhV+NPOEtXj8xkU/0YN3Db+TCdoEvdklmfLdMDiWq/xRlvwxDCRrAh
         MN8xyER6ZJYl/o0AKebSHh7w1wDOBx7lH7RmCFUrV5UdkqMjDEfJmDI7+bFzOP0UL6g8
         WLmWBv4WkQ4SHn2R51t7GJq4vmcwpjz+CnrMmjmPFFk09lxztzfqM45svusrK1RwJ2fi
         uKaA==
X-Gm-Message-State: AOJu0YxpQR6NKOGLn7SwATfNmp5D7pWR//6avaltMgzU4Oi8SnTNZs1Z
	x2BbqVvXmZR5IRZu5Fc4pkyEnR7YEhq7Rg==
X-Google-Smtp-Source: AGHT+IECQtunkXtGJNEz2y7uoqHxDEhxN0uE0Y8C0UeMYbZef+b+AMYaUlZidkAk+iPvN9fDEhMh4A==
X-Received: by 2002:a17:90a:1b8c:b0:28c:aebc:e1b8 with SMTP id w12-20020a17090a1b8c00b0028caebce1b8mr1170033pjc.20.1704728264565;
        Mon, 08 Jan 2024 07:37:44 -0800 (PST)
Received: from x-wing.lan ([106.51.164.237])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a318500b00286f2b39a95sm122218pjb.31.2024.01.08.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:37:44 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rakesh Pillai <pillair@codeaurora.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>,
	Stable <stable@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH for-5.4.y 1/4] ath10k: Wait until copy complete is actually done before completing
Date: Mon,  8 Jan 2024 21:07:34 +0530
Message-Id: <20240108153737.3538218-2-amit.pundir@linaro.org>
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

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 8f9ed93d09a97444733d492a3bbf66bcb786a777 ]

On wcn3990 we have "per_ce_irq = true".  That makes the
ath10k_ce_interrupt_summary() function always return 0xfff. The
ath10k_ce_per_engine_service_any() function will see this and think
that _all_ copy engines have an interrupt.  Without checking, the
ath10k_ce_per_engine_service() assumes that if it's called that the
"copy complete" (cc) interrupt fired.  This combination seems bad.

Let's add a check to make sure that the "copy complete" interrupt
actually fired in ath10k_ce_per_engine_service().

This might fix a hard-to-reproduce failure where it appears that the
copy complete handlers run before the copy is really complete.
Specifically a symptom was that we were seeing this on a Qualcomm
sc7180 board:
  arm-smmu 15000000.iommu: Unhandled context fault:
  fsr=0x402, iova=0x7fdd45780, fsynr=0x30003, cbfrsynra=0xc1, cb=10

Even on platforms that don't have wcn3990 this still seems like it
would be a sane thing to do.  Specifically the current IRQ handler
comments indicate that there might be other misc interrupt sources
firing that need to be cleared.  If one of those sources was the one
that caused the IRQ handler to be called it would also be important to
double-check that the interrupt we cared about actually fired.

Tested-on: WCN3990 SNOC WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200609082015.1.Ife398994e5a0a6830e4d4a16306ef36e0144e7ba@changeid
Stable-dep-of: 170c75d43a77 ("ath10k: Don't touch the CE interrupt registers after power up")
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/net/wireless/ath/ath10k/ce.c | 30 +++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 01e05af5ae08..4b4eca407671 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -481,6 +481,15 @@ static inline void ath10k_ce_engine_int_status_clear(struct ath10k *ar,
 	ath10k_ce_write32(ar, ce_ctrl_addr + wm_regs->addr, mask);
 }
 
+static inline bool ath10k_ce_engine_int_status_check(struct ath10k *ar,
+						     u32 ce_ctrl_addr,
+						     unsigned int mask)
+{
+	struct ath10k_hw_ce_host_wm_regs *wm_regs = ar->hw_ce_regs->wm_regs;
+
+	return ath10k_ce_read32(ar, ce_ctrl_addr + wm_regs->addr) & mask;
+}
+
 /*
  * Guts of ath10k_ce_send.
  * The caller takes responsibility for any needed locking.
@@ -1301,19 +1310,22 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id)
 
 	spin_lock_bh(&ce->ce_lock);
 
-	/* Clear the copy-complete interrupts that will be handled here. */
-	ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
-					  wm_regs->cc_mask);
+	if (ath10k_ce_engine_int_status_check(ar, ctrl_addr,
+					      wm_regs->cc_mask)) {
+		/* Clear before handling */
+		ath10k_ce_engine_int_status_clear(ar, ctrl_addr,
+						  wm_regs->cc_mask);
 
-	spin_unlock_bh(&ce->ce_lock);
+		spin_unlock_bh(&ce->ce_lock);
 
-	if (ce_state->recv_cb)
-		ce_state->recv_cb(ce_state);
+		if (ce_state->recv_cb)
+			ce_state->recv_cb(ce_state);
 
-	if (ce_state->send_cb)
-		ce_state->send_cb(ce_state);
+		if (ce_state->send_cb)
+			ce_state->send_cb(ce_state);
 
-	spin_lock_bh(&ce->ce_lock);
+		spin_lock_bh(&ce->ce_lock);
+	}
 
 	/*
 	 * Misc CE interrupts are not being handled, but still need
-- 
2.25.1


