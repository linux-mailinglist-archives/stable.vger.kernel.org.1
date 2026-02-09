Return-Path: <stable+bounces-214895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PzzM6mqiWlZAgUAu9opvQ
	(envelope-from <stable+bounces-214895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 10:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BDA10DA0D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 401EE3024447
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B54328635;
	Mon,  9 Feb 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2YYJdE2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE170205E26;
	Mon,  9 Feb 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629695; cv=none; b=HQJJVPcgHKJ6FK4V4E5h6e9mXeI8jV1HgcRkf2gys/vp4Xoa5mrwJmngUybnfvloarOdkwcoa9ruoWNYXFIOsJecBjEJ7A6zXj8UznmWTWh83fklRN3Eq64OGY35nOL2Zqe2q/GHxzYVUEIV1h9u1KqUSf6h7He0boXrO2bj+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629695; c=relaxed/simple;
	bh=LGwf+hfMsPyDS27fugz8eoNWwNfBcyc2TpeqWfnjdUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROOFP3NQUqZxifbUVZ2qmOOz77dnHUXDbImuqxl2zChVHOSBR3crnCXTZwV5Cn31hzkxol3Qcp86IN0IIi3HzkDM9wZDr17aU8U4YwMamvPjHZZsmpJyACy4G1oH6lvvVoRSN4swlFAXL+yOd3A/NO0HjjV0hciFLMO3GROH0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2YYJdE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E8FC116C6;
	Mon,  9 Feb 2026 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629695;
	bh=LGwf+hfMsPyDS27fugz8eoNWwNfBcyc2TpeqWfnjdUo=;
	h=From:To:Cc:Subject:Date:From;
	b=C2YYJdE2TvlP37CWeVk55w5pv/80P8TqqFVJ3lHr+LQ9Ua3s2voJCN/nzdMh/ee6q
	 JqlPbUXZEw3wkLvMGsZ9tFoZ0TcJFKz/OuHLR2YcXKEYVGscWedeCNVYT3m6ZL+d7B
	 vosn2iRZgi0xH6KILnrMT7uJNZxDe6uKcyD0tl2Z2zCUtA0sE/z4DDZHCjkzD8bpF8
	 Y6L47O5Kjbc7UmYS68NLDDd/35HE5sNYYdDsUpDqLC58yeqv1pPUrQ9cyv3Uk7Gjkc
	 bCGvnWUQiVd1uMuWClnp/e/AjubUtu+ZCa1HjTHnhEkDtf74i7PxU/knb1cBUW2V0R
	 GlL/6iP2UWmAw==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
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
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] rust: list: Add unsafe for container_of
Date: Mon,  9 Feb 2026 10:34:33 +0100
Message-ID: <20260209093432.17190-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214895-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 48BDA10DA0D
X-Rspamd-Action: no action

impl_list_item_mod.rs calls container_of() without unsafe blocks at a
couple of places. Since container_of() is an unsafe macro / function,
the blocks are strictly necessary.

The problem was so far not visible because the "unsafe-op-in-unsafe-fn"
check is a linter rather than a compiler check. Rust suppresses lint
checks triggered inside of a macro from another crate. Thus, the error
becomes only visible once someone from without the core crate tries to
use linked lists:

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

Cc: stable@vger.kernel.org
Fixes: c77f85b347dd ("rust: list: remove OFFSET constants")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
  - Tidy up commit message and provide exact reason for the error.
  - Add Reviewed-bys.
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


