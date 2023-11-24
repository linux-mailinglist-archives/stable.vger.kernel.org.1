Return-Path: <stable+bounces-2286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C27F838A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681192885BA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5AA364B7;
	Fri, 24 Nov 2023 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JKKMe4bE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6C126BF
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:13:38 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b8382b8f5aso1353671b6e.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853218; x=1701458018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2IO8yizkwbvbCYaFuIwyJ6cSJQCDEdd8cDV+Lv5n8E=;
        b=JKKMe4bE6W9BSAmHdyq/FTnUX7O06Xb2c9HvVg5moUF1ntnWvLQBHSKmDX6v2i3I1D
         YH31clLVDtjEwXDolN2424hRocwHAZDE2/R9LrQf45bovMC5z9KhiC1H0ak8e9DMh+i+
         6oiGJIvHRSjuf1VUDItsSE2qIZWeAOc24iYTM4qjNI1rPPgESaDha9km4pEKWYQ3mzOm
         oyrbI04JsrMJLnckcgkqC/Vn6skCUU/pGF+hR+pMX/W7c3oYEcKjZ21BPitKzpPG0dJc
         rT2IOz6QbzIrFbjDFZqoeHTb37s4sY6kYY2nWkqt3qM8k5b5ay+8XihCJexZQ+H5kZqC
         519Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853218; x=1701458018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2IO8yizkwbvbCYaFuIwyJ6cSJQCDEdd8cDV+Lv5n8E=;
        b=pR6BpZ2B3yI4PFhpTVCW54lsKQs6isKg0w7HG2EzJEgIjLyByektHGp/mTo1TIvOh/
         90hX1gQSXKad93Rfhu8DmDSVg4x+gveEWGuc+q35t/YGgN0g77ct5JkbymgSvQFB2fgC
         ghMP6ESrvv5c66VH7tR9UkXreFfDdiTk8SnlISCsEBz28QMohiZZTwb4WaByrgUUbAlk
         h9nFGD/mMgZka0DWa1anfdjRJehXTXCfcVmeyELIJHYihXx19Ee/b+ZBd8P1uvQweinO
         wgLeUJ01jEhRyiOM4l7K1XXjpKNBqM7N4RgtVeT21kX2x6J9yVLSx3S+/eyAAKDIPUL/
         t/bw==
X-Gm-Message-State: AOJu0Yw+SNDL0kEigJWXzq0dcXtZLXHIUibzFMsxma+7hsN3IJmFHliG
	fy2dCznUGHxMozNfouCBG9KKiPa0n8q9S85F9+ofnA==
X-Google-Smtp-Source: AGHT+IH/0sXZh5zqfrmOwBVpS6YXkNjXU+rhXoICsM0imj/RkzJhHK8GyS3CVsMYOcx8rQNu/MGYPw==
X-Received: by 2002:a05:6870:b10:b0:1ef:62fc:d51c with SMTP id lh16-20020a0568700b1000b001ef62fcd51cmr4609887oab.51.1700853218070;
        Fri, 24 Nov 2023 11:13:38 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id lc28-20020a056871419c00b001f9ef405fd7sm467750oab.24.2023.11.24.11.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:13:37 -0800 (PST)
Message-ID: <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
Date: Fri, 24 Nov 2023 13:13:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org
References: <20231124171934.122298957@linuxfoundation.org>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 24/11/23 11:49 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.300 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see this failure on Arm32:
-----8<-----
   /builds/linux/drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
   /builds/linux/drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has no member named 'has_sysrq'
     728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
         |             ^~
   make[4]: *** [/builds/linux/scripts/Makefile.build:303: drivers/tty/serial/meson_uart.o] Error 1
----->8-----

And this one on Arm64:
-----8<-----
   /builds/linux/kernel/profile.c: In function 'profile_dead_cpu':
   /builds/linux/kernel/profile.c:346:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     346 |         if (prof_cpu_mask != NULL)
         |                           ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
   /builds/linux/kernel/profile.c: In function 'profile_online_cpu':
   /builds/linux/kernel/profile.c:383:27: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     383 |         if (prof_cpu_mask != NULL)
         |                           ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
   /builds/linux/kernel/profile.c: In function 'profile_tick':
   /builds/linux/kernel/profile.c:413:47: warning: the comparison will always evaluate as 'true' for the address of 'prof_cpu_mask' will never be NULL [-Waddress]
     413 |         if (!user_mode(regs) && prof_cpu_mask != NULL &&
         |                                               ^~
   /builds/linux/kernel/profile.c:49:22: note: 'prof_cpu_mask' declared here
      49 | static cpumask_var_t prof_cpu_mask;
         |                      ^~~~~~~~~~~~~
----->8-----

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


