Return-Path: <stable+bounces-121487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37916A5754A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146931899317
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155F7258CD1;
	Fri,  7 Mar 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8OsZmO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F47256C80;
	Fri,  7 Mar 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387923; cv=none; b=Lp776OV/H6Qh2KElseuCFLMz+QOjIqrwZWxcehNB21/AOkPYZmxeMgADZ0c+R4DEGai2aTZ880m9QJZFedw8OdQXnv6+h9i8ZWGtSNZpGEgmeaoAf/FvHsRjiIyQbDPOkT1+c0uB5LyiXPdIF2whSbwx2Lc0lWZelg+cZa1CLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387923; c=relaxed/simple;
	bh=qHsZw8dSTKWD22whbCa8b4CXTLW0ZfUDKl1EZTNDMIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCePk8b+vlO0ZCUmBECZCPSB2tQUhIvYRrgqWuG1NIhyRHVj2r/acEYl3QlBxRfz/3ZqRQ+H1ohuLV7AlNQ+Soj6LIziaizVv1U+YgtyG1JY92Uc7GdzC0Y0/aOE+SPgRHZnN0pdQqrfmFj5h553/QbnpJ9VqRXYhcbD1j9McbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8OsZmO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D8DC4CEE5;
	Fri,  7 Mar 2025 22:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387923;
	bh=qHsZw8dSTKWD22whbCa8b4CXTLW0ZfUDKl1EZTNDMIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8OsZmO5tE+JvoL0IVwjj0MTHd+2Ddc82UQeEf06Umi23JbFs3Bsr4UsTNH6HdzUn
	 zoLlDbB8ZFiwHfRGphUwaNsl0GXLvfiP3wfFJWFdLU8qrN6mHsrW6QzpQW903/NT1s
	 SyGmeC0q9eUCSx8QVEyruZUjXKnGSjBqn2HB8brl94XfsLAQDQfktbXbdlqDx8Ic4Y
	 M1ZcBtgMxjAcnzVLPFnSemkR6jR+EDQgx0DHbqdb1+Rt9L06Yji/A2Yu4Zbh4Orf9N
	 PYruXEAaet55V+UWPeSKGy+PdNzyuwZAJ5OgoS3uYxrepoWqI1hlakTxMb8FsfThov
	 F2NsjOElkb1Hg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Alyssa Ross <hi@alyssa.is>,
	NoisyCoil <noisycoil@disroot.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y 32/60] rust: alloc: remove extension of std's `Box`
Date: Fri,  7 Mar 2025 23:49:39 +0100
Message-ID: <20250307225008.779961-33-ojeda@kernel.org>
In-Reply-To: <20250307225008.779961-1-ojeda@kernel.org>
References: <20250307225008.779961-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

commit e8c6ccdbcaaf31f26c0fffd4073edd0b0147cdc6 upstream.

Now that all existing `Box` users were moved to the kernel `Box` type,
remove the `BoxExt` extension and all other related extensions.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/20241004154149.93856-14-dakr@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc.rs         |  1 -
 rust/kernel/alloc/box_ext.rs | 89 ------------------------------------
 rust/kernel/init.rs          | 46 +------------------
 rust/kernel/lib.rs           |  1 -
 rust/kernel/prelude.rs       |  4 +-
 rust/kernel/types.rs         | 50 --------------------
 6 files changed, 3 insertions(+), 188 deletions(-)
 delete mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 3628e16240a6..94f4de5e0cdc 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,6 @@
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-pub mod box_ext;
 pub mod kbox;
 pub mod vec_ext;
 
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
deleted file mode 100644
index 7009ad78d4e0..000000000000
--- a/rust/kernel/alloc/box_ext.rs
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Box`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::boxed::Box;
-use core::{mem::MaybeUninit, ptr, result::Result};
-
-/// Extensions to [`Box`].
-pub trait BoxExt<T>: Sized {
-    /// Allocates a new box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Allocates a new uninitialised box.
-    ///
-    /// The allocation may fail, in which case an error is returned.
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
-
-    /// Drops the contents, but keeps the allocation.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use kernel::alloc::{flags, box_ext::BoxExt};
-    /// let value = Box::new([0; 32], flags::GFP_KERNEL)?;
-    /// assert_eq!(*value, [0; 32]);
-    /// let mut value = Box::drop_contents(value);
-    /// // Now we can re-use `value`:
-    /// value.write([1; 32]);
-    /// // SAFETY: We just wrote to it.
-    /// let value = unsafe { value.assume_init() };
-    /// assert_eq!(*value, [1; 32]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
-}
-
-impl<T> BoxExt<T> for Box<T> {
-    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
-        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
-        b.write(x);
-        // SAFETY: We just wrote to it.
-        Ok(unsafe { b.assume_init() })
-    }
-
-    #[cfg(any(test, testlib))]
-    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        Ok(Box::new_uninit())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
-        let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
-            core::ptr::NonNull::<_>::dangling().as_ptr()
-        } else {
-            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
-
-            // SAFETY: Memory is being allocated (first arg is null). The only other source of
-            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
-            // the type is not a SZT (checked above).
-            let ptr =
-                unsafe { super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags) };
-            if ptr.is_null() {
-                return Err(AllocError);
-            }
-
-            ptr.cast::<MaybeUninit<T>>()
-        };
-
-        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
-        // zero-sized types, we use `NonNull::dangling`.
-        Ok(unsafe { Box::from_raw(ptr) })
-    }
-
-    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
-        let ptr = Box::into_raw(this);
-        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
-        unsafe { ptr::drop_in_place(ptr) };
-
-        // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
-        let ptr = ptr.cast::<MaybeUninit<T>>();
-
-        // SAFETY: `ptr` is valid for writes, because it came from `Box::into_raw` and it is valid for
-        // reads, since the pointer came from `Box::into_raw` and the type is `MaybeUninit<T>`.
-        unsafe { Box::from_raw(ptr) }
-    }
-}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 9b63fd8e82da..812ae1d06077 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,13 +211,12 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, AllocError, Flags, KBox},
+    alloc::{AllocError, Flags, KBox},
     error::{self, Error},
     sync::Arc,
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -588,7 +587,6 @@ macro_rules! pin_init {
 /// # Examples
 ///
 /// ```rust
-/// # #![feature(new_uninit)]
 /// use kernel::{init::{self, PinInit}, error::Error};
 /// #[pin_data]
 /// struct BigBuf {
@@ -1245,26 +1243,6 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-impl<T> InPlaceInit<T> for Box<T> {
-    type PinnedSelf = Pin<Self>;
-
-    #[inline]
-    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self::PinnedSelf, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_pin_init(init)
-    }
-
-    #[inline]
-    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
-    where
-        E: From<AllocError>,
-    {
-        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_init(init)
-    }
-}
-
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     type PinnedSelf = Pin<Self>;
 
@@ -1301,28 +1279,6 @@ pub trait InPlaceWrite<T> {
     fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E>;
 }
 
-impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
-    type Initialized = Box<T>;
-
-    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Initialized, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() })
-    }
-
-    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin<Self::Initialized>, E> {
-        let slot = self.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { self.assume_init() }.into())
-    }
-}
-
 impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
     type Initialized = UniqueArc<T>;
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b6395b4209d7..5bbaf6282265 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,7 +16,6 @@
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(lint_reasons)]
-#![feature(new_uninit)]
 #![feature(unsize)]
 
 // Ensure conditional compilation based on the kernel configuration works;
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index a9210634a8c3..c1f8e5c832e2 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,10 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
 
 #[doc(no_inline)]
-pub use alloc::{boxed::Box, vec::Vec};
+pub use alloc::vec::Vec;
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4e03df725f3f..c426c36a4db7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -3,13 +3,11 @@
 //! Kernel types.
 
 use crate::init::{self, PinInit};
-use alloc::boxed::Box;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
-    pin::Pin,
     ptr::NonNull,
 };
 
@@ -71,54 +69,6 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
     }
 }
 
-impl<T: 'static> ForeignOwnable for Box<T> {
-    type Borrowed<'a> = &'a T;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        unsafe { &*ptr.cast() }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
-    }
-}
-
-impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
-    type Borrowed<'a> = Pin<&'a T>;
-
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
-    }
-
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
-        // SAFETY: The safety requirements for this function ensure that the object is still alive,
-        // so it is safe to dereference the raw pointer.
-        // The safety requirements of `from_foreign` also ensure that the object remains alive for
-        // the lifetime of the returned value.
-        let r = unsafe { &*ptr.cast() };
-
-        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
-        unsafe { Pin::new_unchecked(r) }
-    }
-
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
-        // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
-    }
-}
-
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-- 
2.48.1


