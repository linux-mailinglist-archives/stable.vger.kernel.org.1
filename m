Return-Path: <stable+bounces-118651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8CA40832
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385C719C30DA
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA620ADCF;
	Sat, 22 Feb 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FxPsKjHD"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E5207A3F;
	Sat, 22 Feb 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226185; cv=none; b=ndOiOxLNxC9YNB9HSpK2+vbOdROW5dnzZ2Arc1VGpkKAsog/Wh3GG91+9cK/IdcB/H4xAmTd6iAcTBBMJmcXy9vCAWeqmM73vX8eXcPoE3nAKD2sAwb/CgR12swhKx/AWg+YObhozs135+yPgPbtcl7ImSJOPA3DUYJGcq62b5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226185; c=relaxed/simple;
	bh=hNzbpZUaacYbwAfzJgcJiA0cKgHDn8Zk5gmPryinfII=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VB49taLvb+0V58Fu3cTwJg6w212NgR0pUQBsNR+Tw3SoQKgoXSAMDvNzUP0TwAfKMRvI816zM7XrQ1Vp/R6g9MbrepPoka769YzGDseFKaJmeCdta5fxocykvBYcMb5v5ZKy9JJxcemDlXWTjYzvy+PXCP0kSCRoc+cgLAeA/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FxPsKjHD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 67FBE25EAA;
	Sat, 22 Feb 2025 13:09:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mClZSRCY7MoH; Sat, 22 Feb 2025 13:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740226171; bh=hNzbpZUaacYbwAfzJgcJiA0cKgHDn8Zk5gmPryinfII=;
	h=Date:From:Subject:To:Cc;
	b=FxPsKjHDrwF3QYzKWci48q8djTQNoAldfP6SdhzR37oHoH6bNeW7axNi8xj9GJC/Y
	 Ir2cYyLN8kZmXsVmlrGu8LhjAX6Zm3qX6/UDL/QC4cGYDmHmMjhaJ3WCdZOSuK6HIG
	 amcvCZuTWuYaJQqNAsg95OHboX9/zop6RWimyvDKkrZXOIR4Lp4NDhJunnDZWfWsMb
	 Q5GuULuYmARTLeabp36qUhsxL8rgrt52yLM+pjhMDHJq8/O/6bdfJgQgRG/TQGPEZt
	 +Idsv3BznNSKVq5wy7kGtsiT2aE3j9bXH5zwYAQiU/mO1khx+SMZNp5ubthwLcaDXQ
	 sBqXheDcoigKg==
Message-ID: <ef950304-0e98-4c91-8fa1-d236cbb782b8@disroot.org>
Date: Sat, 22 Feb 2025 13:09:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: NoisyCoil <noisycoil@disroot.org>
Subject: FTBFS: Rust firmware abstractions in current stable (6.13.4) on arm64
 with rustc 1.85.0
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

The Rust firmware abstractions FTBFS on arm64 and current stable 
(6.13.4) when compiled with rustc 1.85.0:


```
   RUSTC L rust/kernel.o
error[E0308]: mismatched types
   --> rust/kernel/firmware.rs:20:14
    |
20 |         Self(bindings::request_firmware)
    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn pointer, found 
fn item
    |         |
    |         arguments to this function are incorrect
    |
    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
                  found fn item `unsafe extern "C" fn(_, *const u8, _) 
-> _ {request_firmware}`
note: tuple struct defined here
   --> rust/kernel/firmware.rs:14:8
    |
14 | struct FwFunc(
    |        ^^^^^^

error[E0308]: mismatched types
   --> rust/kernel/firmware.rs:24:14
    |
24 |         Self(bindings::firmware_request_nowarn)
    |         ---- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ expected fn 
pointer, found fn item
    |         |
    |         arguments to this function are incorrect
    |
    = note: expected fn pointer `unsafe extern "C" fn(_, *const i8, _) -> _`
                  found fn item `unsafe extern "C" fn(_, *const u8, _) 
-> _ {firmware_request_nowarn}`
note: tuple struct defined here
   --> rust/kernel/firmware.rs:14:8
    |
14 | struct FwFunc(
    |        ^^^^^^

error[E0308]: mismatched types
   --> rust/kernel/firmware.rs:64:45
    |
64 |         let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), 
dev.as_raw()) };
    |                            ------           ^^^^^^^^^^^^^^^^^^ 
expected `*const i8`, found `*const u8`
    |                            |
    |                            arguments to this function are incorrect
    |
    = note: expected raw pointer `*const i8`
               found raw pointer `*const u8`

error: aborting due to 3 previous errors

For more information about this error, try `rustc --explain E0308`.
```


This is because rustc 1.85 (now stable) switched core::ffi::c_char from 
i8 to u8 on arm64 and other platforms [1], and because current stable 
still uses rustc's core's instead of the custom ffi integer types like 
6.14 will. Looking for other i8's in *.rs files tells me only the QR 
code panic screen should be affected in addition to the firmware 
abstractions, and that was already reported in [2].

A simple fix would be to switch i8 to u8 in `struct FwFunc`, but that 
breaks rustc <= 1.84 so I guess a more robust solution is needed.

Cheers!


[1] https://github.com/rust-lang/rust/pull/132975
[2] 
https://lore.kernel.org/all/20250120124531.2581448-1-linkmauve@linkmauve.fr/

