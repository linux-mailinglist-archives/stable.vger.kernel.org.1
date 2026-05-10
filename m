Return-Path: <stable+bounces-245006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEC+GtsaAGo3DAEAu9opvQ
	(envelope-from <stable+bounces-245006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:42:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B6502B82
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5521D3020D5F
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FD3537CD;
	Sun, 10 May 2026 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYNLxuQu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E543246EC
	for <stable@vger.kernel.org>; Sun, 10 May 2026 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391676; cv=none; b=KeEr7kfrdH3IfM51qhATh/mftKybEJrRlWTuK0eMzZ+jwkTEjJ22WbWppa/0vYwx2OLYBg29D+i1S+d1xDeZPyoxIZMrirt7bKopyKi+gmnI1Pa6jiu2EmiBbqYbI+9qz6q0e6GZrSVZPNJZMK/2X+YRMfp2Rxb8M3Ktg3XsP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391676; c=relaxed/simple;
	bh=gDfx5LzmAfAOrqMmIQfvr9ht4ADd1bazSgpxvKasckI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=amkCz00J5k5+M97icC2Th8xTXlmW+ujaFPll0/Q8Wb2a8QIUJ2gZt0K93tpwwwrIRcGrtRkUqbJk/n+3LsE1WeV4AvdidIAxkFpGlbZmdaW1IAId1o+eW6og/7PSzKrRyWxBIquTxcb9C/uInt7YFCXkoGJoGf6bvS6mwyS29F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYNLxuQu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82726f7b0bso392336a12.3
        for <stable@vger.kernel.org>; Sat, 09 May 2026 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778391675; x=1778996475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o94GcXhqW4+xEkZTDHTPwpkDN5aqxWdoTlyMFkc71+w=;
        b=XYNLxuQu5EvF4wFxxwvmvoqO+2mGCPexcIQPBs35spj67fvRRlEMAaZ8xMciwnm3KY
         PuLpvw9OnhwBnh2ousyMo+FWP9BjPGrI+7btGydvZpMUQx1MgDNTt8dqgbJII/82x8uT
         gqH5nZi2F/1DbvocJBKHWGFAvHird8fU1VQcKfkH5OupejJ/eBNGp6qRGc1xUglKUBBY
         PiPCjvgRo76imU2nAKUxXJxbvsGSBB1EAAS0clkmqlh/TjmFzxw3SUNy8RI31AoGy5O/
         DgxVsHITDr1VlsUyH1PfRucqKlO/RBf6rTJlxZkQgF1V71HBJhbVOfK18mhFY0CHZh+A
         /hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391675; x=1778996475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o94GcXhqW4+xEkZTDHTPwpkDN5aqxWdoTlyMFkc71+w=;
        b=ejJ3l2LDMXPeFPfv6uAZ3gFTmQO4GzU0YPbcEHOHNsPN7J0x98O9RAmMfr4gEJ55SV
         DM2h+P49WJxTVHSOzdf3XAfjYMnVDYsMIawQtr2FFgWf9p3hs6TYKb5uHXAcFbfzRwpI
         9UWJJbjxMhEXdz7nC9M3nQIwiP1a9/5YtmCbN2aiSvOiwl2pHJZTDN/c9iPXZn35p1tA
         4R2npGEv/Qpiu6ASi1YSKN7dj/kOCYCHt82wsuQNoNjEr+elHMVyeEgmR/0XqZnrZIT5
         KFwQ2o7/0ePqSPJhpJvQxN4mOMPl7kmOT52Te3I/fPV+FqiZiFeZtC7Aw+OSaRHJofhr
         pYxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zL287Ej9Tb45ose8yEAf9kYex60XaVJEnNFydlGQWe8n+7e8GD3+cuELRdFHzsLOjeLjPTDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVt1zuULlcQPTSv94t3eE1/gIn7Iehal3G/uCmEi7t2thTcvdW
	ZJwx/hxEt8DYZopHF4y+c+Toh/OSjIi4YBmQ73nOhjELq8a2F/TP9n/NXNU1Z2x1qLNOtMLQWQb
	kYT5enwCRyn6uas8qjs3asUhBYQ==
X-Received: from pgc15.prod.google.com ([2002:a05:6a02:2f8f:b0:c74:497:507e])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:549d:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3aa5a8d012bmr19463804637.12.1778391674533;
 Sat, 09 May 2026 22:41:14 -0700 (PDT)
Date: Sun, 10 May 2026 05:41:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510054111.784204-1-joonwonkang@google.com>
Subject: [PATCH v6] mailbox: Make mbox_send_message() return error code when
 tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, sudeep.holla@kernel.org
Cc: dianders@chromium.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, joonwonkang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D01B6502B82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245006-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the mailbox controller failed transmitting message, the error code
was only passed to the client's tx done handler and not to
mbox_send_message() in blocking mode. For this reason, the function could
return a false success. This commit resolves the issue by introducing the
tx status and checking it before mbox_send_message() returns.

This commit works with the premise that the multi-threads' access to a
channel in blocking mode is serialized by clients, not by the mailbox
APIs, since the current mbox_send_message() in blocking mode does not
support multi-threads.

Signed-off-by: Joonwon Kang <joonwonkang@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
---
v6: Remove the Cc tag from the commit message.
v5: Add note to the commit message that the current mailbox APIs in
    blocking mode do not support multi-threads.
v4: Detach it from the previous commit that supports multi-thread in
    blocking mode and rebase it on the latest for-next branch.
v3: No major patch since v1.

 drivers/mailbox/mailbox.c          | 6 +++++-
 include/linux/mailbox_controller.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index b00f7a32e866..066702e5a46f 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -98,8 +98,10 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		chan->tx_status = r;
 		complete(&chan->tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -295,6 +297,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		if (ret == 0) {
 			t = -ETIME;
 			tx_tick(chan, t);
+		} else if (chan->tx_status < 0) {
+			t = chan->tx_status;
 		}
 	}
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index dc93287a2a01..26a238a6f941 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -120,6 +120,7 @@ struct mbox_controller {
  * @txdone_method:	Way to detect TXDone chosen by the API
  * @cl:			Pointer to the current owner of this channel
  * @tx_complete:	Transmission completion
+ * @tx_status:		Transmission status
  * @active_req:		Currently active request hook
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
@@ -132,6 +133,7 @@ struct mbox_chan {
 	unsigned txdone_method;
 	struct mbox_client *cl;
 	struct completion tx_complete;
+	int tx_status;
 	void *active_req;
 	unsigned msg_count, msg_free;
 	void *msg_data[MBOX_TX_QUEUE_LEN];
-- 
2.54.0.563.g4f69b47b94-goog


