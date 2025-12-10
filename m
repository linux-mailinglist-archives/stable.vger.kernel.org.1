Return-Path: <stable+bounces-200748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02709CB4062
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 22:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C89303751B
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 21:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61A2C0F62;
	Wed, 10 Dec 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNqmbYwG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533A1A23A4
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400553; cv=none; b=fEuyAigpMA6vUmbw9+ebhV+YEdiWKhpfp8aAhuBLu+1JoCTagazXrfkwUbEIKA+auGcEKt+S7M3wMWWZsJiXdd6ocLq402N/N1K4AiWwofiwBCULFcp60vijgPHByz8LZ6jkP4stnOVXEkFgRUbAB0C86iqdHBBzyjQ/W8k9RAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400553; c=relaxed/simple;
	bh=bnsj608qcKuRX7D9T0qi0UTR0898IU4h+H1WOag+sD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJT5oI633uz07t1qFeM3UGQFo63aX4W63IgNTdllN18APMjVP/OQ+YJbeF4wywN4VWmdXtitIa6sK0zVg6yTCqA4qnjOBnIAQ4csgCxi9gIHksQwgdAf2KxAKB9yHNquUl+mVbOE9LvlEaRPrlaHrJaCeSly3QnQUI/O/+olG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNqmbYwG; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5957db5bdedso170144e87.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765400548; x=1766005348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haIYg7KE0egTD4YFbfAK5E8Ks8h25fX2CGf27BHTDnU=;
        b=fNqmbYwGwnfImN2vgmneuB4fGFdnhC3Wp4CWBsob9rfll9HQZQP+Pk1il82mSupXQo
         9HdyZ0lwuNEsjDElV8BYQ03iVpJY01z0BJRXZTqGaswJb1A6vWUlpiB8l3AE7ZZk2CVy
         2LBcBvL4YWS4JZiGLcXXxHsxLEJoiNOsXf+EgrYIh73b9/T9S7r0MNnP4MJwcFftv5a6
         IZi166M+qfZq7B9kCBsqoCubdQnKyE34AgMhrZmuOiNoawBKlqmsB/zY+LGlxgshWC4n
         tJiuT/l3V2paQKSEdNWhe+qNxFjK6kWxT5G0rn/A3ywjbsv+qD7B+4RsHg+kUNVQiCkJ
         7ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765400548; x=1766005348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haIYg7KE0egTD4YFbfAK5E8Ks8h25fX2CGf27BHTDnU=;
        b=A5P/MZzRE9j/4SwD0yicRGVVP8FlN3rGASZxW68U9XVaJBM1SSyQzyG3zPV+5UKcpO
         wwItOns8W2huQQJ2zDhGpJEROUVZxkbpbTui6njFHUbH8VqOjjjZfaQlF1BbtzjUApFu
         0uuKo7XeNsn7FvkxlCslfZ8JafF65zuUPl0ma/Brn8RZCxLam1aSlapii6kR5345aWuC
         sGhYxyyuWcZScSlbET1Hz4tgL3QBSmVo5Lh+UC5jNI7petotxzvlLdyjxo+MmXo0NX/z
         ceRRhtdhWhe4JUGnIUELqQPSZqa3iUnZfQU98gIl9/Qt0BzyO1ArCyMuc/Na3Lw3gl1O
         C+NA==
X-Forwarded-Encrypted: i=1; AJvYcCUAnWCdTiMu3fVzDJX6lGoCpRqOpuBDlBa9Z+N/Z07IqWsjXmCsDoWomUpIroBVzW2PvYKgLOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvNh/KooAVFaLFdQx46S6KJuXuHPPGwxBsbuwXJTCWCPsv1vL
	l8OKSYxgynCnLIzpQKtiUsvdbjMtCIM2vJGTt46Tb1soQv3x+/v3lN9LtMZT2Ee/oOJmMlJjPFa
	t2s0gP5jMj4eiYjwe77frTkMjNCGY0lg=
X-Gm-Gg: AY/fxX7I6/faTDAOG6lhXFgK8tzLiWRW2rWoS6RQOkYlGukgjpKPx+iLtgANE+teQLJ
	Bztk3cLFISwgUhv0U7ee6RTPr5LK9NWf4I3kePZ0RxB3X/ia+j+4c0vO8r1S749DF0jVGVH47fG
	Ld4XnZrnL7pLE7N2kBRk0FWgH+g+Akn7xujC/ptBvL2e1kOZTJR7O+q8WUBJRqIl42HsMS1nP61
	kgC3eIEXruvc8pWnxMGZEG8/nParfQbgrNPz6iIeMwSKZCCZHtwRTxLhTl1s2gPrkt/mYAGOA==
X-Google-Smtp-Source: AGHT+IEAEguLLqdu/ojq5/wCiMInqb+jeMis84tJ3BDJ0H2ZwTI5Dd/msvltOu1A3dIMoe7uh+Qrn8LlFfLm6WanlFU=
X-Received: by 2002:a05:6512:e93:b0:590:6119:6b73 with SMTP id
 2adb3069b0e04-598ee50c38fmr1344362e87.48.1765400548093; Wed, 10 Dec 2025
 13:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072944.363788552@linuxfoundation.org> <4b1a256f-5d1d-489a-9c87-c38b4465a6bc@gmail.com>
In-Reply-To: <4b1a256f-5d1d-489a-9c87-c38b4465a6bc@gmail.com>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 11 Dec 2025 02:32:16 +0530
X-Gm-Features: AQt7F2qSIeNouKnAegFy2IqN363aZRc74HdkUV6qpoU_1C2Uw8csLLOY6YM4mSE
Message-ID: <CAC-m1rrLzwywf+6t31kJdfBXuz1fvu4PtyLA=G8V-+qh7RZRMw@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 1:12=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 12/9/25 23:30, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.18.1 release.
> > There are 29 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 12 Dec 2025 07:29:36 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.1-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

Build and Boot Report for 6.18.1-rc1

The kernel version 6.18.1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.18.1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 7d4c06f4000feb509a90ba5eeb00be9839decb91

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

