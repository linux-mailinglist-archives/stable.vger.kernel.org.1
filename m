Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DD7CB54E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 23:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPVbp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 17:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJPVbo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 17:31:44 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2643A2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 14:31:42 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35291dbf7efso7065835ab.1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697491902; x=1698096702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eq+Kx/9S8V0Cs7DZC5sSlCaT+pWk5Hx1QeNjsJae14=;
        b=doQXQAwl+Qn9OY3why2FZQTiBKEyeRX3hXJ9ibNoPUoTkltnOAHHFNVhswuxZ9OT1q
         ZRr9OT4DOuoEfWEXIDjIkzIk/9gLQ0QjXoMngk1x0kBIgpnfTgfi1vDxT1xdJtDWFrxp
         DxIg3hHw8MVmdtx8TNCACCx1uFw1m9QD+w8Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491902; x=1698096702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eq+Kx/9S8V0Cs7DZC5sSlCaT+pWk5Hx1QeNjsJae14=;
        b=ulTTZLEMFJ2p7c065Z1Lb5FDXfzDNbe9hTulyhep7C79saPycFAFekvUuwb44jv5d0
         2ldYvnLKsp9e4BoLTJeLKhu3ifS3G/dDRKwSbCYbXMY4Uv64CeEFaEjoJxqV4ZtkjlyK
         O+2a/+QmA5N5n3J5D8VTbF5yudAHPApSLUVR3zRyHsQlg9BH/S4Mx1H92Zy/HhQclFAP
         NRkajevSFO/YhiobL+tZLM14xm6d+XP+vUBLEfxJaPTTCz5QCtWU1HqpeS1rmhHFd91b
         h/i5ZcMIbSbf9DGTBptzKkcqDAhWSgHcvdTESdGbMmaZeumQDFna0gyYTls/TfNrVaTr
         O3VQ==
X-Gm-Message-State: AOJu0YxNbfERPJxJBhvyXfKHAte307sfmSv2Kg69LxLLb+1DjJb6WHjF
        5WXLAF6Ev27ki3gK9VIUh4IB4A==
X-Google-Smtp-Source: AGHT+IGxeDhQmu1poxt/H4JzwTKErzZyffEgpadqK/wYb/Vt7pGxxTsvG0HukykYVzG+YtLpU/OsYg==
X-Received: by 2002:a5e:9404:0:b0:792:8011:22f with SMTP id q4-20020a5e9404000000b007928011022fmr472192ioj.0.1697491902309;
        Mon, 16 Oct 2023 14:31:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k8-20020a056638370800b0045c25ef9a56sm58767jav.21.2023.10.16.14.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:31:42 -0700 (PDT)
Message-ID: <374b97e6-05e0-48b4-9cb8-6b371f5c7f5b@linuxfoundation.org>
Date:   Mon, 16 Oct 2023 15:31:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
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
References: <20231016084000.050926073@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/16/23 02:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
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
