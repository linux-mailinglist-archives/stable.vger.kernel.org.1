Return-Path: <stable+bounces-202792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0DCC70B9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 11:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB013310F943
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C633A030;
	Wed, 17 Dec 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8Vk4O7d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E633A011
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965678; cv=none; b=TqVYBvh6xV+Lrh53Bk0z0ahjm7+MPKaLrPBo/RNWnxNHzbdK0k5Cj7wC8sPs6ZXVo1JqAl3FrvGYUG6krNJNEpBUJnvRdWlIqshF1RL73u+/P9l0CGr7T82gB8QFUIkrDFSDOGJGU4AB4QURSCk5rUDKRzkaWlKXDmoBgTvC3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965678; c=relaxed/simple;
	bh=TX9PKbwuo+X5c/pt2dQLV/tFLg61cIkY/mvBpoTbQQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPriUfJweZ7oAPrHmExy28apaddKP1iPCfXyIn9/4jEDZBltSedqp6SPQ/4CMktG4ygOSTp0N4Lv3gcCZaPVW1v/9XgSDjNZFLzlBWd+5VF06aavKwNGTKvmP1G4ZfXuUMOGlQrdahQFpDcb7KjL5/LpFyC90aJb8NCfOEfwT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8Vk4O7d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a12ebe4b74so29021905ad.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965674; x=1766570474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnrbYc142rU4PJ4+bdzEv+GG1owi+xgePcJ4V/hmpW4=;
        b=Y8Vk4O7dKWAqkkLwskf49XdUCFSRpGOdqjQcSmTTbARj54lF0HjA9PiA8kE0chVcKv
         c/0i3aPcNnaQdz5r2fjq8O951ZEWxEfV+XnbPdHztWSy0fSCEI6gOE32XepjDpDce2sM
         gNhBEt6PHZU/D1liZmYVGr+ClB20Woy3vc9e3kNmZYu8bEAHQDPNC6qf+KEv+Gr+GjWq
         VJo6HwjU1htljpaqj/royssiGUGQcR1Wit9FnWf/p23em6BqGof0koFvj5ln5mpkQBEE
         6Zt8dhwF+o21DepfxH2JahP3re6Im/9r7hRl3XRD2pN9Q/ecGc/p9m03LuRMVdmxH82p
         FEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965674; x=1766570474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnrbYc142rU4PJ4+bdzEv+GG1owi+xgePcJ4V/hmpW4=;
        b=grVCT6X9KX5Ba/m+wEv6xq08R5XFXixLYDj7mriJoJMbbLzXcwxG0lCdd55+Y5vxlA
         tiL/CIguyCRILr31Jb2xE8HgrsaKeoqIPA6UbHt2HiThiCOWAQA28H7VoH1p91j5mg3J
         X1Xn7eTk3pP4CjrbF7aYxiGxk55/ui6sA+wj5TLywB0fKFip4UNjpp4CjCYGl26vrtrK
         w2G3pR2b3eT4kN068GipyH2U+1DAPLug4+vJlfxQkf+7CVgS3LXFeWPtn3M9H+9vONdV
         BY0Z6hh0G+XlafLw8plhNLnD8A9TUS7WVOJIvTjPOpZA4fgcLJKqt83P3IxzVw4g5ClT
         UUoA==
X-Forwarded-Encrypted: i=1; AJvYcCUm3QywbRlHW0SS+nB88kD6roxiJW0Zy/H+SezvmezV1b4s50741NEREWODzRLuYhGMdxWy2LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62huhLoFtXIuY/CNHlUL1jr+utFFgSLpKbjWtAfLUWKS+KOJL
	ZbE1QV1IlHaABt+CEMUY3TL9ktv8nxkb63bRxGSOGFH+dOLlWtt7pLgS
X-Gm-Gg: AY/fxX4RiTEaWrMCeX8G7FuTzhMyVjR5Z0RfKqlCu3boASV9WLjr/ONc5HXvhofOpET
	bWMRGrCvpTsAl+kKFDtzOBSfLDz8lbQrVKDeQWVqZ332g9LypBwGK1tzxRjta8UGy8d/KfwGWOX
	MLxBrBkbYM3IijRIW7nJKuIswruxqCyrAxKpmhDewo6HaUXtBr193dPbyZACcfOnK4aYAVP0tLE
	yrpU9uVKgqqHl9fByLptgGiF8mAY5UIiqhNExlIXSypBwVDUHZ0EKvSWX7rb3pHGqN/bj9FAfWa
	tYOV5uyEbyRnMY8rU+5Go6TyocYtMSuZXPviniAdYoEtbR8jAqQLjYHWE9Ttu/uzapTgxJPfA0J
	gsXILkEtYeUFZ3NilfZha//7PQKqJFMn2w6epkwpId25fihNNlXukwn+ajozeEkz9TcZLFzB0EF
	SY+yBcJv7tE5iVIw8tFLvFJSsmotxQY133LTYoN0cfop6ARceDL+jkrwqIGUR0Dc9CfQ==
X-Google-Smtp-Source: AGHT+IHQwrAaQaZ6XAsRxYUc34aZYpqc/das4JLNgCdGwfbkhJl9an6tRUMXyRBfVTtZ0DT+E4HinA==
X-Received: by 2002:a05:7022:1715:b0:11d:f81b:b212 with SMTP id a92af1059eb24-11f34bc819amr10015101c88.17.1765965673857;
        Wed, 17 Dec 2025 02:01:13 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb28dsm61367679c88.2.2025.12.17.02.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 02:01:13 -0800 (PST)
Message-ID: <f14fec30-204a-48ed-b714-f420ea4594aa@gmail.com>
Date: Wed, 17 Dec 2025 02:01:12 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Danilo Krummrich <dakr@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Benno Lossin <lossin@kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
 <CANiq72kYjNrvyjVs0FOFvrzUf7QYe8i+NpBS6bMEzX8uJbwB+w@mail.gmail.com>
 <66cba90e-c9b1-4356-a021-e8beeff0b88d@gmail.com>
 <20251215111941.6c7817cf.gary@garyguo.net>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <20251215111941.6c7817cf.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/15/25 03:19, Gary Guo wrote:
> On Sat, 13 Dec 2025 23:34:31 -0800
> Rudraksha Gupta <guptarud@gmail.com> wrote:
>
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
>> Sorry about that, I should've specified in the original email. The CC
>> resolves to armv7-alpine-linux-musleabihf-gcc.
>>
>> When both LLVM=1 and the CC=gcc are used, I can insmod the sample rust
>> modules just fine. However, if I only use LLVM=1, my phone doesn't
>> output anything over UART, and I assume that it fails to boot.
>> Interestingly enough, if I just specify LLVM=1 (with no CC=gcc), and
>> remove the rust related configs from the pmos.config fragment, then my
>> phone boots and I can see logs over UART.
> Which drivers have you enabled that use Rust? Just having core Rust
> infrastructure enabled shouldn't cause issues on its own, apart from
> slightly bigger kernel image.

Just these ones:

https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/pmos.config#L264


I'm starting to think this might be an clang issue. Ran this on qemu-arm 
and encountering similar issues:

https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635#note_521740

> If just enabling Rust but none of Rust drivers cause issue, I would start
> looking at
>
> 1) if there're any symbols somehow being overwritten by the Rust object
> files.

If I suspect it to be a clang issue now, is this still the best way to 
go about looking into the problem? This is a little bit out of my 
domain, but happy to learn.


> 2) if the size of kernel is pushed above a certain threshold that your
> bootloader/firmware is unhappy.

I believe lk2nd (fastboot bootloader) would complain if this were the 
case. I'm currently flashing lk2nd into the boot partition (to override 
the proprietary bootloader's defaults) and then flashing posmarketOS 
kernel and rootfs in data and system partitions.


>
> Best,
> Gary

