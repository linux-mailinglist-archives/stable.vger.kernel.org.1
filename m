Return-Path: <stable+bounces-124085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65FA5CEA8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 20:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B93189DB3E
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A029264F96;
	Tue, 11 Mar 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj/KVkgc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2884264A95;
	Tue, 11 Mar 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719746; cv=none; b=KZSD+xqYvEFyxAqYBIDaydycMOmGv+cghhaJ5xzfqYu98pHU/g441TNy/1/bnLa9JtYIRAV6KZcrhA99qXlz9DRHEZ5XLfP+SZbqi+fre2jAAgZw83t1jIbfXxcZ+4lZQFLVxc+wrcQyAbHbNkMpMNSbUemKsgqs923OrhXlsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719746; c=relaxed/simple;
	bh=GJXko0cS8yP4tyL+QO87NkVReVjTG45bw3praeGh9lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSB5sHmRZnLZlSOjbAYAiwdkaLKKZAclj0ynNgTIxCcu+TkHnDERxeKm7BFGw6EavMLyQGeVntsF4JaW7ewcMXIx5LIn4ObwDjHyuPpbAzGX4ofY0Lci5NNYK7VThkcExM/LsWXD3la+6CB/ZJXVNXYoEO1d/AkPQ0rAG8vsIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj/KVkgc; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso2579813eaf.0;
        Tue, 11 Mar 2025 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741719744; x=1742324544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0nTZ3/CXEq3pQeXVLu/DkAtfYCx6dQ3g1oqxdaL8dYk=;
        b=Fj/KVkgcdkxnEl9s+cRIMr3+oO9yabKnvgtEd2CoZ0qE8RUcpRoB2OJj1QkUDw59F6
         ioCW8ZWJuPJ1fmqEZ8bJLRgvUGkxl8SR4+vmrhuR0paebItYRB+15iGYjGS33nFbCNor
         tVhQHMMVsqLh9ev6GWDeSwkfxUj7Xc02S2Yp9NfPhdcKQxM9B/hF1BT1b1e/VjeH978r
         fpCCTgXbRrL2wojGlcXVh8Y9l16TX0qPp+8Ks4el2CW3pMI+rc6NT+Cms9TTaBZfSP4U
         uTPOz0mfMDrFsuudf5fbu9ufFBcmNorv7tEUFMeUncNvfhWpWbf13hylBo1E53tYKoGy
         2VKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719744; x=1742324544;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nTZ3/CXEq3pQeXVLu/DkAtfYCx6dQ3g1oqxdaL8dYk=;
        b=LX1Ilmvk8E+sbk7it/0iAfSHCilmyqReeHKQWian/9PiOTE7xWewvTm2J2OiC5cEVe
         g9Q4D2wpR3iu+uSZOWCqWPr+NRaESAXSG2+a6QKSqhJdMEcOYrXFWeGGIxbxlI9JwoIb
         TZdo9vJpDvr3ZxXWeu4wSHSUybt+6ilw6oDd1Xmmq629zzwDB1TQwNnGD3RXiJwJm21v
         a6bOWDlrcgI/RHjQrVTIkpihooIEEi85GHksY9JNVzBhtQjERglUeJnbdbz3hExUekdA
         HjzbFE/ojDmyc5/4ZRORXvl630OKQI9ZBayp76cbQXz4TgpJUW+wdXGM1rKCuElJCSFg
         kDWw==
X-Forwarded-Encrypted: i=1; AJvYcCVjvUGdgqkBmjhf5w58nUwq4f7CPo9AoGqry6jPJISG0CK8n2DmpZVqGrH87j6EO9D7IMod/E17@vger.kernel.org, AJvYcCWpHlnQW3M8p+iCfIhhVq+q9w0jZrAFcsAEFKjA7yIBodzqqh2alm2aRH3JoS7icbYZVkc3z4SrfI9Ik20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJ7CNR1R65m/dJpoxAyVr+3EOF3h9CRirGeEUCeuheXpPmYmi
	5hma25ndkkGUvWMGOLzjsjwXLW4S0i5cOmr6+sZb6N2qRrtUtKgX
X-Gm-Gg: ASbGncvbjIxuNVCIp3imYHgoROmjRv5X/FcO3iaQX5TacfjiNye9PEdXjizqRY3YxwW
	5o2xnvMfzhmU3fQWxI7dqmvXKNIWm+4PRs4hlq+AuKiyi+XfEs/RrnNFIwlrbTpWmZFZNy8llbX
	KsO61ZB2W2WhOuVIqcVqm3vcYoX7m6yEw/epeuq7uMdBXq8jN9zRbIlEod90vSilcMeNnqLQboc
	HmKr/qOtPbd/pJSbyZkA7r4JIgrSIhMqyNMR9476S+HLSHJdTOu1hx6LqbyMGj2Lgamx/I0aV1v
	LMYTE4McmHIwNWjKVN73rsZCT/yUZhGz/5aU5ojkNOoUqSTjvTFlZBy+r7Eyoa+R0r76JOTt
X-Google-Smtp-Source: AGHT+IH9+/+x/0N7zgxNkLoBm0aiQ1xO8zzkxVdxqi8AATpnlRHXNKDgWmXMG8qWxyxKS5+3We4rmg==
X-Received: by 2002:a05:6870:bb11:b0:29e:559b:d694 with SMTP id 586e51a60fabf-2c2614abfe5mr10124317fac.32.1741719743781;
        Tue, 11 Mar 2025 12:02:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248d5acfesm2710658fac.33.2025.03.11.12.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:02:23 -0700 (PDT)
Message-ID: <8f0876ad-79f3-49a7-9d3f-ff6edc2dcdda@gmail.com>
Date: Tue, 11 Mar 2025 12:02:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/616] 5.15.179-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311135758.248271750@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250311135758.248271750@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 07:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 616 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 13:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.179-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

