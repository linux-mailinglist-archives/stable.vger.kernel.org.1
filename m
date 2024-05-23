Return-Path: <stable+bounces-46007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D008CDC10
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72CB1C23152
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791D12AAC5;
	Thu, 23 May 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="MprRWTDA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D329128829
	for <stable@vger.kernel.org>; Thu, 23 May 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499550; cv=none; b=GKw1aceKvOcSLIzYBUMfxQxh+zDrx2xHoM7UyB2ZIhr0iltq+bsGv4RtHBK28T6ivRNcCzFr2MzAaKkE+AQ4qA+5mBLEQUTUcosBBN9wE6kGC+Jiel/vQZ/R2xzVut/PMyNdE0KZ7RfX42uGYWucdUPwFwOmmcKLL+NhN9M2UqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499550; c=relaxed/simple;
	bh=mA56a74E5OZmSdOaOCgWbEvISew1H7eTgdBTvcFAbwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWhH3GSh1Y8tslzkCSBAIh8bz40I8fzn71GxOfyPso0a65f08aPaX1Z0xoXgRFtrWFyIf/np9Q8ZVsW8oFoUHK/SZS1+EEIpkaV9AFQ6IGdT0hx4DAKjI6e/J86le+rIrKG9AmLKug1KK5jFWFZZfjOek0/YI1elMLfbeI2Y+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=MprRWTDA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-65c5a29f7f0so3438058a12.1
        for <stable@vger.kernel.org>; Thu, 23 May 2024 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1716499548; x=1717104348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjzBFWQGRJlE51441adpXea9AFvlQa7Gmc9nBZzhGfo=;
        b=MprRWTDAPXYNnFxpDmxH/vINTQVVX/huSxwQJrYdhOkevbf0ctkBeplveKsfmxeuNL
         ltqerCBZqkto+jZtQUBDSr9yYPweINnMYabgdgSlzDyjLP+FReuospCgScsJK27Lwb1P
         aiwtxs9urZZ2IWKVPrPUQHS7EJUxS8eybbBxCYmpvJxueHgMqUe+Gsag5H85927XJoQA
         E+aXzZ3Lk1Ae4fLlZMP8RAnofIEIWeR3M2WGubmdfbaKfZGFRzXcrKzi48s6raRZxCuz
         yL37z8Vd6wr0eddG5iyI5Z0DYTwAr2mlVnJ5htRaLdvXaGqEIF/nE5PduNE0Y98Dnska
         wIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499548; x=1717104348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjzBFWQGRJlE51441adpXea9AFvlQa7Gmc9nBZzhGfo=;
        b=lDZU1cbBPRh3Y14+BnLsbOenL6bX5TppfWQHnm/ICbaBc32LOC0IhcI7ic7/TlDnGr
         ijyT3UyTE6FKHJUv7bx/GbBGA1gqLvuaUihkZGz7pUgssKuFyCVQP2O4pQyD0Fkdyqm0
         QNvurtWKmEerTeI9ZCd6QBXj7YM8w/qyld840t9qsbv2l4QFTluSUIjepkxP/CwNjxqS
         S8RYK4vzqMmbR6PmfePA3s58QDmXSWwlWr1P7CZ/M4BKZGT79WohOeYdo1tynRpCQ55A
         9QQ1Pcs2ucZK7/PJcNaYX9MYWL4QNLockZdUJYQd2kubhacH7UrNrq4JJCm/chaLslN0
         U4Ag==
X-Gm-Message-State: AOJu0YwUtCS6mX7h+Heg3kF5qvZa6HTPW2yIO69i9jeSCDUaDqP5uejB
	TqtpqLos6SyBIDuAC5YCu3OxtmrN3JYhtrxcdNwauvljARBqXc03Lr5V227k7uv1By1Hywm8tph
	iUqthw5o/3M1WEJyM5PDsrONfeFbyvmItm1AZCw==
X-Google-Smtp-Source: AGHT+IEX+DzZqu1f51+157hrrpiCAPisWutwsfM8ZJUQxeRwW/N02+rxbBX6wwe/PUiCT1AAM7TddJlgzw8uQAoAlu8=
X-Received: by 2002:a17:90a:fa92:b0:2bd:efad:88d with SMTP id
 98e67ed59e1d1-2bf5f1077d8mr352514a91.28.1716499547473; Thu, 23 May 2024
 14:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130342.462912131@linuxfoundation.org>
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 24 May 2024 06:25:35 +0900
Message-ID: <CAKL4bV6ip-D-5rOuiZoWPS1w1Oi-Y48TfMtO+qGiVgnu612r9g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/102] 6.6.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Thu, May 23, 2024 at 10:23=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.32 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.32-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.32-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.32-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240522, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Fri May 24 05:32:27 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

