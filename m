Return-Path: <stable+bounces-233075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOYjD8GjzmlZpAYAu9opvQ
	(envelope-from <stable+bounces-233075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:13:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D347C38C6D5
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29CE30DACED
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009003FBA7;
	Thu,  2 Apr 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REuD9243"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A24364931
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149674; cv=none; b=uQDf/NS+yqp+SFqysg3piDpBjOH4mhIyDvlAx8rZPnwsq1TG8IHiLKeuO4V/GAKmNEWAyZivC0k0FBk4Ur25Kle7doqzEwDXII17dAb1AuSu8SUPGXFuqybAzXBtnuuo1da+p9zqIu8ZYDgjpkxjDx60cOzQNy9d7ukVZJlQSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149674; c=relaxed/simple;
	bh=RX9yNp5j1OE/PaC+hIPLZ/izItPwEBkRp9rXwgexlsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZZoZEnGxXQ+VEYzgz0Z3IiTaxMSI6Sq76Yxp6sF87H4Wg1RzS7LzJfjJcHtF0DT+O/qX7sV3Oe5kLoUy7ewhNf1j3F31Odz5pc7EoKM3Yr3O9LW4m8NE4iKIx8LkGync/iwfZdTrZ87fbswE5hBSPKBzxT2pge6Pd1xFZixhISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REuD9243; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so1380831a12.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775149667; x=1775754467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtS1OkkhTmC+kJWduMT9+PxAc4KJJ2D34QZmfUPxalo=;
        b=REuD9243C1mcz2hU0ovnEFQt1Ye0+vC8eA9W2m7Tn8/z5W9zo6oQRPQdcAfmkaCkCJ
         Wmi7Tl5kRQr1Fkj1JDfgVNmJYoWjOdl+MwgveAxlq6saEvGao27pbx4sEApuZBbrK2pc
         36RtfJ10W7EusQlLIFw0fxk62uYiNEw3qEUx3SbGkB81l/KxoguSikkEDgKG0WqBgkcq
         qUF4/D0gL0iqQSJB4HhE5d5ryZBe6yUCiKl3FBoHqv8WyWy//h50m8qNmTi6krgUmd6k
         B/NbAwdHMKGf0CA5aBP7sQCY3w16tNeDgbO1Q+MQ0Vi9O63Y1HO+sx5vqjrhh7GcZUcK
         IbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149667; x=1775754467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtS1OkkhTmC+kJWduMT9+PxAc4KJJ2D34QZmfUPxalo=;
        b=CBFxnuqwzmcLO/UROYBBfTy73eiaFU2ioSTD0qK3InNamJm/1yjwtzPzq5YTzeKvmT
         VAypqxRSFiXdvdP3LJTZwiQurbfXZZ7ShCZEw24nwOJkMFM6qS4IvNb2xJHNo5oBmV9F
         xp4ZALGNtdcaiKGh9iknda0h2TYpbaeLDXP4jQyQkTijxn5e5Rd1W7knDHLBB22Xs+Wu
         5YkfvzgEo+J5WDhqPkmBS3W+mLH5/9UhGf09ZhCjqfyodkdeXuwxSFeawgGkx6/5JCty
         bjEpmN1orOBjruIOH9Zgw55r1BAtfth7h+y3HRVaYLdxeSqdvCyfF5wjIe2k31WbUUnn
         yO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWHgNdx+AkL/7rIyJWr31ONJs5qwF083AlLss8oI/L10DjjZaDKlbQJPhmV0U1Kt5dIdb0hptc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPpSUqpwFStTXwTpXwWJ7J1ilMK21IaD8wdUt+cv+g8UB+hlA
	YXfa7GN+7lVw8+TpNThLIQRN1j+LSsl8Hfc3CdIvyENmQUMHd/X4aSCmkp9T30gSM7pTrgC1XGk
	fVdtrM+N/fB7A18DJ2BMHMv7/6g==
X-Received: from plse12.prod.google.com ([2002:a17:902:b78c:b0:2b0:537d:70cc])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e850:b0:2b2:4f43:b49a with SMTP id d9443c01a7336-2b277e52d1dmr29085885ad.22.1775149666599;
 Thu, 02 Apr 2026 10:07:46 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:06:41 +0000
In-Reply-To: <20260402170641.2082547-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402170641.2082547-1-joonwonkang@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402170641.2082547-3-joonwonkang@google.com>
Subject: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error code
 when tx fails
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233075-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D347C38C6D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the mailbox controller failed transmitting message, the error code
was only passed to the client's tx done handler and not to
mbox_send_message(). For this reason, the function could return a false
success. This commit resolves the issue by introducing the tx status and
checking it before mbox_send_message() returns.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
 drivers/mailbox/mailbox.c          | 20 +++++++++++++++-----
 include/linux/mailbox_controller.h |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d63386468982..ea9aec9dc947 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -21,7 +21,10 @@
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
 
-static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx_complete)
+static int add_to_rbuf(struct mbox_chan *chan,
+		       void *mssg,
+		       struct completion *tx_complete,
+		       int *tx_status)
 {
 	int idx;
 
@@ -34,6 +37,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg, struct completion *tx
 	idx = chan->msg_free;
 	chan->msg_data[idx].data = mssg;
 	chan->msg_data[idx].tx_complete = tx_complete;
+	chan->msg_data[idx].tx_status = tx_status;
 	chan->msg_count++;
 
 	if (idx == MBOX_TX_QUEUE_LEN - 1)
@@ -91,12 +95,13 @@ static void msg_submit(struct mbox_chan *chan)
 
 static void tx_tick(struct mbox_chan *chan, int r, int idx)
 {
-	struct mbox_message mssg = {MBOX_NO_MSG, NULL};
+	struct mbox_message mssg = {MBOX_NO_MSG, NULL, NULL};
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		if (idx >= 0 && idx != chan->active_req) {
 			chan->msg_data[idx].data = MBOX_NO_MSG;
 			chan->msg_data[idx].tx_complete = NULL;
+			chan->msg_data[idx].tx_status = NULL;
 			return;
 		}
 
@@ -116,8 +121,10 @@ static void tx_tick(struct mbox_chan *chan, int r, int idx)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg.data, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		*mssg.tx_status = r;
 		complete(mssg.tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -286,15 +293,16 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 	int t;
 	int idx;
 	struct completion tx_complete;
+	int tx_status = 0;
 
 	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
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
@@ -318,6 +326,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 			idx = t;
 			t = -ETIME;
 			tx_tick(chan, t, idx);
+		} else if (tx_status < 0) {
+			t = tx_status;
 		}
 	}
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 912499ad08ed..890da97bcb50 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -117,10 +117,12 @@ struct mbox_controller {
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
2.53.0.1185.g05d4b7b318-goog


