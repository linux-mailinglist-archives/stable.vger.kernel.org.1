Return-Path: <stable+bounces-195067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E79C67FC9
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 08:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6CA4F61E3
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4092FBE12;
	Tue, 18 Nov 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGVf3L35"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D072F49F4;
	Tue, 18 Nov 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450997; cv=none; b=dSV2rtHGWilq9TYu/8/I0l84iJDi/qUhUf5tcaiYtsMtOHQDwrfTJsOS2c7FXJTUSOcIVE1MgUVyt9hPggf7UrCmMD5qJLiY8qQUTpHQmGfp5RwuyhdehOa4wHeV8e209UNweWronc+UE3RCALkJg7Dvw4zvMlienRwINNUA7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450997; c=relaxed/simple;
	bh=UxiBMwC3uWq0xUu2kIl5lvUXOVp5mKCr8tzUfK2S+FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhl/AX7BMV4Qsyy/ir2B+LeRu/faZUG4JnkxCK8U0aN8bBSuGvnBQAkT3TgyrAt497ZNs0oBZQztCDwdiyOBO4rgdbbLdkk1VZcKtTpYkEwStTS6/p0s81VFyX5qyKOiL7q6glbnsKsnFDtTLCc20Ah8bYPwHAzzZqmSWlzj7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGVf3L35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54760C116D0;
	Tue, 18 Nov 2025 07:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450997;
	bh=UxiBMwC3uWq0xUu2kIl5lvUXOVp5mKCr8tzUfK2S+FI=;
	h=From:To:Cc:Subject:Date:From;
	b=QGVf3L35yAMoabWi9OKB06uszFIjJmrDyCFatc7GSYLUcHhUJIbQdBeDtOLjRWSD+
	 /D/8y1hgjUtwZCfWCymlQKTQpAij8jFUccMk9PENba8ybl+QWxC1lu5pIkT5UJQynu
	 PhjR6RtOa9QANf2uVxTcRbukk2H0oOY3Myjtb90+uGv8JIBxqA3RsktljxqEFAbE8k
	 1cNfZqiQCc6+kBSbN6PFGl4PMyCPJGrXId5uKOqT00nHzMfCLN/mKynvNoFkUE/HkT
	 vONMSyUHriR1DtyhNR2539aIP6RaFlrBXWcH7aQ9jibS9/j8KEKdq1WMm9+cvX3xnl
	 PlNxujpmsSnGg==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: list: Add unsafe for container_of
Date: Tue, 18 Nov 2025 08:28:35 +0100
Message-ID: <20251118072833.196876-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

impl_list_item_mod.rs calls container_of() without unsafe blocks at a
couple of places. Since container_of() is an unsafe macro / function,
the blocks are strictly necessary.

For unknown reasons, that problem was so far not visible and only gets
visible once one utilizes the list implementation from within the core
crate:

error[E0133]: call to unsafe function `core::ptr::mut_ptr::<impl *mut T>::byte_sub`
is unsafe and requires unsafe block
   --> rust/kernel/lib.rs:252:29
    |
252 |           let container_ptr = field_ptr.byte_sub(offset).cast::<$Container>();
    |                               ^^^^^^^^^^^^^^^^^^^^^^^^^^ call to unsafe function
    |
   ::: rust/kernel/drm/jq.rs:98:1
    |
98  | / impl_list_item! {
99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links }; }
100 | | }
    | |_- in this macro invocation
    |
note: an unsafe function restricts its caller, but its body is safe by default
   --> rust/kernel/list/impl_list_item_mod.rs:216:13
    |
216 |               unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
    |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
   ::: rust/kernel/drm/jq.rs:98:1
    |
98  | / impl_list_item! {
99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links }; }
100 | | }
    | |_- in this macro invocation
    = note: requested on the command line with `-D unsafe-op-in-unsafe-fn`
    = note: this error originates in the macro `$crate::container_of` which comes
    from the expansion of the macro `impl_list_item`

Add unsafe blocks to container_of to fix the issue.

Cc: stable@vger.kernel.org # v6.17+
Fixes: c77f85b347dd ("rust: list: remove OFFSET constants")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Add unsafes to the list implementation instead of container_of
    itself. (Alice, Miguel)
  - Adjust commit message and Fixes: tag.
  - Add stable-kernel for completeness.
---
 rust/kernel/list/impl_list_item_mod.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 202bc6f97c13..7052095efde5 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -217,7 +217,7 @@ unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
                 // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
                 // points at the field `$field` in a value of type `Self`. Thus, reversing that
                 // operation is still in-bounds of the allocation.
-                $crate::container_of!(me, Self, $($field).*)
+                unsafe { $crate::container_of!(me, Self, $($field).*) }
             }
 
             // GUARANTEES:
@@ -242,7 +242,7 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
                 // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
                 // points at the field `$field` in a value of type `Self`. Thus, reversing that
                 // operation is still in-bounds of the allocation.
-                $crate::container_of!(me, Self, $($field).*)
+                unsafe { $crate::container_of!(me, Self, $($field).*) }
             }
         }
     )*};
@@ -270,9 +270,9 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
                 // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
                 let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
 
-                let container = $crate::container_of!(
+                let container = unsafe { $crate::container_of!(
                     links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
-                );
+                ) };
 
                 // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
                 let self_ptr = unsafe {
@@ -319,9 +319,9 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
             //   be destroyed while a `ListArc` reference exists.
             unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let container = $crate::container_of!(
+                let container = unsafe { $crate::container_of!(
                     links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
-                );
+                ) };
 
                 // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
                 let self_ptr = unsafe {
-- 
2.49.0


