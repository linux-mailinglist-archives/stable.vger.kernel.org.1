Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA47042EF
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 03:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEPBdb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 21:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEPBda (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 21:33:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006FA3C33
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:33:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3357ea1681fso3216235ab.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200809; x=1686792809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07UHRK+urH/9IUeNAAU6YuT9Kx0Qr9uGLveRLazDAGE=;
        b=coQTQhbvQYulCZHBgae0FEG7tbmO+GOvtK0EmPSPXaVsn7h758EfQ/twdPIsD5OCvI
         vB0aX7NxIgXRkF943wY2LBntXpG34VDj56iskcsg9egAHaJi9qsyza3rYtKcR2TCRW/g
         BjUTMCI9wFJxQBO3FqKyUFQMXr/ceSV7ty7mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200809; x=1686792809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07UHRK+urH/9IUeNAAU6YuT9Kx0Qr9uGLveRLazDAGE=;
        b=MOF0JKd+sHAAHaIHb7lQEruf8ntCCLyLQ3VqES0CQtS7hBJbFhSxGvinHeiSA6NUMg
         T1/qP7k8+LaIhnZwhXyi828BRL7IYrSKeZFij1APW3hRTIIsS/4urceC3Dok/rboy63S
         s2gnjEhopPwswfxjGNIrl6OyegN+x9LE4wFb24okvLtYqqdUPiaqoPJzvIM0UTKGEMXP
         mvrgRRPuZEMmUn6yjWJASfaTVuTepGfyBcYISPNBK83uowZxsGxBubCv6Xwz3u6e09hv
         Pjxfy8C/ZaxEvpZL4JQVixA6rdWn2BxgWwaIWOMPZpoGu+KdjxrbI0f3Rb+wsV3Tv3vy
         ym3w==
X-Gm-Message-State: AC+VfDzLMQJ3Bke/BPNTPsy7xQ3uHTdNlGBvmluPOC1mebdUZjZgjqOc
        DEskhkKCkPXTizpBYMehHg0FhQ==
X-Google-Smtp-Source: ACHHUZ4+j3vGfON4qS0W4wkjGBkMSwoHdpMQb/CtORL2qRuR/lq8J1Em7/wjErV+59fLVEqZ3MvDRQ==
X-Received: by 2002:a05:6602:3806:b0:76c:67bb:11d1 with SMTP id bb6-20020a056602380600b0076c67bb11d1mr988759iob.1.1684200809405;
        Mon, 15 May 2023 18:33:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c22-20020a02a416000000b0040fa241e068sm7291343jal.52.2023.05.15.18.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:33:28 -0700 (PDT)
Message-ID: <8b20e1e3-aa39-a73d-8379-421c6e2bedfd@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:33:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4.19 000/191] 4.19.283-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/15/23 10:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.283-rc1.gz
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
