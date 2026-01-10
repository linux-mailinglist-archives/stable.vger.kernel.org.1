Return-Path: <stable+bounces-207935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA517D0CF00
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 05:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C3530443F9
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E5430FC38;
	Sat, 10 Jan 2026 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="b4/VfO5v"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041A30F818
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768018655; cv=none; b=bf1H7n4IBUVy0Q+h2AJQyACf89B4yqaOciZf7sNebRaXqinCHcTIY2XEWnKD1wNAxVfb3xnZDVQfgEVQ9MRS8MCeqzCClhvuUEDnPNtAmSSpknlfFC++CBYlwzDJZBeeMynbwazb/HwuoYBLkJjEScXRWe0RiOCq9r18wQoGtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768018655; c=relaxed/simple;
	bh=LqEqwy4aYJ+m9rHhduPN6Jq482KPgrrgIwreWb02Pr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIwCzl2FShi822SmJ0PPYf4YTt++hy5T4Brde79dH7VsWI+/WqhuK4Fwm6RA+HbSbYdojafiJa1XsM2Hjkhs9ecC8167pLid0MfEYTtMstNDZnuIfGTMhNGzl+TahEseRWLgphGAhJ7Q9V7tbwh3kLxyyAs1UWa8CFCEuUC0L34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=b4/VfO5v; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121b14efeb8so9212c88.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 20:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1768018650; x=1768623450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dh2OquB7Pq1kZTNXr9NcspR1edcu7JzdBOuViZn/Hgo=;
        b=b4/VfO5vgFDyac8z52bOUPE9TgWVQhvyIkFLJ9paRip4arewXClbw/URtMUBskoy0j
         NPaOL2F8H/KgTyVXZJIJ454imHogt/lSgbK3YaO43FH2oj/V4aekwrYX1PQSskyuq21E
         Vaz/KhIaucyEnNOizjuySHvxte72A0R/YxBvvf1/Ck4fxCHW/xS9PyAAseZ7YwA7IcR2
         neuEPpR0KaNwb54AnUa5HMeXNXrzj51huMA41TuCiDumDHdqAR6Sc+gcrQ8mTfbSL5Gh
         fcCKWlFCMYL1IzVIznk0kcGi92S9kB07KGyE9+l0e19mKJ8OlLrY5wLKnIUhgBxkWQyW
         rI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768018650; x=1768623450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dh2OquB7Pq1kZTNXr9NcspR1edcu7JzdBOuViZn/Hgo=;
        b=AFU+HVLUGGObCgrCBEiln8cglDAUeE4EE+qhIfAd543Yx4Dtgxox85C2+t/kyMW8rK
         cUfjM+lxkA2s50N8SMMtfOqxuQp3n4zyV0ps3ctFjSS/9OCPohFiRfGCzpXn4Js9hCub
         Yd1a0CCZRQbaQWzgP++UOAqEI249nI5kSer6wdM/cJrwz6gGLzS+8TDmR/fQsnGbIdpa
         aXkpkUSc5YS1kiWgGVsTVmQUl4NlVN3xH8FKXh3oaSss6ZvgtPZ94UktUR65nJ4kD6p9
         j+uUieHu10tTyvnw7eL/toauOwP8w53h4qXBtsaJ+hIxWBcFvbLKYFo+yp/KJqVPFtm7
         IBaQ==
X-Gm-Message-State: AOJu0Ywfbg8iZZO4wJf5J9MwFYpCqL2EIPV76GyE0zqg3ZgMfFvXewUu
	5lh+pm8qb4tn5xugy7I9L95vbh03kI4acDFRs9djO86zt1AYaia+gfLrE2asnvh2A7KSG9ZvRGB
	w1G38MCvhsEORqOYr3x0tjjnpi88hAEVIMvlhdDVaSA==
X-Gm-Gg: AY/fxX7Vnhe0oHGQWBpRcnQ/gqK+aRpCg/1nc2Ad7nUjPNsY1Iq5hKK42jSsiLihIyg
	Jh/N2cR6RcpAiuwlUf2LGf6l1nzIDfQoLGpagRzZb6BZqQwcqSPfFMfd8Awt2o3apeIHLtnqYdT
	D4LL1CHZl9ep12skIgFRPDXar0L9EKpAap2atqbyjYzmodRPHoe7X0iLKI+fgulmVDRA+p45fSB
	3mUDyASczWVfYJQE5zAPmvjP6KbUSELrQT98mV4Vbw1+BULoGmyimQmkSXXLLsR/l5ACejaf6fN
	3Hok9k2UFP8P4qfPagjTdFz+kPWq
X-Google-Smtp-Source: AGHT+IGj9pU86yxA0M3nrZTMkJSMtKVtfwL/Ogi6h9a2zNpo8JEukF4GypelqJnxHaNf08IB9z9MvzLUpu3QuhnJbLA=
X-Received: by 2002:a05:7022:50b:b0:119:e56b:957b with SMTP id
 a92af1059eb24-121f8a36e0emr12367971c88.0.1768018650378; Fri, 09 Jan 2026
 20:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111950.344681501@linuxfoundation.org>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 10 Jan 2026 13:17:14 +0900
X-Gm-Features: AQt7F2rb2eU_-W6u_EfdQS0ZCBoLoEmBbmpTsnW0RTxfllIeDKP4GSYHWOrtc_U
Message-ID: <CAKL4bV4tHADyXFwCQVj2fo_SaLcw7ttvb4+hScwuC9mMqsBahw@mail.gmail.com>
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Jan 9, 2026 at 8:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.5-rc1rv-gc4b74ed06255
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Sat Jan 10 12:00:35 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

