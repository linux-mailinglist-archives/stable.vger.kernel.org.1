Return-Path: <stable+bounces-172523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA3B323E3
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 23:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE51B6696F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E12C158B;
	Fri, 22 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="H73mXS3h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937420C023
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896460; cv=none; b=tsAwwgEqXvZZJFkEKqBRNh46ROCe8A6F3IIjQiyh8MJg3AitVk/Uft2xixbKMYkhc86xE0eH7jY5SRlIb6DRP6BqnN29IdvQ4tGFctMa+GcSLN7C2K1d6rgOtkxuwPq7mJKTTS7IDHPdRLXiaG3ahvC1kHBRm4El+SZGS+pcAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896460; c=relaxed/simple;
	bh=dc0BRlBhZJ6Pbxv14syasrosEBaUEOhVgP0tc9NoHLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1MUSo0qckhFDLddorffQC0JAEbZAavi8GGjdtMl/0NTcVTLLJjH2zGAr05idETTH8U40WU6XkbulMS6lai6WS5ocSXAkQQOYAg+P/mCc+LTfZEJrKlsYNQ5vv5Ud6ZoSgQlPxiVqnuE6JACeYVsLpUiuV80ukP1WMRthrcaXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=H73mXS3h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so1136109a12.1
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1755896458; x=1756501258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSm2pjQXpxCPM50Nuau91slBvEI2srYL3KvYFnBQXAo=;
        b=H73mXS3hop0KpzFO2a2dYccTVXmsA993jHRb7pisYjpLuEBUryJ3zwTQFdloihl47d
         X2zPJpqRsLEo2yBm3D9EFuQCsLjyHhyLZUS44z0+2W3/wFy5z1A25C3OX6prpwqIN+DS
         eJaX+X7tZVv1Fl7hkesviYXXHxZttjp0kd4XJMS4uQlBgRa2Zvc5GuPJiU9ox8jp00Of
         rDlSRSEJ6g9a1NjGzPqQznxa0f5cJCgf/33PLt25E6vKYg1ntMw3nXHx7AlSJmR6cSXW
         Irana3f1sBQU1vjOTbeuG9vkYqiyYCl8Qprk7MmxIFGV3qKgcazUJun64NP339uzOCd7
         +V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755896458; x=1756501258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSm2pjQXpxCPM50Nuau91slBvEI2srYL3KvYFnBQXAo=;
        b=nUXTW+bCFvvbQXOQEms5ygGtxzb4PiAsf5To7n1/PBB2U0NNdm9B4yhQd3HZzkGq45
         2t8yIbMu3H1s+IIyIwwMzjKnRjCwFrUeUGcjsE4qg7wQ0XhS9slkWLW+iecBNnyeedAn
         sdj8VXp8GPiST5DLy20j2KJZuQ2jKhBmn1F5ODFT0pzqBzqzhbHI/DYGNNVhQHqBq7cW
         KOcpitQZNaRlFnMbcm+cpWc79XIFqva6qwXf/zbqa+EbWqDgtEqS0EzLc70aeB2kR5kB
         qOCModqjJn2bu8Hu5IeNnj9H/XyaF1crF+I6p7mqgRLQqTmj0lrKuOzM8WRGQrREiP4W
         Xz7g==
X-Gm-Message-State: AOJu0YxcYHEYabf0ATHfABBAwP1eroi7wM4DeDomcOplnHOa6PbPfq6S
	fmwc3o7Mfr1HhJTWx39jzcSZFjomgIsJtS2/Q1ia9V9LiPA6Ud6uCNdHkQgmr9567F1eWJZuxg9
	ftRZ6/YUHMofMDkZJKcpN4v9caMTuc+UR/gOO/sWThQ==
X-Gm-Gg: ASbGnctH2D4SJYA5iHvmALXyVNSdgnj4ACszK2O4rJV47A2nC6vaEzKSJKAV6jy/zlL
	7aN207hAuB4shiY6aOW1h7yC98RzxcLwzqV4iMPgzQvMOj3xPbfgl9kL6uDSsfYnyHkccUMIYDt
	FW+9AIColyMU+I6vWOUu6LpygDnSRrrYhyBTl2OWfEUOfqpmKoZitRdJDBSJNEUWEAxPfthO9Tw
	DM2+Eo=
X-Google-Smtp-Source: AGHT+IEK4BjS16HtEyFxN/8dn0Ogc8AzIY+cgBAZsXdJAbzTtuUSyKBmNNJr870kG/3FIaY8i4pndkzgJyPfrJt6lxw=
X-Received: by 2002:a17:903:32cb:b0:245:f7b9:3895 with SMTP id
 d9443c01a7336-2462edc449emr66279955ad.12.1755896457518; Fri, 22 Aug 2025
 14:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822123516.780248736@linuxfoundation.org>
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 23 Aug 2025 06:00:41 +0900
X-Gm-Features: Ac12FXwOc1JOogbAORWWqhBQKksDiytp0VNRRIlI972IFt1EZD8UcTM1-UoNzCM
Message-ID: <CAKL4bV71GshkgN94LL55NCiDiXD-obrpzVoz4EkPRyP9paG-Lw@mail.gmail.com>
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
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

Hi Greg

On Fri, Aug 22, 2025 at 9:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Aug 2025 12:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.3-rc1rv-g3fb8628191b4
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Fri Aug 22 23:37:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

