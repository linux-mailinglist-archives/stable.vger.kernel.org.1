Return-Path: <stable+bounces-216695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC/cDu8Yk2nD1QEAu9opvQ
	(envelope-from <stable+bounces-216695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 14:17:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2FE143BE5
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BF07300A50D
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2A2E9757;
	Mon, 16 Feb 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM0lJaD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E02459C9;
	Mon, 16 Feb 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247851; cv=none; b=F03+d0nhEZWrPHlrlnWN0n77uU5mTXKYVR4rJY4lxw9/63VOP3SJPv6bC/Tr/hf1YRg4SIAllFJUsIjNfc3xkEBaYcEcYRuJO5uf4+B8ZB8K01CmLI+2LAtEm4dZnpeZggdw32F4iA/7QnN9H++NKyqn1XRDmgaCJRbu5ni8kCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247851; c=relaxed/simple;
	bh=aQY8OJpTmQzIOqZheSBlqAwTQ+oVbc21oC/7wsRI+Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGWrFrzby3NzsSslI8dbpCYRalTyMf/jlEog491jaTbNa2GxsHEAwXLYvrQtQkmfFGbJsn9RX9w14L2/k/wE8usND4ZBYsXVmNBAH2vy5S3GSdCfo13qUTohR3YIHC58b9fx0MCtcGFr0ikMmOmQD75CMmYlIZsua6dGV8ez7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM0lJaD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74283C116C6;
	Mon, 16 Feb 2026 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771247851;
	bh=aQY8OJpTmQzIOqZheSBlqAwTQ+oVbc21oC/7wsRI+Qs=;
	h=From:To:Cc:Subject:Date:From;
	b=KM0lJaD8WpchzFKWaMWQhNxCzbYmAq13wZPIJMzGhK3mTi5DXo8JAhXj/SELsuMRq
	 MeyzDCIFLvmyqINPeuHR6PotI7JqAR/GlowoxnUbj7ZashNRNl7pblMKy6V18Gi1xA
	 ao1aseWvyL6ZnJuoAfy4jvckCyX2euUexzyGV90OCQVOSpaVF9CaNCOCPpj4vR1CDZ
	 i6a46Ch26OUVf8anpRAqhIe5NVENOKi8UsOTcuvyfz7GBGhdvl57YPsSXZ8v+jxAq8
	 WeR9O3laq91bL2zle4BHT7ISerUbCxCVd2mVj5vQplqGPM0bcyB+OIj8ZffQlrzOcp
	 gNa6JjVvd6tFg==
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
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] rust: list: Add unsafe for container_of
Date: Mon, 16 Feb 2026 14:16:15 +0100
Message-ID: <20260216131613.45344-3-phasta@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,impl_list_item_mod.rs:url,garyguo.net:email]
X-Rspamd-Queue-Id: 9C2FE143BE5
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
Changes in v4:
  - Add unsafe comments. (Miguel)

Changes in v3 (was accidentally called "v2" before):
  - Tidy up commit message and provide exact reason for the error.
  - Add Reviewed-bys.
---
 rust/kernel/list/impl_list_item_mod.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 202bc6f97c13..9f9c36051cf6 100644
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
@@ -270,9 +270,10 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
                 // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
                 let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
 
-                let container = $crate::container_of!(
+                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
+                let container = unsafe { $crate::container_of!(
                     links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
-                );
+                ) };
 
                 // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
                 let self_ptr = unsafe {
@@ -319,9 +320,11 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
             //   be destroyed while a `ListArc` reference exists.
             unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let container = $crate::container_of!(
+                // SAFETY: The caller must guarantee that `links_field` is a valid pointer of type
+                // ListLinks.
+                let container = unsafe { $crate::container_of!(
                     links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
-                );
+                ) };
 
                 // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
                 let self_ptr = unsafe {
-- 
2.49.0


