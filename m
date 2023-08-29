Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D8678C76D
	for <lists+stable@lfdr.de>; Tue, 29 Aug 2023 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjH2OWW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjH2OWJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 10:22:09 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AA0D7
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:22:06 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34914064ea9so3139215ab.1
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693318926; x=1693923726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wf6GNFsSxcx1anzAYYKpXcKsJT0xS0B+yb4Pte21nG0=;
        b=KdwwvdZogbw+TuR5vNbEJAhj35004+fY33HYtgviW2le936RoS7BLxHT2nfwHmC0bu
         nkkWr8Dr5iLLrea0ScQ+BFGAF6xV1H5GaJWmh6cAzOr5NU8u3CI1AHnnlmr+cq/11SxS
         R8xwhS8vGTparOL3sa72h3H4F0/JV/uftQ434=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318926; x=1693923726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf6GNFsSxcx1anzAYYKpXcKsJT0xS0B+yb4Pte21nG0=;
        b=DM9dWEsbY8DWXDg0oXwIKpDVnJpZdPTUuCwM8xq/KRMzWRnQQMyv09FPJYrMQqrMQ0
         xEATuTf8tZseB2S5axAmmlZhvCz/K+NiEv9z8rck+Xo2CwY3R1Wpx+0CzNF5I+4ur8W3
         lVELujjNoak+0DRcOxEpTJKFLEanE3PLUytJZspAW34v/alr1G+IbbLQJKTul+jK8nJN
         UiN5ceDZfXuz1gFlCavrag+5Kbac3/bLbc8E5fHafMcNgS4occv2HTsoWRSQvwhWuv+n
         QT71WtA5Q1asKi+eDgI235j0ORKXBT7XCVoSsWR/WF4d0sAUdrQQqZGEgWNi/jirUzo8
         npMw==
X-Gm-Message-State: AOJu0Yyg5j8YrhyAlK/5wK2EPgeShAjoJp7Qj4E0qUZUPkrswe/s+yVn
        Ax7vtpaBFiK3UZdJAJuK2VJ5Lw==
X-Google-Smtp-Source: AGHT+IEu1YVJL/d7gQqT5xXOlyC617XhMQ38RwAqUk/z/Kv5qvJ0qn/cmDqhUWI1CMt10A4ZirgvzA==
X-Received: by 2002:a92:d6ce:0:b0:349:385e:287e with SMTP id z14-20020a92d6ce000000b00349385e287emr29439643ilp.1.1693318925936;
        Tue, 29 Aug 2023 07:22:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i6-20020a92c946000000b0034cac5ced38sm3141971ilq.13.2023.08.29.07.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 07:22:05 -0700 (PDT)
Message-ID: <678a9296-c9b0-9270-7194-f233e9559fd8@linuxfoundation.org>
Date:   Tue, 29 Aug 2023 08:22:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
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
References: <20230828101149.146126827@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/28/23 04:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.193-rc1.gz
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
