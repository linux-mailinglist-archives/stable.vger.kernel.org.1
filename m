Return-Path: <stable+bounces-97775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E19E2579
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AF5285794
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A61F76A4;
	Tue,  3 Dec 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CPdGkMP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984F23CE;
	Tue,  3 Dec 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241690; cv=none; b=XRKdbd2kO2FgD0HGgBaKdFxMtpGXg8KRRzScFYqn7cC+Gu43a2awDW5CPDTrGCJRXvjd6LuGN0ZGZpas16fnv9gwh2qH6YpQ+kSBYm26C2WQFYCLBcTcDxAPkEvhpL5+Jrnzt9l7H+feMvuYXvbMr2bBj5S0f6zNvDICN41+mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241690; c=relaxed/simple;
	bh=Dk3YHLzE5B/TqyEajFtNdwYgXniGsMgxhJ445cjNC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqTw1NAmv4c5redIS/7wzC6LV/6XztXYeEkpLB1hSKjgC+zzhuX4RoI9FmC61seoVrTtVIJc4OW9ssVuvfQ56EjSYJqcEqr91SOZA09XIAZMjc7pmWYKG7QYueyQqUDsAviG8VkpEZAQPrphSCeM4HbtWWXZqvvvCS5k3IIeGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CPdGkMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD08AC4CECF;
	Tue,  3 Dec 2024 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241690;
	bh=Dk3YHLzE5B/TqyEajFtNdwYgXniGsMgxhJ445cjNC94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0CPdGkMPkbQ50Xr+oG8i06IY2RB32c686dIOeyH3lprfl/AfTd1EFb+lPX+0tH3u2
	 Smpdc9YtaV1bZ/+zXwYCDY90XwyYJ0Ebl6rfXBlwc6OcBK70f1F5mr1s5ilYjT2O7c
	 qPiuW85/eIRPg1fV9na/D9kq3Yc5wIA8Jr4thWSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Francesco Zardi <frazar00@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 491/826] rust: block: fix formatting of `kernel::block::mq::request` module
Date: Tue,  3 Dec 2024 15:43:38 +0100
Message-ID: <20241203144802.909832718@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Zardi <frazar00@gmail.com>

[ Upstream commit 28e848386b92645f93b9f2fdba5882c3ca7fb3e2 ]

Fix several issues with rustdoc formatting for the
`kernel::block::mq::Request` module, in particular:

  - An ordered list not rendering correctly, fixed by using numbers
    prefixes instead of letters.

  - Code snippets formatted as regular text, fixed by wrapping the
    code with `back-ticks`.

  - References to types missing intra-doc links, fixed by wrapping the
    types with [square brackets].

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1108
Signed-off-by: Francesco Zardi <frazar00@gmail.com>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Link: https://lore.kernel.org/r/20240903173027.16732-3-frazar00@gmail.com
[ Added an extra intra-doc link. Took the chance to add some periods
  for consistency. Reworded slightly. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/block/mq/request.rs | 67 +++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4e..7943f43b95753 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -16,50 +16,55 @@
     sync::atomic::{AtomicU64, Ordering},
 };
 
-/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+/// A wrapper around a blk-mq [`struct request`]. This represents an IO request.
 ///
 /// # Implementation details
 ///
 /// There are four states for a request that the Rust bindings care about:
 ///
-/// A) Request is owned by block layer (refcount 0)
-/// B) Request is owned by driver but with zero `ARef`s in existence
-///    (refcount 1)
-/// C) Request is owned by driver with exactly one `ARef` in existence
-///    (refcount 2)
-/// D) Request is owned by driver with more than one `ARef` in existence
-///    (refcount > 2)
+/// 1. Request is owned by block layer (refcount 0).
+/// 2. Request is owned by driver but with zero [`ARef`]s in existence
+///    (refcount 1).
+/// 3. Request is owned by driver with exactly one [`ARef`] in existence
+///    (refcount 2).
+/// 4. Request is owned by driver with more than one [`ARef`] in existence
+///    (refcount > 2).
 ///
 ///
-/// We need to track A and B to ensure we fail tag to request conversions for
+/// We need to track 1 and 2 to ensure we fail tag to request conversions for
 /// requests that are not owned by the driver.
 ///
-/// We need to track C and D to ensure that it is safe to end the request and hand
+/// We need to track 3 and 4 to ensure that it is safe to end the request and hand
 /// back ownership to the block layer.
 ///
 /// The states are tracked through the private `refcount` field of
 /// `RequestDataWrapper`. This structure lives in the private data area of the C
-/// `struct request`.
+/// [`struct request`].
 ///
 /// # Invariants
 ///
-/// * `self.0` is a valid `struct request` created by the C portion of the kernel.
+/// * `self.0` is a valid [`struct request`] created by the C portion of the
+///   kernel.
 /// * The private data area associated with this request must be an initialized
 ///   and valid `RequestDataWrapper<T>`.
 /// * `self` is reference counted by atomic modification of
-///   self.wrapper_ref().refcount().
+///   `self.wrapper_ref().refcount()`.
+///
+/// [`struct request`]: srctree/include/linux/blk-mq.h
 ///
 #[repr(transparent)]
 pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
 
 impl<T: Operations> Request<T> {
-    /// Create an `ARef<Request>` from a `struct request` pointer.
+    /// Create an [`ARef<Request>`] from a [`struct request`] pointer.
     ///
     /// # Safety
     ///
     /// * The caller must own a refcount on `ptr` that is transferred to the
-    ///   returned `ARef`.
-    /// * The type invariants for `Request` must hold for the pointee of `ptr`.
+    ///   returned [`ARef`].
+    /// * The type invariants for [`Request`] must hold for the pointee of `ptr`.
+    ///
+    /// [`struct request`]: srctree/include/linux/blk-mq.h
     pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
         // INVARIANT: By the safety requirements of this function, invariants are upheld.
         // SAFETY: By the safety requirement of this function, we own a
@@ -84,12 +89,14 @@ pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
     }
 
     /// Try to take exclusive ownership of `this` by dropping the refcount to 0.
-    /// This fails if `this` is not the only `ARef` pointing to the underlying
-    /// `Request`.
+    /// This fails if `this` is not the only [`ARef`] pointing to the underlying
+    /// [`Request`].
     ///
-    /// If the operation is successful, `Ok` is returned with a pointer to the
-    /// C `struct request`. If the operation fails, `this` is returned in the
-    /// `Err` variant.
+    /// If the operation is successful, [`Ok`] is returned with a pointer to the
+    /// C [`struct request`]. If the operation fails, `this` is returned in the
+    /// [`Err`] variant.
+    ///
+    /// [`struct request`]: srctree/include/linux/blk-mq.h
     fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
         // We can race with `TagSet::tag_to_rq`
         if let Err(_old) = this.wrapper_ref().refcount().compare_exchange(
@@ -109,7 +116,7 @@ fn try_set_end(this: ARef<Self>) -> Result<*mut bindings::request, ARef<Self>> {
 
     /// Notify the block layer that the request has been completed without errors.
     ///
-    /// This function will return `Err` if `this` is not the only `ARef`
+    /// This function will return [`Err`] if `this` is not the only [`ARef`]
     /// referencing the request.
     pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         let request_ptr = Self::try_set_end(this)?;
@@ -123,13 +130,13 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
         Ok(())
     }
 
-    /// Return a pointer to the `RequestDataWrapper` stored in the private area
+    /// Return a pointer to the [`RequestDataWrapper`] stored in the private area
     /// of the request structure.
     ///
     /// # Safety
     ///
     /// - `this` must point to a valid allocation of size at least size of
-    ///   `Self` plus size of `RequestDataWrapper`.
+    ///   [`Self`] plus size of [`RequestDataWrapper`].
     pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
         let request_ptr = this.cast::<bindings::request>();
         // SAFETY: By safety requirements for this function, `this` is a
@@ -141,7 +148,7 @@ pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper>
         unsafe { NonNull::new_unchecked(wrapper_ptr) }
     }
 
-    /// Return a reference to the `RequestDataWrapper` stored in the private
+    /// Return a reference to the [`RequestDataWrapper`] stored in the private
     /// area of the request structure.
     pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
         // SAFETY: By type invariant, `self.0` is a valid allocation. Further,
@@ -152,13 +159,15 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
     }
 }
 
-/// A wrapper around data stored in the private area of the C `struct request`.
+/// A wrapper around data stored in the private area of the C [`struct request`].
+///
+/// [`struct request`]: srctree/include/linux/blk-mq.h
 pub(crate) struct RequestDataWrapper {
     /// The Rust request refcount has the following states:
     ///
     /// - 0: The request is owned by C block layer.
-    /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
-    /// - 2+: There are `ARef` references to the request.
+    /// - 1: The request is owned by Rust abstractions but there are no [`ARef`] references to it.
+    /// - 2+: There are [`ARef`] references to the request.
     refcount: AtomicU64,
 }
 
@@ -204,7 +213,7 @@ fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64
 }
 
 /// Store the result of `op(target.load)` in `target` if `target.load() !=
-/// pred`, returning true if the target was updated.
+/// pred`, returning [`true`] if the target was updated.
 fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
     target
         .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
-- 
2.43.0




