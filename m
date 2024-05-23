Return-Path: <stable+bounces-45998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD48CDBA4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24211F2426F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4C126F2A;
	Thu, 23 May 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYJAiqPj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F97126F02;
	Thu, 23 May 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716497642; cv=none; b=RuSVgdlSd1gRKEBAKiTFzto2xh/nVRvNx5xKgxiDr+qfydvaWmNph5lXouFnQZt94tI7dUX3Cy0iEVHicjg8NfEUgNxYt6TqqvCR2JFAC8rjAPnQDtwSjGa7UiUoQGDUgsNl51MzBuV1UWCO4hZh5rLuGuUGR0uUeDPtKeePixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716497642; c=relaxed/simple;
	bh=pjdVD0Ey758EwjNxbZg5v0ciiT64t0TzFMxkXUAipvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7DMBjqbLn0nK56YIBxMHzVQXmnXQP1zzV4eQPVoLqqzUC0IZulW+GqEva7Hmm4XU7BEil9UJ9t1NFy5nLHg5xmJug0a1+BZwPXLavCVhKYjDJN5LglWyLzX/ve1unxJbdT9tblQxjCT+JsoszdVvTfLuomKHNuQSndMVKEDbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYJAiqPj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-68185f92bfdso144881a12.0;
        Thu, 23 May 2024 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716497640; x=1717102440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3tHKSSpqdK97uiyWkm/Md0YuI2Y3keaW8/UuVa/Zik=;
        b=DYJAiqPjHFysBddXcuLDsShlz5WwzRNjVya+2jru2X40gYQNTOCYd6yc2AmNP/hebP
         7YEDg9MsgEIVbMmO2winE6JanVynLkUsezsQJ52JsWExRps/1pm6BWA+bWXkQ3IJbRXZ
         KUyACeuzFDWcsnYVokqvAaoDO1S7I/iuohfnuhbIrsLQ6Q2vtWOgritsGnAn7znaJQfX
         dVCtwjbw1czDNLXQhvE3s2ENBdXCqbUl5hadTLT069XEHIuLd+xL7WxPzC8ggo8FtDOd
         6GQBE2qmof9kVmvGmb211mtLpXyZSOm1jNScXLQ+dJfICVTVEBl9z1e1ifN4BLWNCwjC
         cUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716497640; x=1717102440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3tHKSSpqdK97uiyWkm/Md0YuI2Y3keaW8/UuVa/Zik=;
        b=M0f5eJRFQAS9j+u7jfx7khv4CGDZoDNSNXfGCh5kWB8ck/HSGB9etwJ3cJETC+m71I
         wlkuRNso+u7V1o54Zwbsog2P08wrfe21PudlrK0GrLtnF3Bz1eQjEOGaTzMlfZGNN0lD
         lCAM+8xntM5ridQ09wKkte+/TpB2ru5eU31xLl2my0/Zh6t6t/A5trbBnj2x6fBZFxbm
         cb+4d+8NmYQ271c6J4ESQI5/xFSQ3eIGG0EqajcFbc9J6WBonbWvetUOI5ONUFzrHcY+
         yKKzpMF6Fa78Onx/1QRhPYcn0mETC7ZG7L2bhc6TR0dIskkMUNXmBYE/u23lrq0BTzKV
         KRtg==
X-Forwarded-Encrypted: i=1; AJvYcCV9tqDzWSbfcLT7avK+vWkZsKiCpUgiqOghzBAozIDukJcj9NHwGLXGP5nNqTG66uyN5axFMItdpBe300H7GZM1eSjAQEk7hmE/Hvm11bAj8NRjID4WHkfhWQuAK3mtZuGcGEmh
X-Gm-Message-State: AOJu0YxEU4k9AwhHgnFRj2s7RP2WXm0HLu53Ru7Pn0wRVqWYGahQaQtD
	zxK3RpKxrUo/zHR0QIR/CneU9ahQxu3gRVKmh4uSLmOLzJ5C0jXH
X-Google-Smtp-Source: AGHT+IHC97JOkbVLBmEFdPLulQZYGm7jf3Alvz+hlXanilKWbJ7JVA2WMR+URu6hZudYtfCu7PbVYw==
X-Received: by 2002:a05:6a21:168e:b0:1af:fff9:30dd with SMTP id adf61e73a8af0-1b212d42ef1mr804825637.35.1716497639884;
        Thu, 23 May 2024 13:53:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb973sm40251b3a.117.2024.05.23.13.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 13:53:59 -0700 (PDT)
Message-ID: <15e80061-6e8e-4845-b377-e13dbaaa37bc@gmail.com>
Date: Thu, 23 May 2024 13:53:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240523130329.745905823@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 06:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


