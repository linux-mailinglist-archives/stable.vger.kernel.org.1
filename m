Return-Path: <stable+bounces-35879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03379897BD9
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B221F23DCD
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834C15696D;
	Wed,  3 Apr 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElurWV5D"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0715686D
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712185264; cv=none; b=PIUKR0uImZT5RSOrRU9NBhqA1kkdlE595Ti0na6Q/lIbWfj3QXI6A6+lQxuBSxINTYB9Mv5j4kAq+IFDkw7AckYPpTeH6juRAYZl96uRuwo56Y9uDjb4zvi8Vihf3me77wdh5M3lo1TgUI+5aDxsNg9UJU9IzQZbfkRR4pkk4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712185264; c=relaxed/simple;
	bh=7Y74O7TjY7jpHYofExHM93h8IkZ4W5efuR621D08PM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPSlbRXfUiaQw/d7QezCUlzhB0thCk7Z3eCDacXu4qMXbE1dXLDb9xOLzUk7F/hADybPlCpp1uNpFJdMR5/XIj8a6OoFyqiMhZ8fcCAreXPkfMfOBCVDgKpbbPx6l9765Tk/RUgVgEUb9xzOhuPjazQpIQFRAin++4yleCEy/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElurWV5D; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-369e4a6ae04so15355ab.1
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712185262; x=1712790062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVfdwPhoWoL0b+VXF/L262JhPi7ESknq7Q/FQyN+ugM=;
        b=ElurWV5DmbFjDaVzbHcP5/mlWUuiqQazypzBtBS/LI4XqyXyJk4R2TRgrTabZSn5kq
         bWY6TBM++AZXLwOmHnr41qnk+ccn3f3zPGVXMhCKNUTSD7KO3l5MtrGY1VDfKeiiyUqs
         D75lswMAnntkS6MGP1iUh5AwHsZft5gBi0BnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712185262; x=1712790062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVfdwPhoWoL0b+VXF/L262JhPi7ESknq7Q/FQyN+ugM=;
        b=gDIXj0azONixDwDUdfxehpUtL7u0KS+6mYvz6v8ewAh1vQ6AflXz+wa95ChXo2AZj1
         zvMVU0jHT4DaUZxzKKpYn7DuCnFpRn+327rCkdx007blhMiTopqgtIE04hIYIwgKGiw8
         0A5729Wr5IgDo2r90204nz67vFNDRjVX2uINxZj2U9EMGmUHrflwjLIECnZ+845eR2IS
         oqXKeprddfiRkQm+C4kZRgd2iULrUxyojq4SeitneAZLTAW9eIoi9Auy96giN46dmGaO
         zPv+c+BJajnlf54lWcrrltGWnBgq0X4filnrMzv4m49X9akRLAU/6f5GMobBpVpCbLa3
         dj9A==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ar3qNbfv0G7jXjlwPGY7RWKo+GCMUwNYRFijP77/vVR++P9NAh7yuH8cY/HFo/BYWk78BMGwz/wuvKunqOHyEw6lCUBu
X-Gm-Message-State: AOJu0Yxd1zgA93Vk/7drgaDuUAvjLzZtG32oA9sub2aQGqjDazeA2awY
	O5VExgavnLjBOpq9SmxJuOZMEqV1cx6LHgFV+9nH1F4QVztzxxIX+40wpflm9U8=
X-Google-Smtp-Source: AGHT+IH6cRHPVj5NEezsGxb7L0Ozrt8vyJr/LPTdVNmL+k/OgV6BiBlvHPc093dRKgMOhDOhj+Ru8A==
X-Received: by 2002:a05:6e02:541:b0:368:efa4:be12 with SMTP id i1-20020a056e02054100b00368efa4be12mr1139587ils.3.1712185261996;
        Wed, 03 Apr 2024 16:01:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n16-20020a02cc10000000b00476e7f39a44sm4092962jap.110.2024.04.03.16.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 16:01:01 -0700 (PDT)
Message-ID: <8cbf96eb-b1de-436e-8312-c228d0882226@linuxfoundation.org>
Date: Wed, 3 Apr 2024 17:01:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240403175126.839589571@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 11:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
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

