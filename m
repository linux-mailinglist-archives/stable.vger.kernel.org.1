Return-Path: <stable+bounces-214635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDCnHBy/hWnEFwQAu9opvQ
	(envelope-from <stable+bounces-214635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:14:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDFFC8E1
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E957302881E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD31361644;
	Fri,  6 Feb 2026 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOCuBbrs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2E2FDC47
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372884; cv=none; b=MILCQ1gEvgDfbD852RLiYQk0tK5CEX9IyI6BFd0cW6nnx+o5QEU+CwGBta6ibC+OSuOvNHc2afb2HUBwWqbqpgjwhkeePmJI2WHRSBSf/DmXtlA9d/uzmgYEmiLJRtKu5T5D0ubR6uRy3hCKBAv1qbf99QwgKq8FrK5JyWxtIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372884; c=relaxed/simple;
	bh=S80eEenF23Jlftx8Nb2GoLHh0cNpf0uICWbwA4J24oU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RBakvgsfFfNjtlLoJDm/nV3UOypS18Wl2sOEOAzaT0FZ4/sENR5fbDrLnXcc1NySVW16tlSE7J8OT6d4PIObGfh+/k2oGzXgiz/nj4gcztkiOt0FawpDM5x6IUcl0CDf5cU+NFZwBU558S+f8/1ReVe1A6leY+1Al+jEmik9OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOCuBbrs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso366307a12.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770372883; x=1770977683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zs6k6Yg8dxvKjSPzGnO8E07vhqHgQ2Yo/nScR5UofAg=;
        b=hOCuBbrsdLyflv/pru3Pe2vzNhCKb+u37HwQzKPx0jQIl7OPu5uzDA30ejDWsxqiMc
         NaZbOpMcfqHjGf7OYlcfxas3LE+Hh/i/6y8mffKx6e4LTxmLLCj2fAIE5/ewmfMeJnVh
         DoTnLz9Zv8mYbNHH5mQe/rhBcRwZAFvk3qu2gaqmhkioOmLpln1rwP/DCrUaZuu42eOc
         +hUoDlvENUWIz+KiUxk0k/lSEnmpwIHSDnjVBOVHKXNdUE/ALqdxa6Yp+3HiSOtcGVwM
         5SdDBPp4NOYyTMHUZsJwPLtDn+L6RWKk6HAq2U7Cb0wRgW3Q2+HCSSLLbNwEENfLqoS4
         uM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372883; x=1770977683;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs6k6Yg8dxvKjSPzGnO8E07vhqHgQ2Yo/nScR5UofAg=;
        b=dtj3jq2Bgd+3ByWenG2b3zs06rFf93Y3Y7vGjPaatxw0x/lfPf9754l22OCFHwyOBL
         ebRM/t0J8XdFY8vrGyeYJywtehMdhNci2R1yUWfqOteB37JtOr7Aa8HR4JZ6ke+90M0K
         C+7LznNHo6ulcPobiC2pc6JlN4EUlZCLucUBV1qw/1aK2BC2FvyPYTEI1LdRaVn7NbUf
         YCEwNDcghGj9p9w0h5psOMGOsHnbcpiPXwL31C6VEOCQoowQaSQVBZxaLjlaQkOPvayH
         iRW9hkIwi6fkcMQCWWfTZGfPJ7C1S2EBNfWmysgvhqT5AIhgJVeaCl/RyXPN8R5r1h3c
         fLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBpHnnqBC4SubrkjlfC92HVrXeE+TpVnsczr/eAH0zoyxIMqOVKpIZVK0AIvkm+7NLTL6fqj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzviDRSkjCyLFa7DJbf3w0i9HDdewTjKOJfgkGrmTCWm5OA4ntj
	ed3VqabJaj1ywpay2VFYigOFYXRbQQQVFNpxk00X9hdGUkcVgcV/Me1IUCq5KAEqLaAQmZjITYm
	ZOiy8z/TfSL7hAFKlvNHbSlVlcg==
X-Received: from pguz16.prod.google.com ([2002:a65:6110:0:b0:bd9:a349:94bb])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2211:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-393acf58258mr2466129637.12.1770372883313;
 Fri, 06 Feb 2026 02:14:43 -0800 (PST)
Date: Fri,  6 Feb 2026 10:14:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206101440.4171445-1-joonwonkang@google.com>
Subject: [PATCH v2 2/2] mailbox: Make mbox_send_message() return error code
 when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: joonwonkang@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214635-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5BDFFC8E1
X-Rspamd-Action: no action

When the mailbox controller failed transmitting message, the error code
was only passed to the client's tx done handler and not to
mbox_send_message(). For this reason, the function could return a false
success. This commit resolves the issue by introducing the tx status and
checking it before mbox_send_message() returns.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
v1 -> v2: No major change.

 drivers/mailbox/mailbox.c          | 20 +++++++++++++++-----
 include/linux/mailbox_controller.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0af2f91132e0..ed1b405a2999 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -26,7 +26,10 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
+static int add_to_rbuf(struct mbox_chan *chan,
+		       void *mssg,
+		       struct completion *tx_complete,
+		       int *tx_status)
 {
 	int idx;
 
@@ -39,6 +42,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx
 	idx = chan->msg_free;
 	chan->msg_data[idx].data = mssg;
 	chan->msg_data[idx].tx_complete = tx_complete;
+	chan->msg_data[idx].tx_status = tx_status;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -96,7 +100,7 @@ static void msg_submit(struct mbox_chan *chan)
 
 static void tx_tick(struct mbox_chan *chan, int r, int idx)
 {
-	struct mbox_message mssg = {NULL, NULL};
+	struct mbox_message mssg = {NULL, NULL, NULL};
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		if (idx == MBOX_IDX_NOT_DESIGNATED || idx == chan->active_req) {
@@ -107,6 +111,7 @@ static void tx_tick(struct mbox_chan *chan, int r, int idx)
 		} else {
 			chan->msg_data[idx].data = MBOX_DATA_CANCELED;
 			chan->msg_data[idx].tx_complete = NULL;
+			chan->msg_data[idx].tx_status = NULL;
 			return;
 		}
 	}
@@ -121,8 +126,10 @@ static void tx_tick(struct mbox_chan *chan, int r, int idx)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg.data, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		*mssg.tx_status = r;
 		complete(mssg.tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -268,15 +275,16 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 	int t;
 	int idx;
 	struct completion tx_complete;
+	int tx_status = 0;
 
 	if (!chan || !chan->cl)
 		return -EINVAL;
 
 	if (chan->cl->tx_block) {
 		init_completion(&tx_complete);
-		t = add_to_rbuf(chan, mssg, &tx_complete);
+		t = add_to_rbuf(chan, mssg, &tx_complete, &tx_status);
 	} else {
-		t = add_to_rbuf(chan, mssg, NULL);
+		t = add_to_rbuf(chan, mssg, NULL, NULL);
 	}
 
 	if (t < 0) {
@@ -300,6 +308,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 			idx = t;
 			t = -ETIME;
 			tx_tick(chan, t, idx);
+		} else if (tx_status < 0) {
+			t = tx_status;
 		}
 	}
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 67e08a440f5f..6929774d3129 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -109,10 +109,12 @@ struct mbox_controller {
  * struct mbox_message - Internal representation of a mailbox message
  * @data:		Data packet
  * @tx_complete:	Pointer to the transmission completion
+ * @tx_status:		Pointer to the transmission status
  */
 struct mbox_message {
 	void *data;
 	struct completion *tx_complete;
+	int *tx_status;
 };
 
 /**
-- 
2.53.0.rc2.204.g2597b5adb4-goog


