Return-Path: <stable+bounces-86560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1199A1A40
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348111F235E6
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E75156243;
	Thu, 17 Oct 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjrMDMv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B71388;
	Thu, 17 Oct 2024 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144240; cv=none; b=mmk2wIhzmfZYDIgqoKgPJti49RAdboy+pwBWCfrj2pZVC7KVkXaOz5QTDr0vTH0yxSHcG0BlGsn5OyVKjp/SsUSb2LhLsY2cNRIFiOI724z0aeDaNq5hIJdxX1hrWPHOBiqoEwzvdMZ+C3HJHcQ1lzRbFimy+bry0mV5RjRs3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144240; c=relaxed/simple;
	bh=JgDkMC6FoSP2hVC7EEtLhLVF6K0lDCSNun1l9prB6GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE4EtiHz03QKKtoC1lXLF+Cqnb9RTGI3OPYdLv9Oh/h3SC3+dVnLAn3otZm1NKDwzSUMI6TH24Ut8y6tONyuNwyADT7X10k5gFIxYBlLXZw7qmCdzmg8axgus+OeJlQVWkAXWStG2aB6+r7Jcb45nBfeHl6HHd5ABETrFKVQvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjrMDMv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF3C4AF09;
	Thu, 17 Oct 2024 05:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729144239;
	bh=JgDkMC6FoSP2hVC7EEtLhLVF6K0lDCSNun1l9prB6GU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjrMDMv6K21F8PZQRQ0Y9uMh8biN4Xtz7YCmtfPZqpO4n1FXL/HvFTOckwYrlzaEq
	 GVo6ra2yTvdMHvymxNIB72Bg2vubWik5dqhiMaH9n2at8Ap8wOWztvEtLDvP2k+BNW
	 EJp65bKkAbaqGeZoUf493wK7Ne7xLOlVvA0uqllsX+z1363mInlGNpqnRfCucEGAMH
	 PJ0NVf+orWPdpY0D3yZfzKI2NvvVMwrMVUeGfuTEgPxjOXi0UUfc2d/h5X42fagYPY
	 dXW7Ge9NyqOCrW7TFgFGmTFRyHxv0s0EmcxNiYhLmbyj8WhYsGQN1qT0YKb1ZEQ5KO
	 mc7uOSCqWJwcA==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d495d217bso460505f8f.0;
        Wed, 16 Oct 2024 22:50:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkbbYP4AKj8BpR2LIPZCMeRWj0Nrvq1TdFgacvXOvFVo4c7FPvKDBQDDkAagWgGdowgN4z7lXZy+0GTqY=@vger.kernel.org, AJvYcCWAQ9nvFL5jPxYQGIz7BokJhmyQ2V4KfAmapqx9Xyn3DPyMP0L1Is6K1E50ZF9mCV/kJVsRo08a@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSSKJaRdNcmOzmJk9YD/Uvddf/nzidaa96glscoZ4vjLak/oA
	EHdlDeoLzrEk8Yd3Fz9ysasC5v3rOMCZKwhL7hWMq/QZsHQ5DW1SUuEdMesYS0wkvWMSWgrjNyH
	MJNcu0RdgJZypiekdl/asIJyePNw=
X-Google-Smtp-Source: AGHT+IH4bLUp2guSOMQGCAZrL1qd/E3kziiiLRFxl56U2a7Irdany/btpiZJz/ngAuGcQZeHHyKfhGn6rYH2Jqe02OE=
X-Received: by 2002:a05:6000:1faf:b0:374:c11c:c5ca with SMTP id
 ffacd0b85a97d-37d600d31e4mr19740821f8f.46.1729144238120; Wed, 16 Oct 2024
 22:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016083625.136311-1-alexghiti@rivosinc.com> <20241016083625.136311-2-alexghiti@rivosinc.com>
In-Reply-To: <20241016083625.136311-2-alexghiti@rivosinc.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 17 Oct 2024 13:50:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRVfzfHeZ+pMBSbxQ3ovFiazJ7CDm-8ZcVHmKpaxZFdCw@mail.gmail.com>
Message-ID: <CAJF2gTRVfzfHeZ+pMBSbxQ3ovFiazJ7CDm-8ZcVHmKpaxZFdCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: vdso: Prevent the compiler from inserting
 calls to memset()
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Vladimir Isaev <vladimir.isaev@syntacore.com>, 
	Roman Artemev <roman.artemev@syntacore.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:37=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The compiler is smart enough to insert a call to memset() in
> riscv_vdso_get_cpus(), which generates a dynamic relocation.
>
> So prevent this by using -fno-builtin option.
>
> Fixes: e2c0cdfba7f6 ("RISC-V: User-facing API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 960feb1526ca..3f1c4b2d0b06 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -18,6 +18,7 @@ obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
>
>  ccflags-y :=3D -fno-stack-protector
>  ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
> +ccflags-y +=3D -fno-builtin
LGTM!
Reviewed-by: Guo Ren <guoren@kernel.org>

>
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o +=3D -fPIC -include $(c-gettimeofday-y)
> --
> 2.39.2
>


--=20
Best Regards
 Guo Ren

