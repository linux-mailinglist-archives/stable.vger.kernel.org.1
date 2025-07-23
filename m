Return-Path: <stable+bounces-164494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0271EB0F8BC
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090CDAC25D7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF421ABC9;
	Wed, 23 Jul 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhSGw9aw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60F2153D4
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290825; cv=none; b=JN4p/hXgFXMeaPvnaaA1PIKSK5FaPvEKlyexweadYPhny7xHfFGPYSxNRVxZOXv3cjZ49DfyhI0fa8ofSrbxGV6h4aAxIOoT9PgzYO7hpJfTu8spnDU4oTm8ladbblY8Eo6v3k/RDsumOIJ/976U3kvBhRwLlL0R2NLbZRvbGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290825; c=relaxed/simple;
	bh=pMnFxJPW6XzsnL1R4P4uAKlb14uoYQriOV872ovk5gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edn1npznkWG5VWDjJgi4uILGbm7xf3yftWQVSKUARlKjhUCvD7Vra3xIyjNffOhL4Xy+haZ//EnpPHPJuHr6kvhVWjX0LVYGjR9w35DXE096uT6aYxtv6nZY7GMF1BO1fSVALs3k3Dn+Ye5D3IdbbzdfgkhCFdYx6+VCWLHF1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhSGw9aw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so248998a12.2
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753290821; x=1753895621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbyOa94TQVfB7gVOjp48G76NvosaX6GbTdxBBffJV48=;
        b=NhSGw9awGZKHpqwNPIvcClFWCxq2Xwr7hvKC+a5yxyzV0or0DV3COtkQnWf9d6dQjF
         Hhslfo7xOmsW4wNOHgiBt4bTYwOX9Lzq6JFowrsds8pxRij22exd/gYDp1nWpQ9mp9j0
         CAY+M2YMMO5QOo3Gnndtg9blh4mpb9vKAfZ38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290821; x=1753895621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbyOa94TQVfB7gVOjp48G76NvosaX6GbTdxBBffJV48=;
        b=cDN6ovflXdrZyPp5oxihHBWhyGJ2WCJWnrVcnVT8ejuwyXko1tOJSZQocVuaumRyO6
         xkkak1vxgY1neJue9/POp56ppJ0ZJMF1zYdHHthFB3J/vkRFC/RXnHf0AY9rzTgVFMvm
         Sow6iX+zBS7ZhOuR84HoXJs70O9DrQ4/qMm5gVMz13COw5AKrZJKGoHqaMVTcW1Slmuu
         P2leMfjT7Nb3e0BHiSCGqpBEiaYwQOrzYqvwP6kqHt52Av04jOxqRM944ohUWVqY56tO
         OlOEle9H4V7YTqjbcQP+59xrRvBtOaCZc9qOPTv18btpt/G/su9/mXBk+Sb1llllKfwX
         1+DA==
X-Gm-Message-State: AOJu0YwzDVGXMiglJOZPA3C0vLwVIMx4V3zj4erDMBofWULSTvThhMPU
	nRWch9LoXhB17NeNiQQCyuPdNZAoKT9HK5aIBzKocZMvDg/FJIa/28dhj9EQa9SesljLt5gjcWY
	rbeOSy5k=
X-Gm-Gg: ASbGncviBivbG5DnM+lIXI1oeObg+1BXOJ0tSBmldHKH4QeR8pKOTKdyvKkLKWJuvbk
	ABjVoRiGqanMSlGxrdWj97UMZt4n0P22uSMRDsevUe781mgIrIgTQ14/S2qhA6sTq1wIOj4RcPQ
	hza8uXnX03tGTWP1PPDTkuStEWiHPc7XOmVLy0TYryI2jrjRfglSLKHG7oS+tJW9rF5kbrAIcAb
	yZbKmg+6iaiNz0SnLzothuzO+sca8TIjRHPyLwLkTU6xjjsTf3obo824yeDXZoi7chSTpl/XGOk
	V6HG0uJKCAsXVYgsyDg+WF0UPuS5kwtjWWOhPN5TGrLxDsYn9sNH2Dl0mD9poblQbKfSbE7TSzT
	r0fJRcjA3s/KGgCxsCUBpCdGlxgysyJS/W84nRzHX9OVHYUx4PNnr6kr8jD1nY9NqVfCIN3XEG/
	afcT0/zq8=
X-Google-Smtp-Source: AGHT+IE3qIsMbNAY/1KaIt5Uqk9Ci4F332V+dl07EfXN9hk8c7g/UNtZnOlUYgVepI7HL7H3mRh7Bw==
X-Received: by 2002:a05:6402:d0b:b0:607:4c8e:514d with SMTP id 4fb4d7f45d1cf-6149b409e97mr3037338a12.6.1753290820971;
        Wed, 23 Jul 2025 10:13:40 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fd6esm8792964a12.45.2025.07.23.10.13.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:13:40 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so245931a12.1
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 10:13:40 -0700 (PDT)
X-Received: by 2002:a05:6402:278d:b0:604:abcd:b177 with SMTP id
 4fb4d7f45d1cf-6149b5a6038mr3381870a12.30.1753290819737; Wed, 23 Jul 2025
 10:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2025 10:13:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDTgxaxLjx0bLnS_Q1Cj+a7hQaJEYsmgEW8izYwQ4UdQ@mail.gmail.com>
X-Gm-Features: Ac12FXwIzOuWPmOEFuXnAdKlUhd-_wPT7V8xPSxl6_fAp9X1gowIqJjQH_CimW0
Message-ID: <CAHk-=wjDTgxaxLjx0bLnS_Q1Cj+a7hQaJEYsmgEW8izYwQ4UdQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Backport "x86: fix off-by-one in access_ok()" to 6.6.y
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Laight <david.laight@aculab.com>, x86@kernel.org, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Jul 2025 at 09:32, Jimmy Tran <jtoantran@google.com> wrote:
>
> This patch series backports a critical security fix, identified as
> CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"), to the
> 6.6.y stable kernel tree.

I suspect it's fine just backporting the whole thing, but the actual
fix is just the workaround for the AMD speculation issue with
non-canonical addresses:

>   x86: fix user address masking non-canonical speculation issue

and the rest is purely "set up the infrastructure so that that can be
back-ported".

A different alternative would be to just take the logic of that user
address masking, which exists in two places:

arch/x86/include/asm/uaccess_64.h:

  #define mask_user_address(x) ((typeof(x))((long)(x)|((long)(x)>>63)))

arch/x86/lib/getuser.S:

        mov %rax, %rdx
        sar $63, %rdx
        or %rdx, %rax

and make that generate worse code - by *instead* of using the
runtime-const infrastructure, only introduce a single new variable for
that USER_PTR_MAX value, and use an actual memory load instead of the
runtime constant.

I dunno. That would be a noticeably smaller and more targeted patch,
but it would be different from what any mainline kernel has done, so
somebody would have to test it a lot.

So I guess back-porting this all is the simpler thing (and does
generate better code).

But I did want to point out that the backport results in 250+ lines of
patches, and I suspect you *could* do it in a quarter of the size or
less. At the cost of having to have somebody who really cares.

                Linus

