Return-Path: <stable+bounces-226072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDAwLuNpuWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:49:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CC12AC4D3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B47530089AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92923E3D81;
	Tue, 17 Mar 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYzqrgc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4726F291
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758940; cv=none; b=W7gNK0YJ3DkAPB4FbBXwA5nVjzbaRJ8QfilO5ZMdLRZ8aiRd1WJMCdYy8+GQl9haNYZ2uuajsB7tzcI44HlbbvXzVN/ykZjKjmjAqP2V+jvY2JDbWdtS00iR9ERtdaG71pdYTy4lilgHu9NHbplomxwD1CyNWb8IlOVp7gS6/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758940; c=relaxed/simple;
	bh=fH2Iv5Ebp0KVtlem9cu2xF3cOSgcNLVqTDLJz/bhfdE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oD5/MQDN1nDjLwgzCw4i8G2RsghG7V5AGTbKVGWGypxIj/l+Hy+GCrFdnbL40qSF04oax0mx/rF1tpwwhzgO4MjnSMoSuAe1IUKVCMjT5DKPVt+3GSN79l1yL8uMtvZZrLmODjN96iIZHlUExh0Ne4aKplkUQLwLd79duxNpcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYzqrgc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A883C2BC86;
	Tue, 17 Mar 2026 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758940;
	bh=fH2Iv5Ebp0KVtlem9cu2xF3cOSgcNLVqTDLJz/bhfdE=;
	h=Subject:To:Cc:From:Date:From;
	b=IYzqrgc7a6lIT+ulUjjVY+shLtihFo9Vic9E785uc1L9v0zbMFQQVKEMF29AmZg6H
	 LWBd729lPeeTXaE1BHhWmmLQoFnv/PKApthB2gPO79Z5Ddy4Y8VCKMaWP1KJyP53mW
	 pZ/reMhNlLvx4mKeTk+VxHp7NF3xxyKmQzUyAXNY=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Consolidate common xfer processing logic" failed to apply to 6.6-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:48:20 +0100
Message-ID: <2026031720-shrine-pancreas-dab8@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226072-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,nxp.com:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,intel.com:email]
X-Rspamd-Queue-Id: A1CC12AC4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7ac45bc68f089887ab3a70358057edb7e6b6084e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031720-shrine-pancreas-dab8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ac45bc68f089887ab3a70358057edb7e6b6084e Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:48 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Consolidate common xfer processing logic

Several parts of the MIPI I3C HCI driver duplicate the same sequence for
queuing a transfer, waiting for completion, and handling timeouts. This
logic appears in five separate locations and will be affected by an
upcoming fix.

Refactor the repeated code into a new helper, i3c_hci_process_xfer(), and
store the timeout value in the hci_xfer structure so that callers do not
need to pass it as a separate parameter.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-12-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index 831a261f6c56..75d452d7f6af 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -331,12 +331,10 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 			CMD_A0_ROC | CMD_A0_TOC;
 		xfer->cmd_desc[1] = 0;
 		xfer->completion = &done;
-		hci->io->queue_xfer(hci, xfer, 1);
-		if (!wait_for_completion_timeout(&done, HZ) &&
-		    hci->io->dequeue_xfer(hci, xfer, 1)) {
-			ret = -ETIMEDOUT;
+		xfer->timeout = HZ;
+		ret = i3c_hci_process_xfer(hci, xfer, 1);
+		if (ret)
 			break;
-		}
 		if ((RESP_STATUS(xfer->response) == RESP_ERR_ADDR_HEADER ||
 		     RESP_STATUS(xfer->response) == RESP_ERR_NACK) &&
 		    RESP_DATA_LENGTH(xfer->response) == 1) {
diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
index 054beee36da5..39eec26a363c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c
@@ -253,6 +253,7 @@ static int hci_cmd_v2_daa(struct i3c_hci *hci)
 	xfer[0].rnw = true;
 	xfer[0].cmd_desc[1] = CMD_A1_DATA_LENGTH(8);
 	xfer[1].completion = &done;
+	xfer[1].timeout = HZ;
 
 	for (;;) {
 		ret = i3c_master_get_free_addr(&hci->master, next_addr);
@@ -272,12 +273,9 @@ static int hci_cmd_v2_daa(struct i3c_hci *hci)
 			CMD_A0_ASSIGN_ADDRESS(next_addr) |
 			CMD_A0_ROC |
 			CMD_A0_TOC;
-		hci->io->queue_xfer(hci, xfer, 2);
-		if (!wait_for_completion_timeout(&done, HZ) &&
-		    hci->io->dequeue_xfer(hci, xfer, 2)) {
-			ret = -ETIMEDOUT;
+		ret = i3c_hci_process_xfer(hci, xfer, 2);
+		if (ret)
 			break;
-		}
 		if (RESP_STATUS(xfer[0].response) != RESP_SUCCESS) {
 			ret = 0;  /* no more devices to be assigned */
 			break;
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index adf35b7fa498..4a80671536f0 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -213,6 +213,25 @@ void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci)
 	reg_write(DCT_SECTION, FIELD_PREP(DCT_TABLE_INDEX, 0));
 }
 
+int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n)
+{
+	struct completion *done = xfer[n - 1].completion;
+	unsigned long timeout = xfer[n - 1].timeout;
+	int ret;
+
+	ret = hci->io->queue_xfer(hci, xfer, n);
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(done, timeout) &&
+	    hci->io->dequeue_xfer(hci, xfer, n)) {
+		dev_err(&hci->master.dev, "%s: timeout error\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int i3c_hci_send_ccc_cmd(struct i3c_master_controller *m,
 				struct i3c_ccc_cmd *ccc)
 {
@@ -253,18 +272,14 @@ static int i3c_hci_send_ccc_cmd(struct i3c_master_controller *m,
 	last = i - 1;
 	xfer[last].cmd_desc[0] |= CMD_0_TOC;
 	xfer[last].completion = &done;
+	xfer[last].timeout = HZ;
 
 	if (prefixed)
 		xfer--;
 
-	ret = hci->io->queue_xfer(hci, xfer, nxfers);
+	ret = i3c_hci_process_xfer(hci, xfer, nxfers);
 	if (ret)
 		goto out;
-	if (!wait_for_completion_timeout(&done, HZ) &&
-	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
 	for (i = prefixed; i < nxfers; i++) {
 		if (ccc->rnw)
 			ccc->dests[i - prefixed].payload.len =
@@ -335,15 +350,11 @@ static int i3c_hci_i3c_xfers(struct i3c_dev_desc *dev,
 	last = i - 1;
 	xfer[last].cmd_desc[0] |= CMD_0_TOC;
 	xfer[last].completion = &done;
+	xfer[last].timeout = HZ;
 
-	ret = hci->io->queue_xfer(hci, xfer, nxfers);
+	ret = i3c_hci_process_xfer(hci, xfer, nxfers);
 	if (ret)
 		goto out;
-	if (!wait_for_completion_timeout(&done, HZ) &&
-	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
 	for (i = 0; i < nxfers; i++) {
 		if (i3c_xfers[i].rnw)
 			i3c_xfers[i].len = RESP_DATA_LENGTH(xfer[i].response);
@@ -383,15 +394,11 @@ static int i3c_hci_i2c_xfers(struct i2c_dev_desc *dev,
 	last = i - 1;
 	xfer[last].cmd_desc[0] |= CMD_0_TOC;
 	xfer[last].completion = &done;
+	xfer[last].timeout = m->i2c.timeout;
 
-	ret = hci->io->queue_xfer(hci, xfer, nxfers);
+	ret = i3c_hci_process_xfer(hci, xfer, nxfers);
 	if (ret)
 		goto out;
-	if (!wait_for_completion_timeout(&done, m->i2c.timeout) &&
-	    hci->io->dequeue_xfer(hci, xfer, nxfers)) {
-		ret = -ETIMEDOUT;
-		goto out;
-	}
 	for (i = 0; i < nxfers; i++) {
 		if (RESP_STATUS(xfer[i].response) != RESP_SUCCESS) {
 			ret = -EIO;
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 9c63d80f7fc4..850016e3d4fe 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -89,6 +89,7 @@ struct hci_xfer {
 	unsigned int data_len;
 	unsigned int cmd_tid;
 	struct completion *completion;
+	unsigned long timeout;
 	union {
 		struct {
 			/* PIO specific */
@@ -156,5 +157,6 @@ void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
 void amd_set_resp_buf_thld(struct i3c_hci *hci);
 void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
+int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
 
 #endif


