Return-Path: <stable+bounces-226045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJMBG4JruWmvEQIAu9opvQ
	(envelope-from <stable+bounces-226045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E82AC757
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56BD3111EBC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CF3E51FF;
	Tue, 17 Mar 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eRkLPk6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0E318B9B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758718; cv=none; b=drOi2jx8osHKrB1Aoyuwa9BYqkJl/gWJkv3J6La+TRJiV0OQc7aZsSYoHQ8GOGlIpQguEhXXGmFXl5Oi5bM79hRbP69S4VRUp/Nglrh8ogD6pgv8EjRqyfegrPVioLXBWCbs8DG+nMf3sGoi+mKYw4vG5V66bb/1Y7wWzje42/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758718; c=relaxed/simple;
	bh=RAufoS44TNq8xi/3DTTrVYQZa+YnRF2zyebPWlubW/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tjYScOKrfvvvdp5WS5rIRZC59dwfIBPTDH4hks0LjLehTjNOpyFrR0xrWeu4WObiX3e8LDAShIG7thqaf0aE7c2JoPi/LGUoVGCBfiWO4GwR8IqKFqWJ34kEgiF2ID+hUlt+HnsATQq5V42OzvEsbVrzNudi7TwtiK/DnglgU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eRkLPk6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435FFC4CEF7;
	Tue, 17 Mar 2026 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758717;
	bh=RAufoS44TNq8xi/3DTTrVYQZa+YnRF2zyebPWlubW/A=;
	h=Subject:To:Cc:From:Date:From;
	b=eRkLPk6eMOnM87Gd6+KxWioKaTksZqZzOQc2N2Oxv5z6keov57j9HZeaFwb+Gb9vf
	 Kc3tiUpEsl3s807+1T9OJqP+/mnKOSKo+xMXaPJYUBP9whWz3qpeESe1N67smT2wi+
	 e2saRmqniO8LWupBW9tHFeLgV9ThqHpZyJy1Tu5A=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Consolidate spinlocks" failed to apply to 6.6-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:45:04 +0100
Message-ID: <2026031704-viewing-sadness-64b0@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226045-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,gregkh:email,nxp.com:email,msgid.link:url]
X-Rspamd-Queue-Id: D59E82AC757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fa12bb903bc3ed1826e355d267fe134bde95e23c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031704-viewing-sadness-64b0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa12bb903bc3ed1826e355d267fe134bde95e23c Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:41 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Consolidate spinlocks

The MIPI I3C HCI driver currently uses separate spinlocks for different
contexts (PIO vs. DMA rings).  This split is unnecessary and complicates
upcoming fixes.  The driver does not support concurrent PIO and DMA
operation, and it only supports a single DMA ring, so a single lock is
sufficient for all paths.

Introduce a unified spinlock in struct i3c_hci, switch both PIO and DMA
code to use it, and remove the per-context locks.

No functional change is intended in this patch.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-5-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4877a321edf9..faf5eae2409f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -926,6 +926,8 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (!hci)
 		return -ENOMEM;
 
+	spin_lock_init(&hci->lock);
+
 	/*
 	 * Multi-bus instances share the same MMIO address range, but not
 	 * necessarily in separate contiguous sub-ranges. To avoid overlapping
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index ba451f026386..2442cedd5c2a 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -131,7 +131,6 @@ struct hci_rh_data {
 	unsigned int xfer_struct_sz, resp_struct_sz, ibi_status_sz, ibi_chunk_sz;
 	unsigned int done_ptr, ibi_chunk_ptr;
 	struct hci_xfer **src_xfers;
-	spinlock_t lock;
 	struct completion op_done;
 };
 
@@ -344,7 +343,6 @@ static int hci_dma_init(struct i3c_hci *hci)
 			goto err_out;
 		rh = &rings->headers[i];
 		rh->regs = hci->base_regs + offset;
-		spin_lock_init(&rh->lock);
 		init_completion(&rh->op_done);
 
 		rh->xfer_entries = XFER_RING_ENTRIES;
@@ -534,12 +532,12 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 	}
 
 	/* take care to update the hardware enqueue pointer atomically */
-	spin_lock_irq(&rh->lock);
+	spin_lock_irq(&hci->lock);
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_CR_ENQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_CR_ENQ_PTR, enqueue_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
-	spin_unlock_irq(&rh->lock);
+	spin_unlock_irq(&hci->lock);
 
 	return 0;
 }
@@ -637,12 +635,12 @@ static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 	}
 
 	/* take care to update the software dequeue pointer atomically */
-	spin_lock(&rh->lock);
+	spin_lock(&hci->lock);
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_CR_SW_DEQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_CR_SW_DEQ_PTR, done_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
-	spin_unlock(&rh->lock);
+	spin_unlock(&hci->lock);
 }
 
 static int hci_dma_request_ibi(struct i3c_hci *hci, struct i3c_dev_desc *dev,
@@ -823,12 +821,12 @@ static void hci_dma_process_ibi(struct i3c_hci *hci, struct hci_rh_data *rh)
 
 done:
 	/* take care to update the ibi dequeue pointer atomically */
-	spin_lock(&rh->lock);
+	spin_lock(&hci->lock);
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_IBI_DEQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_IBI_DEQ_PTR, deq_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
-	spin_unlock(&rh->lock);
+	spin_unlock(&hci->lock);
 
 	/* update the chunk pointer */
 	rh->ibi_chunk_ptr += ibi_chunks;
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 337b7ab1cb06..f1dd502c071f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -50,6 +50,7 @@ struct i3c_hci {
 	const struct hci_io_ops *io;
 	void *io_data;
 	const struct hci_cmd_ops *cmd;
+	spinlock_t lock;
 	atomic_t next_cmd_tid;
 	bool irq_inactive;
 	u32 caps;
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index f8825ac81408..02866c2237fa 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -123,7 +123,6 @@ struct hci_pio_ibi_data {
 };
 
 struct hci_pio_data {
-	spinlock_t lock;
 	struct hci_xfer *curr_xfer, *xfer_queue;
 	struct hci_xfer *curr_rx, *rx_queue;
 	struct hci_xfer *curr_tx, *tx_queue;
@@ -212,7 +211,6 @@ static int hci_pio_init(struct i3c_hci *hci)
 		return -ENOMEM;
 
 	hci->io_data = pio;
-	spin_lock_init(&pio->lock);
 
 	__hci_pio_init(hci, &size_val);
 
@@ -631,7 +629,7 @@ static int hci_pio_queue_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n)
 		xfer[i].data_left = xfer[i].data_len;
 	}
 
-	spin_lock_irq(&pio->lock);
+	spin_lock_irq(&hci->lock);
 	prev_queue_tail = pio->xfer_queue;
 	pio->xfer_queue = &xfer[n - 1];
 	if (pio->curr_xfer) {
@@ -645,7 +643,7 @@ static int hci_pio_queue_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n)
 			pio_reg_read(INTR_STATUS),
 			pio_reg_read(INTR_SIGNAL_ENABLE));
 	}
-	spin_unlock_irq(&pio->lock);
+	spin_unlock_irq(&hci->lock);
 	return 0;
 }
 
@@ -716,14 +714,14 @@ static bool hci_pio_dequeue_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int
 	struct hci_pio_data *pio = hci->io_data;
 	int ret;
 
-	spin_lock_irq(&pio->lock);
+	spin_lock_irq(&hci->lock);
 	dev_dbg(&hci->master.dev, "n=%d status=%#x/%#x", n,
 		pio_reg_read(INTR_STATUS), pio_reg_read(INTR_SIGNAL_ENABLE));
 	dev_dbg(&hci->master.dev, "main_status = %#x/%#x",
 		readl(hci->base_regs + 0x20), readl(hci->base_regs + 0x28));
 
 	ret = hci_pio_dequeue_xfer_common(hci, pio, xfer, n);
-	spin_unlock_irq(&pio->lock);
+	spin_unlock_irq(&hci->lock);
 	return ret;
 }
 
@@ -1016,13 +1014,13 @@ static bool hci_pio_irq_handler(struct i3c_hci *hci)
 	struct hci_pio_data *pio = hci->io_data;
 	u32 status;
 
-	spin_lock(&pio->lock);
+	spin_lock(&hci->lock);
 	status = pio_reg_read(INTR_STATUS);
 	dev_dbg(&hci->master.dev, "PIO_INTR_STATUS %#x/%#x",
 		status, pio->enabled_irqs);
 	status &= pio->enabled_irqs | STAT_LATENCY_WARNINGS;
 	if (!status) {
-		spin_unlock(&pio->lock);
+		spin_unlock(&hci->lock);
 		return false;
 	}
 
@@ -1058,7 +1056,7 @@ static bool hci_pio_irq_handler(struct i3c_hci *hci)
 	pio_reg_write(INTR_SIGNAL_ENABLE, pio->enabled_irqs);
 	dev_dbg(&hci->master.dev, "PIO_INTR_STATUS %#x/%#x",
 		pio_reg_read(INTR_STATUS), pio_reg_read(INTR_SIGNAL_ENABLE));
-	spin_unlock(&pio->lock);
+	spin_unlock(&hci->lock);
 	return true;
 }
 


