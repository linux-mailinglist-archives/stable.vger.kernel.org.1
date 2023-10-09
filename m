Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028BD7BEEAA
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378748AbjJIXDm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377234AbjJIXDl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 19:03:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2924A4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 16:03:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748ca56133so46444239f.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892618; x=1697497418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isNibIDfjCBz+AxQha4Vz6XAmq4W2W0frOEb93LFaIw=;
        b=cRi4SLRTfIaHKGebtDHxeVhrkDaNmTO2X+km9MIRI2HYPR21jhg/hIgyVEXTx+707S
         RJpr0l3A59dqpSZcLHFk6ysiDA8a+iMo862CTLeqEW7QZLiCW7fPB0AxOcmd54fXlKEi
         j4nctci4/zt7smJ2dctZDvoANZTSji5o1FYGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892618; x=1697497418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isNibIDfjCBz+AxQha4Vz6XAmq4W2W0frOEb93LFaIw=;
        b=K+UvZxAZGw/K5ScXxMorKbq5uU3QUxp1MjABNB9CDrR9OlEUIibiDAMneKcCWJcKOs
         aqD+xmIs5F5kR0F3KcsH40C2OQcrawkyCVLq6WMYD/qjlovm24lHWLy7wLKZKhlgDC6W
         K8WuZ/fwIlw8c3+Fgk6xV8bEhpkdMCFO2+qDN+JfjfmeVxsYE5EZdA2DWGG1OsRYbiyl
         7mP9K+ej+7U5MzkUQN8eHZy5WNN0pY+ibZC75Rih4UDfH+40Avj0eV0mM0oauasnqAsk
         AVyu3dADz1GfUVCR0YFIdYO4O10ipVJxpGL02NHZUcuUKrbl0j+PvODm4RxQjESRswi2
         JomA==
X-Gm-Message-State: AOJu0YyxvHMlcyePvZ/D6S4ldx/59JRnxPz6TbIdjO+aeTjKoA5bqwEs
        0uSFFOOUrU6rQnTeCI8X3KY8lA==
X-Google-Smtp-Source: AGHT+IFC7dB+rmhJK94YvLDte9VrWpF4MStdv3nT+6mBzwWpLQzXID6OdAsgCEfdl8dnfczLe/bLCQ==
X-Received: by 2002:a92:dacc:0:b0:34f:b824:5844 with SMTP id o12-20020a92dacc000000b0034fb8245844mr16033525ilq.3.1696892618299;
        Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a92c8c4000000b0035134215863sm3150909ilq.55.2023.10.09.16.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:03:38 -0700 (PDT)
Message-ID: <e60e435c-892a-4d9a-ac46-feb7b49b7f18@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 17:03:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/91] 4.19.296-rc1 review
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
References: <20231009130111.518916887@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
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

On 10/9/23 07:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.296 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.296-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
