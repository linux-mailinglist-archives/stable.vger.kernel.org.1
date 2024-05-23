Return-Path: <stable+bounces-45976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6048CD967
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 19:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0912CB20D10
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561F7F7ED;
	Thu, 23 May 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbqQe6aA"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05D17C77;
	Thu, 23 May 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486629; cv=none; b=uZQGQ2EMBrA9/z5uBR7+cTo1Cf4azipwF2tu2y3uUmDpl24Qb353Y3pREqQnV8ATOKPRHWZ+flna9l3uEdgt4eHgvWbENR3rTY1gcF0sotgbbjIlVwPGliHA4xAAnwQamH0zY4NYsUG/6+6TXQorgR+pvXFiacEHFDbO9ezeDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486629; c=relaxed/simple;
	bh=Oj5V8Zl8AxyLYxbl99PVAplCD/Zk2R4iz+sX+zS8bRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL/oAmnP1xxxXHVRXFO7fUV+SypTRQjnAB+Nw+w5Fa/80u1Oxp7HlP72FzOBM+qUVBhCzl0+Zv+O0iVjryut68YcxffFJR8Mvoj2BURdXBLoVB4Qhi7fi/pLBUMnK0mppHJK9OpYYrS5r0pp/NWCkE4NI/YqkrXpIl+64BKOm1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbqQe6aA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6114c9b4d83so58038257b3.3;
        Thu, 23 May 2024 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486626; x=1717091426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2WExOwhOvPENBtOdrwpIwXYpidNTG4NO4SqsZ/h7Wg=;
        b=gbqQe6aAIXAGmDyufC0WGXykmh0Bob2TVnzf681ilGjSesdqmiBEmQwoA5XHCMJf7E
         SZNylj2xYJavdBmk8WkmCAG408WEvo30rX/YE3WJKSB4KlCu7x1GXxgDFekOT3pw8qQ1
         +ePhI/9vqfTHGv4R6QItF8ERSotg1gbT/VvPbVWmnaqD4fqyG11otM4JsqfHCg+Bwc+2
         2quwqk9N8pwBZP/FGoXibfpIUn2lGNjPyB9TjziBRVxT9vxYf8stjZhtQ+IuSaSay3uN
         5sQjIBKqF41T+u2B5qNZuBc87r0GI0cGV0wnbTZahqIkQgH+DRlufPUhE+nq0dgprhry
         IcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486626; x=1717091426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2WExOwhOvPENBtOdrwpIwXYpidNTG4NO4SqsZ/h7Wg=;
        b=HGKbBLtXk15DdinmrV50s2QJ+CCzoV3js5wRbfFKpt9ohQ3TfKY5tooXUrEt0X4AqZ
         8FXDlXsxitpfZAhLfd22s4q/g1sWP9RTtpRb84CKFUab4Z7DJGaJuQKjftVI0XtO8Zs2
         AQ3JIp8oyDEWaJUmrcwEcps3984HbIlraN3GC4+kzdq1tgrJVXXGF5yCOewzeiWsxvJu
         rkJcSixTOt0UK6kMTR1cly8cRZbsieyz+O3L+yAnQ1MTaD+g8tbJ681MqRz3sYh0VIlK
         NjYAc/q0pDcFBjlPEedeKjupK3RTyx1qj04nny2N8NmTuD6EpLMig+2ryXtuehSb86kQ
         W7vg==
X-Forwarded-Encrypted: i=1; AJvYcCUWVQ84FqRExEWRassqkMH/PsSzpkdV+s9zfR/GW04AV2hQ7h/zEDNvgZ0WqyvsSLTChPsf6UrGfaV6LZSgKNPsvMS16lLqlzsOE9emwEn4+j7P6fyvBzBQoxe72+VklHD0eNLr
X-Gm-Message-State: AOJu0YzLDrdOSL4S8zqdsdRjrmGRyIaFGmZIfdBaryNxor/mY2NoXYj0
	ZCpAB8y5PA1H/NjKYtUCKUuBiBB26PvuZFKqGgL5p9HmTE4sxwey
X-Google-Smtp-Source: AGHT+IHD3RdQmvaRRzVInl/+fceU/kNYKQqsX2H+wX4kUbad5XiDJpOzmGkEBgD5kyM++z+nQwpvlw==
X-Received: by 2002:a0d:ddc6:0:b0:61d:fcf7:3377 with SMTP id 00721157ae682-627e48809fbmr57863297b3.44.1716486626489;
        Thu, 23 May 2024 10:50:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6ab8b22d082sm13532626d6.41.2024.05.23.10.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 10:50:25 -0700 (PDT)
Message-ID: <6b51836b-bdf1-495c-903b-b73439b86449@gmail.com>
Date: Thu, 23 May 2024 10:50:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/16] 5.4.277-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130325.743454852@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130325.743454852@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.277 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.277-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


