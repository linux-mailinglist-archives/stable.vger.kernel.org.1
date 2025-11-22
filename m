Return-Path: <stable+bounces-196577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD3C7C671
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 05:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15743A8095
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2A221FCB;
	Sat, 22 Nov 2025 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzgvZo44"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0036D4F6
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 04:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786475; cv=none; b=irTJf5gAp1Oyc+gnqmqal7AUvm88kksb8DCJD33mTyUnsNh08KZXOmazQY6HOHJCRpjMO+7BXgY235tsAOds0tPN6rjRL87N95BDT6HMkLZN6toP3+qcGcyrUoIKz+ljzI35ggs9/mvPQtXCbV+b6KFYcC7u0Sdl3v65/WCrx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786475; c=relaxed/simple;
	bh=h9VyW+WQyP6sSOegdIOdImrqU/TplUV3/Z9dqepUB1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIWmRxXFVKMnaS9kvJei7raz0MDGGQk/1FE+AjkhzZo7lZrdcAGiXsskmX/yvTPemL8rZMlyMgbBjwAHAeLK/6pP/7KM8S54fKMwpjB8FhrfXhVUA653barDtvk3fPbM0vqqf5fNh0mBwrO9O+vFdEUUKW8+KuLaMLeQCxtZo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AzgvZo44; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1930594a12.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 20:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763786473; x=1764391273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2OfHfYMQD7BIWZ550zETvyeOjFs/FkoMlr0NVso26A=;
        b=AzgvZo44j02VxBaqrYlNwnzGgD2pXtrRNgXIjGkyLApRxYJRhGAzF0sHDQE+LS14TB
         qT8eB4XCFa0R4sYa7gh6OyrLLbJQ1U79CQRdiwc/Ite69T+kvpY1OoTTXykulOqEDFD9
         +rL36Geurb1WwHqAW82I8Z8A6t131ewOtMDm1HBl8XWgzrcn6yzy1GaKyC2nrIf1Izw9
         aNIa+WwyYX/Jv8bETsJR0IFhUAT30yGLr2pNrIFdc42aradaDkWsNwKwLS6zbnaPv6bX
         g2ZPCk9GoPwu+DXTNIH5lAp44GpHvcIK/kq5R6LsySiBo8hTaL4UFdHO+hkprgcL/iyg
         ic/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763786473; x=1764391273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2OfHfYMQD7BIWZ550zETvyeOjFs/FkoMlr0NVso26A=;
        b=sQ/C75nQPTd3zDZZHpK+C0j5AaHSWn+uS8nj4X1l+YuZu9XlHb7+LPobJBIvjszJTN
         O4mW5LOR+7aYtOMqcw2sMy6Vw9+IPMO5hWDVNmDy2tfvLjU8XCZe9Tg9qSXzqHV2uaz1
         1qvAibaAfGjYFpjhxjjzmc0E24yHtq2cVPyO27t29UQlHCv2t32Z+U3yqXU9R8I1bftd
         bB5kI8HxE5LV1LDue4DyUPUdaFLfrBV9/AxDrIEoCfbMVGSplfC+OkNEts0YLy4zGweW
         0MSMouuVhQjZdyuJSEwIsytzOmvlFER1I/98nKWbwN4girb28WU0OrZsGZmEs7LiS8Vs
         K55w==
X-Gm-Message-State: AOJu0YwXGIdadTxN1G6lW6iKqPIuymwIgr+6L5Ki6/IHl9JvElYMlWuE
	sqiMQ0ZpZN/Iu9BGV9un46zSi8SUN0bkDu0OWJicOOQmZWmhGhQ/Hu0+xaE7Y4YmpFZS3+oJ5cL
	ziM0TptKTBio4fi16xrL/zGxGe4eIWqbGjSOq7XzJxA==
X-Gm-Gg: ASbGncsW/Q4yXqRzHd+gQGMyEjBRwNHiBguRLxFV3qUVttN3fQa8qLe8fPnipz4GY4a
	nSR3dGvqV51XIEszBYJd+cRDohph533rZfv9apcQRcRMdFV/Wg7t4gsPKMs2LdW/3Gepn7lJXIw
	FKktgouostyac8/bNR0IIgD5ex/ZniAGlz6WxQedSdwYACLMDb3Zr2KTSVZb2NfCWW9x/vKAKY3
	SV17jQ2/Ckty6BefiUIrLgABDmyuVhWVhMHjt9rdQrbFBFWBMZY7Z8g7SMOilqBHuLQc+yVvyEW
	0AA3dGRVYTlCjEWkKv7zUl+EsNFdyERQCH91KYg=
X-Google-Smtp-Source: AGHT+IE8oEB0Bk/WUV316rX6l836nB/xJn7OLenveTC22jF0e+Qj166dl6/klF8TEtvtM/R/zQi99gF2oec8bULJg6k=
X-Received: by 2002:a05:7300:b593:b0:2a4:617a:419f with SMTP id
 5a478bee46e88-2a7194a9af6mr2638588eec.2.1763786472525; Fri, 21 Nov 2025
 20:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121160640.254872094@linuxfoundation.org>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 22 Nov 2025 10:11:01 +0530
X-Gm-Features: AWmQ_bnWr_rQO39FsnhRRTwXh3oyCJ2CUpy3Um6q10yQWTSxEQLiDtW17Wfwwms
Message-ID: <CA+G9fYsomsM_07yAZ=MShyjFRXLe26Vm+-tPv81YLOO-SPqo6Q@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com, LTP List <ltp@lists.linux.it>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 21:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The LTP syscalls listmount04 failures noticed across the 6.18.0-rc6,
Linux next-20251120, stable-rc 6.17.9-rc1, 6.17.9-rc2 and 6.12.59-rc1.

First seen on 6.17.9-rc1
Good: v6.17.6
Bad: 6.17.9-rc1

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: listmount04.c:128: TFAIL: invalid mnt_id_req.spare
expected EINVAL: EBADF (9)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log,
<8>[  467.451816] <LAVA_SIGNAL_STARTTC listmount04>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.17.9-rc1 #1 SMP PREEMPT
@1763732790 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: invalid flags : EINVAL (22)
listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
listmount04.c:128: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:128: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0


## Build
* kernel: 6.17.9-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ddfe918dc24b5818022af062d1685d31fcdb8b3b
* git describe: v6.17.6-1131-gddfe918dc24b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.17.y/build/v6.17.6-1131-gddfe918dc24b

## Test
* Test details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.17.y/v6.17.6-1131-gddfe918dc24b/ltp-syscalls/listmount04/
* Test log: https://lkft.validation.linaro.org/scheduler/job/8533736#L25762
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/35nQWH8wgEwiOrUmrLn0I3NGkyh
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/35nQUZuM39Pa120Y5iFXGyRw4Or/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/35nQUZuM39Pa120Y5iFXGyRw4Or/config

--
Linaro LKFT
https://lkft.linaro.org

