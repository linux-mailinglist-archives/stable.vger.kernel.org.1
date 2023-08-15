Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62D77C4D6
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 03:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHOBAt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 21:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjHOBAm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 21:00:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7F133
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 18:00:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6878db91494so981382b3a.0
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692061241; x=1692666041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0tOP/Sk6SaxW5EklQ0Kq5WadLaqCBXr2GTwbhwi+As=;
        b=CtJFJvXmPcxT4EArqAzjCw3dUzTUYdofM/MzgCqWTHeaBWUsS4Dm/5+n0VlW3JODgH
         JQsgLFgjyjZLLCQZ6IUObIJynAgun1cPKmurzWOk3uMfG069m+C6XI6UTN3++riX28YP
         86oMHF8ymVGj/MUmlJx6Dbh70brLDusWJXagQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061241; x=1692666041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0tOP/Sk6SaxW5EklQ0Kq5WadLaqCBXr2GTwbhwi+As=;
        b=PT3I35d+eegH2grEGf8j37VtOx9HoZbzxbXkS4hldcJwWU4Ee8wriPKvhMLQ3el/QQ
         6VrYpaTYSO8trQsz4NtU2qNijR2w0kDuIPnJdG9gfiizeo5x7y3jl1B19rS/qb7RJ847
         ODIO8xaa2WFE8/CVxoMtlNp3aP9aKC2bORArX/PpsPKz6ZKkdemoTh/lbJ1fa3mnEg+7
         QMNSOIqUvyzL+ZoX7ns/TNKgJRfDqjMhJQ+xqpz1qbxddyVcboiJy9+64mF7jeGHBJUk
         sQAdp0juUFTUgV1WvOFIewORx/nLY/e8PIwvZ5uxMRpmpKOIeoUwz91BCWO7gHzEyPWG
         dG/g==
X-Gm-Message-State: AOJu0Yyyhi0K3g5rdOC+gIvlca5cwNkxrrJaPelJi+JlrtVKe7Ot7HSR
        cW5f6otWCT28y2gXqBdTUpg5fuzPCEuz5wqPoyQ=
X-Google-Smtp-Source: AGHT+IHlrrS+jS+og76YUa8EoyLSWx0CRIu3vN6zTO5d+dOrQZpvb4VyJhrYCvo/YV3WEBBhqEmHtw==
X-Received: by 2002:a6b:cdc8:0:b0:790:c991:8467 with SMTP id d191-20020a6bcdc8000000b00790c9918467mr13076492iog.0.1692060640948;
        Mon, 14 Aug 2023 17:50:40 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id eh28-20020a056638299c00b00430245071ddsm3309996jab.176.2023.08.14.17.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 17:50:40 -0700 (PDT)
Message-ID: <b47405d0-1bf7-be07-3059-41c66cdea77b@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 18:50:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
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
References: <20230813211710.787645394@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/13/23 15:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

