Return-Path: <stable+bounces-247329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBUCEKqnBmp0mAIAu9opvQ
	(envelope-from <stable+bounces-247329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AE5495E3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E3183018BD4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723B3CF03E;
	Fri, 15 May 2026 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6NGgDmn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFB3D9DB4
	for <stable@vger.kernel.org>; Fri, 15 May 2026 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821023; cv=none; b=gw3oWFQeR1G7uxn9VemhjJi/7mUO19d1qTpb171nY3mQ0Ky29z+W5YnbA3r244dPsMTM0s/x5NTbMq02oshr9jPgiwit5NWye223Hn2SQp8ELn8nPZAIokImN06d+4AV6SFVb/MeUVLuUggLBZaxep5JRBnIul74SfjPJ+gEwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821023; c=relaxed/simple;
	bh=eQWJsLFYCOoe95iYFeHwefeY2wFnssmrqOjdoF/rwMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0OySmN5htFIuQEcHBQPe27ywLgoT92DajhlZuJ9d1rOvCI6f/E21osU34YbFL0T+nH8fLbdGbkBKYmxExB/o+qnSP3JFu3aCyF3XDjpbHLFe/rQZXyXoSKgGPZIRihwMfK4UdRqgmKvi4lBFzwvqCN6wnYeVxWDZImxO8y4hNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6NGgDmn; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651c5d525f6so11793151d50.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821021; x=1779425821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPsE9qWZdOb1TR1AHrKLa6S3PYltxNEP+yyKsE9R4/0=;
        b=S6NGgDmnoTK2qKUdZEU5ec4nU8cd7lMgbmecrgN+wkrv+9TH9DOFsPZgv9oNRrXB6P
         nmO/P31yv2InjQc26VnstvtFBL6wH9WeyvjZ9zp8HAW85aYiYbuCSQkz4Gkf/Y5Nov2A
         jn6qefA9a2PMeu3H0Yk0w85Cyb0pUPsrK3irQ67fpJ5TIIOZ8ClxRiotj81tLgBlL56q
         uGOMey9+yuM0EPFW3P4s0WKXeehpgdfsvGNJGlIyB8jfM791NQr0G85gwftjIWwFGZEx
         SsET8/caIJNmdpPJtfgZ+pc7cMS6bqJqzJocU4Ka1XAtK4UL8iSMbw3EpRfhzL33yLai
         Tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821021; x=1779425821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPsE9qWZdOb1TR1AHrKLa6S3PYltxNEP+yyKsE9R4/0=;
        b=IqvLVJBJbQ26Necct2cVUUMYRaua6dKLQOBiCzTO0ft1oO0001P+CY8b5UKifPlENg
         cMmVMr/R61tDwz/q0s4IVfTrGAWahdapaRDS5Y2tzafXp7O9iNidtAFQnkUP9ZN4n57D
         HFRi93edY/9nIuN2r2ljg4p6860snip+logQX4mlpccAtdwqSaliMpCHJxdy9Fh17oEW
         pSeD3h0lkJLnWW+AkpDKRZrl9T50FTN1QN8u4R3184rYQSlg4xWTQY/f+1/SHh4Ylcs1
         KDI5zAOoSKa0BokAW3n9xQgc5to3GohTbKmIOhTVQ25+AWKmLwwa6PedOk7Fy4YHKeXd
         /5GA==
X-Forwarded-Encrypted: i=1; AFNElJ+KWAImGzK1Tr/twiBogFGlT09jV5dtZ+YxIkXe5/T+dkpqKanC0mCkDnMAh2Bki3VkdFpwgiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4iquVWT9Fq3MyZGUDXgXzBCM3VcEgZMZs2CkG1nmSggFGqnq
	pZ3TBBskELmrQJBfat1QTOJK+nbWbIrxrTE68ZyiEv2XYqAnIse2F4ZD
X-Gm-Gg: Acq92OF1BqsjCO/ZGv8FiRi9Uu7HH/q8UlpJibwqOGNq4mu2Cy99FhkdPjH4lPuW19O
	6ySK6BrimzrOVTx7EdDeyJTOK/aR1zxF/INVzxn2FOeM8ruStHJEGEo828/qZe5AJ1SrKkjqcOg
	W0RvU2xRrk1HA3x8H/J37MxFbo8t41ff5CHRN2vmtIX2oSZTzSpTNXhCLD6+8ywBqRMM2ahKNuj
	CtasEWM8OQ+IR5Mg5mDtL/pYVcNfO7Ba6WgUYkkqaFNr97XCzovjOg+Nde5b7i9Y8YsqNAezTP6
	WR+97chPpOgiJI3FvABhS/2CA0/RJE8BT9BZO3CakfIXPFkvlWc1SPluwOB0M8sXUnuaotR2clg
	iSnLFwP1KE4MJ8VRZQ1hVHerg6fAw+i+jNQmBoWpxkwBHf5aou7EKY/1pdYxBNGsgIGhyhC7kTr
	Kt2l4IyinoCJFGvjxKHDjG
X-Received: by 2002:a05:690c:c513:b0:7bd:6432:dab with SMTP id 00721157ae682-7c95ced6eaemr25719707b3.43.1778821021047;
        Thu, 14 May 2026 21:57:01 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c955d8d3aesm8372687b3.30.2026.05.14.21.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 21:56:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	bernd@bsbernd.com,
	ali@ddn.com,
	horst@birthelmer.de,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] fuse: fix race between registration and connection abortion
Date: Thu, 14 May 2026 21:55:40 -0700
Message-ID: <20260515045541.1171335-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515045541.1171335-1-joannelkoong@gmail.com>
References: <20260515045541.1171335-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D2AE5495E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-247329-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This fixes this race:
- thread a: io_uring_enter -> register sqe ->
  fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
  yet
- thread b: fuse_conn_destroy() -> fuse_chan_abort() ->
  fuse_uring_abort() is a no-op due to queue ref being 0
- thread a: grabs the queue_ref, queue_ref is now 1, rest of
  fuse_uring_do_register() logic executes
- thread b: fuse_chan_abort() returns, fuse_chan_wait_aborted() now runs
  and calls
  "wait_event(ring->stop_waitq, atomic_read(&ring->queue_refs) == 0);"
The abort/unmount thread will hang indefinitely in unkillable state as
nothing will decrement queue_refs or wake stop_waitq, and the ring,
queue, and ent are leaked.

Fix this by checking fch->connected under fch->lock after the created
ent has grabbed a ref count on the queue. This ensures that in the
scenario above, it is guaranteed that we either release the queue ref
and wake up stop_waitq (in case fuse_chan_wait_aborted() is already
waiting) in fuse_uring_do_register() when we detect !fch->connected, or
if the connection is aborted after the check, it is guaranteed that the
async teardown worker will be running in the background cleaning up ents
and decrementing the ent's ref on the queue, which will unblock the
eventual queue and ring teardown.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index cd75f61018ec..d9108b5b5db8 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -977,15 +977,26 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
-				   struct io_uring_cmd *cmd,
-				   unsigned int issue_flags)
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
+				  struct io_uring_cmd *cmd,
+				  unsigned int issue_flags)
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_chan *fch = ring->chan;
 	struct fuse_iqueue *fiq = &fch->iq;
 
+	spin_lock(&fch->lock);
+	/* abort teardown path is running or has run */
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
+		if (atomic_dec_and_test(&ring->queue_refs))
+			wake_up_all(&ring->stop_waitq);
+		kfree(ent);
+		return -ECONNABORTED;
+	}
+	spin_unlock(&fch->lock);
+
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
 	spin_lock(&queue->lock);
@@ -1002,6 +1013,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 			wake_up_all(&fch->blocked_waitq);
 		}
 	}
+	return 0;
 }
 
 /*
@@ -1118,9 +1130,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-	fuse_uring_do_register(ent, cmd, issue_flags);
-
-	return 0;
+	return fuse_uring_do_register(ent, cmd, issue_flags);
 }
 
 /*
-- 
2.52.0


