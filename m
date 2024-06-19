Return-Path: <stable+bounces-54671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C490F859
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B01C22827
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D615B143;
	Wed, 19 Jun 2024 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH4wYMqv"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1315B13F;
	Wed, 19 Jun 2024 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831638; cv=none; b=WlQ7+x36RniIvEIkPgcg9yj/WTJDmAFw46uv2CUHAmIwVPu6DhoCsO9MUxhTOhQUPyqA+Lt+jgYHxeYoK1wSe8UKlAdxiiAG++cg7ifjFvk1xrUR5J3IKz8Ks41lKx1Qn/ZyhjBefdN3H4N7Xn+tbG6jIjJbKd7rLm20p3h1qsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831638; c=relaxed/simple;
	bh=rpOVe1jItyq7CejO1NxThDWJH36d0/VyRsjB7hMyk2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yzox+cImL73oAK8OQTlkKBbSJZCYTdUy/MW+P3uNtP6YmroRQtpo3owyI5MutyFMpSTEpaobBzHxtAqwzc3mdB0Yg8TaQOBD8UPTbv2P60Vf9Ed2buYoMnW4/jqrgQao20+SWqxsmmJB7T82mMCnMvdPIl/lzmHsww/Lda3i0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH4wYMqv; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4ef217d6463so49681e0c.2;
        Wed, 19 Jun 2024 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718831636; x=1719436436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5lqTl+uAxp8s2vfx7aDxDVmFRnQKP/tGJxujthBDYjI=;
        b=iH4wYMqv0PefXp3TKhDj+sZuypY5OazA+jzAscHe5WLiYxcDzRKGJbp4ZEfe9Cm98E
         bdnMH7y3f72O0RrYYxYsRDPTMMploI1EzdvgNe34RZiBUJseW6kmfWr1buOamtCEURmA
         pu5mpQmTgOkdWS5+2iYK3XwmOF3nSaq45MY1Ftj5eCtnm1eFq2UI8BryOn/JCq1WWYrq
         NCMqdEwzA0lVLh4BI1JYLm8pNWdm6n9Sdqo49UxdHWddqLrbyRP4j95h8fCklwQM2k9M
         k0Q/DImKPeqc6nNPSAMM+mLDtMroTCFJNYY229TsTgbOCaDCR6R0YezBMq76tC3QtCWE
         qxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718831636; x=1719436436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lqTl+uAxp8s2vfx7aDxDVmFRnQKP/tGJxujthBDYjI=;
        b=UtjwMGx8BeNed/dFzP3ab3VsnaQ+qWh4bQ0q6r66tGLfaAjxguwSmZbQPrPf6LcWAT
         nElyIGY4bZsbSqYQdYMhH8OEv5YpTNfyQEyCBvH9hc8FvwxgnxMzF6dw1w94/WVmN4jb
         /lOjG+JhE40eFzfRD6bQ3Suv88bHvnIRSCUAz7ESvp9cei4P/mpU0Mp9YCzdg/N0Dbn3
         AHpQSLOXlVeAtEvkLmxZanluehv1D3zT0dwovoIlgp1ReEcHoLj3YXa+98iroZLcstZy
         yaMg3uB3fJA7GqTUQ+H41cEdnH/JxjV939aSGXwqKzbUDFsh8n5fCscY8k+EGKINMKCW
         +TfA==
X-Forwarded-Encrypted: i=1; AJvYcCUHK63cdV1Q5+jtgIbVNRr6T3Z60Hv0mlMpcxJKRq4DAUgr/mvJ79b5nwSeL/xn1zQACD4Tdg6L7ByZJoyicv3tj1ibmjZXTK6lp8Qq
X-Gm-Message-State: AOJu0YzdHk1Yvhy9Aq2p3fVEyh+QF+8jfX9lttxu9c3idB1Urp0vLJxQ
	eUaHcKQGErq3yUP6KCbfd3nT0YXTsyVDJklJtM0D9qaQzM7Tl2DoSgdyRTeD9OinQVWr6LACoMa
	dRnmrQVOM/qFOespoKwsNk/1aujv6DmHr
X-Google-Smtp-Source: AGHT+IG+nD+fZRMU/xOWtMG+hZUji6SWhy84IrO3OtuENFQhrKrpf0j3Ruw7e7xZ80w8ValYIl4HkGMyoFYCtLc53Dg=
X-Received: by 2002:a05:6122:2093:b0:4ec:fc23:7928 with SMTP id
 71dfb90a1353d-4ef2777f84bmr4352731e0c.12.1718831635757; Wed, 19 Jun 2024
 14:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125556.491243678@linuxfoundation.org>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 19 Jun 2024 14:13:41 -0700
Message-ID: <CAOMdWS+Q1U0jzwcTiaXTj1RRhPVdpp0e=4dCQs3JLAJD+YT9cg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.95-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

