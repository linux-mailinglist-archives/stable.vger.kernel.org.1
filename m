Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F679B824
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbjIKVHv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjIKUJt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 16:09:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B6E1AB
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 13:09:45 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34f5357cca7so4499865ab.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694462985; x=1695067785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6Z8kcoZfdqrD4VAC+its9hMTOja8wL+SBN6X63Af10=;
        b=hJd0weg9G6YUTNwQAgWAnQuFFk7g3yfDoBhkK1bXaLU2DG6GuuJPLCDFLa1DDu2oDK
         bqwY4a0M+bULqHECRPvWdACVvAIsdvL/on+WQv8ynZzUx9/wieBUTMxqu2GZPe4BZRVN
         zJi5XxaEytgvT10zIPBNGnh8qzUyMGsqoln7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462985; x=1695067785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Z8kcoZfdqrD4VAC+its9hMTOja8wL+SBN6X63Af10=;
        b=SMeo6+iEYC8C04OiYeEOSv+YprAzFR4ejNRRm9shA1x0FpOZT1ttP2sgpNhWHs3iTb
         kwQ1BahUY7DsN5mahUBpAh7QRimujc5KkitjpQWh+FJbNxJ/0XgjgGobSI1PTmZ7t865
         9jJcR1yj81FYvECQZyYfeJ2LZOU2CksgsXh6fW6qpKkH6+uSN9oFUWzq4RCfL1TGQwsb
         h02XuP9zxykVJEhGPl7NOOKBYF9WvJoSpaPB3gFAUqxjARsodKxL2yeZ6WPNmeFW8SP5
         Fb6VAmcPZ3HOeRwK75Vnmk74YkV0+OC06RwP9N1qjgPY7nEm3zqWq3qLMOBOVJ2e9zno
         j3OQ==
X-Gm-Message-State: AOJu0YwhALZG2s+oaGi70E+FB6n8rwrDI3uqtf+NCp3DQO9TrqqSfxf7
        Vmc8MFaosrDM87nWJDhI4uBzDQ==
X-Google-Smtp-Source: AGHT+IHl7dEk3Usw2lbA4i6Du78JPOPDv+eJN2JrRzjfuzVVE4YHa04mCVuFcDZEenbGJoV25HF5dA==
X-Received: by 2002:a92:dc05:0:b0:349:983c:4940 with SMTP id t5-20020a92dc05000000b00349983c4940mr10587304iln.1.1694462984855;
        Mon, 11 Sep 2023 13:09:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q10-20020a056e02078a00b0034901a2f693sm2575834ils.27.2023.09.11.13.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:09:44 -0700 (PDT)
Message-ID: <a0dfa3d3-da47-56f2-b486-c9d607f9749e@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:09:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
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
References: <20230911134650.286315610@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/11/23 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
