Return-Path: <stable+bounces-78635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D295098D1EA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C0280F91
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719561E631B;
	Wed,  2 Oct 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVFeYsTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52619409C;
	Wed,  2 Oct 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867043; cv=none; b=LOa48+NEhkN6olrFEfad4OZT1UnIWVy/wzi3h96f+GCUrTzpTdvKVizdTz/3T3jr/1tG5FWJrBuFHOn9x/JrmjsvOx6hIS6jIQgbrhW7px6s0zb9WQH+yGoCmTIXIGxgj5gkQqTOsSwkKc3ID8jHy3jgHJi6E40w89dNUzWM8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867043; c=relaxed/simple;
	bh=bRT+Rmf3ckP1CToEZOVirx3YK7yUBv4HzsB9WBFxi7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfg7YzcKJU0h+a9Dtu5xHz9u4l4Hh+kN2LnPVX7G7/gKB9sKig5NgSV4qTBzHZP/k7eP16QDy7jyH3212+umD+87Qt0kCFtjl4bIKA5w5FZVyf5sVez2iBRkTEJ05Bb3A4/Qkxix10uddLgMFQicgotN3D+7zucvp5YGeXgDaXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVFeYsTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB2C4CECD;
	Wed,  2 Oct 2024 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727867042;
	bh=bRT+Rmf3ckP1CToEZOVirx3YK7yUBv4HzsB9WBFxi7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JVFeYsTSWXLil+Vig2hIXLpFa9wsvTgzbIGhJVdUvNloOEEQz2lFrys84ZMeWZWaB
	 yNsqPCmqf+VGkOPVYYUpsAUolRbdRbqNytBCzWpX4Ieru4vSgzwCtkRYMfbPmXdToA
	 qZbhcPFVKE8e6RJzODX4TNIKmz8zMxj55/tC2HrJ7/O11Sr2FKsNyd8G3QgDN3dj+c
	 L1k0QUKfUi+YQb0yuxtPM5ZlifFfT/K0Bx8OeJlhFwjl47v080bgXJTobl4H7IdRtj
	 NpZF4xKm8NH53neFZ0ObHPJ2MsrwkMl8V6Hxpx6mEtci+dbWoRPt7HBfACbMvkGnkn
	 UVMoCXTuj1uWA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fadb636abaso17442021fa.3;
        Wed, 02 Oct 2024 04:04:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtfGUiu6j9mZZUgBZ5GPd1i8CdXssYFOeo7Ax6P2EN+DbccH2dH3l5S4f5759uvoV39mNMgl4n@vger.kernel.org, AJvYcCXSpYta+ajzyaAK66l9WaoXwNSVj8HFhvdVzqzclnV9v/eNwXH6CTES7Hv/ze6jMJoreMd/p/IoD4aOhbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiblNvFURqO436tWXQYYEbVeICr7JcDdML3s70uQmqoChSaMr
	0KtBWcOMeysO/fsA4klv+X0QSE7nbrl7WHlRr81Xdb/xbse8R+9KzjJHQIYeo/+9uGoc9Lk5Ock
	wutUUu01slIKwIPHzmNca1bL0/vY=
X-Google-Smtp-Source: AGHT+IFXrL3jOypLzRq2RuKWfKSf02ONCh7cDfckKnMQsWD7y7mVBolgTUV5bFx8iJFuViEowg65BT68DJ4dEirM26g=
X-Received: by 2002:a2e:b8c6:0:b0:2fa:d059:af2 with SMTP id
 38308e7fff4ca-2fae1087453mr16472701fa.39.1727867041073; Wed, 02 Oct 2024
 04:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002092534.3163838-2-ardb+git@google.com>
In-Reply-To: <20241002092534.3163838-2-ardb+git@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 2 Oct 2024 13:03:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGDmkuwSROhnFkX_jYbWyAL738KmHbk5qYnThL6JWHapg@mail.gmail.com>
Message-ID: <CAMj1kXGDmkuwSROhnFkX_jYbWyAL738KmHbk5qYnThL6JWHapg@mail.gmail.com>
Subject: Re: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol requirements
To: Ard Biesheuvel <ardb+git@google.com>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 11:25, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> GCC and Clang both implement stack protector support based on Thread
> Local Storage (TLS) variables, and this is used in the kernel to
> implement per-task stack cookies, by copying a task's stack cookie into
> a per-CPU variable every time it is scheduled in.
>
> Both now also implement -mstack-protector-guard-symbol=, which permits
> the TLS variable to be specified directly. This is useful because it
> will allow us to move away from using a fixed offset of 40 bytes into
> the per-CPU area on x86_64, which requires a lot of special handling in
> the per-CPU code and the runtime relocation code.
>
> However, while GCC is rather lax in its implementation of this command
> line option, Clang actually requires that the provided symbol name
> refers to a TLS variable (i.e., one declared with __thread), although it
> also permits the variable to be undeclared entirely, in which case it
> will use an implicit declaration of the right type.
>
> The upshot of this is that Clang will emit the correct references to the
> stack cookie variable in most cases, e.g.,
>
>    10d:       64 a1 00 00 00 00       mov    %fs:0x0,%eax
>                       10f: R_386_32   __stack_chk_guard
>
> However, if a non-TLS definition of the symbol in question is visible in
> the same compilation unit (which amounts to the whole of vmlinux if LTO
> is enabled), it will drop the per-CPU prefix and emit a load from a
> bogus address.
>
> Work around this by using a symbol name that never occurs in C code, and
> emit it as an alias in the linker script.
>
> Fixes: 3fb0fdb3bbe7 ("x86/stackprotector/32: Make the canary into a regular percpu variable")
> Cc: <stable@vger.kernel.org>
> Cc: Fangrui Song <i@maskray.me>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Uros Bizjak <ubizjak@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1854
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Makefile             |  5 +++--
>  arch/x86/entry/entry.S        | 16 ++++++++++++++++
>  arch/x86/kernel/cpu/common.c  |  2 ++
>  arch/x86/kernel/vmlinux.lds.S |  3 +++
>  4 files changed, 24 insertions(+), 2 deletions(-)
>

This needs the hunk below applied on top for CONFIG_MODVERSIONS:

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -20,3 +20,6 @@
 extern void cmpxchg8b_emu(void);
 #endif

+#ifdef CONFIG_STACKPROTECTOR
+extern unsigned long __ref_stack_chk_guard;
+#endif

