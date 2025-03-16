Return-Path: <stable+bounces-124513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BAA6346B
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D0716E03D
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE118859B;
	Sun, 16 Mar 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fw0rAk8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBF17D346
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109412; cv=none; b=X9xhf/GsvGUw+auOaL8h4OoB5SBuvSumI8YHtyD25k3nVSnS1vtHVMvy957ENDnRag02ikkFOGGSEyB21kgkwOuqPPbkj1wdoyFdKBn7I0bHS7WyeVMEN12gilZpj9ktVaMnM92XcvYdScIJt5ndokbcZ/KbJeEc63mFBFZiJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109412; c=relaxed/simple;
	bh=gOj8qv5gxZ/pb5RKYfm9HXQv1MyCBqf/NIzfW0hH85Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qS8L+NKFCOvFD5yVSnFDSqWDVNlITuIxwnhwRH1Dp3MHiyPAqOVVb2S8KizRt7EEJluVxgCB2jur/iFNl1qYj2zGHkjdri5nIgixFJEZGfXlKj0F6fteKQs8tzCdhh5IJCHSxutVB68BHZyEedX9c0sFi7KYJ794QU6Qls+fAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fw0rAk8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A611C4CEDD;
	Sun, 16 Mar 2025 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109411;
	bh=gOj8qv5gxZ/pb5RKYfm9HXQv1MyCBqf/NIzfW0hH85Q=;
	h=Subject:To:Cc:From:Date:From;
	b=fw0rAk8lJzbPHvenMKYizSjM/OVwke9+Pj/k0fv9S4T/vtAjgspgtgV7Rd6FOygBi
	 to4yNSCK7gwFK5UAKvUb1gsZBxFOxxw3yDie9sJOkP6CAflYCHfX+7QS2iNxJWpkyP
	 vhOESy2yCf8uKDCffwJO1vbvz0GTK+rU4AwSrY5c=
Subject: FAILED: patch "[PATCH] rust: lockdep: Remove support for dynamically allocated" failed to apply to 6.6-stable tree
To: levymitchell0@gmail.com,aliceryhl@google.com,benno.lossin@proton.me,boqun.feng@gmail.com,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:15:32 +0100
Message-ID: <2025031632-divorcee-duly-868e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 966944f3711665db13e214fef6d02982c49bb972
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031632-divorcee-duly-868e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 966944f3711665db13e214fef6d02982c49bb972 Mon Sep 17 00:00:00 2001
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Fri, 7 Mar 2025 15:27:00 -0800
Subject: [PATCH] rust: lockdep: Remove support for dynamically allocated
 LockClassKeys

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250307232717.1759087-11-boqun.feng@gmail.com

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb344dc9..16eab9138b2b 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -30,28 +30,20 @@
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        static CLASS: $crate::sync::LockClassKey =
+            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+            // lock_class_key
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }


