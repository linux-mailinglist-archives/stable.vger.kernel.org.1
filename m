Return-Path: <stable+bounces-202793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 926FCCC7230
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 11:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4C03017646
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B03A1E62;
	Wed, 17 Dec 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYPfLFKx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20D9237163
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966243; cv=none; b=LKzc0wwPxhPvLh/23wR0akh8kRNnFd4YTK3Kwgm9cUJeDwTfeMzJ4CbadkCKSB7VVM4bjAcG7yT9D1dGKVITUEcUao3DXFY7IqomBN2o7MidCg3OG6eUeWSqQtUOPunEavUFARH21uOoKAK9pCYfUcrv6MjJymD7iao+Looq7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966243; c=relaxed/simple;
	bh=SMvRzUudMwE9gh+QI3p78IKx2rZRmC3QOeEAGSMOXbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FENFYHb56gfg7cAHrstWHCbfFX0+dnrxw9w7eokbiwStKjqBfSfnRimzZND+2LvvnlCzUuCi9jxMM3pYJOk8hMvSMSIOk/Qe66ae/gAV6YxIpLIA99h3k4zWULpU8/OhLteJ5sVuqZmfAA7rZ+J4Guczjbol+WAlwP2jetqEJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYPfLFKx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c20ee83dso41608695ad.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 02:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765966241; x=1766571041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xO3E6v+EYJi4XiIbsXeHvys7mPWX18qJ6xl10KMPnZ8=;
        b=KYPfLFKxICsP2RUSX3eGUynFtKyaQwNVF4f10XE7KEem7RUcmWf45tP0A/i3eA8ALd
         B+HkJXjXfdW+90Cn+MoCRVxecT201NLRjvZKekwKlWhBTcWagIUSqGGfEZVXfEt8y4+7
         4LVYpCSCXaCwaj5egZCxCVi9eu6rfQfAA98rIAkcsxOq3KEfPXyRD/GUE1KScbvE+x2V
         GQOvvuBwfHn2VMJE/wgkVtKchgivEoEwuMYBZGzNtwheZyIQCA35UCpikzUS1NAjDttg
         P2M+nDNVIpL6GNgAPc2W3xr13YP+V13DHYgNAoAJjXzkskcEziJGZ615XZDJI9SCrUTN
         xKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966241; x=1766571041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO3E6v+EYJi4XiIbsXeHvys7mPWX18qJ6xl10KMPnZ8=;
        b=UohM/yUDcjRjs91WbGJ3E8TG8GQSaNU0qqmpua279UZEK4Dgjd2ty8fI3hERtv6LlY
         PdLjyPuEx7bEUAu+93gOXyzu2Y7R1wo3qSJQ5M4ioENTBEUpEgguoW1w2XqnjK0tx8vA
         1DfaELOViHX2kL0txCKH2rxm251UhRJ7zLw19Wt+xGc2r4q0gyo1H4ChHAb42WzrWkK3
         G1uyMUkPayow7HJCms67xbpRNXvqyzYw1UJ/tM52Bv8xBOiFmVqNxvVxCVuOZxbfmmec
         wSD/9QNRnKUhOnjDz9MrxFy5zKwTBbh89MfAWjDde/SAFPE2/vZqCWe4HPSDQA+uEYA0
         oA4A==
X-Gm-Message-State: AOJu0Yz1yh0nBsd8BUeZYLu+/NglVB/lNIswD4d2oQMPNlRhmhcRmLC5
	ZVY+z6fD6vlpYI49/flO1hVffUkyKO+Pty6RW2AMXg0+YsQ5t/FfaCzB
X-Gm-Gg: AY/fxX4/f1v/rwB+XYRU3NDgO4Ygn37iFJD2wlpWpkcJVYwa5dAZMyZwJ914uTfOO7w
	S7Rn9waz3Nlk8wk7QUzYHRNMI9Jz6Sms7E6tS9H8yB7haQzNtSfqF1ph/+9D+Hx0w0IAlv49RmV
	GZK4CwTxqhQNXWOCgTgHXSNq5BcOGrFhpGYTFBflwHOFTnSszTkYkDmULvN0UpYB4WPnyG/IkRp
	3aJNTkra45q65vyJJOCXBg8P9ZFldMxHJwP/ojtWs0WJnjlSTBFso7qn56LbUCqb56Pu/9hvZYp
	lUM+SOIQhgkiS572MZznngYPoO3zBuzNXtlRX2OdPsGS/qtyH9qwpbHvN3rGk8/cahs5DMG6rHO
	wWYS/RjEnEbHLSQlvTr/PbDaeoNry48rUZPwvGK2YE0RhfmizBokioSEoyuprQXnzmscpou6Tid
	7mbyjmTu9+BtBCNvdY9o90rFjRrYEC7G4vcU+Z8yiFZEB8HkWHekO6owH+KGhWPAlxDdpSH7G9W
	vVf
X-Google-Smtp-Source: AGHT+IEG8JLieGR++365pLcyjXKBpPQ05/7enLWig8JfwMbvY/InVaunD5JLpgX83zIDArSrsMhjGA==
X-Received: by 2002:a05:7022:6191:b0:119:e56c:189d with SMTP id a92af1059eb24-11f34ac157bmr15819602c88.5.1765966240957;
        Wed, 17 Dec 2025 02:10:40 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f43288340sm26393130c88.6.2025.12.17.02.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 02:10:40 -0800 (PST)
Message-ID: <bbc421e4-76f7-4dba-8228-23488b1b1310@gmail.com>
Date: Wed, 17 Dec 2025 02:10:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
To: Christian Schrefl <chrisi.schrefl@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
 <66cba90e-c9b1-4356-a021-e8beeff0b88d@gmail.com>
 <6eaa65a1-e7dd-404c-b716-d4f7a0ce7f5c@gmail.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <6eaa65a1-e7dd-404c-b716-d4f7a0ce7f5c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/15/25 04:17, Christian Schrefl wrote:
> On 12/14/25 8:34 AM, Rudraksha Gupta wrote:
>> On 12/13/25 22:06, Miguel Ojeda wrote:
>>> On Sun, Dec 14, 2025 at 12:54 AM Rudraksha Gupta <guptarud@gmail.com> wrote:
>>>> - The kernel boots and outputs via UART when I build the kernel with the
>>>> following:
>>>>
>>>> make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"
>>>>
>>>> - The kernel doesn't boot and there is no output via UART when I build
>>>> the kernel with the following:
>>>>
>>>> make LLVM=1 ARCH="$arm"
>>>>
>>>> The only difference being: CC="${CC:-gcc}". Is this expected?
>>> It depends on what that resolves to, i.e. your environment etc., i.e.
>>> that is resolved before Kbuild is called.
>> Sorry about that, I should've specified in the original email. The CC resolves to armv7-alpine-linux-musleabihf-gcc.
>>
>> When both LLVM=1 and the CC=gcc are used, I can insmod the sample rust modules just fine. However, if I only use LLVM=1, my phone doesn't output anything over UART, and I assume that it fails to boot. Interestingly enough, if I just specify LLVM=1 (with no CC=gcc), and remove the rust related configs from the pmos.config fragment, then my phone boots and I can see logs over UART.
> Did you try other architectures / devices as well (especially can you reproduce it on qemu-arm)?
>
> Did you try a LLVM=1 build without rust enabled?

Seems like you've found the preliminary qemu-arm patches I posted, but 
for completeness sake for others, this is reproducible on qemu-arm:

https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635#note_521740


As Christian mentioned, and I also now seem to conclude, it seems to be 
a clang issue.


>>> The normal way of calling would be the latter anyway -- with the
>>> former you are setting a custom `CC` (either whatever you have there
>>> or the `gcc` default). By default, `LLVM=1` means `CC=clang`.
>>>
>>> So it could be that you are using a completely different compiler
>>> (even Clang vs. GCC, or different versions, and so on). Hard to say.
>>> And depending on that, you may end up with a very different kernel
>>> image. Even substantial Kconfig options may get changed etc.
>>>
>>> I would suggest comparing the kernel configuration of those two ways
>>> (attaching them here could also be nice to see what compilers you are
>>> using and so on).
>> postmarketOS uses kernel config fragments and tracks the latest linux-next:
>>
>> - https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/devices.config
>>
>> - https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/pmos.config
>>
>> - build recipe: https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/APKBUILD
>>
>>
>> The only thing that changed was whether CC=gcc was specified or not:
>>
>> https://gitlab.postmarketos.org/postmarketOS/pmaports/-/commit/b9102ac5718b8d18acb6801a62e1cd4cc7edc0cb
>>
> I'm not familiar with pmbootstrap, what is required to reproduce this?
> Do I just need to use the edge channel with linux-next or is something special required?
>
> I might habe time to look into trying to reproduce it this week, but I'm not sure.
> I have a armv7 based asus-flo device to try it out. Its not very well supported, but
> It should be sufficient for this.

asus-flo would probably also encounter this. Currently it's a bit broken 
in pmbootstrap, but I've provided a general guide here on how to go 
about fixing it:

https://postmarketos.org/edge/2025/11/17/apq8064-kernel-removed/


Would love to help you setup the asus-flo, since it also seems that 
upstream's IOMMU is broken and likely other things as well. If you'd 
like to drop by in the Matrix chat, we'd love to help you there if needed.


