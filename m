Return-Path: <stable+bounces-18690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C16848411
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 07:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE5F28940E
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727C13FF1;
	Sat,  3 Feb 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUeyq5n3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510916419
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706941419; cv=none; b=U+F1phW0EmWHZsMSTf3rSnzomP8K6/JY0UCKe5Gkoby0cUMywUxLyLmAbyoX6zhQkcanRw4GJds1pOyuG8wEAOCoze0rhCefSc2n+N0IG0kKd5DnwIsBQaDWkLbfyyLW+6nwCq8c7OmnMDvG66KXCGC00MVVgDLQGuRQuFSjimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706941419; c=relaxed/simple;
	bh=Jn3PoFXKEd5njDWhISFAGN3lFjLWLAEnXNMTpfnhA10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTfBM8587e/5f9VpaXW3a5SbI123Pgz4M1cgN6b0baPYuRoVNX7xz4oH49BZb84f0z0fFRmCrh4CTyvSBj/OvjdBnJNKTp6A25Q4/lBcIPPFAbyfs9dELEiUP76VvgKF11Hd/sGukZ026H5d8dKnU6suQCJwfEwv/hRuJqfaeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZUeyq5n3; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e11988708aso1210706a34.2
        for <stable@vger.kernel.org>; Fri, 02 Feb 2024 22:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706941416; x=1707546216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wx/FHR/ZkCwr2WNzTYSorDZnzq3qTx8t/b03FExQ0Ys=;
        b=ZUeyq5n3ghb7uwQA7Hwhvwkf5TY7/xQWCYgXXbUJrfQVc1GiHorRX3D+GW14lI72SC
         cE6eXPrHBJ7iln+F1cNUWEutHZrSWyS7xn92V+K9wO580j3RLpvRRmr2heSz6lsSQfLs
         VOed52vJUepGrPny7V+2teCStwmsyJ75O/obBSwlO2wjl2bUH9saXNlINnyxrBouFcPV
         tUEulcmEZMceNtguotFw3tFcasuXbzyQgua8e3wikPFvxj4LBsahUA0xGhT+6nZptehP
         8uaeaC69cV5eaBYf6TWBqEeSoNBMtsPIkyd//g6dcB5826TesK4MBWZuvLuYfLRUkHmy
         wQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706941416; x=1707546216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx/FHR/ZkCwr2WNzTYSorDZnzq3qTx8t/b03FExQ0Ys=;
        b=qBpnhsGLUExRr4wrgu/5ftsVewWl9T1Os34YMNXoqSESA/r/nFA8uwV1W5r4HVxW8k
         NaEC6/jZTYnPQ96/MLYEqAVZU09RaXGjKU9agVDhNKQD4I6unhLoVt2pU4L3TjMoahm1
         mClKItvOoJ2Wh+o3ABoul5PxwLnUS4NymUMk4uxXyKQr3IV4gqbwfy7Jja8otGbj5cm3
         bc6KJtRsZoASfSFO0zuoYjLcP+5d7sixcNw0gA9MqTPh3Lq7ivi13na27FK0GDvuN3kz
         LsQdZIQiGvdppk3x85koZWMGN07wevayNew6JLpWbKS4xBwAbMN+GbN5fmvkukDAesYD
         qh+w==
X-Gm-Message-State: AOJu0YzUzjHi4a+QMjWtKDoft3y12nCwR92k4aqoNFr8mOeGrWaBFJDm
	34ZXd5QSmY6ubEx1zszuHb/EAiUxDtAAXLtb9YCmQQJuqCArKueq5ZjXMRFagpA=
X-Google-Smtp-Source: AGHT+IGLJilOGe9v4pmuX80A+qKaROuFu7kzLvZdDC1GQJRyjaU5vat3w3/xfQ28LrId5/hQeqQ88A==
X-Received: by 2002:a05:6830:1d62:b0:6e1:ff3:d369 with SMTP id l2-20020a0568301d6200b006e10ff3d369mr7957113oti.25.1706941416142;
        Fri, 02 Feb 2024 22:23:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUk9PvWOAPudwGGHN9T1ZSTyXKq50ExkdujlKU2whjYCSJ9N7/BRayi1o+WenYiMMmzyPb6NN+JGLdT2yu1SimMNfg0cgM1k3VYlqxYO2nmW7xUz7jfwgQnLDpEgzsdIZxc40ieXGYkOzRQh5RgXJx7Wl3qsk8tv6ck9oADWpSTvRtbfN8TAtSX+bolhHUa822u1CuPIRKOUaEJ9ssjaHGDnrX8Sa3n7KPmq9CK5XBT2AQDX5SIwhB7RFsl0h8T1aUEdwfifjaS+LZkUaJATgwrMiTfL0wAEKOvcqbYV1QPltwxrakfWjwjxr7DR1Dgq6mvLUQYNFOm6dTegICAhIn0I6c5EUwxnZIuvPdCOnWNln0ar/DYNY0nJ287Teebai/uZ6Mk4cXmJwU1MfpBf4EENSB/QEWWjVbWkaodhph/bpS0q6j6cLi0UCnPgW2k3bc8nsIJPadvoqhfSe24H9Jq3tumEN/rShtwnVCZnrr+GMVx6xAsKR/Qf0kKPMWw3aCoPiVvXt0uWpqjht/Z1HaAbJgG9+FcFsiBPdydPvwGhlBiB+z7AJIAkw7eqw4aaOnfXwjEL812SqZSHhk=
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id bn11-20020a0568300c8b00b006e1363a01adsm691471otb.57.2024.02.02.22.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 22:23:35 -0800 (PST)
Message-ID: <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>
Date: Sat, 3 Feb 2024 00:23:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 mathias.nyman@linux.intel.com
References: <20240203035317.354186483@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 02/02/24 10:02 p. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing lots of build problems and warnings with Clang 17 and Clang nightly:

-----8<-----
   /builds/linux/drivers/usb/host/xhci.c:1684:37: error: variable 'slot_id' is uninitialized when used here [-Werror,-Wuninitialized]
    1684 |                         ret = xhci_check_maxpacket(xhci, slot_id,
         |                                                          ^~~~~~~
   /builds/linux/drivers/usb/host/xhci.c:1652:22: note: initialize the variable 'slot_id' to silence this warning
    1652 |         unsigned int slot_id, ep_index;
         |                             ^
         |                              = 0
   1 error generated.
   make[5]: *** [/builds/linux/scripts/Makefile.build:250: drivers/usb/host/xhci.o] Error 1
----->8-----

Bisection points to:

   commit 37ef029fe9a5639f12250f75f5d1594c6a11e181
   Author: Mathias Nyman <mathias.nyman@linux.intel.com>
   Date:   Fri Dec 1 17:06:47 2023 +0200

       xhci: fix possible null pointer deref during xhci urb enqueue
       
       [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]

Reverting the patch makes the build pass.

The problem manifests as build error in i386 and x86_64, and as new warnings on Arm, Arm64, and RISC-V.

Some reproducers:

   tuxmake --runtime podman --target-arch arm --toolchain clang-17 --kconfig omap2plus_defconfig LLVM=1 LLVM_IAS=1
   tuxmake --runtime podman --target-arch x86_64 --toolchain clang-17 --kconfig x86_64_defconfig LLVM=1 LLVM_IAS=1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel Díaz
daniel.diaz@linaro.org


