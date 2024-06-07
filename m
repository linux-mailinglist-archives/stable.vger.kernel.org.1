Return-Path: <stable+bounces-49996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B2900BB2
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 20:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF11F21C75
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3872199EAC;
	Fri,  7 Jun 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4yGcMz3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB221957F6;
	Fri,  7 Jun 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783385; cv=none; b=Gqh5d1/az8jdB+nrvV8N9DgBIshY39ORQdSwnpJHWQ83Q4RdTiVIL4BDEFKP8cIsVT+fr5rkDt/V+aMGay7PdGInD+pY1coF5J6KiZxpogIY88bHu/ebaF5E2bQZBTY5gB5bFw0bWeRops2zaOj8418JdjRJVlnt309P/q9JnzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783385; c=relaxed/simple;
	bh=S9vlXymCuw8y2soXFtQEl6vKMBGohi8Chq1vzxf6eaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gk96M0CtrpqlT1HvlJS3k/LrLwg6XfQ0vjjBbZoPGV4UVJSIwdtxGhQlszQEUsg1CcrqqxqWCzOWXIBJ1yLSYN5S9st6Q5Aneyg5SddKqMY2qZ3pUn3T7QmYqTu/xU58KjBAmxymnxHu3e+t2qWGe40MClbsm6iLCCCqsOcbFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4yGcMz3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68ca4d6545so435222766b.0;
        Fri, 07 Jun 2024 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717783382; x=1718388182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M4JhFWYIaba6S7NZfwQpR1LZP1nrX/OWl8a4IvQCyvQ=;
        b=K4yGcMz3YzBU7Sa83NjKsXRY4aADN4Gm88wTConYfsGmkkiGB/ZVFO727DigXotuWJ
         Lm1JBu8FyVHCFkYzGBBkn8l+gCNbhE+kfKvmNB37CsP7ZtpMOVCc0GM40V1ziBzhcN5G
         txOr5PMZcQwf6hDJgDnJv8LqwWItd9BQ/Zhf4l2gJBENSTyGhkjXmeiJHwPEj6MW+rEp
         RfnW+tFzc+F1MR7nJONLFkI6KB+fM/LbitjkWXGIgQ62t+EP3nQCwZcuPO0MY99V6pu6
         yvemboh3dfunUOE2LAln57TSlmbAR2bixjjzmoj8ZWM6hyhnh58jjEx41DzgKxScQtiO
         ScSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783382; x=1718388182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4JhFWYIaba6S7NZfwQpR1LZP1nrX/OWl8a4IvQCyvQ=;
        b=hlpNi69JX5rYG2x1pj+YXkvJFs0q0TrLHfPevT4/jlniMA97ccUUkNJwqHxzMaXxSZ
         GW9Tp6OK9boXoW4qREfT4lENFHcgekuQS5Op+j69S2nIjZJ7ZXYyIEqLKtr88CGxiBBs
         bwGzwhAhoosmxxZkLQpvmr+UipoSV1uB1zihbyWZgtH9tXfmfrMqAkgdCNm5gtgULsM/
         X79/qBiIvuYt2dL+uJbUk1OdjVzo11qm3ujugYhX7gapdDGRcGl/Ge5gRk4A4jN/2Ewe
         3l8Sdo0UzE5csjCnAulRRDu6g8Rxo5V1+WnwM1LZLL2SJtNsFeDjKFG7J1M23LsSH8wD
         K9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIn7UkUxMZZbVe0oSwBnoP0JsyBe9tPqA242cAYLAt5KU48vITNfsLLCWK/5KkBUBeC5KI5kCrwP3/H9DLh1+bj45vgY6toqZB8K+U
X-Gm-Message-State: AOJu0YymVdoPXBUcS++LYiQ9ZqLQhlFCgim1H6PKHwHyDevEXvtnMMWi
	SMNyl2fU6VpN1yZXvh68aSaXfl4ddyUesUQn83JW8luoIE+NA1hxEtixv6B53/okPwecKaET5t1
	ZNvxDGQpgCOkjjpS2Sv6+A8iU4Jw=
X-Google-Smtp-Source: AGHT+IGnj2ysUfh7SOHLkJc3CGDkP6SwlsXhwVpEmOYlNR31bDcHXd9kiuPue/wzF/0qSpCM7o3lXDUckdPju300slU=
X-Received: by 2002:a17:906:4154:b0:a68:e268:fa30 with SMTP id
 a640c23a62f3a-a6c7651ad4emr448512966b.38.1717783382081; Fri, 07 Jun 2024
 11:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 7 Jun 2024 11:02:49 -0700
Message-ID: <CAOMdWSJr-KSGgWrv0zG+nBu=NzQVpw-z7ef5+ykoKXO1uczLzw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

