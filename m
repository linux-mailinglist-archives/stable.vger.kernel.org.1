Return-Path: <stable+bounces-177620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69688B4218A
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 15:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02F06858AC
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C130507F;
	Wed,  3 Sep 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="ioZvnfs0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF97307499
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906141; cv=none; b=ky0KVZ6kuuFnl4rYCcbeOL5nfaDP5JJWdqsQhQh+ECipFJzyJ0dBA/Z6uXVpOhZ2OCz/ZZS9whoJ3y2zXLpyqfxqcatx6Iw8cozDNmDI+Cp6MlHqVGzexs1G/oEkLpyy8LcwhISzLsgizAOLg8UQPF4fq3n/az4pM18ctkOxu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906141; c=relaxed/simple;
	bh=izk0IZmyI3MpZX8dah1iAMq8tH5iGUvz2zunPfvcQnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0566kNgHXfLZXDSY8+IaYmyocw5zwh1nrbGwf17bNL7YquSJtgckXsuAlLbr0+U6S5JTnsEZpNDyVnSYLPqWEI65EkcNFFOp5E59iE7o1qZlknndxdxX/ZL4BVouAOarA4/uAln6B34XBqdXmWYqr1nODgOrnjwJdNt1yVs6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=ioZvnfs0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b30f73ca43so39644921cf.3
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1756906137; x=1757510937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1xV/deyqGkmJxLaaOIY+1qBi2UrFX9CrtK1ZvKF0rs=;
        b=ioZvnfs0EEux+O5ebgtLh5ydx4q/FfZUlJsrglde3QMHaDyth48lnMt4N/aKt8cfCn
         xuiuBzhY7o4kYn6jnqO7374/Y8yTt7otArZQOwUhd9Q/bSwRcPixTtmHBFKPsdEathWr
         T+2SD7XLv0GXPmMGka5ymcYysERZEag1E9mGmlUA+daWx4J3UF7EZJBKbWF4w+u6FZG2
         bwoXZFU3DLIWgThJ2ZhO8K/FUfrOjXq7yO5I7IJLZKuTzdULZkhB1Gh0sypGHEXj6x+J
         EHGdvZmF5DrW2kF31mLvgRISSRCCWqeBCOzJXCYiF9e6BCfjzIcn4kJ6o17g4INVNSDk
         s5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906137; x=1757510937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1xV/deyqGkmJxLaaOIY+1qBi2UrFX9CrtK1ZvKF0rs=;
        b=F7ONnb4K0VS0a7KHGZW4qpyE0o2H/n6STO9JU+H98kHQaopcS2bC/R/vmKOMOrdrqU
         WkPT9ZNYYciIHltltedELmpfgy8A+coeOKAZXOjw16JWLh7SkdvDFVJnunDdVY2KvDIb
         7/65PTw5xehkf0QeFEnmir/4Gvz3QKB+XaD2kUSltiJNTGFNZQGVrz26t7uIzQUcW6XX
         1XdkwGTaHHmDNTFPvD3dpxyLbdWMxNNjlwrjlPkSXy4uj5UkK1l91aMmGGEGIKvyM9ia
         TwhdhKnpyqQrnSdJ4PbqM6ZH9tmCOLbQTATFqx018PipspHqMcCMsBxcLvvzIiqNHTux
         Dpaw==
X-Gm-Message-State: AOJu0YzYR8ZdT2FKLAVau3GLmetawbyGVQY55jo54TVDog7WKi/UHvXY
	Bs9lo9t4yaR/Q7RNp9XtCc990aj+B0tXLcioTErRMMMNYXp8Y8oSBUt3VphyHnMsR/JDJoEb3Jk
	kDOAcVMMSZz29+jH4vYm2Zy+kM6tPRx/HcC6Cow5wbQ==
X-Gm-Gg: ASbGncuhvPQ7Wkb2BZ7hJuQnOL7KumNbkVL8Co0VForF5qkUY64QrawfAAbm1hSEKJh
	9RyKPy9fYumM4d6wQlSMOFOIqmDJChpOC4b77EmXILr3WXmzrHxz0pZxONKs3d2ry0o0ZL4fzoO
	qeYmYCnRlme8+uZMaTzSzwhbVHH9WhL2xDqMozpA3pTJ4Ora/hVP0n9H2SP9Ea1BJF4l2+WfUyI
	JPQ0+Gy
X-Google-Smtp-Source: AGHT+IEb9SF0ZAQ/gl70xHietNZGoqqgRbcYfcZB8vu3mSrxASuhTzMLNODi+2ufxi3Kb5/VCv5lEH2P3alFHmyuJUY=
X-Received: by 2002:ac8:5d87:0:b0:4a9:c2e1:89c4 with SMTP id
 d75a77b69052e-4b31da3d038mr183413971cf.47.1756906137150; Wed, 03 Sep 2025
 06:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902131939.601201881@linuxfoundation.org>
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 3 Sep 2025 09:28:46 -0400
X-Gm-Features: Ac12FXwi4i5s22HaICVQk8Zg7KdU46JZLCzhgfwfvZeR0OQqZCIwhAezRAG0Tdw
Message-ID: <CAOBMUvi4yUWxMLU5usvYsCVd_cKd9iQHBqSzVp4sW4Kc9Z3fTg@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/95] 6.12.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.45 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

