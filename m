Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D102872D443
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjFLWQm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 18:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbjFLWQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 18:16:41 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5F10DF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:16:39 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-777abee746cso44145039f.0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686608199; x=1689200199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUfP40fw6jd0SG8TaNGZLKGi0AkFdRjHIOaILEZPzLQ=;
        b=O3Zn5EK9trub3s8ohzkUoyAVO7uNr4N60t7GapeNIzuAtm06nCpSCD8t7uTiGbGc8l
         L6NFM5msDpVGSbGieBgX/BBIErmo9sYVfZ09QE/KLvxXe1MtMO0sOucHIMeZCIMqooSi
         UYaSmYalPmkF1EwK4mwvEGMir83uXAgmr9ewU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608199; x=1689200199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUfP40fw6jd0SG8TaNGZLKGi0AkFdRjHIOaILEZPzLQ=;
        b=jANwf2ToxK9rSEBo2gaa5r26DxUEEIKxwZKyDT6PMJxrbuJcF2kJ4WsVm2oymFnfEz
         0aPtpPmtvnRSXrJ9aoyACRFBrJcFOxLy5Tz2gI739nE/gcYaNokjGwuOynO724xUB4gR
         RkYbJBLn6EbiDo1EPf86jmh+/SQrhJZ91DrTjxQXlInrFx2f1kwaKySCr5wUMAhipRHH
         Ua4AK05Tb5weBPF9e1AXMksA6aqlqlt6VAPcbnFZHIy9D/o80GijK0P1GVGBZ73estoY
         zjkIj68Gf1Kty7TnWOCnY6fBsDECChPnhUG3hRWi8v9Z+8fKa99eDTZVdZIvQCX3Iguc
         yO0Q==
X-Gm-Message-State: AC+VfDwYiTlRn8Yf5OVab+bf7fffEfIYXBwXjylI8H7O1h3qagl4W9qV
        /TZ1GVg3Yqz4j9GFEVzyADtVoQ==
X-Google-Smtp-Source: ACHHUZ7FAIzvZ7O+8bEHCh5LKifB25TcO0B06wEat4/olhfTvbIVbih3qpFauAFLhOeklAWU3ft3qg==
X-Received: by 2002:a05:6e02:1c0a:b0:330:a1eb:c5a4 with SMTP id l10-20020a056e021c0a00b00330a1ebc5a4mr6909400ilh.1.1686608198867;
        Mon, 12 Jun 2023 15:16:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b11-20020a92ce0b000000b003350061b57csm3400873ilo.81.2023.06.12.15.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:16:38 -0700 (PDT)
Message-ID: <15d43456-d2bb-7f1e-7673-aa06f6077dce@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:16:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
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
References: <20230612101715.129581706@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/12/23 04:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
