Return-Path: <stable+bounces-57990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8A926C30
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 01:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC62284B95
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 23:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600763A8D0;
	Wed,  3 Jul 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gpteLhbu"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A81422B4
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047657; cv=none; b=ibkWLecnF0q7K2c9eAhffBiLzwtdsCBGWxE8zHJuZlJibdMjGvd91SAUW/ES1cA6qUUIay7ewLTEAINlz/H1uWEBEZOn99OManqzH+h2nxVzsJUUAXvtfPBw10WEjyue2NqlnmOmoYxNlgtYGa1yiMniA+M/4PqaX0Paq9Swn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047657; c=relaxed/simple;
	bh=VHyv/MRVW+WTFhYaGnV3MOif7DUzQliFa8DPM52lXxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+Dzt0nA0HSHZZ43gS++RWMaaQPi1xx3rDt9kHVNua4ascoXizVnL9aJ/mZgq29Z4D0pJsUJ4KLedMWhacd1V8qKvcaRJ8I4I7rQ0uFiYkQFbfYDnH+fCXcmX34La7EK63j/ijaYxE+FXnr7/w/EtsdzN1NQUD3HYIa6aaYoUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gpteLhbu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36dd6cbad62so26455ab.3
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720047655; x=1720652455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaNGuPgmfmqVDw17Fg7WUhOBboXfNjYBg+GGHoJDUOQ=;
        b=gpteLhbu+9+aK4TQmBYAH4iWomOwBtUVth34gtfx+bzEWsyLZ6y/NhyA3zuwvmrzHk
         zqsgnxHgxopYWKCj+CZvGNxPYMNwsWj8d5d7P228a6RLTxdiUbEOAjPkMaRnGzC509ji
         vWQnsSzOJyh0xj5Q99psaxhHQCOSuzKY9LmzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047655; x=1720652455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaNGuPgmfmqVDw17Fg7WUhOBboXfNjYBg+GGHoJDUOQ=;
        b=TbELNzoPhNGtaidGQBSuDsngQATxmG3SMqWWbz78x3/ghJJqvItoCoP+IDHnlaRWsk
         7mIsoAgjqeu1ANaVuez53YGur6IIBqDan7t2n3IHrM2MrmnDoZgaMY2bF6Knhh2Zxv/s
         U4DlyIhYkCecOwCS6AZxhL8+yZhWBCoNqsefc0nCC4EdoQoji571pDDFAe2n7ehuUEj8
         0YgrzR4p1YymUJr9wCkDLQ1a7xy3XWGUHEIYNBI+Z4FiD+P2FqPwyEIkzV0PNkrAWZmM
         6BnGs01SfKCiS1SJqlWUsb2HR+uSPeRHcyRbmxoQoDcodi8hr5e/AhaEFJg9k25zMuTe
         cFwg==
X-Forwarded-Encrypted: i=1; AJvYcCWzgpw/KzZ7+qYIJiuOfD2gFNJ/M54ElrTo6BRtNlJRU/KqaFstNn6s+3zP0ldUpg61DbBVxg8Uh8tIqlOOGUVWS4+Qrhij
X-Gm-Message-State: AOJu0Yz+ifuf4gzJNUueC4HCY38ngdmP0ksAPth/G7P7RFHkbxup7Q8V
	WkerslzvqABMZtasXk9bQuzhCzjDCzOL4SJGtQD7DI1ocBKJcYM03XXjJ56X7064feU6Kt+K34+
	j
X-Google-Smtp-Source: AGHT+IHz9n+Gt9WGxmI6Wh1bYRd6WGaEgA2QfMUYbKqtbN5k5a+OnZFmL04YQ3gW4hYStFJwJ/L5KQ==
X-Received: by 2002:a05:6602:634e:b0:7f6:52a7:69aa with SMTP id ca18e2360f4ac-7f66dee2ea1mr7367839f.1.1720047654608;
        Wed, 03 Jul 2024 16:00:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73dd7bacsm3616714173.65.2024.07.03.16.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 16:00:54 -0700 (PDT)
Message-ID: <b7b4bf0d-35e8-41c1-ae0a-e91483e465a2@linuxfoundation.org>
Date: Wed, 3 Jul 2024 17:00:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/356] 5.15.162-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 04:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.162 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jul 2024 10:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.162-rc1.gz
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

