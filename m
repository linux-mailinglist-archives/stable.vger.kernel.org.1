Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583FE7E4363
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjKGP1V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 10:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjKGP1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 10:27:20 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094E79E
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 07:27:18 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35950819c97so3861605ab.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 07:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699370837; x=1699975637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9r1p0ZSiR1SW3Vp37rjwojqo5nEaTZFOuzEKg6WqO2c=;
        b=YB/v4xqp2ZcD4XEuK/+4erxGK+P3TMrktnPUhlpX3Df6sUomoZEtV8RQcUtsi71aZN
         EY4LtS6sctjOmTdIKzuXnMfyplZjdkQQMNy+JzxGguGXKVxSIqq/hQn2HUbuczm4cnAv
         tz7u6pJX9jcgD4v3tGQ/9U+zMwEBkHr7bjVWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699370837; x=1699975637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9r1p0ZSiR1SW3Vp37rjwojqo5nEaTZFOuzEKg6WqO2c=;
        b=hidQkNneitcVZ/86EAkWHA/ne229IGVOWQ/hMxAbURuxluQZdC95FTRUDOXDPFyH6v
         jRk9yIV+YECmFjaEcyaL2vJa2bzfRljNHCKEh07/yQss8d2lr2vo1aJzSj2f8hig9JD/
         ERDi11di86xLlZGOXLVceALXMfQUMPkEJ10mVuyhFL7njfp30+8fk3IfwBCSn5ywbhLP
         ngAxGVXwzUhoF3czJF/r/lw98ofJgyk0zCIcNW6ece9kBytAxQSaLvCcX/2WlHO1GQsP
         nPe/kANGfPiHQiSy12IyGiLBj5JiMHIb69kJ95f1bFl6GixFqJ5ZqzlELmtAOWUVIFjX
         JPpw==
X-Gm-Message-State: AOJu0Yy05KVRSsoUK1w6yfpa4RZ9gOC6sn25ymxedyzHhDv9hIAzrw5M
        b/G+GgIj2r9HWEzbIFMbHsKatQ==
X-Google-Smtp-Source: AGHT+IE7B0QzN4WoPG0EXWrCKJMWbwGhjT4CgwjteIj3zoF0tGikYBcllHZfBik4artp7ggwYfKjuA==
X-Received: by 2002:a05:6e02:168c:b0:359:4db7:102a with SMTP id f12-20020a056e02168c00b003594db7102amr24948172ila.0.1699370837192;
        Tue, 07 Nov 2023 07:27:17 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id db8-20020a056e023d0800b003596056a051sm3201829ilb.71.2023.11.07.07.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:27:16 -0800 (PST)
Message-ID: <2b536b87-33fa-4e84-8c0c-d96fabcec723@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:27:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/6/23 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
