Return-Path: <stable+bounces-124048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C5A5CB15
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CAA17AC6F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286325FA3B;
	Tue, 11 Mar 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhVNdgTZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72225E83D
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711641; cv=none; b=V2tstso1mBC81iCp4r/9hIsGH/Pp039zNTIRIqKPTeEfIBjzx02undfO8vGvUoCvHiDLcj4ThbNqPRp8NF51kAL4dw3WzqDCciiJePW/xrzy+1R74OhG0B76DMaP+Ukh1dY3yiazBYHSq6Q/qQOVQOvEkuU7N4XTu7Rw7JMaisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711641; c=relaxed/simple;
	bh=Lr8zNkZl809MOIhPoVDsIbz+X1gMtYCv3KwPHC+qhBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA05vZx8NSX5uISaHN7iSS/6OFT6R5GdWlQ5JRSqMl9y0KkQWuHbQJsPIdMZu4T1NWzVKxxESg6Twmhk7GY0dOzdXOyj2YYH3lZXlJwsp3Er1h/zjDDFQHLxmNYH69PY5aGaoN2CYJP7gXN93nYzqKKovLnid7Omu5GJKtIvQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WhVNdgTZ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so239853539f.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711639; x=1742316439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ya/SCcQg5pOPa0gL5x/xnC2JbLciEJIK5frt9Hsnh0Q=;
        b=WhVNdgTZGscIrlbv1ogV5D0g01Efnnjo2Km5DTLR937E0xghnmOUxseZQCS07oeaQA
         lmozZz7RjNcLNdKwTC+LnCGNGHVhsQwR3lPZ1cziIaCFICknJLOVRHNQ8flzci6hB6gF
         fFpoTQWjSJp/sIvCr6lFZ3SvNUFmjFLxYyC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711639; x=1742316439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ya/SCcQg5pOPa0gL5x/xnC2JbLciEJIK5frt9Hsnh0Q=;
        b=FNTola8WLnigqaNzGlN7my/GzsEkYCzZD/ecWmwQ7bwOrwR6zCmhWBc3dROj2r3F9C
         u8iLb4HrOpXTXVEH+gEY7DGgLWYZNuv6802UMmX8shXowtggMwzAmJFA61c8fl39Hoie
         kTghgxv4BM7nQ6AYQ/817vrq6+bO+U5rskwZkywvKrLxNCuNCjc5+XqKflTSf4IxTQog
         aCRA/quvig2xO7+QKs7FqViVqJsq5h9CLLhBEB41QamjqLYD0JIG3H4W82D97KMcU46c
         mT4z4D9Tp0d7T5krPqesqiKbqUipXI2tgyPyEmFgQURQFN5LVFSUgrQjMhMvzP/UvKtE
         p8TA==
X-Forwarded-Encrypted: i=1; AJvYcCUTfzfyNVa32rFN8eO5fsEcK9WWN3YJRgmggeS/0aL/h6DmPRSzbvUcpZ+K8zyeftU48IXqgfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0tYhDafmtjIv+Een+OFRF1PxA3jGxcuv03ZRB6kLHq65qh3v
	M5nTRyRi4XU28p57MRfNlDtf7s7e7YJyNRyBiVNV0F7EY/jS+wurp9QBs7u6hp0=
X-Gm-Gg: ASbGncu4f2I8OrNNO7TyICq4Yz9KNyTq9yJhyBa83k4hZsS+qvOkYgENHjpU8tYe054
	7JwCW9SuQJc4jBZ/VBhtMUsVtF1izEHutpT4SNC24t6PA2Z9nCaXdENOghaOYB/4wnnu8qeu/3W
	fNWNpeB/Vz9N2SuVc8f5Zj8lpF9gfn7zrKFiZPghtoiYUE50wN5PdKfxPjt2ZyLpE33u1Cn2iSl
	XlXTHJOUXOoQ2j0+6k/VZBCTRqj0YUVsL5F5BGOCZflBZDqVJ4uEmr0bTDTb0lmKXRVveBdAhvk
	HfileYIKRrW0YHGKx+GqLq7D2phlWIEMbc446qIoUOXr5TycGtphqzo=
X-Google-Smtp-Source: AGHT+IEQgCPhuww2FzPObKtYHJfNUKNZ4AwdoQI2ZwzxZCEL5p9J6b7jq21Rn5Xq7Ea+2Z1UlrfUBA==
X-Received: by 2002:a05:6e02:174a:b0:3d3:e296:1c1c with SMTP id e9e14a558f8ab-3d468921f95mr44132895ab.9.1741711639211;
        Tue, 11 Mar 2025 09:47:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209c55460sm2827091173.0.2025.03.11.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:47:18 -0700 (PDT)
Message-ID: <eee86dd7-68ce-4147-aeb0-e009aeebb80f@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:47:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
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

