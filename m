Return-Path: <stable+bounces-187741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D186BEC2AB
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D05CD4E71BA
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A112CDA5;
	Sat, 18 Oct 2025 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QsB4M/qa"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796B26ACC
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747154; cv=none; b=SunAvAgHy9E8RsIOQ18wO1bzYur6AWyZ7mcCDwuiTLVE0GEYwJDTOS4EauXcWKI1mhRUKPA+17lFE6P+CrbEH7PBgTIl7RPsOzsaIrtRfDW81qb9KENnyBrjtk3PHyBzC4ptyflzOJ/poQ4rwaIa4ZmF+I+6Bew9+CBR9bIb9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747154; c=relaxed/simple;
	bh=wYDlpw74Z3cyAlrGrGpo5UDCI9NbA92k8W5CCOz2vbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPJI1JWaF9gpHhdmcgkbzsS0f4AoZ27v5XQCQkTf0LK1qTV23eew1WKlu5Hl0llenWWsvt4sxrNRkw+b8Wl2fZ0f5tJFW8332Ha3cg/ceH8Di+Ni2+EAUY7orCMeQ6g23URk+YMXrUtt1GwEZXefwUSvAIZ/2eAwxtailbbX1WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QsB4M/qa; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92cebee95a8so105494139f.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747152; x=1761351952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii45rQqKjwtGH5Psho54TOQP3QBwhKcT/rt69FEd2QU=;
        b=QsB4M/qaHts4WwWne9J3ekuorZ+Ledj6XCr85ZIOf+3bvq4BsuPhY5oy3HjV7Vz4yA
         0V/OW2qpJWrhdbAyIpPH5YxNix6+Ahn5ESvaJ9oFJ3DpvTStXYK4vNvYcsJFBqwRhmwb
         QIuBd1idfp9syS19PwAskCj4xr33z8/xOgWdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747152; x=1761351952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii45rQqKjwtGH5Psho54TOQP3QBwhKcT/rt69FEd2QU=;
        b=g7ga3bJGCoOCOrCAN7l2VWg/vu9HALgF3c2GDNdQ5Icx5N2kvSrPqNRxM2Lj56O5TV
         ADXWFfcwz4xByNj5afMlUWbpHysNdgLiQVtzjNh3e3BuiSctBa0KtgRK9RfFq8AHHTGo
         3u+fjef+fluKgGY1lmlUSbkmJUc5zpvuZA2CA+oC+4XyzK27A8IlbFHiy828Y6ANe94h
         5qync6ObTxx4Y/d6rfZ3pE1msb7RC+pzqsAGEOTgZ2vecv10OH8MIY6/7EBfi0pPurw4
         VnESYhHAJHJWKZWhjJNq3YDrL2Ibme/5Mr+mnZyjc362yekj8LL67MPH/m1wf2BbZkpF
         VKWg==
X-Forwarded-Encrypted: i=1; AJvYcCVhDKSP83Qh51mq3vwgjgln/21+CKJce6+luQYJjWt4OgaGlM1/d/oQAWe91dL/S8ZG50KTzFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgarP21/6fWrnS9n/QhwuYtB7hF8jp29QvYhTLegKeWpqrFsRB
	Yk6NeBe68rNlVI1CCeufo1j9XU40OlHLW+9N5UfHc+Ll2jSLuhPrS8qdYw6AGP2W6dY=
X-Gm-Gg: ASbGncsz1rwThiuYv4CB7ihe73LlfQngjvTQcqIbtJ5uia42B6nqCo3JqFn71f6zSPS
	m8jo+PgaJ+ffKdKxaAYkdxVwDkTOouxyOBu4XmujIss3EzmZDZF5ddu+OqFXEsHdI7shayowxNP
	+kljfedAfo2TWHayGZTnlamz3M6Y6IlckolavCmi8XhEX6Yn8vwTX03bh6WV3mGn0FbkkOkOSV5
	ZO9g22yhUYR2mlnbZv8hwov+KGs5eX+WzTPG8WojTaoqTyqJi4/sD8r5V0CF5s4hZXtc+A6M+lT
	sYpy1Au2mqTm6fQYSomapyWEbIydNIwdtNuwxRerXWJ26LFn0L1qKFT2t7JkXtsazv7f6CXpppY
	08ZpWRY6Z3YiOOEhZE9yLy8qcA5+668hP9wkctchYjGoekaGriIygz9g2ZRlr5SnFLcrGy06IlX
	dDGmxz/Tzwx0C5YG2aFezvIjU=
X-Google-Smtp-Source: AGHT+IGo2Se2kxunEF/SZg2Y4xCxWJXIASoIB5WJpf6wAy+KaI73tMOnfXy92b899FQW/8z6rJQpuA==
X-Received: by 2002:a05:6e02:156c:b0:430:af13:accc with SMTP id e9e14a558f8ab-430c5208df1mr78329755ab.7.1760747151996;
        Fri, 17 Oct 2025 17:25:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fed66sm413846173.1.2025.10.17.17.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:25:51 -0700 (PDT)
Message-ID: <3c6f1571-8e24-4d03-aaee-5852fc9fd943@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:25:50 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
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

