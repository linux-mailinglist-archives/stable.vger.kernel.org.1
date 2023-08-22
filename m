Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F2784377
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbjHVOJI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjHVOJA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 10:09:00 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D85E61
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 07:08:30 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34bb0e34fbdso2420185ab.1
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692713254; x=1693318054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBfudvUcA90EgP90c3v1NclyXmUuNio5tYlPAp81Sm8=;
        b=Kk7aV1ur7Cvckuz/Bd9P4BhKHhmQAiMPV+fMlwGEi+SxBO46i1nlYevp+ubhEycSuA
         MftJWe25tMghZ2NeR2w/i5uPhANZRgn6QJ1N99FBB4+97S2f3O1NXPtmADQ8xwvxoTJa
         9XQvFibSYrNXk207p0x1xJLA3Ag+gyyUta74c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713254; x=1693318054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBfudvUcA90EgP90c3v1NclyXmUuNio5tYlPAp81Sm8=;
        b=XAdPrFrAyfszDOZMV55+hFBXB/ejn5MWnKk+UVnSPNsfYVdE7jsJPebalVcnalVUjh
         KSSIOqtefik5mtYPQK4hCDbmpoduy9qys/12zPm/ipKnePvEq+M1A9YXnaNGW68D96bc
         aOp1gVzOPxC1N86OrM8SK0IresG/h2r8h01y9nnsysiJZK3Y528+rnvn+/FRwffijRte
         uDVjVEb7jjA1v5Aa3kwL+W2x87dGZgSnUy2UlqyZaSC+hMiLoaUjD0u83S90qb0EL/7l
         +UQmo7oA0QenHoc2N4RcWHjvJMYPL3bM9uAQzYHpTYsDHM14Sh18hqpT805f2JvbjW1P
         atRQ==
X-Gm-Message-State: AOJu0YwMgKi4pxjvX7pOWxulU/H3yN/sKnHj5XnACU7DdtVrwUtCQI2T
        RfxkerGfC3XxhuLU8vP5vks3ug==
X-Google-Smtp-Source: AGHT+IFqxwZ6HMNcGjtgurzjJ9aQjSGsn+IK8C6z2Ox189KEayPWkHyTWSET4e2Tn+VGomzJbkvxaQ==
X-Received: by 2002:a92:c6c7:0:b0:345:bdc2:eb42 with SMTP id v7-20020a92c6c7000000b00345bdc2eb42mr10961930ilm.3.1692713254147;
        Tue, 22 Aug 2023 07:07:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e4-20020a926904000000b0032b72b5c1c3sm3137113ilc.9.2023.08.22.07.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 07:07:33 -0700 (PDT)
Message-ID: <362a75b9-4790-e7f0-fe13-4685e04cdecb@linuxfoundation.org>
Date:   Tue, 22 Aug 2023 08:07:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
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
References: <20230821194128.754601642@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/21/23 13:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.12-rc1.gz
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
