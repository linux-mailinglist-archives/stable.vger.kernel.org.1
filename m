Return-Path: <stable+bounces-132206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F7A85540
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50CB3A089E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3672853EB;
	Fri, 11 Apr 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8vPazfe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C962853F4;
	Fri, 11 Apr 2025 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355696; cv=none; b=JYNigUq+LTwTso43z8F65nr95uLn+psXTDP8mLIXg3kxEMYsetMtjsHSxdoAAubCmMEJRCjR3ExD3M0RUrOnZo0HuIfOeYpTKDTb1SPhVNvvOpKw4HifnoGVQV1zLY5i8cJEKhurdwVDyl8HD6HNdTb1RcdncBDShHODjlGxFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355696; c=relaxed/simple;
	bh=tpS0UlAr4w1LsBHuXYb1fiiOH8hIvS0JrS2AM6UhpwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HI963IQ7HIqSl9m+0UMX0sLo13dIqXwpPBY3mLaJ/ErR2wDTUyK4Wda/enam2eQjQKhUyAnEMIrN/MSjUFoJOQ8+HjrV/TxBEi6TmVbqc2lBA7Mf7OVe6okWZVDYUT6y+NlEAHL40JYW6A/+FIXR2plsZB37HKgQ5x1OSG5R1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8vPazfe; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acacb8743a7so141050266b.1;
        Fri, 11 Apr 2025 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744355693; x=1744960493; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hq5nxbhmh17ZZ8eYIzyyvh2Q6aoKe7PhPVOM2wk4Eo=;
        b=U8vPazfeoMV+wEsU+oL66wKqFPtP/u1D8q/EUxC7/SK8e3Vz2u+pUGnf1P83ReaKC8
         hrG/JP/lTC94n9/w45Uv5eNs2f6Jx04nWGO0/bev6en267NVmmEfaulY3vuOIseUl5pj
         mY4YGB57V3Pad3NeaTJ89poXwBhaJb117/bfI70bFrra6Kk8ijd8kTt8DePfIEfgZaDI
         Ps3r5m/huYnuJVm/YYLVHND28HIU1Utk9mxY+BE1xlRgCJP6PkcKjcaT4wGQtmZs4AKT
         9jnZAp0eiVRFuyGzq/hxxV30ZUwYKa7aFGRFDZm23QjMHASYqKzggfDSElG5tRCPuJLD
         RRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744355693; x=1744960493;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Hq5nxbhmh17ZZ8eYIzyyvh2Q6aoKe7PhPVOM2wk4Eo=;
        b=EyIvDDIBxnepHPqNE2gOFmtc0cTeX7eBYupJKr0xzHYHLbknFgTUeVWSn6/k6Y3ySw
         4HG6qePffWH7bpOsqafgk51CkkJfyHNvJRcib21NHWpsPJkrm72HhvmV/gT/lYfMgSca
         8vJu/uwoH6fQLStjZTPo8Iwpt3KwZguedPKB3zSoEePOvgSurZFLMDaxuX909G50oJgw
         iJuEr5oYxjsFc7N56PTTMmBXMIhzkSaxh6MbXjGpSN9/j2bU0gzME+t7Gdjz+t76RK1y
         zvtAj+7K8v4KAte5pKTLHAmKbY9vC6x7r3uct07wTNPr6hZcaENCAkWscSt1+u552eKd
         uY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVevoPHvjozPcGHolAQbyiIvJ1gNanTfERXGVc5xzXjbXEvN+vsO+Z7w8y+hUIi8qyB4fFLxUo1@vger.kernel.org, AJvYcCXyOvsG2LzU3GTMnYQ+7/Tt7m5sNsKb1qqONZ1HkdPVSP7KN+6V0eMdIXfsADfMxdoNku/kTSiD7HkdA9GE8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZAKr2C/PyTPqxmhC0k3uGTBm2O3bopA3zFGV2Z8sBPeZil7R
	3JRVRM3m5u8ztp9Cr35NtXPVfQ5QalAPLfUdgjej5+EzObzXpk7d
X-Gm-Gg: ASbGncvE3Md8UV7rbSflXZ+KrkHGdFmc2pcRiVEHI0/X8CHv/Z8HvRoeB320NnRPGBr
	1LaRJwnAHi90PAfd0KG+vIisqIYfSm3JCsCsfKQwMbuKtNjt78P6tNSfrWjzLgq62+njncwepX4
	7S6cyIIqy5XHJEei8HHoCoBcW1vq6NGv+oFgBVvi9/o9MYpWVFG7alJsB2CgxS+4e+XdHOxNw15
	LmL11Y0paPc+TvF5gqFv9inlaocpStW71D1Ec0uRWHwdfPAYTdaZEk+3jZ0sF4DXQ/uBQTlbBTW
	IEDDRmMrG90RCJqgyP2yPGQ9oxRJR1nEndwvVk7tBCE89nWzqtT2
X-Google-Smtp-Source: AGHT+IE8mGpY5sxmCCDsK+kIl318ye2lnYZ63ltBewZtDKuUvd1gjqFGWJqESIxbKkKzXidqQZX5Nw==
X-Received: by 2002:a17:907:6e9e:b0:ac7:b494:8c0c with SMTP id a640c23a62f3a-acabc24974cmr381517466b.16.1744355692427;
        Fri, 11 Apr 2025 00:14:52 -0700 (PDT)
Received: from [10.27.99.142] ([193.170.124.198])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acaa1999d96sm395178666b.0.2025.04.11.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 00:14:52 -0700 (PDT)
From: Christian Schrefl <chrisi.schrefl@gmail.com>
Date: Fri, 11 Apr 2025 09:14:48 +0200
Subject: [PATCH] rust: fix building firmware abstraction on 32bit arm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGfB+GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3aLS4pL4xKLc+LTMivi08vjEpOKSxOQSoDZdk2TjRAvLFHPTVCN
 LJaABBUWpQEVgw6Nja2sBwYNPFGwAAAA=
X-Change-ID: 20250408-rust_arm_fix_fw_abstaction-4c3a89d75e29
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 stable@vger.kernel.org, Christian Schrefl <chrisi.schrefl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744355691; l=3313;
 i=chrisi.schrefl@gmail.com; s=20250119; h=from:subject:message-id;
 bh=tpS0UlAr4w1LsBHuXYb1fiiOH8hIvS0JrS2AM6UhpwM=;
 b=2D05eOYdLxxiSrURCt3/1oKKRXE4zYpAX/wJcncEymVElybR/gatP9W5q9/2IbwuIY6tk/sJU
 1Kej50cBWz4AiLE/Q9lDrIF2hcuRWeVpmzqWkfj5zOLq7gT3bG5knPn
X-Developer-Key: i=chrisi.schrefl@gmail.com; a=ed25519;
 pk=EIyitYCrzxWlybrqoGqiL2jyvO7Vp9X40n0dQ6HE4oU=

When trying to build the rust firmware abstractions on 32 bit arm the
following build error occures:

```
error[E0308]: mismatched types
  --> rust/kernel/firmware.rs:20:14
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

To fix this error the char pointer type in `FwFunc` is converted to
`ffi::c_char`.

Fixes: de6582833db0 ("rust: add firmware abstractions")
Cc: stable@vger.kernel.org # Backport only to 6.15 needed

Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
---
 rust/kernel/firmware.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272670e5e29b0ff924 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -5,14 +5,18 @@
 //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
 
 use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
-use core::ptr::NonNull;
+use core::{ffi, ptr::NonNull};
 
 /// # Invariants
 ///
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


