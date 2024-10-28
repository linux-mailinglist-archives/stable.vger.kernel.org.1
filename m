Return-Path: <stable+bounces-89094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2C9B366B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AEB1F22CDB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 16:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A201DE8B7;
	Mon, 28 Oct 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLoTAyIs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135F18B48C;
	Mon, 28 Oct 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132763; cv=none; b=TOKceCSTgm+dD2nIHt3xOMK8Ltq3o/7EM669cKrNIK0D+aOaceF5JLpPSKHZId4qBIEjM3MoeV2qgo0rEOCplNqkypA8vXb4gGglH4qOn5RhT7s7ofGQC53dFxN3hv410t32kUZbWdDyQa8i/Nyy/jaJCpbIjLazuWkMO+3O8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132763; c=relaxed/simple;
	bh=mQZSI004/P48i+HS6A49TOUpl/j7aAzwI0a9NzusncI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZQLIZXyxoBn6PGDEt6rR0jP+i6jBW9GftzVLSSN6LjfVamBZnQIL1RR7cdz5uIAaxSA2tcTR4jqxnqYq4ts9GiZPRahC0ZxiCJZoiORSIzdSZ+LL4jO8s/Suv1wA24majqxk1GvQfCpmfVBF8pJAXPJuIMj6ShGTPs1Ukbmbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLoTAyIs; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c693b68f5so46926015ad.1;
        Mon, 28 Oct 2024 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730132761; x=1730737561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zi/YPCKq2pnvwaWzJ1+lBWDNA5pML5O6ykDvgXbiSGY=;
        b=ZLoTAyIsjJp2tCkoXregVU0jqwvJWlUrmKjicttVZsJ08q8eThIuEHEQCA+GvttNYH
         naa39JshbnRvKbqC+S1t6UgQQjn3EDczP83tDb636kx3h31gUWZkTXD6Nmhr9wHSi0kH
         U0iTQvVrW0vIoe7I5VJhSzJYZlSz1Q5uwsQMEvp2q/7dwtxfVA6xan/Q6q91H+UcUsuS
         zb5NXE+7pR5D1duGSEB6laIePGf6R634tCC33++/Lj4SYKT1Q/XStbT0QvnAE57JyzPA
         ogtlVZaqhaDDUBO+a0SyrWegJJWoM8lR/qgeQWZ4YJnr2USru+n35K0ByTZOzHRHYvev
         p2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132761; x=1730737561;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi/YPCKq2pnvwaWzJ1+lBWDNA5pML5O6ykDvgXbiSGY=;
        b=liYladi3+hOWxsIzRxH81Rb9+m74DIYwe7Kusw6PY2tvftEH0Hl6Wfj3QFTE1oybsm
         xbOJCsVPStvqgdilTfM2tYjuZdJQbMKk4IuCOhT0Fqcz50srpNqdntsZo7Rokobmlq5k
         mG5YEOihIH6EywEdz3dgKntUCW6gG45H78e2XvU74asfX7wswv6fzoWVX3YiynOc2uRT
         me4FVViYnLp+MOhTYXDH4fKXrPRlKSsDTF1u7LlktxWMRWl0jLqq7LRFLX9RtcSdZ0cw
         2DLn3gyHXg46fNCNU5tdILo8b335uPAqb/XQ1taQxZwSvlkyhEt8a18mXsZpojJwxBug
         VRjA==
X-Forwarded-Encrypted: i=1; AJvYcCWPGiS/OWTW3o1rUlvThUT293rmYAfXbirytWl9Qt8XMXDbpobfkMrlU1lKr7NRt9wnL3mYHbUW@vger.kernel.org, AJvYcCWfSWLe+GhetU8HaqYRkxzdYkAoHVznf5xtsQMoudfb5kihjjV8zyQ+f7aPb/rQjT4UmO47T2d3+tMbso4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pwBZjoqppwa/A+G6Mq3DN9Tv3Z5CMPpxHvXZWH1ZlN5t3z0I
	e5sauCgxEOQkLIfkMj/jMTzDo5rr99XQpLwcJEBWHR/5WsjikP1P
X-Google-Smtp-Source: AGHT+IEEIhIcjSj9a4I/Em/9bk4VIo7UIAOODWRRjuGix7T52NUnL+2Mu/j8znXSNfqN/pfRwVna9Q==
X-Received: by 2002:a17:902:e848:b0:20b:9998:e2f4 with SMTP id d9443c01a7336-210c6cf705bmr96246315ad.61.1730132760809;
        Mon, 28 Oct 2024 09:26:00 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02eb81sm52187745ad.207.2024.10.28.09.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 09:26:00 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <109afaab-05c0-4228-8ea0-1dc1aabe904f@gmail.com>
Date: Tue, 29 Oct 2024 00:25:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
Content-Language: en-GB-large
To: Ron Economos <re@w6rz.net>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com> <87a5ep4k0n.ffs@tglx>
 <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com> <877c9t43jw.ffs@tglx>
 <81afb4bf-084b-e061-8ce4-90b76da16256@w6rz.net>
In-Reply-To: <81afb4bf-084b-e061-8ce4-90b76da16256@w6rz.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-10-28 08:17, Ron Economos wrote:
> On 10/27/24 2:52 PM, Thomas Gleixner wrote:
>> On Mon, Oct 28 2024 at 01:01, Celeste Liu wrote:
>>> On 2024-10-27 23:56, Thomas Gleixner wrote:
>>>> Equivalently you need to be able to modify orig_a0 for changing arg0,
>>>> no?
>>> Ok.
>>>
>>> Greg, could you accept a backport a new API parameter for
>>> PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?
>> Fix the problem properly and put a proper Fixes tag on it and worry
>> about the backport later.
>>
>> Thanks,
>>
>>          tglx
>>
> I wouldn't worry about backporting to the 4.19 kernel. It's essentially prehistoric for RISC-V. There's no device tree support for any hardware. Also, 4.19 will be going EOL very soon (December 2024).

Ok, I will work on preparing a new patch to add a new set in 
PTRACE_GETREGSET/PTRACE_SETREGSET.

> 
> Ron
> 

