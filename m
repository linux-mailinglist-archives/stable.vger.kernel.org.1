Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62377BEEA7
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 01:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378973AbjJIXAc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378964AbjJIXAb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 19:00:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A749E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 16:00:29 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a29359c80bso19090839f.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696892429; x=1697497229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2BWZbZhytBka0EffrJfj1+89PYtChbCcDgjZSFmqKc=;
        b=hF3L84veQVg3QAV90brXWtyZZSD3sRk/PdnZk27XM3fcRzpydcK6CAGqE4M0Y7/vfG
         lG5YCUM1hWos6b5B2gBx3YRmgU26NwAfz4dYNQr9xJlwd4DF6PN74FFt5NKUTk+jJQ4w
         YSIhj2EehMEFBrizv7X9pjhG4FwLlwGIsnT5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892429; x=1697497229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2BWZbZhytBka0EffrJfj1+89PYtChbCcDgjZSFmqKc=;
        b=XKE8c1jFkg6uPLedKqhGJcApFGQMRrVR3lVugSkJAWSvX1ckPiwrFyrG0psuDuc0+S
         Rexr8ihCh5JW9xC82UtXlqAI3UywXAUvTYp78mnyNENd8PlOwh1XhN/Q0hDC2dFlAMZ9
         IynnNdXlX9jInoRZexuKzu2iWuT9aSwhI4C2VkJg3BTA4VTt416SMDoMGMqOcu1mEtV/
         sxb2GchAGM29NQ8Cr4lCdPnnBLJFpKiZ0Cwwcb+QxonetG+1d+smnH9I223arOtKQ3wS
         g9BPOhtknGBAisO86sqEwg4ugjElNijEGpqcG0G/j79KNYCrANi/t25y0O2yP37YBv/N
         7Idw==
X-Gm-Message-State: AOJu0Yyiv+odQcEbostgq/i8ycAFrXuU9PaJ4YUirAdc0cZnZL6IB9hl
        vipySM1xp/kc6wDv9nRfrNRamw==
X-Google-Smtp-Source: AGHT+IGXrpYolpV2262t6JGutia7xDeNmPzKKe5RBMLoyi0TT6PWVTZdPMb4J5AvS7LFikrBXw3jSw==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr17554425iob.1.1696892429339;
        Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s8-20020a02ad08000000b0042b3a328ee0sm2328655jan.166.2023.10.09.16.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:00:29 -0700 (PDT)
Message-ID: <f252a3d0-8e86-4c74-818b-4d9063607607@linuxfoundation.org>
Date:   Mon, 9 Oct 2023 17:00:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
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
References: <20231009130116.329529591@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
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

On 10/9/23 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
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
