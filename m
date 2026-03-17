Return-Path: <stable+bounces-226054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGG8BnNsuWl6EgIAu9opvQ
	(envelope-from <stable+bounces-226054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:00:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D042AC92E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D63EC305CE33
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B13E716E;
	Tue, 17 Mar 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FYFRXCPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B726F2AD
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758790; cv=none; b=LqTL35p4cWeHr1O5ydJEeVzYKrmTg+b+U+uPvnjys/mtF6+HLinoXnYJI26OUi7T8smqdMp06hGkZDhbjEz7Y+8Tb3T0304UbpKzVh9tFIjE7yU1aLyJNoaFErDD4UIGJm/La8sdXyu40/cmI8NweIXRjGTL2LSCGSBNKUd2R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758790; c=relaxed/simple;
	bh=OKDCEZggkbqWhCO6M4qE684bpU3qrYmHavvRYKUEYLc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZvgnOUnvb+yf4XeOnmC66wTHDt8sdY0qBomE8vgtiwezcZOniifCIO60HoQuqM1zwqXqOx0cI5Y6EmQsky/q7tL5yI1F+sKV9lnx3ADFJVAlVDqkxLsiGuC4REV3avuxVlquX9IZx8JvMZ5I3751CBb84kKswTrsYe5tXU78YcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FYFRXCPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D22C4CEF7;
	Tue, 17 Mar 2026 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773758790;
	bh=OKDCEZggkbqWhCO6M4qE684bpU3qrYmHavvRYKUEYLc=;
	h=Subject:To:Cc:From:Date:From;
	b=FYFRXCPuJIpQPmT/J/bjBRWlQqbFusaWmC29gojJ/0mxgWxxpUUC6DTm5rQaeUahw
	 2GEBc3qWjxGkTGdIBFT+cw9d7watyP97HBzVBl7+l+T7JBHgpgmPMJJkY4tO1bY9ci
	 g3/TeVOP+2xV7hEOPPIR01zCdxXlcpn7jjmOthig=
Subject: FAILED: patch "[PATCH] i3c: mipi-i3c-hci: Fix race in DMA ring dequeue" failed to apply to 6.12-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 15:46:26 +0100
Message-ID: <2026031726-compactor-cosponsor-800d@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226054-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,bootlin.com:email]
X-Rspamd-Queue-Id: B2D042AC92E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1dca8aee80eea76d2aae21265de5dd64f6ba0f09
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031726-compactor-cosponsor-800d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


