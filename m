Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDC7BEEA4
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 00:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378972AbjJIW5w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 18:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377234AbjJIW5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 18:57:50 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC6B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 15:57:49 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fab2caf70so18830539f.1
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892268; x=1697497068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OEcyx+CG+G2DX8k230kBj9Zk1p7l6RAqnhFlG0dPE0=;
        b=JQQEUTKlKWmhfLKcS8uMvoKu1r5+RV99O4xNyzAYxjdabiIgxqg/3sotiM/VaLGXr2
         BOPLmubVmnAGg+4WztnMMugbV2n4L/ALbpHo4CqLVDdrCatXiujvtTd0WACUnpCSoYAr
         fleb3TM4DCv0ohO9Swzug+qqI0AcdLflfdISc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892268; x=1697497068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OEcyx+CG+G2DX8k230kBj9Zk1p7l6RAqnhFlG0dPE0=;
        b=mm+aA0lrglTsx/hcMGV7Au3MyMncDgJONTUK0YLwNFb90c7dUpr7CZLi4/FfaUnaeY
         oOknfyAIHiwyinwxm1kmoc08uYSq0qugGLTC9BC/dkzLUUP0qWJTElICFekSag1LxPpG
         y2PlGYJeP02AnYvN1p2Rpa/RZ9uoICie7doithtepMAdX4oe/kOrUVIGWBMD63ozqXkF
         uxhteXHmQ0ioN9Fm8TYCDUT0/ef3paJJzSaVV3vPsi4D//Nkf/Kn3aZjsYLrF+wG+zfq
         0ttgcRoP7ONhSnAIYiCbmH2XAszrnOmCCIA0dy+MPQ07p086tAD4pHoNcgu58kCeWflc
         HGEw==
X-Gm-Message-State: AOJu0Yy/xJ3JK/14us0k+wxcUO9q2JMEFUejFiCHLeWh7oKgHPxqBQkB
        /tpiouEHC1/4Vae+WIa+hqww3Q==
X-Google-Smtp-Source: AGHT+IFbTZ2wIH4yqfN84dEc3TWbmavjElIAAr7btZSRiegZjepleLuOOmWAR//KMO3Z9SVLZvXinw==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr17549615iob.1.1696892268502;
        Mon, 09 Oct 2023 15:57:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j2-20020a02a682000000b00418a5e0e93esm2347740jam.162.2023.10.09.15.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:57:48 -0700 (PDT)
Message-ID: <98ce539d-481f-4897-8d30-13b6c57e5b74@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 16:57:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/9/23 06:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.198-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
