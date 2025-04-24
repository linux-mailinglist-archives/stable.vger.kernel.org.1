Return-Path: <stable+bounces-136573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBAA9ADA2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A551189F788
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040627B4E3;
	Thu, 24 Apr 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="bnZx/hXq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DD27A931
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498279; cv=none; b=T8/VAkHWky9MXyxUOZXzGkHArFSwWqpCoQ28nHRIZ4NhNlNpUGsC7Z51SsiFIyc8tloUX8DbPwPExxVDELrpwBXqsVwLj7WqFO/4pij/NucU7BX74K3sj0YXpy+8XAoA1QwD7mKO+kGCMZ+43JerNe1Odsz9/GuUMOqlowQPjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498279; c=relaxed/simple;
	bh=y6xwBroK6Cw33bDi3/bZVR2AEIsdxRcF2bY256Tok1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQ2umeAeT8xWDI4Z/qKdsbnL95jB/vJoi0ptjbtAyceECLnjhATNVbfUUR/FLT2KXaqxaGUvgMaJYV+tmtQIyZDBKbGn2qekJpGH+0Pw7non3H06EZPfEAhJVOqjnwN7uR76hBsrrSkJAwBkZ4BhxVbcm1rPJR/qfX7K5NS+aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=bnZx/hXq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30863b48553so1907697a91.0
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1745498277; x=1746103077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZpWL/S+NSRUlk5wqUBhROOnOk/3l0ze67ok0V8c+5I=;
        b=bnZx/hXq9gufBDxFRSjWWlE8eXGiDjYZkH/Ld19kan4qYmTI7pU0XWIzsVWHjyPHyL
         +53YM5Se7ERnCws1NgbmtFvSH55a5K0pJm2z/N2HsRRHnziyXtBRRhX4+iuLEgIB1vUT
         FbF4lRFx7DiI6XVBriy7KJ6raavuEr0/ysnG8+zEkl8LYe9GKpWzAJmtdlH+YnuACnVU
         hF1Qn/JtzEZI0TnxKWTDdY4KoBDD5uH4mZYrWg2d3Sz3wxgwvrtv2Otm7d/O9TpBLYRg
         1Ah9vrtcDdBQ/lU3m2T67pw6s6ZbkFSdd5j9eW5UCFkJ1Cgva2Ln03dn5lpXGdFq/aHP
         RAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498277; x=1746103077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZpWL/S+NSRUlk5wqUBhROOnOk/3l0ze67ok0V8c+5I=;
        b=siGhziK/elfW4hFq+JZFdRCBfNbw6SnT5vTc1xURK01dTZEIx4t4hAPPdnKBgfXhuR
         If4vWuRCskeC75cDKRE69j/GlK+i+2/F/KR5WcG6DRonaP8PhJDcZB4BdHcm5N3t3g7z
         xZouV4j27H9nT+bal+qvdhIyVR4WxQp0da7EvHoYmWfVTSpJWIsyY/GZj0A4qi0kXIUh
         Z56AqX3ib3M59Ov/4oHnAvQsAvF7lra4YsjXWvb88SQ/ljyQnBkbFsC3mA+RHD19EH39
         BYKKdyO4W5RsrTWCphm+3UlO16Y9u2+sVrBUSTMFosSj/bZCopwNtY3cCof0H0GLY/Ed
         tw0A==
X-Gm-Message-State: AOJu0YxLzlXwnOtgShImL/smDG/mZPmAumdrMZO3YJWCOEvH4e367T0l
	EPFhhSROo1tCLptL+l1yIpmAbZjKMoj/FAh7VIyWH9I5dy9z+UtHQiWUPg5FUYCzx6psZcrDWCz
	C2FYdJMjftDjcqBktEvm67WE3yINPNgORs3rezw==
X-Gm-Gg: ASbGncshVNG/ufC3mYtoeSKpbcPT6ZVYsJZE11KC4XNh2jYED8XwLjJ5TrXVkqLTd0V
	2k/onrqT0GtiWlkBXAf7m0RXR9X0C4bEVOf2kPsxWrAmPdZEYfl2T1tRsE4Ow2B4yRLo0izegu5
	h5SmYVznBI6ENlUQ+YDXc9jGY3CAzqYAuz
X-Google-Smtp-Source: AGHT+IFZiMB6j3ycGd0+0mt1gFr0C5pjE8ZeKmh2QCQ+qpdXY6INn1eOuR8jJhehu9q6wu/xF32MCcHREH5Z2qVs7zo=
X-Received: by 2002:a17:90b:28cf:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-309ee37b4f8mr3286435a91.6.1745498277298; Thu, 24 Apr 2025
 05:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423142620.525425242@linuxfoundation.org>
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 24 Apr 2025 21:37:40 +0900
X-Gm-Features: ATxdqUG7SveaxlChrXmWKmEOOPp12zjRNih3IrQJPBkjwP-JegqpOJKeUEoj8_k
Message-ID: <CAKL4bV4AZY_8WmQv25XC5EiuRzTS4gfCoo_DDq0evfFkMmHZqQ@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/241] 6.14.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Apr 23, 2025 at 11:47=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.4 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.4-rc1rv-g86c135e93323
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Apr 24 21:12:13 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

