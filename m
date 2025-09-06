Return-Path: <stable+bounces-178008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CDB4776A
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031715A0CA6
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DD3284679;
	Sat,  6 Sep 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twAmqSqb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6025315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193934; cv=none; b=qcwK7GWUZfg+ODr25uvhaSuHrMC1ayo1O4ZP3Cf0501LRVGfMgQtAeW/3umD62ANDlWxg6FO7k+yedf0xnQgX37picYczxyWgYsVh344RkcT5fIX5Ss577kjivXu80BzMWiFrKXmEb/EdLGhaKZ3VCKpBQDyZfd9PVaENU5c6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193934; c=relaxed/simple;
	bh=ezVzwnuwxgJHWw1/TuXST0aCLoeEBNcZiIdH+prc9/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ2zuRGD67xRkWQpfxM7EZIKkpF0RXa5m/pj6XBLErUrG+SS5L4lY7FSI381fyk/dtNDiVoTgTdVT2gDdcdGzaaBY4J4jW+So/H7UFEBhATqhqV6b1ObODrMKt+ez6p2MHEGrVfkUXmapZWGtdCmikA/6REvu2/fo+mTpwMUdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twAmqSqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E719CC4CEF8;
	Sat,  6 Sep 2025 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757193934;
	bh=ezVzwnuwxgJHWw1/TuXST0aCLoeEBNcZiIdH+prc9/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twAmqSqbVOBd3MbGpfFPP4sjUNEDYvArLVtpxeatUVU5UmA25q0lp4eSPSNSSrO7u
	 nAEuNf/amRxhsWFIJ1e5ZNUdQw/YxnHSR70fhgIhPojEuOf0G20POSvtrS+rCUc4bf
	 x1ZUAAuAQc058PEahWHixPYT43rBYgoCX90OpF6B7MGQuVqk/F3emLNdDxy5NLupi3
	 jwUgg7IMQ+nW+VxqmeoHtjkJe49Uc3Svk9vK2V8c+DrdFtI2jkUH/Os5onS2iQwcBD
	 E49Cm9YSE137FvziQvTH7qUlc9EBb+kGXSJK8YVzyhnbZR1kY9/1StTyKtKd73TdB1
	 VH3PTOPgCkZJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] mm: slub: call WARN() when detecting a slab corruption
Date: Sat,  6 Sep 2025 17:25:28 -0400
Message-ID: <20250906212530.302670-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906212530.302670-1-sashal@kernel.org>
References: <2025090618-patient-manlike-340f@gregkh>
 <20250906212530.302670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyesoo Yu <hyesoo.yu@samsung.com>

[ Upstream commit 3f6f32b14ab35452d2ed52f7821cf2829923c98d ]

If a slab object is corrupted or an error occurs in its internal
validation, continuing after restoration may cause other side effects.
At this point, it is difficult to debug because the problem occurred in
the past. It is useful to use WARN() to catch errors at the point of
issue because WARN() could trigger panic for system debugging when
panic_on_warn is enabled. WARN() is added where to detect the error on
slab_err and object_err.

It makes sense to only do the WARN() after printing the logs. slab_err
is splited to __slab_err that calls the WARN() and it is called after
printing logs.

Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: b4efccec8d06 ("mm/slub: avoid accessing metadata when pointer is invalid in object_err()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slub.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7282beba8ec5e..f6323fac6a026 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1036,7 +1036,7 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	pr_err("=============================================================================\n");
-	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
+	pr_err("BUG %s (%s): %pV\n", s ? s->name : "<unknown>", print_tainted(), &vaf);
 	pr_err("-----------------------------------------------------------------------------\n\n");
 	va_end(args);
 }
@@ -1095,8 +1095,6 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
 			      size_from_object(s) - off);
-
-	dump_stack();
 }
 
 static void object_err(struct kmem_cache *s, struct slab *slab,
@@ -1108,6 +1106,8 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 	slab_bug(s, "%s", reason);
 	print_trailer(s, slab, object);
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
 }
 
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
@@ -1124,6 +1124,17 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+static void __slab_err(struct slab *slab)
+{
+	if (slab_in_kunit_test())
+		return;
+
+	print_slab_info(slab);
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+
+	WARN_ON(1);
+}
+
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 			const char *fmt, ...)
 {
@@ -1137,9 +1148,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 	vsnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 	slab_bug(s, "%s", buf);
-	print_slab_info(slab);
-	dump_stack();
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	__slab_err(slab);
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -1312,9 +1321,10 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	while (end > fault && end[-1] == POISON_INUSE)
 		end--;
 
-	slab_err(s, slab, "Padding overwritten. 0x%p-0x%p @offset=%tu",
-			fault, end - 1, fault - start);
+	slab_bug(s, "Padding overwritten. 0x%p-0x%p @offset=%tu",
+		 fault, end - 1, fault - start);
 	print_section(KERN_ERR, "Padding ", pad, remainder);
+	__slab_err(slab);
 
 	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
 }
@@ -1630,12 +1640,12 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
 				 object);
 		} else if (!slab->slab_cache) {
-			pr_err("SLUB <none>: no slab for object 0x%p.\n",
-			       object);
-			dump_stack();
-		} else
+			slab_err(NULL, slab, "No slab cache for object 0x%p",
+				 object);
+		} else {
 			object_err(s, slab, object,
-					"page slab pointer corrupt.");
+				   "page slab pointer corrupt.");
+		}
 		return 0;
 	}
 	return 1;
@@ -5440,14 +5450,14 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
-static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
-			      const char *text)
+static void list_slab_objects(struct kmem_cache *s, struct slab *slab)
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = slab_address(slab);
 	void *p;
 
-	slab_err(s, slab, text, s->name);
+	if (!slab_add_kunit_errors())
+		slab_bug(s, "Objects remaining on __kmem_cache_shutdown()");
 
 	spin_lock(&object_map_lock);
 	__fill_map(object_map, s, slab);
@@ -5462,6 +5472,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
 		}
 	}
 	spin_unlock(&object_map_lock);
+
+	__slab_err(slab);
 #endif
 }
 
@@ -5482,8 +5494,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
 			remove_partial(n, slab);
 			list_add(&slab->slab_list, &discard);
 		} else {
-			list_slab_objects(s, slab,
-			  "Objects remaining in %s on __kmem_cache_shutdown()");
+			list_slab_objects(s, slab);
 		}
 	}
 	spin_unlock_irq(&n->list_lock);
-- 
2.51.0


