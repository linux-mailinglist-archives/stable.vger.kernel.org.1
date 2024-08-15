Return-Path: <stable+bounces-69251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90F953B8A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD0E287E63
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2F14A096;
	Thu, 15 Aug 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b98vo5nI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C5405C9;
	Thu, 15 Aug 2024 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754441; cv=none; b=E2AadhjK6kdbyp/59T3A+TgQbtx8htt6MHxdvHQvZijx7sjL6+qkNtrQ6UuTvjK0yVZSv/x+DLw+kMj3Jy7/kLM84BUWAUioXvTWjF6BUC9YGXI4LYYs0lVyIEjRHUiWvJMgTsuluWiPibD1yeeYP5uWkGUBfCOHrwC/M1aDNlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754441; c=relaxed/simple;
	bh=yPrJ50VXI5nJ2rby7f8Ln8oGQi3wYrAEG06B/vm9Abk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhi7u5Mslhno3geH04/zPw38ENjtCmKFFD6Gc6963uv0iyEPSCZ1TSzLt6mawbcY3yhcK8x+f48/NV4J0g1cfMyBs3bIb6yWEaN1kgIri7C4kHHpQ+bOcFMWeSM6YYLr7NtIVaYiHlhXO6MD0wzhswKoY6cFp9HSYh+nUs2YvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b98vo5nI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fee6435a34so11534485ad.0;
        Thu, 15 Aug 2024 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723754440; x=1724359240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WkB5SkQtbWMRkXaB+yKolATeCu0MoWvQKnYm5st5Cs=;
        b=b98vo5nIA+blyfbz1rHDdVdahiiJK9NaN9aMZEuMIGjS/xEvaPOJcP0RDySTcqm/hY
         IxmXtZRWdFUc7x0x+LLO0X999PDrDuwUyFKsRChVz1KMAzkXcH/RvvY9LYNsZK85EhZn
         A63BVvEEXX2LHYlg+myttZo4kL/TC6bApYytL1ZRJLlURNwPdNU+lDXY/pYs+DVNOozd
         5baZdjfUul8i67E1FW01JfYKy940qwrUvnlxk8u2HW6bKrP9v06+7fYfhiTGT3DcAbfU
         XKjuBglgkpPzPAHV26h+VlfOtA2YY6H5Zgddh2CtLIUO7iG10mZy5yF053sgL3X//E6D
         H8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723754440; x=1724359240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WkB5SkQtbWMRkXaB+yKolATeCu0MoWvQKnYm5st5Cs=;
        b=OO+/bnnEJA7Tf0sXNOEawkR0DrQTUkTyx81f1S0esLip10WCTiAAaax1ezqXyd9Ft+
         q4uL5BY9sj+ZZ0qL4q+QEBddzDepqh/cY+knGBO1UAMo6aGzYih0SeD/+0duveG6XZk3
         UZlDJIp74CxcJ8xE05rKYSsu0Ib3v4/zf8bN9o+mz59AqzfBP9p+rbURBw8qAuBctpCR
         1xWO1hgGiaTmYD6h72TVm7c0YtSNtkvo9jKg94of45JzbedQ69fp3t6Hjsg2OCLhnFGa
         aVKHWsVLM41rrll8g2+3YbNrODE8NM5JDDbcQokRqHm33s0jYhbhMPi3ACczkcyof4uc
         2pYA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Xjpc+HkHbJyf1VUbrjd9TtDGPhEGgF4rfGr4WNcukg7W2hbhEX22e5vB/BkP/AtUjRsoUIzeDOQridfDrWB/8Yj2Ng/3OwMUE9uqGUcbIYR8IPVlWcw0GEZipYD9NzMPsS+E
X-Gm-Message-State: AOJu0YwiYDB5wXSjA3gTk5wv0grfaPxlF7rjrKIUPVMvb8DfjbLkzfqe
	wXgkIqYJdq6TWUt49q+HggKUKB7Fq2pYRZElIuZICAiu2Zpx3x06
X-Google-Smtp-Source: AGHT+IGMhDTyIayyAG2ydk7g1y0+W5VoTqLRXWve72ZnKng+f2tGdhpAlIk2AfPn1zlJ7KkoxKrwCg==
X-Received: by 2002:a17:902:ecd0:b0:200:a9da:add2 with SMTP id d9443c01a7336-20204050d7fmr10407335ad.62.1723754439669;
        Thu, 15 Aug 2024 13:40:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375123sm13919635ad.139.2024.08.15.13.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 13:40:39 -0700 (PDT)
Message-ID: <22ee17e3-5bd4-4c62-9619-7e105bbd6ef8@gmail.com>
Date: Thu, 15 Aug 2024 13:40:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/352] 5.10.224-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131919.196120297@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 352 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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


