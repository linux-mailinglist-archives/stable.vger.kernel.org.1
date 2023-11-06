Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169DB7E2417
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjKFNSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKFNSC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:18:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB094
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:18:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC95C433C8;
        Mon,  6 Nov 2023 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276680;
        bh=SwIQ+PrAzSby/JfwdX/vsGU+WwH0SMfTNaKVuGp7RH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hI7nhO9C9l6Yeo/SNDtZ+dTqs9WIYJEEbsNt26yByik8ONDgHgHv9c0fcEpzXjNsg
         /m6hFoJtixwKZMDz8lfhjkh9l+pfU+o93JvdeplbHvxEGaeRcexytk/cNFi3P4nkWL
         Yxi7KH/oCHGD/qARxECSP/65tsWL/pCfR266WmYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>,
        Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 62/88] rust: types: make `Opaque` be `!Unpin`
Date:   Mon,  6 Nov 2023 14:03:56 +0100
Message-ID: <20231106130308.070678539@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benno Lossin <benno.lossin@proton.me>

[ Upstream commit 0b4e3b6f6b79b1add04008a6ceaaf661107e8902 ]

Adds a `PhantomPinned` field to `Opaque<T>`. This removes the last Rust
guarantee: the assumption that the type `T` can be freely moved. This is
not the case for many types from the C side (e.g. if they contain a
`struct list_head`). This change removes the need to add a
`PhantomPinned` field manually to Rust structs that contain C structs
which must not be moved.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Link: https://lore.kernel.org/r/20230630150216.109789-1-benno.lossin@proton.me
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/types.rs | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index c0b8bb1a75393..50cbd767ea9dd 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -6,7 +6,7 @@
 use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
-    marker::PhantomData,
+    marker::{PhantomData, PhantomPinned},
     mem::MaybeUninit,
     ops::{Deref, DerefMut},
     ptr::NonNull,
@@ -206,17 +206,26 @@ fn drop(&mut self) {
 ///
 /// This is meant to be used with FFI objects that are never interpreted by Rust code.
 #[repr(transparent)]
-pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
+pub struct Opaque<T> {
+    value: UnsafeCell<MaybeUninit<T>>,
+    _pin: PhantomPinned,
+}
 
 impl<T> Opaque<T> {
     /// Creates a new opaque value.
     pub const fn new(value: T) -> Self {
-        Self(UnsafeCell::new(MaybeUninit::new(value)))
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(value)),
+            _pin: PhantomPinned,
+        }
     }
 
     /// Creates an uninitialised value.
     pub const fn uninit() -> Self {
-        Self(UnsafeCell::new(MaybeUninit::uninit()))
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
     }
 
     /// Creates a pin-initializer from the given initializer closure.
@@ -240,7 +249,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
 
     /// Returns a raw pointer to the opaque data.
     pub fn get(&self) -> *mut T {
-        UnsafeCell::get(&self.0).cast::<T>()
+        UnsafeCell::get(&self.value).cast::<T>()
     }
 
     /// Gets the value behind `this`.
-- 
2.42.0



