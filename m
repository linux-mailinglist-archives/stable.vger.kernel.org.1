Return-Path: <stable+bounces-226076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKShA/VruWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A72AC85D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E98C312DD54
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857713E868B;
	Tue, 17 Mar 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1S+hHlNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491493E3D81
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758956; cv=none; b=AKadI931PbtMqEeH2b+v0CBqPOjI5Vx4mD8fxTnhLPIhNvSQIKAfXxyud8/GPv7XH/2nP+/eTBLNancD6lSfgrPmbntIUIz8SUQscrilJJqTnMJUn75tyeCufrTqJvgFpgpbjXBAuu5ZixbjoageczpwoLlp9MgnvQZ6HyyvWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758956; c=relaxed/simple;
	bh=0HaLQpzDBAEp3nGz7IRNRx/1OPk1FccZkVHTWuKzRzw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CgWRWKTWvSlo0wN/np41iNPH7Qw8VVPZHDyZJQ44v8tUGqRQiYXZLr/nrkTMftJFkQdFBW5c+6oTbbJFBZ81jEZEiII4Ox8/7xL0u2M42gS7NhUsDu0wdIgfSxPXSblsLHihpyOjnv5pmmHgKDLuYrOu2SMHJEImj8QHd+yUgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1S+hHlNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C8C4CEF7;
	Tue, 17 Mar 2026 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758956;
	bh=0HaLQpzDBAEp3nGz7IRNRx/1OPk1FccZkVHTWuKzRzw=;
	h=Subject:To:Cc:From:Date:From;
	b=1S+hHlNb0Vto6rSFdBjgLRHquScOXAGcpl1hGCXeomsoyhPd7oFCgbteDJ2KzirLm
	 8FtBEKmZcWgjuzdyHSQPdEIxNuYDCD7oAwEsKWslscaOBGRve0y08M40hIyH6f4254
	 sBy8dJ0wkfPyZ9TIfCrZVNtUkZnbjq7//eWykdhE=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race in DMA error handling in" failed to apply to 6.12-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:31 +0100
Message-ID: <2026031731-expel-lens-bed2@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226076-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,gregkh:email,msgid.link:url,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A67A72AC85D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e44d2719225e618dde74c7056f8e6949f884095e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031731-expel-lens-bed2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e44d2719225e618dde74c7056f8e6949f884095e Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:49 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix race in DMA error handling in
 interrupt context

The DMA ring halts whenever a transfer encounters an error. The interrupt
handler previously attempted to detect this situation and restart the ring
if a transfer completed at the same time. However, this restart logic runs
entirely in interrupt context and is inherently racy: it interacts with
other paths manipulating the ring state, and fully serializing it within
the interrupt handler is not practical.

Move this error-recovery logic out of the interrupt handler and into the
transfer-processing path (i3c_hci_process_xfer()), where serialization and
state management are already controlled. Introduce a new optional I/O-ops
callback, handle_error(), invoked when a completed transfer reports an
error. For DMA operation, the implementation simply calls the existing
dequeue function, which safely aborts and restarts the ring when needed.

This removes the fragile ring-restart logic from the interrupt handler and
centralizes error handling where proper sequencing can be ensured.

Fixes: ccdb2e0e3b00d ("i3c: mipi-i3c-hci: Add Intel specific quirk to ring resuming")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-13-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 4a80671536f0..b98952d12d7c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -223,10 +223,21 @@ int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n)
 	if (ret)
 		return ret;
 
-	if (!wait_for_completion_timeout(done, timeout) &&
-	    hci->io->dequeue_xfer(hci, xfer, n)) {
-		dev_err(&hci->master.dev, "%s: timeout error\n", __func__);
-		return -ETIMEDOUT;
+	if (!wait_for_completion_timeout(done, timeout)) {
+		if (hci->io->dequeue_xfer(hci, xfer, n)) {
+			dev_err(&hci->master.dev, "%s: timeout error\n", __func__);
+			return -ETIMEDOUT;
+		}
+		return 0;
+	}
+
+	if (hci->io->handle_error) {
+		bool error = false;
+
+		for (int i = 0; i < n && !error; i++)
+			error = RESP_STATUS(xfer[i].response);
+		if (error)
+			return hci->io->handle_error(hci, xfer, n);
 	}
 
 	return 0;
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 41b83f07fdab..e487ef52f6b4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -609,6 +609,11 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 	return did_unqueue;
 }
 
+static int hci_dma_handle_error(struct i3c_hci *hci, struct hci_xfer *xfer_list, int n)
+{
+	return hci_dma_dequeue_xfer(hci, xfer_list, n) ? -EIO : 0;
+}
+
 static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 {
 	u32 op1_val, op2_val, resp, *ring_resp;
@@ -870,29 +875,8 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci)
 			hci_dma_xfer_done(hci, rh);
 		if (status & INTR_RING_OP)
 			complete(&rh->op_done);
-
-		if (status & INTR_TRANSFER_ABORT) {
-			u32 ring_status;
-
-			dev_notice_ratelimited(&hci->master.dev,
-				"Ring %d: Transfer Aborted\n", i);
-			mipi_i3c_hci_resume(hci);
-			ring_status = rh_reg_read(RING_STATUS);
-			if (!(ring_status & RING_STATUS_RUNNING) &&
-			    status & INTR_TRANSFER_COMPLETION &&
-			    status & INTR_TRANSFER_ERR) {
-				/*
-				 * Ring stop followed by run is an Intel
-				 * specific required quirk after resuming the
-				 * halted controller. Do it only when the ring
-				 * is not in running state after a transfer
-				 * error.
-				 */
-				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE);
-				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE |
-							   RING_CTRL_RUN_STOP);
-			}
-		}
+		if (status & INTR_TRANSFER_ABORT)
+			dev_dbg(&hci->master.dev, "Ring %d: Transfer Aborted\n", i);
 		if (status & INTR_IBI_RING_FULL)
 			dev_err_ratelimited(&hci->master.dev,
 				"Ring %d: IBI Ring Full Condition\n", i);
@@ -908,6 +892,7 @@ const struct hci_io_ops mipi_i3c_hci_dma = {
 	.cleanup		= hci_dma_cleanup,
 	.queue_xfer		= hci_dma_queue_xfer,
 	.dequeue_xfer		= hci_dma_dequeue_xfer,
+	.handle_error		= hci_dma_handle_error,
 	.irq_handler		= hci_dma_irq_handler,
 	.request_ibi		= hci_dma_request_ibi,
 	.free_ibi		= hci_dma_free_ibi,
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 850016e3d4fe..9ac9d0e342f4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -123,6 +123,7 @@ struct hci_io_ops {
 	bool (*irq_handler)(struct i3c_hci *hci);
 	int (*queue_xfer)(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
 	bool (*dequeue_xfer)(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
+	int (*handle_error)(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
 	int (*request_ibi)(struct i3c_hci *hci, struct i3c_dev_desc *dev,
 			   const struct i3c_ibi_setup *req);
 	void (*free_ibi)(struct i3c_hci *hci, struct i3c_dev_desc *dev);


