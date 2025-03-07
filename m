Return-Path: <stable+bounces-121459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F1A5752C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7537E1899381
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0D2561DA;
	Fri,  7 Mar 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXV1c25w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164418BC36;
	Fri,  7 Mar 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387847; cv=none; b=T2HKITQLUm5WW0BcpIZh3hUqpchmbgyuM+5Ur0U/xgy7S80+duTw4V2PXi3u4UsRjdEMJfq+PuupvjZm3DbachLYNAjFqVMWw6wtJSehFmUQq8Dzlc3/jWJhtXCuzF+5s6lqXyPc8T8zHcdnycyP35wfOcIcyaJMu+7exlaSGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387847; c=relaxed/simple;
	bh=sBfKiUiaNMieaa0AzxNDSb0OBEsGDD+ACj1/I8qHKr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHqfWBja3wVJoiw5Ezk2Xz1ggkuoWwkpEmZFXAExGqUY0QGliK4T8oLo4Za/NoTM2APDiOeRwzEbYCdoxEPTbBteXJ8BqGBMiPTZc3sP4k+p7fZ2Wp2a+POcAJysM+yLSxu16SLgg4OLQeQBKwWAzWeEau9VYqIgwXInfexuLOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXV1c25w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837CC4CEE9;
	Fri,  7 Mar 2025 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387847;
	bh=sBfKiUiaNMieaa0AzxNDSb0OBEsGDD+ACj1/I8qHKr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXV1c25wCm+e/A0c/SMnZc5bYCfw8GE5O3xXhUER1aC0Bqmxbh82UO5lzBIdiTJcq
	 f8DK2CeW+ftjlHekLgriA49r7T7ttf0SswrGZVWaMW5giJSzLZ1m2sVGWGOdWUpTBw
	 yajkcdNWAGJVr9swKKuZ3R2PvosFOWNNL24yGT6mg1L2gVjviIjYIMYNya1RssL4Wq
	 r85IICwzBou8qL6fWyVHWzNYMeHooX03a2UJD42MAANR5QKXCO8WuIi/rIVb2ocI3J
	 ee4t8gT+1RlLaMPG5uYfN/1SQcTznkWsChMtO71odb1icbkKMJhEwaY+w9uGO3V/rT
	 Thi/JuVylC0eA==
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
Subject: [PATCH 6.12.y 04/60] rust: enable `clippy::undocumented_unsafe_blocks` lint
Date: Fri,  7 Mar 2025 23:49:11 +0100
Message-ID: <20250307225008.779961-5-ojeda@kernel.org>
In-Reply-To: <20250307225008.779961-1-ojeda@kernel.org>
References: <20250307225008.779961-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit db4f72c904cb116e2bf56afdd67fc5167a607a7b upstream.

Checking that we are not missing any `// SAFETY` comments in our `unsafe`
blocks is something we have wanted to do for a long time, as well as
cleaning up the remaining cases that were not documented [1].

Back when Rust for Linux started, this was something that could have
been done via a script, like Rust's `tidy`. Soon after, in Rust 1.58.0,
Clippy implemented the `undocumented_unsafe_blocks` lint [2].

Even though the lint has a few false positives, e.g. in some cases where
attributes appear between the comment and the `unsafe` block [3], there
are workarounds and the lint seems quite usable already.

Thus enable the lint now.

We still have a few cases to clean up, so just allow those for the moment
by writing a `TODO` comment -- some of those may be good candidates for
new contributors.

Link: https://github.com/Rust-for-Linux/linux/issues/351 [1]
Link: https://rust-lang.github.io/rust-clippy/master/#/undocumented_unsafe_blocks [2]
Link: https://github.com/rust-lang/rust-clippy/issues/13189 [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Tested-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20240904204347.168520-5-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile                       | 1 +
 mm/kasan/kasan_test_rust.rs    | 1 +
 rust/bindings/lib.rs           | 1 +
 rust/kernel/alloc/allocator.rs | 2 ++
 rust/kernel/error.rs           | 9 ++++++---
 rust/kernel/init.rs            | 5 +++++
 rust/kernel/init/__internal.rs | 2 ++
 rust/kernel/init/macros.rs     | 9 +++++++++
 rust/kernel/list.rs            | 1 +
 rust/kernel/print.rs           | 2 ++
 rust/kernel/str.rs             | 7 ++++---
 rust/kernel/sync/condvar.rs    | 2 +-
 rust/kernel/sync/lock.rs       | 6 +++---
 rust/kernel/types.rs           | 4 ++++
 rust/kernel/workqueue.rs       | 4 ++++
 rust/uapi/lib.rs               | 1 +
 16 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 6fbdb2e8ffff..a491ba904601 100644
--- a/Makefile
+++ b/Makefile
@@ -458,6 +458,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::needless_continue \
 			    -Aclippy::needless_lifetimes \
 			    -Wclippy::no_mangle_with_rust_abi \
+			    -Wclippy::undocumented_unsafe_blocks \
 			    -Wrustdoc::missing_crate_level_docs
 
 KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) \
diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
index caa7175964ef..47bcf033dd4f 100644
--- a/mm/kasan/kasan_test_rust.rs
+++ b/mm/kasan/kasan_test_rust.rs
@@ -17,5 +17,6 @@ pub extern "C" fn kasan_test_rust_uaf() -> u8 {
     }
     let ptr: *mut u8 = addr_of_mut!(v[2048]);
     drop(v);
+    // SAFETY: Incorrect, on purpose.
     unsafe { *ptr }
 }
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 93a1a3fc97bc..d6da3011281a 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -25,6 +25,7 @@
 )]
 
 #[allow(dead_code)]
+#[allow(clippy::undocumented_unsafe_blocks)]
 mod bindings_raw {
     // Use glob import here to expose all helpers.
     // Symbols defined within the module will take precedence to the glob import.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e6ea601f38c6..91216b36af69 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -31,6 +31,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
 }
 
+// SAFETY: TODO.
 unsafe impl GlobalAlloc for KernelAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
@@ -39,6 +40,7 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
+        // SAFETY: TODO.
         unsafe {
             bindings::kfree(ptr as *const core::ffi::c_void);
         }
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e..639bc7572f90 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -171,9 +171,11 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         match self.name() {
             // Print out number if no name can be found.
             None => f.debug_tuple("Error").field(&-self.0).finish(),
-            // SAFETY: These strings are ASCII-only.
             Some(name) => f
-                .debug_tuple(unsafe { core::str::from_utf8_unchecked(name) })
+                .debug_tuple(
+                    // SAFETY: These strings are ASCII-only.
+                    unsafe { core::str::from_utf8_unchecked(name) },
+                )
                 .finish(),
         }
     }
@@ -277,6 +279,8 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     if unsafe { bindings::IS_ERR(const_ptr) } {
         // SAFETY: The FFI function does not deref the pointer.
         let err = unsafe { bindings::PTR_ERR(const_ptr) };
+
+        #[allow(clippy::unnecessary_cast)]
         // CAST: If `IS_ERR()` returns `true`,
         // then `PTR_ERR()` is guaranteed to return a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
@@ -286,7 +290,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
         //
         // SAFETY: `IS_ERR()` ensures `err` is a
         // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
-        #[allow(clippy::unnecessary_cast)]
         return Err(unsafe { Error::from_errno_unchecked(err as core::ffi::c_int) });
     }
     Ok(ptr)
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 789f80f71ca7..a5857883e044 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -541,6 +541,7 @@ macro_rules! stack_try_pin_init {
 /// }
 /// pin_init!(&this in Buf {
 ///     buf: [0; 64],
+///     // SAFETY: TODO.
 ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
 ///     pin: PhantomPinned,
 /// });
@@ -875,6 +876,7 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
     /// }
     ///
     /// let foo = pin_init!(Foo {
+    ///     // SAFETY: TODO.
     ///     raw <- unsafe {
     ///         Opaque::ffi_init(|s| {
     ///             init_foo(s);
@@ -1162,6 +1164,7 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
 // SAFETY: Every type can be initialized by-value.
 unsafe impl<T, E> Init<T, E> for T {
     unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: TODO.
         unsafe { slot.write(self) };
         Ok(())
     }
@@ -1170,6 +1173,7 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
 // SAFETY: Every type can be initialized by-value. `__pinned_init` calls `__init`.
 unsafe impl<T, E> PinInit<T, E> for T {
     unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
+        // SAFETY: TODO.
         unsafe { self.__init(slot) }
     }
 }
@@ -1411,6 +1415,7 @@ pub fn zeroed<T: Zeroable>() -> impl Init<T> {
 
 macro_rules! impl_zeroable {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
         $(unsafe impl$($($generics)*)? Zeroable for $t {})*
     };
 }
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index 13cefd37512f..29f4fd00df3d 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -112,10 +112,12 @@ fn clone(&self) -> Self {
 
 impl<T: ?Sized> Copy for AllData<T> {}
 
+// SAFETY: TODO.
 unsafe impl<T: ?Sized> InitData for AllData<T> {
     type Datee = T;
 }
 
+// SAFETY: TODO.
 unsafe impl<T: ?Sized> HasInitData for T {
     type InitData = AllData<T>;
 
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 9a0c4650ef67..736fe0ce0cd9 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -513,6 +513,7 @@ fn drop($($sig:tt)*) {
             }
         ),
     ) => {
+        // SAFETY: TODO.
         unsafe $($impl_sig)* {
             // Inherit all attributes and the type/ident tokens for the signature.
             $(#[$($attr)*])*
@@ -872,6 +873,7 @@ unsafe fn __pin_data() -> Self::PinData {
                 }
             }
 
+            // SAFETY: TODO.
             unsafe impl<$($impl_generics)*>
                 $crate::init::__internal::PinData for __ThePinData<$($ty_generics)*>
             where $($whr)*
@@ -997,6 +999,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
                     slot: *mut $p_type,
                     init: impl $crate::init::PinInit<$p_type, E>,
                 ) -> ::core::result::Result<(), E> {
+                    // SAFETY: TODO.
                     unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
                 }
             )*
@@ -1007,6 +1010,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
                     slot: *mut $type,
                     init: impl $crate::init::Init<$type, E>,
                 ) -> ::core::result::Result<(), E> {
+                    // SAFETY: TODO.
                     unsafe { $crate::init::Init::__init(init, slot) }
                 }
             )*
@@ -1121,6 +1125,8 @@ macro_rules! __init_internal {
         // no possibility of returning without `unsafe`.
         struct __InitOk;
         // Get the data about fields from the supplied type.
+        //
+        // SAFETY: TODO.
         let data = unsafe {
             use $crate::init::__internal::$has_data;
             // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
@@ -1176,6 +1182,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         let init = move |slot| -> ::core::result::Result<(), $err> {
             init(slot).map(|__InitOk| ())
         };
+        // SAFETY: TODO.
         let init = unsafe { $crate::init::$construct_closure::<_, $err>(init) };
         init
     }};
@@ -1324,6 +1331,8 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // Endpoint, nothing more to munch, create the initializer.
         // Since we are in the closure that is never called, this will never get executed.
         // We abuse `slot` to get the correct type inference here:
+        //
+        // SAFETY: TODO.
         unsafe {
             // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
             // information that is associated to already parsed fragments, so a path fragment
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 5b4aec29eb67..fb93330f4af4 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -354,6 +354,7 @@ pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
     ///
     /// `item` must not be in a different linked list (with the same id).
     pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
+        // SAFETY: TODO.
         let mut item = unsafe { ListLinks::fields(T::view_links(item)) };
         // SAFETY: The user provided a reference, and reference are never dangling.
         //
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 508b0221256c..fe53fc469c4f 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -23,6 +23,7 @@
     use fmt::Write;
     // SAFETY: The C contract guarantees that `buf` is valid if it's less than `end`.
     let mut w = unsafe { RawFormatter::from_ptrs(buf.cast(), end.cast()) };
+    // SAFETY: TODO.
     let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
     w.pos().cast()
 }
@@ -102,6 +103,7 @@ pub unsafe fn call_printk(
 ) {
     // `_printk` does not seem to fail in any path.
     #[cfg(CONFIG_PRINTK)]
+    // SAFETY: TODO.
     unsafe {
         bindings::_printk(
             format_string.as_ptr() as _,
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index bb8d4f41475b..66d4527f6c6f 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -162,10 +162,10 @@ pub const fn len(&self) -> usize {
     /// Returns the length of this string with `NUL`.
     #[inline]
     pub const fn len_with_nul(&self) -> usize {
-        // SAFETY: This is one of the invariant of `CStr`.
-        // We add a `unreachable_unchecked` here to hint the optimizer that
-        // the value returned from this function is non-zero.
         if self.0.is_empty() {
+            // SAFETY: This is one of the invariant of `CStr`.
+            // We add a `unreachable_unchecked` here to hint the optimizer that
+            // the value returned from this function is non-zero.
             unsafe { core::hint::unreachable_unchecked() };
         }
         self.0.len()
@@ -301,6 +301,7 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8Error> {
     /// ```
     #[inline]
     pub unsafe fn as_str_unchecked(&self) -> &str {
+        // SAFETY: TODO.
         unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
     }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 2b306afbe56d..7e00048bf4b1 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -92,8 +92,8 @@ pub struct CondVar {
     _pin: PhantomPinned,
 }
 
-// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
 #[allow(clippy::non_send_fields_in_send_ty)]
+// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
 unsafe impl Send for CondVar {}
 
 // SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..07fcf2d8efc6 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -150,9 +150,9 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
 
-        // SAFETY: The lock was just unlocked above and is being relocked now.
-        let _relock =
-            ScopeGuard::new(|| unsafe { B::relock(self.lock.state.get(), &mut self.state) });
+        let _relock = ScopeGuard::new(||
+                // SAFETY: The lock was just unlocked above and is being relocked now.
+                unsafe { B::relock(self.lock.state.get(), &mut self.state) });
 
         cb()
     }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 70e173f15d87..6c2d5fa9bce3 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -410,6 +410,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
+    /// # // SAFETY: TODO.
     /// unsafe impl AlwaysRefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -417,6 +418,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data as *mut _).unwrap();
+    /// # // SAFETY: TODO.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///
@@ -483,6 +485,7 @@ pub unsafe trait FromBytes {}
 
 macro_rules! impl_frombytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
         $(unsafe impl$($($generics)*)? FromBytes for $t {})*
     };
 }
@@ -517,6 +520,7 @@ pub unsafe trait AsBytes {}
 
 macro_rules! impl_asbytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
+        // SAFETY: Safety comments written in the macro invocation.
         $(unsafe impl$($($generics)*)? AsBytes for $t {})*
     };
 }
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 493288dc1de0..3b3f1dbe8192 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -519,6 +519,7 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
     impl{T} HasWork<Self> for ClosureWork<T> { self.work }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
@@ -536,6 +537,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
     }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for Arc<T>
 where
     T: WorkItem<ID, Pointer = Self>,
@@ -564,6 +566,7 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
@@ -583,6 +586,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
     }
 }
 
+// SAFETY: TODO.
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
 where
     T: WorkItem<ID, Pointer = Self>,
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 80a00260e3e7..fea2de330d19 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -14,6 +14,7 @@
 #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
 #![allow(
     clippy::all,
+    clippy::undocumented_unsafe_blocks,
     dead_code,
     missing_docs,
     non_camel_case_types,
-- 
2.48.1


