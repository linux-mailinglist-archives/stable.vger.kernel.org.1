Return-Path: <stable+bounces-202957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E74CCB392
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74C5F3031E7B
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2439D332907;
	Thu, 18 Dec 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8jy7cyI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E582F4A10
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050876; cv=none; b=hpUUQvMAAN1AoQX8zINCy3ioTLugNb5A7+O1zQPS8OwH2UJ1O30ZUJyicWIXhT9ebPqNxh5FBe91dOpzgQfB/Hv8ydGlpejiZw4+TseF0FPUKNKxPyAJ+QJi4syg35RcA4+5dbhyhG1gUhFkoMkNwJkfsm0mFXzJTIC2a+r9YTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050876; c=relaxed/simple;
	bh=XYH4u6sei1EsidlFeyOpqvTMGNqvJ295Z3V4Mke0XRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GaAgvq9Tszl83MW26Bko7nmLX2+yW3I8Ib5h0Iz+XYcukKyY2OrgUFY1jUp9Ue2+X/H6xNHPaAG5yW/KXT1Rx5YRRB8ZoAy0sVv9SxMyf0i3YqdVYLKKN6zfT54wTjNh+N2EG87J9C1z0NXHaDLT/Y5MFas78RA//lGhRAEVkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8jy7cyI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47921784b97so3078455e9.0
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766050870; x=1766655670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tb2d6Cb3DcPhwKvIWU5F/kRUeFtqPtRNxpGpAq3DFrY=;
        b=n8jy7cyI+bDY0NfPnUj0wX7l7eiHLtsncGlfN9ddH28ZuRe+v4lqAluOGVC3hMs79E
         ECt2E+DxA6Wf1lQY2j187GUchPsjE4hUQyfV1XKmZIhpvCcrrX6ZQQBntHgWmWHOTsfN
         C1VG7xVYb9rzIrdqEbMHo+dIIDCAiJ7dadIVWl8DhrRyI3YGPi/e27vaG2H5+H/w8C53
         RT+qoMONA18NCSslkKwEHD84H+pN+KLrq7N3/o4wBDCGQPs87Am/xVmkUjufF+bV4jsu
         +x+3pr6Y+LH72A9XZBPtjHRNNMQIytD09Kr98sZB7I1q2a96EiYalw/zoLpy+xz1Mx+S
         Jb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766050870; x=1766655670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tb2d6Cb3DcPhwKvIWU5F/kRUeFtqPtRNxpGpAq3DFrY=;
        b=QKsaTGCHBjrwZMNJW/Em5eSh3GOtOtR8bWrDLYoa5lUHJJyhoiVseDtbpiLFrvsaa9
         BXeYJy7bopDgdqgjKOLioDOyPHgcpakFLOgzz+pPBb3RloC+OVR5kWo08O4xvCj/NhdJ
         MLp0aDkY/c8ELZRwecGYm7WhnkL9q3UhY7I4qGUsJ719/lGOP8dEx3+cTbx5myWPc4hR
         Fj0P40oamz43q8io+dSR7aK2HJO+XgBYM4QzR0GOH2KgT4W3jsUZsYxPzdK+TmF0B6qT
         MLUcYAssaiGCxmu6o4HqsegvzkttP/RLOtteAyO7+pQcOcM5FzO1/L0PgAZRrwxmqyft
         qXww==
X-Forwarded-Encrypted: i=1; AJvYcCXNRlvJP/m4S94nE5pimz1pJF/sve69q6/PCY+y1vjaLJGnMJhEwvHivsA+1M8ivxvX7fWxJ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iXZE8s+lmL/OgkPwbi9ym2m+0fqGN9JBVeRp7FDa/i+xG21Q
	KXQR9n6ObbX23OlcbMLNyjMNsQ8YNewM997P0sKq4x+n3R5w+5vnIYrcLsmfQ8UqEQsSJQLe6Ws
	bFrWklveeOtbZwEg5Xg==
X-Google-Smtp-Source: AGHT+IF0IOWby5SoajBqRsWVgMnbSnAo2HCb+2Jd+SVjfbdQJmilnqMXGXlqZhtlSQW7B6sJkpI/Jfybcx4gAkk=
X-Received: from wmbh27.prod.google.com ([2002:a05:600c:a11b:b0:477:9f20:94cb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cf:b0:477:a3d1:aafb with SMTP id 5b1f17b1804b1-47a8f90d757mr208363335e9.29.1766050870555;
 Thu, 18 Dec 2025 01:41:10 -0800 (PST)
Date: Thu, 18 Dec 2025 09:41:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACvMQ2kC/x3MTQ5AQAxA4atI15ro+HcVsZiYoiFIB5GIu5tYf
 ov3HvCswh6a6AHlS7xsawDFEfSTXUdGccFgEpOToQoP62ccdTt3XNg6VrQl1Sn17IoshdDtyoP c/7Pt3vcDbpeUqmMAAAA=
X-Change-Id: 20251218-task-group-leader-a71931ced643
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4208; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XYH4u6sei1EsidlFeyOpqvTMGNqvJ295Z3V4Mke0XRs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpQ8wxjYIwrPxCXnMyt+mAikGCReAP81auoJOfs
 /NhmIKJHJ+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaUPMMQAKCRAEWL7uWMY5
 RgN8D/9aaPQWO4u1ChmSACkZsVO/zHrE9heGf6aznNludSd8GrDw1374HdlRZWQ3lNXF6hzyyu6
 XBteu8H2UekZoBMXLnSWWbu1KvWfFQNes8DPrAnrg1baOI4AyFcmL6HA+RQuUwtqlWz6IHHqOAL
 8Ub+E2plJj3uhs8qp/MO4KDvqD7bBqDQRqez/79HFY/7a21knq8v+8fI/C7X6GyzG9cWZqmhQa7
 YOFGSHVuCBwG/MCnn05y9VVl1y6xGIUSwdFROK+tT7v9Tm48O32S2gPiPnYpLfzBR+zUXiqo6mg
 pBwF9lLdpu1aC/xZ1fH4ArKlaYRQzr1qaTDvYUAW6BMt8Fiqf1BKextv2EMaV1uATO95U/WiOUV
 +ufhCNIPVqHzNhflDM+uXrHo6XVAXnahtKhC8D1c4HrExVoxUbI4Fp/SxFuJJQuWSb2nady56bt
 n3zfnGQ6+I2qvMxCj6d0w/4e6v9D52KnLwXlUeE9+uc5QHmOjVGOPY2b3QYhMd/owYHcBD+CnEl
 Ivhb0YSojKZA5rNPyr0kSFmvVTXsaaiWuaAY7tUB8by4bS7cyHm4ihy6g3STUwU0AF7bxJ9g63U
 6ssT/nIrIJx0NPcbxYARi7wd3Fs5uPAzqYr42P/OSWL0abTk6HSkzxgTsz+673fEjo/MHZcyrOl wcJPV3/FOOIb38w==
X-Mailer: b4 0.14.2
Message-ID: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com>
Subject: [PATCH] rust: task: restrict Task::group_leader() to current
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The Task::group_leader() method currently allows you to access the
group_leader() of any task, for example one you hold a refcount to. But
this is not safe in general since the group leader could change when a
task exits. See for example commit a15f37a40145c ("kernel/sys.c: fix the
racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths").

All existing users of Task::group_leader() call this method on current,
which is guaranteed running, so there's not an actual issue in Rust code
today. But to prevent code in the future from making this mistake,
restrict Task::group_leader() so that it can only be called on current.

There are some other cases where accessing task->group_leader is okay.
For example it can be safe if you hold tasklist_lock or rcu_read_lock().
However, only supporting current->group_leader is sufficient for all
in-tree Rust users of group_leader right now. Safe Rust functionality
for accessing it under rcu or while holding tasklist_lock may be added
in the future if required by any future Rust module.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Closes: https://lore.kernel.org/all/aTLnV-5jlgfk1aRK@redhat.com/
Fixes: 313c4281bc9d ("rust: add basic `Task`")
Cc: stable@vger.kernel.org
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
The rust/kernel/task.rs file has had changes land through a few
different trees:

* Originally task.rs landed through Christian's tree together with
  file.rs and pid_namespace.rs
* The change to add CurrentTask landed through Andrew Morton's tree
  together with mm.rs
* There was a patch to mark some methods #[inline] that landed through
  tip via Boqun.

I don't think there's a clear owner for this file, so to break ambiguity
I'm doing to declare that this patch is intended for Andrew Morton's
tree. Please let me know if you think a different tree is appropriate.
---
 rust/kernel/task.rs | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 49fad6de06740a9b9ad80b2f4b430cc28cd134fa..9440692a3a6d0d3f908d61d51dcd377a272f6957 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -204,18 +204,6 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
         self.0.get()
     }
 
-    /// Returns the group leader of the given task.
-    pub fn group_leader(&self) -> &Task {
-        // SAFETY: The group leader of a task never changes after initialization, so reading this
-        // field is not a data race.
-        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
-
-        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
-        // and given that a task has a reference to its group leader, we know it must be valid for
-        // the lifetime of the returned task reference.
-        unsafe { &*ptr.cast() }
-    }
-
     /// Returns the PID of the given task.
     pub fn pid(&self) -> Pid {
         // SAFETY: The pid of a task never changes after initialization, so reading this field is
@@ -345,6 +333,18 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
         // `release_task()` call.
         Some(unsafe { PidNamespace::from_ptr(active_ns) })
     }
+
+    /// Returns the group leader of the current task.
+    pub fn group_leader(&self) -> &Task {
+        // SAFETY: The group leader of a task never changes while the task is running, and `self`
+        // is the current task, which is guaranteed running.
+        let ptr = unsafe { (*self.as_ptr()).group_leader };
+
+        // SAFETY: `current.group_leader` stays valid for at least the duration in which `current`
+        // is running, and the signature of this function ensures that the returned `&Task` can
+        // only be used while `current` is still valid, thus still running.
+        unsafe { &*ptr.cast() }
+    }
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-task-group-leader-a71931ced643

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


