Return-Path: <stable+bounces-253481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN17IhPLDmovCQYAu9opvQ
	(envelope-from <stable+bounces-253481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:06:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 242205A1DA2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D78743038943
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7836DA15;
	Thu, 21 May 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+7hS1gM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD33546F7
	for <stable@vger.kernel.org>; Thu, 21 May 2026 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354282; cv=none; b=aOJae+uEh81ZYriX4n7cldnxb1qDjmKgbgdLqB3oyelW2ZQSFxuQeRAvcD2NStErb0crXtJGJROd13lR3q1ai2C89o5QDj4wRw5qOy2s3ulXY4+7LkBruUAl3D1Xljgau1Oh9HVkgkMbSAY6Txhw5M4r4UTfDmeJL9mAtglInFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354282; c=relaxed/simple;
	bh=+dwTK0cuHhjwGvIjWknGmhW347ji5Nq6ak300K4ZR0U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iM27rh61gcqU9EqP2XPOWaNnxpqVE0Xrz7QqkfZ2ujLnWc2H4dP+DuYkyFNkOwrz4prgCKx9H+jz2QRo1litfMUpj1XqKSzyWtY+yrj3KBY93mbPDxLhW1QNPSfvJ6E/aBsPWjmLitemK+YAWIVLBQPhoAEuccI0TEQKwSi9jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+7hS1gM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8292e18166so3030090a12.3
        for <stable@vger.kernel.org>; Thu, 21 May 2026 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779354279; x=1779959079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yAR4jGfkO1axcbCYTzSG39vOuVG5Rz/bo7M1T3CVqPQ=;
        b=J+7hS1gMA/KSRTV6KXRwLOSCmj0OBoeloMh7n4Ow0ilVQ/Ded8W3BF4b6eiLXa8oUJ
         2fqXRe7qBARdr70uxmLsX083cJ7QhHaPxBI8Uo43RXmHm2cKKjzO6VDSXweUCVpwguPW
         o5boZLPvJ3YZY+bZj74Vp5UeYU3yoS+sgeVFwnLVTHPpB9UQ59d8pGAPdFwXhPqYPlih
         AxjY6+m7vPfAihWKZTlUyE+/jy0a+ziPZPkgtqkoGSPXY6AN4VtiX6ntCX94t/tk9m5f
         u6OtemoxD9+MmP1ZZDfmozsFYqmwrVsGD/+AT/b+FW9shZSNua7T1JhQ8UhtmiEVI9CW
         jw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779354279; x=1779959079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAR4jGfkO1axcbCYTzSG39vOuVG5Rz/bo7M1T3CVqPQ=;
        b=Bg+iGPn6XulFWkWP+4+ydvRepDvapj98cW+84gl8MDB9M5d56vZyf1uak600wnCFi7
         CoflqwUwuAXIL/dMUjeZBB+WdWSprukzkKVu0t+FwyPR4Yzib8aJjFoX50lst0oK5UvS
         6DVVMSmebo1SLnGtXHCH0tKwvPkFaTYDinUOxLQsnNYQZwaYFN1Bln9Rk6MKhOBc8F0n
         K3gqVSh9CW5fkZzLhuTPjOdocDeZLe+ylwk9qswbJiK82HuRkLb/bwwu3lrOQ8CLaIBt
         R2fyy0W5rkyNhJMcEI4Z2M7+Dohw5MNRSN6P52RQmdzLw+2MHZp+E1oAQx9sl61jFfvW
         aEzA==
X-Forwarded-Encrypted: i=1; AFNElJ/rNyAnFsc+ygscHi5gsVpriPbXRiGeARQWhOu0Wr5xNEGBZCxZDVk8boosf2GRytlvkqZQum4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxBmERpKvksW2xC1bvnIz+F4pqlSOolqaAUcDv/DcaPHuA/9f
	oTploZ3oUDzJttbZ8PE/2aFsmfATM4BSH5H9NeYF3ILTtZhKIiKw5Q4hQY/V4+6lOyfYLYO9yNE
	KUgfjJbxkvIzpNHFPxk0GlX0tjg==
X-Received: from pfblx15.prod.google.com ([2002:a05:6a00:754f:b0:82f:7833:9aa9])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d1d:b0:3a2:ebfc:6bf3 with SMTP id adf61e73a8af0-3b30885a83cmr2492228637.29.1779354278650;
 Thu, 21 May 2026 02:04:38 -0700 (PDT)
Date: Thu, 21 May 2026 09:04:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521090433.1353240-1-joonwonkang@google.com>
Subject: [PATCH RESEND v6.12.y] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: sashal@kernel.org, stable@vger.kernel.org, jassisinghbrar@gmail.com, 
	greg@kroah.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	joonwonkang@google.com, dianders@chromium.org, sudeep.holla@arm.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,google.com,chromium.org,arm.com];
	TAGGED_FROM(0.00)[bounces-253481-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,kroah.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Queue-Id: 242205A1DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jassi Brar <jassisinghbrar@gmail.com>

commit c58e9456e30c ("mailbox: Fix NULL message support in mbox_send_message()") upstream.

The active_req field serves double duty as both the "is a TX in
flight" flag (NULL means idle) and the storage for the in-flight
message pointer. When a client sends NULL via mbox_send_message(),
active_req is set to NULL, which the framework misinterprets as
"no active request". This breaks the TX state machine by:

 - tx_tick() short-circuits on (!mssg), skipping the tx_done
   callback and the tx_complete completion
 - txdone_hrtimer() skips the channel entirely since active_req
   is NULL, so poll-based TX-done detection never fires.

Fix this by introducing a MBOX_NO_MSG sentinel value that means
"no active request," freeing NULL to be valid message data. The
sentinel is defined in the subsystem-internal mailbox.h so that
controller drivers within drivers/mailbox/ can reference it, but
it is not exposed to clients outside the subsystem.

Fifteen in-tree callers send NULL (doorbell-style IPCs on Qualcomm,
Tegra, TI, Xilinx, i.MX, SCMI, and PCC platforms). All were
audited for regression:

 - Most already work around the bug via knows_txdone=true with a
   manual mbox_client_txdone() call, making the framework's
   tracking irrelevant. These are unaffected.

 - Poll-based callers (Xilinx zynqmp/r5) are strictly better off:
   the poll timer now correctly detects NULL-active channels
   instead of silently skipping them.

 - irq-qcom-mpm.c was a pre-existing bug -- the only Qualcomm
   caller that omitted the knows_txdone + mbox_client_txdone()
   pattern. Fixed in a companion commit ("irqchip/qcom-mpm: Fix
   missing mailbox TX done acknowledgment").

 - No caller sets both a tx_done callback and sends NULL, nor
   combines tx_block=true with NULL sends, so the newly reachable
   callback/completion paths are never exercised.

Also update tegra-hsp's flush callback, which directly inspects
active_req to wait for the channel to drain: the old "!= NULL"
check becomes "!= MBOX_NO_MSG", otherwise flush spins until
timeout since the sentinel is non-NULL.

The only tradeoff is that 'MBOX_NO_MSG' can not be used as a message
by clients.

Reported-by: Joonwon Kang <joonwonkang@google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c          | 15 ++++++++-------
 drivers/mailbox/tegra-hsp.c        |  2 +-
 include/linux/mailbox_controller.h |  3 +++
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index b4d52b814055..383c54d353ee 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -59,7 +59,7 @@ static void msg_submit(struct mbox_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
+	if (!chan->msg_count || chan->active_req != MBOX_NO_MSG)
 		goto exit;
 
 	count = chan->msg_count;
@@ -97,13 +97,13 @@ static void tx_tick(struct mbox_chan *chan, int r)
 
 	spin_lock_irqsave(&chan->lock, flags);
 	mssg = chan->active_req;
-	chan->active_req = NULL;
+	chan->active_req = MBOX_NO_MSG;
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
 	msg_submit(chan);
 
-	if (!mssg)
+	if (mssg == MBOX_NO_MSG)
 		return;
 
 	/* Notify the client */
@@ -125,7 +125,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req && chan->cl) {
+		if (chan->active_req != MBOX_NO_MSG && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
@@ -257,7 +257,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
 
-	if (!chan || !chan->cl)
+	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
 		return -EINVAL;
 
 	t = add_to_rbuf(chan, mssg);
@@ -331,7 +331,7 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->msg_free = 0;
 	chan->msg_count = 0;
-	chan->active_req = NULL;
+	chan->active_req = MBOX_NO_MSG;
 	chan->cl = cl;
 	init_completion(&chan->tx_complete);
 
@@ -492,7 +492,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	spin_lock_irqsave(&chan->lock, flags);
 	chan->cl = NULL;
-	chan->active_req = NULL;
+	chan->active_req = MBOX_NO_MSG;
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
@@ -549,6 +549,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 
 		chan->cl = NULL;
 		chan->mbox = mbox;
+		chan->active_req = MBOX_NO_MSG;
 		chan->txdone_method = txdone;
 		spin_lock_init(&chan->lock);
 	}
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 76f54f8b6b6c..8ef8b444de61 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -497,7 +497,7 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != NULL)
+			if (chan->active_req != MBOX_NO_MSG)
 				continue;
 
 			return 0;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index b91379922cb3..1689031c58c9 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -11,6 +11,9 @@
 
 struct mbox_chan;
 
+/* Sentinel value distinguishing "no active request" from "NULL message data" */
+#define MBOX_NO_MSG	((void *)-1)
+
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
  * @send_data:	The API asks the MBOX controller driver, in atomic
-- 
2.54.0.746.g67dd491aae-goog


