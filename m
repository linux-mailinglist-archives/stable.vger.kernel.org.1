Return-Path: <stable+bounces-4770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF4806080
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 22:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2275B281F9F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9B6E591;
	Tue,  5 Dec 2023 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYT/KKJV"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35FA5;
	Tue,  5 Dec 2023 13:14:37 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-46484f37549so921894137.1;
        Tue, 05 Dec 2023 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701810876; x=1702415676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/ZBnlG/4O4Nf+VPlwuFFktfrixZ06nlRki7xqoRblk=;
        b=GYT/KKJVsldVVmuE+K7d+Rvz2XW68JMPTmSbgg4LCyDwiK9NkMkm7fYBcG0LFlT4A7
         Lo9tQjmpr/vI7P11HLw1Oak9h1j5rGZwk7NKp7RwS9H6RAIh6pkboVZcx/gqnPKQmcKA
         lVH5TctWJrVpNbal4p3tHDaKJhJpscqHTJnYo0jK1uuy79yaVw6fZPNjgCU2IIprd8n/
         P2dtiZ6uZ87m0tq+b8rd3IQ63F18ms5vAOeSGIeDkzZZgz6LS/Jb0iEGZP/jyroskryO
         p8rP6MQX2AJE4Rf6bazdCd35P9HZHpAvU61yTp5x2WK+FMaKgdLZW2p0vDAqm4H1FvVm
         diMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810876; x=1702415676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/ZBnlG/4O4Nf+VPlwuFFktfrixZ06nlRki7xqoRblk=;
        b=CAp4xyq96GodXceQcLs6rEdpVyP9WBDMi7xM1MAqbfUlWGRptXJ3Rgwwu106cFWScc
         e70MntyZRxmqxZM8zsux9zHtKfZsa1vXNTUitvrbe5yvY1y8Xm13TW/YBoqT/Gaxo9Y2
         6CdW8SlNx86znasg1185T4/kyYTo7GqprJV0oN8Fd1nDaE82gwBLVATsHpIk60+5SUP7
         YBrYyJ97GBxDVeWqlV9TYg7jVa1d415auu4ILACTOUOwdakFCfDrbpUWk6EagUwN5gnm
         +axf1aNFyNqi0r8L5bLMxzQwuN55RUfgUNUGwYHyIQOEo75xvjH5Rx3qHm8N8hnOkVEd
         58aA==
X-Gm-Message-State: AOJu0YxcwyXRqbaD+EJXsSkOrGU/6PpTR/J6aJavRrrRVnQaW8k1OuHW
	gcgazYvBMOIPX/lz79lMs8f4M5cjsUu53v+EfXc=
X-Google-Smtp-Source: AGHT+IH+UdlfWyVlMgyHnqKWo2m141tgyAR3pqlIW+VX4wUkEZ6lSV2rACyt+JSRvaT0kg2N03iEUaTiYpgOSsOODxA=
X-Received: by 2002:a05:6102:284d:b0:464:55d4:b41f with SMTP id
 az13-20020a056102284d00b0046455d4b41fmr3539942vsb.0.1701810876415; Tue, 05
 Dec 2023 13:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031519.853779502@linuxfoundation.org>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 5 Dec 2023 13:14:25 -0800
Message-ID: <CAOMdWSJRR+iqqUD4iVuxV0mL45CJ10zSrTo5YXn+_f2bd09ezA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Perf builds fine too.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

