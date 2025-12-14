Return-Path: <stable+bounces-200959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB22CBB750
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5889A30081BB
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B2299AB3;
	Sun, 14 Dec 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caBgqtMT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8E2CCC0
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765697675; cv=none; b=anNnG0lsyJl/TGjs1/W2yV/yauN2gvduuTe73whX0/BTvlNIxI2dVKlnSOZ4Ylr8lvfB+uHQ03sKxScsXXmOSt9mZbtLmfSzCxcVpeD58WEOkavapm810zlpXDoaMFpHTldOMO/qoYS4U1qEy+83XK5X3GMLPhJoC23KpNz3F40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765697675; c=relaxed/simple;
	bh=FVxIlAKuTuRT11DwsMiqIbBYGhbAiF+XA+LYL1zo2gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4JJoOJ91F99r2i80W3/N9yluT0yMkd8rQFML3PQXoDnAfjrQyBrMbNCYiGYn9zLwxOShSeEdsXVwh8kap+lfoGcgq+Vnu/O5HdekxbaxT398zGqq7P4wCqHBvK4qFL6sC14CEiNjTaQdKgN1Rx1c476nShhgYBNnB26j3tMAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caBgqtMT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso2416847a12.3
        for <stable@vger.kernel.org>; Sat, 13 Dec 2025 23:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765697673; x=1766302473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRn1RbbVVYNiiCpJThw73EOp5BTjJZAt0+REstZc+hw=;
        b=caBgqtMTulwlXhh93hcKSUs0xu7K8V4YRTW8YuUX6J/kRWXqYWZPzjyql5NblDdwJs
         ra3haBTSHmjT33HYkRrC4c3H96WFvWsjPSbA+zyXzybi+R+VYSXSJn89pdsHqdAOBh5U
         GPVZQ8iSCZBWNe1JOSMSAOY7ZXIrinbOI+emjqOYjQQXZHoBNMeLkFikQpYriTo1yB+T
         5pTsYgJQGvaHlmlKv4DKqrD+JAcjLG3fL2eNdC+GVsKYpw0Nm4oUA5SkmCFw+yyRk5CK
         ATtDMEL582xSfTXi0wnK4m20E6wWNYhGUojB0sdOz20K4bA3R3AqWvAwmCZjj0cht4R5
         jQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765697673; x=1766302473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRn1RbbVVYNiiCpJThw73EOp5BTjJZAt0+REstZc+hw=;
        b=oTgIPr3MYxYx8qeFib2eGzPU1GDOq8Tye+RSAm05A88tOB7gc3uuSv49BmPq4MXPTW
         W8LrqKfdychOSOBB9vqeYNuQ1ACNgJVa1wq+2zR2Q/iSnvUUaIfIJIjJ15hakJeVgH34
         HbDIPXjrwuA95WJHoKBckEkW/rjyQdIHyEgw5s/EJJroFazAjBHLgg545Bh/tyRISXWy
         y9dZHGE64KPtndS0G7IdL0ReSNL7kluaekwLYlfgI3kU7tuhMUASfwhRBhOPijMtr3S9
         gQ1/DXvbgrm/V6z6ziX24hWytMAJakQYTNVEwnMqzR+/2WUs32+a0rIkXqCv1CRRXEIs
         gP4A==
X-Gm-Message-State: AOJu0Yzj2emG6KNOEP9u7XASFJUuL3uEJZNKsWuZIV86QBs/HXJyf6A6
	Lxz2zzxA2BiAp7d9J7M052qvNulZgm/2uq/G1L6k3+y8kGFDuguuu97b
X-Gm-Gg: AY/fxX4bajl4MQ1tQPRAIOs9+5YHq0CyOYTLy/ll2glqqqI8N2DFKLgY+FEdSrkNE/N
	IrX3caEn67/4uDMBV/ux8enQgfYYO/c79hjSOxxJH1PBINM+GIwGLdORstfsrIxy5aRQI2mOkw+
	SEt+G4aAGM2S+AlNW5k5KsM74tZfN7Fd3+AEEwnrpzvyw83V4LA1Y3FFIIQ/7jGzzccltllm6nm
	RtT+jn30NgYu1swBNRC55EQdfLabeJggm+QVjnyKUN5NacQvi5jUWdgut7U4l0r91BWEss8brrx
	sB0TAvm4nBGJ9pvC98g2D3W6PRPkdFdj29KWjiZcOOw3pZrRGpwqXMRMaPW9LIlsrAxX2N2DCgT
	3kuIAewwbQhEaEkU37lGYFclHRbTRmhHc+0/0ndpTc3YcXt4SmICqMFyzElOqUHFUZOtIyVDBK2
	vRrnVoPHj5hTHkLAArM65bFp7NPR+kinWDxBmHc4TawVv7syy6Prt7v4JhvEN+Ij1ebg==
X-Google-Smtp-Source: AGHT+IHAPA/EnNsgzP0HIlYsXfOj/q3Xg73QhloxXAO45aDmZUzS7OcDiFy9ELh/3UzA7ijVRiMldg==
X-Received: by 2002:a05:701b:2704:b0:11a:61ef:8491 with SMTP id a92af1059eb24-11f34ac1593mr4017789c88.3.1765697673068;
        Sat, 13 Dec 2025 23:34:33 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb2f4sm32890480c88.3.2025.12.13.23.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 23:34:32 -0800 (PST)
Message-ID: <66cba90e-c9b1-4356-a021-e8beeff0b88d@gmail.com>
Date: Sat, 13 Dec 2025 23:34:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
 <CANiq72kYjNrvyjVs0FOFvrzUf7QYe8i+NpBS6bMEzX8uJbwB+w@mail.gmail.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <CANiq72kYjNrvyjVs0FOFvrzUf7QYe8i+NpBS6bMEzX8uJbwB+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/13/25 22:06, Miguel Ojeda wrote:
> On Sun, Dec 14, 2025 at 12:54 AM Rudraksha Gupta <guptarud@gmail.com> wrote:
>> - The kernel boots and outputs via UART when I build the kernel with the
>> following:
>>
>> make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"
>>
>> - The kernel doesn't boot and there is no output via UART when I build
>> the kernel with the following:
>>
>> make LLVM=1 ARCH="$arm"
>>
>> The only difference being: CC="${CC:-gcc}". Is this expected?
> It depends on what that resolves to, i.e. your environment etc., i.e.
> that is resolved before Kbuild is called.

Sorry about that, I should've specified in the original email. The CC 
resolves to armv7-alpine-linux-musleabihf-gcc.

When both LLVM=1 and the CC=gcc are used, I can insmod the sample rust 
modules just fine. However, if I only use LLVM=1, my phone doesn't 
output anything over UART, and I assume that it fails to boot. 
Interestingly enough, if I just specify LLVM=1 (with no CC=gcc), and 
remove the rust related configs from the pmos.config fragment, then my 
phone boots and I can see logs over UART.


> The normal way of calling would be the latter anyway -- with the
> former you are setting a custom `CC` (either whatever you have there
> or the `gcc` default). By default, `LLVM=1` means `CC=clang`.
>
> So it could be that you are using a completely different compiler
> (even Clang vs. GCC, or different versions, and so on). Hard to say.
> And depending on that, you may end up with a very different kernel
> image. Even substantial Kconfig options may get changed etc.
>
> I would suggest comparing the kernel configuration of those two ways
> (attaching them here could also be nice to see what compilers you are
> using and so on).

postmarketOS uses kernel config fragments and tracks the latest linux-next:

- 
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/devices.config

- 
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/pmos.config

- build recipe: 
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/APKBUILD


The only thing that changed was whether CC=gcc was specified or not:

https://gitlab.postmarketos.org/postmarketOS/pmaports/-/commit/b9102ac5718b8d18acb6801a62e1cd4cc7edc0cb

> Cc'ing Kbuild too so that they are in the loop.
>
> I hope that helps.

Thanks for your help! Always appreciate your presence. :)


> Cheers,
> Miguel

