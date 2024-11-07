Return-Path: <stable+bounces-91859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708469C0EAB
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3097B21BA6
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD4217F43;
	Thu,  7 Nov 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRGqZWJe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4F217F42;
	Thu,  7 Nov 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006621; cv=none; b=qDA5Z9h+vihGXeTkNH1U3OQyi05bTbmbcTX0GLTGNoPN46Euml9qzsLXbb+QNkg6HomgDdRxIy/4Ss08ClV2/HqCfylnJPi3BWF67FrdNphou7tUQO5iW9xHQ72hhE4F8f7eIaBXkX1ZGxBk//ETu3A9HP8wnaMPENDwVo7V/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006621; c=relaxed/simple;
	bh=tGoBycTXxo0mx1M7toDsrPWRE++0SXPcQIoTLDWoxp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amwj7pAO3QdH3ml42944bih9Ur6tgAxWH6JESfv1V2SdPzSN6sQ4lXqDio3s0OYtBl9g1vTJEeoM914MaTLHoEOfEd2nyfTGI4jnPqHSgyOsGAkbDGLTfKM6rKgEpNtIROAwV37asBNYO+iWLtJPovsIo3CO8MhhHiHxJgsAqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRGqZWJe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4608e389407so14905261cf.2;
        Thu, 07 Nov 2024 11:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731006618; x=1731611418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir6wlx3IvE0lY95Mpvr6pWUWiaMuzwgUYeqA+dpdOts=;
        b=dRGqZWJeT1Lnm9jU2pfNJ5+dYxNrZE5IOOqrOCBZcwKFQZerP3sr8a0jMlwKJ6Gp1i
         XDbB/sKM7akCguSTFrHo6bkQjuxRrvueU9b+bCgFuGAPPxXf+vfddGbeAeSXL678HJqn
         cWKx2YP1aEc8X2yi8iwbUqGAI6flJ3/uXLfzvTHtboxBpdXuyheHJXd+ufmIpvANezWX
         wYMtBrYE2pa3CKb5MDO95ixjErm63CuPGbmh59ql8nOltcUaHwTIoVMO9b6HIVQRvWvx
         lB4R2+grU2wRUy4K/cNz+BOk+S+IS51k71ygQvjnLQ1Z/JV2p7mNEvP+XUpHd0TYZOZe
         1KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006618; x=1731611418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir6wlx3IvE0lY95Mpvr6pWUWiaMuzwgUYeqA+dpdOts=;
        b=GeuCxetajzrZvHjfkiN4F/cmikd6AKCsVjx/rdiaHK9+B1mFHbPG+mTdMZQma5zjqE
         KTIRlE5KaA4+zVlQQB5FiAYtaDMhIgKRAAeOX5elEZCZU/xL2N8XQ5qze83ueVmTA+Bj
         UKIHaGjTL9Oy/9TrkPA4Qng55BO0c8l4qdHDhYoZYDSZBGLwYfCSYwcOukXOtzzKj3kl
         zGopJM+52TAfOSO+tBmkFZoahXfHMdci7rdn+NIxxdgnCJ0FhzGnf+fqC0GX/8+GU4zb
         BaRjoshA8p/VQ8Rs24ra8bxmnDpmnsnmjTUJ1scUx6GdECCTCkctxbIC7YdCHMSrQLjd
         EdoA==
X-Forwarded-Encrypted: i=1; AJvYcCV08Z6hLdWxqbJXHE0MfYqvp6usYSUIhOL9HllY6xwl5vSut+FHjY3Y68JPwjFVt8OKPY8iA5yL@vger.kernel.org, AJvYcCV8sk0RecccxAf8dqPBveB6xL9o9Zj+GAHR15ftJNFnVCWw5P/MAAxd0O4puZsoQZAVUq5arbvC6bFz8y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYE4KlzrxEpjsCzG7g3qgM+H4eKRUEXS2QLJagRJEKKUEx8MiQ
	bZXw/FtPBssoXPMad7VP8h+jT5HP0vFpJcUKhOoXZX5BZ7uG9q96
X-Google-Smtp-Source: AGHT+IF6yGu5NeFYB0p//+sYa/NfBjbYpBWHXAAYmyxbR+gg4I6LizlJqv/jHYyOYOYgJszmAfz+5Q==
X-Received: by 2002:a05:6214:588a:b0:6cc:22f7:2353 with SMTP id 6a1803df08f44-6d39e1d04admr311226d6.33.1731006618312;
        Thu, 07 Nov 2024 11:10:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396208436sm10495136d6.56.2024.11.07.11.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:10:17 -0800 (PST)
Message-ID: <cf7063cc-fcfc-4137-af6e-9f1582041d95@gmail.com>
Date: Thu, 7 Nov 2024 11:10:14 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/110] 5.10.229-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
References: <20241106120303.135636370@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 04:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.229 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.229-rc1.gz
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

On a 64-bit ARM kernel, this warning is seen:

In file included from ./include/linux/mm.h:30,
                  from ./include/linux/pagemap.h:8,
                  from ./include/linux/buffer_head.h:14,
                  from fs/udf/udfdecl.h:12,
                  from fs/udf/super.c:41:
fs/udf/super.c: In function 'udf_fill_partdesc_info':
./include/linux/overflow.h:70:15: warning: comparison of distinct 
pointer types lacks a cast
   (void) (&__a == &__b);   \
                ^~
fs/udf/super.c:1155:7: note: in expansion of macro 'check_add_overflow'
    if (check_add_overflow(map->s_partition_len,
        ^~~~~~~~~~~~~~~~~~

-- 
Florian

