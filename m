Return-Path: <stable+bounces-194589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB33C5186C
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 049364FEB5B
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43C304BDF;
	Wed, 12 Nov 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVpr7Ih1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732530103B
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940952; cv=none; b=hBkD04OQ2WyAW6UI7Wd5muLwHl1uNJIFJaMXq0cdoKuWJx7aGQmqjoNOnKt6qZ+PQ8nr4VMl3dpzppUqo3Fz/shYl1JOFqWyVNVAP9vA+e7RTDl8s6j7ePhliW2T3aycWWmzzwBf5g4lM9shOdqAhC8e3E/jCCOmNhDw55Vevx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940952; c=relaxed/simple;
	bh=JnroIx5Mod0LvWzfxsHi8lC2HMAygcMfxnURZ1dW9Z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ORtXeI02OEL0a8fHEvUiJKFHfK+0/uDrtOsGS+Dj7SFwDXm35DxYvFVgzA9eQH51GdR05EN+aNwHssK1lU4HML2JTlzb5yJBLwt0yaMKLxSKxR/iv2oRBmbqgvO2bukc2OfFxfXMC4oxIHvWgzVkoDz31EUKHlcaFWEcVvOSYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVpr7Ih1; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6417b2fae83so593519a12.1
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 01:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762940946; x=1763545746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgfDsUZ638nSlM9QsO/BjlaImnMhRtBDf+7UnlFjNC8=;
        b=vVpr7Ih1G7xxs1FHFMg7hvv0X/u7djAzPcXsNyEeLACQW3st1YpMcLSfjEp1l1OonA
         HTS3ScdqNMZ6+jzHEP8lMpcp3bRBP6xsgLMhGDAIcax5p8nXL9+jKXTyqWnFc96aHB2K
         A5QE0HrNWTulQkcCXWO0xcUaAes3DqKtOS6aTwkeUrDRg75fBPahC3YzBSG0GmgFK1eJ
         uz1i7YOMf4tORRZFbXr2DiZeCRoZdITml6ZlvhdAgeQXS2VQQuxqICAxQyVEF7krnFWh
         O/UYZ8xsX85dHBsmQaZlIZx81C7wnz0wPuzXmgNlwE20Ru0gF5q37ZXuAAtXzjt9rbl2
         KiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940946; x=1763545746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgfDsUZ638nSlM9QsO/BjlaImnMhRtBDf+7UnlFjNC8=;
        b=sSnO+UXQcbLD8SJJJ5TQB7ose5rO9F8jSLJ/aFLfXLlqRoLaeOr17aJvaZ30ij9b3I
         NBSe357bsg2DFQLLSehGOSjOL5Z4NLZC4Tvq+bWgUXkQLLzOtsowgzD+54SR+cij3Y7/
         JS+zEZn/jz5WnStD4VPGySDno5A1fnvMCTIkd2PJ+tWYn7JfowE2XUy9ww1+nd5Eb1g5
         tUQWid5KrAJf3DNHYsXAESaEJZ2fwjf7tp/CBobo1hDYdEfupd3oKH7S1nuU6jY5SbQk
         +h4oYmwziYGSo2rj7PpWiG9ig+m7YmCCTW2+bpEQM/8StFMQxffHddsoipTdz+RytxMm
         JI+w==
X-Forwarded-Encrypted: i=1; AJvYcCWylGfua7kC87MajzkGqA4cfbbxQ0LfX4Q0s3d2Uafog7zzS+zLD63bDA6nDQNV4Ppn8BKQY+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKn1QkQtVcrCC7RWy6cF1dJHLL8u/bdELACDNBGb6yp26W53vr
	hDPHw3bB0q66LDYQm987HY+CColWtjaClt7Cwib0P1tLty1cpwfqKZorN++SnSQD1m5BRyqfG4r
	7asjeYa2cyTZHLPcGcA==
X-Google-Smtp-Source: AGHT+IE+cjLYnTFZuo5v6gTqC7tY+9gCgCj3XFCBabgexAOsp/gnMC81dLElIaB5dX/oUzHAaCm70diaCOcjx8M=
X-Received: from edhs12.prod.google.com ([2002:a50:8dcc:0:b0:643:12a9:41aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518d:b0:640:af04:d71d with SMTP id 4fb4d7f45d1cf-6431a530103mr2083350a12.22.1762940945677;
 Wed, 12 Nov 2025 01:49:05 -0800 (PST)
Date: Wed, 12 Nov 2025 09:48:35 +0000
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=JnroIx5Mod0LvWzfxsHi8lC2HMAygcMfxnURZ1dW9Z0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFFgMvhta5ZE+nVzvbAWjQ6Bmf4qj5MzJLHNql
 Vvajde1Zy6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRRYDAAKCRAEWL7uWMY5
 RoltD/4gZDgFyfkmyIQ8jz86Sq14oRcj4YA9tYmTwoVN1CNa0xK19cl2/YssVaGvVJxNcrFmImO
 X80ej0I0zG+N35qE9MRyjp7qUtarjOuVT2FKZtQi9EEtO4dipnF5LukHnEm4qrU1e9Eu3ML6x/0
 mnqNVazTZYVsrshwe8rYpA5mYMCmapfaF/43rzAJarZD/cqEAlRD8Lg+JWsUsDj9KCFO4dras+e
 7C6t/f1dRVt2fs0+hYv+sjqlA6AXvL0HY0/CYmF3nD1UKg8FftxzaJGvhwFDR7thPD7G5xlYEVi
 YXOOW0Mo9FLTi4UwCz9gY+7uT8SC8ZaWLsTv8slejFqpgFp6ITYWlxAFwi0Xw2u5+Y7Or1wquv3
 j8hACH5nreHi4yUGKkzaVcYYZTEn4jMJqBS+GQGIZsxAQ1bG93z7+EVkE3iVH64PpADt3AeiOzr
 c7fVEe4qsBqRbFK0lHt847m0x/GNejvgS2PUnuKcKPlqf0guND8h120c+eQ3f0fV+8NvG57WSBH
 fjjjrIqrBEVvU8ySKVS/O3/EgtSzTBkKB80YAojHF8Y8Rdst/ZdpOfvpqRKoJ8z/szWMzUu/x+I
 RCaXvjlYMJupB0eimvFU2Q19Nkx5LKWWVxaozUnvB6gKZHgIkMAu1AbhH2cASzPLHr87k1Ceg8t BjyyHxyV1Vo33Hw==
X-Mailer: b4 0.14.2
Message-ID: <20251112-resource-phys-typedefs-v2-4-538307384f82@google.com>
Subject: [PATCH v2 4/4] rust: io: add typedef for phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The C typedef phys_addr_t is missing an analogue in Rust, meaning that
we end up using bindings::phys_addr_t or ResourceSize as a replacement
in various places throughout the kernel. Fix that by introducing a new
typedef on the Rust side. Place it next to the existing ResourceSize
typedef since they're quite related to each other.

Cc: stable@vger.kernel.org # for v6.18
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/devres.rs      | 18 +++++++++++++++---
 rust/kernel/io.rs          | 20 +++++++++++++++++---
 rust/kernel/io/resource.rs |  9 ++++++---
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a17898541d4a0f01af41f68e3ab3d6bb0aca..e01e0d36702d38e9530a2fa4be884c935c6b5d0c 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -52,8 +52,20 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
-/// # use core::ops::Deref;
+/// use kernel::{
+///     bindings,
+///     device::{
+///         Bound,
+///         Device,
+///     },
+///     devres::Devres,
+///     io::{
+///         Io,
+///         IoRaw,
+///         PhysAddr,
+///     },
+/// };
+/// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
@@ -66,7 +78,7 @@ struct Inner<T: Send> {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 6465ea94e85d689aef1f9031a4a5cc9505b9af6e..56a435eb14e3a1ce72dd58b88cbf296041f1703e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -13,6 +13,12 @@
 
 pub use resource::Resource;
 
+/// Physical address type.
+///
+/// This is a type alias to either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
+pub type PhysAddr = bindings::phys_addr_t;
+
 /// Resource Size type.
 ///
 /// This is a type alias to either `u32` or `u64` depending on the config option
@@ -68,8 +74,16 @@ pub fn maxsize(&self) -> usize {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
-/// # use core::ops::Deref;
+/// use kernel::{
+///     bindings,
+///     ffi::c_void,
+///     io::{
+///         Io,
+///         IoRaw,
+///         PhysAddr,
+///     },
+/// };
+/// use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
 /// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
@@ -82,7 +96,7 @@ pub fn maxsize(&self) -> usize {
 ///     unsafe fn new(paddr: usize) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index 7fed41fc20307fa7ce230da4b7841743631c965e..0e86ee9c98d840b44b8f8953f83d31612fdaea46 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -12,7 +12,10 @@
 use crate::str::{CStr, CString};
 use crate::types::Opaque;
 
-pub use super::ResourceSize;
+pub use super::{
+    PhysAddr,
+    ResourceSize, //
+};
 
 /// A region allocated from a parent [`Resource`].
 ///
@@ -93,7 +96,7 @@ impl Resource {
     /// the region, or a part of it, is already in use.
     pub fn request_region(
         &self,
-        start: ResourceSize,
+        start: PhysAddr,
         size: ResourceSize,
         name: CString,
         flags: Flags,
@@ -127,7 +130,7 @@ pub fn size(&self) -> ResourceSize {
     }
 
     /// Returns the start address of the resource.
-    pub fn start(&self) -> ResourceSize {
+    pub fn start(&self) -> PhysAddr {
         let inner = self.0.get();
         // SAFETY: Safe as per the invariants of `Resource`.
         unsafe { (*inner).start }

-- 
2.51.2.1041.gc1ab5b90ca-goog


