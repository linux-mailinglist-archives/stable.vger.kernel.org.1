Return-Path: <stable+bounces-19883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE948537B4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139E62833D4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C05FEEB;
	Tue, 13 Feb 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0fdENeSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7C5F54E;
	Tue, 13 Feb 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845315; cv=none; b=AStB4IYofjCu7IDQcxZmYZNYs4LrmCm+0ZRoTsEjcCBZVamwVL216TP8sH7WEGA+ZZ2LHI6IwIo49Qmzh5OrCKTHrqDjO3+T5x5T9Yxb6X8SLVtlhkyzach8Ip73xBwuGzxIWGvt3Rmn77l+0jK1H1e22F0oYF18NU8gXp5R/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845315; c=relaxed/simple;
	bh=64U/Q9l/DvbIajJRbOvJeE5uyPmEdZ2XNY0HQKncrcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMYtFQMlIATiVnI9p7nWrJtsCvivlKNK1MOr2hUtnSVb7o77umGgx126qRYkH0SwxLTTKBsQBVRinlUyWy8FFklH+nYIObhqvXcatxkPwk7oQFlbzX6XOCa/L3OG24Zw8OrdLet88DNTIPBZ6qtlfAjDhtNI7dGWHS9BdvOl1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0fdENeSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FE9C433F1;
	Tue, 13 Feb 2024 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845315;
	bh=64U/Q9l/DvbIajJRbOvJeE5uyPmEdZ2XNY0HQKncrcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0fdENeSyWj7pK/5eNeEyYzTIBla1EOGqKE5teTr6YE+JCrY+i3ocQxv56DvOdpQFm
	 NaqLZ0AJpPS7Cyk1xC9FPOdmqMF9/v7KGJOYHpYBrkq+kAstO7KRlOcKHJRFViZ1N8
	 U0fdS5awEs3blinsaaZ67iYHy4nKZjMRdaW0bKrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6 016/121] rust: upgrade to Rust 1.73.0
Date: Tue, 13 Feb 2024 18:20:25 +0100
Message-ID: <20240213171853.444476518@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit e08ff622c91af997cb89bc47e90a1a383e938bd0 upstream.

This is the next upgrade to the Rust toolchain, from 1.72.1 to 1.73.0
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

No unstable features (that we use) were stabilized.

Therefore, the only unstable feature allowed to be used outside
the `kernel` crate is still `new_uninit`, though other code to be
upstreamed may increase the list.

Please see [3] for details.

# Required changes

For the upgrade, the following changes are required:

  - Allow `internal_features` for `feature(compiler_builtins)` since
    now Rust warns about using internal compiler and standard library
    features (similar to how it also warns about incomplete ones) [4].

  - A cleanup for a documentation link thanks to a new `rustdoc` lint.
    See previous commits for details.

  - A need to make an intra-doc link to a macro explicit, due to a
    change in behavior in `rustdoc`. See previous commits for details.

# `alloc` upgrade and reviewing

The vast majority of changes are due to our `alloc` fork being upgraded
at once.

There are two kinds of changes to be aware of: the ones coming from
upstream, which we should follow as closely as possible, and the updates
needed in our added fallible APIs to keep them matching the newer
infallible APIs coming from upstream.

Instead of taking a look at the diff of this patch, an alternative
approach is reviewing a diff of the changes between upstream `alloc` and
the kernel's. This allows to easily inspect the kernel additions only,
especially to check if the fallible methods we already have still match
the infallible ones in the new version coming from upstream.

Another approach is reviewing the changes introduced in the additions in
the kernel fork between the two versions. This is useful to spot
potentially unintended changes to our additions.

To apply these approaches, one may follow steps similar to the following
to generate a pair of patches that show the differences between upstream
Rust and the kernel (for the subset of `alloc` we use) before and after
applying this patch:

    # Get the difference with respect to the old version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > old.patch
    git -C linux restore rust/alloc

    # Apply this patch.
    git -C linux am rust-upgrade.patch

    # Get the difference with respect to the new version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > new.patch
    git -C linux restore rust/alloc

Now one may check the `new.patch` to take a look at the additions (first
approach) or at the difference between those two patches (second
approach). For the latter, a side-by-side tool is recommended.

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1730-2023-10-05 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
Link: https://github.com/rust-lang/compiler-team/issues/596 [4]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20231005210556.466856-4-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/changes.rst |    2 -
 rust/alloc/alloc.rs               |   22 -----------------
 rust/alloc/boxed.rs               |   48 ++++++++++++++++++++++++--------------
 rust/alloc/lib.rs                 |    5 ++-
 rust/alloc/raw_vec.rs             |   30 +++++++++++++++--------
 rust/alloc/vec/mod.rs             |    4 +--
 rust/alloc/vec/spec_extend.rs     |    8 +++---
 rust/compiler_builtins.rs         |    1 
 scripts/min-tool-version.sh       |    2 -
 9 files changed, 63 insertions(+), 59 deletions(-)

--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself wi
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.72.1           rustc --version
+Rust (optional)        1.73.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -6,11 +6,7 @@
 
 #[cfg(not(test))]
 use core::intrinsics;
-#[cfg(all(bootstrap, not(test)))]
-use core::intrinsics::{min_align_of_val, size_of_val};
 
-#[cfg(all(bootstrap, not(test)))]
-use core::ptr::Unique;
 #[cfg(not(test))]
 use core::ptr::{self, NonNull};
 
@@ -339,23 +335,6 @@ unsafe fn exchange_malloc(size: usize, a
     }
 }
 
-#[cfg(all(bootstrap, not(test)))]
-#[lang = "box_free"]
-#[inline]
-// This signature has to be the same as `Box`, otherwise an ICE will happen.
-// When an additional parameter to `Box` is added (like `A: Allocator`), this has to be added here as
-// well.
-// For example if `Box` is changed to  `struct Box<T: ?Sized, A: Allocator>(Unique<T>, A)`,
-// this function has to be changed to `fn box_free<T: ?Sized, A: Allocator>(Unique<T>, A)` as well.
-unsafe fn box_free<T: ?Sized, A: Allocator>(ptr: Unique<T>, alloc: A) {
-    unsafe {
-        let size = size_of_val(ptr.as_ref());
-        let align = min_align_of_val(ptr.as_ref());
-        let layout = Layout::from_size_align_unchecked(size, align);
-        alloc.deallocate(From::from(ptr.cast()), layout)
-    }
-}
-
 // # Allocation error handler
 
 #[cfg(not(no_global_oom_handling))]
@@ -415,7 +394,6 @@ pub mod __alloc_error_handler {
             static __rust_alloc_error_handler_should_panic: u8;
         }
 
-        #[allow(unused_unsafe)]
         if unsafe { __rust_alloc_error_handler_should_panic != 0 } {
             panic!("memory allocation of {size} bytes failed")
         } else {
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -159,12 +159,12 @@ use core::hash::{Hash, Hasher};
 use core::iter::FusedIterator;
 use core::marker::Tuple;
 use core::marker::Unsize;
-use core::mem;
+use core::mem::{self, SizedTypeProperties};
 use core::ops::{
     CoerceUnsized, Deref, DerefMut, DispatchFromDyn, Generator, GeneratorState, Receiver,
 };
 use core::pin::Pin;
-use core::ptr::{self, Unique};
+use core::ptr::{self, NonNull, Unique};
 use core::task::{Context, Poll};
 
 #[cfg(not(no_global_oom_handling))]
@@ -483,8 +483,12 @@ impl<T, A: Allocator> Box<T, A> {
     where
         A: Allocator,
     {
-        let layout = Layout::new::<mem::MaybeUninit<T>>();
-        let ptr = alloc.allocate(layout)?.cast();
+        let ptr = if T::IS_ZST {
+            NonNull::dangling()
+        } else {
+            let layout = Layout::new::<mem::MaybeUninit<T>>();
+            alloc.allocate(layout)?.cast()
+        };
         unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
     }
 
@@ -553,8 +557,12 @@ impl<T, A: Allocator> Box<T, A> {
     where
         A: Allocator,
     {
-        let layout = Layout::new::<mem::MaybeUninit<T>>();
-        let ptr = alloc.allocate_zeroed(layout)?.cast();
+        let ptr = if T::IS_ZST {
+            NonNull::dangling()
+        } else {
+            let layout = Layout::new::<mem::MaybeUninit<T>>();
+            alloc.allocate_zeroed(layout)?.cast()
+        };
         unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
     }
 
@@ -679,14 +687,16 @@ impl<T> Box<[T]> {
     #[unstable(feature = "allocator_api", issue = "32838")]
     #[inline]
     pub fn try_new_uninit_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
-        unsafe {
+        let ptr = if T::IS_ZST || len == 0 {
+            NonNull::dangling()
+        } else {
             let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
                 Ok(l) => l,
                 Err(_) => return Err(AllocError),
             };
-            let ptr = Global.allocate(layout)?;
-            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
-        }
+            Global.allocate(layout)?.cast()
+        };
+        unsafe { Ok(RawVec::from_raw_parts_in(ptr.as_ptr(), len, Global).into_box(len)) }
     }
 
     /// Constructs a new boxed slice with uninitialized contents, with the memory
@@ -711,14 +721,16 @@ impl<T> Box<[T]> {
     #[unstable(feature = "allocator_api", issue = "32838")]
     #[inline]
     pub fn try_new_zeroed_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
-        unsafe {
+        let ptr = if T::IS_ZST || len == 0 {
+            NonNull::dangling()
+        } else {
             let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
                 Ok(l) => l,
                 Err(_) => return Err(AllocError),
             };
-            let ptr = Global.allocate_zeroed(layout)?;
-            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
-        }
+            Global.allocate_zeroed(layout)?.cast()
+        };
+        unsafe { Ok(RawVec::from_raw_parts_in(ptr.as_ptr(), len, Global).into_box(len)) }
     }
 }
 
@@ -1223,7 +1235,9 @@ unsafe impl<#[may_dangle] T: ?Sized, A:
 
         unsafe {
             let layout = Layout::for_value_raw(ptr.as_ptr());
-            self.1.deallocate(From::from(ptr.cast()), layout)
+            if layout.size() != 0 {
+                self.1.deallocate(From::from(ptr.cast()), layout);
+            }
         }
     }
 }
@@ -2173,7 +2187,7 @@ impl dyn Error + Send {
         let err: Box<dyn Error> = self;
         <dyn Error>::downcast(err).map_err(|s| unsafe {
             // Reapply the `Send` marker.
-            mem::transmute::<Box<dyn Error>, Box<dyn Error + Send>>(s)
+            Box::from_raw(Box::into_raw(s) as *mut (dyn Error + Send))
         })
     }
 }
@@ -2187,7 +2201,7 @@ impl dyn Error + Send + Sync {
         let err: Box<dyn Error> = self;
         <dyn Error>::downcast(err).map_err(|s| unsafe {
             // Reapply the `Send + Sync` marker.
-            mem::transmute::<Box<dyn Error>, Box<dyn Error + Send + Sync>>(s)
+            Box::from_raw(Box::into_raw(s) as *mut (dyn Error + Send + Sync))
         })
     }
 }
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -60,7 +60,7 @@
 
 // To run alloc tests without x.py without ending up with two copies of alloc, Miri needs to be
 // able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
-// rustc itself never sets the feature, so this line has no affect there.
+// rustc itself never sets the feature, so this line has no effect there.
 #![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
 //
 #![allow(unused_attributes)]
@@ -90,6 +90,8 @@
 #![warn(missing_docs)]
 #![allow(explicit_outlives_requirements)]
 #![warn(multiple_supertrait_upcastable)]
+#![cfg_attr(not(bootstrap), allow(internal_features))]
+#![cfg_attr(not(bootstrap), allow(rustdoc::redundant_explicit_links))]
 //
 // Library features:
 // tidy-alphabetical-start
@@ -139,7 +141,6 @@
 #![feature(maybe_uninit_uninit_array_transpose)]
 #![feature(pattern)]
 #![feature(pointer_byte_offsets)]
-#![feature(provide_any)]
 #![feature(ptr_internals)]
 #![feature(ptr_metadata)]
 #![feature(ptr_sub_ptr)]
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -471,16 +471,26 @@ impl<T, A: Allocator> RawVec<T, A> {
         let (ptr, layout) = if let Some(mem) = self.current_memory() { mem } else { return Ok(()) };
         // See current_memory() why this assert is here
         let _: () = const { assert!(mem::size_of::<T>() % mem::align_of::<T>() == 0) };
-        let ptr = unsafe {
-            // `Layout::array` cannot overflow here because it would have
-            // overflowed earlier when capacity was larger.
-            let new_size = mem::size_of::<T>().unchecked_mul(cap);
-            let new_layout = Layout::from_size_align_unchecked(new_size, layout.align());
-            self.alloc
-                .shrink(ptr, layout, new_layout)
-                .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
-        };
-        self.set_ptr_and_cap(ptr, cap);
+
+        // If shrinking to 0, deallocate the buffer. We don't reach this point
+        // for the T::IS_ZST case since current_memory() will have returned
+        // None.
+        if cap == 0 {
+            unsafe { self.alloc.deallocate(ptr, layout) };
+            self.ptr = Unique::dangling();
+            self.cap = 0;
+        } else {
+            let ptr = unsafe {
+                // `Layout::array` cannot overflow here because it would have
+                // overflowed earlier when capacity was larger.
+                let new_size = mem::size_of::<T>().unchecked_mul(cap);
+                let new_layout = Layout::from_size_align_unchecked(new_size, layout.align());
+                self.alloc
+                    .shrink(ptr, layout, new_layout)
+                    .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
+            };
+            self.set_ptr_and_cap(ptr, cap);
+        }
         Ok(())
     }
 }
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -216,7 +216,7 @@ mod spec_extend;
 ///
 /// # Indexing
 ///
-/// The `Vec` type allows to access values by index, because it implements the
+/// The `Vec` type allows access to values by index, because it implements the
 /// [`Index`] trait. An example will be more explicit:
 ///
 /// ```
@@ -3263,7 +3263,7 @@ impl<T, A: Allocator> Vec<T, A> {
 /// [`copy_from_slice`]: slice::copy_from_slice
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "extend_ref", since = "1.2.0")]
-impl<'a, T: Copy + 'a, A: Allocator + 'a> Extend<&'a T> for Vec<T, A> {
+impl<'a, T: Copy + 'a, A: Allocator> Extend<&'a T> for Vec<T, A> {
     fn extend<I: IntoIterator<Item = &'a T>>(&mut self, iter: I) {
         self.spec_extend(iter.into_iter())
     }
--- a/rust/alloc/vec/spec_extend.rs
+++ b/rust/alloc/vec/spec_extend.rs
@@ -77,7 +77,7 @@ impl<T, A: Allocator> TrySpecExtend<T, I
 }
 
 #[cfg(not(no_global_oom_handling))]
-impl<'a, T: 'a, I, A: Allocator + 'a> SpecExtend<&'a T, I> for Vec<T, A>
+impl<'a, T: 'a, I, A: Allocator> SpecExtend<&'a T, I> for Vec<T, A>
 where
     I: Iterator<Item = &'a T>,
     T: Clone,
@@ -87,7 +87,7 @@ where
     }
 }
 
-impl<'a, T: 'a, I, A: Allocator + 'a> TrySpecExtend<&'a T, I> for Vec<T, A>
+impl<'a, T: 'a, I, A: Allocator> TrySpecExtend<&'a T, I> for Vec<T, A>
 where
     I: Iterator<Item = &'a T>,
     T: Clone,
@@ -98,7 +98,7 @@ where
 }
 
 #[cfg(not(no_global_oom_handling))]
-impl<'a, T: 'a, A: Allocator + 'a> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+impl<'a, T: 'a, A: Allocator> SpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
 where
     T: Copy,
 {
@@ -108,7 +108,7 @@ where
     }
 }
 
-impl<'a, T: 'a, A: Allocator + 'a> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
+impl<'a, T: 'a, A: Allocator> TrySpecExtend<&'a T, slice::Iter<'a, T>> for Vec<T, A>
 where
     T: Copy,
 {
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -19,6 +19,7 @@
 //! [`compiler_builtins`]: https://github.com/rust-lang/compiler-builtins
 //! [`compiler-rt`]: https://compiler-rt.llvm.org/
 
+#![allow(internal_features)]
 #![feature(compiler_builtins)]
 #![compiler_builtins]
 #![no_builtins]
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.72.1
+	echo 1.73.0
 	;;
 bindgen)
 	echo 0.65.1



