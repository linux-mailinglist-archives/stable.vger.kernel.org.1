Return-Path: <stable+bounces-78585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EBB98C752
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6171F22888
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F11C1AC9;
	Tue,  1 Oct 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H90bTaft"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFDC19F42F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816980; cv=none; b=UKEJ056X9g6xoWwxT9GhECu8dAWb5bg0p9V0dnuXkt8xITgcld9LqgyUqe+LCoMLt73OLOrK/c6GtJ6j4i0gXC4/uyockD6ZdrMsDpRQPTSDz0hsYyKVLp63JbqVlqqe6F6j6goGUwoBQVaeTI9Juc2nuNdi33nY6pbY5mvw2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816980; c=relaxed/simple;
	bh=FxSb3O3aeGaeOAztFK8Kz/1ZaGaNdj73FIAA+ouDxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJ+sOt/RYt8XW+HBEBFJLaEKOTQdL8e/U9hCdxvRRcybWeZ/zJwR4+E0BhRLtNGPNG/d5qb95UC9DoUmNIXZsvATKRbC7tzbMvSTsi7KygSMRgdQ3+3rEq2giNuSTmYdZrygSgMpYQbzCeQo7YNUO7OXeTL21yRRVQpVJI9sA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H90bTaft; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e06acff261so4407442a91.2
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 14:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816977; x=1728421777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNclUftA+2fVW4dk17EgTfTt0frBJ481qKsl0epyaOg=;
        b=H90bTaft4NkGbVGLBC1agDFBUcUOzLA/jAoqTUgFFgKINMbgSc/rguUDEkXnvd834x
         DY/hM5ohD9uZ1KkhLqzYj+xZVNYF4S/KQ//7d7A1/NM8LLLaaOTECVmrXhteVl3aTHq1
         Ly+dJI0iN+qkSqcctWBj1TLDWQE8yZjcX5JNakfCI7vBCWKgalMP0l8tx+hxnxGYQbss
         +oblUh4LwFuSojwRvgUjY0fgn9QHk7Gt7CIjjEI+hYnaNGA8mKSDJ8BGyGrT5iTBY5DI
         RpOoiHlsGdXpOLZv2szpq/V0vjv1wf+VbgRHVx1hYijb6GXe9ENPjnwumqgVh6kwsT2w
         qMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816977; x=1728421777;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNclUftA+2fVW4dk17EgTfTt0frBJ481qKsl0epyaOg=;
        b=gXzxK0YxWspLJ/6UJUUVoQWK3enAF/1o01903i5Fr8yiS0C97/Pvp69cDwjdwQWvrR
         VZkDs5KhQ366ixbzMNxuJn0E/ZHT7KSZAZT77yP15yo5nJxv44ASxBzfZki0pqfhjXE6
         9O+k6MZEHvsL2pIqE83a+H0VZuGy8PO89PnqwZ8Lq07Nu+LFbRpfQ4vwZrEwwJ9zXDvx
         GUeQFEVB3WGJZysVR3hbDWSlaEi3mUSYin9cacWOyL/EWBmx4l4AkyRvQevuyQ8l4Foo
         EcUmMkrn4oD5tOo1Gwbg2vu8x2oq41jsufm7qjjEfDp9Zd+D2R3S88rC0nKPS1QB6JU6
         +p+w==
X-Gm-Message-State: AOJu0YwftlqFQQRHeCDPa0HhMan9NCo8vcn43ud9eNLyradPuksPPUk7
	EdBunWIfCLJ+4rfYuzRal7lWjY2zjl/Ibm3TozJxH2+hIcC32vO/JUJVYmQXc9g=
X-Google-Smtp-Source: AGHT+IFg8Ppp1Gar5wmrOeGeA4vy7W9AM1OrbCrF/AyWe/wly/E541zd94zhqgV0RH5Q4IOOzzbZlQ==
X-Received: by 2002:a17:90a:fa4b:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2e18466d52amr1249361a91.13.1727816977292;
        Tue, 01 Oct 2024 14:09:37 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f798037sm34307a91.25.2024.10.01.14.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Oct 2024 14:09:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	David Howells <dhowells@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>,
	Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@meta.com>,
	Sam James <sam@gentoo.org>,
	Daniel Dao <dqminh@cloudflare.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 6.6.y 2/3] lib/xarray: introduce a new helper xas_get_order
Date: Wed,  2 Oct 2024 05:06:24 +0800
Message-ID: <20241001210625.95825-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001210625.95825-1-ryncsn@gmail.com>
References: <20241001210625.95825-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

commit a4864671ca0bf51c8e78242951741df52c06766f upstream.

It can be used after xas_load to check the order of loaded entries.
Compared to xa_get_order, it saves an XA_STATE and avoid a rewalk.

Added new test for xas_get_order, to make the test work, we have to export
xas_get_order with EXPORT_SYMBOL_GPL.

Also fix a sparse warning by checking the slot value with xa_entry instead
of accessing it directly, as suggested by Matthew Wilcox.

[kasong@tencent.com: simplify comment, sparse warning fix, per Matthew Wilcox]
  Link: https://lkml.kernel.org/r/20240416071722.45997-4-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20240415171857.19244-4-ryncsn@gmail.com
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6758c1128ceb ("mm/filemap: optimize filemap folio adding")
---
 include/linux/xarray.h |  6 ++++++
 lib/test_xarray.c      | 34 +++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++++++++++++++----------------
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 44dd6d6e01bc..0e2feb72e9e5 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1530,6 +1530,7 @@ void xas_create_range(struct xa_state *);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
+int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 #else
@@ -1538,6 +1539,11 @@ static inline int xa_get_order(struct xarray *xa, unsigned long index)
 	return 0;
 }
 
+static inline int xas_get_order(struct xa_state *xas)
+{
+	return 0;
+}
+
 static inline void xas_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..2e229012920b 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1756,6 +1756,39 @@ static noinline void check_get_order(struct xarray *xa)
 	}
 }
 
+static noinline void check_xas_get_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned int order;
+	unsigned long i, j;
+
+	for (order = 0; order < max_order; order++) {
+		for (i = 0; i < 10; i++) {
+			xas_set_order(&xas, i << order, order);
+			do {
+				xas_lock(&xas);
+				xas_store(&xas, xa_mk_value(i));
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			for (j = i << order; j < (i + 1) << order; j++) {
+				xas_set_order(&xas, j, 0);
+				rcu_read_lock();
+				xas_load(&xas);
+				XA_BUG_ON(xa, xas_get_order(&xas) != order);
+				rcu_read_unlock();
+			}
+
+			xas_lock(&xas);
+			xas_set_order(&xas, i << order, order);
+			xas_store(&xas, NULL);
+			xas_unlock(&xas);
+		}
+	}
+}
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -1805,6 +1838,7 @@ static int xarray_checks(void)
 	check_reserve(&xa0);
 	check_multi_store(&array);
 	check_get_order(&array);
+	check_xas_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/lib/xarray.c b/lib/xarray.c
index e9bd29826e8b..341878f98c5b 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1752,39 +1752,52 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 EXPORT_SYMBOL(xa_store_range);
 
 /**
- * xa_get_order() - Get the order of an entry.
- * @xa: XArray.
- * @index: Index of the entry.
+ * xas_get_order() - Get the order of an entry.
+ * @xas: XArray operation state.
+ *
+ * Called after xas_load, the xas should not be in an error state.
  *
  * Return: A number between 0 and 63 indicating the order of the entry.
  */
-int xa_get_order(struct xarray *xa, unsigned long index)
+int xas_get_order(struct xa_state *xas)
 {
-	XA_STATE(xas, xa, index);
-	void *entry;
 	int order = 0;
 
-	rcu_read_lock();
-	entry = xas_load(&xas);
-
-	if (!entry)
-		goto unlock;
-
-	if (!xas.xa_node)
-		goto unlock;
+	if (!xas->xa_node)
+		return 0;
 
 	for (;;) {
-		unsigned int slot = xas.xa_offset + (1 << order);
+		unsigned int slot = xas->xa_offset + (1 << order);
 
 		if (slot >= XA_CHUNK_SIZE)
 			break;
-		if (!xa_is_sibling(xas.xa_node->slots[slot]))
+		if (!xa_is_sibling(xa_entry(xas->xa, xas->xa_node, slot)))
 			break;
 		order++;
 	}
 
-	order += xas.xa_node->shift;
-unlock:
+	order += xas->xa_node->shift;
+	return order;
+}
+EXPORT_SYMBOL_GPL(xas_get_order);
+
+/**
+ * xa_get_order() - Get the order of an entry.
+ * @xa: XArray.
+ * @index: Index of the entry.
+ *
+ * Return: A number between 0 and 63 indicating the order of the entry.
+ */
+int xa_get_order(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	int order = 0;
+	void *entry;
+
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	if (entry)
+		order = xas_get_order(&xas);
 	rcu_read_unlock();
 
 	return order;
-- 
2.46.1


