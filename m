Return-Path: <stable+bounces-82135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2A994B50
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D527F288CEA
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1B1DF971;
	Tue,  8 Oct 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOGZ42Ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886E11DF966;
	Tue,  8 Oct 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391270; cv=none; b=F1RIyQB6IJuvHeIBnSRfM8FkaVKZp6sxPQYahqllSqOszhKEjhzoamm7QWSuwCrMXe3pFljbwqRSYzs5O6MV3SwrznbhOk08zGp72BvEv5gooSPyigywy2HRTjhTIcL6mqLJVRHfv9VI5rVtcsfB7vbmWlLLpmJ041ZW44m3MR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391270; c=relaxed/simple;
	bh=3dpGET+NFcvvfQRfFn9OpVdZSb7v6cATozuUz6W6J6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxs5yy2xbbetj2I0YJxdoFEWC7zhZKgdUKvpTe/OrPnC0nZYD6rg4y22JXwc9AbFN28Q/iLttosb2KUXaThPrvx3k/sY0+eSk8EOxN/4AcRVd0SrONkyFfVLJZKQBT+QXhYMlUIFB/ooh37dqwUJAm8D1+YGr2UcfZogEccncmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOGZ42Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0488CC4CEC7;
	Tue,  8 Oct 2024 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391270;
	bh=3dpGET+NFcvvfQRfFn9OpVdZSb7v6cATozuUz6W6J6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOGZ42ObqamF8QSk5Cs2M7IPfiJdyISxfYJovbLFV2973NkIZg+lFZemT0NVT4Zvd
	 qPDCvfLpAFkFpERzYl43TBtua4PKFESGXyBX/S6E3EYKYQ9IEZaSrgpsbQkB3i+ZXc
	 2QYbfgH0rl+6yY4y0GBahQVzmLJDoH23H2eUFdnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gary Guo <gary@garyguo.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 061/558] rust: kbuild: auto generate helper exports
Date: Tue,  8 Oct 2024 14:01:31 +0200
Message-ID: <20241008115704.621792380@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gary Guo <gary@garyguo.net>

[ Upstream commit e26fa546042add70944d018b930530d16b3cf626 ]

This removes the need to explicitly export all symbols.

Generate helper exports similarly to what's currently done for Rust
crates. These helpers are exclusively called from within Rust code and
therefore can be treated similar as other Rust symbols.

Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240817165302.3852499-1-gary@garyguo.net
[ Fixed dependency path, reworded slightly, edited comment a bit and
  rebased on top of the changes made when applying Andreas' patch
  (e.g. no `README.md` anymore, so moved the edits).  - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Stable-dep-of: d065cc76054d ("rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile            | 16 ++++++++++++++--
 rust/exports.c           |  1 +
 rust/helpers/blk.c       |  2 --
 rust/helpers/bug.c       |  1 -
 rust/helpers/build_bug.c |  1 -
 rust/helpers/err.c       |  3 ---
 rust/helpers/helpers.c   | 13 -------------
 rust/helpers/kunit.c     |  1 -
 rust/helpers/mutex.c     |  1 -
 rust/helpers/page.c      |  3 ---
 rust/helpers/refcount.c  |  3 ---
 rust/helpers/signal.c    |  1 -
 rust/helpers/slab.c      |  1 -
 rust/helpers/spinlock.c  |  3 ---
 rust/helpers/task.c      |  3 ---
 rust/helpers/uaccess.c   |  2 --
 rust/helpers/wait.c      |  1 -
 rust/helpers/workqueue.c |  1 -
 18 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index acfb8d7feba7e..2aa93007aacae 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -16,8 +16,8 @@ no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
-always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
-    exports_kernel_generated.h
+always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
+    exports_bindings_generated.h exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -313,6 +313,18 @@ $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 $(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
 	$(call if_changed,exports)
 
+# Even though Rust kernel modules should never use the bindings directly,
+# symbols from the `bindings` crate and the C helpers need to be exported
+# because Rust generics and inlined functions may not get their code generated
+# in the crate where they are defined. Other helpers, called from non-inline
+# functions, may not be exported, in principle. However, in general, the Rust
+# compiler does not guarantee codegen will be performed for a non-inline
+# function either. Therefore, we export all symbols from helpers and bindings.
+# In the future, this may be revisited to reduce the number of exports after
+# the compiler is informed about the places codegen is required.
+$(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
+	$(call if_changed,exports)
+
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
diff --git a/rust/exports.c b/rust/exports.c
index 3803c21d1403e..e5695f3b45b7a 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -17,6 +17,7 @@
 
 #include "exports_core_generated.h"
 #include "exports_alloc_generated.h"
+#include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
 
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
index d99c965eb59bf..cc9f4e6a2d234 100644
--- a/rust/helpers/blk.c
+++ b/rust/helpers/blk.c
@@ -7,10 +7,8 @@ void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
 {
 	return blk_mq_rq_to_pdu(rq);
 }
-EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
 
 struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
 {
 	return blk_mq_rq_from_pdu(pdu);
 }
-EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
diff --git a/rust/helpers/bug.c b/rust/helpers/bug.c
index e2afbad23dcda..e2d13babc7371 100644
--- a/rust/helpers/bug.c
+++ b/rust/helpers/bug.c
@@ -6,4 +6,3 @@ __noreturn void rust_helper_BUG(void)
 {
 	BUG();
 }
-EXPORT_SYMBOL_GPL(rust_helper_BUG);
diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
index f3106f248485a..e994f7b5928c0 100644
--- a/rust/helpers/build_bug.c
+++ b/rust/helpers/build_bug.c
@@ -7,4 +7,3 @@ const char *rust_helper_errname(int err)
 {
 	return errname(err);
 }
-EXPORT_SYMBOL_GPL(rust_helper_errname);
diff --git a/rust/helpers/err.c b/rust/helpers/err.c
index fba4e0be64f59..be3d45ef78a25 100644
--- a/rust/helpers/err.c
+++ b/rust/helpers/err.c
@@ -7,16 +7,13 @@ __force void *rust_helper_ERR_PTR(long err)
 {
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
 
 bool rust_helper_IS_ERR(__force const void *ptr)
 {
 	return IS_ERR(ptr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
 
 long rust_helper_PTR_ERR(__force const void *ptr)
 {
 	return PTR_ERR(ptr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 2b54f22e87741..173533616c917 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -4,19 +4,6 @@
  * cannot be called either. This file explicitly creates functions ("helpers")
  * that wrap those so that they can be called from Rust.
  *
- * Even though Rust kernel modules should never use the bindings directly, some
- * of these helpers need to be exported because Rust generics and inlined
- * functions may not get their code generated in the crate where they are
- * defined. Other helpers, called from non-inline functions, may not be
- * exported, in principle. However, in general, the Rust compiler does not
- * guarantee codegen will be performed for a non-inline function either.
- * Therefore, this file exports all the helpers. In the future, this may be
- * revisited to reduce the number of exports after the compiler is informed
- * about the places codegen is required.
- *
- * All symbols are exported as GPL-only to guarantee no GPL-only feature is
- * accidentally exposed.
- *
  * Sorted alphabetically.
  */
 
diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
index 905e4ff4424a5..9d725067eb3bc 100644
--- a/rust/helpers/kunit.c
+++ b/rust/helpers/kunit.c
@@ -7,4 +7,3 @@ struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
 }
-EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
index 29fd141c387d7..200db7e6279f0 100644
--- a/rust/helpers/mutex.c
+++ b/rust/helpers/mutex.c
@@ -7,4 +7,3 @@ void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index 7fd333411a88f..b3f2b8fbf87fc 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -7,16 +7,13 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages(gfp_mask, order);
 }
-EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
 
 void *rust_helper_kmap_local_page(struct page *page)
 {
 	return kmap_local_page(page);
 }
-EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
 
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
 }
-EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index 13ab64805f779..f47afc148ec36 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,16 +7,13 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
 
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
-EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
 
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
 }
-EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
index d44e8096b8a96..63c407f80c26b 100644
--- a/rust/helpers/signal.c
+++ b/rust/helpers/signal.c
@@ -7,4 +7,3 @@ int rust_helper_signal_pending(struct task_struct *t)
 {
 	return signal_pending(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
diff --git a/rust/helpers/slab.c b/rust/helpers/slab.c
index 3e0a1a173d8a7..f043e087f9d66 100644
--- a/rust/helpers/slab.c
+++ b/rust/helpers/slab.c
@@ -7,4 +7,3 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 {
 	return krealloc(objp, new_size, flags);
 }
-EXPORT_SYMBOL_GPL(rust_helper_krealloc);
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 04fd8ddb4986d..acc1376b833c7 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -12,16 +12,13 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 	spin_lock_init(lock);
 #endif
 }
-EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
 
 void rust_helper_spin_lock(spinlock_t *lock)
 {
 	spin_lock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
 
 void rust_helper_spin_unlock(spinlock_t *lock)
 {
 	spin_unlock(lock);
 }
-EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index b176c347f0d41..7ac789232d11c 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -7,16 +7,13 @@ struct task_struct *rust_helper_get_current(void)
 {
 	return current;
 }
-EXPORT_SYMBOL_GPL(rust_helper_get_current);
 
 void rust_helper_get_task_struct(struct task_struct *t)
 {
 	get_task_struct(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
 
 void rust_helper_put_task_struct(struct task_struct *t)
 {
 	put_task_struct(t);
 }
-EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
index 3d004ac1c1805..f49076f813cd6 100644
--- a/rust/helpers/uaccess.c
+++ b/rust/helpers/uaccess.c
@@ -7,11 +7,9 @@ unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
 {
 	return copy_from_user(to, from, n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
 
 unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 				       unsigned long n)
 {
 	return copy_to_user(to, from, n);
 }
-EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
index bf361f40c7cbc..c7336bbf27507 100644
--- a/rust/helpers/wait.c
+++ b/rust/helpers/wait.c
@@ -7,4 +7,3 @@ void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_wait);
diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
index 12e2ee66aa4f6..f59427acc3237 100644
--- a/rust/helpers/workqueue.c
+++ b/rust/helpers/workqueue.c
@@ -13,4 +13,3 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 	INIT_LIST_HEAD(&work->entry);
 	work->func = func;
 }
-EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
-- 
2.43.0




