Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BE57E4643
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjKGQlD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 11:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjKGQk6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 11:40:58 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1B19AF
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 07:51:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a9447c828aso3374639f.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699372294; x=1699977094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAzxkP10OQDM9YOWOWaJJRML05AHefjemOIWQGzk+qI=;
        b=NXD+GXMygJbxokOI9+pUGnO4C9RUv1da8ZVPhePattmiJrKqbAeCt0sCuGtXKEJ8E1
         n2Prvim4rXxGJuhqPhucPB9eesKfuYVzePKIo6ifTMn0L4fmq3x723ChpW1dXwQyigt8
         qqjyYn93pZt4YxNGkrOKSCPRWAYaewDscE70M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699372294; x=1699977094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAzxkP10OQDM9YOWOWaJJRML05AHefjemOIWQGzk+qI=;
        b=jMxUZVuk6iADJ+Qfj2rP0AJTHQCKfczhPtnbKSA+BMMcFgza7EvSs7E9GI688eGElu
         Tz9FlBFujA+w2e1cJ+d4LgSrWnCWbIL3hyuc/0Yn4xE+NOLtVWJwRamuMjDFZx4xtaWh
         ToCcIAH57pcpjPTATtgDNaWszvzqrfjCwuPPh33/3KkVjuSicyPkukMqn4Wi5Go4vnQb
         tUHFFsi4B3IWkKkZisBLemXPIc4bVC9BBrNuvwV/uEbb1ua6b4weM2ItzA0OtlVjdZqH
         qU9gH00dkpdQHMgUa+NQw+kOn5NW7Z0rV6hHWeRUDK5vWUYkzHCiR8eSy3xczsDPEsVM
         oogA==
X-Gm-Message-State: AOJu0YwP9axgPXMygA7DPAXrzfhfArRKcAZOkqu2B/wBqKbvSH1BXkgN
        0jZdLA3Gpa1i/RHVHIoWIvCQ+A==
X-Google-Smtp-Source: AGHT+IGv36r+ShQUykCndJzyqw+Ib+370gxiK90Ut8FZCZBzlh3wm4c/To1ndWM2b46rlfXQKkxINA==
X-Received: by 2002:a5e:a80c:0:b0:792:8011:22f with SMTP id c12-20020a5ea80c000000b007928011022fmr36342555ioa.0.1699372294206;
        Tue, 07 Nov 2023 07:51:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id m8-20020a6b7f48000000b007a278f16881sm2899101ioq.42.2023.11.07.07.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:51:33 -0800 (PST)
Message-ID: <ae5bf8c4-23b8-43cc-b6bb-ce89076fef4c@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
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
References: <20231106130301.687882731@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/6/23 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
