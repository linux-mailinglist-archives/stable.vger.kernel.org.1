Return-Path: <stable+bounces-57916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1134392606F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C487E1F22307
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CE176AA4;
	Wed,  3 Jul 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erEep//Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915B17335C
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010112; cv=none; b=Yy53WfM65pT2EWivOFSmDDvFVcp9ek82zA3PNUaBlSPg6HT7SoC37pQKjI/dcUMRL0kMjekf0VzyPrOrZ6OTNCby4wNHKVzGRhjmg522mH1jYZqKvNBVOPnwXbdAJnmeQN1pdMbCZZwf7qzkgMBf5NvQFeRTO+S86OjcYfK7LSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010112; c=relaxed/simple;
	bh=cfGy4hd/MJDQaAlZyWKj8dMD+MgtojL710RreopYNk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaT+TNPYHP+1j3hQkwsRrV/bdwkEp02/5JZiWmrBgd/GGrPtoUlBbDCAq6nMchIAQ9Eg6FLYsCVDYePH+XTRFLRf4Hk2xo+ybHhnGmDirzi+iwfYY6ouPgUn63n2itzRSYdDVBO6G0/EeKFv9swz7SMOylVVailp5nVJDtnGWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erEep//Q; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8100f08b5a8so516350241.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010110; x=1720614910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj8SrAjLpSLjliuG99WdKny0d1AT/67yDFEWTU/8uKo=;
        b=erEep//QN5IXm7I1epEj8I1BLWCjLhgaUkdFy0OsgNUbm/sTbX25lI0309bLOna9zI
         3B0meQB7XuQJ2z+I+Bw5vLZoFTtIjkJJEcTD9e6DoPyLws4jwQUKO2Td7xa79GsxmiAi
         LJGMgNYE7e0SdOywpuKcompPZypvWwXmMPjZ9Mcp2qoh9b5uou+/DqRnHC9QtUQTOsEV
         MqGCq8G2yKf29qakj0oFMZhapUilwaDMzVl1/312RRdZvzBuZQjXKA+QSnc0XYFD/UxT
         9md6fxCuIu9ehR2wbW/IKCeHm1VF/aTjACo7frld7jpJEgT90K3pHOkvnA3r2URpp+Jt
         nPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010110; x=1720614910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj8SrAjLpSLjliuG99WdKny0d1AT/67yDFEWTU/8uKo=;
        b=lzv670nQcyxxTBzstBg7waV+Qfd7ThWgOrfttD68irx1Ri/Bh7ALtBcJsl00jkA02a
         PXO1gJ9PQB4rzOPDI1ySS8uNQaK8Ke3FNzCepLIgYhYXTJGJaDpIuD19p9pYYpEoji/C
         Nre8Oq7Cow2cO9xkS5OZgzIgJrfobSUowLFY6pZJeOwesAZn39afezNLUzOdRiFyedT+
         JaQbB/UZAu1b0NMyc1tJdYCYVZ6s0Hhdfe6Lk0xFJvC3AV2RU5eQWvuPH2Qz7/ASz6x3
         XSdrjTZnMqNWdoTLZepl7l2LH69L1yCU6rp5WYaYTOKIQT1y+VFz/fQjPqT+yBMPtoPT
         f3Wg==
X-Gm-Message-State: AOJu0Yzh8ITKsD1XIxqSWbZCBG5Qq74Tt87NRHeiWztxqj54LsjjlF2U
	MxzxjLSb2sC3+JgV+Bd89D1rCqD/3aCUKWxRr3EQxcT4FS4q9wZ4RJBDQH3fhGBq3IpB6A8YV7u
	Kl1wjjzS4CcO81OQE8oU8tMci7CnPw6uMdqfHmw==
X-Google-Smtp-Source: AGHT+IFC2Ceua1RohvvkAIKkyjcpb3zdlon3mgykMv7og6AVgIzZvwsefW9dPMvY1y6HF6Y22NRmSxg3gPVSzvwQPTc=
X-Received: by 2002:a05:6122:4287:b0:4ef:58d4:70f8 with SMTP id
 71dfb90a1353d-4f2a572cb78mr13958132e0c.13.1720010109406; Wed, 03 Jul 2024
 05:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170233.048122282@linuxfoundation.org> <CA+G9fYs=KkeYFMS01s3VZmeSYd1zJphinPFCk1G2AJ7LZ=+8=A@mail.gmail.com>
In-Reply-To: <CA+G9fYs=KkeYFMS01s3VZmeSYd1zJphinPFCk1G2AJ7LZ=+8=A@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 18:04:57 +0530
Message-ID: <CA+G9fYvcbdKN8B9t-ukO2aZCOwkjNme8+XhLcL-=wcd+XXRP6g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 14:27, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 2 Jul 2024 at 22:48, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.37 release.
> > There are 163 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The following powerpc builds failed on stable-rc 6.6.
>
> powerpc:
>  - gcc-13-defconfig
>  - clang-18-defconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> ---------
> arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
> arch/powerpc/net/bpf_jit_comp.c:208:17: error: ignoring return value
> of 'bpf_jit_binary_lock_ro' declared with attribute
> 'warn_unused_result' [-Werror=unused-result]
>   208 |                 bpf_jit_binary_lock_ro(bpf_hdr);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>

Anders bisected this down to,
first bad commit: [28ae2e78321b5ac25958b3fcae0dcc80116e0c50]
  bpf: Take return from set_memory_rox() into account with
bpf_jit_binary_lock_ro()

- Naresh

