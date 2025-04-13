Return-Path: <stable+bounces-132359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDECA87387
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 21:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8215E3B6B33
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929C1EA7CA;
	Sun, 13 Apr 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMY6pZ3q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5651993BD;
	Sun, 13 Apr 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744572428; cv=none; b=iDPZzLTk7Qd2bPkhTWd06GXL9qm/rFvMgcR3KrD5vPKD9FhthA5+5AJD0ISxHRskAEs5pxv4Pbris4K7MjZEmh9TU0Psy3Q8ckl20EoSoDjp5OPBuR+7zihLU3oiSFiBb8t8des4/9eImq1UTe5tfjpQS9l3JQ9Bom7gp70Itns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744572428; c=relaxed/simple;
	bh=QkCkuKFT6wZHH592ZB2ggniEln82VIfqvoPJBbkXvsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K3xT5nv07I697AWsC0gDIQk8syDHtbXKb1lxJFJmlGAFe7scHeVy7EJizpEavNb2Dlji9fnI+2vc6UGjyEGl8y9iHBIM51X5xNm5ypNCq7UbGBYUBSwpL3wKzgh57fQ3ai1OHo86qyjZKvgPkzIiIdeAkZqIaRDnHQWwrvY7HWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMY6pZ3q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2963dc379so594796566b.2;
        Sun, 13 Apr 2025 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744572425; x=1745177225; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjpcKZWpASgE46JrEqXPnEh3oUn+ZfJ5tsNx6ErOfYw=;
        b=CMY6pZ3qBav+IMhS/xVeU6IieEcQNBq5IeTbZPBTKdxe2tNAhJigmAUYETOVGtXkyp
         xQBn8GPWXLqI/xlFTUEObP4IQyC6BWtSwrDKhnNx25LPgGX1FFA5y8ftJLlHZXLD/Drn
         yUl6Ylb1998GvS7J/OzCkopYixfYYULM3JAnn8xzJaap8wQ8Aq6IKDrYsXZatBCjjRTN
         lGrlLrWOoeWz2xlwG2vxLSm6whzPuw86DXfwKuM/rBvIUeMwsja/mJD6EHh+fV0h5DAX
         NNcxMdNlQBhmhsWHUo9olZvxSs/KP0B4zcskmLty7JJ968o1R9sfFBCSglA5+KtrXQPr
         pq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744572425; x=1745177225;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjpcKZWpASgE46JrEqXPnEh3oUn+ZfJ5tsNx6ErOfYw=;
        b=mIOxbUmTs5gTgGkV86p7XRMSS2qr5XjdkUm0kPq9out8Q+6SFdz3b1eVgtoaI2NMPF
         5nq8jFg+bufLqmyrTOCozF7xl0M1DfVl9CY7NL7yjlxlLM6313pXlEdN4QwTCPpUyCPn
         feSsXWdWl+VFu9uN2ENkH0SfvJkBKI3xzcmZA+Uij3NDAyr4a8sB+qVvEt7lB7Bp+p+y
         99JQrJ35WT+4vMn3C4XXNxZGqmj9FkYt/xnDqHQ3M1H9oH/Lw0vcQ/KVgSQSyL3jcyAd
         +5k5axVy0WR15oAGk1SFmvzbiPxsdIijEiQk8+9G87DeZDGb4V/NVRn0c09R/253c0oB
         1qwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9XKiKcEp+KNs4O7yku+YTeN7CCC7NWGETIg8PVmf0Erw+V832Tdpui89Ji43xbmR7HlgJrmhUaVPCGax4w==@vger.kernel.org, AJvYcCW2rRE1XDjNZuy4KF75BeZ7aGsQuhAg/FsCBaT4KecMz69C/O+HE0BeIAohR0Tt0jQ7pKIHPw1S@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/p8H2yY4YzCD8U+wW8XeWSDCSjBtnwZU2o254eat9LTuw+Ch
	SRyvL62OZckQEsKZQDJJaU+UDwVvHj0ZA6+3fuXb6KvEIEodA2kE
X-Gm-Gg: ASbGncuP8aNuC8R8r5CvdbChHB0d2qPE8kg8KwJ0hgLfCNIwqdK32VrB+8NLZV7RCdy
	/Kxm+E8dnBbc3HBFMq/ufmrrbNolu8WKlnclj2YyMwQ4zKmrIICDsD2cQRZHqDfK6Y4xsZQaVsq
	Bgd3+7oyaSbeWavL7eJh/zG+214Sxrqo7ieQbgJBB11sc8P6N4mONFvmXDOhErNmgbEmo8XlYyX
	sYF+7+C1xYX5Rr4F/tr4Cn6eAZtS1S7q+gNRym4ocgSsp6dDJtBeeO6HEb4XPW1wmqqbeXUA40j
	QP3Jr9q9LJppppQRXP488uBQ0eiFzArt9F/tM6o=
X-Google-Smtp-Source: AGHT+IF7TqwmNFBxoP1uwqhPRKHQxWwZot1FSfd89dNpEdwbpMrqjQX9ievtOkmZkx8tbScP44J/ug==
X-Received: by 2002:a17:907:9624:b0:ac2:9841:3085 with SMTP id a640c23a62f3a-acad34ca0e5mr824898566b.30.1744572424459;
        Sun, 13 Apr 2025 12:27:04 -0700 (PDT)
Received: from [10.0.1.56] ([2001:871:22a:99c5::1ad1])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acad99c4456sm394686366b.110.2025.04.13.12.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 12:27:04 -0700 (PDT)
From: Christian Schrefl <chrisi.schrefl@gmail.com>
Date: Sun, 13 Apr 2025 21:26:56 +0200
Subject: [PATCH v3] rust: Use `ffi::c_char` type in firmware abstraction
 `FwFunc`
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP8P/GcC/33N0Q6CIBSA4VdpXEcDFIWueo/WHMFB2VIbENWc7
 x66Lrzy8j875zsTCuAdBHQ+TMhDcsGNQ47ieEC6U0ML2JnciBHGSUkE9q8QG+X7xrpPY9+Nuoe
 odMxnuNSFEtLUHJhEGXh6yEsrfr3l7lyIo/+uvxJdpn+W0j02UUwxURK4FCWnurq0vXKPkx57t
 LCJbSm2S7FMCaissUQWpqZbap7nH7+FC7APAQAA
X-Change-ID: 20250408-rust_arm_fix_fw_abstaction-4c3a89d75e29
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 stable@vger.kernel.org, Christian Schrefl <chrisi.schrefl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744572423; l=4718;
 i=chrisi.schrefl@gmail.com; s=20250119; h=from:subject:message-id;
 bh=QkCkuKFT6wZHH592ZB2ggniEln82VIfqvoPJBbkXvsw=;
 b=cGG6PnEoXUDm7qAkWhgmOrbJjFUCLr2mDR20W8glZz5+PtFQdnyH28x9uga5aDx2tyY0oVptq
 Z94QMjRkZ7xAswoVD+JOOWzD1U174qEciLBzYCRroOL6fFfMbpTH9sA
X-Developer-Key: i=chrisi.schrefl@gmail.com; a=ed25519;
 pk=EIyitYCrzxWlybrqoGqiL2jyvO7Vp9X40n0dQ6HE4oU=

The `FwFunc` struct contains an function with a char pointer argument,
for which a `*const u8` pointer was used. This is not really the
"proper" type for this, so use a `*const kernel::ffi::c_char` pointer
instead.

This has no real functionality changes, since now `kernel::ffi::c_char`
(which bindgen uses for `char`) is now a type alias to `u8` anyways,
but before commit 1bae8729e50a ("rust: map `long` to `isize` and `char`
to `u8`") the concrete type of `kernel::ffi::c_char` depended on the
architecture (However all supported architectures at the time mapped to
`i8`).

This caused problems on the v6.13 tag when building for 32 bit arm (with
my patches), since back then `*const i8` was used in the function
argument and the function that bindgen generated used
`*const core::ffi::c_char` which Rust mapped to `*const u8` on 32 bit
arm. The stable v6.13.y branch does not have this issue since commit
1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`") was
backported.

This caused the following build error:
```
error[E0308]: mismatched types
  --> rust/kernel/firmware.rs:20:4
   |
20 |         Self(bindings::request_firmware)
   |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
   |         |
   |         arguments to this function are incorrect
   |
   = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
                 found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {request_firmware}`
note: tuple struct defined here
  --> rust/kernel/firmware.rs:14:8
   |
14 | struct FwFunc(
   |        ^^^^^^

error[E0308]: mismatched types
  --> rust/kernel/firmware.rs:24:14
   |
24 |         Self(bindings::firmware_request_nowarn)
   |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
   |         |
   |         arguments to this function are incorrect
   |
   = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
                 found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {firmware_request_nowarn}`
note: tuple struct defined here
  --> rust/kernel/firmware.rs:14:8
   |
14 | struct FwFunc(
   |        ^^^^^^

error[E0308]: mismatched types
  --> rust/kernel/firmware.rs:64:45
   |
64 |         let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
   |                            ------           ^^^^^^^^^^^^^^^^^^ expected `*const i8`, found `*const u8`
   |                            |
   |                            arguments to this function are incorrect
   |
   = note: expected raw pointer `*const i8`
              found raw pointer `*const u8`

error: aborting due to 3 previous errors
```

Fixes: de6582833db0 ("rust: add firmware abstractions")
Cc: stable@vger.kernel.org
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
---
Changes in v3:
- Clarify build issues with v6.13 in commit message.
- Link to v2: https://lore.kernel.org/r/20250412-rust_arm_fix_fw_abstaction-v2-1-8e6fdf093d71@gmail.com

Changes in v2:
- Use `kernel::ffi::c_char` instead of `core::ffi::c_char`. (Danilo & Benno)
- Reword the commit message.
- Link to v1: https://lore.kernel.org/r/20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com
---
 rust/kernel/firmware.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index f04b058b09b2d2397e26344d0e055b3aa5061432..2494c96e105f3a28af74548d63a44464ba50eae3 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
-use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
+use crate::{bindings, device::Device, error::Error, error::Result, ffi, str::CStr};
 use core::ptr::NonNull;
 
 /// # Invariants
@@ -12,7 +12,11 @@
 /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
 /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
 struct FwFunc(
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
+    unsafe extern "C" fn(
+        *mut *const bindings::firmware,
+        *const ffi::c_char,
+        *mut bindings::device,
+    ) -> i32,
 );
 
 impl FwFunc {

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250408-rust_arm_fix_fw_abstaction-4c3a89d75e29

Best regards,
-- 
Christian Schrefl <chrisi.schrefl@gmail.com>


