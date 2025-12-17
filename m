Return-Path: <stable+bounces-202828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B087CC8B8E
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6EB73037948
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28D3563CF;
	Wed, 17 Dec 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZxrr2cJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8135F8D0
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977054; cv=none; b=QAjYV6B74s5UzLja0EixwZ54KWY+Jfut8fN4EAFMyiTdYsl+spscSLfMfsUOuQjwzug9+idTpSKLXzwpKw/TFEYo0ZS8b30p1w+V9gnmaEm6FalL4UWKfgaS3z06DRvfDpR9hiY7qPeoPnoFLtshqtl8gWJLKtw6cSEH6IaH0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977054; c=relaxed/simple;
	bh=k7ah473lbDl4JL4MlfAcQeYPB9OEQ+mxsApvnfPnjng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L6WsexyS0kWrZlFVEq3gF4XGE19Wq44ZSpkyo6EU3fPBIowmNta4ssNbJSmM7vKsG/9kBKvl4n7gXyvRF9S5s6iwk4Az0ErU9JKADfw0j50jXHNPQ0PBQNhWzpnOu+Ga8My0Cp5qco4HxaPSwx6epLgFTi2M1/DqvQKhVQz3jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SZxrr2cJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so39832605e9.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765977048; x=1766581848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55z/kcnyK4/jomiZdp6n9WsDi2cwF/5hOkFlLeTTiF0=;
        b=SZxrr2cJ4ECPw1llPyN9XxILj3PaEimg7a4utvfOa4hii/RZCX/3ZR1jkLiyUmt3Zg
         EEEjeqjkQhwarc53AIWp+x/XoMMaUAIkpUz0bwAQFeQ7u0dbG/BHzsUJtYm8BV+PwR+/
         ffvJR2E4CpYbGMmjdhtTGSRQXSg5Zm0FWc1Z9TX5jSfSdeaT0oPMH80EBRyKaWSPHcv/
         cwBq1wQsxl6ly8arsvjvn3M1iJzKmmf0e8jHJ1KC2rRZOlC9hLYJeze93/TyGQF2j0Kn
         LbbgcTGL+I6cCkyIypZ512D71HWIGLhtVO3Klh9FXkKWy/2UswOoMpx+2xrTY1556kPI
         uFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765977048; x=1766581848;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55z/kcnyK4/jomiZdp6n9WsDi2cwF/5hOkFlLeTTiF0=;
        b=hdfoDSnoqrJ/7V93K6N0lSocvzavObI/rsuq51MrEMn+aqIqkAxxt34wT+MGIDfkVI
         EY2JxEz+/JWXFSmSz9Np3AMcR111OJqsmYD+oEgfaTPnULF5KVgduxRVLqLlE7fiLViw
         H63Tkum+YKojXeKJ25YOF27uO+9U/4lTWuDI+uwo3gasv+svnpKHivOZm6dJ2OOo6MXE
         tfr7zquPrw+hXt8+qF7iY9IXppH9nrW3voIQN+6KxtBIh2T1GizqllR+i79F+NJoV1Tl
         16+LUvobhUvlvxVvKFu7i5H6SqblNJOStx50CwUo1hS4roKDzXlVxuNZE3FPQbd29GGs
         Vw+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvNiB52wxtp2Dese9EvX5HF1nz9+ZXwaYxZekRdjgH0cdfA+NGvOkizKrAIc9UjAtx5wgr1Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMU6tkoK3ejLiNnVNWQJ/3fF1Echyimge+Bo6qpS9DKbaKxKR
	lN0N1pvzmmnvWC0YcJLr0d7h+zjvi/hqQ1qOzQa6CX8eYEwGOgCQzTJMf8s9dwR9a8pmLuiTqfV
	ltCjgmF3CiS33GYxfOA==
X-Google-Smtp-Source: AGHT+IGvw4zgme++j/6mCd0eYW7FhdEhTwz2nifrF5I4TlPoKnDQGwHnPqTVXe9HihQmPwoNHm1qcgNVLSM6sxA=
X-Received: from wrbbs15.prod.google.com ([2002:a05:6000:70f:b0:430:f5d7:eb5c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:186b:b0:430:f5ab:dc8e with SMTP id ffacd0b85a97d-430f5abdec7mr14495399f8f.13.1765977048487;
 Wed, 17 Dec 2025 05:10:48 -0800 (PST)
Date: Wed, 17 Dec 2025 13:10:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMyrQmkC/x3MQQqAIBBA0avIrBtISaKuEi1KxxqolJEiiO6et
 HyL/x/IJEwZevWA0MWZ41GgKwVunY6FkH0xmNpYbXSL+5Q2Qi8xobgTfaDWhNmGpiMoURIKfP/ DYXzfDzkU/lVgAAAA
X-Change-Id: 20251217-maple-drop-rcu-dfe72fb5f49e
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3923; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=k7ah473lbDl4JL4MlfAcQeYPB9OEQ+mxsApvnfPnjng=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpQqvOGiHo1F5JsZO6XBpXWRgaranpPKixIVKf4
 j/gRr7XyWyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaUKrzgAKCRAEWL7uWMY5
 RmrUD/0cJnplKl7x0+RCQdZX0u9m7BctBfwLBjcxJu+Ihrw+JDvFUIkVbFO4JlieGSegRZuf+5B
 6Rzl2TIGB63yx0bfOcdKed6ABKXdxxu4fD3fwwtPRX4PUMRKp7nmCYQXhjhGn57iHHoQ6GDCRIs
 pKlbvYWHagfWjkH0diRrw0wrili7zVWhw3DJAqK9vNwEtH+OhZJVrHTiOYfuVgYPGIVnxuALJb4
 2skHPG1u4KFFZYWBoRu4YJAybh9IWyqsanln3+P1YwM3HV5143x3IoMoHllIwSYQEPtJFk3bMtN
 JpvqE2adnQ1ASHzYlLfNmliv5bYIECFYcbM+r3OK8jPW1t6nacsCZjppSs5z6lNdIxlDgXFQsQs
 OOFnyaQifVxCKaInpWwMAdqHYwQJazIccYuFTM8fKJ4oL1SwKUuBGhB6eP3Ug6+WniFIZ8SQbE9
 0oECnzvBy3JG6P51A7npsmdOGxH+f1te5Y2aQNiAvWi1+0+PzleYU+Fcq+qjNTPQLK6o86vdRhK
 VNlD+7s8OBupGifiiUGEJuaj7Gv16qdYugvaWEDOm8xExxWVNLPCPqpqnAWtu+grhHbv3Sy76qy
 Iq+jL9GoWzwe0HnzXluEaf6bgHbFH67uUhGo7s7iszrg3CCObO1vjJnOKmQ69F5oeHksziTqWlv wu4NDmOHMnkjlDw==
X-Mailer: b4 0.14.2
Message-ID: <20251217-maple-drop-rcu-v1-1-702af063573f@google.com>
Subject: [PATCH] rust: maple_tree: rcu_read_lock() in destructor to silence lockdep
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When running the Rust maple tree kunit tests with lockdep, you may
trigger a warning that looks like this:

	lib/maple_tree.c:780 suspicious rcu_dereference_check() usage!

	other info that might help us debug this:

	rcu_scheduler_active = 2, debug_locks = 1
	no locks held by kunit_try_catch/344.

	stack backtrace:
	CPU: 3 UID: 0 PID: 344 Comm: kunit_try_catch Tainted: G                 N  6.19.0-rc1+ #2 NONE
	Tainted: [N]=TEST
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
	Call Trace:
	 <TASK>
	 dump_stack_lvl+0x71/0x90
	 lockdep_rcu_suspicious+0x150/0x190
	 mas_start+0x104/0x150
	 mas_find+0x179/0x240
	 _RINvNtCs5QSdWC790r4_4core3ptr13drop_in_placeINtNtCs1cdwasc6FUb_6kernel10maple_tree9MapleTreeINtNtNtBL_5alloc4kbox3BoxlNtNtB1x_9allocator7KmallocEEECsgxAQYCfdR72_25doctests_kernel_generated+0xaf/0x130
	 rust_doctest_kernel_maple_tree_rs_0+0x600/0x6b0
	 ? lock_release+0xeb/0x2a0
	 ? kunit_try_catch_run+0x210/0x210
	 kunit_try_run_case+0x74/0x160
	 ? kunit_try_catch_run+0x210/0x210
	 kunit_generic_run_threadfn_adapter+0x12/0x30
	 kthread+0x21c/0x230
	 ? __do_trace_sched_kthread_stop_ret+0x40/0x40
	 ret_from_fork+0x16c/0x270
	 ? __do_trace_sched_kthread_stop_ret+0x40/0x40
	 ret_from_fork_asm+0x11/0x20
	 </TASK>

This is because the destructor of maple tree calls mas_find() without
taking rcu_read_lock() or the spinlock. Doing that is actually ok in
this case since the destructor has exclusive access to the entire maple
tree, but it triggers a lockdep warning. To fix that, take the rcu read
lock.

In the future, it's possible that memory reclaim could gain a feature
where it reallocates entries in maple trees even if no user-code is
touching it. If that feature is added, then this use of rcu read lock
would become load-bearing, so I did not make it conditional on lockdep.

We have to repeatedly take and release rcu because the destructor of T
might perform operations that sleep.

Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/564215108
Fixes: da939ef4c494 ("rust: maple_tree: add MapleTree")
Cc: stable@vger.kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Intended for the same tree as any other maple tree patch. (I believe
that's Andrew Morton's tree.)
---
 rust/kernel/maple_tree.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index e72eec56bf5772ada09239f47748cd649212d8b0..265d6396a78a17886c8b5a3ebe7ba39ccc354add 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -265,7 +265,16 @@ unsafe fn free_all_entries(self: Pin<&mut Self>) {
         loop {
             // This uses the raw accessor because we're destroying pointers without removing them
             // from the maple tree, which is only valid because this is the destructor.
-            let ptr = ma_state.mas_find_raw(usize::MAX);
+            //
+            // Take the rcu lock because mas_find_raw() requires that you hold either the spinlock
+            // or the rcu read lock. This is only really required if memory reclaim might
+            // reallocate entries in the tree, as we otherwise have exclusive access. That feature
+            // doesn't exist yet, so for now, taking the rcu lock only serves the purpose of
+            // silencing lockdep.
+            let ptr = {
+                let _rcu = kernel::sync::rcu::Guard::new();
+                ma_state.mas_find_raw(usize::MAX)
+            };
             if ptr.is_null() {
                 break;
             }

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-maple-drop-rcu-dfe72fb5f49e

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


