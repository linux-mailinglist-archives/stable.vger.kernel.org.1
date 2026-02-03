Return-Path: <stable+bounces-213178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cELoKIKvgWn+IgMAu9opvQ
	(envelope-from <stable+bounces-213178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:19:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07490D624C
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A2B303BB3F
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BB394467;
	Tue,  3 Feb 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ0J6jRy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543839448E;
	Tue,  3 Feb 2026 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106480; cv=none; b=XHLcvzRIOHxcLx7qblI6IpRKvAQMjoJoLYGQn9IS5LTqu2wwmGwJiSRe1s0Wnjckb2OQueQ0D2Q4sN1Mv6vTrCEPbsvYQ5RTvgGR5AsLHdAn9FMn6qXUHnKEjmAE/xcBrVHqzRm7t8Q55Id6/63A5MiDbHVkQtEXbR7mlYkoPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106480; c=relaxed/simple;
	bh=+vC2aosMFk7TAuVXidYijONEtqq2NTUeKHA8bbK0DN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjXhfKc+QZe9QxuyHLU7FjSR/Y00Cuz4tUAqz33rOkffuP9vByrj7A9mM0+5oixi+lMxXNWA6ukd1lzXrqRCpQKQZjvqjEtJPcolpiRllxBwwDxncbAaw2ZKuZkjIxkvcVzINCCq7q8TZE++XP80nOnGSsynnNbRBl2MtqXQbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ0J6jRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EC8C19421;
	Tue,  3 Feb 2026 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770106479;
	bh=+vC2aosMFk7TAuVXidYijONEtqq2NTUeKHA8bbK0DN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQ0J6jRylrunBvIq7xYaf/tUum/oiLRCk3qOT4PPsIqidyJ1PhBod8TjAM+BWNmm7
	 DWU4sXvrQ87RQVqQfRZ9yvdjmeUOZZtx9dpXsJ4JoMihakbrnF+LgAQkmJ3eRmheaw
	 +//SDdR+LIpmauXfp00UbJpc9NhEly90wYdLYzKoo/CRYIf845r3xOgexLmcRZeJFY
	 mQNUI2wPEZmhqssUdw5ibhxZgpoGb0ybqrUg5iGQ7L9O5TKe/hfD5t0/40rlqHWb93
	 JJzDBY99A/+83Z9A3PooZkvvignXovLR7ar1wibPbRrCT8twqBT0YoQbB4dcTcn7d0
	 8oeIt3X6ZSLkQ==
From: Philipp Stanner <phasta@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Benno Lossin <lossin@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/4] rust: list: Add unsafe for container_of
Date: Tue,  3 Feb 2026 09:14:00 +0100
Message-ID: <20260203081403.68733-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203081403.68733-2-phasta@kernel.org>
References: <20260203081403.68733-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213178-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,ffwll.ch,kernel.org,google.com,garyguo.net,amd.com,collabora.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phasta@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[impl_list_item_mod.rs:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07490D624C
X-Rspamd-Action: no action

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


