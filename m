Return-Path: <stable+bounces-158481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B523AE75DE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 06:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA4C7A17F1
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC119C542;
	Wed, 25 Jun 2025 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkphe7Gt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289713D76
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826016; cv=none; b=gpVS54+7BdwGmoyOAEAHEb+S1a2uEjXgk/rsCx/Ywb4sibJAZFNyE0omxKPll5JgRxa3jPWzQwN7CsfBfFzFgp7VkoQCnbHXvzBj4Nj94v4B/z9xF/EnST0ZsDx9l4PFzfe1GqsUGlhZ/jwSL9LV+Ki9E2rsdcyix/wpjy6iBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826016; c=relaxed/simple;
	bh=suGpKOxJrw/x+Qw34YH9Wq5C5aeu6ITuVv0x3tIR8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zc0x+A0LBwvupVCI7REiqnxMuZYOyWQphD+aXh5x4KGTZQZylKe3rOyeKH52XAoqmBxlXJtjoYeqFVSUyKvFkrdFX0hnumwn8N+LzCnS9C8Cq1pjsREqdK+JT+7dodkmdev3r0zUoQuuTuA4uy4AMfwTGVAwY5mnvWvMZnL58uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkphe7Gt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so60201855ad.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750826014; x=1751430814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gxLtLJHJekP2m5RDJO4GtXWgXu8wxWquk/PnbuibIg=;
        b=wkphe7GtVKXlZEf4dSRQ6JoNnkFUNGpSRmwQZzciM0mL9BsFQIwloPQgPuvyRnCy8h
         706+QFk2DWUHzeDqb+PbEgHGi6HhHzabyXif2IjGVba1HRBi9GDaBBW43/6IWUX4VsFH
         Fg1wlkL93rEe8+vAlU/KQP6f2UzQvT2uMM5hp7OII0f2L/BzwpS2/UsnrfOm3ATCRdr1
         LdmqqWBOUISQDoN9Ng+aG9jyPAt67U+S0syDqFFfoa/iC4vY+Hp07H/cQgOoqMXuTIoF
         ARMlUckqHcsqcQwXQvywXj3428KP0lBhMe5Jeqbs1zT9gNp+jqXalZeJ6/KB+KSDvByk
         14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750826014; x=1751430814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gxLtLJHJekP2m5RDJO4GtXWgXu8wxWquk/PnbuibIg=;
        b=HLSq0Ega41dQrTMesNxEAMYEeORDQYgDtn6rCqWd2JRe6af+QEVpXzp9HY2DHPL2WV
         YhXw3XTLlZZJL/GvLMvcDpiRU6/ZChVT/0Nkln8jUaYITGlOLfqiZFQtQwQrXFSkznps
         2gdEtwUhuQyA1iZSiU0AtYUhdKcZLqntyhrfA/k5IF7Jb/lua3pf+qppviK8/b7eTH6D
         aUNyaLmmzidnAQF3kQ2BLUhDvA1wiTYFmZv2ffuJvnbrPhiRjX8kj14mVBIBszfyhYNZ
         RAF5C+hDzpH9HpvLOaNSSf5z1F4jcp47TwRh/4TIdeSK1klF6mzBXcwBxPfCsyNZGDKr
         RWNg==
X-Gm-Message-State: AOJu0YyInJcbquxZ1xsEN5A4W2v8Xdu73Ovgk1gb6UfN5B+Dzm6dq8O8
	kKAxDmVszNinafCDiRp36ADF3A1L57SCYZxC4jSsLuDVtcN2kcVY1ayMetYmyBzJnomwv2HUZ4a
	4lpk7kfksrbIaqS1IRrrIcuBtniYwkCuDOXg9Z8M9/w==
X-Gm-Gg: ASbGncsIrjJSm+EcslI83IyVOr5QgVvVGyz+/rY//TzdEeETN8KpBv+G+D9gjrdSOfu
	+VzQyssGg4MKhRhaWOTeQNNjTyebYb4eyyCO0tdLhiFBByYN1f8c/a44Pi4ek4KcopWloaSHePH
	efVNDvNQ97YBHrQRtr79n/wiCCjvslK6/oOpuwuBIZ6eWuAq8dxqmCcRtRTM6GGHbydlP5eRa1i
	1Sx
X-Google-Smtp-Source: AGHT+IGtaQJcYYKVhLp/50lPmuB48IV2mPVXAbLY+hiIPV/anQZIZHdY1a23C23NRxSz7f54xc9tE/nROguaPMm8/Tw=
X-Received: by 2002:a17:902:ec91:b0:235:7c6:ebbf with SMTP id
 d9443c01a7336-23824047541mr35763975ad.35.1750826014327; Tue, 24 Jun 2025
 21:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130611.896514667@linuxfoundation.org> <CA+G9fYvpJjhNDS1Knh0YLeZSXawx-F4LPM-0fMrPiVkyE=yjFw@mail.gmail.com>
 <2025062425-waggle-jaybird-ef83@gregkh>
In-Reply-To: <2025062425-waggle-jaybird-ef83@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 10:03:22 +0530
X-Gm-Features: Ac12FXyd0V9F7KS0Td9Q-UYWV_cQw3EQwUvR1Vc5-PgNTQkt74Bhnhzxgl5WlkY
Message-ID: <CA+G9fYvNTO2kObFG9RcOOAkGrRa7rgTw+5P3gmbfzuodVj6owQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/222] 5.4.295-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	kvmarm@lists.cs.columbia.edu, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 15:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 24, 2025 at 12:46:15AM +0530, Naresh Kamboju wrote:
> > On Mon, 23 Jun 2025 at 18:40, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.4.295 release.
> > > There are 222 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 25 Jun 2025 13:05:50 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.295-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Regressions on arm defconfig builds with gcc-12 and clang failed on
> > the Linux stable-rc 5.4.295-rc1.
> >
> > Regressions found on arm
> > * arm, build
> >   - clang-20-axm55xx_defconfig
> >   - clang-20-defconfig
> >   - clang-20-lkftconfig
> >   - clang-20-lkftconfig-no-kselftest-frag
> >   - clang-nightly-axm55xx_defconfig
> >   - clang-nightly-defconfig
> >   - clang-nightly-lkftconfig
> >   - gcc-12-axm55xx_defconfig
> >   - gcc-12-defconfig
> >   - gcc-12-lkftconfig
> >   - gcc-12-lkftconfig-debug
> >   - gcc-12-lkftconfig-kasan
> >   - gcc-12-lkftconfig-kunit
> >   - gcc-12-lkftconfig-libgpiod
> >   - gcc-12-lkftconfig-no-kselftest-frag
> >   - gcc-12-lkftconfig-perf
> >   - gcc-12-lkftconfig-rcutorture
> >   - gcc-8-axm55xx_defconfig
> >   - gcc-8-defconfig
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > Build regression: stable-rc 5.4.295-rc1 arm kvm init.S Error selected
> > processor does not support `eret' in ARM mode
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >
> > ## Build errors
> > arch/arm/kvm/init.S: Assembler messages:
> > arch/arm/kvm/init.S:109: Error: selected processor does not support
> > `eret' in ARM mode
> > arch/arm/kvm/init.S:116: Error: Banked registers are not available
> > with this architecture. -- `msr ELR_hyp,r1'
> > arch/arm/kvm/init.S:145: Error: selected processor does not support
> > `eret' in ARM mode
> > arch/arm/kvm/init.S:149: Error: selected processor does not support
> > `eret' in ARM mode
> > make[2]: *** [scripts/Makefile.build:345: arch/arm/kvm/init.o] Error 1
> >
> > and
> > /tmp/cc0RDxs9.s: Assembler messages:
> > /tmp/cc0RDxs9.s:45: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:94: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:160: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:296: Error: selected processor does not support `smc
> > #0' in ARM mode
> > make[3]: *** [/builds/linux/scripts/Makefile.build:262:
> > drivers/firmware/qcom_scm-32.o] Error 1
>
> That's odd, both clang and gcc don't like this?  Any chance you can do
> 'git bisect' to track down the offending commit?

The git bisection pointing to,

  kbuild: Update assembler calls to use proper flags and language target
  commit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.

- Naresh

>
> thanks,
>
> greg k-h

