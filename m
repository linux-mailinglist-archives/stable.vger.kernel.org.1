Return-Path: <stable+bounces-119552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48EA44B24
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 20:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49FA3B4CD3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06301917F1;
	Tue, 25 Feb 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0SPbAEn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFB1A2846;
	Tue, 25 Feb 2025 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510916; cv=none; b=m/QeYslb4GymgM/KiOh06uPi9MwGpDYWtxYCo358IC7zDzZkNayQwV/3HTzwtg+G95TXDXx8gB5Cx8BZkhwDHDVLPx8t538ZEGjRqJzs/Pc9CFdQcS8tA7fR59DACqrYzv5812gdZcR5MrXFK4WerloY2aFdj3LQlNKHtI7a6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510916; c=relaxed/simple;
	bh=DSDcuexA9NRCJPkhclcocfqW/i+zO3L62puQ9zsDF6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNA1tsj9fiV92dR1y0lhy59n58ZFcDLqNWw34aFtrto+xqdktIOlmqCZAEDWh2FAasyfBVRr/nCp7p77XYXFmbZmAJMWmlViCtzcIpCrzsIc9ZtKJZgNwhyCfen0RjtFrgehtJDgs0yJ2JxIdDHqCLozzQDTtBMGIxF7oesh6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0SPbAEn; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7272f3477e9so1831763a34.3;
        Tue, 25 Feb 2025 11:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740510913; x=1741115713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCmpdiWwybHJ5Or+j67rh5Tqf2Twd+jvO/TNbWf9bY=;
        b=X0SPbAEnmqPq8Jos+fxffCYbhnYlNh8vgILhepv2Zdq/P7sfzlsH5hTxz1I+Mcr233
         UqFXdyrmK6Z6yzQkyIOqq1TuLlUWxPWHA0OJaX1WVe9OQm5rvhbM59ChClWflOJO1oqX
         aKgVk1kyRND8VMqjuFV8jAyozzkXKB5Nen42T7cDuWn/sPVMawdd8MEJa3d8AKIHm4Nr
         LzSBq9bahYdjVPzVnuL/2GTfTzPpFfFp6KUWwb17KkDqxHB9kxsLYFwgmwlu9ZgVqHm1
         KTTINvV6yENCchmJMOCO5DQ10Jy97EdTQd28mtBfUXf5KAdgUQEi1+8mnXJKffjDfIQe
         Ge1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740510913; x=1741115713;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nCmpdiWwybHJ5Or+j67rh5Tqf2Twd+jvO/TNbWf9bY=;
        b=sfo7jLxDBBhFHdgBPyobjnSvvL1F/09oeEx2zH/35MKyVASRykQWqHhpyxxNmOyMFm
         Awa1j0KjJgGDl8ZyhMpSHc2x8e6XycgiiN087eyoVK+P2VoBIrhAfHweNLHpbl33MNQU
         mMbXMFJ4/xXt4QowjX0G7C4wqK5cRobCZtw9vGbTveXca4uoKECKxDgMwYWPN/vbb7AC
         xdRbLa/vrnZw71TeDfSlkKVrMIUTv/r6BlfyrHUHQvOcRHuBLLYswIo+mqiVv0/d07+M
         SuT2/mfUFK2ZTAMcUlJwEBPz9GBiboY/LNhdziddvAXO5XH8RQbU7tOKeT4p+2BgYtJY
         gbJg==
X-Forwarded-Encrypted: i=1; AJvYcCWqovuj/n1o5xjF6oAhH6jj4g6p8iayIwTpzR0sq2+hvMXWBhdyTNpm3UQwz7ZcFG/ZERuDKk+M@vger.kernel.org, AJvYcCXDODTB5vgSCrrlH29gsgly2TS/BFMXsHJQkQDIji8B+ucsT4NTCv4w53tlAM//IOeW2f/piFI0/sKQX+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBJpKipNWSlP3Qq812MFSZHcgxZWWPfL9xetA1Jktm3rqBdhN7
	aH5X4X1n5bPxsYnT0a6yJpMd+Miq8lzpHn7Xx3aafd4dJ+2Koumg
X-Gm-Gg: ASbGncv8o1IACG0GAIPe+8iwx60r4+mmt/fb1L97+PCuGL4G7fm+pP+ThLXBAw1xnum
	YXAK4JohgMuRFY8VoHso60IaNBV8ExTC3bM28MHp87WS/P3ji5eBuD5NjmXsBRdnkVqut34YG/0
	UnQKkmQ+xce1lNt7mfX+YvjF8Dtrm5fELz/1p1lfsoiKNS202VXze1vwKLY6YVgDMkCUp942GVG
	9oJ09j5lxrv5KDRHf1zdfle8c+arhiRnohoeaX9LjS/oglIwU4rhEt9lkcGd3yJ6au8P92Ju+FT
	IbvaG1ElIB1osyaxVIeNDLKZpckuYXDRe+XXv31lPg==
X-Google-Smtp-Source: AGHT+IHxK9HSJkQGHeaKwTTRSQTnFChvfSwiDjnkwf7FjH5/sXmwBWDELznEqDVX/UCCANo0lOb4mg==
X-Received: by 2002:a05:6830:6e8e:b0:727:2252:226d with SMTP id 46e09a7af769-7289d0ef003mr3197396a34.1.1740510913290;
        Tue, 25 Feb 2025 11:15:13 -0800 (PST)
Received: from [10.69.73.201] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9410d291sm403460eaf.5.2025.02.25.11.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 11:15:12 -0800 (PST)
Message-ID: <1916f14d-03db-4644-a68a-dea428070fcf@gmail.com>
Date: Tue, 25 Feb 2025 11:15:10 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064751.133174920@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/24/2025 10:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.17-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


