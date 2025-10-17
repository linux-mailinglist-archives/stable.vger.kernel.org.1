Return-Path: <stable+bounces-187700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7195BEBB15
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3DB19A7640
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318CB264A76;
	Fri, 17 Oct 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="QuywydNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA8354AFA
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733088; cv=none; b=Zsq5Wt68uRP/KkyZlJMCsoxIVTKCOAgBre3a2KbIkmqAeRcUiM3qWFvAX9FQS4CM1GT1DDaBj5yFyWDw2F7hYeLbJiyt2VJ7Cl7KqW6AfyyKxxeBGjiprCjucWAHvIw9ipFJZ8DBr5pE1IgQrq/N9W5o5Y9eOq3zdTvuP3LovCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733088; c=relaxed/simple;
	bh=MKk7ulg8THfN6IMYxwH8fJ0oDGq7pR+r1xwzI/IoyqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS8Hr3iGCHSFyufjtwLbiwWOU/kW8lkOmxmShewOYrzmZFygnqH2eHpiUz44gIfCNKcV4uArQxxSNvhnNRaa/pkbLG9xuqfkMl7VbaakDuymLWJ2d95RA7HCL/RPbKIWul7f/ek3QcWvgbmU/MW4SvEqPmDZb2DEp3We4yvHNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=QuywydNj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78ea15d3489so27752956d6.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1760733085; x=1761337885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lPpXtKNC8Pcljol6lZmI6XFoGZEJXZUpwOt8AD0/Gk=;
        b=QuywydNjcm27vQc791n5AmY//nevEF1Kg5ym8e4hlgMfm3jZ7Xc8kCd6zGSOzwLHVl
         06B7afgDe/8nWP/DNfIlABHnfk4pNPlLfQvB1N6e68/0m/WaUR/ZQwzFKxvXvW5pJoB+
         54UcDNbuQ/yIc2EjV/W6UPTRX9mzCd6aPPtfYpJMXlel3UF3ZsX4N5LI1B056BZO6m98
         WCuUMsLOV3zMNEIVL4SJ++Hctj7bwHgXi0gPwIq/UvvXytrws5YKIBzvUX7UW320nRix
         CUu0HR4QwimBe2zGbInM08vqSgx7FgJm4B3NJWrGVqWVDj2lqwc+mHp+t8wiZftzTS61
         H8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733085; x=1761337885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lPpXtKNC8Pcljol6lZmI6XFoGZEJXZUpwOt8AD0/Gk=;
        b=v3n2Jl0OkZVMeH9GSCjTfVzBVqfo7Q99iOIRQOCjdybjLMyIUZe9L+xFpgFpeo++Ae
         frSp/zUTCkf2KFLcQZPrlwp/r/OfNmckEbbJniAei1s6HRmIsrFut2Jx2OtUGitjxlX0
         NBkWrTiG/L/clmlor2Xs+1YWeUb8tlHEH0pRAIvEaCJOvAGIGSyP7dmJG07lqv+SaIrN
         qaCV3N7rUfOGXarDJQstsG0fLwHey6tWpDFhIzesxq9ueVrLrt3+nR9wiD0fJy77G+6e
         R3WEkIvEwVFGV0ZXyrxynGqLpgz5i8nxN6SXckJ04GrP3r/i8Ih/Jldb04j8mwqHjgs8
         /ojA==
X-Gm-Message-State: AOJu0YygfEycL+m1L6KdsxPIDb4VQWJsqErCiOqJVWzJUagnYAaA9NQw
	knxitam2LkuyS6PvrT9oEX6kTNFWvT8Dc1PrPtvGtZIb8lC7V26G2R+hxFTQprh0OvXgQ+Lys9E
	vdP9JJjXemv3ZtIlSoLwP0gO/1+SH2Q/AXQHge+r7vg==
X-Gm-Gg: ASbGncvJnVMMAvKQSjSL3jAPD/wzuI2cGe2zi7Itu5b5V2bl/erboyN82Z+jhZD1vaw
	HCKATThdUiVjVOlPnmCBCg4rPHqY3+UgspXrUn6597ntdz2m+Z3fI2gwDkgSMfCEBViuRvyGaNn
	9XjBrJX1Ro4SMueglkBoZZ/HcDrtqt5HTRKWAQfbRrXz/o19yi1mrxplWP1ZZq7d0zCcOrfZzyR
	xsX/Ut8t1552uwngZEwDKt+jYcp5k/zbtyhbVH/LND0c6LrikanvVeWXNfwAw==
X-Google-Smtp-Source: AGHT+IGQFfaB9wOSLxDZqrYjsq7EvvuhGYx/LCDuuPQUSKlNN3GFBd2FmzvCC7AVAg1tdTIrtigxUrv4wdP7WpBC77c=
X-Received: by 2002:a05:6214:c64:b0:87c:a721:42f1 with SMTP id
 6a1803df08f44-87ca72143c0mr20321786d6.52.1760733085286; Fri, 17 Oct 2025
 13:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145147.138822285@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 17 Oct 2025 16:31:13 -0400
X-Gm-Features: AS18NWAWVvdm9jPTS1ddtyd-wd5oGJSWRBN2RKy5mD95QqYr0wV-qU9IWXqpvdI
Message-ID: <CAOBMUvgT47EEqCi9_np-Fx6j7dR9=RhqY_tsb7+gMYi7Jb05WA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.54-rc1.gz
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

