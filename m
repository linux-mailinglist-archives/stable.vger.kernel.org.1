Return-Path: <stable+bounces-136486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23CA99A9C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0784E1B87172
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA6266B4E;
	Wed, 23 Apr 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3DYDO1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED621FF59
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443050; cv=none; b=IAJxYEikSxHIW8OnipWLTh1/fpPkaMq/LAuzJT+n/GGb8xqqay8VQ54opQwPRWNseL5kT7Fpj0FmWGME2Yk5Wf4d7/cGfAwL2K/tWQ9iNjDxNyqXtzZ6ANXorJW0vLV4yYrT/zPsQD7qsDsnh+VRLBjcbb0IVHSExqHAMvZM3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443050; c=relaxed/simple;
	bh=U5ZhDPfpS+YKKIq8omJZ8lYB+4B7ZbQsmohNqr+ETkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bS83EMQ6sV7+LjlYajyxXM/R9EJXhzSlO+xTjGCd3qSVGB8TPKvvGw/2uZenJwtpZYVFLPEaNwhAGX3b1+6RAjlTTCU6Qa0/prjdoZtIceX94u9zH0/7mfrWGP95b49g6/n6onMl4J1HggIw8heYvbfUrcc1Q4+KvC1SprTrCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3DYDO1U; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d81ea55725so1062185ab.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745443046; x=1746047846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chdVg3DD/9/cLpbZdSTropk2aaUqeVP24/sslKciaJE=;
        b=X3DYDO1Ue2k9bnxDoJoFt7TCp2EvJReukkfo6oc+xMXvx0LhCOhneIA9ANMyfc5QpL
         LrNyq/uR+jYaMW912xGgH6dac8n0sLrCW4OcTFDPSnyavpQdimAsP07rH0ehrFpXKIpp
         qBJH80CAc5zRV/jBX9BoHFryBIbOIhQfbP3xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443046; x=1746047846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chdVg3DD/9/cLpbZdSTropk2aaUqeVP24/sslKciaJE=;
        b=skzBQcBUHnpz3gkhBkcahBc1fAxn9jdYSNpzRsfWVbmVpoQeowrtRVAO5yxSCjn/B7
         lBo1ySeCY0g0JnOx/RddnxuVE1bStRqKqyG4lcjFsaGYj5cEJJaJLOhOolpKBVz958Hl
         HgVqDFvgeZUhmvi9p0okfq8fvuEjupXfOrzDBwPBpJ868onf6XMagH+Jj6ycUI/j0naA
         5Ti6eHplxcYgPIExzgVRZtYkd1Z8kFa/E0tzlVVqWMqwxesEjN2owPXFrFw3lZmd6Lsv
         pVk9WHvqZoNFKTl+pkbrlbTmGau7zN+8/EVjkKe1sU7BNlvtw12Ivw7uEh7Zkhj+uEe1
         Aexg==
X-Forwarded-Encrypted: i=1; AJvYcCWJZefMjQccgAb3jCceRFiDM5b4yDzNeCqkPN2q52LzRAmbUb453t1Xzg+qAHnCTI6rVHIdMW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNfPxpiiBpmYUMV0HzD8bV8wYpMx5K/tcv+mIB4yrzJQJMO9+
	W0sCCEsjCzkcnhcDrAqx/tmZWY99RnOlfDwCrXUONi3jqEA5l8d4Lp18nbbE8w0=
X-Gm-Gg: ASbGncuxdQzZwufveI30qBWPNbZMZdvkr6i+e2aXu8/ULuXcxzfv0CRQFFnUyZ2loOO
	lwlnO5wk8kQid0nGyTJEl2uei3or8yOkHLx647NgV9aNENhAXT2G8AQ2qGz59PfZgzoo7x3AzN5
	1xdI1e0l5As/z8/eqVHSYQQxTPkLfv+UvC7xfrytuwhH58rzDI7XCTNxmhysZDKx3nJdSpdGGBW
	CVauy0JEGZS75NAszk3a/H1X58nDfGCbdztNVdvWzw//xdO6tQVbsj4iLUUtcDFVe2BS4Qtgh++
	AysRHoDobY0ATCf6n9zrX+pYa7p7+YvoFAmht4G5LRjuRJVvQAY0VOZovAndDA==
X-Google-Smtp-Source: AGHT+IHCn2m04+D1m+Vyv0CL9LnnBZoMW4EoCPPLnYGeV85B+zuoNK55CnRyXvy7a+pwH0vkMd410Q==
X-Received: by 2002:a05:6e02:1564:b0:3cf:bc71:94f5 with SMTP id e9e14a558f8ab-3d93041dbdbmr1891995ab.22.1745443046107;
        Wed, 23 Apr 2025 14:17:26 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9275bceeasm5249825ab.37.2025.04.23.14.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 14:17:25 -0700 (PDT)
Message-ID: <6c7b5a49-2890-4db9-afab-5af337207916@linuxfoundation.org>
Date: Wed, 23 Apr 2025 15:17:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/291] 6.1.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.135 release.
> There are 291 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.135-rc1.gz
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

