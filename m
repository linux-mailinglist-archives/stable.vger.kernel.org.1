Return-Path: <stable+bounces-226078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gId3Om9suWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CE2AC926
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9ED93165045
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F33E716D;
	Tue, 17 Mar 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YP2+ulvN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F83E3D81
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758965; cv=none; b=EtXyfJmA2e1pgjiWAYiL4ktpScVu5q6ATp+mtjHB4VpXG0AlG/cpS8xgrHfTa7/1xA5tfYA9bKaxiMtwWw8VnPv83AfG9cjLU34tVgaPFNAGMEAcK9nnY2/ohnyCGgFk9dCMlPUre6dMu+/0ZkGpUHjO5H5oNVHZk7DDCZpVVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758965; c=relaxed/simple;
	bh=Lu/leoyTlZ0eb+Tz2kUMru7SmxR/WCYLE0Grz8QjWKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Uy2AAs8G6KhQlImmJ7bj4H6v81UIFMcNuQXUa2Rb08e3Jl4IBvmnchf7J83DplFwCfs6o9XQMROWQoSgr+oCUGgXrKMhZZQoMeOc1wRJaYsflUrZlmGCbN1xvKNrQuP8thUkr0R8p7y/y3FFI9TQ57wdeGdRlLdx3Y+7k7nSxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YP2+ulvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14363C4CEF7;
	Tue, 17 Mar 2026 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758964;
	bh=Lu/leoyTlZ0eb+Tz2kUMru7SmxR/WCYLE0Grz8QjWKo=;
	h=Subject:To:Cc:From:Date:From;
	b=YP2+ulvNBKR1yEpC7/jnV3qEW/m++R6yu591gOzlO3/MuWGhgX5u5qoeyaj0C0Ej0
	 JUVu7lynotLbiZPf6eJBF/tmcPr3A23dshRUzKzi1ivXZtsQYoKJCfMmVpo9opi3GV
	 ctwmXmbTB6x8ElYl8LG2XpykqkuJKBjZycDrHqTo=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race between DMA ring dequeue and" failed to apply to 6.19-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:37 +0100
Message-ID: <2026031737-reviver-scarecrow-ae71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226078-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,gregkh:email,bootlin.com:email,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 548CE2AC926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x f0b5159637ca0b8feaaa95de0f5ea38f1ba26729
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031737-reviver-scarecrow-ae71@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0b5159637ca0b8feaaa95de0f5ea38f1ba26729 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:44 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix race between DMA ring dequeue and
 interrupt handler

The DMA ring bookkeeping in the MIPI I3C HCI driver is updated from two
contexts: the DMA ring dequeue path (hci_dma_dequeue_xfer()) and the
interrupt handler (hci_dma_xfer_done()).  Both modify the ring's
in-flight transfer state - specifically rh->src_xfers[] and
xfer->ring_entry - but without any serialization.  This allows the two
paths to race, potentially leading to inconsistent ring state.

Serialize access to the shared ring state by extending the existing
spinlock to cover the DMA dequeue path and the entire interrupt handler.
Since the core IRQ handler now holds this lock, remove the per-function
locking from the PIO and DMA sub-handlers.

Additionally, clear the completed entry in rh->src_xfers[] in
hci_dma_xfer_done() so it cannot be matched or completed again.

Finally, place the ring restart sequence under the same lock in
hci_dma_dequeue_xfer() to avoid concurrent enqueue or completion
operations while the ring state is being modified.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-8-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 061e84a5c412..adf35b7fa498 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -567,6 +567,8 @@ static irqreturn_t i3c_hci_irq_handler(int irq, void *dev_id)
 	irqreturn_t result = IRQ_NONE;
 	u32 val;
 
+	guard(spinlock)(&hci->lock);
+
 	/*
 	 * The IRQ can be shared, so the handler may be called when the IRQ is
 	 * due to a different device. That could happen when runtime suspended,
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index f7d411e5e11f..d7840ff69e59 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -560,6 +560,8 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 		WARN_ON(1);
 	}
 
+	spin_lock_irq(&hci->lock);
+
 	for (i = 0; i < n; i++) {
 		struct hci_xfer *xfer = xfer_list + i;
 		int idx = xfer->ring_entry;
@@ -593,6 +595,8 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 	/* restart the ring */
 	rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE);
 
+	spin_unlock_irq(&hci->lock);
+
 	return did_unqueue;
 }
 
@@ -618,6 +622,7 @@ static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 			dev_dbg(&hci->master.dev, "orphaned ring entry");
 		} else {
 			hci_dma_unmap_xfer(hci, xfer, 1);
+			rh->src_xfers[done_ptr] = NULL;
 			xfer->ring_entry = -1;
 			xfer->response = resp;
 			if (tid != xfer->cmd_tid) {
@@ -635,14 +640,11 @@ static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 		done_cnt += 1;
 	}
 
-	/* take care to update the software dequeue pointer atomically */
-	spin_lock(&hci->lock);
 	rh->xfer_space += done_cnt;
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_CR_SW_DEQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_CR_SW_DEQ_PTR, done_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
-	spin_unlock(&hci->lock);
 }
 
 static int hci_dma_request_ibi(struct i3c_hci *hci, struct i3c_dev_desc *dev,
@@ -822,13 +824,10 @@ static void hci_dma_process_ibi(struct i3c_hci *hci, struct hci_rh_data *rh)
 	i3c_master_queue_ibi(dev, slot);
 
 done:
-	/* take care to update the ibi dequeue pointer atomically */
-	spin_lock(&hci->lock);
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_IBI_DEQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_IBI_DEQ_PTR, deq_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
-	spin_unlock(&hci->lock);
 
 	/* update the chunk pointer */
 	rh->ibi_chunk_ptr += ibi_chunks;
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index 02866c2237fa..8f48a81e65ab 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -1014,15 +1014,12 @@ static bool hci_pio_irq_handler(struct i3c_hci *hci)
 	struct hci_pio_data *pio = hci->io_data;
 	u32 status;
 
-	spin_lock(&hci->lock);
 	status = pio_reg_read(INTR_STATUS);
 	dev_dbg(&hci->master.dev, "PIO_INTR_STATUS %#x/%#x",
 		status, pio->enabled_irqs);
 	status &= pio->enabled_irqs | STAT_LATENCY_WARNINGS;
-	if (!status) {
-		spin_unlock(&hci->lock);
+	if (!status)
 		return false;
-	}
 
 	if (status & STAT_IBI_STATUS_THLD)
 		hci_pio_process_ibi(hci, pio);
@@ -1056,7 +1053,6 @@ static bool hci_pio_irq_handler(struct i3c_hci *hci)
 	pio_reg_write(INTR_SIGNAL_ENABLE, pio->enabled_irqs);
 	dev_dbg(&hci->master.dev, "PIO_INTR_STATUS %#x/%#x",
 		pio_reg_read(INTR_STATUS), pio_reg_read(INTR_SIGNAL_ENABLE));
-	spin_unlock(&hci->lock);
 	return true;
 }
 


