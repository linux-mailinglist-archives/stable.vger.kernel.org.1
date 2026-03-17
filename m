Return-Path: <stable+bounces-226849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOfgGjuPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:28:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E82AFA04
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 392513025E5F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44E37419E;
	Tue, 17 Mar 2026 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cG4G99DM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD9372ED3;
	Tue, 17 Mar 2026 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768465; cv=none; b=ABKj3xRziXI66ohbsPJbsFGpjFBqNmgf3/3MQkMvGtnPZ8S3D6AWNiwGJ9ths5xaYfNazmcm17J74uUj98W17Mfz4BIwjhktjSmPORz1gW46j5oPPI8lkP0nr0+faMOJrPKhnFr9o8wt3K6gwg6nwYUNv2OsfGS2U4/uIJqRp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768465; c=relaxed/simple;
	bh=IDuIDW7lYcA9Q6fiTWbpNa2xnqq6QkEjHux+/ZU2F0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqu0/5hPNMMpeAsFn7iNE7PG1RUZlbv6xQg6M9AJkvD6rml57IVJYc6YmBQs5BVf8Bk47vbdH22A78jm9hjxo9QqrTKIQtInCNhT/qD1awlMUTqkXlrdWF3e+1/Qnp8gE/7nMMmHoj8IYlK2Xj57vkuuYF82xOTxDM+ezX5OgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cG4G99DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730A6C2BC86;
	Tue, 17 Mar 2026 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768465;
	bh=IDuIDW7lYcA9Q6fiTWbpNa2xnqq6QkEjHux+/ZU2F0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cG4G99DM6Ppu5qcFFWjZEIU1P0FuiodrpHPp4nkarx0THqY+tLpth0/PdmU0G+TYX
	 S3GFPYsWbO6ruf8UoB1X9uYYsMPbQy7In9rCB2hUiRbwID5hIbFLBGYt6J0TI7slg7
	 9FmlPchdjjdgFag2ttQ0Qh6LC0zeWhANe9Y8r0No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.18 313/333] i3c: mipi-i3c-hci: Fix race in DMA ring dequeue
Date: Tue, 17 Mar 2026 17:35:42 +0100
Message-ID: <20260317163010.990995942@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226849-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,nxp.com:email,bootlin.com:email]
X-Rspamd-Queue-Id: E20E82AFA04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 1dca8aee80eea76d2aae21265de5dd64f6ba0f09 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master/mipi-i3c-hci/core.c |    1 +
 drivers/i3c/master/mipi-i3c-hci/dma.c  |    2 ++
 drivers/i3c/master/mipi-i3c-hci/hci.h  |    1 +
 3 files changed, 4 insertions(+)

--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -632,6 +632,7 @@ static int i3c_hci_init(struct i3c_hci *
 		return ret;
 
 	spin_lock_init(&hci->lock);
+	mutex_init(&hci->control_mutex);
 
 	/*
 	 * Now let's reset the hardware.
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -486,6 +486,8 @@ static bool hci_dma_dequeue_xfer(struct
 	unsigned int i;
 	bool did_unqueue = false;
 
+	guard(mutex)(&hci->control_mutex);
+
 	/* stop the ring */
 	rh_reg_write(RING_CONTROL, RING_CTRL_ABORT);
 	if (wait_for_completion_timeout(&rh->op_done, HZ) == 0) {
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -46,6 +46,7 @@ struct i3c_hci {
 	void *io_data;
 	const struct hci_cmd_ops *cmd;
 	spinlock_t lock;
+	struct mutex control_mutex;
 	atomic_t next_cmd_tid;
 	u32 caps;
 	unsigned int quirks;



