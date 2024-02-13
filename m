Return-Path: <stable+bounces-19869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED888537A4
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8221F21585
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375BC5FEFE;
	Tue, 13 Feb 2024 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ijmY5I/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C315FB86;
	Tue, 13 Feb 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845264; cv=none; b=Tc2oHopy9hIp9WClI/p9V6gX7VCK5IzfK5aI8E/zjxDtT1yPIphK5yyty4dHuSHgTJMHgmAzMQnj/GHkeUn9HDUg1rbvx8UT3/K1TfTcfwhWzkVrgh6CCwVeMohtqq63JIGseJke5cG7vZxnhS1anX9j3OsdfJ5300N/5o1fAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845264; c=relaxed/simple;
	bh=rl4i7L+NTyv3WQb4WETk2vY4yPAf1Fwag5/YgetR3KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drRW1PqcXkJ6qV92schGlxggizqa0URD+HWJ++uPyIvE6r+4TNRO20+BYkrdGKfLApeXxL/UKd/4yPdOI5ZEHF6QJfagQm3dFLbj9tqZUg1rmX76EhL9pK4HHzqtu8EnSxcHCbXQqgCw8m6MNDxwumA+GqBU4fCX61EdDeuOkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0ijmY5I/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15064C433C7;
	Tue, 13 Feb 2024 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845263;
	bh=rl4i7L+NTyv3WQb4WETk2vY4yPAf1Fwag5/YgetR3KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0ijmY5I/bHbFuyRyQNMCZ+tM1m5c2rPJZg9H2ONl3J+IJ56oYmY49uEPOo0amcTcE
	 AvhX9cNQ3I3QoPPnYfZoC3y82sLA8tpTyQ5STJuAKsNjW7fpNwsy2n1ZNOtzgdtWxS
	 vejN7iUQBBaCkTwJBNU/Pq4AbOCxVd1BAouHCpwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6 013/121] rust: upgrade to Rust 1.72.1
Date: Tue, 13 Feb 2024 18:20:22 +0100
Message-ID: <20240213171853.356641988@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit ae6df65dabc3f8bd89663d96203963323e266d90 upstream.

This is the third upgrade to the Rust toolchain, from 1.71.1 to 1.72.1
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

No unstable features (that we use) were stabilized.

Therefore, the only unstable feature allowed to be used outside
the `kernel` crate is still `new_uninit`, though other code to be
upstreamed may increase the list.

Please see [3] for details.

# Other improvements

Previously, the compiler could incorrectly generate a `.eh_frame`
section under `-Cpanic=abort`. We were hitting this bug when debug
assertions were enabled (`CONFIG_RUST_DEBUG_ASSERTIONS=y`) [4]:

      LD      .tmp_vmlinux.kallsyms1
    ld.lld: error: <internal>:(.eh_frame) is being placed in '.eh_frame'

Gary fixed the issue in Rust 1.72.0 [5].

# Required changes

For the upgrade, the following changes are required:

  - A call to `Box::from_raw` in `rust/kernel/sync/arc.rs` now requires
    an explicit `drop()` call. See previous patch for details.

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

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1721-2023-09-19 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
Closes: https://github.com/Rust-for-Linux/linux/issues/1012 [4]
Link: https://github.com/rust-lang/rust/pull/112403 [5]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Link: https://lore.kernel.org/r/20230823160244.188033-3-ojeda@kernel.org
[ Used 1.72.1 instead of .0 (no changes in `alloc`) and reworded
  to mention that we hit the `.eh_frame` bug under debug assertions. ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/changes.rst |    2 
 rust/alloc/alloc.rs               |    9 -
 rust/alloc/boxed.rs               |   10 +
 rust/alloc/lib.rs                 |   10 -
 rust/alloc/vec/drain_filter.rs    |  199 --------------------------------------
 rust/alloc/vec/extract_if.rs      |  115 +++++++++++++++++++++
 rust/alloc/vec/mod.rs             |  106 +++++++++-----------
 scripts/min-tool-version.sh       |    2 
 8 files changed, 187 insertions(+), 266 deletions(-)
 delete mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/extract_if.rs

--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself wi
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.71.1           rustc --version
+Rust (optional)        1.72.1           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -6,8 +6,10 @@
 
 #[cfg(not(test))]
 use core::intrinsics;
+#[cfg(all(bootstrap, not(test)))]
 use core::intrinsics::{min_align_of_val, size_of_val};
 
+#[cfg(all(bootstrap, not(test)))]
 use core::ptr::Unique;
 #[cfg(not(test))]
 use core::ptr::{self, NonNull};
@@ -40,7 +42,6 @@ extern "Rust" {
     #[rustc_nounwind]
     fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8;
 
-    #[cfg(not(bootstrap))]
     static __rust_no_alloc_shim_is_unstable: u8;
 }
 
@@ -98,7 +99,6 @@ pub unsafe fn alloc(layout: Layout) -> *
     unsafe {
         // Make sure we don't accidentally allow omitting the allocator shim in
         // stable code until it is actually stabilized.
-        #[cfg(not(bootstrap))]
         core::ptr::read_volatile(&__rust_no_alloc_shim_is_unstable);
 
         __rust_alloc(layout.size(), layout.align())
@@ -339,14 +339,15 @@ unsafe fn exchange_malloc(size: usize, a
     }
 }
 
-#[cfg_attr(not(test), lang = "box_free")]
+#[cfg(all(bootstrap, not(test)))]
+#[lang = "box_free"]
 #[inline]
 // This signature has to be the same as `Box`, otherwise an ICE will happen.
 // When an additional parameter to `Box` is added (like `A: Allocator`), this has to be added here as
 // well.
 // For example if `Box` is changed to  `struct Box<T: ?Sized, A: Allocator>(Unique<T>, A)`,
 // this function has to be changed to `fn box_free<T: ?Sized, A: Allocator>(Unique<T>, A)` as well.
-pub(crate) unsafe fn box_free<T: ?Sized, A: Allocator>(ptr: Unique<T>, alloc: A) {
+unsafe fn box_free<T: ?Sized, A: Allocator>(ptr: Unique<T>, alloc: A) {
     unsafe {
         let size = size_of_val(ptr.as_ref());
         let align = min_align_of_val(ptr.as_ref());
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -1215,8 +1215,16 @@ impl<T: ?Sized, A: Allocator> Box<T, A>
 
 #[stable(feature = "rust1", since = "1.0.0")]
 unsafe impl<#[may_dangle] T: ?Sized, A: Allocator> Drop for Box<T, A> {
+    #[inline]
     fn drop(&mut self) {
-        // FIXME: Do nothing, drop is currently performed by compiler.
+        // the T in the Box is dropped by the compiler before the destructor is run
+
+        let ptr = self.0;
+
+        unsafe {
+            let layout = Layout::for_value_raw(ptr.as_ptr());
+            self.1.deallocate(From::from(ptr.cast()), layout)
+        }
     }
 }
 
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -58,6 +58,11 @@
 //! [`Rc`]: rc
 //! [`RefCell`]: core::cell
 
+// To run alloc tests without x.py without ending up with two copies of alloc, Miri needs to be
+// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
+// rustc itself never sets the feature, so this line has no affect there.
+#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
+//
 #![allow(unused_attributes)]
 #![stable(feature = "alloc", since = "1.36.0")]
 #![doc(
@@ -77,11 +82,6 @@
 ))]
 #![no_std]
 #![needs_allocator]
-// To run alloc tests without x.py without ending up with two copies of alloc, Miri needs to be
-// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
-// rustc itself never sets the feature, so this line has no affect there.
-#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
-//
 // Lints:
 #![deny(unsafe_op_in_unsafe_fn)]
 #![deny(fuzzy_provenance_casts)]
--- a/rust/alloc/vec/drain_filter.rs
+++ /dev/null
@@ -1,199 +0,0 @@
-// SPDX-License-Identifier: Apache-2.0 OR MIT
-
-use crate::alloc::{Allocator, Global};
-use core::mem::{ManuallyDrop, SizedTypeProperties};
-use core::ptr;
-use core::slice;
-
-use super::Vec;
-
-/// An iterator which uses a closure to determine if an element should be removed.
-///
-/// This struct is created by [`Vec::drain_filter`].
-/// See its documentation for more.
-///
-/// # Example
-///
-/// ```
-/// #![feature(drain_filter)]
-///
-/// let mut v = vec![0, 1, 2];
-/// let iter: std::vec::DrainFilter<'_, _, _> = v.drain_filter(|x| *x % 2 == 0);
-/// ```
-#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
-#[derive(Debug)]
-pub struct DrainFilter<
-    'a,
-    T,
-    F,
-    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
-> where
-    F: FnMut(&mut T) -> bool,
-{
-    pub(super) vec: &'a mut Vec<T, A>,
-    /// The index of the item that will be inspected by the next call to `next`.
-    pub(super) idx: usize,
-    /// The number of items that have been drained (removed) thus far.
-    pub(super) del: usize,
-    /// The original length of `vec` prior to draining.
-    pub(super) old_len: usize,
-    /// The filter test predicate.
-    pub(super) pred: F,
-    /// A flag that indicates a panic has occurred in the filter test predicate.
-    /// This is used as a hint in the drop implementation to prevent consumption
-    /// of the remainder of the `DrainFilter`. Any unprocessed items will be
-    /// backshifted in the `vec`, but no further items will be dropped or
-    /// tested by the filter predicate.
-    pub(super) panic_flag: bool,
-}
-
-impl<T, F, A: Allocator> DrainFilter<'_, T, F, A>
-where
-    F: FnMut(&mut T) -> bool,
-{
-    /// Returns a reference to the underlying allocator.
-    #[unstable(feature = "allocator_api", issue = "32838")]
-    #[inline]
-    pub fn allocator(&self) -> &A {
-        self.vec.allocator()
-    }
-
-    /// Keep unyielded elements in the source `Vec`.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// #![feature(drain_filter)]
-    /// #![feature(drain_keep_rest)]
-    ///
-    /// let mut vec = vec!['a', 'b', 'c'];
-    /// let mut drain = vec.drain_filter(|_| true);
-    ///
-    /// assert_eq!(drain.next().unwrap(), 'a');
-    ///
-    /// // This call keeps 'b' and 'c' in the vec.
-    /// drain.keep_rest();
-    ///
-    /// // If we wouldn't call `keep_rest()`,
-    /// // `vec` would be empty.
-    /// assert_eq!(vec, ['b', 'c']);
-    /// ```
-    #[unstable(feature = "drain_keep_rest", issue = "101122")]
-    pub fn keep_rest(self) {
-        // At this moment layout looks like this:
-        //
-        //  _____________________/-- old_len
-        // /                     \
-        // [kept] [yielded] [tail]
-        //        \_______/ ^-- idx
-        //                \-- del
-        //
-        // Normally `Drop` impl would drop [tail] (via .for_each(drop), ie still calling `pred`)
-        //
-        // 1. Move [tail] after [kept]
-        // 2. Update length of the original vec to `old_len - del`
-        //    a. In case of ZST, this is the only thing we want to do
-        // 3. Do *not* drop self, as everything is put in a consistent state already, there is nothing to do
-        let mut this = ManuallyDrop::new(self);
-
-        unsafe {
-            // ZSTs have no identity, so we don't need to move them around.
-            if !T::IS_ZST && this.idx < this.old_len && this.del > 0 {
-                let ptr = this.vec.as_mut_ptr();
-                let src = ptr.add(this.idx);
-                let dst = src.sub(this.del);
-                let tail_len = this.old_len - this.idx;
-                src.copy_to(dst, tail_len);
-            }
-
-            let new_len = this.old_len - this.del;
-            this.vec.set_len(new_len);
-        }
-    }
-}
-
-#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
-impl<T, F, A: Allocator> Iterator for DrainFilter<'_, T, F, A>
-where
-    F: FnMut(&mut T) -> bool,
-{
-    type Item = T;
-
-    fn next(&mut self) -> Option<T> {
-        unsafe {
-            while self.idx < self.old_len {
-                let i = self.idx;
-                let v = slice::from_raw_parts_mut(self.vec.as_mut_ptr(), self.old_len);
-                self.panic_flag = true;
-                let drained = (self.pred)(&mut v[i]);
-                self.panic_flag = false;
-                // Update the index *after* the predicate is called. If the index
-                // is updated prior and the predicate panics, the element at this
-                // index would be leaked.
-                self.idx += 1;
-                if drained {
-                    self.del += 1;
-                    return Some(ptr::read(&v[i]));
-                } else if self.del > 0 {
-                    let del = self.del;
-                    let src: *const T = &v[i];
-                    let dst: *mut T = &mut v[i - del];
-                    ptr::copy_nonoverlapping(src, dst, 1);
-                }
-            }
-            None
-        }
-    }
-
-    fn size_hint(&self) -> (usize, Option<usize>) {
-        (0, Some(self.old_len - self.idx))
-    }
-}
-
-#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
-impl<T, F, A: Allocator> Drop for DrainFilter<'_, T, F, A>
-where
-    F: FnMut(&mut T) -> bool,
-{
-    fn drop(&mut self) {
-        struct BackshiftOnDrop<'a, 'b, T, F, A: Allocator>
-        where
-            F: FnMut(&mut T) -> bool,
-        {
-            drain: &'b mut DrainFilter<'a, T, F, A>,
-        }
-
-        impl<'a, 'b, T, F, A: Allocator> Drop for BackshiftOnDrop<'a, 'b, T, F, A>
-        where
-            F: FnMut(&mut T) -> bool,
-        {
-            fn drop(&mut self) {
-                unsafe {
-                    if self.drain.idx < self.drain.old_len && self.drain.del > 0 {
-                        // This is a pretty messed up state, and there isn't really an
-                        // obviously right thing to do. We don't want to keep trying
-                        // to execute `pred`, so we just backshift all the unprocessed
-                        // elements and tell the vec that they still exist. The backshift
-                        // is required to prevent a double-drop of the last successfully
-                        // drained item prior to a panic in the predicate.
-                        let ptr = self.drain.vec.as_mut_ptr();
-                        let src = ptr.add(self.drain.idx);
-                        let dst = src.sub(self.drain.del);
-                        let tail_len = self.drain.old_len - self.drain.idx;
-                        src.copy_to(dst, tail_len);
-                    }
-                    self.drain.vec.set_len(self.drain.old_len - self.drain.del);
-                }
-            }
-        }
-
-        let backshift = BackshiftOnDrop { drain: self };
-
-        // Attempt to consume any remaining elements if the filter predicate
-        // has not yet panicked. We'll backshift any remaining elements
-        // whether we've already panicked or if the consumption here panics.
-        if !backshift.drain.panic_flag {
-            backshift.drain.for_each(drop);
-        }
-    }
-}
--- /dev/null
+++ b/rust/alloc/vec/extract_if.rs
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use crate::alloc::{Allocator, Global};
+use core::ptr;
+use core::slice;
+
+use super::Vec;
+
+/// An iterator which uses a closure to determine if an element should be removed.
+///
+/// This struct is created by [`Vec::extract_if`].
+/// See its documentation for more.
+///
+/// # Example
+///
+/// ```
+/// #![feature(extract_if)]
+///
+/// let mut v = vec![0, 1, 2];
+/// let iter: std::vec::ExtractIf<'_, _, _> = v.extract_if(|x| *x % 2 == 0);
+/// ```
+#[unstable(feature = "extract_if", reason = "recently added", issue = "43244")]
+#[derive(Debug)]
+#[must_use = "iterators are lazy and do nothing unless consumed"]
+pub struct ExtractIf<
+    'a,
+    T,
+    F,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+> where
+    F: FnMut(&mut T) -> bool,
+{
+    pub(super) vec: &'a mut Vec<T, A>,
+    /// The index of the item that will be inspected by the next call to `next`.
+    pub(super) idx: usize,
+    /// The number of items that have been drained (removed) thus far.
+    pub(super) del: usize,
+    /// The original length of `vec` prior to draining.
+    pub(super) old_len: usize,
+    /// The filter test predicate.
+    pub(super) pred: F,
+}
+
+impl<T, F, A: Allocator> ExtractIf<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        self.vec.allocator()
+    }
+}
+
+#[unstable(feature = "extract_if", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Iterator for ExtractIf<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    type Item = T;
+
+    fn next(&mut self) -> Option<T> {
+        unsafe {
+            while self.idx < self.old_len {
+                let i = self.idx;
+                let v = slice::from_raw_parts_mut(self.vec.as_mut_ptr(), self.old_len);
+                let drained = (self.pred)(&mut v[i]);
+                // Update the index *after* the predicate is called. If the index
+                // is updated prior and the predicate panics, the element at this
+                // index would be leaked.
+                self.idx += 1;
+                if drained {
+                    self.del += 1;
+                    return Some(ptr::read(&v[i]));
+                } else if self.del > 0 {
+                    let del = self.del;
+                    let src: *const T = &v[i];
+                    let dst: *mut T = &mut v[i - del];
+                    ptr::copy_nonoverlapping(src, dst, 1);
+                }
+            }
+            None
+        }
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (0, Some(self.old_len - self.idx))
+    }
+}
+
+#[unstable(feature = "extract_if", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Drop for ExtractIf<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    fn drop(&mut self) {
+        unsafe {
+            if self.idx < self.old_len && self.del > 0 {
+                // This is a pretty messed up state, and there isn't really an
+                // obviously right thing to do. We don't want to keep trying
+                // to execute `pred`, so we just backshift all the unprocessed
+                // elements and tell the vec that they still exist. The backshift
+                // is required to prevent a double-drop of the last successfully
+                // drained item prior to a panic in the predicate.
+                let ptr = self.vec.as_mut_ptr();
+                let src = ptr.add(self.idx);
+                let dst = src.sub(self.del);
+                let tail_len = self.old_len - self.idx;
+                src.copy_to(dst, tail_len);
+            }
+            self.vec.set_len(self.old_len - self.del);
+        }
+    }
+}
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -74,10 +74,10 @@ use crate::boxed::Box;
 use crate::collections::{TryReserveError, TryReserveErrorKind};
 use crate::raw_vec::RawVec;
 
-#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
-pub use self::drain_filter::DrainFilter;
+#[unstable(feature = "extract_if", reason = "recently added", issue = "43244")]
+pub use self::extract_if::ExtractIf;
 
-mod drain_filter;
+mod extract_if;
 
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "vec_splice", since = "1.21.0")]
@@ -618,22 +618,20 @@ impl<T> Vec<T> {
     /// Using memory that was allocated elsewhere:
     ///
     /// ```rust
-    /// #![feature(allocator_api)]
-    ///
-    /// use std::alloc::{AllocError, Allocator, Global, Layout};
+    /// use std::alloc::{alloc, Layout};
     ///
     /// fn main() {
     ///     let layout = Layout::array::<u32>(16).expect("overflow cannot happen");
     ///
     ///     let vec = unsafe {
-    ///         let mem = match Global.allocate(layout) {
-    ///             Ok(mem) => mem.cast::<u32>().as_ptr(),
-    ///             Err(AllocError) => return,
-    ///         };
+    ///         let mem = alloc(layout).cast::<u32>();
+    ///         if mem.is_null() {
+    ///             return;
+    ///         }
     ///
     ///         mem.write(1_000_000);
     ///
-    ///         Vec::from_raw_parts_in(mem, 1, 16, Global)
+    ///         Vec::from_raw_parts(mem, 1, 16)
     ///     };
     ///
     ///     assert_eq!(vec, &[1_000_000]);
@@ -876,19 +874,22 @@ impl<T, A: Allocator> Vec<T, A> {
     /// Using memory that was allocated elsewhere:
     ///
     /// ```rust
-    /// use std::alloc::{alloc, Layout};
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::{AllocError, Allocator, Global, Layout};
     ///
     /// fn main() {
     ///     let layout = Layout::array::<u32>(16).expect("overflow cannot happen");
+    ///
     ///     let vec = unsafe {
-    ///         let mem = alloc(layout).cast::<u32>();
-    ///         if mem.is_null() {
-    ///             return;
-    ///         }
+    ///         let mem = match Global.allocate(layout) {
+    ///             Ok(mem) => mem.cast::<u32>().as_ptr(),
+    ///             Err(AllocError) => return,
+    ///         };
     ///
     ///         mem.write(1_000_000);
     ///
-    ///         Vec::from_raw_parts(mem, 1, 16)
+    ///         Vec::from_raw_parts_in(mem, 1, 16, Global)
     ///     };
     ///
     ///     assert_eq!(vec, &[1_000_000]);
@@ -2507,7 +2508,7 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         let len = self.len();
 
         if new_len > len {
-            self.extend_with(new_len - len, ExtendElement(value))
+            self.extend_with(new_len - len, value)
         } else {
             self.truncate(new_len);
         }
@@ -2545,7 +2546,7 @@ impl<T: Clone, A: Allocator> Vec<T, A> {
         let len = self.len();
 
         if new_len > len {
-            self.try_extend_with(new_len - len, ExtendElement(value))
+            self.try_extend_with(new_len - len, value)
         } else {
             self.truncate(new_len);
             Ok(())
@@ -2684,26 +2685,10 @@ impl<T, A: Allocator, const N: usize> Ve
     }
 }
 
-// This code generalizes `extend_with_{element,default}`.
-trait ExtendWith<T> {
-    fn next(&mut self) -> T;
-    fn last(self) -> T;
-}
-
-struct ExtendElement<T>(T);
-impl<T: Clone> ExtendWith<T> for ExtendElement<T> {
-    fn next(&mut self) -> T {
-        self.0.clone()
-    }
-    fn last(self) -> T {
-        self.0
-    }
-}
-
-impl<T, A: Allocator> Vec<T, A> {
+impl<T: Clone, A: Allocator> Vec<T, A> {
     #[cfg(not(no_global_oom_handling))]
-    /// Extend the vector by `n` values, using the given generator.
-    fn extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) {
+    /// Extend the vector by `n` clones of value.
+    fn extend_with(&mut self, n: usize, value: T) {
         self.reserve(n);
 
         unsafe {
@@ -2715,15 +2700,15 @@ impl<T, A: Allocator> Vec<T, A> {
 
             // Write all elements except the last one
             for _ in 1..n {
-                ptr::write(ptr, value.next());
+                ptr::write(ptr, value.clone());
                 ptr = ptr.add(1);
-                // Increment the length in every step in case next() panics
+                // Increment the length in every step in case clone() panics
                 local_len.increment_len(1);
             }
 
             if n > 0 {
                 // We can write the last element directly without cloning needlessly
-                ptr::write(ptr, value.last());
+                ptr::write(ptr, value);
                 local_len.increment_len(1);
             }
 
@@ -2731,8 +2716,8 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
-    /// Try to extend the vector by `n` values, using the given generator.
-    fn try_extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) -> Result<(), TryReserveError> {
+    /// Try to extend the vector by `n` clones of value.
+    fn try_extend_with(&mut self, n: usize, value: T) -> Result<(), TryReserveError> {
         self.try_reserve(n)?;
 
         unsafe {
@@ -2744,15 +2729,15 @@ impl<T, A: Allocator> Vec<T, A> {
 
             // Write all elements except the last one
             for _ in 1..n {
-                ptr::write(ptr, value.next());
+                ptr::write(ptr, value.clone());
                 ptr = ptr.add(1);
-                // Increment the length in every step in case next() panics
+                // Increment the length in every step in case clone() panics
                 local_len.increment_len(1);
             }
 
             if n > 0 {
                 // We can write the last element directly without cloning needlessly
-                ptr::write(ptr, value.last());
+                ptr::write(ptr, value);
                 local_len.increment_len(1);
             }
 
@@ -3210,6 +3195,12 @@ impl<T, A: Allocator> Vec<T, A> {
     /// If the closure returns false, the element will remain in the vector and will not be yielded
     /// by the iterator.
     ///
+    /// If the returned `ExtractIf` is not exhausted, e.g. because it is dropped without iterating
+    /// or the iteration short-circuits, then the remaining elements will be retained.
+    /// Use [`retain`] with a negated predicate if you do not need the returned iterator.
+    ///
+    /// [`retain`]: Vec::retain
+    ///
     /// Using this method is equivalent to the following code:
     ///
     /// ```
@@ -3228,10 +3219,10 @@ impl<T, A: Allocator> Vec<T, A> {
     /// # assert_eq!(vec, vec![1, 4, 5]);
     /// ```
     ///
-    /// But `drain_filter` is easier to use. `drain_filter` is also more efficient,
+    /// But `extract_if` is easier to use. `extract_if` is also more efficient,
     /// because it can backshift the elements of the array in bulk.
     ///
-    /// Note that `drain_filter` also lets you mutate every element in the filter closure,
+    /// Note that `extract_if` also lets you mutate every element in the filter closure,
     /// regardless of whether you choose to keep or remove it.
     ///
     /// # Examples
@@ -3239,17 +3230,17 @@ impl<T, A: Allocator> Vec<T, A> {
     /// Splitting an array into evens and odds, reusing the original allocation:
     ///
     /// ```
-    /// #![feature(drain_filter)]
+    /// #![feature(extract_if)]
     /// let mut numbers = vec![1, 2, 3, 4, 5, 6, 8, 9, 11, 13, 14, 15];
     ///
-    /// let evens = numbers.drain_filter(|x| *x % 2 == 0).collect::<Vec<_>>();
+    /// let evens = numbers.extract_if(|x| *x % 2 == 0).collect::<Vec<_>>();
     /// let odds = numbers;
     ///
     /// assert_eq!(evens, vec![2, 4, 6, 8, 14]);
     /// assert_eq!(odds, vec![1, 3, 5, 9, 11, 13, 15]);
     /// ```
-    #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
-    pub fn drain_filter<F>(&mut self, filter: F) -> DrainFilter<'_, T, F, A>
+    #[unstable(feature = "extract_if", reason = "recently added", issue = "43244")]
+    pub fn extract_if<F>(&mut self, filter: F) -> ExtractIf<'_, T, F, A>
     where
         F: FnMut(&mut T) -> bool,
     {
@@ -3260,7 +3251,7 @@ impl<T, A: Allocator> Vec<T, A> {
             self.set_len(0);
         }
 
-        DrainFilter { vec: self, idx: 0, del: 0, old_len, pred: filter, panic_flag: false }
+        ExtractIf { vec: self, idx: 0, del: 0, old_len, pred: filter }
     }
 }
 
@@ -3290,9 +3281,14 @@ impl<'a, T: Copy + 'a, A: Allocator + 'a
 
 /// Implements comparison of vectors, [lexicographically](Ord#lexicographical-comparison).
 #[stable(feature = "rust1", since = "1.0.0")]
-impl<T: PartialOrd, A: Allocator> PartialOrd for Vec<T, A> {
+impl<T, A1, A2> PartialOrd<Vec<T, A2>> for Vec<T, A1>
+where
+    T: PartialOrd,
+    A1: Allocator,
+    A2: Allocator,
+{
     #[inline]
-    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
+    fn partial_cmp(&self, other: &Vec<T, A2>) -> Option<Ordering> {
         PartialOrd::partial_cmp(&**self, &**other)
     }
 }
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.71.1
+	echo 1.72.1
 	;;
 bindgen)
 	echo 0.65.1



