Return-Path: <stable+bounces-87637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477799A90A6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5838B22B9D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206811DF26A;
	Mon, 21 Oct 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alWgyXFB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CE1D3627
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541356; cv=none; b=bxN0fOsJsYsfRfRKLjL+sBZNfLqmdGCyCnIH8mgiTO7vo4MkwugeZ7aryR5kaKngHFJMiy8c3lzFMCrN5m15plJBbwe0oykX485ddJUnlPuMIO5weQQRmSQ765c5SvtvaKzRjyK0AKyuPDeRlNrUZWe4F9HjTqUkyx62tExFolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541356; c=relaxed/simple;
	bh=I6t9p1EaDfvb/Eliq/u4F2cQjKpPa4rONmqDu33+ZwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5sXD87ytXq7AnvSRM2ijaPPaztZyB2zVfWeVm/39ZfFvpR1+dQ5j8FP7Llekz7rKIz8zZndP5PIqbM9O6G9ZVwbBSJ1H+O4A0TfYg090Gqn/EPu9cE8Hi7T6gL24DfKeqBERY5zBVtw8q81pkuU4dsYUq4kMGkKWB/wbNUD9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alWgyXFB; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso1456210e0c.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729541353; x=1730146153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7UfXJmHqQAN/EECC23EYEuOCLTpAVln9L8WakW7sCk=;
        b=alWgyXFBA+H0T/A3mNimKB8uiUJKi7VMNRYQ25fgCJl5sQivtMxQroqoA9BZsAdFuB
         J+q4uYFwFSUfcgvMM6viDc3yHNd5oBntRHArhdvXxmZlo+wvUtjccmrJc35hAlS4Br8g
         i4DLfW2W5NdV0pNwrams6S9Z+6FAsudakGnggyx0i375aXIOpKygik3XRZh91FInpwfV
         SE1waY/KyKTWyuJLHtkWr+Wdm6+ftqmpJwmzxBaLFi4OyvqyFPcsFXRATbS7cZsqHOaZ
         JLhBR3didFUqdrl1Qzxyw/QWhztE3Q71NIjgTLLUSLoBb/g4JFQanH+nQFIk29HIyZ4P
         rm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541353; x=1730146153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7UfXJmHqQAN/EECC23EYEuOCLTpAVln9L8WakW7sCk=;
        b=nIGmAQ4DUz/8cOGU+UljOUkXqW1Pz41sFtRigPKIDG+1E7s4A1y2Yx/6oBmOprvuby
         4SMrWPgRVRn5DqT3cexblu6Tk0BZXPavHcuPC22ec2uXbUsVYwpwc71T0aYQdnGgof8U
         Xphga+juh69bAgyGS58cyTT+7jhaqrV2QS/LCQ5UH2PluboTNVqhuLK14cnd+R5oQpHS
         3hjreQOVJqJV9/lEG4CRpp28DR+wkcgL/ieOnGhy4g/xDQ6rtB1JSHSFAKU75vxTzt1+
         8ONtJ0NmTgXRYW1QLLcbCdSzrcy7GYxhYleeQStj/iyygO4f2SqjA2SgFAsEFsmeEBfe
         PEBA==
X-Gm-Message-State: AOJu0YzZDKOuZIBHPZZWtWSeBH4EwX3NUo5i9VvZM44PyRBM3CKazj0t
	DX+H09wTgHmOa6eBET3gTbXV5Vo2uzQyAkE7drQFFJApxECY2cCxFyrr2ay1BZpZ8RCQc4idcA2
	CfIjjyZT4Rmpq3jO3vIf7jaWDSM2GDijc/kO3kw==
X-Google-Smtp-Source: AGHT+IHOy4P9Q03evxUVUvw+iLlP+PcSvEmnXr9naHrpQxbtIPqDsLLua0p6Q8JDW2ufPcobKza/hdFknJsTy785kG4=
X-Received: by 2002:a05:6122:179a:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-50dda180bdemr8605836e0c.1.1729541352168; Mon, 21 Oct 2024
 13:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021102249.791942892@linuxfoundation.org>
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Oct 2024 01:38:59 +0530
Message-ID: <CA+G9fYtXZfLYbFFpj25GqFRbX5mVQvLSoafM1pT7Xff6HRMeaA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/91] 6.1.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 16:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.114 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.114-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm allmodconfig build failed due to following warnings / errors with
toolchain clang-19.
For all other 32-bit arch builds it is noticed as a warning.

* arm, build
  - clang-19-allmodconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build warning / error:
-----------
fs/udf/namei.c:747:12: error: stack frame size (1560) exceeds limit
(1280) in 'udf_rename' [-Werror,-Wframe-larger-than]
  747 | static int udf_rename(struct user_namespace *mnt_userns,
struct inode *old_dir,
      |            ^
1 error generated.

Links,
---
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.113-92-g6a7f9259c323/testrun/25501845/suite/build/test/clang-19-allmodconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/

metadata:
---
git_describe: v6.1.113-92-g6a7f9259c323
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git_sha: 6a7f9259c323c90fd1384904b8d547666568a716
config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/config
download_url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nkFE9BnBhh1xegvL7gVqMnXz2x/
toolchain: clang-19
arch: arm
config: allmodconfig

--
Linaro LKFT
https://lkft.linaro.org

