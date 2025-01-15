Return-Path: <stable+bounces-109179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B7A12E5E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 23:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6872F165258
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109D1DC197;
	Wed, 15 Jan 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Faloxm+z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BE1D79A9
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980986; cv=none; b=N2MZxMLA9Sd2NQUzQmh7sspISF52nG04Tl62NRCwvpFE3GxKOoHMINxCBur+0bhtt9CwDuUfbSkLMl0CpeKtQrTIIYhH+otvne+jWuz8capytH5OOtIRWk9DfXebm7bCROW+W1huzyWATj8QfSEZBlCMnnJM1GmXn3BfjSXZ0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980986; c=relaxed/simple;
	bh=yL6U+qd9McH0WeBiO4msfSFQjHRbrZ8Ebmmtycj45mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEzFK1Mjn3zvbasi2rphOiigEwZT7iJDUTe4isVXRAZoABSqLDNacGIQMEX0gb+nSlqD9ibpjtgxfuKiqQzqFnkmy3ChWyiRRWsIU8vjyi85La/vJqlcJbS90faUrGjnkIv1C/sQT2au9VbR5l1GJ2XQ88cwQhPQCnyPNVQOLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Faloxm+z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166f1e589cso4760985ad.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736980984; x=1737585784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1YubPgC/8eI2lbaVxtAtUgVaIXVapt21tVigfpGQfQ=;
        b=Faloxm+zhHaMwNZOyI+Nxi5I53I/aWoXcjWGhCbNBJzwaxCmQLwU1hUdgAiWzRz40t
         9A8fVaabbbIpUzxInDzVUpDQ0tL5HdrypeqTSHeUL/tbzEU2aWZmy7012h9NiIH4BRRm
         rc8rvj9xJwpx2SedyWhl0VCbTy12CnW8mocP/W27DqTzgYXFE4Pz7KUQ/tZWpaTEjv4n
         xNdCa3dBpis7m6P54uweNfDwicw7wiTGACkd6BoUH9GIolRMnSLaa2VktKGnqE5J0+Po
         uMT0IMlqW0LiJKgJRuXutU5jEancL8WToRy1Z0br9WfqVOBMyEyJmcEaAW+67bD3U+hB
         E9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980984; x=1737585784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1YubPgC/8eI2lbaVxtAtUgVaIXVapt21tVigfpGQfQ=;
        b=Rn5TI9X0FjaR1JsUR2Gm3HwfO+3p+FPOKbAB9NddoY79dkscMxm8Sh5ORBNLHZuYv6
         j2SAmawJjZuGP5FPky2Eh945KfQosXiHPY/k5SMwvYSFfaAjBHFMmGJ7xGJqNq2215b+
         AsvfIawpJsAfBEifl90ig58yhVbvvUoGz2wOR0LwnddQsCFJJXgblI5f2zYEuLux13FX
         pg0RkprcoFhIJ+Df3Dc5ZFmoaOMoBVijcNYf1FpNi+XH/g6Xq30d6JSXAe0xWwc2thJL
         UE45Bdx9z1eA7aefMP4wSWfYUeYdYkV14tlSQqg24pVCElgAgXZ3NtT5weQUZx2XymYp
         fkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM51cJAC8rVR/HqqDYqvvWZPhvLsUPU98vKcUYs4jR6ApXCXWyBKBgqfHqmwlRuffWmJSWecY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNi/6mZBcKs06d+2PHznP8/lgCWcv0651doGqMKYF2ADB75L1h
	KhMgoOY4LcdTVcAkDCwcqshjo4VPimrfCd20wBzdhbKOFa7vQyTs4PKw7ow9qrw=
X-Gm-Gg: ASbGncsUi2lAQq9q+0LGiQCbTGTrq1wqSDzWq8Vdzhz10kAuz1+oZ0QtIKS30UL1hcD
	r3CLPCKnBVspWEOvxnbQjdP6g/9Dsd5DFPdwsSOni/RpZanlAGv2gumJPxxEhwlWN/iuztzhVum
	PlvIarh6bdIqZcwgTb//jUyrIDL8Ne1Cy3wx7f8QLRCQq1KY/Wkt0qcZNR+5t8g2fQCFz/7otKA
	UMrVAbQtoSQOK7snP83221dfV8lwf6mzS2VuIfp/olRp2k=
X-Google-Smtp-Source: AGHT+IHvvdjAhB26TfABelCo2yezRGgIVCLHqbk75eU3TNKSL+BscHjkrJVVlUgyTbGeTyl7z8y3Mg==
X-Received: by 2002:a05:6a00:1385:b0:72a:aa0f:c86e with SMTP id d2e1a72fcca58-72d21f17738mr44987044b3a.4.1736980984037;
        Wed, 15 Jan 2025 14:43:04 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405942b0sm9709309b3a.74.2025.01.15.14.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 14:43:03 -0800 (PST)
Date: Wed, 15 Jan 2025 14:43:00 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
	Andrea Bolognani <abologna@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Andrew Jones <ajones@ventanamicro.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v6 0/3] riscv/ptrace: add new regset to access original
 a0 register
Message-ID: <Z4g59EaNblLWKPXF@ghost>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>

On Wed, Jan 15, 2025 at 07:13:26PM +0800, Celeste Liu wrote:
> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
> 
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
> 
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> 
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
> Changes in v6:
> - Fix obsolute comment.
> - Copy include/linux/stddef.h to tools/include to use offsetofend in
>   selftests.
> - Link to v5: https://lore.kernel.org/r/20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name
> 
> Changes in v5:
> - Fix wrong usage in selftests.
> - Link to v4: https://lore.kernel.org/r/20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name
> 
> Changes in v4:
> - Fix a copy paste error in selftest. (Forget to commit...)
> - Link to v3: https://lore.kernel.org/r/20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name
> 
> Changes in v3:
> - Use return 0 directly for readability.
> - Fix test for modify a0.
> - Add Fixes: tag
> - Remove useless Cc: stable.
> - Selftest will check both a0 and orig_a0, but depends on the
>   correctness of PTRACE_GET_SYSCALL_INFO.
> - Link to v2: https://lore.kernel.org/r/20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name
> 
> Changes in v2:
> - Fix integer width.
> - Add selftest.
> - Link to v1: https://lore.kernel.org/r/20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name
> 
> ---
> Celeste Liu (3):
>       riscv/ptrace: add new regset to access original a0 register
>       tools: copy include/linux/stddef.h to tools/include
>       riscv: selftests: Add a ptrace test to verify a0 and orig_a0 access
> 
>  arch/riscv/kernel/ptrace.c                   |  32 +++++
>  include/uapi/linux/elf.h                     |   1 +
>  tools/include/linux/stddef.h                 |  85 ++++++++++++
>  tools/include/uapi/linux/stddef.h            |   6 +-
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |   6 +-
>  tools/testing/selftests/riscv/abi/ptrace.c   | 193 +++++++++++++++++++++++++++
>  7 files changed, 319 insertions(+), 5 deletions(-)
> ---
> base-commit: 0e287d31b62bb53ad81d5e59778384a40f8b6f56
> change-id: 20241201-riscv-new-regset-d529b952ad0d
> 
> Best regards,
> -- 
> Celeste Liu <uwu@coelacanthus.name>
> 

There is also this series that looks like it will solve this problem by
providing an architecture agnostic way of changing syscall args with
PTRACE_SET_SYSCALL_INFO [1].

- Charlie

[1] https://lore.kernel.org/lkml/20250113170925.GA392@altlinux.org/


