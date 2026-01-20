Return-Path: <stable+bounces-210576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MFsHmLLb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:37:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7E49933
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57D4438D615
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501D31B814;
	Tue, 20 Jan 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gn4jbD0A"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC527E074
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925775; cv=none; b=aUvLonAODbfGc3TR/8PAz/6E7VvbHkEV4LeP5snvTX+L/+Xhc3R4FIFXWT83hmjIycNNGnQlIKn50njQ4Qv0kPUTmw4KzjTLQQCbqri9L6/AEgXXUlm/wBOn4reXGf9Hj5Q4oIjT5bjG9kuPHCpUt8U3lvBTBw+mHQ7rnUeQFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925775; c=relaxed/simple;
	bh=cx6fHJOVY7EpVdxfguIigjRygA1bknBX31Ik7S2yhWo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lnJG4vf7osobyq95TJ4dOZZQgLw8ecIvTMo3lzhNvKJrLh+lFFSj7fACnD5ZQHjmA/rJRx3Awa9gFyXLO4VEjcHFOiTD+bRG3phcVsFehpeg2hnQzzzEvq8GyCSKWWJ5NJi40N8EZQtCvYuQFE+RD6y4C/9YDy1s/l5PEA5v0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gn4jbD0A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pimyn.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4801d21c280so33305865e9.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768925772; x=1769530572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zECdq2qx8LIRzMbM9dI3FS5kU++am0Lig5cv/EMeCDY=;
        b=gn4jbD0AapBrx1aP4Vfk5X8D1PKDZ3d5mA308Or6aYJUrlrbarSGGQ6DTA+NYCqu6/
         HdHo8o3ZF7FJGSulNFsZLmhLfVTCTToK982rlYsnfg4NN6+7dQ13vW1guWNW5avIW8aJ
         Cg/Awg22EaLh+uFOGowsjLENSqexklsqljTClzTAjnNWz/FcCZrmYaHUQqCFUEGCuemx
         eiUHYs+x1keKbzdwkV91zYuY4MtqtziXXEO4V1C+If6ErrJBC1zIUu3DVY9bBpLSBwk6
         Vlo0uuAsX5t88a/VlOhJoA7yOiKnc6+MHAjZHeMxMUHmYzVcsqJlnA0XcMFYZFNA2QJ6
         xUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925772; x=1769530572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zECdq2qx8LIRzMbM9dI3FS5kU++am0Lig5cv/EMeCDY=;
        b=k/GpGc9/butKqJraoGW8/uBxrjSbxOPzVn2aTJjdbudXWNtMV0zSwTUGr7dGnPLxmH
         C0Ayh2v/0TZVh5VSDhwyIPc5MdZqIb2rUUpyltXOic/zBOwJlVPcz2L8k4VXVzzchwKL
         5HLl7psJcmq+B0KvjRlDlXrcD2gjiZPjinZsu8GG0SnIeQLZXyl03ruToS9/i1ebfvWM
         4KozCtNyzwAyfCYvkrtdTrLCzyDWvHgbzgzJEXceNJWYsiTUoCagrttqXzKtCKnE9RmS
         5jmoLwWmJSBHWKQ6MheoXzOflAIhgeB5z6SXRqJKmeqUW98KAgcAnSDlYs8iq+IXUYhA
         lKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUlRRsdrsnxoAKCahx4FIsbcYOWvc1KuyiZ4dPz2gqn+JWvaG7Oqcfgtq1L5K7/+uQ4dqcygQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3r3HrnWLu2uIO+Mu5OwaPLhHSEwumLYoj04pIsloP4R2VceK
	IA61T3zUxm2HGIuum/E9Ct9HRNLkmE3mDrZno/sCfviUdLC7o5qE6kR8joTtZCPaVFZl+BmWmDq
	ptw==
X-Received: from wmsm27.prod.google.com ([2002:a05:600c:3b1b:b0:477:9769:66d0])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b78:b0:47e:e8c2:905f
 with SMTP id 5b1f17b1804b1-4801e30a790mr216491795e9.8.1768925771811; Tue, 20
 Jan 2026 08:16:11 -0800 (PST)
Date: Tue, 20 Jan 2026 17:15:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120161510.3289089-1-pimyn@google.com>
Subject: [PATCH] mm/kfence: randomize the freelist on initialization
From: Pimyn Girgis <pimyn@google.com>
To: pimyn@google.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, elver@google.com, dvyukov@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_FROM(0.00)[bounces-210576-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pimyn@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 42F7E49933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Randomize the KFENCE freelist during pool initialization to make allocation
patterns less predictable. This is achieved by shuffling the order in which
metadata objects are added to the freelist using get_random_u32_below().

Additionally, ensure the error path correctly calculates the address range
to be reset if initialization fails, as the address increment logic has
been moved to a separate loop.

Cc: stable@vger.kernel.org
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Signed-off-by: Pimyn Girgis <pimyn@google.com>
---
 mm/kfence/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 577a1699c553..9e8b3cfd3f76 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -596,7 +596,7 @@ static void rcu_guarded_free(struct rcu_head *h)
 static unsigned long kfence_init_pool(void)
 {
 	unsigned long addr, start_pfn;
-	int i;
+	int i, rand;
 
 	if (!arch_kfence_init_pool())
 		return (unsigned long)__kfence_pool;
@@ -647,13 +647,27 @@ static unsigned long kfence_init_pool(void)
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
-		list_add_tail(&meta->list, &kfence_freelist);
+		/* Use addr to randomize the freelist. */
+		meta->addr = i;
 
 		/* Protect the right redzone. */
-		if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
+		if (unlikely(!kfence_protect(addr + 2 * i * PAGE_SIZE + PAGE_SIZE)))
 			goto reset_slab;
+	}
+
+	for (i = CONFIG_KFENCE_NUM_OBJECTS; i > 0; i--) {
+		rand = get_random_u32_below(i);
+		swap(kfence_metadata_init[i - 1].addr, kfence_metadata_init[rand].addr);
+	}
 
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta_1 = &kfence_metadata_init[i];
+		struct kfence_metadata *meta_2 = &kfence_metadata_init[meta_1->addr];
+
+		list_add_tail(&meta_2->list, &kfence_freelist);
+	}
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		kfence_metadata_init[i].addr = addr;
 		addr += 2 * PAGE_SIZE;
 	}
 
@@ -666,6 +680,7 @@ static unsigned long kfence_init_pool(void)
 	return 0;
 
 reset_slab:
+	addr += 2 * i * PAGE_SIZE;
 	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
 		struct page *page;
 
-- 
2.52.0.457.g6b5491de43-goog


