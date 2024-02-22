Return-Path: <stable+bounces-23317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77885F76B
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 12:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FE4285702
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3947A57;
	Thu, 22 Feb 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0f50Yjd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B64655D
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602588; cv=none; b=qqZ5maynjSSVtHUA0k8oBY2+2Up4FSXthB/xjMtWFNoXGoM/fZeL9qN9xH4v2Fhsg8HHXi0uvCMBfxWuL/6CRTAggEvOx9d0TBGxI7puvUc9MIS9VyqOm+wuajdv20hmKsJe70VvoPYNqgeR8ENW5knOWL6bCKrYpeEM79i0jNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602588; c=relaxed/simple;
	bh=rwjqj3F5DEjDpzt7Wk5cef+rvi+l02SyQ3twXyL6rZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+ziS6CypgGOTbbdXK6DUrqaCyZ33789YheQ+jiMNNB8xJT1kHyG6RPaztzvsUSAvT13youiNrKo63GYi7BQ7HPViK0OPJsJtCXH09dGRlwYG8chEuyjBey/F/dcXn0wj1kEtIg70lxcN6sAM4RKEc65qRkg9Bh6PRfijzdwmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0f50Yjd; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso3282289241.2
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708602573; x=1709207373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXZywZ9bYzEPOeiOcQKWFDupoTVmbm/QeWT4cQk2MjY=;
        b=X0f50Yjd07xChxgzH9HRmoWpya1qyoQ8+fLn22QFTrnXOK4Es+7jfrPOexmoUMyPvW
         UldlRHNFFxsmcZJZgO8+LqSHievX/yLrHpNOSphNsvv3Ckb+X9vqM18FERQw7fwthKRR
         l5Brz9VoJhxsCobbzEpIj1gv5eV1+hvxMl0wN/VjrTN1R9hSwZiAqtXbHASFL5AF+rhW
         vhtfOngM8Pbfg8OUmwVrow3vTziJ7VCxnV2E0ce5SNHRwybEjcUP4aX2sMfvyLUEcW1k
         pTA5xekTEezDE6jr5DhuPYAiSdHLV8SVJUFnr1CHj+dhUwBClf2aeV8Fss7YlL7k/RL+
         IH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602573; x=1709207373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXZywZ9bYzEPOeiOcQKWFDupoTVmbm/QeWT4cQk2MjY=;
        b=txsLFi5dVhIDHPRMut0RFi4F+8xgNkm8YJF+HBxbtGLbasElM+qV28+HJHNOEfGdYz
         YJDrgiVkrPnOlRAcT2pk3yzgGoxiogJanYSyt8BKzx2oudWMrTcJSmOdDSwfhd9W5C1r
         F0Yz9AF4b/eS7YOSbt+U4YZbr6lGnrEZ6Egit0WyrizRVdZYFUuR+8wgDKrZ9RLhA/GA
         x/dWfjRJ6Y/IZrAfUtRFLl9+mndia0gjYT8y+P8moeRgezuV5BQgQ2m3mKtXHxeQ6J6P
         CBCSmHY5RrGzM8JZQM4z/0NBP+LD4YoScl01kuezTnNwU91DVPznhwrvJkWZjY96fgMV
         iRPQ==
X-Gm-Message-State: AOJu0YyYCoU4JqV1vr01bpxxScRa3iFYPwlzbqGdcAfop1fa0zHAfXhR
	qucfsvLx7UXupVYFa1zwHV+W+2VlrgWNo3L1i6G1gCNbc5BaE6Bzub7+hHBsyg1AVFu8vhJXlV3
	q/c287aP8R9ga7jWzpeL6BHn1y00nhwp0z1p5Pg==
X-Google-Smtp-Source: AGHT+IGta4b8AQTI82Vy3bZ+I0eDJVomcLJAjLz5u0WRGMb36VgNJK8SiwxwZrfdsHu4htq+oh8pRtOm5apzgwmgUh4=
X-Received: by 2002:a05:6102:2334:b0:46d:3208:aec9 with SMTP id
 b20-20020a056102233400b0046d3208aec9mr14251737vsa.8.1708602572983; Thu, 22
 Feb 2024 03:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221130007.738356493@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 17:19:21 +0530
Message-ID: <CA+G9fYtNZrQYiZaR2CChtA868kwnrz4byqnvt7g-0hW_LXyWfQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Beyond <Wang.Beyond@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 18:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

The i386 allmodconfig builds failed on stable-rc 5.15, 5.10 and 5.4.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:133:
modules-only.symvers] Error 1

Steps to reproduce:
 tuxmake --runtime podman --target-arch i386 --toolchain gcc-12
--kconfig allmodconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

