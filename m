Return-Path: <stable+bounces-226067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBRfN/JruWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102852AC848
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8796315EE66
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509E3E866E;
	Tue, 17 Mar 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjaeFpSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B643A9DB6
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758919; cv=none; b=RYktZrWa6BL/2nDVoLJsZ4YyGR6ig2R0QznWf4R0Tno23poOigI1DpfzeQXvA6+rux4oLP8Vbu49k/AAdCAK4L5B0yxxIdEGeJ9ilu4LaCrsXfOjJReBGtlFE73T42qctaFMS/XRQQWKoD4TlDR9TyBgl0hR1kvfeUwSvrVDILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758919; c=relaxed/simple;
	bh=DAJYGJt+NvjWjIQaNEfELbdCEgL2G3eXRJIL+X6yZUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m2STD810GtjP8xoGOzr9A4FuQmxaykalm0krVRN1HIr56XbC7qlNKLlRV8np33oRwbLYBWO1Kb7n5FVF3BwIJ8UI02SkJXKxPljSOW2Ga8ViKttZxK1npMhWsQRH/G2XijYiAIQRRNTJTfhMn7vYUvwKqn/+65L2+68N8L9z0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjaeFpSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9B4C4CEF7;
	Tue, 17 Mar 2026 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758918;
	bh=DAJYGJt+NvjWjIQaNEfELbdCEgL2G3eXRJIL+X6yZUU=;
	h=Subject:To:Cc:From:Date:From;
	b=kjaeFpSlELrAxy6VPmJIs7FCnxSca4PqDpOY6Jc6ncg0cvfwrlL4PXg1ZQ9De6qKV
	 xkyo4BAsci7G3jgpt45VHP1ao6AR7iy01dlbpMZ1y8neuRdYLXjIebrNfrWWA+p23/
	 pprsafzx8XvG8BRow3HItADPuFhMbUC+4r/e5cYc=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring enqueue for parallel" failed to apply to 6.1-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:13 +0100
Message-ID: <2026031713-portly-secrecy-a7fb@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226067-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nxp.com:email,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 102852AC848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4decbbc8a8cf0a69ab011d7c2c88ed3cd0a00ddd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031713-portly-secrecy-a7fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4decbbc8a8cf0a69ab011d7c2c88ed3cd0a00ddd Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:42 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring enqueue for parallel
 xfers

The I3C subsystem allows multiple transfers to be queued concurrently.
However, the MIPI I3C HCI driver's DMA enqueue path, hci_dma_queue_xfer(),
lacks sufficient serialization.

In particular, the allocation of the enqueue_ptr and its subsequent update
in the RING_OPERATION1 register, must be done atomically.  Otherwise, for
example, it would be possible for 2 transfers to be allocated the same
enqueue_ptr.

Extend the use of the existing spinlock for that purpose.  Keep a count of
the number of xfers enqueued so that it is easy to determine if the ring
has enough space.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-6-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 2442cedd5c2a..74b255ad6d0f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -129,7 +129,7 @@ struct hci_rh_data {
 	dma_addr_t xfer_dma, resp_dma, ibi_status_dma, ibi_data_dma;
 	unsigned int xfer_entries, ibi_status_entries, ibi_chunks_total;
 	unsigned int xfer_struct_sz, resp_struct_sz, ibi_status_sz, ibi_chunk_sz;
-	unsigned int done_ptr, ibi_chunk_ptr;
+	unsigned int done_ptr, ibi_chunk_ptr, xfer_space;
 	struct hci_xfer **src_xfers;
 	struct completion op_done;
 };
@@ -260,6 +260,7 @@ static void hci_dma_init_rh(struct i3c_hci *hci, struct hci_rh_data *rh, int i)
 
 	rh->done_ptr = 0;
 	rh->ibi_chunk_ptr = 0;
+	rh->xfer_space = rh->xfer_entries;
 }
 
 static void hci_dma_init_rings(struct i3c_hci *hci)
@@ -470,7 +471,7 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 	struct hci_rings_data *rings = hci->io_data;
 	struct hci_rh_data *rh;
 	unsigned int i, ring, enqueue_ptr;
-	u32 op1_val, op2_val;
+	u32 op1_val;
 	int ret;
 
 	ret = hci_dma_map_xfer_list(hci, rings->sysdev, xfer_list, n);
@@ -481,6 +482,14 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 	ring = 0;
 	rh = &rings->headers[ring];
 
+	spin_lock_irq(&hci->lock);
+
+	if (n > rh->xfer_space) {
+		spin_unlock_irq(&hci->lock);
+		hci_dma_unmap_xfer(hci, xfer_list, n);
+		return -EBUSY;
+	}
+
 	op1_val = rh_reg_read(RING_OPERATION1);
 	enqueue_ptr = FIELD_GET(RING_OP1_CR_ENQ_PTR, op1_val);
 	for (i = 0; i < n; i++) {
@@ -518,22 +527,10 @@ static int hci_dma_queue_xfer(struct i3c_hci *hci,
 		xfer->ring_entry = enqueue_ptr;
 
 		enqueue_ptr = (enqueue_ptr + 1) % rh->xfer_entries;
-
-		/*
-		 * We may update the hardware view of the enqueue pointer
-		 * only if we didn't reach its dequeue pointer.
-		 */
-		op2_val = rh_reg_read(RING_OPERATION2);
-		if (enqueue_ptr == FIELD_GET(RING_OP2_CR_DEQ_PTR, op2_val)) {
-			/* the ring is full */
-			hci_dma_unmap_xfer(hci, xfer_list, n);
-			return -EBUSY;
-		}
 	}
 
-	/* take care to update the hardware enqueue pointer atomically */
-	spin_lock_irq(&hci->lock);
-	op1_val = rh_reg_read(RING_OPERATION1);
+	rh->xfer_space -= n;
+
 	op1_val &= ~RING_OP1_CR_ENQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_CR_ENQ_PTR, enqueue_ptr);
 	rh_reg_write(RING_OPERATION1, op1_val);
@@ -601,6 +598,7 @@ static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 {
 	u32 op1_val, op2_val, resp, *ring_resp;
 	unsigned int tid, done_ptr = rh->done_ptr;
+	unsigned int done_cnt = 0;
 	struct hci_xfer *xfer;
 
 	for (;;) {
@@ -632,10 +630,12 @@ static void hci_dma_xfer_done(struct i3c_hci *hci, struct hci_rh_data *rh)
 
 		done_ptr = (done_ptr + 1) % rh->xfer_entries;
 		rh->done_ptr = done_ptr;
+		done_cnt += 1;
 	}
 
 	/* take care to update the software dequeue pointer atomically */
 	spin_lock(&hci->lock);
+	rh->xfer_space += done_cnt;
 	op1_val = rh_reg_read(RING_OPERATION1);
 	op1_val &= ~RING_OP1_CR_SW_DEQ_PTR;
 	op1_val |= FIELD_PREP(RING_OP1_CR_SW_DEQ_PTR, done_ptr);


