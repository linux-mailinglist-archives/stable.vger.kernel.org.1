Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1467DD97C
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 01:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKAAMp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjKAAMo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 20:12:44 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E85F9
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 17:12:38 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3593d2018bfso503615ab.0
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698797558; x=1699402358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BwcL3Ik8T32BxWkj2vJ8XwaP5u8yJv04op8qbH8gSeU=;
        b=RbECe+/85LOcr2QYiZTtUv5TaobgBGRIAaRNh/Cl6chtb23tr6zXG79KP7I2ogalZ6
         eshzMcRN+XPv8xt3zQwD8RHinBVVRxpZZdHJU6UV51NGP7czTBXKJIYgOW8+KrbmVnMY
         od8x+qtv8Odv7sExTlP0gKxSc0HF+P749xcu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797558; x=1699402358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwcL3Ik8T32BxWkj2vJ8XwaP5u8yJv04op8qbH8gSeU=;
        b=aq/rb8A+9ixnAL5TAjaXraZDwZLpBF3G5Fcm19At4w4TTKncsMZmPUTefDnEt3ZTLx
         sC2OJUuXRMrjlumXEFtODU+ota324IQcPX3kFUoq1dNKpNPYnKlm2TtJKJh3Giyp9IEw
         RTzHJWaRZA8o4mpRW31oT5FSHaYEpxU0ZTZUwsW+GZKhYjpFkVpcJ5I2RZBI/1LMMGN5
         kvcctVnZLXJ9exsVs106ohOw5ANIHl8wOe1qtxr6ZNtmLXzyc2uRI2Uq9dwaTBFaA15q
         xv3tyF7kygjoIcVTKFZ0KhqZkMNs68c6T6Of+Lt4agsEJeKahomrgcgHFrwcJsgbSnlx
         yNMg==
X-Gm-Message-State: AOJu0YyDxJmLecwoIvOi+4zCdHuD4cFzXupV2TWAETHoJtMr4xmSA7SF
        d62dd1CP0JPBAtUi9NBuX7xvoA==
X-Google-Smtp-Source: AGHT+IHA08hW6m8f4biMPB2WcC+NaLNCFuUv0MuE9T71mbKNniGSDZQQg031gfS6dQ6dGWPLA01YOw==
X-Received: by 2002:a92:cb11:0:b0:359:3d9a:282e with SMTP id s17-20020a92cb11000000b003593d9a282emr1831910ilo.0.1698797558113;
        Tue, 31 Oct 2023 17:12:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g19-20020a92c7d3000000b003590b126f15sm134627ilk.72.2023.10.31.17.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:12:37 -0700 (PDT)
Message-ID: <66a02bbc-0679-4b32-bcef-7c108b15b346@linuxfoundation.org>
Date:   Tue, 31 Oct 2023 18:12:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
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
References: <20231031165901.318222981@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/31/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc1.gz
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

