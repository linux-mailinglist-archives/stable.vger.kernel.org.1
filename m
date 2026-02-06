Return-Path: <stable+bounces-214634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FsfN9m+hWnEFwQAu9opvQ
	(envelope-from <stable+bounces-214634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674DFC8C2
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DA5301910D
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E8364EBC;
	Fri,  6 Feb 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PSNPKyH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D232D7DE
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372822; cv=none; b=nlCOh+GQiLUmJGe07D2Ab0NI/y0HH3zwUo2XkHA83kJy9si6tN572T3SqhVzkBB76SM0eM1ospFnCfMsRrLyqDzRzJqLR1ElBziCejzKHIhAu4cakaEGl2Q+DLdZss9oes+fQjTzrwJME29za0HJ/koV2LMM5e98qYu6CNcv7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372822; c=relaxed/simple;
	bh=KYvVs86jpFGqET7KE++r/JCvZvSTDoSVsfghA8KCL24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YMlGtoJrbZLQ+sgCSlgl6xSkL+oSN3wxspFp4eSdfeqvrx67JiOEFYaIGPOlM41BuStLX/09qsNXCTqbY+8H6B+Fmm3YSlIKV9zICw962ZOqUkBakaKAZfPpT4c7hihBHXv9kcWGeugE0EBk6whrdU6Hmd6P4wB1up9gSS9+yOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PSNPKyH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3545dbb7ee6so1650808a91.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770372822; x=1770977622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8jOnXwPKl/fjBXLstxJ9vYgAS8HzUNg2s3m6R0efD4=;
        b=1PSNPKyHWPhXw1OmP+x89EMrrDVF59vVoKAWxFGqF5dWxmskltt8QKzHRwXmfsr7sp
         AKRwoAR2u3gW1QQHY+7BDJeVdMUqxRY6e1WdAmtaDbnz5CCuRf+OpyX/aBl3umGIieJW
         PqqaFelIZBdTYrRM7wltfEreyrxPXWohZEchu4fRS3CEYLN1s0Rv6tSLDWsMT8rgPohE
         QNaA9hHhfVjLEt/LCM23lpWg0cmsLEjgUeR/2rsUpNdChf2uWGUot+fIP+njxg+j2Cjd
         76vgWBRVGB+3Tl61LWh8tezy/lFSZWc09ss6cj6eqrms/Dj1xUr+l/602mBIfSUuTqXI
         oXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372822; x=1770977622;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8jOnXwPKl/fjBXLstxJ9vYgAS8HzUNg2s3m6R0efD4=;
        b=E0Hb3Nr5x6n/Dh3OZqzMHHKVXw8CU2aV0cEijjTxZejIXFwhyLxP/Gfinx99A8mxh5
         w6iOQ4VYj0xSK5Rln+0N+pbau0Spi9/ytCJnr9V1hHkJ/pQD/FEJSq6HbjONkmc3W66R
         7NIwPdL3dkWgg+zZv8NrZQCRUlrKW95zuQeWhpq0RN7LDxuV3Mx8b/97G/wkfXKytn1h
         GmyCxlnJMjjFc/Qmuv7HBO/989uOQNl5khYsP8QeWOWX/71EPZCDAAD82AcQMrtb/tiK
         fcE4OG+Af0p0vd0Mlq+jXY7woG8Jt/vq/0U0ZONKnmLpRjnivTWQMCgb2E2a9CSObZCl
         Sn3w==
X-Forwarded-Encrypted: i=1; AJvYcCUmJABHNvoP2bmhaMmG5LRUKnqYZhIg0tzKTHai9gW4kMVC/+U7b1iJ4Na5/r4ni9jrxSHKU7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFmDUZiFYoMJHPEKOepjxWmTwdVwUgAy72i7dMQ+F2se6P+qo
	Lz1/klzKf3ycLI56aifjUBLt61tf1pKDBIE6nMDmSZirpAO8Ip1WG9xTFnlQzix4IMU0mGnHAid
	iXZ3Br5jHldX9byLdbXAlNm//Jw==
X-Received: from pjso14.prod.google.com ([2002:a17:90a:c08e:b0:352:b687:3b20])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384d:b0:343:7714:4ca6 with SMTP id 98e67ed59e1d1-354b3cd821emr1827874a91.22.1770372822044;
 Fri, 06 Feb 2026 02:13:42 -0800 (PST)
Date: Fri,  6 Feb 2026 10:13:36 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206101336.4170728-1-joonwonkang@google.com>
Subject: [PATCH v2 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: alexey.klimov@arm.com, jonathanh@nvidia.com, joonwonkang@google.com, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org, sudeep.holla@arm.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,nvidia.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5674DFC8C2
X-Rspamd-Action: no action

Previously, a sender thread in mbox_send_message() could be woken up at
a wrong time in blocking mode. It is because there was only a single
completion for a channel whereas messages from multiple threads could be
sent in any order; since the shared completion could be signalled in any
order, it could wake up a wrong sender thread.

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
v1 -> v2: Considered the case where tx_tick() is called for a channel by
  a thread due to timeout while another thread has active request on the
  same channel. In that case, we mark that non-active request as canceled
  and do not send the request to the controller.

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

 drivers/mailbox/mailbox.c          | 87 ++++++++++++++++++++----------
 drivers/mailbox/tegra-hsp.c        |  2 +-
 include/linux/mailbox_controller.h | 20 ++++---
 3 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 617ba505691d..0af2f91132e0 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -20,10 +20,13 @@
 
 #include "mailbox.h"
 
+#define MBOX_DATA_CANCELED ((void *)0x01)
+#define MBOX_IDX_NOT_DESIGNATED -1
+
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
+static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
 {
 	int idx;
 
@@ -34,7 +37,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 		return -ENOBUFS;
 
 	idx = chan->msg_free;
-	chan->msg_data[idx] = mssg;
+	chan->msg_data[idx].data = mssg;
+	chan->msg_data[idx].tx_complete = tx_complete;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -52,24 +56,33 @@ static void msg_submit(struct mbox_chan *chan)
 	int err = -EBUSY;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		if (!chan->msg_count || chan->active_req)
+		if (chan->active_req >= 0)
 			break;
 
-		count = chan->msg_count;
-		idx = chan->msg_free;
-		if (idx >= count)
-			idx -= count;
-		else
-			idx += MBOX_TX_QUEUE_LEN - count;
+		while (chan->msg_count > 0) {
+			count = chan->msg_count;
+			idx = chan->msg_free;
+			if (idx >= count)
+				idx -= count;
+			else
+				idx += MBOX_TX_QUEUE_LEN - count;
+
+			data = chan->msg_data[idx].data;
+			if (data != MBOX_DATA_CANCELED)
+				break;
+
+			chan->msg_count--;
+		}
 
-		data = chan->msg_data[idx];
+		if (!chan->msg_count)
+			break;
 
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
@@ -81,27 +94,35 @@ static void msg_submit(struct mbox_chan *chan)
 	}
 }
 
-static void tx_tick(struct mbox_chan *chan, int r)
+static void tx_tick(struct mbox_chan *chan, int r, int idx)
 {
-	void *mssg;
+	struct mbox_message mssg = {NULL, NULL};
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		mssg = chan->active_req;
-		chan->active_req = NULL;
+		if (idx == MBOX_IDX_NOT_DESIGNATED || idx == chan->active_req) {
+			if (chan->active_req >= 0) {
+				mssg = chan->msg_data[chan->active_req];
+				chan->active_req = MBOX_IDX_NOT_DESIGNATED;
+			}
+		} else {
+			chan->msg_data[idx].data = MBOX_DATA_CANCELED;
+			chan->msg_data[idx].tx_complete = NULL;
+			return;
+		}
 	}
 
 	/* Submit next message */
 	msg_submit(chan);
 
-	if (!mssg)
+	if (!mssg.data)
 		return;
 
 	/* Notify the client */
 	if (chan->cl->tx_done)
-		chan->cl->tx_done(chan->cl, mssg, r);
+		chan->cl->tx_done(chan->cl, mssg.data, r);
 
 	if (r != -ETIME && chan->cl->tx_block)
-		complete(&chan->tx_complete);
+		complete(mssg.tx_complete);
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -114,10 +135,10 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req && chan->cl) {
+		if (chan->active_req >= 0 && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
-				tx_tick(chan, 0);
+				tx_tick(chan, 0, MBOX_IDX_NOT_DESIGNATED);
 			else
 				resched = true;
 		}
@@ -170,7 +191,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, MBOX_IDX_NOT_DESIGNATED);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
@@ -190,7 +211,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, MBOX_IDX_NOT_DESIGNATED);
 }
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
@@ -245,11 +266,19 @@ EXPORT_SYMBOL_GPL(mbox_client_peek_data);
 int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
+	int idx;
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
@@ -266,10 +295,11 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		else
 			wait = msecs_to_jiffies(chan->cl->tx_tout);
 
-		ret = wait_for_completion_timeout(&chan->tx_complete, wait);
+		ret = wait_for_completion_timeout(&tx_complete, wait);
 		if (ret == 0) {
+			idx = t;
 			t = -ETIME;
-			tx_tick(chan, t);
+			tx_tick(chan, t, idx);
 		}
 	}
 
@@ -300,7 +330,7 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	ret = chan->mbox->ops->flush(chan, timeout);
 	if (ret < 0)
-		tx_tick(chan, ret);
+		tx_tick(chan, ret, MBOX_IDX_NOT_DESIGNATED);
 
 	return ret;
 }
@@ -319,9 +349,8 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_IDX_NOT_DESIGNATED;
 		chan->cl = cl;
-		init_completion(&chan->tx_complete);
 
 		if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
 			chan->txdone_method = TXDONE_BY_ACK;
@@ -477,7 +506,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_IDX_NOT_DESIGNATED;
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
2.53.0.rc2.204.g2597b5adb4-goog


