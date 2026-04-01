Return-Path: <stable+bounces-232842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGfBIRFqzWlmdQYAu9opvQ
	(envelope-from <stable+bounces-232842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45C37F786
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAF63036D45
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4D331A43;
	Wed,  1 Apr 2026 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9K4tCpz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AC47B403
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069412; cv=none; b=R7SotPVWhuoY5mXxANpgr1pvf/vsdfvgWLod1Eg3JgWRTicHn4ztfD4FXSH8Jzu26PSrNXsxL7WIl8tF6uI7hlKXsOCJCxgWOryfbOf3UBdHfjqiiQtw/qk3ox4gjmgGByaL/aJlJOhQASmjiAdkdumn42n0ViEvLaa7Q/Epxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069412; c=relaxed/simple;
	bh=1GnI4YZW3N2JC1IinpFjDEYdd9ykHsrCmlasNHYbQ98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgVyjDDLCrLEOppJykgStbJsfpUVFRh6t6TpgJfV9DJq/zIa/EbT6rm82NP3t60zLnyqfpcydY2CW16ksuBgODg+8yw4W7w+iqspfCXHRV+Jdp/Si+wJWVIU5KN9ejovXACHHv0J9SbnI67ciOcopFdD+S+mcpAAPVPvrPP0tVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9K4tCpz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a893d289bso50241b3a.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775069411; x=1775674211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICaAFpbMGQboIAi9OiYLR3EBM6U+PTOXmuN9mYNMh0M=;
        b=T9K4tCpzpvLdXjBOYFklVSRkqAMWbDA4ryLrylLhtTahjHO7dguuJswPxscAFsLgit
         1d+xy3vOso4isSpU8WEmfs1rW7vyyHQBX95ozKEsn2TIRX/3l17itopS3t86s8iyyTse
         30lbii+I/PtrdyScDzYsAlDjFCPleZfK0CSYaVuh/JMyjXN9K63vGjxcCmmJeO0Ms6kV
         c5lDW4oCDVA3PCyJ3hexNh2KWb6NfjDpz/JWSBrghkuLxSNZdmQuOUwBkYM1oSRUyp8c
         LFWp8xlBPdrNjDOM4Trhx2WpLKWNpyj1xqJxHVKF3JUeGywoPMbvL1FIC0qAjEXMbJq5
         e3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069411; x=1775674211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICaAFpbMGQboIAi9OiYLR3EBM6U+PTOXmuN9mYNMh0M=;
        b=qK2oFRSqdiqaelgRvLg0Y089etiyqVhqBjBWL0xgwVDligrCUTQh2xZzGgwLGfp9VM
         al7RPXBG/JPWItrdqjvRjVQXZ/7PgMHz25Uk9kMXrvANoHBiSZgz/Oq2X63hG7hTRTw4
         kAAJW6jLa0QqLyMqt+CcUh6yC7k0i0gWF9cYPYZfDt9yE8ev9AUngdO0Psfrdu3S/VBL
         EPffEUtsNTb0f1XcI3ypTmAhKnsdTSrcLBL5p3U7JQLNidDliWTgjksimSDAQlazR9kK
         1UCEplgJ/Vo7wKl1cCmLi1a05aaQA0GeVd5cY5lXDi6ECJcDa4x3vpuwaCAGRNG5xkxN
         v4GA==
X-Forwarded-Encrypted: i=1; AJvYcCVQYh5NhVxhiA207FgzqDK0bKyy6zMxk4S7Q5tA0tRMo/kRsg+yhyS2qrFvC5PV/gmnxhhaYls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasF9nxU7o6DNMgqxPKhmaCw35PaFo6SF5yn682uqpTkBGu7bt
	vt7yoO2ZSQQrxWwtvz8soiH7Wf5cebS7lIQzf/K860LWi1rf/g/4KsLY22gxRw==
X-Gm-Gg: ATEYQzxZOJDqmNNJaaJzZ528Oy7pmxiuKIHWk+OFfPzSCuwmhT5UKWJUNBS74jJiY3V
	rd/U8Ee8x4bMlPrfdNITeAiqYYQu/LNXgttdXa7WoDkFjLQgH+bw6R4LG6lQpQlW2gS2bnQNuio
	IMqo+Zw1pkf4//A+c9YgOp3omG0nea1bsbRMKrOim8Y1wys/CrESns45oR7XSLnyY8uuvJS9ByH
	oAFfn5wW62TMpISQY3VyE8TVNt+O+dQAFpLnt//2o8NkjfExQzlUgHkFs/uQuwDpAWXEjcUWEkA
	CZegFaw/YNGfuJuJLgdg4JREzKggIuQgTwtgs8F9kOtTKWB71fpcyuojUeUps6llz/vtyYaoxMN
	a/JGgygImvhaRP1iBQlkIxtvjWqIRXrWH4QS8tcHFS+rIoa83CqOd3CSPIt2AfU4UtxWz7FF3Lz
	xCWkrGC+Adyb0VLOiDnw==
X-Received: by 2002:a05:6a00:600a:b0:82c:2480:4e3d with SMTP id d2e1a72fcca58-82cfb85d64amr604949b3a.9.1775069410480;
        Wed, 01 Apr 2026 11:50:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c72967sm628158b3a.49.2026.04.01.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:50:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: fix io-uring background queue stall on request completion
Date: Wed,  1 Apr 2026 11:49:15 -0700
Message-ID: <20260401184915.747714-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232842-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF45C37F786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a background request completes via the io_uring path, the
background queue gets flushed to dispatch pending background requests,
but this is done before the connection-level background counters
(fc->num_background, fc->active_background) are properly accounted,
which can leave pending background requests stuck in the per-queue
background queue.

The connection-level counters are decremented in fuse_request_end(), but
flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
the io_uring per-queue bg one, which means pending uring background
requests on the queue are never dispatched.

Fix this by accounting the connection-level background counters first
before flushing the queue's background queue. Since
fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
skip the background cleanup branch entirely, which avoids any
double-decrements; it will call the wake_up(&req->waitq) branch but this
is effectively a no-op as background requests have no waiters on
req->waitq.

Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c        | 41 ++++++++++++++++++++++++-----------------
 fs/fuse/dev_uring.c  |  1 +
 fs/fuse/fuse_dev_i.h |  1 +
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b212565a78cf..35cdfc162ba5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -447,6 +447,29 @@ static void flush_bg_queue(struct fuse_conn *fc)
 	}
 }
 
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req)
+{
+	lockdep_assert_held(&fc->bg_lock);
+
+	clear_bit(FR_BACKGROUND, &req->flags);
+	if (fc->num_background == fc->max_background) {
+		fc->blocked = 0;
+		wake_up(&fc->blocked_waitq);
+	} else if (!fc->blocked) {
+		/*
+		 * Wake up next waiter, if any.  It's okay to use
+		 * waitqueue_active(), as we've already synced up
+		 * fc->blocked with waiters with the wake_up() call
+		 * above.
+		 */
+		if (waitqueue_active(&fc->blocked_waitq))
+			wake_up(&fc->blocked_waitq);
+	}
+
+	fc->num_background--;
+	fc->active_background--;
+}
+
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was aborted (and not yet sent) or some error
@@ -479,23 +502,7 @@ void fuse_request_end(struct fuse_req *req)
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
-		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background) {
-			fc->blocked = 0;
-			wake_up(&fc->blocked_waitq);
-		} else if (!fc->blocked) {
-			/*
-			 * Wake up next waiter, if any.  It's okay to use
-			 * waitqueue_active(), as we've already synced up
-			 * fc->blocked with waiters with the wake_up() call
-			 * above.
-			 */
-			if (waitqueue_active(&fc->blocked_waitq))
-				wake_up(&fc->blocked_waitq);
-		}
-
-		fc->num_background--;
-		fc->active_background--;
+		fuse_request_bg_finish(fc, req);
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
 	} else {
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..ae916733f18a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
+		fuse_request_bg_finish(fc, req);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..7da505af6d35 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -59,6 +59,7 @@ unsigned int fuse_req_hash(u64 unique);
 struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
 void fuse_dev_end_requests(struct list_head *head);
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req);
 
 void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
-- 
2.52.0


