Return-Path: <stable+bounces-78154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B165A988AC0
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 21:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31774283263
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D3170A1A;
	Fri, 27 Sep 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu8R2c8i"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E7136354;
	Fri, 27 Sep 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465564; cv=none; b=DiReA8rrDiTQhI5fb2ZZfVvek6sdEMH6zS665yfOJAnNNuFLqYogi2kjgDdKIGgPpo4bX8jrvsvObkQle1e1VxXdq3RnAkXkcGILNhzgzezsf4Qt59VcsQ4bwXldcgBHVKlZgQnOeoNKP+wiz8v5kjPdk14JEJ7KXPXB/GsYD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465564; c=relaxed/simple;
	bh=sJRp5M0f6R2juQwYr1JcI1DlvoVM9hEc1EdOE+xM0yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcmhKi5LhvkY2Zv031qWIBqI1pewzUohgQp0TwMEd6AuHp1WHPpRXKezNY0rzYApSY4D2ldwUE37Cjs8wnGR5XgALWdlxj/1Dd59mVtbS3+r9UGDBNgmK1W+DvIyiIa/FBKcb94wsQBr9NYD7xujUHnOJdXr5zf+QymvSNtwNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu8R2c8i; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5011af33774so837135e0c.3;
        Fri, 27 Sep 2024 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727465561; x=1728070361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fh5W2HEXCsiK+VCosBNxjg7EhZqBA4xPzqKSyJkN38=;
        b=lu8R2c8iGi9l7BKYukPCfMbPLymTz8gRwEpN6mvwalLcy0MORTK9vgZpxi3YPoEKL+
         5DBFSuM1sOeBVrFljhjNKhu9di0/ejZ1+6Wire6MniDatmlK4SRb/V0MRiD/6zYP4/fg
         /1vdfbn0SoUTUf9d+7sFGhT1/PWYuXuQOAYXYPX4DeGcdY9NEyvZGIf2InKREsL+pwua
         H7yxHubj265R9JM5GfIFXI2jX245R6mLZ5I/j6gbmD2QVQTvX+Zd+wltRQptdUD8Er5x
         7V09zH7nJdQLWPFEqMK3lPWzuLwhGz2XhwYbA7g+PuL40PW6zhw9nRdi9DqgFmtipFKX
         RPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727465561; x=1728070361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Fh5W2HEXCsiK+VCosBNxjg7EhZqBA4xPzqKSyJkN38=;
        b=Fx/zcE+mu44S35BRZZZXenGl8uv2Os3VAlrSwi40ybeoKP8O40jDqG7FOz77SBJz0N
         iNyMdEQxcYrOK6WAd+0Nev6v6qZRbV/sVI9ugzqtEyVkYAFUuM/fjoJVaUCJYpYCQ1UB
         j/P3+agU/7VqLn3iQ3CoFDs/6tvwOhm7O6UO507kuRix61nfJz1TgpDJF8xyySggVQQJ
         gpuMK8w08m3O2zasQmppAHNGxRHcXyFMpbOTr+d3pFqkxEJU8QGA6SOoCUr3Vy27WYLY
         4qzTItU/Cgl5+ocvIJImGxv0drY54JD/BMM2W4rW57m1EcVhJ9HqH6oUkoQSecR4CSai
         tgqg==
X-Forwarded-Encrypted: i=1; AJvYcCUYIJsTHbTBvKnq6unAsND2jVtoDo44UeMYForNcDp2ecCrDQcuG89i+0BnmpkujazDYZ0oCbMKppCg7dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Hw6uW1q1puERQCZ+XT6Vo7TTBr9dYTKVHwlQ1aeVhSr6kVV/
	6Ducyjc2+rmpzCZPSb1HCO7SmtvsS4IGBW/QBTHLc06eRnwILvjoUP4GttyU4JJmvABSokthP1f
	gX5LNc8ICpu3LVmVDvlTjPUwhLBw=
X-Google-Smtp-Source: AGHT+IGHZ+l6QU+gzzC1IXZtjjwytnJoq9ws5zJ8pdYCTCLJc6QsTyHwbnRwxqOdfxOjayJGcrRP/SA5C7mr9EE6eP4=
X-Received: by 2002:a05:6122:468d:b0:4fd:18e1:ab0b with SMTP id
 71dfb90a1353d-507816d9b26mr4035152e0c.4.1727465560926; Fri, 27 Sep 2024
 12:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121719.714627278@linuxfoundation.org>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 27 Sep 2024 12:32:29 -0700
Message-ID: <CAOMdWSKcb78TZvOk29tkk=yDn9it89wTWo4QERTJSTM0h_70Qw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.53-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

