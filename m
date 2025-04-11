Return-Path: <stable+bounces-132224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D8A85A1C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 12:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD784A54D1
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56D204581;
	Fri, 11 Apr 2025 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2CEKUpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531A17D2;
	Fri, 11 Apr 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367718; cv=none; b=E2xmDdNHrsrWYdrelgtugji0OGzj0sv6uWzJVw+IahMVMrxZLx/K2sAp/05uwm55EfGfM9L8prDBL1nhFRXhByQP7eGRq+OH+vCCcXI/rAtwn3iE7+fU+QSZ0quUl2boHcoY41/zH2Wmb/QDjnSj/H8vnC/RkWisCuJoUeWDWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367718; c=relaxed/simple;
	bh=ZzgqBVvUJRx01Xdr3ZUB0nMTq1IDHwQSF+NS92g+sto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKLtWNF7CQ2dCgUV35j5Nb3EN3BISHVCBWzDv/XqdWf6kRCjxpQITK0WHUKMQsIAgPwUsdr/QMP9u6LBQ9iIUha4WD5Ev8eFRTV1wguxlV7gvNBi/sPUIWd3VAke841D49Vn+8lpfGIdeRNbv4u1Ls0ixZ45NFllx35GkWArg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2CEKUpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3ECC4CEE2;
	Fri, 11 Apr 2025 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367716;
	bh=ZzgqBVvUJRx01Xdr3ZUB0nMTq1IDHwQSF+NS92g+sto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2CEKUpfHqqDerKDhIYJp2apcdLnhC17OX9lzAT0gqybRu8mnxS4/2j400RoTWHqZ
	 MW4opsgFLHwG5t8qbVvdDm2HI4ODPreciwiieWudZ28LdRCnamyB/B1o7JVQrdnplJ
	 NTe2vWrHcZrqccNFgG7yE+C9M2kYstoD5Ag8ivFLCjdTGiB9LT/XH9KiX2gvFLR8JB
	 vT7293e8orUWPGoB+8ZowaN/RmIf4wIfifcou+2Dgq5n8AdPiMQ98SjFQSqborUQQC
	 n+T9o5k9u3Xtd5OhebnmyFYfaaX01pZKaSrR7OU3PH8xuo1S9Ug4yLlHPpP+/csAec
	 xu1O2TmaAooHg==
Date: Fri, 11 Apr 2025 12:35:10 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
Message-ID: <Z_jwXsQae9DjLWha@pollux>
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>

On Fri, Apr 11, 2025 at 09:14:48AM +0200, Christian Schrefl wrote:
> When trying to build the rust firmware abstractions on 32 bit arm the
> following build error occures:
> 
> ```
> error[E0308]: mismatched types
>   --> rust/kernel/firmware.rs:20:14
>    |
> 20 |         Self(bindings::request_firmware)
>    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
>    |         |
>    |         arguments to this function are incorrect
>    |
>    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
>                  found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {request_firmware}`

This looks like you have local changes in your tree, running in this error. I
get the exact same errors when I apply the following diff:

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index f04b058b09b2..a67047e3aa6b 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -12,7 +12,7 @@
 /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
 /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
 struct FwFunc(
-    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
+    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
 );

> note: tuple struct defined here
>   --> rust/kernel/firmware.rs:14:8
>    |
> 14 | struct FwFunc(
>    |        ^^^^^^
> 
> error[E0308]: mismatched types
>   --> rust/kernel/firmware.rs:24:14
>    |
> 24 |         Self(bindings::firmware_request_nowarn)
>    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
>    |         |
>    |         arguments to this function are incorrect
>    |
>    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
>                  found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {firmware_request_nowarn}`
> note: tuple struct defined here
>   --> rust/kernel/firmware.rs:14:8
>    |
> 14 | struct FwFunc(
>    |        ^^^^^^
> 
> error[E0308]: mismatched types
>   --> rust/kernel/firmware.rs:64:45
>    |
> 64 |         let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
>    |                            ------           ^^^^^^^^^^^^^^^^^^ expected `*const i8`, found `*const u8`
>    |                            |
>    |                            arguments to this function are incorrect
>    |
>    = note: expected raw pointer `*const i8`
>               found raw pointer `*const u8`
> 
> error: aborting due to 3 previous errors
> ```

I did a test build with multi_v7_defconfig and I can't reproduce this issue.

I think the kernel does always use -funsigned-char, as also documented in commit
1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")?

> 
> To fix this error the char pointer type in `FwFunc` is converted to
> `ffi::c_char`.
> 
> Fixes: de6582833db0 ("rust: add firmware abstractions")
> Cc: stable@vger.kernel.org # Backport only to 6.15 needed
> 
> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> ---
>  rust/kernel/firmware.rs | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272670e5e29b0ff924 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -5,14 +5,18 @@
>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
>  
>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> -use core::ptr::NonNull;
> +use core::{ffi, ptr::NonNull};

The change itself seems to be fine anyways, but I think we should use crate::ffi
instead.

