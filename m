Return-Path: <stable+bounces-245009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJtCFmcnAGrkDgEAu9opvQ
	(envelope-from <stable+bounces-245009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 08:36:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92BC502CB6
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 08:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C75DA3005596
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954135BDCE;
	Sun, 10 May 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEGpFHB7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D42628D
	for <stable@vger.kernel.org>; Sun, 10 May 2026 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778394980; cv=none; b=lp1SYQDIsMAPBuAKodFTRL2Z6f8AaELb9+ORJ2Udh/LEO/TRBbXQY7FgjEo0pr3zUwq21laV1y1Lf0tXv4cP5zgdb7Hi3fHsNAd4DPKTQu2eF1GxVNWFpxhHnraYKbe/FCCNsbwY+PRjS3TBaXpE2ftPgicxdT+UyXz9ey2oxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778394980; c=relaxed/simple;
	bh=phdnQxRsFNGzKAcu/4enEnu/G9ERVK1WGTbPg6FbUOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=B3HPHKwtUGRxk/UrNgNrJXjT4ux8SRCSnkPzgVIOeQ3d+CnmALGsuu6L5l655FT42J2RgglSCI8GJCoVVd5mEcrKbe0A4jQzDmSk0UFLnbNV6CNawfgGHM1ATfftWcuzdRPpIsIF2kxUU9IgSwQ7cPhZVPbFFd/oaumdINp+ssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEGpFHB7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b461b36990so37088465ad.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778394978; x=1778999778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3aQJiZTRBJkBFZ975taZr8YJVOyVprFYSJVw8C+91Rk=;
        b=EEGpFHB7hgOWisUab5fuBgHikJsPBDGMWZVyKFieo9qsBTK34jPDeGWCryYLyjP/SB
         UUNHx0a/46RbmQAQOm/lbA4rFQeDy2nTq0tE3oT37x9jQ6dpqKMJ/jnMUEHgdYFnDWQR
         Fm+YKNWq9E5fHpPY0g584J5GTdPTBXXZ8cMNybQaj0Z+U3AVskXetx1pEMq18oNfzk2R
         W0j0V/ZDSo2slWVUATRgYzxqxIXhE8aDg1euxiFW5+WFkNqw2jvriRcwpVEcCU0raeWX
         Uhf5gSujk3lrSOb+g8l2Wux7lnh9Lj0h+rqao1Ako3eEfOhxbglDkmp6g4+bSCOGDn81
         6sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778394978; x=1778999778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aQJiZTRBJkBFZ975taZr8YJVOyVprFYSJVw8C+91Rk=;
        b=HkkOaFSY1LypbgCPm2CfoJAaVRajuHs+l2+JeMvi2nE2TRfbKFqt9Uay0tyduPt5RW
         4gTlRykoUnEkFyaW5/cg2LEacIsXGA2N7gOInJwzNtYD+fYhCLVdvuLycx4ruVDCTGyR
         w00k7oRPJ9QfT0SlSGDu/wpPSqJq10uQ0QDxs5xVJp9wGxTNdt/rzI9VTyhDoOSoGpRy
         vrrQUyDquOQ3/XMuriSPF5LbMh8ixtd5rAi0Pfq8Tqw0PhY3CgM6vfizQPPim1IxlSqM
         nRseiHcvR8wYySObVbTT/0fk1jyIpS/J+PwvJZOUiZJUkU6MfTz/ZVVCvXD3I7hgC7Ui
         Svww==
X-Forwarded-Encrypted: i=1; AFNElJ8tcIPMhfeIjbqLVfp3OKeROroe1HIcmuFnXGjqzlLWrriICgtVEAp4eoHJU3mNNsWSh1wPNxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywIrkek07OJNZN0DHRaO9ldzTAIxjzHOiycIVu+nMSnXb1E66
	EuQRrCy/ApXg4M4L6oFAE0kdeD1dydfo5ZGqoftiH5pODlFWPkdANkhnAHTJuEpDBhcair3Zl9P
	tNgp/HknbESPxth+IlysKZPusWQ==
X-Received: from plkz6.prod.google.com ([2002:a17:902:7086:b0:2ba:8f0:838b])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:388d:b0:2ba:3b71:5814 with SMTP id d9443c01a7336-2baf0d4b827mr90924315ad.18.1778394978235;
 Sat, 09 May 2026 23:36:18 -0700 (PDT)
Date: Sun, 10 May 2026 06:36:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510063613.1158801-1-joonwonkang@google.com>
Subject: [PATCH RESEND 6.12.y] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: sashal@kernel.org, stable@vger.kernel.org, jassisinghbrar@gmail.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	joonwonkang@google.com, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E92BC502CB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,google.com,chromium.org];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245009-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email]
X-Rspamd-Action: no action

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
2.54.0.563.g4f69b47b94-goog


