Return-Path: <stable+bounces-201153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D9FCC1A56
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5ACB30145B3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5A314A8D;
	Tue, 16 Dec 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOpZvIrj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523231355E
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765874688; cv=none; b=LgqPt5/6Qz++Tgc5/GrSgkeKjPbBQzOkW39r+FRpjtDKP/9mWRHFoU5W4K8Id0+04Eoc0y1Upqdd4w7BYa5CSWVq5oeukbrQLs1otyieSFaxfvpSurdZAq9z4GAYmaMs4qoY5QnOCj0WBAItSwd8t3l3pNPphlCrXQinhU/mnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765874688; c=relaxed/simple;
	bh=skcLtTAuwQc+z12XPRKCn++Kb3mOp6E2OLyrnzpi2Ag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hgunuy70XTeSwt6TYdn6wmholjbZx3UVQtpSXbVP+pg6w+7N4THA7XEMgkESFzLBapfTHvnRuMwaYDlkLRmWTeMqHSQAWbM+N0QBySToWbgWM2B4wpX8Q+FDNngQ3mtYCMGoK5Us9WuuyOFnbc55m773TM2Ah/0tyvwa0nF8o4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rOpZvIrj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c5d6193daso5328103a91.1
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765874683; x=1766479483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iCS39mntlzMdxHlY1QanSj8RXtdylHJx128WPAJO81M=;
        b=rOpZvIrjhJ0DM6lM4X155+IzypfRboMk5B0yQuDjh1+eDbwe5FHfCsHReX7uzgdzUf
         tCy1eLdaKZR0xJJxbZ9JMY6O6+vJfiqdvF9Rc4JlnpYgLi0LmfsY6J6I8RwP4kpP7E0k
         KrtI81/D5pR8L7yw7L9xWUVdY2bBOwNBn7bNmfPXInuWbECm3LaV8Utgp9nLK56zXy9H
         EaGbAIC0uMPsL90OC14ysTKqwpi5keTRzgya0WL37NpkI32hceOphnZfY7+ASkF3bR2y
         pNQC5Qv2EkF0L2ScY95JrwcwBt5U9KG2ABadq7BUATLj6ZLUrdVAImOTvSGC0S67Ts3m
         d65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765874683; x=1766479483;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCS39mntlzMdxHlY1QanSj8RXtdylHJx128WPAJO81M=;
        b=cT8v8bCgiL4c3FQSQQN95xXEtC/X6hxRSYV7/egp3B7fhLphJ/dWRBSh/QxWfpg+Ql
         TlWkN4T06ksRTs0Xq2tKoiLuuE1ueQlJrS+0T8YGh9yibXCorLHBhH1NvrRY+BJal6rU
         6H5dwUni4ncU2/R8DEOKm1qEJyIcN1osAzz+B3dV9ilQapE7RwlkTBdpPzHV0AZmm9AK
         gbS2E25CvRnqXFJbfj5Znb64DsoadrgqLIhqCHXgBhGM5t6V70X5t7rm+e7uOyuyhpD5
         kLSrTci9RUS9n+G0E8guSNc2XznkwvyF+nEuTT79TZ/Nh4alynPAxuXDAVVhAVknZi3l
         hFdg==
X-Forwarded-Encrypted: i=1; AJvYcCX95UWn/XEF83gN/krafMCDJalwBHcMQP7U8cO6GRKM0RoXUMPZlPBFLi9Mmsv8QpgpS5RDOo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJv7R4tu2Lztlm8pHMpZ8jmB9cgc9ae+FB0lN9BPT/WUtsJad
	ilvGuPqujMWy5cu6UoZ38AI1+vXf8Hwml4F3uTgBj2T66upQJFGfiC5z8hTvlrjxJpg7ZVxgKIb
	0ZSsgawxSWJx7wRRuqRsNDCXRuQ==
X-Google-Smtp-Source: AGHT+IGSm4OLT+l5V7HmKcb03rEzDHoOa+Zj3rolZDvGKSsZODc6QsE69LeAdJbnSqThLKGGMMi0vDSpwCDiw4xxZA==
X-Received: from pgkb5.prod.google.com ([2002:a63:eb45:0:b0:bd9:a349:949c])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:999a:b0:366:14ac:e1e5 with SMTP id adf61e73a8af0-369b05bfa1amr13464711637.75.1765874682775;
 Tue, 16 Dec 2025 00:44:42 -0800 (PST)
Date: Tue, 16 Dec 2025 08:44:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251216084435.903880-1-joonwonkang@google.com>
Subject: [PATCH 2/2 RESEND] mailbox: Make mbox_send_message() return error
 code when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, Joonwon Kang <joonwonkang@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Previously, when the mailbox controller failed transmitting message, the
error code was only passed to the client's tx done handler and not to
mbox_send_message(). For this reason, the function could return a false
success. This commit resolves the issue by introducing the tx status and
checking it before mbox_send_message() returns.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c          | 17 +++++++++++++----
 include/linux/mailbox_controller.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0afe3ae3bfdc..05808ecff774 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -23,7 +23,8 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
+static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete,
+		       int *tx_status)
 {
 	int idx;
 
@@ -36,6 +37,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx
 	idx = chan->msg_free;
 	chan->msg_data[idx].data = mssg;
 	chan->msg_data[idx].tx_complete = tx_complete;
+	chan->msg_data[idx].tx_status = tx_status;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -87,12 +89,14 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	int idx;
 	void *mssg = NULL;
 	struct completion *tx_complete = NULL;
+	int *tx_status = NULL;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		idx = chan->active_req;
 		if (idx >= 0) {
 			mssg = chan->msg_data[idx].data;
 			tx_complete = chan->msg_data[idx].tx_complete;
+			tx_status = chan->msg_data[idx].tx_status;
 			chan->active_req = -1;
 		}
 	}
@@ -107,8 +111,10 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		*tx_status = r;
 		complete(tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -253,15 +259,16 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
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
@@ -284,6 +291,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		if (ret == 0) {
 			t = -ETIME;
 			tx_tick(chan, t);
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
2.52.0.239.gd5f0c6e74e-goog


