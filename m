Return-Path: <stable+bounces-209971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D5D2913A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2576E302AFB3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E532ED5C;
	Thu, 15 Jan 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xx8qrlKa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4F32B9A5
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517010; cv=none; b=YTEhGwFIhac5U9FezfwYya56O0inhv6JzaFOamWQBAIS9Qr1qSG95nHAWnKuqZ8CyD/i2f0ZgjeR61Dqf48R0v+mNjqnbt6mt50DBJUpUOLuB092KO5lOR657tuHy/UnPhcnH/fmuwtkg8F2EG6cWrSglfngJfu/i+4ieyMUJo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517010; c=relaxed/simple;
	bh=MCDhR2w1d6r7sDjNpkR1URtOxNX6Pk/r8MfOlD0CjpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgRKAuWLcd5x4VqG48b2biQ3OBJKLgbu8UtD7E59TVaKHBKzTOP5nLSigTMKIscpwpXz1ArUSCHmT5GHK5YR6UwsAG34Rmicb7KaTW0Pi9sMwg41GV4MHNaiP1QJkLShSxpD8+bB6rcp9OWOUiLzRzGOHqaJtMVscL2LgF8YSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xx8qrlKa; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45c78da5936so1242777b6e.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768517008; x=1769121808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyRs+d0Cf5Kw2rXB13ZsV9jwZ76UYEa/5ku5BYfGZvg=;
        b=Xx8qrlKao7Pm5DHiZtb73jCOhkgsqR0Ory/6LSmPH0gHBwLxUU8Z59RWDS5uwLCnhs
         XqM6E6LsN75owiMd5C1n3mxBL3R2QLZpV/16s+aSFji6fCN+cq/e1uOAgKhlIhfqOUoF
         wrDXfmqibaNEkdpYtJPRCkSgW4YsiOfWiSZKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517008; x=1769121808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyRs+d0Cf5Kw2rXB13ZsV9jwZ76UYEa/5ku5BYfGZvg=;
        b=s/6kSMxAb7VGIhQ6kCmzDksCbw5+/p+9jAdHLXarcD+qcU4C6Z2RZzUfSic7xtFry0
         hg5GTFnSLACx4K6Q712cWL7/6amcoKJWGstFupdR6Lgkki+Jc61fagDr4DPWJYScP5bu
         R8/iZx7lDoauSHc2UoEJvlcLQz7+tqMVIVgRZOCT2m6/Yfzyvq/qjxkJflxfrMNJF4vV
         4sojZEDwimhK9zOZyjPlpTU2sAEki6ywc93uyJU2mQosCbfjizemv7LPjWY+PdXnwd4I
         aBRROB86LEY/aT68qi9MaYyXER131LHmGrql8aULD0a7SMcLyGLnj9OrsYZS9bKeS7Gv
         h5nw==
X-Forwarded-Encrypted: i=1; AJvYcCUXWytehse+EjOU+YEIwd7JPF95srhQV7ns1OX4EQQHHH+Hi+edOBGXuwoylG6HpkHQ2gGwsIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB87RQ4ZxyuMdLVA2WpqY3Wkn/1ASmNOyC+Marw+2f2lJyJXQy
	OXoipO26qnzk5M8PAyPhjljosy0CMOGTDW4LTT1iXQP4N7AX8Tyrw1uCB2FVl8BfTio=
X-Gm-Gg: AY/fxX5Z5clTOqBoZYMFxWqaF+HQY7MRkVyid213RD04G8d25udozcf3/OOTi5U5NCe
	c1pJUuLs9fKiL4E5F5YYq/2rrLcGdhTXGmfzsNRpFfredaRgldQu7jdnFsJkTJGFihVSFJmpOvO
	IKfSzgoxJrBwu5bMQZY4X2SumpPWFWoljUkYVPInqKTMCHbv9T/R8vdVlWI3Ob7HDM7hJuupgbq
	MzV21271azZwQFnTS9ycRGIomo3t92vliBLXalgptXEhOqAStCYl/PNXiMEbIvrxvbm9FQU5kFa
	edmaXmby4GvjWy0w7vQs/GzkBQPv/D95dhYKkX9Bnf5njl0ljzESDl30/wDHAD2LP0UsnN0cwsG
	IcmPaJzgp2V2vLmjXNjCMTX0LKAe1CwxkPbyxYIVop62Dd5GYMbMvQkwl/8N39I1F5nKqiL73RU
	wma/cdfbOzOvJG8ICMP3Z8EIU=
X-Received: by 2002:a05:6808:4fcb:b0:450:b246:f1ab with SMTP id 5614622812f47-45c9c78ff51mr501659b6e.11.1768517008104;
        Thu, 15 Jan 2026 14:43:28 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9defa8a8sm380622b6e.6.2026.01.15.14.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:43:27 -0800 (PST)
Message-ID: <9a75e502-619b-40f3-8f6b-1aad24855045@linuxfoundation.org>
Date: Thu, 15 Jan 2026 15:43:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260115164146.312481509@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.121 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.121-rc1.gz
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

