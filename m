Return-Path: <stable+bounces-52168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90E908729
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B986B23B7F
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5181922CD;
	Fri, 14 Jun 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZHXyssU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF4146D6A
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356541; cv=none; b=MItds+xiVCINHs6TbcQRURfCR7AtUcW83XVc11rzENxfot6dMMjM5sgLLEYA8ueS8DdSELE4+KgpF7OXQ6ZV+Fq/2zgoTZf0sZeOKZlKKR40p4AfxNlG07vXApj/kypNVyf3tzVeXhvqLnJx9j+vu3no8Foid4AuFeu6Vn2EDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356541; c=relaxed/simple;
	bh=/JZG/AGW8YO9YEwzpQSbeXxjZz1kRWU7PMN2yTnHC3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdjbcERzj2XVYRnXDxKLjiXjgfM6lJmmKQWP2SC2hr73bKoOkrwJSEdXq82CA0HQDtTEWqNfst48LYgT/aJ13stHAbkpZ6hx/ffjiEOphZxFydetAXc9jrseJYgyKPZo+mBoQH86RodNzOWFJyw3eM4DtEIX5wmzwihT3CO1WBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZHXyssU; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80d6cf96e22so1153290241.0
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718356537; x=1718961337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5t2Wj1oXu+8rhsC44ZuFPYafYW/0+ix7sLMBpjY/38=;
        b=YZHXyssU7+Xe83GcApUJia+H9JVtx3Z54AJLtSLpS438eNJO4+c7PLH6TsJs1bzvTq
         tB17LVBe0BsetJ+AILi72yj32YMtbPBx+4ZqxKI2nLA62j5HTxMoWhfAmFPTvj7mpS/I
         HSTta//vgKwOB/yNUgwPvgLK/tqQrUQ7Kb7ltMKSkMoiN/3a0KbUhZeQ3lGJIdJGDfeo
         ZLD6iKkZ454K834Np4u8HqSJCMYVmubPbcTvaALvmLAdMPCXOTH3NsQze+u9X1iuLtso
         sfQYW8A5nOvV6630UcJ1e2qQnnaGKFLl15wlvDLra31xjKPsayN+kfkCuejJEgJ1LN2w
         KJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718356537; x=1718961337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5t2Wj1oXu+8rhsC44ZuFPYafYW/0+ix7sLMBpjY/38=;
        b=X4N+bIpEPIm9MMUvxswe2GkJ2BEtOfXMt0x4tqEuoiQBx2PNOGcVh20N+QjKqphr01
         pnETvRxvrmsjpkSpbAGKFMT1xGx6EzC/1tQx9tMNEFDMQKJlmnfqCNK7/2FFBXGzKlUg
         SIAwcSreH0UKTBXgmM8hzB9z0BGbCCe1td77LCR0uV+BfVmc34zgviAS9L2QkOyQw6KA
         1qZsajZc2UVHerf0M+s7U5lZaueyc9mT9Mprk7rb4sLcOMcEN8rFkHK/weAh6qD/DUVX
         cDXAhBVPNT6V17thiY3+WQVB+8xNmik0uEcie6MBDIr7BUZ6cpSKjgFFOGNzA2DWmndU
         604Q==
X-Gm-Message-State: AOJu0YwypM7J8+JxE+B9K9NotPskkZ1qLCn7bcj2NMwPOpsaQ699rjcb
	G6RmIDZvDwh8/F83NXVChzqAHO6jn2Z06I1n1UmLlkwvKkXip1hT9xUC5eWmDYGqqT3p01+8U1X
	fAbRfyeigOLVo+iP3igmarOPg0GT4j1TE/nUkFw==
X-Google-Smtp-Source: AGHT+IE3eSj2stOVQBL5thdzjGaVBKFsIPShMAnCCjVqEowRbjHRfmjek5eDn/iLg3Kys0gPCOQmwn2hEbOoZKuDtZg=
X-Received: by 2002:a05:6102:304e:b0:48d:a16c:9c9d with SMTP id
 ada2fe7eead31-48db4f00688mr472940137.4.1718356537574; Fri, 14 Jun 2024
 02:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org> <CA+G9fYtEkcPasc62FH170nPyJTS83jfdAtHUfgwG+QDuQP060g@mail.gmail.com>
In-Reply-To: <CA+G9fYtEkcPasc62FH170nPyJTS83jfdAtHUfgwG+QDuQP060g@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Jun 2024 14:45:25 +0530
Message-ID: <CA+G9fYvwJxJdsSeTGsKjKonkiJnDC13t1+mpjHhyCvc_2r3=-w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 20:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 13 Jun 2024 at 17:35, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.34 release.
> > There are 137 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.34-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The powerpc defconfig builds failed on stable-rc 6.6 branch due to below
> build errors with gcc-13, gcc-8 and clang.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> ----
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
> arch/powerpc/net/bpf_jit_comp64.c:1010:73: error: 'fimage' undeclared
> (first use in this function); did you mean 'image'?
>  1010 |                                 ret =
> bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
>       |
>          ^~~~~~
>       |
>          image
> arch/powerpc/net/bpf_jit_comp64.c:1010:73: note: each undeclared
> identifier is reported only once for each function it appears in

Anders bisected this and found following patch,
 first bad commit:
 [2298022fd5c6c428872f5741592526b8f4aadcf8]
  powerpc/64/bpf: fix tail calls for PCREL addressing

>
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.32-876-g8429fc3308da/testrun/24327571/suite/build/test/gcc-13-defconfig/log
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

