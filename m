Return-Path: <stable+bounces-227850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DQkVE0wkwGnEEAQAu9opvQ
	(envelope-from <stable+bounces-227850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:18:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BA2EA262
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FEA13004D08
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956EB33066D;
	Sun, 22 Mar 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKF9kqAQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA41B7F4
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199879; cv=none; b=dkRImQCu5YHOAQGLEvS8D5L2gu5ITKYuywJg2pUTDrOV9HzMXCtFhOyPHQMxvC4KZ+hN8tNQuGpNb35b3URjDoaP/aJ3ovk+WWBdYNM80IRpe1iCWaZyRFaou0SNP0fVliODKrg39e8MbBKT0bAKx1kO7xMzlW29Lw8QMHVgVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199879; c=relaxed/simple;
	bh=knwR+x+KbyGQeI0D/y5xe5g9j4ScAC9NPUHZVYuXd6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUQ2fN222swTp8uvkJkU0JJyIa7m9V3BWgOmv7f4hhxPPJVsTkvwet+jpRSMKg2MMS2x/qxSmF+MvQAkl5QrLpfVODeAiu4+dJ7M2IqeLC0tDBY5HyJDS03rY2Q+v/JBD4PNIi1Hygb+ANo5Muo5pronC7Wtej1m3m3hGMaYPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKF9kqAQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfc40e4158so340700485a.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774199877; x=1774804677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSMooCIC7eRFhSt8FxFqoAMmRD4C+XMgbM/hUvAjw1Y=;
        b=UKF9kqAQHOjYOkVnTbNB3PPtjaDef8Fj1P6IYOMadZY7cIBpaAsdfsmrWPZWa462HK
         lAw/Fla/A4dN+l7BSFw0xFsXk3PPArpnVuNZpfMVAroaHCT/Rb7HmjqUnqITBGSrYaHp
         OXSx/tKvSoZrfkiH/NrE6UY1IoDG3syiq9418zdUfmVQypqSy60Zy2AvpiY5B4vIVXy1
         GEMZACSw9R2Lv8V1ORvxxvkKVfIddNjUmSpXPp1xR/ubYA7HSAjhcjXhkob49E5JgGNP
         ki4MC0HMTbKi0p09XjpyHevjnNlrKvZcz4j5cgtHv2DLIJNVKDKdBqnzHPHKtNsrz5nX
         hmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774199877; x=1774804677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSMooCIC7eRFhSt8FxFqoAMmRD4C+XMgbM/hUvAjw1Y=;
        b=BhxduIe5UR4m8YsjX/mY+j6t46FWbWRKJ2Zq1yCY7xmv6AGCCzBDF/Z/GIuHA0kAOp
         xpk6pAttm/mQRqGJtWENw8XhxVbbbNQO72EJ2FGC858da048etGAttNbDoyR7FHvaxzA
         ds2RqEJZAQy0jFZ+dg1k9tHR5W/tgcz/E/K3ALo9gRDgarAu7RBMJWek/ZzIG9XXYvNG
         /Dv3KCeIe6P8k2CRaB+oDMhLawnm/eXUC3L16VokaTOR3kVMz8Z4c1Yqj6IOJmoXrOnR
         ZYAIZ8AnY4BF10zLq/933b7I+kvmgVcKGHwj2ziA3c8vSvkdyFYUYQaCdTiIhvOJZun+
         cffg==
X-Forwarded-Encrypted: i=1; AJvYcCX+A4HIQzz2qRxvVy4B/+aCSQp5yPpo9uLv2h9/+y0PgPMZz/oBYFNXzJb64GCTEoSjnFw1CjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxdWX9HAOSzLE0AwPhWKf0ugLq5IKhjkcFEgv+9AjMnf41143
	QPM4ICTQg3P25207N4MrT7Wh7kCZTvv5eYsG4NKM7dAABq/LmAt1kakv
X-Gm-Gg: ATEYQzySfDVQ3ddB6mF1veIWQuL9ISciFL5WQbPHxGa5h3CmQM60cyinf3yz0R4qoIr
	cDRGoIOVdpB5eTvAJ8M06n1kF1hCNZBQ1olDdl1imiU/tlN/0am9roBn7oZvXUdt9uUpL7W1Xw/
	Wl5zYE3GG83hU6CjacUpMLIySLSpFipXtUSRCTszYeoH3xmDIa90iPSQG7ClqXPVfllCx6CachL
	AsJkh9klyYw26OYSVTe7ly/enLNtD62p1of6EdzyZxq5+rLJoNNc02yc34Z8FzrGRjOmiExAbdw
	X/C80nn6t5X+Wl0gi21RJGvAWQl3HVtcJoeumVKOAJO0pIk2L7FVQq2/4INx+68YnooDLOe83i0
	tfhvW74/h6FfUlU6ZMsoj8NJ5x2FWRJoY/moZ8waFAXTdrkhooSejEYd8HFrPeMU5ILt3yt4QLf
	OKn8QDXZtr1VrhfLN0NodQj6++grxN9Ild7giLvcFx5GVaNJ4aoY/AfryMr94GiPvAZpQfSuwRZ
	EIfTDqM3YYoo0U1AjEq/yaz
X-Received: by 2002:a05:620a:440b:b0:8cf:e152:592d with SMTP id af79cd13be357-8cfe1525999mr433128585a.21.1774199876857;
        Sun, 22 Mar 2026 10:17:56 -0700 (PDT)
Received: from Desktop-PC.. (wnpgmb0311w-ds01-161-217-39.dynamic.bellmts.net. [142.161.217.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90e7587sm597838785a.46.2026.03.22.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 10:17:56 -0700 (PDT)
From: jassisinghbrar@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: dianders@chromium.org,
	shawn.guo@linaro.org,
	maz@kernel.org,
	stable@vger.kernel.org,
	andersson@kernel.org,
	tglx@kernel.org,
	joonwonkang@google.com,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] mailbox: Fix NULL message support in mbox_send_message()
Date: Sun, 22 Mar 2026 12:17:52 -0500
Message-ID: <20260322171752.608486-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,linaro.org,kernel.org,vger.kernel.org,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227850-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D87BA2EA262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jassi Brar <jassisinghbrar@gmail.com>

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

Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox.c   | 13 +++++++------
 drivers/mailbox/mailbox.h   |  3 +++
 drivers/mailbox/tegra-hsp.c |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 617ba505691d..2a7fc7395144 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -52,7 +52,7 @@ static void msg_submit(struct mbox_chan *chan)
 	int err = -EBUSY;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		if (!chan->msg_count || chan->active_req)
+		if (!chan->msg_count || chan->active_req != MBOX_NO_MSG)
 			break;
 
 		count = chan->msg_count;
@@ -87,13 +87,13 @@ static void tx_tick(struct mbox_chan *chan, int r)
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		mssg = chan->active_req;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 	}
 
 	/* Submit next message */
 	msg_submit(chan);
 
-	if (!mssg)
+	if (mssg == MBOX_NO_MSG)
 		return;
 
 	/* Notify the client */
@@ -114,7 +114,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req && chan->cl) {
+		if (chan->active_req != MBOX_NO_MSG && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
@@ -319,7 +319,7 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		chan->cl = cl;
 		init_completion(&chan->tx_complete);
 
@@ -477,7 +477,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		if (chan->txdone_method == TXDONE_BY_ACK)
 			chan->txdone_method = TXDONE_BY_POLL;
 	}
@@ -532,6 +532,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 
 		chan->cl = NULL;
 		chan->mbox = mbox;
+		chan->active_req = MBOX_NO_MSG;
 		chan->txdone_method = txdone;
 		spin_lock_init(&chan->lock);
 	}
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index e1ec4efab693..c77dd6fc5b8a 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -5,6 +5,9 @@
 
 #include <linux/bits.h>
 
+/* Sentinel value distinguishing "no active request" from "NULL message data" */
+#define MBOX_NO_MSG	((void *)-1)
+
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index ed9a0bb2bcd8..7991e8dba579 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -497,7 +497,7 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != NULL)
+			if (chan->active_req != MBOX_NO_MSG)
 				continue;
 
 			return 0;
-- 
2.43.0


