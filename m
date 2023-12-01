Return-Path: <stable+bounces-3590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040977FFFE2
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 01:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A1C281A61
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 00:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B0F368;
	Fri,  1 Dec 2023 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9eMkDoY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67B1B2
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:08:55 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d815062598so289540a34.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701389335; x=1701994135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIpe6Pc8ZEweE2wHhNCMd1qwpO5w40pY6E+2NFsb9lM=;
        b=P9eMkDoYcRuWpW5lX2gDC3rXNb+6JHI9ZawoQPSB3RV/GDKEbBVz0DzM4u0zDp4mqJ
         KPInS8wQjHIU5W+zmCLfBHIyrfe6cLJ2r0HyRiUDDpux07u+Q/3/aYMJ9kh/JxV+1NS+
         UgHNdyl69ugHuAQcqXmZxSiKIxzAVftPRlr+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389335; x=1701994135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIpe6Pc8ZEweE2wHhNCMd1qwpO5w40pY6E+2NFsb9lM=;
        b=re91w/I4wAc54uoMDfeE3ymn8K3HbAByJZhlHjhL7Bz3ZFNb/KID8gvjq2cQ6HbDIJ
         SOwetQrKAR0d6vkedi96OSX7g1lS07pDUvhfj/MAzXBPGPXA6HXGnEY/QUauCoakAVpQ
         2vNwL5xQOPmwrN7pFmjGheAbxzJw5UcN+lzxGRPk6XMKhRRlTgmUFkSgQgXLnKXlTbWK
         0fTEkPMgdLSc/2c2MWM+uG38ZeUqah/9vRWSMGwtYIbMOb/PEXZBM024imo+cV6s1YIN
         vq6gpbz+t2A0WuFtUB/1i7lBfa4RA3Fml7NrZdWgQIiYHbn+ojRr1XAAwN1XerQ5dVvz
         TjiA==
X-Gm-Message-State: AOJu0YwrCQ9sBhk6haPFvKrEPnHyFW5w2XEAFZNrmCK1Ff/iBZI6aSbj
	znPgebvv1HskhxLLmb+7OVTCSQ==
X-Google-Smtp-Source: AGHT+IFiMvXhLclCKdsvPVqAtnER9bIGg1ntAGRXcro8SZwc8QNq2ehOJpy6gxKHfW0xxsLRvnKWsg==
X-Received: by 2002:a05:6830:4686:b0:6d8:53d9:8386 with SMTP id ay6-20020a056830468600b006d853d98386mr5896779otb.3.1701389334789;
        Thu, 30 Nov 2023 16:08:54 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm315807otj.61.2023.11.30.16.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:08:54 -0800 (PST)
Message-ID: <a78d25f6-4822-46da-a431-1c35cbca7b18@linuxfoundation.org>
Date: Thu, 30 Nov 2023 17:08:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 09:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc1.gz
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

