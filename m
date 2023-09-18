Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2A7A55AB
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjIRWUD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRWUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 18:20:02 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369738F
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:19:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fcb08d1d5so1733445ab.1
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695075595; x=1695680395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQtkVy0bBjiY++L4VDVGjsqSDZ1al4llsn1ovHo8nPo=;
        b=BuUubTp39ukGBpuXqzCOT3i4UxXAXbAsKCXxE7ttMoekWRp1cOvunpSvfqmAqkurGH
         oNcYb18lR2BUqeyEhc6WC3mnc37+SMv1qnE2pJaUnJ6niEiRGfTqlujWa5gV1V7/9etP
         kXN6cJ9I4bjVFuBv51+PdL1niVBKkWk6pW4nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695075595; x=1695680395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQtkVy0bBjiY++L4VDVGjsqSDZ1al4llsn1ovHo8nPo=;
        b=WWGzfjATh2NVh3IDfa8l6CXxz9NlbmVIP6XKdcHadj7HVZ6KkfmLEEu2TF3Dw8tkMg
         vFg5xQY6lcK3njGK3ntGEr9JwcL9lg7vyFGgUbKJ5J3LHRml15ZUAD/14CfFDP8doSL2
         61wp+BxvRZ+A2yr0m7J9uQ2WI9/X8vb+xGn9dqxwRKW4Uecsl7nJIbuwBhoc7hPtU1Eb
         kXfWdI2aO1h0TS1yXPkt807bVfUIbCeGttSR1bD6zsJF9aBrmTI5oFHrHB9m1xosR0lB
         Spx34ALG1Ly+TMi7h4T+6ioxAPDF4Cj4K7vCfSdlXFaYCLJeeU5GtT3iKu2eP9Vk+kP1
         UAyQ==
X-Gm-Message-State: AOJu0Ywm5LEwMqc85aDNiIDX1U0IpH4TxUQHBpszp00OByuS/ZhmyHX0
        iWKbFilM5BErATEBj3UyIi6DRw==
X-Google-Smtp-Source: AGHT+IGhHG2GWoVd+m67RgtbSpgQz/v41HIUXEkQ9EnlB6GmJaiYZUTQduVR2tkiUNR1L5MrITSeCA==
X-Received: by 2002:a6b:5f1d:0:b0:792:9b50:3c3d with SMTP id t29-20020a6b5f1d000000b007929b503c3dmr11061093iob.1.1695075595589;
        Mon, 18 Sep 2023 15:19:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dk19-20020a0566384bd300b004165ac64e0asm3250361jab.40.2023.09.18.15.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 15:19:54 -0700 (PDT)
Message-ID: <f5262d8f-82af-1f1d-b21f-fc95604e4b99@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 16:19:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
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
References: <20230917191051.639202302@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/17/23 13:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
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

