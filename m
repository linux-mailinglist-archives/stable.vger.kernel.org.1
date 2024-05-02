Return-Path: <stable+bounces-42935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA468B938F
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 05:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C01C20A42
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 03:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5618AED;
	Thu,  2 May 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4aEFbw2"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A1182DB
	for <stable@vger.kernel.org>; Thu,  2 May 2024 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618938; cv=none; b=IByLBObJVbsCtf6h+4gfj8PIMyWxMVCQUd+UMUmzonmNbFXfStl1bPVgxEif5yKUxTCGc2985n4vQIZOQzUb+/KX+22b7prp686ps0p6FpouLKNULfFuc7aGhtil5dwrKBYYpkBSZI5akZmENdvHhKrU5iHWY0ulX3Uu5yPTMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618938; c=relaxed/simple;
	bh=BrO6sR36R5N0le0PyCco3GLRO439I9ECeSVrhMyd9Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUPW8AnGS/IcccP1Lw332fajnakzJPjHNCEoVj9wV5SphF3yoPy9veFtHwIVnqUmwUgy1KGZv8mF98R2iynmNRRTEnZfAI2VganLcxNj5LhwDAyFCJhCqcJZtJrhLGTIGjvMfHImyRagW0hcPdXVkuEV/+3NByTrvYiGglucr5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4aEFbw2; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d9c78d1087so47890439f.2
        for <stable@vger.kernel.org>; Wed, 01 May 2024 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714618936; x=1715223736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjNlz/0kd2mNH4T0WxI7TxdTu+LxmeVSYgKdgcdHPyQ=;
        b=f4aEFbw2qcQDPOooAgI2/HgmjIfwI6SlYB7fTbxNGNmMpP6mAqPJ1DCvUQUyBvCyJU
         zo7zgT4kn8hZ4XGdaY++GdMgNnD7NRp6wsuzZ9WxV2uFjAFZLYhvjLBXWwNve7yoR6Bm
         d9OUC4vrCZ/0LtNDgN0D0k+EMil9mvVbki0yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618936; x=1715223736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjNlz/0kd2mNH4T0WxI7TxdTu+LxmeVSYgKdgcdHPyQ=;
        b=Hjra25CwiNnyAh4p81W5GSAdy2AcTy3f6yH9LYTUAH4O5/bT1y+l/hhgF8Jlx0BSOf
         00KmId6uD4pHN3a0HxWodbVzSf8HT+3kEihiu6fF12ap8Y69GlXAXGi262RR65+3g7TU
         6eXbvNp2Dx1uA7mu2u04fzFZ87DwsjiVqQjzOVzGCCaJEF3fugYj3W2PMRXvNK86ofou
         UfTdhN9UDMvoJx6U8GJ131SuG0q6AJ7IzmYjPIE/wg7gQr3ptzrmuVFVHdAXoXumQfGD
         zUauChwKKXjaVQJJKiWcUsoGsm85onBq2GK0LXKKCHg+qR1hkFbPj5jc+eUVYLVyuSy5
         IQKg==
X-Forwarded-Encrypted: i=1; AJvYcCUdhdlrgr+jLDhGNtcpTKVOXi8uta5H3bmdlrxhHQVpMy+E5ph1Kl2EtSmf3syTGNOWlCXEP5UMiz+chiT7dI1z37EJHBgA
X-Gm-Message-State: AOJu0Yx8QDHn3tsit6lKWqJrd3gW0GnzN0koXJxLJ3KqhXeHgLypHBE2
	81+1IAEIYX+xGTKhqyXCOTlb1rmSTckPXpb4bhj4ZRYD0/SEiKASBMx6hkXlb6Q=
X-Google-Smtp-Source: AGHT+IEOuAgdk9W4YMfkruIQU7JI4kuh9SNxi71Q6WgY62QwA9r9Ov3Tyn+mqjPjcs8/YxqfbXwpJQ==
X-Received: by 2002:a05:6e02:13a4:b0:369:f53b:6c2 with SMTP id h4-20020a056e0213a400b00369f53b06c2mr5302970ilo.1.1714618936102;
        Wed, 01 May 2024 20:02:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r5-20020a92cd85000000b0036a3e54b6b1sm11450ilb.13.2024.05.01.20.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 20:02:15 -0700 (PDT)
Message-ID: <bf2aff2a-d243-4b5c-93eb-3b6ad371b24a@linuxfoundation.org>
Date: Wed, 1 May 2024 21:02:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
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

