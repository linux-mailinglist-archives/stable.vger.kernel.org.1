Return-Path: <stable+bounces-54670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9086590F846
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 23:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C151C22DB0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF53F249ED;
	Wed, 19 Jun 2024 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlsBqu2N"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28F7A724;
	Wed, 19 Jun 2024 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831513; cv=none; b=DVWnjlsUYuezw/ANoFYn78YwsSXeJfzHtoT+f5/PlB/LauCfUviCansWS+gnbttgGE7/j/QjLU1BgXhUi+5Iw6jr07qK4sW5lo3uXEP+xk8sAnfkjlAE2PqRlIktMYRs3CFNa2tA4SYVZk2SXx4jwuMEN4OUQjfEyjOkWw+rKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831513; c=relaxed/simple;
	bh=JonIJaq3OZKtX2IdWUeB2L72zt1Pa52H9/4Dlgj3xoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds0taG/KehMFARMVBlAIdUfmHSHRBXqaYDiazu53o7tNd0TGCriu9gpp6hoZ8iQthZb7F31UkVcqNFYxmSosaN5o9Y8fbUMzlRbjzOQ53GXvNyl0ECYRJlrDNpEUaUwsSD/pBRS9mBrevJ11gvz31931Xcs/Qso8/2OPkf7g6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlsBqu2N; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-80f4f7e6856so71786241.2;
        Wed, 19 Jun 2024 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718831511; x=1719436311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Wf/koZbFW9IPk/YrluCkWzg9WkxM+rq1aaZRjZ11M=;
        b=JlsBqu2NswBGPwEs59iK+zePqFmQa80TN7XEScK6ZrGuBuvjssNo1OylWsWk85tvr7
         Iawa2jud0OoroKiDtN2LKAsdauoW2Iw2cpaq9a2MqhReUiSfBSP+evAFk9RG5aYUPTj1
         prxfkIT2OraSSmkmtA6xXU6OEEflzaQ2geiFcBOTrYubQasPz0OGlpWhA/92Sp2DGX9m
         PSBhn8CTC1p4abH/L+toVAEgflwjcyk13BI7oGcSl0Xj/V9RKanM1f1P3AM9IpAXakTy
         HMkeJ2n5TDMVtXJ01PC2n2LNtwS/FzvHtISkMUcfIRfIwiTmI2DrG0Lc7LEcm3kLHPrq
         G/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831511; x=1719436311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1Wf/koZbFW9IPk/YrluCkWzg9WkxM+rq1aaZRjZ11M=;
        b=ToRUhaTeXJFbDER6bPzVAKat7D6HX4PHamETPEO56/7w5tLspJcWIVDtU6Nc+7jxhT
         khE6mGye5yAoQc0ERicBApnq4iRSPmxv9ZaxG6hVx70MyQ13t7wBgLsQ3mLKisXBUnJZ
         IhIpFX1Vy/0mJtf9OYrvVos4bjnNZrLlqo/zD8Sj6u2aRO7ZhbZ3+uuJwH+aiYRaGAe5
         pMv1PElNIs2oXoRrmh6gs7IJ9MdiHxQN1wtfxDUu9kfyYT2ltpu3OAKYgbL9NPbR8Sji
         GGqtliUX/AHtAMg/vGipj7axi2cIX2mT4nyj7ju58c8r/Ia+G15xXQC/I96JGls6i0aj
         vnfg==
X-Forwarded-Encrypted: i=1; AJvYcCUWKhrxE+p2ZeIKNfT++PJizGyM48aPaES3RnWRcvffkz7nsr6rdVC4jzpKKjmaBAm8B3bakVX9na6C3RSARts+IZ7vLiLPfIoXSmA5
X-Gm-Message-State: AOJu0Yw9VbMLhRKlUdyMwCYiXlp8B1e/+Ji8mUMujj0dlLSLPDyPwEGZ
	LYXg2GKgFu0EvuFcqCK+JWsFzZkC9wgY7MJqKAKcWUUtj8MpugMmneHVn6wCGhvQ21sINJ5cgI5
	ebAVEWTT5mT5TO53wso0iUfLCXOM=
X-Google-Smtp-Source: AGHT+IGjyujEK+bHyLZHGQKjMkIjxvDNm29uWhTBhACl6IcDhQiGcoLcjOlh9JO/lLGeoXMwIZaOtHEreRocNL6N4n8=
X-Received: by 2002:a05:6122:920:b0:4e4:e90f:6749 with SMTP id
 71dfb90a1353d-4ef277dd297mr4205321e0c.10.1718831510898; Wed, 19 Jun 2024
 14:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125606.345939659@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 19 Jun 2024 14:11:30 -0700
Message-ID: <CAOMdWSKYu2f5Pz_CNVktWQonknPOOskdp9Jxj+xBJgp_JdsdnQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.35-rc1.gz
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

