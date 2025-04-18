Return-Path: <stable+bounces-134592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CC9A93803
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2667A70AF
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805927815B;
	Fri, 18 Apr 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="hGgktBRD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2227815E
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983359; cv=none; b=N1/nTkEibZRHgGIRgN98QPuli6fdqmOnC3/P/i/coiXBTQZpuhhp7nrT1bu8f8eo12rPsSp7Gqe+JMoURUnTuAYOiCixzUa/Sm1ouxB48aezbk/I/lFnIii/9KrR1kOlhvhDcEMhAhqn2+82Txz1ha5l1KcFy+6UqEq+0MfZyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983359; c=relaxed/simple;
	bh=3QDmuHmDcXII7yvPfaVTp22nIGOY70Z6X9jLpFJwTO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaQiZpOgz4rmgA5XV4EQv2RM8tWbqrPriXLRj0/pHmL+E/p8Ouv4ZVQHh+z74dW1rcSxj0DpjnhPtqV5NE24o3bxbVnGCD2wt+KnbWXMY42dwzkhZg9xRZibmLJzPrLYrdFrpXnmndudktc97z2XhGHsCXdsSD7AXp5N4zCtyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=hGgktBRD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so1920779a91.2
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1744983357; x=1745588157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r45gHrvj+34dC5NFe9TWN4ATAYJOPM9aWOmtX/SbRpY=;
        b=hGgktBRD2vmeOLaA3oth3cvF7TbCSOs7JAxu2HjU462I0BGYBrTy7O301iHn9xv0zu
         aiYPUCeJcHWQrK2B6omu8MzAwnZdEJsCZFOQmPsiIHKdD987X8bkeM1am2Rrh4yBEWT+
         Z+TA/HClK4F7+FrwftxDd8JS36XHUwsQQxBEnW3PZ3IaLiZ8oVd4hpYBh8nO5JY+yLAa
         7klMWnRuWzHQpfcIibMThN4EKsMy1pgyQIpt2jm1/+BJ4vev2fkhZWaM7hDiAs5ZcrXm
         CQqt/g9kdFHsyNKJTeudJ6TtFC7k03i7mlsoynal+2t7SL7WnePSJTkpJrXC8VPEhoKM
         9Lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983357; x=1745588157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r45gHrvj+34dC5NFe9TWN4ATAYJOPM9aWOmtX/SbRpY=;
        b=MNB+FYMmIg3aWCozLHhUPIaVr9UaLO7/4IIFkUNa5/8hxQoaBnYmxIfPOwut/IjziV
         BSCZk1ggP9VzrjAD6YJO+NGnaidMtTkBs1eVDWiygOl98P2SIxgc0ZjZU2+7GfEUtoWE
         ytCOf3LCIAw2OnMylBLNYjDfQXowYKmu7k1nV7EWoQHq4FlN4mX8AU+2AvhLaiBVU4/X
         A/HtcwovwK93fkzAme3TJf7Csf8iwWQ9ga9FEw9Dp4p8e+YiAg6rlXqiLRhwWGj719nq
         6v4eA3+VGCan+3pBaAJymmVCKz5VEw2TY7mAUfSbIz6qU63WWphCs0m1iAgWC2hSyBIm
         Qelg==
X-Gm-Message-State: AOJu0YwZ33nMXwJkNT/DAdmSPT9vwgLQ1dP9ggRlGXVhV7wIUG12CB9M
	FerAQw2PjM4Hi7rjAI1ASOXR9tSLMqiA6+o+/UVjSPdNEURRx75K3wqu8oSj2ZnYBLkhq+iJjiD
	wkASnzNhimP2dYE0Vubaw8pTScNKnSpibfFm7Gw==
X-Gm-Gg: ASbGncudQVwYVKboVR9hJ5cR2P6RLWtwoJIKm4wapWQ0vR4J44C8dii/ui9Xfo3HCww
	rgZmsG6YntfVndXZ69A0GhkIjtxp99RDBnkBZFljtcIV6VgF32gfSZ/6Nilpd/VhTF5h6SokYVE
	t007uhmYUGspKPHwmATiA9ng==
X-Google-Smtp-Source: AGHT+IFqngEBbHaX2QdwEE3HsnDHxcnw7w8+EIZiIRsTTuz89IIJcidVWtQ0RrBbV3822UkQAYwqoYqBNqqBeud2jKE=
X-Received: by 2002:a17:90b:528a:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-3087bb396abmr5001654a91.2.1744983356901; Fri, 18 Apr 2025
 06:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418110423.925580973@linuxfoundation.org>
In-Reply-To: <20250418110423.925580973@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 18 Apr 2025 22:35:40 +0900
X-Gm-Features: ATxdqUGfPD_Fn3CbFgQ2JqWIaEF-HIOZJH7bBppNB-unRzzXA6xZw7RWTQbVovg
Message-ID: <CAKL4bV6cjDh24qpW-g_a2i+OF_kujS0kMp-Dvy+OoVAiOJLHtg@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/447] 6.14.3-rc2 review
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

On Fri, Apr 18, 2025 at 8:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 447 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 20 Apr 2025 11:02:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.3-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.3-rc2rv-gfc253f3d7070
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Fri Apr 18 22:09:28 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

