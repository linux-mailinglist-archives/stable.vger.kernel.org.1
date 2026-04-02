Return-Path: <stable+bounces-233004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O6oJGlczmmgnAYAu9opvQ
	(envelope-from <stable+bounces-233004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B4388D7F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E6D30715F8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D23C7DF9;
	Thu,  2 Apr 2026 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bThnD9zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D803E0257;
	Thu,  2 Apr 2026 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131623; cv=none; b=ipS5XiL5wnZb8uuB/k18gGXhjGOSrvi0Ie5BBwj4JyyUqLBRO29jYQx7G4kXvaLLS/OEp817JND0txwu9oQUQpMg6P7QLhbuVFKD0f3CrrK804gk6wDq3MOINw/rLHxKbHEJLvkxzbkHP+odTJIok5jphCHAtfFVQEnp9TZDwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131623; c=relaxed/simple;
	bh=P9U6iMD76uiRdjM5WgI3IK45vf4UDtwjIDtcwjoWb68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmhLx2ef2QJob4P7BRZBc0S5mR/lyjDru4b+r3eMqDcr+gauwJ/NfQHj//45n6NOeaaP2WXo5KJLXaJL8g+aWwLKUDBAjAjFuM2MCvvQ3/FG4q1lP2fj3fIjqlrRA0hE9BzxB2EhrG4DEoeaz0BGbkCDsCo1WBAP7h1mDLVw7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bThnD9zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12DDC116C6;
	Thu,  2 Apr 2026 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775131623;
	bh=P9U6iMD76uiRdjM5WgI3IK45vf4UDtwjIDtcwjoWb68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bThnD9zhpbhS/+gHm8ZsEvtop6+KRAlJuGj9FaVg9AUOVAwg12eSyChJWg9aC1JfE
	 pt6MQ+lc2bcAMP2tBdyI/A0AxK3ArbVIno/vyoBuPlU505mTPLux71vrIosIYCriPv
	 VR52M/ZYHgP8MCi0YfpCqZtC1Qgz6Teu2SQghz3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.132
Date: Thu,  2 Apr 2026 14:06:56 +0200
Message-ID: <2026040211-wife-deepen-b4b8@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040211-smog-slander-0a1a@gregkh>
References: <2026040211-smog-slander-0a1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233004-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E53B4388D7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Makefile b/Makefile
index 567fe79e76bf..56ff90e4d603 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 131
+SUBLEVEL = 132
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index d6f8d5ce61af..cb769a09e742 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -964,54 +964,35 @@ fn drop(&mut self) {
         @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
         @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
     ) => {
-        $crate::macros::paste! {
-            // For every field, we create a projection function according to its projection type. If a
-            // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
-            // structurally pinned, then it can be initialized via `Init`.
-            //
-            // The functions are `unsafe` to prevent accidentally calling them.
-            #[allow(dead_code, non_snake_case)]
-            #[expect(clippy::missing_safety_doc)]
-            impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
-            where $($whr)*
-            {
-                $(
-                    $(#[$($p_attr)*])*
-                    $pvis unsafe fn $p_field<E>(
-                        self,
-                        slot: *mut $p_type,
-                        init: impl $crate::init::PinInit<$p_type, E>,
-                    ) -> ::core::result::Result<(), E> {
-                        unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
-                    }
-
-                    $(#[$($p_attr)*])*
-                    $pvis unsafe fn [<__project_ $p_field>]<'__slot>(
-                        self,
-                        slot: &'__slot mut $p_type,
-                    ) -> ::core::pin::Pin<&'__slot mut $p_type> {
-                        unsafe { ::core::pin::Pin::new_unchecked(slot) }
-                    }
-                )*
-                $(
-                    $(#[$($attr)*])*
-                    $fvis unsafe fn $field<E>(
-                        self,
-                        slot: *mut $type,
-                        init: impl $crate::init::Init<$type, E>,
-                    ) -> ::core::result::Result<(), E> {
-                        unsafe { $crate::init::Init::__init(init, slot) }
-                    }
-
-                    $(#[$($attr)*])*
-                    $fvis unsafe fn [<__project_ $field>]<'__slot>(
-                        self,
-                        slot: &'__slot mut $type,
-                    ) -> &'__slot mut $type {
-                        slot
-                    }
-                )*
-            }
+        // For every field, we create a projection function according to its projection type. If a
+        // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
+        // structurally pinned, then it can be initialized via `Init`.
+        //
+        // The functions are `unsafe` to prevent accidentally calling them.
+        #[allow(dead_code)]
+        impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
+        where $($whr)*
+        {
+            $(
+                $(#[$($p_attr)*])*
+                $pvis unsafe fn $p_field<E>(
+                    self,
+                    slot: *mut $p_type,
+                    init: impl $crate::init::PinInit<$p_type, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
+                }
+            )*
+            $(
+                $(#[$($attr)*])*
+                $fvis unsafe fn $field<E>(
+                    self,
+                    slot: *mut $type,
+                    init: impl $crate::init::Init<$type, E>,
+                ) -> ::core::result::Result<(), E> {
+                    unsafe { $crate::init::Init::__init(init, slot) }
+                }
+            )*
         }
     };
 }
@@ -1205,17 +1186,6 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
-        // Unaligned fields will cause the compiler to emit E0793. We do not support
-        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-        // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
-
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1247,18 +1217,6 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
-
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
-        // Unaligned fields will cause the compiler to emit E0793. We do not support
-        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-        // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the field is not structurally pinned, since the line above must compile,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
-        let $field = unsafe { &mut (*$slot).$field };
-
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1277,7 +1235,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             );
         }
     };
-    (init_slot(): // No `use_data`, so all fields are not structurally pinned
+    (init_slot($($use_data:ident)?):
         @data($data:ident),
         @slot($slot:ident),
         @guards($($guards:ident,)*),
@@ -1291,19 +1249,6 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
-
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
-        // Unaligned fields will cause the compiler to emit E0793. We do not support
-        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-        // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the field is not structurally pinned, since no `use_data` was required to create this
-        //   initializer,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = unsafe { &mut (*$slot).$field };
-
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1314,50 +1259,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
-            $crate::__init_internal!(init_slot():
-                @data($data),
-                @slot($slot),
-                @guards([< __ $field _guard >], $($guards,)*),
-                @munch_fields($($rest)*),
-            );
-        }
-    };
-    (init_slot($use_data:ident):
-        @data($data:ident),
-        @slot($slot:ident),
-        @guards($($guards:ident,)*),
-        // Init by-value.
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) => {
-        {
-            $(let $field = $val;)?
-            // Initialize the field.
-            //
-            // SAFETY: The memory at `slot` is uninitialized.
-            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
-        }
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
-        // Unaligned fields will cause the compiler to emit E0793. We do not support
-        // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-        // `ptr::write` below has the same requirement.
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        #[allow(unused_variables, unused_assignments)]
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
-
-        // Create the drop guard:
-        //
-        // We rely on macro hygiene to make it impossible for users to access this local variable.
-        // We use `paste!` to create new hygiene for `$field`.
-        $crate::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
-            };
-
-            $crate::__init_internal!(init_slot($use_data):
+            $crate::__init_internal!(init_slot($($use_data)?):
                 @data($data),
                 @slot($slot),
                 @guards([<$field>], $($guards,)*),

