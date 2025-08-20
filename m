Return-Path: <stable+bounces-171899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0648B2DDB3
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 15:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05AC720EB0
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26BF31DDAF;
	Wed, 20 Aug 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pOdG4z51"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DA2D3231
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696403; cv=none; b=ryqyV7NTDvxzZ03A+H6vxUrnIbRgJz+LqpiHTnhzrdm1xhIuRbRmbWxO338zqzPhhWz4wISPI/8ApThqysEwbCLK6NPksxTrypS7DBiLeZOgE7MmbP+gyVOYGDo19/GL9Gr3srmeifESWwm7WSqlRLMgUKR/XYly1xnDdqizS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696403; c=relaxed/simple;
	bh=0uRCBa5DuHokeAP8b7en3IxnvVTDcb0IQO3SjWgln30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDJx59sQHIrnQO3XCONk7gEzVYT5bePp0rxSgxZfxDKu27ncRDI1w/9k7Sj9OvkctaKRQTytTLLNftPsrQ/izlRCKjCD18tXv3fT5eP7ipmMUh7+hqsOx9FIgnrhHwObkbSZejs360oX2AvXgT/vKSdD/0Nd3a9KgCgyS0Rrwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pOdG4z51; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e9f7c46edbso72683385a.0
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1755696401; x=1756301201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pduMkEptKdLVMmJZmH218CFcitvFhjXDFeo33s0r6g0=;
        b=pOdG4z51maqCFMr0MGgLrkmLFuX4Kh1avl6nMKVdnASKJNgcoQnWPYbavRxB1ZvxPG
         I54hOE3R7wtVuSVuHGdxNIe2ugEzeeS+Wsl+DjUtFyTFlF8MJX4R3B0p/TzLxbDLpl1R
         3M/rAE3OpXth6bdLMJR5fJIIcr+6biAWoGNZ2cg+AkW6F5wpZEaoYiTov4mPBZ+uAeJf
         qpovgPSDqkB9VWdvZKXu6l0HMC8ypu65xsTQGbI6wTlePw8wO24G3ST9AT8lTKI7e8R4
         +H2IsfLb1hLoreZMQmi84KRed/orLpleyWmuY2Mxw2BxEyJT3T93rHqMd+LHcUD7z+A3
         g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696401; x=1756301201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pduMkEptKdLVMmJZmH218CFcitvFhjXDFeo33s0r6g0=;
        b=ubgrO6gb9ybx4BY+69WxoDj8Khcv1vCEpsCpUHQ+v8c74rZrKmRL2/UipadkOHmgAI
         7uqpaVAvJZTmYhnBlG+IZ/St4zRmGjNP17tYhrr6EZeamm1UxeIn8JhFUEDSREpZJD7h
         FjT/nz6vTOSdzKv0NIwdDCer24KnE1oD4Rp/C1IwgQjtK2t+w9VgCq59kV3B/ntou/R1
         6dWD8F3weD+fMx1Gxowc2ayfy6ZRdW6Rnmza+YFIRQLBVY8/wWKpcm+CmEzYRywhQnrk
         U+3tRU8tfKGLMYxCEHzsGRI/QePLXLK+15S2+kuY4LBh4QvAOzW3EPYuu1liNRm5kfE1
         hqCA==
X-Gm-Message-State: AOJu0YxeIAkRdBj+dKcHYqtOOY7ou1gJRHG9S2qw101ihxeUWyspDOOv
	Qes1Wl09rzqFHvGSaMM1g+FETsdQORsK7cZ5BQmQNwBKVlV2bFY9giZ2D+kwmRERxcQ10SOdA0P
	/US8uVVMkjc1FLnlmQbT890sTE9yMPgbOmXXmAwJ+9g==
X-Gm-Gg: ASbGncvMdM/q3ghYRCid5pHl6/femoiJvj8nuh6AmwiQ3DubnxMjxaf8mDDWDvxkg87
	dNEFn03v71dcrK+xtUx8FPfgQgA/DQOa9KshJtXHoz6aRbRSRQEjGqqyE5lAnv8FBVS/jxvP0yK
	8ntgN4tMJniHS2xnCOxL0HwOaC/1r6BcHf0fHyTcn83a2sg7nJRcIMgyrSn0hujwrrvDVtE4Jyz
	z9kRKgxcrir6aJrKS0=
X-Google-Smtp-Source: AGHT+IEFuP7zEWHJoh21HjBk2ylXFPhv4P+z+9swFEB6pv8mUDeiqmBE0z39lKhQPdd5eiXvNYtv0J4LLfK1tyaY6YI=
X-Received: by 2002:a05:620a:4105:b0:7e3:2c53:b28a with SMTP id
 af79cd13be357-7e9fc7585acmr318667185a.16.1755696400716; Wed, 20 Aug 2025
 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122820.553053307@linuxfoundation.org>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 20 Aug 2025 09:26:29 -0400
X-Gm-Features: Ac12FXzu8URN-aar7Ixa8xJWtMgHFMvicrS2nfeoiQQtmUGUKz6HliO5RbQkSeU
Message-ID: <CAOBMUvjakzTF63pwX0_GGswgKR+0TT=V4gPVZOOBuBbESqsbpw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
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

On Tue, Aug 19, 2025 at 8:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.43-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

-rc1 and -rc2 build successfully.  Boot and work on qemu and Dell XPS 15 95=
20 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

