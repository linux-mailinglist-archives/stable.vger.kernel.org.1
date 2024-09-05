Return-Path: <stable+bounces-73594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018F996D817
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 14:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD47B1F2338B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232019AD8E;
	Thu,  5 Sep 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8tlkCrC"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7C1993B2
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538553; cv=none; b=eAHp71OPY6EZ9Dnm5utrM1WbhGMqUl49RRUG/gBWTxWNmXHtzipio3TpXcCPuP3j58kOI53hOiW289sPP7BXPsuos+xT8CZTiXtXzK/2P9VpdFhmDFG7W96pGX5bJlkf469h1ICo7b3kjjKUsJUiOjEhWWGDtWvpbkMfAQLMM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538553; c=relaxed/simple;
	bh=mUZECu3XD23oLtyR4TiJ+f4tm2Ge2L2URhkjRFEzffs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmqDzpewR9jqsNa9Vt49zEiBWXlTAqM+nwcrIEdWdtqAJuJwTpZ90YEVBJQ4tgoiCE80iKoaZmEwjgn4/u1ksrkWv3pdxOG7sp//k5r8SZAVcHDK/lxgcZ03usPBrEPjtHq2Wj6mqenxDsRX3zmSQcWK6yVRY7ptODi2Ems8/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8tlkCrC; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-501204753c4so258184e0c.0
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725538551; x=1726143351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qnz+skM7CpabV9IsCJlSuO/xZoEhUXery/iq6oi7kw=;
        b=Y8tlkCrCMs6h2kEYRuundpwZBY4HlSygy+5++zcdw8l1m6twHBC+pfssfLUlnFzXjd
         63op31FHFdsrjOVh02YITNvPQAhqgcdRNmqYKIeO69fkDb0c0wJX0uf6m1o5ejGEP81r
         CpLhOeJ3+xztNzWofbSqjeIPLJsYkRuu3zG5xDiXlfsqjXfpgSG9KWwvFGjVtf+VDu1w
         LLoT6htCIsZDYdAU56oMq4Ng4W8kU/vIWZpYnbH38rVhRWrEAnHXoiYM2L5hW0Pk0kJh
         ZqAnJW27gQS6+nBd+WWwnv3E6sROWaufFebreH/zfXZ6ADDeM3hjcZ2VGiDAqcNJeRc/
         aRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538551; x=1726143351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qnz+skM7CpabV9IsCJlSuO/xZoEhUXery/iq6oi7kw=;
        b=fOUy3QHFp8HUduTbUFYnNV5+A/4QLB++zV/1Nb/Hqca5hrAsZZIb2iEqAb+Sz8WBVx
         2llrvROkXbFWEaea8+I1jpfRWt3JFA8iCblkpaBjzY4XMNq5arcWxjMvuP2qyNVqDkiC
         hFx14eSy9//Fp5rq9jS/SG7jy510EeXe4drTFqCEr0Jjl6vLYqVQeMx0po9Q+z5YeQAO
         PrSWTFSQ2f3oAtC/zsLkFOL0CslZ6xnmYzCVF4VT0t/KtrHITE1YA9fKV2NPordox3Qi
         NaIwIFttyhaHEKv1zjApCAjq27qg0R8+vClfIXq3LjA/rLTqQldwNM2jDrENT3DQsaGx
         t8fg==
X-Gm-Message-State: AOJu0YzVcdyo/BfO1oRmI2Xb3oSlptYd4KrvVuNgChxXVZC6SdXRnj8g
	SK0yNzGHKjnoh+3r2BmBovUq244DZnxA8ZQny0URJno7Lp/fCX/+IyV/Jy9bihmQZHFZxdGCvLr
	Jw5JnFIu0HYt77A4ycsCzkq13qqWSXpcmkBVHxw==
X-Google-Smtp-Source: AGHT+IHNYqKainf94hj2ADROXtyYoaLPTdE2ATA2hVcEBZwn4nrhEx7B/lOd2f8OVgUdvkWrxNqMZsa4q+oGwgZSxhM=
X-Received: by 2002:a05:6122:3b11:b0:501:1aec:d2c4 with SMTP id
 71dfb90a1353d-5011aecd469mr685166e0c.2.1725538550826; Thu, 05 Sep 2024
 05:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093722.230767298@linuxfoundation.org>
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Sep 2024 17:45:39 +0530
Message-ID: <CA+G9fYtziUjN_J4fdwDH4Sf0RguW4h3X9OEO=ZvJzt3dh9hnaw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/132] 6.6.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 15:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.50 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.50-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build errors noticed while building arm64 defconfigs with
toolchains gcc-13 and clang-19 on stable-rc linux-6.6.y and linux-6.10.y

First seen on today builds v6.6.49-133-g18327dd4281a

  GOOD: 8723d70ba720be0b854d252a378ac45c0a6db8a7
  BAD:  18327dd4281aaea9d7639a33a52a7ec57c97f942

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build errors:
-------
drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_advertise_quirks':
drivers/ufs/host/ufs-qcom.c:1043:32: error:
'UFSHCD_QUIRK_BROKEN_LSDBS_CAP' undeclared (first use in this
function); did you mean 'UFSHCD_QUIRK_BROKEN_UIC_CMD'?
 1043 |                 hba->quirks |= UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                UFSHCD_QUIRK_BROKEN_UIC_CMD

Build log link,
---------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.49-133-g18327dd4281a/testrun/25035737/suite/build/test/gcc-13-defconfig/log

metadata:
------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2leCGwTPT1TApOAJ20gB0VL84XW/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2leCGwTPT1TApOAJ20gB0VL84XW/
  git_describe: v6.6.49-133-g18327dd4281a
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 18327dd4281aaea9d7639a33a52a7ec57c97f942
  arch: arm64
  config: defconfig
  toolchain: gcc-13 and clang-19

--
Linaro LKFT
https://lkft.linaro.org

