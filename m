Return-Path: <stable+bounces-226057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKkXC29suWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7002AC91F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 769E230AA9B5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D433E7175;
	Tue, 17 Mar 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtdEoXt6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F783E868B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758807; cv=none; b=XbQDfWCzk29W+kftvmRCVMtOF8wASf9vHPvKtu/8+O3mQUR31cpvmZe3obA+mo/440KiN+Nl0G02GstKTYBpwwuKp9qJ4/r6kiZpzHH/pgU/yVmooJjlB99+pCgTWwJ1joA8G0uMEd+Zr7Vq1DF+fCTwTWrWm1yAySBnkRC0xgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758807; c=relaxed/simple;
	bh=sscSoSFouV+BYtAMLCzJuJT4rVcrPZOmplb5c40nlDs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hcc2JHBTtl3TJPmvDXD9Xx92V9U6wZhT0vNccXoKBpaIUQIFlMthi0JYd0QgvZeYFMNduE7+tZ9oY/bm8dGq1hHw0CgC7aFvAHboiWqRL9G3PiUg4qYa9Ls70U2Z2Ccjb8OXD9IMGzYk0bObpPFy/2/4bvF4LcvyzKO6NlNt44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtdEoXt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BFFC4CEF7;
	Tue, 17 Mar 2026 14:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758807;
	bh=sscSoSFouV+BYtAMLCzJuJT4rVcrPZOmplb5c40nlDs=;
	h=Subject:To:Cc:From:Date:From;
	b=jtdEoXt6WBirUqiAn47L9dmYi7gOQLEudga7Lfq+0oqzplKb/FOWPpHwUtoPGXdW1
	 MG+fAl7FWFKdA9HOT16Lvd534ck+JQgW0XqaWUJzQ66aIj3A2vMJJGHY4H2RHls0Hd
	 ZQmlpCkhCqm5qz5u2zzcqCryGYwogy12L3tscTvc=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring dequeue" failed to apply to 5.15-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:46:28 +0100
Message-ID: <2026031728-preplan-unfunded-8460@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226057-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,nxp.com:email,intel.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: 9B7002AC91F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1dca8aee80eea76d2aae21265de5dd64f6ba0f09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031728-preplan-unfunded-8460@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


