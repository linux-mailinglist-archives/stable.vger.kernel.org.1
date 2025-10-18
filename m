Return-Path: <stable+bounces-187831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011DBECCF5
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F83D3AC063
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FA2957C2;
	Sat, 18 Oct 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPwNjKyl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284E24EA81
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781380; cv=none; b=r4PIPPMk0XTJnjsanVdEOpbQaFSmd4FmCzpncngTSUJdaHnbfIq2K/zZbq3L8TD1U3MWRTVuJzWlt2v/cjmWavIe9idjGFQGk3blc+Abp+tu6+32pxEPjLRUSDZi7995GrJEhvwYOsQaPpnruEFzSP83MK7766U4ZmBX6LGn+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781380; c=relaxed/simple;
	bh=scF0EL4ZrQ8MG0dfR6wkjGh51GNi7IaZ4FTFjOLlLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfImwSsVaknT0OT9pM61R+YTKDezkaX6Z0IP1l7IWZzp2iCgnY7BbRmxtZO/vctfPNHd6HYMYv2DXMhhB2BthPkcF4oefN0MeA0hlFntqY568wsh3ycb1L7Giw/5Z1GQwg34zBBUbYMMWqoSDKRgdac/JrFd6A8gYy87JETfbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPwNjKyl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so3196532e87.2
        for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781377; x=1761386177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG8h4x80hiheaVlFkmBnjfZS/77H5VFbiYTB4d4lcjA=;
        b=iPwNjKylLLTCAjv+dqXkOb5aTi93lSKMguT4wrFZIZxqe8q9dTOp9A/8ainmLtKNUI
         +jBZ/qU2sRMyUgeYRAI+r3cEQlpvk1wH1i1Gh+2fcHam/83KNXamKr/yQhvHFThvE4vZ
         iMr8nfPwIcS8+E7fU8nbI/J1SLn6sIZjRghigLwpZjVBAtUL/oV+cfjwwh3+R0Dwhhij
         MMa5ghdDsSMKr66U+IlzMIrgb2NkQv37WOarFqPmgo0OL/DIqcjgD5Zwq8b8WrJo2CQA
         YZjFOg6hEDi0ozi51zgLEms3/w+Q30dJMu+7Z8REn7WeuFyKBxRymxOF3IUydkamlhXp
         c5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781377; x=1761386177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG8h4x80hiheaVlFkmBnjfZS/77H5VFbiYTB4d4lcjA=;
        b=enPUrM5icFJLP4n/eVDXTldd5r8XxYrZbPUDoFEqdRAqunwjl4wSyEqtuyCSd5iRVN
         unBZ2/WeeoBJodjWOMyOBHRUcXYfnn5BRvBqXgP2CUh/kncVeiY0gKyTO4XUMMZPgi+J
         sKDw0CtRP0bAlg0AufDqgcur9EyDLMHEPgEM+Os+c/GjjsfXhsq+1+a28auxFD6+B1pE
         9ZhHRXOXf0tpavZfzLtencLMV4MKr9jZH4nABiR3xt7cQ5y+s+h9De7pLclrG6aIZt3B
         naPEd5K/CaP15VSncclpr60dgSAQ55traWidmCOKrAC4oBOGCuKlwxKbJxYvJeEGguET
         kdiQ==
X-Gm-Message-State: AOJu0Yyy3PiBZ/YU9xDCAXYZ6qTU8sAOzi4+G5qKo4ufx3QAyHJjF43o
	XG0VsS6nlWOJ9l1ufLPi7zyXENshv8ZFhBxuEcyB/L3WzmaeY1ys2wd/QfL4801s4v6uTJNayfo
	4sZ3fMV3ZawS3sBL20hS5w741yReKnTMY2wuR
X-Gm-Gg: ASbGncvp6v/wnlGuJIEDec86hupvBlFVnasXvpBHrNeBIhOmJZ1nvUFgd0oM/XdCFU0
	ZjhMS67g6Vuv7TY9mz+i40yQW7b3Z3q+BicP+nHxhvxO5+B6lCrPTI+R6HGePO25qOLpKOn2RtC
	LyNJIlyfBfQaIrYaNDXIz3wkRawp/duZtvT67VL0SMw1zrCl8+2Vn/lPediG6qG0RvGjcps3yDs
	Nz2ONKfxM9CzII2N1hRIcKPFfJujrhotyGMzv7f2gL8HzQhuqrcTSO28w5SVPsJ+tFRqP/s+FKd
	8jj6nsX+G5I/JMRn
X-Google-Smtp-Source: AGHT+IEKJ5y6YF95e/034EqGxft4V8xi6FgMAhGq8nqr/x73Z61EUK919R7mXNOGbOwgly5qAy/ORYIiCfLVfCja/8Y=
X-Received: by 2002:a05:651c:1989:b0:36d:6d71:4ec5 with SMTP id
 38308e7fff4ca-377978ab84emr21143131fa.17.1760781376848; Sat, 18 Oct 2025
 02:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145147.138822285@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 18 Oct 2025 15:26:05 +0530
X-Gm-Features: AS18NWDmZ6tjsEYEhc3Qxf_b1eBqwCHw2ql60itDmA3aRy_0TfbbrlLraB7y8cM
Message-ID: <CAC-m1rrkfLXrBtvvpZf=dBnx8B2bb7O8zZQ8xx_1mA5LAM88Sg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hii Greg.

On Fri, Oct 17, 2025 at 8:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.54-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------


Build and boot tested 6.12.54-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.12.54-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 6122296b30b695962026ca4d1b434cae639373e0

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

