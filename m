Return-Path: <stable+bounces-230334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODdGIqPhw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:22:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02B325A61
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D7203147CF8
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD93D811A;
	Wed, 25 Mar 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2ibpF07"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADF3D7D8E;
	Wed, 25 Mar 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443550; cv=none; b=tC7Hn+4FVz1A8ujorqUB7fRvhh7YJYAGyVHuIAr8uvuUAJtUORU5Anzj6lPiyeWNguVa/A+vHucULcBmWE6UbNPiePzC+Sgd+muyo7pWIvoTTXdVVo4lcW5p7C+s7wVzIWEdPly4cwkw39mEXTPki7wjSaS0qShL5Ga6Ceyimc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443550; c=relaxed/simple;
	bh=w8yWoIGL4H/5v+018HO6no94WcPHwkYtY8y+99K3vBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KO6DnJMPpPfMXwTGMFQZDVZ9oomZy13tLK9AYSNJozeo16IYoV2ra49PfqEfBvKOlF67F3Qqvi3KkEA1zDJtelHLOVF1HlEhFiIZfvRkF6cBaANFDzUdadAACM/uHDBLJ5T7uZbKwELmpoOtNCjP+0R5Y6GnhjsoYA2kb+fA4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2ibpF07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFADC4CEF7;
	Wed, 25 Mar 2026 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774443549;
	bh=w8yWoIGL4H/5v+018HO6no94WcPHwkYtY8y+99K3vBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=L2ibpF07n96eP7jK4qFlUI6536zB7BAmIuPiRkwP7QMtvHDU+F5JZl4UcYPR84Tvn
	 4lQwMciLgs65FKYIFDKS0+mxrJroNyl9UtHrYUp72aLeD35gzD6P32xqN7QbKHZ4dd
	 ReR4pa2oiVQMqLg1vZRK5agVy4DB0PDUTq3B8eYOXjxu9zYi/JNMAOH5egGfGBa4Cs
	 z6SZv7eVC7aTgYyF2OK59kcpQIQ/xRyoOabmD8HfFIH/2GDN3akPJ5wV3qmanX3Dhy
	 E/d4MkerIkedeX46V7UOnpOS80nZi7uzscBM4jMZOFQpGsBollgWmYbrKAPaHqlqwD
	 FV7cMYaj8DQjw==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benno Lossin <lossin@kernel.org>,
	stable@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y 1/3] rust: pin-init: add references to previously initialized fields
Date: Wed, 25 Mar 2026 13:58:14 +0100
Message-ID: <20260325125816.945578-2-lossin@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,proton.me,google.com,umich.edu,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230334-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C02B325A61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 42415d163e5df6db799c7de6262d707e402c2c7e ]

After initializing a field in an initializer macro, create a variable
holding a reference that points at that field. The type is either
`Pin<&mut T>` or `&mut T` depending on the field's structural pinning
kind.

[ Applied fixes to devres and rust_driver_pci sample - Benno]
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Benno Lossin <lossin@kernel.org>
[ Removed the devres changes, because devres is not present in 6.12.y and
  earlier. Also adjusted paths in the macro to account for the fact that
  pin-init is part of the kernel crate in 6.12.y and earlier. - Benno ]
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/init/macros.rs | 149 ++++++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index e530028bb9ed..54c0b255a9ce 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -985,38 +985,56 @@ fn drop(&mut self) {
         @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
         @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
     ) => {
-        // For every field, we create a projection function according to its projection type. If a
-        // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
-        // structurally pinned, then it can be initialized via `Init`.
-        //
-        // The functions are `unsafe` to prevent accidentally calling them.
-        #[allow(dead_code)]
-        #[expect(clippy::missing_safety_doc)]
-        impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
-        where $($whr)*
-        {
-            $(
-                $(#[$($p_attr)*])*
-                $pvis unsafe fn $p_field<E>(
-                    self,
-                    slot: *mut $p_type,
-                    init: impl $crate::init::PinInit<$p_type, E>,
-                ) -> ::core::result::Result<(), E> {
-                    // SAFETY: TODO.
-                    unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
-                }
-            )*
-            $(
-                $(#[$($attr)*])*
-                $fvis unsafe fn $field<E>(
-                    self,
-                    slot: *mut $type,
-                    init: impl $crate::init::Init<$type, E>,
-                ) -> ::core::result::Result<(), E> {
-                    // SAFETY: TODO.
-                    unsafe { $crate::init::Init::__init(init, slot) }
-                }
-            )*
+        $crate::macros::paste! {
+            // For every field, we create a projection function according to its projection type. If a
+            // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
+            // structurally pinned, then it can be initialized via `Init`.
+            //
+            // The functions are `unsafe` to prevent accidentally calling them.
+            #[allow(dead_code, non_snake_case)]
+            #[expect(clippy::missing_safety_doc)]
+            impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
+            where $($whr)*
+            {
+                $(
+                    $(#[$($p_attr)*])*
+                    $pvis unsafe fn $p_field<E>(
+                        self,
+                        slot: *mut $p_type,
+                        init: impl $crate::init::PinInit<$p_type, E>,
+                    ) -> ::core::result::Result<(), E> {
+                        // SAFETY: TODO.
+                        unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
+                    }
+
+                    $(#[$($p_attr)*])*
+                    $pvis unsafe fn [<__project_ $p_field>]<'__slot>(
+                        self,
+                        slot: &'__slot mut $p_type,
+                    ) -> ::core::pin::Pin<&'__slot mut $p_type> {
+                        unsafe { ::core::pin::Pin::new_unchecked(slot) }
+                    }
+                )*
+                $(
+                    $(#[$($attr)*])*
+                    $fvis unsafe fn $field<E>(
+                        self,
+                        slot: *mut $type,
+                        init: impl $crate::init::Init<$type, E>,
+                    ) -> ::core::result::Result<(), E> {
+                        // SAFETY: TODO.
+                        unsafe { $crate::init::Init::__init(init, slot) }
+                    }
+
+                    $(#[$($attr)*])*
+                    $fvis unsafe fn [<__project_ $field>]<'__slot>(
+                        self,
+                        slot: &'__slot mut $type,
+                    ) -> &'__slot mut $type {
+                        slot
+                    }
+                )*
+            }
         }
     };
 }
@@ -1213,6 +1231,13 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        // SAFETY:
+        // - the project function does the correct field projection,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables, unused_assignments)]
+        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1244,6 +1269,14 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
+
+        // SAFETY:
+        // - the field is not structurally pinned, since the line above must compile,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables, unused_assignments)]
+        let $field = unsafe { &mut (*$slot).$field };
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1262,7 +1295,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             );
         }
     };
-    (init_slot($($use_data:ident)?):
+    (init_slot(): // No `use_data`, so all fields are not structurally pinned
         @data($data:ident),
         @slot($slot:ident),
         @guards($($guards:ident,)*),
@@ -1276,6 +1309,15 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
+
+        #[allow(unused_variables, unused_assignments)]
+        // SAFETY:
+        // - the field is not structurally pinned, since no `use_data` was required to create this
+        //   initializer,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        let $field = unsafe { &mut (*$slot).$field };
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1286,7 +1328,46 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
-            $crate::__init_internal!(init_slot($($use_data)?):
+            $crate::__init_internal!(init_slot():
+                @data($data),
+                @slot($slot),
+                @guards([< __ $field _guard >], $($guards,)*),
+                @munch_fields($($rest)*),
+            );
+        }
+    };
+    (init_slot($use_data:ident):
+        @data($data:ident),
+        @slot($slot:ident),
+        @guards($($guards:ident,)*),
+        // Init by-value.
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) => {
+        {
+            $(let $field = $val;)?
+            // Initialize the field.
+            //
+            // SAFETY: The memory at `slot` is uninitialized.
+            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
+        }
+        // SAFETY:
+        // - the project function does the correct field projection,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables, unused_assignments)]
+        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+
+        // Create the drop guard:
+        //
+        // We rely on macro hygiene to make it impossible for users to access this local variable.
+        // We use `paste!` to create new hygiene for `$field`.
+        $crate::macros::paste! {
+            // SAFETY: We forget the guard later when initialization has succeeded.
+            let [< __ $field _guard >] = unsafe {
+                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+            };
+
+            $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
                 @guards([< __ $field _guard >], $($guards,)*),

base-commit: 48591125594050ab91c9156bccb3ddd9a869d9f1
-- 
2.53.0


