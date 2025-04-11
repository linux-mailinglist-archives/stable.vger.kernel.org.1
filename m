Return-Path: <stable+bounces-132252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1DA85F9E
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7037E44237A
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22E1E5B94;
	Fri, 11 Apr 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMBmv6AV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3321D86FB;
	Fri, 11 Apr 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379255; cv=none; b=LCCcSme3YEKEHZEEuOell03NWePotRCGwbF1paNqqaTru3DoeMxB6srHQmHXDWr3s3YJGWdq7cuqXKECINn/T02hyLHTtzm3K00BwPuTszQj6SgWlkXugkVJXwIjAJbc7vy2jdSrqo5+NkILQoGtBW+JJezLg+aRs1XvnoySevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379255; c=relaxed/simple;
	bh=PogR4W7dnXucGICz/AQVDV9oEY2yJBO7er+MO0ZqtZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7lUtwzkZuNGYqAEgdGTCaMzvp8sZQOzH++jTXBXG1Fe1uMemrIOlFiTZ+DANO6vr069j9TMqXg9efRBXoKhwwqOvoHn7y1vOlRPE9eGqSJV5NJR3DY0cNhpw4Frv30vZZGcRVhGGJ1gJBJkC269I2riobJtZ2HM4WqYzy10EPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMBmv6AV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac73723b2d5so398504966b.3;
        Fri, 11 Apr 2025 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744379251; x=1744984051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5n+QohqvB7s/Sb0490fMM5HBbQ3f/3RmRNA2L8Qxnk=;
        b=GMBmv6AVOiSBEgESelZmu++MVZbL5kUoCDdyyRvNQ0Dzbv/jLQwDjBXLsiCu5IECtK
         XXibYP8hA5DirBsrFWJNArwFSevmDx7u1WqkCnJEsGf7JJN7scmleNyZtzkBqxwuWDgg
         +QXhnCbEuNbUbxXxV7Qrsss0NCGdvMMKX33uHNXmeZD3Q/j6Lz5kQrEXqjFDRJ68igQQ
         i7tJDlYsn6JjKAGIgPoi+MK/on09uzfvoS52QHz8ZQIpB6QSd8DaG+RRgcnlQwaiGxhH
         Hl8ZQO2x8VzzIvDXDeUhjhDoHdIrKT+IjI8jAxL70hz97iG/Klij0/X+YCeNb9QkrB3T
         RQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744379251; x=1744984051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5n+QohqvB7s/Sb0490fMM5HBbQ3f/3RmRNA2L8Qxnk=;
        b=Os0ASRDiBRiaXDqlELQIvZorv1oceH7ZjIL+G0vm5u39PuxU3oRVgiTHVz43Kz1ZQR
         /wB+N3f3vMP0+pQwo2xeamhc6260qtWW4P8lkGy0lTOV/2OkHIxYNxLi3o4R3QjP88Fr
         EA5TeNQF9FwCQCCkbI1Y0e0s27LuafD2PwNOAdO9PZF9+yjfw1hEGMSjywTwRSb3wFuH
         9KPxah+8q9GN4PehVH0+zmK/TAnYhqMQOezrJ4rNV+TDyWvbdtd17TzYDQypz/jNdckI
         ZSH6AE2EC48yLtkZf8Tv5qwUtfUFbIniZSBLmC56mWMciRURfrd3udCTcd9eknP/P++v
         iDug==
X-Forwarded-Encrypted: i=1; AJvYcCUvBwxvt6GSJtTBEptaIvFGyuzyWdFpcEK1wdsFmQrSuvtxuGYnbJpjoM+kBs2t+bveZciQCpnW@vger.kernel.org, AJvYcCWveBehoOAivrkAJnF2FvWKk6uoDO6ziKVYyaKSHns3FNi6n3CjjkPqBdxKq0aaZMl/ArAk3/Vea1XUBZU=@vger.kernel.org, AJvYcCX6+ECqfcW5sQX3ZafsCLR54o25qCHN3xUfQD9pwAc6yvykyxHAG1p9dkqR9yS6SpIRvcV7QTVcRhy2MDq/ApY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxmNYYjiHSgFAWIrP5RbWNF9bR+Dpss5Bx8UnhnRP0N8lceWl
	Fx/EHocTrLLOFec5/MNqOOlagtpJBRC/hTIaJjC0Xcg7DarVHs5a
X-Gm-Gg: ASbGnct8tqzxBR1+dFROPtf9Z6zl6k/e2CDAYmf38GpMy4tv0Nl+EGLT87XtojyCmXZ
	vgr4spDJRkS09h9Y1KvYnXt5YL7Zv++DxVrdPIWvEsZMVKXgiODmJoOF9/tRIFNdMRMt/olaqLp
	P/iMncKaXrmwv4kRcOAQN6eOFi/UW4lPS8crn5SfUGJ/fPQOF+HZ3KVWC7YtD0gN2okh44CeWoT
	bgLk4IGUSyDTyEHyN6zZbZuusjR/Kk1XyvA0b2FiGDBiNsUqtYV60M4BfKdI7ZnUveWA/HlRRSV
	H452fOYuhfOzYNZtBCEYUZdknNW1MnOKNvj9mrmmoOYieMSTOPF/Cks+8hhz99xA348Q8QWxwK1
	tD/d7UDwoTioJDh2KF1I=
X-Google-Smtp-Source: AGHT+IHxm8659RzD3xWh3EuM0iDPlgOx6OC9RUxPjuJSZXQ8ecMHseGUJ7xwZNzC+27SLQe8FZ4ZQA==
X-Received: by 2002:a17:907:c22:b0:ac7:e5c4:1187 with SMTP id a640c23a62f3a-acad343c76fmr227896466b.11.1744379251125;
        Fri, 11 Apr 2025 06:47:31 -0700 (PDT)
Received: from ?IPV6:2001:4bc9:801:666a:43aa:5aff:fcd4:ae38? ([2001:4bc9:801:666a:43aa:5aff:fcd4:ae38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be87e1sm451142866b.53.2025.04.11.06.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 06:47:30 -0700 (PDT)
Message-ID: <99070274-4891-411a-89e1-420ca4d5d0fb@gmail.com>
Date: Fri, 11 Apr 2025 15:47:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
To: Danilo Krummrich <dakr@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
 <Z_jwXsQae9DjLWha@pollux>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <Z_jwXsQae9DjLWha@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.04.25 12:35 PM, Danilo Krummrich wrote:
> On Fri, Apr 11, 2025 at 09:14:48AM +0200, Christian Schrefl wrote:
>> When trying to build the rust firmware abstractions on 32 bit arm the
>> following build error occures:
>>
>> ```
>> error[E0308]: mismatched types
>>   --> rust/kernel/firmware.rs:20:14
>>    |
>> 20 |         Self(bindings::request_firmware)
>>    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
>>    |         |
>>    |         arguments to this function are incorrect
>>    |
>>    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
>>                  found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {request_firmware}`
> 
> This looks like you have local changes in your tree, running in this error. I
> get the exact same errors when I apply the following diff:
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index f04b058b09b2..a67047e3aa6b 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -12,7 +12,7 @@
>  /// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
>  /// `bindings::firmware_request_platform`, `bindings::request_firmware_direct`.
>  struct FwFunc(
> -    unsafe extern "C" fn(*mut *const bindings::firmware, *const u8, *mut bindings::device) -> i32,
> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32,
>  );
> 
>> note: tuple struct defined here
>>   --> rust/kernel/firmware.rs:14:8
>>    |
>> 14 | struct FwFunc(
>>    |        ^^^^^^
>>
>> error[E0308]: mismatched types
>>   --> rust/kernel/firmware.rs:24:14
>>    |
>> 24 |         Self(bindings::firmware_request_nowarn)
>>    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found fn item
>>    |         |
>>    |         arguments to this function are incorrect
>>    |
>>    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
>>                  found fn item `unsafe extern "C" fn(_, *const u8, _) -> _ {firmware_request_nowarn}`
>> note: tuple struct defined here
>>   --> rust/kernel/firmware.rs:14:8
>>    |
>> 14 | struct FwFunc(
>>    |        ^^^^^^
>>
>> error[E0308]: mismatched types
>>   --> rust/kernel/firmware.rs:64:45
>>    |
>> 64 |         let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
>>    |                            ------           ^^^^^^^^^^^^^^^^^^ expected `*const i8`, found `*const u8`
>>    |                            |
>>    |                            arguments to this function are incorrect
>>    |
>>    = note: expected raw pointer `*const i8`
>>               found raw pointer `*const u8`
>>
>> error: aborting due to 3 previous errors
>> ```
> 
> I did a test build with multi_v7_defconfig and I can't reproduce this issue.
> 
Interesting, I've it seems this is only an issue on 6.13 with my arm patches applied.

It seems that it works on v6.14 and v6.15-rc1 but the error occurs on ffd294d346d1 (tag: v6.13)
with my 32-bit arm patches applied.

> I think the kernel does always use -funsigned-char, as also documented in commit
> 1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")?
> 
>>
>> To fix this error the char pointer type in `FwFunc` is converted to
>> `ffi::c_char`.
>>
>> Fixes: de6582833db0 ("rust: add firmware abstractions")
>> Cc: stable@vger.kernel.org # Backport only to 6.15 needed
>>
>> Signed-off-by: Christian Schrefl <chrisi.schrefl@gmail.com>
>> ---
>>  rust/kernel/firmware.rs | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
>> index f04b058b09b2d2397e26344d0e055b3aa5061432..1d6284316f2a4652ef3f76272670e5e29b0ff924 100644
>> --- a/rust/kernel/firmware.rs
>> +++ b/rust/kernel/firmware.rs
>> @@ -5,14 +5,18 @@
>>  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
>>  
>>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>> -use core::ptr::NonNull;
>> +use core::{ffi, ptr::NonNull};
> 
> The change itself seems to be fine anyways, but I think we should use crate::ffi
> instead.
Right, I just did what RA recommended without thinking about it much.

I guess this patch isn't really needed. Should I still send a V2 using `crate::ffi`?

Cheers,
Christian


