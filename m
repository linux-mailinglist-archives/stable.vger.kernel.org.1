Return-Path: <stable+bounces-178947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67499B4980C
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4F61890558
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67F2314B69;
	Mon,  8 Sep 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KulParVi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FB3126D2
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355279; cv=none; b=LVxC35YeZB75HbRrOX+lUeYV5EpRkeI8z15f8KhPShZVmCc47TagMRWl3NVOJ6q3H+LiUbT5O0i8nRZ8f67A3wCuYJZ0kAnRAAwxBDCelCFC35qjhmeW49agK7Q6angBeHbojZV3EmIbmlc7Vh1BPTk8YwQ2WoArhwLFPZ2g8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355279; c=relaxed/simple;
	bh=Dd+pgApASQAzgj9X3zonS77Lm1GUV+22MQ9r9kA15iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft6QpqF6LA1XkfNfvsxlwredmVdj6X+poRcyKkIYmBwJkU35ElO+Tw4LvVoRHxMOAx4Sd/HkxrAxGyi3MEUWpVAXKdSBr0Rg1Xo2GpQyCxUAeXaHFZsCcVLL4ZhgtFP6NiWOWykqXPYJo3dBBlczjPkdXMICW9HjKv40s3W6UhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KulParVi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3716964b3a.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757355277; x=1757960077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa8ggLlyMVJh/eLNB7/vORTWXIRxgODsZo7MWhmnGSU=;
        b=KulParViFVt05a2wk3gGZhfcS3CXTQZ3E75p2wuhDJxuOZrKXGjCg+ZbJw07NoqnJY
         YxM2vkpiO0Cb7BcqPB7AEApIqaEPnwwZZMQczSChnKdv08nC+E8OT1YNF2U+rX2wzffe
         mXLRqYYe4akc0bFoUNelA3SaTxhqyPAMeiKyzvQuJRqBQH3hM1EN3f3o6JVzTgHjyKwn
         KIMqj/dZdr/tzG2MufEmnkeBjszB0cdcrtRYBa5SJwJYsJgUI6YTS52zqxIf7Rx4Pbo2
         SPgD4UJk/1xxtHtw2eot+LpALr5Aq+9HIS8CMEB2kUfKrxz+P1QQkQnf52kW9ztcL4Po
         hdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355277; x=1757960077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aa8ggLlyMVJh/eLNB7/vORTWXIRxgODsZo7MWhmnGSU=;
        b=DPdi31z51S4P0GMSgppyTAj/lQTJzgaODmNyU92arbxeqrGCVGDvLdYnnxS3kb2jd2
         SzhsqpW789Ub18rk0JLNsS7pgvJblQr1/OQxRxqMIW2YVW7clZZgUAxtueaipUfFkvyj
         n/7EW89F8xTFD8Vhwj0oRXKjeVi6razJQHzAMSJvXWUFm+1ar4mZwe2AYx7N2wi14RCW
         MjfDLwi30Bep5el7PMLICVR90Q4z91ktH5EepRoFLDgUzJk8GCo/IecLGfCfPVnBovXA
         ilhg5vdyeVB4fej07PM1749/pRp7nq90PJPSIX5qFToiaTwnY4I4nWdBugEB1/PKNBpf
         TE5A==
X-Gm-Message-State: AOJu0YzyBLMg8jJkDrT9cS2yTGt83s/QNaYqr3ZmYZChEfDTxKau6pf5
	BlRWsHzo8fgGdsSAttxEsYot0KqCoHS5HC/sd11AIBAEIp7NNmoXqMKR0ZztJEdBQE8BEPqrnq+
	JiQI7poPZ6arIRBRsK6HYf3A6rj7FbBLr9qwfPhXDrg==
X-Gm-Gg: ASbGncuS5IjIhTzhh6iWBJoRAzOELwbKoEiQJG/xzhbZ41fMcOW5j6nY8V79X49LYZm
	8ryXOMMftOquI/uy4XMdWwwD6Tpr/R3qWEzOqjY1OSK/nku7OKfxOV8u4HI6MssGZ952p2Plne6
	nfefnrwX7Uw+IdUMMIotogXZWIGxzJ05CycoEMEQEDHrw+admekWJEv5qM5VxEuYKsjrL0xXzPj
	m35kL3+3wu3d7DZt/2+SpR56YdNdZwKHYmZtPXvY4lS9MqwVEs2auOsiK4ld3fnqKEUvjuMOqoA
	ZfYMyiI=
X-Google-Smtp-Source: AGHT+IErypQRC4wzGQeAuOgUtnwtBi2ya2m51s0FvrrM40iFGJDv512kzAJrOm36DfnNRSDLy6uFdTKbm3aJAXKiWZI=
X-Received: by 2002:a17:903:19c6:b0:24c:e3d0:c802 with SMTP id
 d9443c01a7336-2516c896521mr127705465ad.1.1757355276936; Mon, 08 Sep 2025
 11:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195601.957051083@linuxfoundation.org>
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Sep 2025 23:44:25 +0530
X-Gm-Features: AS18NWCueKZLivBwekubKSawy9W-Z7KRPjuA564ID06uBm9Hh6QXYlMBZZtS8_g
Message-ID: <CA+G9fYsX_CrcywkDJDYBqHijE1d5gBNV=3RF=cUVdVj9BKuFzw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/52] 5.10.243-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, Netdev <netdev@vger.kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 01:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.243 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.243-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


While building Linux stable-rc 5.10.243-rc1 the arm64 allyesconfig
builds failed.

* arm64, build
  - gcc-12-allyesconfig

Regression Analysis:
- New regression? yes
- Reproducibility? yes


Build regression: stable-rc 5.10.243-rc1 arm64 allyesconfig
qede_main.c:204:17: error: field name not in record or union
initializer

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### build log
drivers/net/ethernet/qlogic/qede/qede_main.c:204:17: error: field name
not in record or union initializer
  204 |                 .arfs_filter_op = qede_arfs_filter_op,
      |                 ^

This was reported on the Linux next-20250428 tag,
https://lore.kernel.org/all/CA+G9fYs+7-Jut2PM1Z8fXOkBaBuGt0WwTUvU=4cu2O8iQdwUYw@mail.gmail.com/

## Build
* kernel: 5.10.243-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 910e092353351549f4857c48c68cc154c84305e8
* git describe: v5.10.241-89-g910e09235335
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.241-89-g910e09235335

## Test Regressions (compared to v5.10.241-35-g4576ee67df7a)
* arm64, build
  - gcc-12-allyesconfig

Build log: https://qa-reports.linaro.org/api/testruns/29791464/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.241-89-g910e09235335/build/gcc-12-allyesconfig/
Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3Hlq8fZQUSOfU5gyju24xQit/
Build config: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3Hlq8fZQUSOfU5gyju24xQit/config

--
Linaro LKFT
https://lkft.linaro.org

