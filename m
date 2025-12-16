Return-Path: <stable+bounces-201152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63918CC19E7
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECB9A300B309
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AE313E00;
	Tue, 16 Dec 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMQElSWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB62C0F7D
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874637; cv=none; b=E7/DMCMSQuDe1lcfusoJsGfcrcaqKiyEsET9MpBx8791JPX8l7VlgEl8cRqG5Re9MWnQ3DmgccWoPLoi2uZDjlWKCxQwqelpeDwr9erUM6D4P8iY9Sc/g2/l/oRG8QixFc1QrXr7maRW5YtELZar/Zwb9uZpihn0t0KHJ4OKxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874637; c=relaxed/simple;
	bh=sVE2uy1lfgD1T3yf8ycnp+3UiXq4hxYh/F0gCRqGTrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IVYDZsIG7P7OFUHixNuxgGuenfYDFJPT15uNzchNW07YjWf/Mwh02N8ROWPM4B0jeQgsE4JVcm48Djy+RWkJCJJ+iP+8JcbrL78TbNdiQvy3xLdnSaWl1Gq3zpZw6Bp1wXbxSBqTG+8V8sdGMoyvVkAd5jGRmEDVAGpR3u2w7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMQElSWo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9208e1976so8067764b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 00:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765874634; x=1766479434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3YwVFuyayREOqPduUup4CfMPIb0E9MpA8gNuOyoTCFw=;
        b=CMQElSWoBC9jqUn5u9uW2K+Ql/symas4KVB50xZj2HQYWlEtPPKQ9eg/FhqebJUbDZ
         dlydfXbt3YirBFNlTHtpE5p613GSqIJTyVTUIbqaoAwQS8ZC8x2W9qaH9trHW2YocJ5j
         js1xwZSub60dOY95WOyprjoxKk99UViGLZ6Hkvl0i2/fgPBneq6chtEPvdsBsTVwhif+
         Vr5i3sbPlTLDCDgqcmxc+kno7mMUiRqUv8aXc/hMY/SLRvoGL69fHuyTTHsM1ntJI9IC
         TsqgIe22fDKj7cxQ8tF8WNJo5kY26kpDJL6CqmJ2aSMJq3HLkqz6pHPd4yMZ/fHBcnQd
         r83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874634; x=1766479434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YwVFuyayREOqPduUup4CfMPIb0E9MpA8gNuOyoTCFw=;
        b=wv36fCov+Hy8VT/0EpzOhFXPp4tMzVDrkNKxJB7e1gae8yMQQIgA2y371CYs8fi5GN
         FwNv6r17Sxcskm0cwxQ7Qv/KFtbSyi68xDgLDuwAPn8XkJtOePL2GHxqh9eqmdE2mND/
         P3D8xIfK0qpVTjbBIByIDRCsJ1h8G1zQAPAZnsz8OSoMi4MZr0U/0ZZERDa/LwYuP/Cg
         1oRXUl/GX2VQ29bTCPBpl8s9qaguh3UhT955bUrtbd+TASLgTfDIw5HNCjDJeuYaLDXe
         +/oPNq8q4ItSEJoOjlZY5dnA42sYZZnoKdBhKIMKDX1r/xXvuPotmhIr0plCv36MZq9A
         Io1w==
X-Forwarded-Encrypted: i=1; AJvYcCXciJc+QdZPw8d1hy1azMRFCF8LJDsV1DCM+0ZZXUB9e+YoKATadVU0CIcj5WNY0XHVDZvqaGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCN5Lv5T2H6Bn6E4CTpVgmgBqy0SEz7ST17cQ3cClH0RW2cky
	+oQz8VSV3JETG4s9+oMuBhqufxRb4Tti0ALTWvQ66Q5iqZJNHX/LUtm1fRu6zV+yWjjn/AF1r5p
	vZq7/FGCqJQaZDR9Ep70Rh290gQ==
X-Google-Smtp-Source: AGHT+IEUK2E5WQWmckQII0liTKhGV27vc1qIeabtLP5TEhd2IumLLhVtg0DI/Adfpvx5Jx75V4rso5xYin8rXonE3Q==
X-Received: from pfbjc37.prod.google.com ([2002:a05:6a00:6ca5:b0:7dd:8bba:638c])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4304:b0:7e8:4398:b35f with SMTP id d2e1a72fcca58-7f66969f83dmr12436525b3a.50.1765874634535;
 Tue, 16 Dec 2025 00:43:54 -0800 (PST)
Date: Tue, 16 Dec 2025 08:43:34 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251216084334.903376-1-joonwonkang@google.com>
Subject: [PATCH 1/2 RESEND] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: thierry.reding@gmail.com, alexey.klimov@arm.com, sudeep.holla@arm.com, 
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Joonwon Kang <joonwonkang@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, a sender thread in mbox_send_message() could be woken up at
a wrong time in blocking mode. It is because there was only a single
completion for a channel whereas messages from multiple threads could be
sent on the same channel in any order; since the shared completion could
be signalled in any order, it could wake up a wrong sender thread.

This commit resolves the false wake-up issue with the following changes:
- Completions are created just as many as the number of concurrent sender
  threads
- A completion is created on a sender thread's stack
- Each slot of the message queue, i.e. `msg_data`, contains a pointer to
  its target completion
- tx_tick() signals the completion of the currently active slot of the
  message queue

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/1490809381-28869-1-git-send-email-jaswinder.singh@linaro.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
Link -> v1: The previous solution in the Link tries to have per-message
  completion: `tx_cmpl[MBOX_TX_QUEUE_LEN]`; each completion belongs to
  each slot of the message queue: `msg_data[i]`. Those completions take
  up additional memory even when they are not used. Instead, this patch
  tries to have per-"thread" completion; each completion belongs to each
  sender thread and each slot of the message queue has a pointer to that
  completion; `struct mbox_message` has the "pointer" field
  `struct completion *tx_complete` which points to the completion which
  is created on the stack of the sender, instead of owning the completion
  by `struct completion tx_complete`. This way, we could avoid additional
  memory use since a completion will be allocated only when necessary.
  Plus, more importantly, we could avoid the window where the same
  completion is reused by different sender threads which the previous
  solution still has.

 drivers/mailbox/mailbox.c          | 43 +++++++++++++++++++-----------
 drivers/mailbox/tegra-hsp.c        |  2 +-
 include/linux/mailbox_controller.h | 20 +++++++++-----
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 617ba505691d..0afe3ae3bfdc 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -23,7 +23,7 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
+static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
 {
 	int idx;
 
@@ -34,7 +34,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 		return -ENOBUFS;
 
 	idx = chan->msg_free;
-	chan->msg_data[idx] = mssg;
+	chan->msg_data[idx].data = mssg;
+	chan->msg_data[idx].tx_complete = tx_complete;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -52,7 +53,7 @@ static void msg_submit(struct mbox_chan *chan)
 	int err = -EBUSY;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		if (!chan->msg_count || chan->active_req)
+		if (!chan->msg_count || chan->active_req >= 0)
 			break;
 
 		count = chan->msg_count;
@@ -62,14 +63,14 @@ static void msg_submit(struct mbox_chan *chan)
 		else
 			idx += MBOX_TX_QUEUE_LEN - count;
 
-		data = chan->msg_data[idx];
+		data = chan->msg_data[idx].data;
 
 		if (chan->cl->tx_prepare)
 			chan->cl->tx_prepare(chan->cl, data);
 		/* Try to submit a message to the MBOX controller */
 		err = chan->mbox->ops->send_data(chan, data);
 		if (!err) {
-			chan->active_req = data;
+			chan->active_req = idx;
 			chan->msg_count--;
 		}
 	}
@@ -83,11 +84,17 @@ static void msg_submit(struct mbox_chan *chan)
 
 static void tx_tick(struct mbox_chan *chan, int r)
 {
-	void *mssg;
+	int idx;
+	void *mssg = NULL;
+	struct completion *tx_complete = NULL;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		mssg = chan->active_req;
-		chan->active_req = NULL;
+		idx = chan->active_req;
+		if (idx >= 0) {
+			mssg = chan->msg_data[idx].data;
+			tx_complete = chan->msg_data[idx].tx_complete;
+			chan->active_req = -1;
+		}
 	}
 
 	/* Submit next message */
@@ -101,7 +108,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
 	if (r != -ETIME && chan->cl->tx_block)
-		complete(&chan->tx_complete);
+		complete(tx_complete);
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -114,7 +121,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req && chan->cl) {
+		if (chan->active_req >= 0 && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
@@ -245,11 +252,18 @@ EXPORT_SYMBOL_GPL(mbox_client_peek_data);
 int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
+	struct completion tx_complete;
 
 	if (!chan || !chan->cl)
 		return -EINVAL;
 
-	t = add_to_rbuf(chan, mssg);
+	if (chan->cl->tx_block) {
+		init_completion(&tx_complete);
+		t = add_to_rbuf(chan, mssg, &tx_complete);
+	} else {
+		t = add_to_rbuf(chan, mssg, NULL);
+	}
+
 	if (t < 0) {
 		dev_err(chan->mbox->dev, "Try increasing MBOX_TX_QUEUE_LEN\n");
 		return t;
@@ -266,7 +280,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		else
 			wait = msecs_to_jiffies(chan->cl->tx_tout);
 
-		ret = wait_for_completion_timeout(&chan->tx_complete, wait);
+		ret = wait_for_completion_timeout(&tx_complete, wait);
 		if (ret == 0) {
 			t = -ETIME;
 			tx_tick(chan, t);
@@ -319,9 +333,8 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = NULL;
+		chan->active_req = -1;
 		chan->cl = cl;
-		init_completion(&chan->tx_complete);
 
 		if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
 			chan->txdone_method = TXDONE_BY_ACK;
@@ -477,7 +490,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = NULL;
+		chan->active_req = -1;
 		if (chan->txdone_method == TXDONE_BY_ACK)
 			chan->txdone_method = TXDONE_BY_POLL;
 	}
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index ed9a0bb2bcd8..de7494ce0a9f 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -497,7 +497,7 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != NULL)
+			if (chan->active_req >= 0)
 				continue;
 
 			return 0;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 80a427c7ca29..67e08a440f5f 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -105,16 +105,25 @@ struct mbox_controller {
  */
 #define MBOX_TX_QUEUE_LEN	20
 
+/**
+ * struct mbox_message - Internal representation of a mailbox message
+ * @data:		Data packet
+ * @tx_complete:	Pointer to the transmission completion
+ */
+struct mbox_message {
+	void *data;
+	struct completion *tx_complete;
+};
+
 /**
  * struct mbox_chan - s/w representation of a communication chan
  * @mbox:		Pointer to the parent/provider of this channel
  * @txdone_method:	Way to detect TXDone chosen by the API
  * @cl:			Pointer to the current owner of this channel
- * @tx_complete:	Transmission completion
- * @active_req:		Currently active request hook
+ * @active_req:		Index of the currently active slot in the queue
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
- * @msg_data:		Hook for data packet
+ * @msg_data:		Queue of data packets
  * @lock:		Serialise access to the channel
  * @con_priv:		Hook for controller driver to attach private data
  */
@@ -122,10 +131,9 @@ struct mbox_chan {
 	struct mbox_controller *mbox;
 	unsigned txdone_method;
 	struct mbox_client *cl;
-	struct completion tx_complete;
-	void *active_req;
+	int active_req;
 	unsigned msg_count, msg_free;
-	void *msg_data[MBOX_TX_QUEUE_LEN];
+	struct mbox_message msg_data[MBOX_TX_QUEUE_LEN];
 	spinlock_t lock; /* Serialise access to the channel */
 	void *con_priv;
 };
-- 
2.52.0.239.gd5f0c6e74e-goog


