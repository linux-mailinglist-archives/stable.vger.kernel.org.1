Return-Path: <stable+bounces-232564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEWlBIEYzGkeOQYAu9opvQ
	(envelope-from <stable+bounces-232564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:54:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4218370438
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 742A23042D09
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E383A542C;
	Tue, 31 Mar 2026 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8qNiudu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A73A4F27
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983273; cv=pass; b=T8mkI0Z9DbgAU7VT9nL4YLxiDKOp7fQ7ejxQi8Mq1KWJTBqE+3KPA+09CPldw3HDMWdGo1z8nE7OKpjc5SNc4g9KOlOUl+im8ur3iDd76J+NzsabfjWxd72yU8IMWO9F28HSRB2mllXMgnRou5YDQhNoMNdOhWHDgVmRKAnZ0Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983273; c=relaxed/simple;
	bh=uhzoRXxX78P/5kx2Ju13EGTvDLo7lvJcJD3Pm6rkk8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FelDJJGf5ms/TI4ixsMt5MEQHqyXYJET03jlXYVbFO0kfqOXBW0HG42UFYMOzz3nWd0DyNwtiqw1ro5ykb+MSyJ/g7c2/Nemk2pwcdsaHTpW5y42O9LFbz4zwlWJPi85Eo0ILxrvvSRQ8yla7agWoxIcMf+e1w4z3bL9g8DzfdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8qNiudu; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2a5236811so4933927e87.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774983270; cv=none;
        d=google.com; s=arc-20240605;
        b=GSSN/vFAf4b1e8+XppE7xM7knd3Vx3MMlS0xFSJUmp6Gg4fpbljtP5TlhtdqotoZ2G
         dtamAPqJ9I73is6xlwQZJqC1jG1cmaG+4GK22jfGLkBfLxNDLjKaLUBZLNmrS4M0fftc
         wYVwVAcqbiHEBF9vFiH9i6TBoQrNgOwTA+FlUBAZCAvFhw3OGBs7JKgMmYwXrNDStCVZ
         VgC+wyVt/1ZfIajoyrbAj70aOYbNdgXkzOdLt+27DKKnpjwY+xY42FAH24SKHyKqoCi5
         xyV83bVZHka92lYDY1IEH31xnbHNcUk8qSUsxkD0XMt1Qg/dYMUC8iGFY818FeqTkgiz
         GAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PelUNYlHA4etBcKLJ5LMDyufODvPTjPf2fovxktMXIU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=kKTex2v1QKmA2RiwRiHTOdL7IzpryFlN0U1Lo/CyjCHf6c/feAp8XQjacAXXSC2jds
         f2V+tAO99uX69fr8Zpcbaq4RxgXU3i3PbLHbVt0/atwmXi2qn1N8OWTCHigDEANS6wlF
         VxzMfvWmmY52UPTOsQ9Q2Ydse+0GsKbHPy3WjndHYiBCJW9pm4BSb3gAfPWbX+A9XQjd
         EdUUTvI/lW0W9cSJkycHXCVgDFA3lAdg9Ed3C5D02GToofntP+5u/0S04ayMHqGr8IWT
         dOZ8qZSv14b5D9Mgj7JRVRU1F7KsHQXwwiJlUTI3JsMoDB/syErnTj50FMcxwm9szdoZ
         s78g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774983270; x=1775588070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PelUNYlHA4etBcKLJ5LMDyufODvPTjPf2fovxktMXIU=;
        b=U8qNiuduJd6Iuu/fIttMLHkP44OV+ro/9Lzc/Z6dRKos5Hs8EoA5D/gDg+FZZh7YYa
         YH2ldCSNfqqSG32xPiK8Utat+NCmdTdtSHQSt52VKEpA+CPyWT1h68M1vH3eJeom5L2I
         DRqbcWzV8dn2HWGQCKVnNomS+MfDdq9ItoSw4s3L5DcvfjlNc2FSsZUu4HTNLgqDnQwT
         APpDaDrhu7k5Hc2DzLzFyHXVnDObtP7J3UI4eukMD1oFqbFn7iRAwLwZ86hns6E7aZ5H
         RufVcWZBrxZLrL6kgkaP7oQbsm1MqLsanVIpStxQIdSjpRBbkAstzeaoRBCyVvjtC6jA
         AtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983270; x=1775588070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PelUNYlHA4etBcKLJ5LMDyufODvPTjPf2fovxktMXIU=;
        b=kDMoeAIy6eJ5mULkeUWXfJ7CRJ/v+eh+jNStgT827tr1ZDoOisos4K9MNmOjKONdu3
         WJYEdNRXbafjn0SqMiIwYiNYsCix6kfQd0jHaK3ynss+/5tGCEnfkongvvh2/sRzI5Fj
         wgwb744hJ+9PrPU42DjNxhE9HN/aPED7tSRPx/AAxIOIcQ86G/KEXPqIdOVShGfFXD9b
         kEQqqlPpy+kSSYOoxCNG0hx/o57dTZSXeNBcNT0hjSBOBbW5zPbGVjuc2kh8N677vRWL
         8FKj5Sq91nxV2v+FxWxsY+OUA1LW3ypd05ZssZiSf73D+Wb4/bvdRamXgSPCIWeaWiyI
         B0Wg==
X-Gm-Message-State: AOJu0Yy+ch9K1k4yTl+YWINFR4ZsyYHmnjj/eNbSr2B+rQWB6SP7z83J
	dqnbItx1SR0lqabpMqi9bfjpPtqlu+jQFKfoOUpeeXHXMs8xVqR1e1F7VQCBVeSWWqJlVRmJrXe
	P4qBCLwlXrTZRrGB1xAZ8PgysalcMYak=
X-Gm-Gg: ATEYQzxh3dajweh6RHTUxIu72mqC8xdEn1tyq4LHaTPOxBOdV4nqlccae3cB5INJh5V
	mVo48xgvblq5eA9oyIOrQ5+9Yx5SlhD0YKUSG7oJ97D09nkpZJWCKCc1h+sGm4yjY1dyo0qaN5E
	HWJppxuruy4YGDI84V3cDlyGqhxaJKdg6lFDq1taNTPZTYPrO88YNjO2jz1wcST+g5oxfhyXpXw
	Gp8XCto6X03b0MlYA/AvMt9vjbnO4D7abNtdqM8xwCC4Yi+3S+uUwMEj4mV3G2IewlDu+5mZ6g0
	9+gu6W3arDFxzM50ceYoVQNvN7cwwwlG9t9A5oPwQw==
X-Received: by 2002:a05:6512:308b:b0:5a1:351f:8650 with SMTP id
 2adb3069b0e04-5a2c1eec64fmr165899e87.8.1774983269524; Tue, 31 Mar 2026
 11:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161753.468533260@linuxfoundation.org>
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 1 Apr 2026 00:24:16 +0530
X-Gm-Features: AQROBzBNIKLKEZtwNjxuWXV3qWqroAIDJd6GWuT8KNKRw9dfUwXw5HuACN9i8HY
Message-ID: <CAC-m1roDY60qEnS1ciy_93yE_BBKNy1w5=kdgO8h1kW-T1X1_w@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232564-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: B4218370438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:33=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.18.21-rc1

Build and boot testing was performed on version 6.18.21-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.18.21-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 489a397a6e94bf636650e210b0ed749a3cdf1e9f

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

