Return-Path: <stable+bounces-158410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3868AE67B0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD574E0895
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04C2D322D;
	Tue, 24 Jun 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1zjb6Q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC62D3228
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773545; cv=none; b=dby7x6oQuYYhSoZcrX3KxXg/IATjyqeau92YrlJGnzB3X1usqdxNHt+0AGbZICnhBcdl52dGiv24fcXcFQxVf+4VbixcC6vNsWI1eQ1lHKpau39ZqPc7Lo3ouMMTita5G5xvNma8E0OvjBM0QKLB3iHh35F0TsWMvt5yVXcs7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773545; c=relaxed/simple;
	bh=jbYT1bjzomzvD1KMIDwAugQyxP7dqnWs47vVCGpd8BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMBeLrp4722+/Mko20iLIf+dFFmTjqdEPLyhNwzbpM/Vy+MWhj6S/rN+gw5KYrqkPUrcJL5A142suGbSrZVUXKd6yzEecdxvVjPTgEC+yyNpsKZJvbQQEtOasI93lNHOdiCnzuMFtIfD2XHC6fyhzo1f8jp+FFz0nD+QGOvSw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1zjb6Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E7C4CEF0;
	Tue, 24 Jun 2025 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773545;
	bh=jbYT1bjzomzvD1KMIDwAugQyxP7dqnWs47vVCGpd8BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1zjb6Q7L+T7JbVoROJEqd3ryKpZehLboz+LATnUrs22hRZVUrwPZGW49S1Ai0c9f
	 L+0UXOUi2YCdJqexlSQOXvL1mkyAQpra7XzNpjVJhvh8METR1rm4r7HZVL/8JJF0QA
	 zscNxwYdhP1o0l5NUtyE5bE2PV/plk+KwcfWWDVl2G4nSTeUQUGhdGIoqVEP3mO+00
	 vpmxB7bok6vBei7kjxvn46tmOr9jcFh0OZQ+SMR3KKFWxo0xGo7s/lKLjoegE+kxKT
	 TAepMSAX2n8ShCbwfr4y1z4vU822fjL4d18JMPfCvW0rVxJyqPokyNtbVxGRevxD8A
	 CRX8ujwdnzYlA==
From: Danilo Krummrich <dakr@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	lossin@kernel.org,
	sashal@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 1/4] rust: completion: implement initial abstraction
Date: Tue, 24 Jun 2025 15:58:32 +0200
Message-ID: <20250624135856.60250-2-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624135856.60250-1-dakr@kernel.org>
References: <20250624135856.60250-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 1b56e765bf8990f1f60e124926c11fc4ac63d752 ]

Implement a minimal abstraction for the completion synchronization
primitive.

This initial abstraction only adds complete_all() and
wait_for_completion(), since that is what is required for the subsequent
Devres patch.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20250612121817.1621-2-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/completion.c       |   8 +++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/sync.rs             |   2 +
 rust/kernel/sync/completion.rs  | 112 ++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 rust/helpers/completion.c
 create mode 100644 rust/kernel/sync/completion.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..3f66570b8756 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
diff --git a/rust/helpers/completion.c b/rust/helpers/completion.c
new file mode 100644
index 000000000000..b2443262a2ae
--- /dev/null
+++ b/rust/helpers/completion.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/completion.h>
+
+void rust_helper_init_completion(struct completion *x)
+{
+	init_completion(x);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1e7c84df7252..97cb759d92d4 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "completion.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 36a719015583..c23a12639924 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -10,6 +10,7 @@
 use pin_init;
 
 mod arc;
+pub mod completion;
 mod condvar;
 pub mod lock;
 mod locked_by;
@@ -17,6 +18,7 @@
 pub mod rcu;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use completion::Completion;
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
new file mode 100644
index 000000000000..c50012a940a3
--- /dev/null
+++ b/rust/kernel/sync/completion.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Completion support.
+//!
+//! Reference: <https://docs.kernel.org/scheduler/completion.html>
+//!
+//! C header: [`include/linux/completion.h`](srctree/include/linux/completion.h)
+
+use crate::{bindings, prelude::*, types::Opaque};
+
+/// Synchronization primitive to signal when a certain task has been completed.
+///
+/// The [`Completion`] synchronization primitive signals when a certain task has been completed by
+/// waking up other tasks that have been queued up to wait for the [`Completion`] to be completed.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::{Arc, Completion};
+/// use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
+///
+/// #[pin_data]
+/// struct MyTask {
+///     #[pin]
+///     work: Work<MyTask>,
+///     #[pin]
+///     done: Completion,
+/// }
+///
+/// impl_has_work! {
+///     impl HasWork<Self> for MyTask { self.work }
+/// }
+///
+/// impl MyTask {
+///     fn new() -> Result<Arc<Self>> {
+///         let this = Arc::pin_init(pin_init!(MyTask {
+///             work <- new_work!("MyTask::work"),
+///             done <- Completion::new(),
+///         }), GFP_KERNEL)?;
+///
+///         let _ = workqueue::system().enqueue(this.clone());
+///
+///         Ok(this)
+///     }
+///
+///     fn wait_for_completion(&self) {
+///         self.done.wait_for_completion();
+///
+///         pr_info!("Completion: task complete\n");
+///     }
+/// }
+///
+/// impl WorkItem for MyTask {
+///     type Pointer = Arc<MyTask>;
+///
+///     fn run(this: Arc<MyTask>) {
+///         // process this task
+///         this.done.complete_all();
+///     }
+/// }
+///
+/// let task = MyTask::new()?;
+/// task.wait_for_completion();
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+pub struct Completion {
+    #[pin]
+    inner: Opaque<bindings::completion>,
+}
+
+// SAFETY: `Completion` is safe to be send to any task.
+unsafe impl Send for Completion {}
+
+// SAFETY: `Completion` is safe to be accessed concurrently.
+unsafe impl Sync for Completion {}
+
+impl Completion {
+    /// Create an initializer for a new [`Completion`].
+    pub fn new() -> impl PinInit<Self> {
+        pin_init!(Self {
+            inner <- Opaque::ffi_init(|slot: *mut bindings::completion| {
+                // SAFETY: `slot` is a valid pointer to an uninitialized `struct completion`.
+                unsafe { bindings::init_completion(slot) };
+            }),
+        })
+    }
+
+    fn as_raw(&self) -> *mut bindings::completion {
+        self.inner.get()
+    }
+
+    /// Signal all tasks waiting on this completion.
+    ///
+    /// This method wakes up all tasks waiting on this completion; after this operation the
+    /// completion is permanently done, i.e. signals all current and future waiters.
+    pub fn complete_all(&self) {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        unsafe { bindings::complete_all(self.as_raw()) };
+    }
+
+    /// Wait for completion of a task.
+    ///
+    /// This method waits for the completion of a task; it is not interruptible and there is no
+    /// timeout.
+    ///
+    /// See also [`Completion::complete_all`].
+    pub fn wait_for_completion(&self) {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        unsafe { bindings::wait_for_completion(self.as_raw()) };
+    }
+}
-- 
2.49.0


