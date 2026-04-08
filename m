Return-Path: <stable+bounces-233954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCj6DJCR1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:34:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F103BFA35
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0977F30F0058
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE953D667D;
	Wed,  8 Apr 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewfE3otd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875A3BB9FA
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669282; cv=none; b=KitySepczGHXIBDRibttQTsEfCBPSS85hVzRkFEzx5lRq4v7PmAAZbehnlDH3OBCZAMtsc6IbrnCo158CdhJiJR8Juo5YOdfYXXo6/x305aE+k3jevgWMmICMmm9tencfoXBDBnL5Nvz8xjeuB7R6wqirsh89UzlV0a44iIhEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669282; c=relaxed/simple;
	bh=LWTx2GY8slqIDGaaLTanK/z5XYSQoYnAW6llqlo71dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMlbgT12VJfS4ruJ89dzdP9kS0GmX/Nq/wcxN/vCpIN91wFDhmTcwRs4lGTnrPIRkWpg3/EekRrj4aREdmqtL2dY0aK+zpwAUGt5cFmRujFNXxHaWB5t8ppDNqZAVO2Y/JWvKOmE8cxAmIMvrkXszCcVbr8NamCPYACqNfVW9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewfE3otd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2469e5117so764345ad.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775669280; x=1776274080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HF3+tN1DpTpfpPPMCKgC2HXznMTy5CA+hodNp+cNrs=;
        b=ewfE3otd+MqQcmtg8be8AW4qBgQw6W8ckRHNUFrVK5c/fhCkkhowdJU3oD/Z49dd6Z
         RqLgiCmpjORrCGhGDRRy/SPSLFO4srZBKn7UXdpVGjfdfIPqeCU8uTGk+FoeTiEYYiSs
         KnV/fu1NUHMMa6+sEOpKsB+Gmd6OuHaUrtowxA6b17RltipNguH9ozx8SLFONpUSHRP0
         XsOi88QqOesnqHFhc4nkHlxf7Uf6YjKNIgxbPWFVohWT7wjIKPnlk5F6oNMOE9z4dnVv
         /sfUmAX0BUD704tYdlEaZbHGI92ROVeNxTX152kOSQ3C7R6IaYxsShykdHr4YmVLIoO8
         ES3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669280; x=1776274080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HF3+tN1DpTpfpPPMCKgC2HXznMTy5CA+hodNp+cNrs=;
        b=RY6pQAyaGpHaGH3qEpDooIq/MWqsYL1pSOhnlBTva1uUaTDT9bz13UG9eibKIGRqGv
         vxhmq2A7kvQ83uxSUlLFP+QRXI6F4dPrIZqpmiwQpizFXYg6dr0de9Xj4crvLa+dKQLB
         yzuK3/Ee6Iqf+7m8we3SD17HfI1HqwCBOFxNbY28WuDRV6G2mBZNx8t6EmWSunjRP18W
         9Vmm080oBNHUGZhFnxzxg+tWk1fe36oQK3jlCkfGXHQfV7jLAvQT5iCOm3s+DJ3KW7+e
         PnPShIXUquoLeN26FNxwAa+wuk81mqz6yxI8XgzAwat0VDrYInYIzfs4AsmvB7Hl7yZZ
         B7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUHc2uqiR2qaxtbTyjHm/+CryR1+yq6GkJ+L97H0O5f5K4fBAlyBIcXphfwOiSzzm1NSb/gRqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6i1KokylTpqetXwpJa/lVbXtGKdsI4kerhH8T6f1Q+B0EyPuI
	h2QFG3WR40BtEENr4/Bf21t4gU5X5+DyG8S6d5jQ84JzaQMNguibNdZ1Fa2TuA==
X-Gm-Gg: AeBDies+B6JyVjl5V+JdWVwJ4IOwOHiE/5Xf0wnb69kKxlMZUFYpXDoU00YiF4ULBl4
	Ta0iaOA19mH4vKBUoZvst7NuFhGtY89uDVYbyIHyzS9pLIOhOGjaJObcDQdMXwKUBtsyGBcoXkc
	5sjW6XEOoWSKwTPiO1YbffhebxgMXwt3o4v7J7HK9MxxVAmxj06j/jQm0CpXLdfAaX0BFsg6qRK
	tS8xIRNxGrOrHxXBeFvojGhJ2kwOpS9r8dK7lGUex0jq9xUdVd+A2R6p4OcRIncTu49lXdRcT3d
	FxyaYCcYk53GfMf1RJgY6ZEVycqIHCIsMcj/Vmm2vXfxphvf6z7O0hvaRvQ1fQI3MfQBg791CrK
	h6QHSAwKp1OOgS5pQCaj5XNDXkrEfkQapJ5sMvpayUTJrD7iwyrLsAvAgkuleMLrxfpZ5CAozDa
	1+Ge8Qr9cjpanjA1kWGQ==
X-Received: by 2002:a17:903:1ac8:b0:2b0:4f7a:1958 with SMTP id d9443c01a7336-2b2c73a442fmr2487605ad.29.1775669279941;
        Wed, 08 Apr 2026 10:27:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3af9sm198274025ad.63.2026.04.08.10.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:27:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	hbirthelmer@ddn.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: fix io-uring background queue dispatch on request completion
Date: Wed,  8 Apr 2026 10:25:10 -0700
Message-ID: <20260408172510.52950-1-joannelkoong@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-233954-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: B6F103BFA35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a background request completes via the io_uring path, the
background queue gets flushed to dispatch pending background requests,
but this is done before the connection-level background counters
(fc->num_background, fc->active_background) are properly accounted,
which may reduce effective queue depth to one.

The connection-level counters are decremented in fuse_request_end(), but
flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
the io_uring per-queue bg one, which means pending uring background
requests on the queue are never dispatched in this path.

Fix this by accounting the connection-level background counters first
before flushing the queue's background queue. Since
fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
skip the background cleanup branch entirely, which avoids any
double-decrements; it will call the wake_up(&req->waitq) branch but this
is effectively a no-op as background requests have no waiters on
req->waitq.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
v1: https://lore.kernel.org/linux-fsdevel/20260401184915.747714-1-joannelkoong@gmail.com/
v1 -> v2:
* change commit message wording (Bernd)
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


