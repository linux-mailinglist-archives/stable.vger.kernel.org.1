Return-Path: <stable+bounces-202794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA798CC72DC
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 11:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCCB93009850
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756234F49F;
	Wed, 17 Dec 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtghsHur"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868433A714
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966876; cv=none; b=nd6UBu3R8awKR6zBeWGbAsMbk2Kb/RFoLRZ+BR+LDnlSGaEHpN8v5ORjsUhEI65WdiUlVkiMhdNWy1zlHsnsvv1s7LIWW2h8MedE27IzUU2E0Yd5pl/EucHeHJfyabUp7mwVIbkxF/gvYd1VmaALXTECFGAePGKmLHfPUy/8pfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966876; c=relaxed/simple;
	bh=cF083mu3r55SVNE++nE4r8UwPmfojIpwXzIP+N1PTgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4A5PP3mmicewhuXr0P4MYigbQn2JQieG5LFqD0P328U1sfpo8q54e+IjPoX7y8brnFE9gjdr3OmyTeC3FBu9Ni6psUBqdBSbGb/EzLozgB59UrkfOfcH9l1mwqu5MYJ6GReRBWzz8VJqJBRR90Cp11E7N0oKI5SVy7nz6qMp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtghsHur; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5304938b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 02:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765966872; x=1766571672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVo0HBOMwKu9ksJmzCZKQPSTIhrU1ZIPJ/ubRTYCNmk=;
        b=HtghsHurmguGNme8RNmqRFDG9RdNeuuVDxVeNoLOalL586crJb5um6qDYuKMcaaW4o
         X8q249UvK/k32ghuf7fhEg/F8lgJd5QuckhtknrxmmZxhsG/bRnmD9sycsz9PXx7cRV8
         pdKK9YhFufieic6b73cfzaFPfdHC0QMOqVPBxVESqeErIZTUW3Sgb2Riph38EEQ0j78E
         cIX3XmpBQ+9/DWK8i22CYjnsPcFRaxLUcwNhrqKI8cefPpk/V93iEdvOVLl56dXrS9mO
         7JqNgOaoVgIsZ2XpBWvFWyjUnltKcinHUNVY7QdJPuLRFNpVatLmVaaiKCvn58pESYJQ
         xYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765966872; x=1766571672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVo0HBOMwKu9ksJmzCZKQPSTIhrU1ZIPJ/ubRTYCNmk=;
        b=nTz1gVuLKGK66UZT6cx/TcVGjAA5HiMoEtvJbG7zgjfGgj6ifCoODtai4gZNVb3B4o
         sJDNqRWTtf+mcjzKgDXhR0W38T9Djz2zegBxvw+eJgYsQlqqp0wnjEdN9LycitHm9Og9
         lVgyzMwXzRJfCzgm6k9cz2KDYHPEoJhqXpIc4o7M8I0s2K++jFMJj0Irglol7v/SliP+
         hukYa+7ZTIy9FHBupFErgDaL1uvrA8G3Sx+Kyr+drSjQ7kPGac+tNL05GluUYEgnPH4r
         pQRoeSushPGlSJQm0MRxB+KAU0c7q3XylYAktHCcpS6ZWR4fG9VIR48VLr99vMUnlenQ
         miQg==
X-Forwarded-Encrypted: i=1; AJvYcCXfngS3Z1IO+vcfOcPA1Sy3yy+4UNAd1lrD3DflhKFEVBwQ8cUou6UlZJx2qeZ8bx+f18JD/ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrISsk6PvngvgQiNCw5gBMCiXdjxYHKzru07arrW7xoGWajvj
	vP+rHwsE7Wduc2XqEMBEvzC/7a2d4MvKYX56QuatvhBPOVzv0UBbmO9T
X-Gm-Gg: AY/fxX4LE7De0rnmhuhd6dxeixAnY0VUb2bUcnT+QRljh7rS8aMBPRkIitAjUewnROe
	PJ+S6/FGsA/KwtDR94BFzkA7d+IhX6dFw4TO2QzfoZ03f34ctPZqA4lY4GOKsqh1wO3Usf/qgWx
	/8dw6G3SeqOSBF+/u61hiHjHOFMbY0pDo9vCH+MtHVtcodUzClfEgPbpd1k2hfdbumiCYB9d8h9
	Sm3kDcSNu3xjsxz7HBG1Bto73u6yOgPZtIyulIYS9LwZT2flgxNmHfsyfCOQjxjTwuuPbOeBJ2r
	bcQfjQ3SPutXRvqVmFEqjCbgSXxQ1nlDdu4tRht7tbuCq3Ml7xcDuVLbRIyWjPT28OFl4bP7tf8
	vTUBF5sUHVCOcM9AJFi4SZRcw/ITsveDpXRnPZZNjK7+0vWn/qBO/8gOK6ugfk9HrtPs0PhBTQO
	uYZw34Lq4ntYlbJnm8UV6HMp5/usds4yb1HISf5QOpk4ELkDtlF7tZ/HWFhz9VPtAo9w==
X-Google-Smtp-Source: AGHT+IEKnlxl760/suZ89AobjUICKYa4N99bq8z5k3ImT4XOViJUc86UsaA7/A8wEeEcuyACIfLqtA==
X-Received: by 2002:a05:7022:158a:b0:119:e569:f276 with SMTP id a92af1059eb24-11f34c035a0mr13548110c88.31.1765966872169;
        Wed, 17 Dec 2025 02:21:12 -0800 (PST)
Received: from [192.168.68.65] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f43288340sm26457054c88.6.2025.12.17.02.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 02:21:11 -0800 (PST)
Message-ID: <1910f4b6-db74-4c86-9010-28ab4462c5a7@gmail.com>
Date: Wed, 17 Dec 2025 02:21:11 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARMv7 Linux + Rust doesn't boot when compiling with only LLVM=1
To: Christian Schrefl <chrisi.schrefl@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, llvm@lists.linux.dev,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
References: <1286af8e-f908-45db-af7c-d9c5d592abfd@gmail.com>
 <0705db10-3cbb-4958-a116-112457f9af6c@gmail.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <0705db10-3cbb-4958-a116-112457f9af6c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/25 06:41, Christian Schrefl wrote:
> On 12/14/25 12:54 AM, Rudraksha Gupta wrote:
>> Hello all,
>>
>>
>> I have the following problem: https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635
>>
>>
>> In short, what is happening is the following:
>>
>>
>> - The kernel boots and outputs via UART when I build the kernel with the following:
>>
>> make LLVM=1 ARCH="$arm" CC="${CC:-gcc}"
>>
>>
>> - The kernel doesn't boot and there is no output via UART when I build the kernel with the following:
>>
>> make LLVM=1 ARCH="$arm"
>>
>>
>> The only difference being: CC="${CC:-gcc}". Is this expected? I think this was present in the Linux kernel ever since Rust was enabled for ARMv7, and I never encountered it because postmarketOS was originally building the first way.
>
> I've managed to the get the build setup for qemu-armv7. For some reason
> I could not get past the initrd even on kernels that are supposed to work,
> but I think that is unrelated (and not a kernel issue).

Yep, I just got qemu-arm working to drop into a debug shell for now. I 
have to look into why other things aren't behaving nicely (but that's a 
problem for later me :P). For now, it seems to demonstrate the problem 
nicely:

https://gitlab.postmarketos.org/postmarketOS/pmbootstrap/-/issues/2635#note_521740


> On the linux-next kernel I didn't get any output on the console from qemu so I
> think I've reproduced the issue. Changing CONFIG_RUST=n did not change the behavior.
>
> So I this is almost certainly a LLVM/clang issue and not a Rust issue. I'll try to
> do a bit more digging, but I'm not sure how much I'll get done.

Did a little more testing in addition to the testing in the gitlab issue 
mentioned above:

- Removed Rust configs from linux-next/pmos.config -> didn't boot on 
qemu-arm and my phone

- Then I removed Rust dependencies from linux-next/APKBUILD -> didn't 
boot on qemu-arm and my phone

- used linux-stable instead of linux-next -> booted on qemu-arm to a 
debug shell

linux-stable is built via gcc:
https://gitlab.alpinelinux.org/alpine/aports/-/blob/master/community/linux-stable/APKBUILD#L179

linux-next is built via clang:
https://gitlab.postmarketos.org/postmarketOS/pmaports/-/blob/master/device/testing/linux-next/APKBUILD#L68



>
> Adding the LLVM and ARM lists to this conversation.
>
> Cheers,
> Christian

