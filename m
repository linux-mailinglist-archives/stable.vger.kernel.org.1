Return-Path: <stable+bounces-2571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D65D7F8884
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 06:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F211C20BC9
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44E34415;
	Sat, 25 Nov 2023 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9TCGaXj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24319E
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 21:45:13 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2e72fe47fso1641672b6e.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 21:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700891113; x=1701495913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YtcVT0tO/faU6pBapwW4pF/eOnwAU4GwA3kQ7ou57Q=;
        b=b9TCGaXjju1T5l/bw/G0ao5bmLuAGtTCuufBms1tk829AJAsNHhVptN7JqtzMIcVRt
         Tfiy54ej7G739QaaZVNN0omAPCOxpzrITgtDOefZTq4qyiKyxj2z1tESKclSfLr9xL6I
         X0QydVCe1OExnE7FZpW3nrUtr7NBLtZSRp/og59g8BdoSm/qViqL7koxg44N50opXEVM
         kATPsj9bFvkJQBntEeBooe0EFqDI7qs+NZHplhDRKbHl71vvP59he0NJiEs/sTcqJGzI
         qeNdVtwyh1zfQEciyfOR3V6B3nVl9WMdcW1H3bVXW+Yxx2FbHLUmPJYkbyKnMNA0DQ5Q
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700891113; x=1701495913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YtcVT0tO/faU6pBapwW4pF/eOnwAU4GwA3kQ7ou57Q=;
        b=ib5Rp588X5P3AzJAd8BUws6U+Mv00hEe9INsJaYZCw1dYzPIz8R+H+LvyS0jy+h/6m
         Su5vB9K1bMQTHbZb2XEoPGrzPca9x5hVFpVSWNaq1/eT1K+sKj6ee4mnnXFv9RpMmudy
         6bfh60LePGcu8wnf8/7/dq5SGMUbnscWo1JvCmKzto4SVDta5sbc4ra7Qaqg0m29vVnC
         cvGHevx1nKjel0mLJ/TwT5NfC2E4D5EDnbmndMfmtcKPQrlPUBqtzSmkj4nXOs9Gce8c
         +ThLA0amemdEK/dVN2I1GO9/XPHbrrL8jfoP1uE68bvzlP8E0sB+aFsC5T6fTnVHMcKp
         lQcw==
X-Gm-Message-State: AOJu0YzD4EesWyzTAlhmbjx6A3jzSxgVs950gRxwMNhHx9+xqzeKxAh0
	hjrx+28+Ab3eKL7hPOEfHRUrag==
X-Google-Smtp-Source: AGHT+IF8hKgzamcS6ks5XPNrfLtxKvTT7kP1+08AKQ7V7ZC2VsynTR7rqVJLUmxGjFzLY3gdcJkZOw==
X-Received: by 2002:a05:6808:2111:b0:3b8:3826:6dcd with SMTP id r17-20020a056808211100b003b838266dcdmr727299oiw.25.1700891113007;
        Fri, 24 Nov 2023 21:45:13 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id bc10-20020a056808170a00b003b85ad8e75asm163754oib.6.2023.11.24.21.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 21:45:12 -0800 (PST)
Message-ID: <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
Date: Fri, 24 Nov 2023 23:45:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, jack@suse.cz, chrubis@suse.cz
References: <20231124172000.087816911@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 297 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We are noticing a regression with ltp-syscalls' preadv03:

-----8<-----
   preadv03 preadv03
   preadv03_64 preadv03_64
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
----->8-----

This is seen in the following environments:
* dragonboard-845c
* juno-64k_page_size
* qemu-arm64
* qemu-armv7
* qemu-i386
* qemu-x86_64
* x86_64-clang

and on the following RC's:
* v5.10.202-rc1
* v5.15.140-rc1
* v6.1.64-rc1

(Note that the list might not be complete, because some branches failed to execute completely due to build issues reported elsewhere.)

Bisection in linux-5.15.y pointed to:

   commit db85c7fff122c14bc5755e47b51fbfafae660235
   Author: Jan Kara <jack@suse.cz>
   Date:   Fri Oct 13 14:13:50 2023 +0200

       ext4: properly sync file size update after O_SYNC direct IO
       
       commit 91562895f8030cb9a0470b1db49de79346a69f91 upstream.


Reverting that commit made the test pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org


