Return-Path: <stable+bounces-111745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FEA2355E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 21:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117FD167205
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013031547C9;
	Thu, 30 Jan 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPNwRWZb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5A196DB1;
	Thu, 30 Jan 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270234; cv=none; b=AWp3AVHvluwR6FSu9lOUALj9meu5m07F1HBKKfvanbk+sqiPzX4onsiYc9baMqaJpOKa5FGWR7le98h9MV0glJfudXPXwoVh9sRaaP3mA8GUb6Ip25Jq6cwq+OXHqaXoNuoQAWXenyOHHoYmQs+XLXV/jt0wL0IUcJlJlAwYf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270234; c=relaxed/simple;
	bh=Qj7emfc0qplYYCs5OcbTy59HCcddBdEnCOXARYroSIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0w+JzoURWWpvpIIklwonlJSSJ9uql2eOwv0uG82TwjCRZdftWxpnRINrrEeJPWEzenTldrAo4v5RVyKtB7SmU/dUd50JUWnZdH7Tlp/Gins8jE5O0tYlvZoI3h1CJ0NowOb/Q84ibDCkrbIJwtzkyorN3xuTryc/qISWZMeRdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPNwRWZb; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb8accbde3so1287737b6e.0;
        Thu, 30 Jan 2025 12:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738270232; x=1738875032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZo8hpxoqHa3DYL5NC5WhT0YUjb7CkDNTgoxTkCC3eA=;
        b=OPNwRWZbbpNHYbGpYO7YJdGHBrKV0Fy9+hh6joQZhZPoIJC9txLLEaGzEJaDYggKw/
         3avlFXsxMLauYZ7pxcovrwC97iFZK+t52nRUDuTfXKahySXLjVuMs8+YrEebA6Lf4BVt
         6LMq4Cx+/HWsRipaYHDxzAMWfnGJQfRY/qa9qQVVWSaMIELKss1XWcKliKD6AL9F9L63
         JWsWPkSenSBbxYykE0nTmWKmxoFBXgS3WX14t0Os1NRCIFKT88Gw5GkFYfrSUz7FHpGk
         gGpWAitKJQASkGfDf1gDsPrvQmMkjMCRXa5o48ExTughYMRAvxJ4RLNBSfRKdWiZTpOb
         GeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738270232; x=1738875032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZo8hpxoqHa3DYL5NC5WhT0YUjb7CkDNTgoxTkCC3eA=;
        b=W34uGv0jfrZWqNR5yTu7CyqNMnPT6HwprvpxFEHd8r37/RJoLQwYSkiU8OkNjCqMHt
         jd4lhyucy7fV6bdTMRfF6IQLS7qSIyGmH3B3uOMZHJxY4EvuvROjFHcmmQRZvlAPR2JW
         1syacz/WD7YHsEZl8bS1lSShw/6xeKai4nTRkT0V1zaXOwwYJ1aek/4x41JHuFingI5h
         ZC30VwDPLwzREot5NklDgKL7VMLFw684mIZw70r3sbm6gzJVhRqw7NaUhzWD0LbLEK2G
         F2HbiayeTLjURIvepDyWM5sHYsDpYulqZpkJPh4zPFkAus+sS96Svyr3/zRGIhuQN59v
         9jzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd140F/0s+KtDwbvabq0sB+DLyfUrD859xBL+W+91EpTiROrlbywMp71TzGNzSPx1Rj6b+f4QU@vger.kernel.org, AJvYcCWpSYClI45FIHGaTqger6XWmsRkrCN2NE4Pb2Guf7HhaUubosWZp5c+/Rll8rSkTucYyuHKgvNebDtzHk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9iaDqu0Ey6l6PzrtB1IVjBClegt20nmne7O5q5IMQAbyK+8c
	fx8rO3wukznkxZ7xHdjpBlo1QHD47lrE+OpujSnM32IsXfIeWPQY
X-Gm-Gg: ASbGncsYtX1WXWzaStp9nlwu0VBpafPK6jonvHVR823SOcIkXlWgi09VYZRp1KqDnI8
	7DcR+jykubFS9TvE0R6hyquADz3IIi0hz1miDxI4+2kQKjt2/H8CYlqpOtnCCu/YCkgTiOyAyqE
	OeYNl1Q0jAxOxaFF1tNHp8iV8Bumo1f8tC606NLiGZoBaygJGAv3ufxS1LiHy2ko2A64bWi9nBq
	tIi403nPa5k0wVEh8xKo+CUl5lSyMtTa6CUraD0IvgPMzYX0unMtV7Qa7Wmq8+caoobNvslomhK
	dggYplb16KdGHyogtecvJcUjTuSDqxrJGnp8XnjQd1I=
X-Google-Smtp-Source: AGHT+IFE2iqVirz904ovcR70x7P4qhg9/LDhLdjk7U1HIgwqjlgumoEt4jW0fBUgkqML6erNY0PKTA==
X-Received: by 2002:a05:6808:bcb:b0:3f1:b1af:7206 with SMTP id 5614622812f47-3f33c347363mr1106763b6e.10.1738270232256;
        Thu, 30 Jan 2025 12:50:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f33368be99sm410742b6e.47.2025.01.30.12.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 12:50:31 -0800 (PST)
Message-ID: <f51208a1-927e-4069-bb92-d29d4bc74db5@gmail.com>
Date: Thu, 30 Jan 2025 12:50:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/133] 5.10.234-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130140142.491490528@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.234 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:01:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.234-rc1.gz
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

