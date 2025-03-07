Return-Path: <stable+bounces-121492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2815BA57550
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546601710FE
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53A256C80;
	Fri,  7 Mar 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSo+QU+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AA2580C8;
	Fri,  7 Mar 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387937; cv=none; b=TbqZrmCnYRQP/K+aUkAPCd0ARpjX4c4/q4zVP/lyJMMfaqq+AydNfydOfWam7USWiT+WGjFkMeSo4084rswvzL6BnPRRh8RJyQO2her7U8+BFTRl4WILHls5EShsWz7jn2zUEP9tL9uAbYr5IXIoGI0uzNtsIbZSId8QOS7APoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387937; c=relaxed/simple;
	bh=PLMXsINKTAOXy2GRyaFu9D809mBWA8vjQbv3SurbvVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIeTpP9w8f2P1RFeGMgl2qV36E4JP+8g7pMGiD9nrjsQ1t355u5x9GgTJIdFLZ1XXRtpmYBdMIr6iZhof4tJmo2LNR2cHPfOBnoHq5pp1ZqO2EbWi+b6F+Mb0zTeF2hZaZJqLZfR07F50hknbMe/UkmkvadtkTwzI06t/YOE/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSo+QU+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8462C4CED1;
	Fri,  7 Mar 2025 22:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741387936;
	bh=PLMXsINKTAOXy2GRyaFu9D809mBWA8vjQbv3SurbvVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSo+QU+m2VQuezmXlMm+e4BgR0ACEUM/pFyyxhpkg9j9FGiCWOi9uiIeuXDzRVspr
	 m8gINqVntFDD94tnHaktCvFqlzuVJNTp5Ht9DcPr8r4HdZNFDwZ4A3WrfLx7iRTNkF
	 N84JTCDDPbgPf4F4T1hHV/XFI2slikCNAglTIXV7xB8k6FD07i/yQFE7H+RX5zCz4F
	 TtynE1JcGzTni1kqFy8wyJB48DWRCfvfsN6afONdNsnStFGxgV43wK5qKfFfQOqjZI
	 U31z1dhv5t3iQ+2Ts95h46stusR9stVPLv8XEg/bv8eyjYvSkVd4cloVinoj8OcAS1
	 L1ohpFjG4JiEg==
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
Subject: [PATCH 6.12.y 37/60] rust: alloc: implement `collect` for `IntoIter`
Date: Fri,  7 Mar 2025 23:49:44 +0100
Message-ID: <20250307225008.779961-38-ojeda@kernel.org>
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

commit 93e602310f87b7b515b86a8f919cc0799387e5c3 upstream.

Currently, we can't implement `FromIterator`. There are a couple of
issues with this trait in the kernel, namely:

  - Rust's specialization feature is unstable. This prevents us to
    optimize for the special case where `I::IntoIter` equals `Vec`'s
    `IntoIter` type.
  - We also can't use `I::IntoIter`'s type ID either to work around this,
    since `FromIterator` doesn't require this type to be `'static`.
  - `FromIterator::from_iter` does return `Self` instead of
    `Result<Self, AllocError>`, hence we can't properly handle allocation
    failures.
  - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
    additional allocation flags.

Instead, provide `IntoIter::collect`, such that we can at least convert
`IntoIter` into a `Vec` again.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/r/20241004154149.93856-19-dakr@kernel.org
[ Added newline in documentation, changed case of section to be
  consistent with an existing one, fixed typo. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc/kvec.rs | 95 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 4ddc2ca6cd32..ae9d072741ce 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -692,6 +692,101 @@ pub struct IntoIter<T, A: Allocator> {
     _p: PhantomData<A>,
 }
 
+impl<T, A> IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
+        let me = ManuallyDrop::new(self);
+        let ptr = me.ptr;
+        let buf = me.buf;
+        let len = me.len;
+        let cap = me.layout.len();
+        (ptr, buf, len, cap)
+    }
+
+    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2, 3]?;
+    /// let mut it = v.into_iter();
+    ///
+    /// assert_eq!(it.next(), Some(1));
+    ///
+    /// let v = it.collect(GFP_KERNEL);
+    /// assert_eq!(v, [2, 3]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// # Implementation details
+    ///
+    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
+    /// in the kernel, namely:
+    ///
+    /// - Rust's specialization feature is unstable. This prevents us to optimize for the special
+    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
+    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
+    ///   doesn't require this type to be `'static`.
+    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
+    ///   we can't properly handle allocation failures.
+    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
+    ///   flags.
+    ///
+    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
+    /// `Vec` again.
+    ///
+    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
+    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
+    pub fn collect(self, flags: Flags) -> Vec<T, A> {
+        let old_layout = self.layout;
+        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
+        let has_advanced = ptr != buf.as_ptr();
+
+        if has_advanced {
+            // Copy the contents we have advanced to at the beginning of the buffer.
+            //
+            // SAFETY:
+            // - `ptr` is valid for reads of `len * size_of::<T>()` bytes,
+            // - `buf.as_ptr()` is valid for writes of `len * size_of::<T>()` bytes,
+            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing restrictions relative to
+            //   each other,
+            // - both `ptr` and `buf.ptr()` are properly aligned.
+            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
+            ptr = buf.as_ptr();
+
+            // SAFETY: `len` is guaranteed to be smaller than `self.layout.len()`.
+            let layout = unsafe { ArrayLayout::<T>::new_unchecked(len) };
+
+            // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
+            // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
+            // it as it is.
+            ptr = match unsafe {
+                A::realloc(Some(buf.cast()), layout.into(), old_layout.into(), flags)
+            } {
+                // If we fail to shrink, which likely can't even happen, continue with the existing
+                // buffer.
+                Err(_) => ptr,
+                Ok(ptr) => {
+                    cap = len;
+                    ptr.as_ptr().cast()
+                }
+            };
+        }
+
+        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
+        // the beginning of the buffer and `len` has been adjusted accordingly.
+        //
+        // - `ptr` is guaranteed to point to the start of the backing buffer.
+        // - `cap` is either the original capacity or, after shrinking the buffer, equal to `len`.
+        // - `alloc` is guaranteed to be unchanged since `into_iter` has been called on the original
+        //   `Vec`.
+        unsafe { Vec::from_raw_parts(ptr, len, cap) }
+    }
+}
+
 impl<T, A> Iterator for IntoIter<T, A>
 where
     A: Allocator,
-- 
2.48.1


