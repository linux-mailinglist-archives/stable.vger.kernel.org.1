Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC67C7E438F
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjKGPfe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 10:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjKGPf0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 10:35:26 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA695
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 07:35:23 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-357bc05f94dso3898775ab.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 07:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699371323; x=1699976123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0Q97ZjZqObFPBaDoJRqfB46zlWgq8JESlNpJLuVSWY=;
        b=d6kjRvnzLbRG17B+9z4CkpSc+mL12VW/5vWqPibjVOPOeNNgpuWtoXUXA/rZp4uaOn
         WwLjBJbcOQqEPsIW51k6O1DbjZc83B9uqcXdQ/p6Y3zSafcHR7EtoLdAwLhdkpEOcqh1
         iBh/E0Vgy+eOwD9LQnhFWJTc2U5ofnWzVgksA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371323; x=1699976123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0Q97ZjZqObFPBaDoJRqfB46zlWgq8JESlNpJLuVSWY=;
        b=WiRjPi+t2V+QNNqHkUv0PPLQuIvm1r1glNp6w47AgODBBS7Inyk3xXtpXcbVeD4Xsv
         G2ReXbpCUPrAlHr3A+HzyRaI7dy4n8u06uAb+1K34kHhEgVJIdVRl5iKnxX6QTZRiPOo
         cKgtTR+ATR5nh1CQFBuziBaF5RJEQTaZCOSLxsn4NxP2mer3P1jaUJjvLwstIlMIdA+u
         pCcYbO6g+OodrDCuEyqbDYeYaqSJ3lsGubltgJxroJMzRnKXMJiOyUJ7YbKCm2V+iwBd
         fcjuy9dQdMUsOZ0hD/A3dzAoyYoSDPp3SbCBMKzbxmIz2tyExXcEldqxT0bpGrkHBdcV
         EfXg==
X-Gm-Message-State: AOJu0YzuElENzaTbceCcP36lp6pLQFv1VL/Wm8P59ZKi0iRGkA2mkAlo
        rWsmvW89t1pcgylpKlfc89gpNQ==
X-Google-Smtp-Source: AGHT+IGu0+OjpZ9c5GFN+YtEXHATCgKN5f1JuHTU2tvvV8AFosus9NykJaZw8geqLpsU/G11l9HIEg==
X-Received: by 2002:a05:6e02:168c:b0:359:4db7:102a with SMTP id f12-20020a056e02168c00b003594db7102amr24982430ila.0.1699371323093;
        Tue, 07 Nov 2023 07:35:23 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y12-20020a92090c000000b00357f3790ab3sm3160589ilg.25.2023.11.07.07.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:35:22 -0800 (PST)
Message-ID: <df4b4f69-5fb0-4247-9eef-057efcd33f10@linuxfoundation.org>
Date:   Tue, 7 Nov 2023 08:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
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
References: <20231106130301.807965064@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/6/23 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.62-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
