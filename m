Return-Path: <stable+bounces-76510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D129B97A640
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559FC1F21963
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16556165F13;
	Mon, 16 Sep 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGjd4dQV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A9165EF5
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505398; cv=none; b=IvXBVIcDIOhlHkGVTgWPLVp5pIDATpaZ2KR5pS2Qiaxr2lfWtCNq6pDKU7e8Di5Lql3zedxkle8AZKUxn7LIb9swD3s9vxybr4NlsgkXKnUE6bD2hq2f5HIBukGv9q5gUSRxWUFAzWCVGAWHK7S+CsKIklnWABMtt76zW+VRbo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505398; c=relaxed/simple;
	bh=o+DYVxVDcAlTZVNN1hFyfoqE3+LqsO2LryTMqHdVksQ=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4IfT4lQssDIDAgjS1IwPobI1qDXk6s5/GWdBDvUsGRs6BFiZJE8Q8PMbTEtI4JRpK00mrQTVHyCaiCaJbeyIXf3Sori+NjBIcFB51qsNj/LEmXq0io9kmMVclLPnpai63kSEeTT3cmspC5Hi1sOls80zfGiUY4tlHyMtBNoQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGjd4dQV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726505396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GXZKybnTnuNS+nIRSUr5QII9/sx+kMsW3/KaJpCCQ8=;
	b=EGjd4dQVzMWkZCkoFMmQCkLzWvlnoMcY8h+nc32Fu7/QOKVwE+xbOL2/hlTczgpWCGZ1kT
	TApZK5bNfkoK2zFTigi5DeSYEEfdE3F6IbpffKrKDqecmckrkfZap2Jk7TsK2/CMLS3jps
	BMZaqa+01iXYg6BUaeSrv+VMTdQRFWk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-8M6GsisCMM2Llqe8FXj4DA-1; Mon, 16 Sep 2024 12:49:54 -0400
X-MC-Unique: 8M6GsisCMM2Llqe8FXj4DA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a9bffc241eso836458685a.3
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 09:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505394; x=1727110194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1GXZKybnTnuNS+nIRSUr5QII9/sx+kMsW3/KaJpCCQ8=;
        b=RnMmip03yQSW0riVpnHsLIVdNERN26hbMcHO2jVkZkwrGeOog/LuiQxH8VpPN0K7t7
         73FxomQwQoORJTcOaMgG0xWWURXIfsDBOG6XIQlVCCy/IThC7UwMDGozIZGwXTbmI5Ml
         RoFtsFDF326XaanzQOBfuPIT8qUmYb4lHuXAxX4oTBzdegrt+Q2rByZmrrS9z/kssMEo
         sMllAziRzKxFSd1qPUMxDEA5WqyvYw/1Ra/oa/Pwrwif5zNuCEqBaZO44cc8zHppFojj
         1yq06joPs5E14bROS6KH5xJxCHWmB67fbWwLaytR8pjCObLN2xxbNKnhL24ZD3wJ2rMb
         sPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtx2TTieJY0CS5GQ2J89G5IISDj3I73FHdIe/MW5fO619gPY+QM6VqqlM3AvT7eOXG3oXM4Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wj1mdaOeAViIPUBEFeS5zai3z9wHr9wGTWx1Qfcpc/EsS7nC
	yVtS0GMmTpALkzQ8fwrg0Bb36FG5o2kx4gCwJMlZIQYK3xOgy1U3W4UK5gaTcvxZV8XzP2BI4Pn
	w90aWI3B9kEYbQN3z465X8yuZCsL+zukfzZqff4hjlcadOsSz5UHKKo4YlfHre87hfq59kYG/z9
	hBwxNQtJRaXT4MhE4WGTftszUylqRB
X-Received: by 2002:a05:620a:4708:b0:7a9:aba6:d033 with SMTP id af79cd13be357-7ab30dcefb0mr1578196785a.56.1726505394319;
        Mon, 16 Sep 2024 09:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEpr++i4tcvPceMgrGqzAnmVR09V07s8NPt541CScK42NXb+0pSNQBgOVdc22NfVWwm8atRhs0RB5k3cMyc+c=
X-Received: by 2002:a05:620a:4708:b0:7a9:aba6:d033 with SMTP id
 af79cd13be357-7ab30dcefb0mr1578193985a.56.1726505393925; Mon, 16 Sep 2024
 09:49:53 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 01:49:52 +0900
From: Andrea Bolognani <abologna@redhat.com>
References: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
Date: Tue, 17 Sep 2024 01:49:52 +0900
Message-ID: <CABJz62PRAv0QqszOTHDUdrrgY-Za9y9Vq6mYke=FqP=N5qXvbw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: entry: always initialize regs->a0 to -ENOSYS
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, "Dmitry V . Levin" <ldv@strace.io>, Guo Ren <guoren@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Felix Yan <felixonmars@archlinux.org>, 
	Ruizhe Pan <c141028@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:23:39PM GMT, Celeste Liu wrote:
> Otherwise when the tracer changes syscall number to -1, the kernel fails
> to initialize a0 with -ENOSYS and subsequently fails to return the error
> code of the failed syscall to userspace. For example, it will break
> strace syscall tampering.
>
> Fixes: 52449c17bdd1 ("riscv: entry: set a0 =3D -ENOSYS only when syscall =
!=3D -1")
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  arch/riscv/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..51ebfd23e007 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  		regs->epc +=3D 4;
>  		regs->orig_a0 =3D regs->a0;
> +		regs->a0 =3D -ENOSYS;
>
>  		riscv_v_vstate_discard(regs);
>
> @@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  		if (syscall >=3D 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> -		else if (syscall !=3D -1)
> -			regs->a0 =3D -ENOSYS;
> +
>  		/*
>  		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
>  		 * so the maximum stack offset is 1k bytes (10 bits).

Hi,

this change seems to have broken strace's test suite.

In particular, the "legacy_syscall_info" test, which is meant to
verify that strace behaves correctly when PTRACE_GET_SYSCALL_INFO is
not available, reports a bogus value for the first argument of the
syscall (the one passed via a0).

The bogus value comes directly from the ptrace() call, before strace
has a chance to meddle with it, hence why the maintainer suggested
that the issue would likely be traced back to the kernel.

I have built a kernel with this change reverted and, as expected, the
strace test suite passes. Admittedly I've used the 6.11-rc7 Fedora
kernel as the baseline for this test, but none of the Fedora patches
touch the RISC-V code at all and the file itself hasn't been touched
since rc7, so I'm fairly confident the same behavior is present in
vanilla 6.11 too.

See

  https://github.com/strace/strace/issues/315

for the original report. Please let me know if I need to provide
additional information, report this anywhere else (bugzilla?), and so
on...

Thanks!

--=20
Andrea Bolognani / Red Hat / Virtualization


