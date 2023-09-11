Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19979AE01
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378631AbjIKWgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244322AbjIKUGu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 16:06:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E428185
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 13:06:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so57164139f.0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694462805; x=1695067605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vdcOYkDo7YYgDn3y9MlkiRl34kpqBQNFGUopW9ZjvE=;
        b=G2fPLsnBlhTtYX3kk4HX3HjyObbQIcuQZ7MTQvg7dbffL/hTJ3EyHjV9pcVvdIGyZG
         j55266iH3UqW9bn/ZWruKm4PpEtA4oSvH0tO9gAaA0+OcKNUNqhR5aztcNkvkrTuJYwv
         QMeQXMzFcAbpQqTFaYELVNQ8GnvTeRIzwaP9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462805; x=1695067605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vdcOYkDo7YYgDn3y9MlkiRl34kpqBQNFGUopW9ZjvE=;
        b=sYuDcXOqyfZpFOV5bp2BgdzomD425phHjLOE0BmTr4SJmVd+XHnFGqYm2/bmGA/lB6
         1T88BYWvSoZkRF7Ig2xAPJEANytMzHEE3oKnATfhw9d1Yxg+Qji1iSyYHJDoM4Pd7goo
         1stZn22n9B7KzQvw/rdY1WMM/yvFfsDybXA0qeOAV0k6DN83EWFVkdV1nTSmR7CUR4rt
         454N0Qfbg+cM3Jj2SPu20+JE4Ms4vLjEe7aFOL2ouZhCZq8fdJ1MPWTrxIip6WrmVr3n
         e9jnINl+SkdSjEKD9NPk7uzO4cAaCqmt4zamUUZZ8sMIlcVWQLd+Sl2SYJGQoYE5WLPq
         m+Jw==
X-Gm-Message-State: AOJu0YzgoJN7joXmJfFp3okGsLe0w+rVikwwpot+8fgxZuWz0UUFYtQa
        OrjZjf8HNSjx5Fe8K6K5YYU7KA==
X-Google-Smtp-Source: AGHT+IFWyI74g4J7b5VMjPOyOMsyz+RufAkrXy81JLdc8QUB4IHlAQwhWICvcnTmDPRDlM0vPfHyVg==
X-Received: by 2002:a6b:c810:0:b0:794:da1e:b249 with SMTP id y16-20020a6bc810000000b00794da1eb249mr13694459iof.1.1694462805495;
        Mon, 11 Sep 2023 13:06:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i3-20020a02c603000000b004302760aa6bsm2333572jan.4.2023.09.11.13.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:06:44 -0700 (PDT)
Message-ID: <a775025c-4e66-f414-5475-76698e30accf@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:06:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
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
References: <20230911134650.921299741@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
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

On 9/11/23 07:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
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


