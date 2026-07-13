Return-Path: <stable+bounces-273931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VnHJB0UnVWpakgAAu9opvQ
	(envelope-from <stable+bounces-273931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE2E74E39E
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fNySx5R8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273931-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273931-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E5C3004637
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5B2F360A;
	Mon, 13 Jul 2026 17:54:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59D32FA2C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:54:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965264; cv=none; b=kXTls6SRMcO3d+fC85HGcctMWR1spHe6q/1tGwdWO2hhIyvfXCm83sv+ZKc4zZtY+8m5lajUNxt1hrs324xKnzbZ1+TNUX1bfJrQ096vX/1zaSgyjsG3yKSMxJVg/A/w8k0lPZZgbTfIJPGeNmeujsayycGCDSp1P9QIIz3lkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965264; c=relaxed/simple;
	bh=jF3lkhKiWakpsBVktimaJzqA+Qy4eUHt2cp8o/pJc9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwWE4cmiiT1OFPtCLcN3srNUnJj2nNGI21L6NKslULtoPuMZ1IHn/nYWYPRbFiqWaEAywEuajhsF3zkwA2EghGfONd3tdvU5gXVTCWqoJIHsfnnZW8eKaUJY8zjX/SG6PXtz0H4QQrkSUo0+cw7TKrKFdyqPUaLm9vK449nxfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNySx5R8; arc=none smtp.client-ip=209.85.210.52
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so1751249a34.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965262; x=1784570062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTazow5AK7oQsOPc1YIhM/ohcZWShlTcPJrS3UikzxY=;
        b=fNySx5R8oMbE0REIG/NMakSSFc8IRWEv/rkgGbus36kbyeZzQs3T9UzTZFIlOvhuTx
         sBq2yTBaFCwzCTnDh4T5b+Lk/Uksx1RwmwqjXA34yJ5aaPLYbDF3n0cz0IH7O66J+p7f
         D6B5fwYs5KLXyrVoQ6CDpQgwAmBXQYfk9FsTRZyzKfncHiaBcHpORalWEiLL5mI226d1
         mTZNHwLTgE97p5f4vURTH3zkSaEgM65kH722HxIBLhGAjtw5ExBlXQS4QtKsKWpfvJpH
         EdqPpnGSCnoEhCyWXLlSWHk01viIc49AREZw7T/EyEOaFzeCURos7oxx/7yL1XWwh7SU
         l4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965262; x=1784570062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wTazow5AK7oQsOPc1YIhM/ohcZWShlTcPJrS3UikzxY=;
        b=OzH5Dl9UoiynklPR9x4pW3QAYA0Obi6kMEyxBConPaNLzdkKY5nNT8CtkO/S/1WnY0
         xR9cbuUSJIJeIw/Fgdchg6pbbZtzgqyA6CaHMCJNpNz2epLDWqfUvFZzqQg5sgtxnjDn
         /eY29sWoh39nVF/7dIKLsDwV5Fc0lEf7yo0cefCDYmLmmat7qW2yRFUflDUvEd0dquzO
         NQwN4fSUx1pOjGvECvqK5FZ5I6F9ZTJjGZ/gGsWWdPcyIyDwcjpSA6MT7zOwzLfkq/bT
         Rw5HhydxxnTAbi/2aZw8cKV6rpQG3bAVobFteM+xIAbNPwKvHbscOFJlsjiHADkVjCpS
         ZjWg==
X-Forwarded-Encrypted: i=1; AFNElJ+tMt4b6BgGq26l2CMSxu/BTqhp7zbJPVHnbuEWydRZxASSbBLGsvKsCrhDeuPcnZAI+HvOaXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrhZCJheIucae9DO95jtn0kJLYkTSli7KxFuAQIS5InkKRbe8
	0exleg++bFqvhrtlFXF/voPINRfcavmixMFVbR7e5UHU/EA6ildNUBVk
X-Gm-Gg: AfdE7cl3xVqpWYGpFunDu5WjxqUoAQlZhKjudl0qn/6EDAWGH5raNHL4CsWDIgjcT1h
	5FBxGNXSVmvAhqpRPYO0vgd2JmTnEfvKnpDzPcHXgZsZOdRkILcNA6yYkl+foHkrqNswKH4K6yP
	iV09lPmyrdBOwyBUNJcqSlPwRhew04n8cTGTDWZxgiNNie6oKLDhBL5gd1sp0o99heiso/3QlGv
	sQitjfmOUZrRDUr4MG8K8pN7BuaQ0KMWQImm9R1/+8F+xEkQv/Bs/tJ+l55zhFCVlgOUNXq9hdU
	Ko7mnLS0UifKmS1E22q2kyBPKoZpzfMSqbG7bGiaZeumn8jJYyrFVOp9YQMWtemDEk7ACQXVRJz
	m0OtZ3SK6GAKG6Dua43Zrh9rdwaT6U1hD9uMrQ4HyOZuy//3OMhkpV6QSCvUxCeHDbQOif+IZbe
	WhkR97aEJaiMeM9scSNFPGhVUv0QivUQQOvumNDXiG1wbzG2fNW9xxGBMZyK+5vQMo9l+LQ6WPU
	Js=
X-Received: by 2002:a05:6830:6995:b0:7e6:d54e:8fe3 with SMTP id 46e09a7af769-7ec09678204mr6662957a34.9.1783965262313;
        Mon, 13 Jul 2026 10:54:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm13630238a34.8.2026.07.13.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:54:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] fuse: publish io-uring queues with release semantics
Date: Mon, 13 Jul 2026 10:53:45 -0700
Message-ID: <20260713175345.2542331-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713175345.2542331-1-joannelkoong@gmail.com>
References: <20260713175345.2542331-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273931-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:bernd@bsbernd.com,m:fuse-devel@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEE2E74E39E

fuse_uring_create_queue() initializes a fuse_ring_queue and then
publishes the pointer into ring->queues[qid] with WRITE_ONCE() under the
fch->lock. On the reader side, fuse_uring_register() reads that pointer
on a fast path locklessly with

	queue = ring->queues[qid];

There's no barrier that orders the initialization/setup of the queue's
fields and the WRITE_ONCE() that publishes the queue. As a result, the
lockless concurrent reader can see a non-null queue but uninitialized
queue fields (eg spinlock and list heads) and then operate on
uninitialized memory.

Publish the queue with smp_store_release() and read it on the lockless
fast path with smp_load_acquire().

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..0ea142d6670b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -321,9 +321,12 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	}
 
 	/*
-	 * write_once and lock as the caller mostly doesn't take the lock at all
+	 * fch->lock serializes concurrent creators for this qid.
+	 * smp_store_release() is for the lockless reader in
+	 * fuse_uring_register(), which pairs it with smp_load_acquire() and
+	 * must see the fully initialized queue if it sees a non-null queue
 	 */
-	WRITE_ONCE(ring->queues[qid], queue);
+	smp_store_release(&ring->queues[qid], queue);
 	spin_unlock(&fch->lock);
 
 	return queue;
@@ -1191,7 +1194,8 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	queue = ring->queues[qid];
+	/* Pairs with smp_store_release() in fuse_uring_create_queue() */
+	queue = smp_load_acquire(&ring->queues[qid]);
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
-- 
2.52.0


