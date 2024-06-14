Return-Path: <stable+bounces-52206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A820C908D71
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E87287F35
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02000F4EE;
	Fri, 14 Jun 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vog70K8s"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B6D51C
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375572; cv=none; b=qwU8mciKgxriDGFRmoEWFZVl5AkLIqaPzFC94sRWAvI2Wuxd0eT26H55b4uatEB8AZb02/xYNtsAsFFe+1eEakxzmcpP56CuG52vKYS3QW9jjXBpXOkPA0NWHnMalWOGhGjP3xSwLjIcSccnl2KSfbKgRurJUUdFwhSh+lE9Efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375572; c=relaxed/simple;
	bh=JGJBAZFgEDVwsfbp8Nm4QSiGVzE0S38UYkGCzfduj4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dpht6jg4t/WC8R9CM0F2XlpD4KncIx0gx9h7mijSobLj6x/NfdHIYSXtdMvMNgkZzBHeNjeq5gZBcw+R4mcMO4q6XLtdqBh733A0xq964L2YKHc8PSUAXY3iQL0XYTBRRiqdpQHxAxnpfZuwg38Za88n1FITuBQa1am9L74lv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vog70K8s; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718375567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oKGgulHI+TDI8kNJgxolYwa/zBW01wITWhncfioM0zI=;
	b=Vog70K8se6pQCOes6SgIF2PL/qN2bK1cf5TB6JsDLVUeDtIz0ZYJD7dEo85/J7yLYLznaJ
	HTGZZGW3DEcq7zn/muU05dwd7FZkMQtMJ3uq92PJUaAEKp5UVCENwCYuhM0KVF838BPeId
	7uO4pMlYht90PiYbs2F2VlyRkJ5YusE=
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: elver@google.com
X-Envelope-To: glider@google.com
X-Envelope-To: dvyukov@google.com
X-Envelope-To: ryabinin.a.a@gmail.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: spender@grsecurity.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: stable@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Brad Spengler <spender@grsecurity.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] kasan: fix bad call to unpoison_slab_object
Date: Fri, 14 Jun 2024 16:32:38 +0200
Message-Id: <20240614143238.60323-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

Commit 29d7355a9d05 ("kasan: save alloc stack traces for mempool") messed
up one of the calls to unpoison_slab_object: the last two arguments are
supposed to be GFP flags and whether to init the object memory.

Fix the call.

Without this fix, __kasan_mempool_unpoison_object provides the object's
size as GFP flags to unpoison_slab_object, which can cause LOCKDEP
reports (and probably other issues).

Fixes: 29d7355a9d05 ("kasan: save alloc stack traces for mempool")
Reported-by: Brad Spengler <spender@grsecurity.net>
Cc: stable@vger.kernel.org
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

Changes v1->v2:
- Fix typo in commit message.
- CC stable.
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e7c9a4dc89f8..85e7c6b4575c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -532,7 +532,7 @@ void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 		return;
 
 	/* Unpoison the object and save alloc info for non-kmalloc() allocations. */
-	unpoison_slab_object(slab->slab_cache, ptr, size, flags);
+	unpoison_slab_object(slab->slab_cache, ptr, flags, false);
 
 	/* Poison the redzone and save alloc info for kmalloc() allocations. */
 	if (is_kmalloc_cache(slab->slab_cache))
-- 
2.25.1


