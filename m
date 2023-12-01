Return-Path: <stable+bounces-3589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BDC7FFFE1
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 01:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C128197C
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DF620;
	Fri,  1 Dec 2023 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TmfBxgnE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6754B133
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:08:27 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d8103f3cc5so218210a34.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389306; x=1701994106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TeSiz7oFzuM5XyCdaX+ONzU+lRac4jJbmIws69/sXE=;
        b=TmfBxgnE7VIjgami+sFfEJsF6B5Ol9zcfMdP7jKkdB2uHuFVvuGZ93WFU3HwLGUpjV
         XosQGB1RZi50gV88h+760PbOvcBsN0l+9V2cPPjvUrSSIAYgwbE1S45QKjFgz6XtUxPX
         fZdGc3Qhw4rxKvCHWHku6Xe9L4DwC/oYgOe0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389306; x=1701994106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TeSiz7oFzuM5XyCdaX+ONzU+lRac4jJbmIws69/sXE=;
        b=UfaRFqfIX0678OuVBAAkQcXM6XqhI1XaYet17OWh7/vxRHahqAFJSN3kZ6iOyJTgE1
         BjuBuc/esFM8sFzh+b8lxB4IS655430WAGSqTgoExj/KojyB5tp629hofsuCoR4iKBzc
         MgK910bNF6ulo5tVFt8QdnvjWxXXGkcmkIFbbsZReL1jx4XmH8DH5wugFs5WKk5Uj8hx
         f8gVQTVLXYyjgfazmPaWcU64TPuqAgSjtfvca9oNJDoeabWmKQvRgLcsHfwSsY8UTQI6
         HBb4l2pX2lapvnwBVylLmubyiG9grDAukxhOZsKEwEwm0j8ipOhaMRItj8QeENkQASwV
         mKpA==
X-Gm-Message-State: AOJu0YzL3g9golr4Iv0iPzpTmQMtGPZg0qbJOt6UJ2tmLa5SxQrC+xll
	GBl8phq6N97V2cE+IYx5rxmHWtn5fLFCw66tnO4=
X-Google-Smtp-Source: AGHT+IEjoza6H96rpiRXI/yQlfJocoSpE8YdpEW/1Kp0jxbS6nBNtuQSHHnK1i96Tjnh8gSr6g/Urw==
X-Received: by 2002:a05:6830:4888:b0:6d8:114e:9c5d with SMTP id en8-20020a056830488800b006d8114e9c5dmr23275214otb.0.1701389306333;
        Thu, 30 Nov 2023 16:08:26 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:08:25 -0800 (PST)
Message-ID: <65a8c8d3-7557-4731-8909-a6445dd58806@linuxfoundation.org>
Date: Thu, 30 Nov 2023 17:08:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
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

