Return-Path: <stable+bounces-45270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4C8C7582
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2843B20E74
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40A145A17;
	Thu, 16 May 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoxtqSG+"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D22145A05
	for <stable@vger.kernel.org>; Thu, 16 May 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860695; cv=none; b=NfN3TuCt8JqprhRX8+VhZ5hA1ct38C1vjVZtB/EIow/qc+QX+6W9GbBi52RDE/VXXxgy8V4ah+j56PPPNb4xJ9RlzfmTEaSbTxV4/xZ3SLKfqpcJPNdDpK9I7tOy9QrpzU2K+1ADrTCVLNwcHT1jrlMd53x30ovJT6qxo2y9yEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860695; c=relaxed/simple;
	bh=ZD6fdGcG8Vh7cSxSlm4IT/PuId4g528AT3i6ACO2HWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6IdeDGQOrkI5e2NEyDx2ivbFxpFebvEKPqDhGLyBADctS3PGD1L8lwzNh77+pkPd/zJi5uO6iSEU+RBuXo58OCZ1KS+JPSjyf+VvZVoTRyHtwisO5IX2d93k3lrOGrVumzq+I5u43ThasZdcbbXSo24gR2Hqozc3nrW8Op34Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eoxtqSG+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-47f01a027easo2254400137.0
        for <stable@vger.kernel.org>; Thu, 16 May 2024 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715860692; x=1716465492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVLsiflUzOkxw62g1k8tSvDQS/0/UmSfYYflXMvKM5w=;
        b=eoxtqSG+QuovpfoCjZsVJdME+SSQzEAYcYcW/KMDfajcFoFzHkkjgjWt+QJb5pufE3
         oNwum97K1wCQ6xuOW0axnGzPanCi6GlTFY0RksbMNiF+GzhtiK8H4quWMnalNmWWmvb7
         eswcJXC6aiMZSiRwIN5lFJQAPtqgGLW0fe9Rt88kdR+ZpNojfeck8ycBQuD0VRlEN4GZ
         16pBbUDhIChHsmWRLI88iD03UJqmqN3n81K9Ez4rNyZvj1ZIUAgVrO4JoRkwfzPDAfOK
         9aPnIDY4Vc4sDFPCidgklWKom8TNlx5J/LlXUg1AnhfnzHFiUhCMhWyyHCyNV2LxdMu9
         yHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715860692; x=1716465492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVLsiflUzOkxw62g1k8tSvDQS/0/UmSfYYflXMvKM5w=;
        b=YrgqHkDwRhj1ZQptj66Qcs8nVEoAFtSvkoXd5YRjieo08cXwLXXfh/HTvoRqbgB4GA
         CeMBe/gCvVYks9So80h39cCUa68vslZVMt3cd03wctR+u5ALJFFonLcRDqt1B8fCZhC4
         5kpUeQuJyeidNHXfiw0GbRy0LYgUdzoxckoZokY2gXoY172ZHJ8ZYctSDWaNe69jUnoY
         cX3swb2vUd1CYq1WwI4bxY/Pa3ujAYlbTKPVPqKdwrjL3BcLaUtFFgmiechJZnAJNHss
         ALDD1EiPU/k8Y8bI7jKWO12+xB2ofktHVkhayqm1xue9y8Vru8YB8u/ntbg/mxBM5Ate
         p8Xg==
X-Gm-Message-State: AOJu0YwwztxRZ2+v/u7K/EpNwcPF3a9HTYlxM3RWhwmb/fJ9yP93tqQO
	ARG1GITEca1iWV4749L3Jos2CqLNsmp1YdCuqDmTho0HAJlq0bzVDjKWu1MM2g2Nc2VkYnQXeqL
	3QHPweFEa0Efhdwx0yN5L3yJ5fuoQnYOk1fD+2w==
X-Google-Smtp-Source: AGHT+IEnSexvZwY287vVwa8ydg5RBnd4iYHY/vijHZOwtIpC7IUKq3meEbllweVItwMl5LJPYcEeoHu8dAXmjWLzQQg=
X-Received: by 2002:a05:6102:2914:b0:47e:d89:6ae1 with SMTP id
 ada2fe7eead31-48077de8685mr14056384137.12.1715860692420; Thu, 16 May 2024
 04:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082510.431870507@linuxfoundation.org>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 13:58:00 +0200
Message-ID: <CA+G9fYtEMG8t4rKgyDdC_xPNZOoXy43AjaqL6a14uAZSgcEf7Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 May 2024 at 10:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.

As reported from the linux-6.8 review email,
Following tests failed on 6.8 and 6.6.

kselftest-ftrace
  - ftrace_ftracetest-ktap
  - ftrace_ftracetest-ktap_Test_file_and_directory_owership_changes_for_eve=
ntfs

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Linux:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.=
6.30-310-g0b94bef0cf16/testrun/23929131/suite/kselftest-ftrace/test/ftrace_=
ftracetest-ktap_Test_file_and_directory_owership_changes_for_eventfs/detail=
s/
  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2gUuHR=
XnZeVFxSJj1ZDTcnIKTr7

## Build
* kernel: 6.6.31-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 0b94bef0cf164f56b5f7d93015069017f1678f70
* git describe: v6.6.30-310-g0b94bef0cf16
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
0-310-g0b94bef0cf16

--
Linaro LKFT
https://lkft.linaro.org

