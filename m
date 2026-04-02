Return-Path: <stable+bounces-233074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MhqJBukzmlZpAYAu9opvQ
	(envelope-from <stable+bounces-233074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:15:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C738C719
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA90F310C9DC
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0993921CD;
	Thu,  2 Apr 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPS1WL29"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A93363091
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149668; cv=none; b=dsAWNoA1uX6xlo+byNtzE+ZKXX79/R+PH/uqoKa+Bs9O/XkgCKr1HECwCV1HhBEU7Fh8sKjAqExNxQHo2v8kfS6qOtntul/yhT198Giwb5QS1IYWRDzhzntAlL8epCqpLyo/3cXONq6awruQp8q5tUvE1QMltLWsTNkkMeb/Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149668; c=relaxed/simple;
	bh=iboUIMrr4ZTwXaB6GUMUN1CNFh7FqDUbG1ISIooTYNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XMw7h5e0arF8HMnO2x+OqvGNDmct51k2elDZ/+Hsod2XAGL1CJUSMboifWmfjzMCRBFMBhysPTepa7I3m5d684++5EpdXR+KYTz4N+Kppd2yv3r7cx9/ZsVPioC8bW1z4kCCDXSr6BLcOfwBGa5uzcIG2O0/VeKy7ik5Ig8mytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPS1WL29; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so1597978a12.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775149661; x=1775754461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe/ZA3cS06JPwazJ5lT2X5nq3OydOwSen9aJipTvAo8=;
        b=jPS1WL29f9SHjnLowWyzlGHdFBOkTmMT5TYQQ2ay8qCl3RXGGXj7ZD2C5ihMdpdsEP
         rpDLedBTSkB12gZ567FyKnGS0pA/TomU8kTLOyAVWY3wxgy5uJPD8uNQiDVgrM+NOXpY
         puxEjssJaelwP+rtiOCvpIH5Il+rfuhAcoJ3goRIAg2DrsWOgJfD5V8j64zsod5TO7jG
         C3h5L23NQAPW+7FGUil0h3s0+pKLADFv6SsnPE9Gmg+00pLKmr2CJLvYCxSChzLRxhDd
         X+t1GnRbiea4kBpdAWtGC8wuBS64uhEm3kGABVViFYQmt1GdJZdMv+G4Rmy0kOWKSkQe
         /dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149661; x=1775754461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qe/ZA3cS06JPwazJ5lT2X5nq3OydOwSen9aJipTvAo8=;
        b=QwrICV6mL5ihGroVg/Jj04rkNLiynKLB8TLbY83KkFNf0c/k3TiS8pQ7hogDRpIhrd
         5hkthgVpKnTpRpG1+ydbob/1baf295k9XZZxik54eVUAe5K4/TAMc3wW4l9Ymd2ebKUF
         rnKelgvRWKtsmqyKOb1gZUMQlH1DPzG0Zd90hPZD9CnXPLFG4nIKfMe7ZgdZNBe8eeb3
         Fh08fCV8ri3HT/iUQgAWX3v6t8o/lr0DozlVlAPsVgMsLci76uHQa1/IJnd6/tE++MOY
         CbzUHQSGg0CTtKliP9HRpTXL6Na8ndYGlhqM8w1SUhRJTwrcbDaFMU49yeV1SyyQrvHq
         Ki6g==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ig9X1H++BDE/bcLkURq7bmg1Ig8hboUyVseUuyM2Msmd+IP5l5WzdPJWUb3dwMyAlpXk3kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCq+cSsMzCh9O1PRrPVHJyjTxmiDtPGrttJQ3/Q3bBK4OtM612
	EXZ7/2vOKENlCQ6snLw48gS0k+tWzhH9ej3NuRMFgDSeoUG7qad2OwaMHmiDh1JlfueSeSeU7xC
	zs2ocnP+HHvTacGTf/yyMWOhlVg==
X-Received: from pgww5.prod.google.com ([2002:a05:6a02:2c85:b0:c73:9919:c4f8])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a0:b0:398:98ab:71a8 with SMTP id adf61e73a8af0-39ef773e0a1mr9207386637.47.1775149661098;
 Thu, 02 Apr 2026 10:07:41 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:06:40 +0000
In-Reply-To: <20260402170641.2082547-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402170641.2082547-1-joonwonkang@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402170641.2082547-2-joonwonkang@google.com>
Subject: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com, 
	jonathanh@nvidia.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Joonwon Kang <joonwonkang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233074-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,collabora.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F28C738C719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/mailbox/mailbox.c          | 86 +++++++++++++++++++-----------
 drivers/mailbox/mtk-vcp-mailbox.c  |  2 +-
 drivers/mailbox/tegra-hsp.c        |  2 +-
 include/linux/mailbox_controller.h | 20 ++++---
 4 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 138ffbcd4fde..d63386468982 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -21,7 +21,7 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
+static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
 {
 	int idx;
 
@@ -32,7 +32,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 		return -ENOBUFS;
 
 	idx = chan->msg_free;
-	chan->msg_data[idx] = mssg;
+	chan->msg_data[idx].data = mssg;
+	chan->msg_data[idx].tx_complete = tx_complete;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -50,24 +51,33 @@ static void msg_submit(struct mbox_chan *chan)
 	int err = -EBUSY;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		if (!chan->msg_count || chan->active_req != MBOX_NO_MSG)
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
 
-		data = chan->msg_data[idx];
+			data = chan->msg_data[idx].data;
+			if (data != MBOX_NO_MSG)
+				break;
+
+			chan->msg_count--;
+		}
+
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
@@ -79,27 +89,35 @@ static void msg_submit(struct mbox_chan *chan)
 	}
 }
 
-static void tx_tick(struct mbox_chan *chan, int r)
+static void tx_tick(struct mbox_chan *chan, int r, int idx)
 {
-	void *mssg;
+	struct mbox_message mssg = {MBOX_NO_MSG, NULL};
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		mssg = chan->active_req;
-		chan->active_req = MBOX_NO_MSG;
+		if (idx >= 0 && idx != chan->active_req) {
+			chan->msg_data[idx].data = MBOX_NO_MSG;
+			chan->msg_data[idx].tx_complete = NULL;
+			return;
+		}
+
+		if (chan->active_req >= 0) {
+			mssg = chan->msg_data[chan->active_req];
+			chan->active_req = -1;
+		}
 	}
 
 	/* Submit next message */
 	msg_submit(chan);
 
-	if (mssg == MBOX_NO_MSG)
+	if (mssg.data == MBOX_NO_MSG)
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
@@ -112,10 +130,10 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req != MBOX_NO_MSG && chan->cl) {
+		if (chan->active_req >= 0 && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
-				tx_tick(chan, 0);
+				tx_tick(chan, 0, -1);
 			else
 				resched = true;
 		}
@@ -168,7 +186,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, -1);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
@@ -188,7 +206,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, -1);
 }
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
@@ -266,11 +284,19 @@ EXPORT_SYMBOL_GPL(mbox_chan_tx_slots_available);
 int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
+	int idx;
+	struct completion tx_complete;
 
 	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
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
@@ -287,10 +313,11 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
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
 
@@ -321,7 +348,7 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 
 	ret = chan->mbox->ops->flush(chan, timeout);
 	if (ret < 0)
-		tx_tick(chan, ret);
+		tx_tick(chan, ret, -1);
 
 	return ret;
 }
@@ -340,9 +367,8 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = MBOX_NO_MSG;
+		chan->active_req = -1;
 		chan->cl = cl;
-		init_completion(&chan->tx_complete);
 
 		if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
 			chan->txdone_method = TXDONE_BY_ACK;
@@ -498,7 +524,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = MBOX_NO_MSG;
+		chan->active_req = -1;
 		if (chan->txdone_method == TXDONE_BY_ACK)
 			chan->txdone_method = TXDONE_BY_POLL;
 	}
@@ -553,7 +579,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 
 		chan->cl = NULL;
 		chan->mbox = mbox;
-		chan->active_req = MBOX_NO_MSG;
+		chan->active_req = -1;
 		chan->txdone_method = txdone;
 		spin_lock_init(&chan->lock);
 	}
diff --git a/drivers/mailbox/mtk-vcp-mailbox.c b/drivers/mailbox/mtk-vcp-mailbox.c
index 1b291b8ea15a..a7bab06ac686 100644
--- a/drivers/mailbox/mtk-vcp-mailbox.c
+++ b/drivers/mailbox/mtk-vcp-mailbox.c
@@ -84,7 +84,7 @@ static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
 
 static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
 {
-	struct mtk_ipi_info *ipi_info = chan->active_req;
+	struct mtk_ipi_info *ipi_info = chan->msg_data[chan->active_req].data;
 	struct mtk_vcp_mbox *priv = chan->con_priv;
 
 	return !(readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index));
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 7b1e1b83ea29..efe0033cb5c5 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -495,7 +495,7 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != MBOX_NO_MSG)
+			if (chan->active_req >= 0)
 				continue;
 
 			return 0;
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index e3896b08f22e..912499ad08ed 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -113,16 +113,25 @@ struct mbox_controller {
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
@@ -130,10 +139,9 @@ struct mbox_chan {
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
2.53.0.1185.g05d4b7b318-goog


