Return-Path: <stable+bounces-226056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAI+D9JruWmvEQIAu9opvQ
	(envelope-from <stable+bounces-226056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D72602AC809
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A183A3178EFC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265483E867A;
	Tue, 17 Mar 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLnimeS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C43C1996
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758802; cv=none; b=r/tWe2raqLAh4QH03UiOVDoYoJR8FTyuf6LbpbDz8vyIWHqKa+DmTFSqy9vXz5pGx87XBXcDed2MUYv+U4+P0QbG34ORnGcTvSRBs+85KOqAEXEGyAA7iD06qemQtqL+l9bFU1OpE1oesXKSO/GZFDSd7fnZXjNT9axP/MqgZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758802; c=relaxed/simple;
	bh=Sd9js/XQXhRzAoIT9ggUKud5g2a3b35P3a1FbtbWNJk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OqDUmRpnCdKBBZY9oUA6UKHRGvZgstxzfVft12upLXds7k4p5bbUb9x6wgoCF45S6vpk83lx4RJKCd/nSz5kJjgYoGv78FEU1vLJbOubLdH8/kPxKYTb8p3W5jIv5PxKyPtEaedCM3c83NjD8vR6iW1NlDgcuIe9SqGc3Spub2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLnimeS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD00C4CEF7;
	Tue, 17 Mar 2026 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758802;
	bh=Sd9js/XQXhRzAoIT9ggUKud5g2a3b35P3a1FbtbWNJk=;
	h=Subject:To:Cc:From:Date:From;
	b=uLnimeS+akOD2HyQuRgXBFMxKck23p7NZVuYUGT8ny6N1BvO4rfm660waal9g/doJ
	 geBbuAGPsvs+jqhcOII+abCYYtAu9eB9aXKk5NcqOKGsKOUuDU2Bh/NsFR4gIP6vzw
	 qynpuxHqkRQfHqqXuHDb8SLUeP5Fei2FmaR83bnE=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring dequeue" failed to apply to 6.1-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:46:27 +0100
Message-ID: <2026031727-stowing-immovable-d382@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226056-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,bootlin.com:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: D72602AC809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1dca8aee80eea76d2aae21265de5dd64f6ba0f09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031727-stowing-immovable-d382@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1dca8aee80eea76d2aae21265de5dd64f6ba0f09 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 6 Mar 2026 09:24:43 +0200
Subject: [PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring dequeue

The HCI DMA dequeue path (hci_dma_dequeue_xfer()) may be invoked for
multiple transfers that timeout around the same time.  However, the
function is not serialized and can race with itself.

When a timeout occurs, hci_dma_dequeue_xfer() stops the ring, processes
incomplete transfers, and then restarts the ring.  If another timeout
triggers a parallel call into the same function, the two instances may
interfere with each other - stopping or restarting the ring at unexpected
times.

Add a mutex so that hci_dma_dequeue_xfer() is serialized with respect to
itself.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-7-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index faf5eae2409f..061e84a5c412 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -927,6 +927,7 @@ static int i3c_hci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&hci->lock);
+	mutex_init(&hci->control_mutex);
 
 	/*
 	 * Multi-bus instances share the same MMIO address range, but not
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 74b255ad6d0f..f7d411e5e11f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -547,6 +547,8 @@ static bool hci_dma_dequeue_xfer(struct i3c_hci *hci,
 	unsigned int i;
 	bool did_unqueue = false;
 
+	guard(mutex)(&hci->control_mutex);
+
 	/* stop the ring */
 	rh_reg_write(RING_CONTROL, RING_CTRL_ABORT);
 	if (wait_for_completion_timeout(&rh->op_done, HZ) == 0) {
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f1dd502c071f..9c63d80f7fc4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -51,6 +51,7 @@ struct i3c_hci {
 	void *io_data;
 	const struct hci_cmd_ops *cmd;
 	spinlock_t lock;
+	struct mutex control_mutex;
 	atomic_t next_cmd_tid;
 	bool irq_inactive;
 	u32 caps;


