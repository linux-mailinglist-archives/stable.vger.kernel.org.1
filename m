Return-Path: <stable+bounces-3563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A57FFB17
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 20:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A8E281964
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D055FF1D;
	Thu, 30 Nov 2023 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN1JBTek"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3210DE;
	Thu, 30 Nov 2023 11:20:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77d8f9159fbso62775685a.2;
        Thu, 30 Nov 2023 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701372056; x=1701976856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMF7VYY19D+eQIQZfWXe7V4YN2em5TdIIdXRtsbpR4I=;
        b=YN1JBTekK+dK+dC35v+ZL4dnuzBL1W5R76P9HwTsXSBW9tnG5QYHOQ/FQGGeo3r0WZ
         dW6zdfJ8z8oTukgOT31KcBHP+Dn0Cou/RFQgVqTe6SKkQUjGMQWUuBZfScmy9wV4l4LW
         VDpGXlAaJ9XU7GlaNq4EjnYRYUfxJUAAh9SNLFxhHofcxcE8v3GBqJrwDcd2hxmGaFHB
         E1Lo3NnXYT9O3pjHXey0KibcPnKc5YOvCQtSLC2nel9qg+zJNOrXf/qXQasYOHfjJwr1
         EkvILvz9K7boyEciHU2J3uw73ObCuIUSMFtTZTxQ6vxeb5B9ydtRbivBRS8pGvYtiW2t
         106A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372056; x=1701976856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMF7VYY19D+eQIQZfWXe7V4YN2em5TdIIdXRtsbpR4I=;
        b=JDv6qLJd2e7d5tbNp9CJXL2Vaot4UyaIEetT/8v1vInSTsfryAvrQlAbmuk+mIakya
         s3Uq/41T5Anf6GNCHQWv9YDF3WEx8hlKte24FbcXM9B9Vcq8YLxRQgQsZvcYq8wCUgBr
         JgZrSZliT+BitsxPg6OF1HKVIjmrC+CWwj3wOix7vhrsGr7G3eSUb9XGzmO2Sxd8RdVk
         4Npn38P3Ow8Hg1Y7iYbTMMFRPvoILUoa3mSx7BV1cFhhbkVbpr312dMktANqEcURttnM
         AF4TwIO3Iq+dwGpPvUgnDITlLhyK5Ht83VLRHEG+a/U58T5pw3B1dZKD2FeTaZ17KC8Q
         BSjw==
X-Gm-Message-State: AOJu0YxFLsiCJKKW0NUx/AzG+anTuo0u32UX3Z30RWF21hXoJZ9Op7pJ
	KFwMjsQbiajjUtTW8gaGBBo=
X-Google-Smtp-Source: AGHT+IFxLmHWM3NUzIFmoQzZlN929a8bl8rPrUilhkGpBTMEF1AGJcDLaYs+MZJsH0llFk4AFe59Eg==
X-Received: by 2002:a05:620a:3d0d:b0:77d:ce26:beab with SMTP id tq13-20020a05620a3d0d00b0077dce26beabmr5065261qkn.63.1701372056036;
        Thu, 30 Nov 2023 11:20:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b12-20020a05620a0ccc00b0077dd098d0b6sm756877qkj.109.2023.11.30.11.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:20:55 -0800 (PST)
Message-ID: <9c78fd82-d984-4426-84f9-957db4cb9971@gmail.com>
Date: Thu, 30 Nov 2023 11:20:51 -0800
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
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20231130162140.298098091@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/23 08:20, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


