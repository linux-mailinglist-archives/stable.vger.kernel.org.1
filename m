Return-Path: <stable+bounces-240375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLdMImYK6WkKTgIAu9opvQ
	(envelope-from <stable+bounces-240375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B7F4496F1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E28543009F3E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AF39182A;
	Wed, 22 Apr 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbMEWWIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746E3909B8
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880131; cv=pass; b=tnWl9LuSeLyPwQ8Zz+51AqSm4Js3vSWZoDpk/dLwphI/AiodlwjmqJW9X6ntTqxXk5ZflPQu3s+kC4ik0CxCV0+IeYm59d/9+ZZvbunZ3ByfmTGyiPd6ePHjBSHUONnFyw8A9muMzXYBPxHqy/RLmPxLgBtYXH9e56NPG2PlU+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880131; c=relaxed/simple;
	bh=qon7y6o9zTnB/Xx99TUqlH+uNjnbrTNWb007t17VXAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8bjbo63F609wVGRIWQRIlnv0pGINeTuwN3HQNvgOg3Q1QXPul7FRiw7fDO1FUZ4l5/24wtOm4LDUfGgS/VzqTbqRjL3JkxjNCyqG6Zejj3cD9nhuEPM/GmDmY3lx7WOrX+aKH84myGP1zCtBFn2h4w1rPc3//DA0zxAx2FB650=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbMEWWIr; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso2915817e87.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776880128; cv=none;
        d=google.com; s=arc-20240605;
        b=S0z77kqtklwDQ7p/jAnFCJGhTzRAc5a88MXzJgN2O0xnMGhwcFxaI9a+JBnAoZ66+z
         liKHVqo02bGOBGfXHhrfvSATVbycuVQiT/Y9/VamgLIqXMcAOjYfxBA03nNPGgpcH54e
         IHTjqKko9bFSZvISU3qt20YIzTr+tPC099R82uu1mUUmnkGdrilZ3jVzPCSl6sw6WEFa
         Wrv8BUSGWN/CVoYcQqjRsefuqfmnxMwQAfb9w9ffh4mNMoyNDcNOoRqc/JXPWyIu40BJ
         K7yrFcydLB2Yk8CrEQCIaEIeV8vuTdQiiFcppj2vTlzu6xXoEDN3gIr2RWgUmvQ/KhKa
         hCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzy81VImjVVpgnx2EjGyMDO4d342RAyW8Y30pwd644s=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=K7Gid8ltTjF6Df30V2YYMg2vL/go5s4iNcilp9e9HZLHh7gwlUg2clfyGOYjvAGOdJ
         M2vazAYhi2e8zClHTNNBsfd8zvveHcR2gJhVGyZIRN29judSYenohEIprfj02C/IFPj1
         Z4RS3rqDgxWs5BD+euZeGPyypCCBgQfReLZtpa6XvNxOwPg5wsMUSX5FH4tYpLSCZJKh
         vr90zeJyivWdWfXpOmoRQ3fUaWbcjezfeoWczIzlq+4cdp5HUxy/SsxYUY6pvCuo6qyt
         1a6GUJBC5vaKpKSHFJPQz2M8mpoup8m6ssqU+5q9MuXJASPRqep4b+CZkmnKAL9Ns201
         z0rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880128; x=1777484928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzy81VImjVVpgnx2EjGyMDO4d342RAyW8Y30pwd644s=;
        b=sbMEWWIrqCmvrCQlXVlnrCFiuOJdMnctEyBExAfxxXx9lzLWS4ckhXL044c1uMLQtt
         AF3pjdw5vBEpKc3dPqkuL9+Kei7TvDNtmHQ5Oonh8MUxfJY/EFsKWioG7ZfzMgGGiBEM
         XL8YpyB7QX8pr4WUOUh7fjFQYuduuz5u+ijmxnGZgokrt4X/v+fGA77XEVNYPsyWA83J
         ttjA0rZEyDW7rYpUPOfH733MWmcsjm+Sr/DiMDbg48t2OHLpvqUc14znF+5bbyB2MCxD
         +jzoZBiWkbMBWz5zqsE1LautQeb33g/VpXJfo+9iQRR8KLjRCt49BDbegw0MIr+f7B+2
         t0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880128; x=1777484928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzy81VImjVVpgnx2EjGyMDO4d342RAyW8Y30pwd644s=;
        b=OHeJ4mRlSQUAbObWtYei8mNpyolS225XlqJaefu7Lk7mMG9Rs45/I+/VfEI9WAzVcP
         tUDrcn5e0gXL2Cs4KRzxT5rv2MrxKqotu2SGlYs6p92gemkUFelKWRyE99NVJbJHLNmA
         RHespSBZY1IVpgyeVJf8MkhY00J5CPg7FrXeXez64N5sLciSdXpDfQMOE5UqX3RJHzTm
         6hB/ghNaEQgqhF+5m5nf7AYBznn8MzVQaPmmBSAJja2gI7DmYmNhUfvkWQq0UYWcjnQG
         JWhFrRDau7SZwsetULwktKHkA0V5cZth/svQHMVZ+KYp61o68hPSfPwS4jnFQiTO5YQi
         KEIA==
X-Gm-Message-State: AOJu0YyB+JVuP75XxrMoG5le8SAUxlLARiDpLK1BmQD9YwlUNpQDNQVC
	AuanRtGjR4f2Um60irFVZumlB92kfMhIxxeHW0abIHaXBGRlLNXUcLGgNlTDYGyYcVXI7S7n7ua
	w1/Omg3rWJ9HAKsp6BkL2wnbsxhpXlc8=
X-Gm-Gg: AeBDietYmL5ISvFKzBp69rHV9EVMrquGrmWUKD6ZKZtA+Q7ThzNLvG5RT28QljXHCl+
	cd8jy8Vp820lHitWedGN2Fr5OMcrotJH4dFRMcRqDI8wVKz2Be5d3ue/9IcMCoT4zzndCiF6V0Z
	lQ/wlUTBEfu8wJcx92Zhbz+EWpZGjh3GqXuK08gtzHPwZG4wdTsmk6moDSTZ6kkZyppKrS1PH4l
	FZ4LJjiQegqRu2ctnvCQQNpLmb+02J9hZ1XJ8CQmFk/Ru6KgSGCBuisurvp/20Auuk4md40OM7C
	QkRPUnjYld0pK2EQNB2O7zn17QtZxsNNpcUBJ97WewZU/b1nAmHkBwcQRYEt
X-Received: by 2002:a05:6512:3e05:b0:5a2:c0d9:4e95 with SMTP id
 2adb3069b0e04-5a417303620mr7782695e87.39.1776880127780; Wed, 22 Apr 2026
 10:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153934.013228280@linuxfoundation.org>
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 22 Apr 2026 23:18:35 +0530
X-Gm-Features: AQROBzBf9c1uXFX2JRLrU-CAhd3tpip7zBxRUwVFK1FS2T-mKKlIpYYYyDXQrFA
Message-ID: <CAC-m1rrppB60zSoh=EKCv75oOOJ7RGRG1eauJ0AAFjFXH2usww@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240375-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 27B7F4496F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 10:57=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Apr 2026 15:38:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report  6.19.14-rc1

I built and tested Linux kernel version 6.19.14 using the default configura=
tions
on both x86_64 and arm64 architectures in a virtualized environment.

The kernel compiled successfully on both architectures and booted
without issues.
I did not observe any regressions or new warnings in dmesg during boot.

Kernel version: 6.19.14-rc1
Configurations tested: x86_64_defconfig, defconfig
Architectures tested: x86_64, arm64
Kernel source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: d5ff99d1ccf4eb2e2288c5126f1f846a8ed7e4ab

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

