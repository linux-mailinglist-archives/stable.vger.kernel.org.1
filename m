Return-Path: <stable+bounces-71336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C994596163B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 20:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DB91C21457
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351EC1CDFC4;
	Tue, 27 Aug 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfgIdqyF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3E1C8FD4;
	Tue, 27 Aug 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781783; cv=none; b=nWO7RPMU5+hlVzrF/eocfaAfEMABrACCbcoUInzInfNhUG8tiHpazvetZxn/e4a30LQLNQSsCZ5wF0riXzYfEGMhV8jkPLLjWJ9fQbRSZy7Zx7Uhex+FbJlx42W1A/pYNrnckQ7SLGEtLrW0uaEW1rDRwZg0rj3fF3859/D2Vrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781783; c=relaxed/simple;
	bh=uDSRe4+ypz3TK5ICKGKQf7MdUR2fS3TzFqfb5D8FN50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7DbqNqJPqKmLuEZeOiDZWYwd/QkDHyN96t1uF6QcLfu7SpE6+t31nNU1jowcOjNJc/K5KBsjrt7IkjaBRfKO/RJ4BiWWgQIVMLUxYBHVMHD+g3wR8QMmOiUau+hIHWPyKNkwZb7TAquwE7ZGnz6Kv9qNQ1HDmWDCVVqUABMwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfgIdqyF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7143ae1b560so3246291b3a.1;
        Tue, 27 Aug 2024 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724781781; x=1725386581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZcFyZyRdSFfHxupkjJyrWOtZv+pT4JWFFLO3DW9kp4=;
        b=XfgIdqyF+kVklAnl8tOTih0/pZfeq+oX5pY4h6TsA3S5vG8M8MFhfFkl4nAA2CTXE+
         iexwKGFdExuRTPZdaqKpHGplNXCUQUIhWUxVms1AyuldOibGviXv4ZUb//IeEoRY6CeQ
         heyVSaEGYhpltpfPhqao/yFUIAr6PB/ZRUtCTjVlM9iZbFrNh4+QJu7DYrA39pYv9D5I
         7z0uIPMfUmxgeSA5xn+AMzHp3FXOOT11hEQKrpefqZgkQc49+HDdTSGnRP9wY+SIdoom
         mQsFZov5c3Gx9OSNFxLpXAPWq7xEb+/6yfRz8mxKFUFDOXzqgFiTFHOCfAJNn/MG4AHQ
         A6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781781; x=1725386581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZcFyZyRdSFfHxupkjJyrWOtZv+pT4JWFFLO3DW9kp4=;
        b=rjxeNZZNGi70uQw9e/N/hAk6X/A8JjumAHaUNfTdZvf29W44vThTaDAello6F03qdD
         PtQFH2G2ZBveKKQrHz1tIMrExP90nknYVBkT7asHfL04PA6wCBXJjIYO/Gk+2TSv8PiF
         RYPmhlXR9Svc5gBikz2Qm+sL4WBbHweKEufR4H7k1FRvMKWrltmFBZh7hPSJ30aDHRv0
         MVJIMZf0nfeXlxfMrkaClAjqXlVuN2QXcv7gS/7HMh2wPc/ETTkUNfo6jRoaASw/p4jp
         fLaLbj0sQV44p/JsWHIuJBZ8UvPml1/1WXgLEduFt2KTLe9/r5uGwLZ4y5JsZK6Vs8kJ
         G2LA==
X-Forwarded-Encrypted: i=1; AJvYcCWWhXSO0BqKsQhFObRh40vMCeZ/3oyFHmoxMXErU4fFuJzF+xGeHNFIGmCEf71MuGVA6tyAezYA9lz3ezk=@vger.kernel.org, AJvYcCXCc3svJrbOM9N5T4z7t3uDe1zqCQbKIWJ0MMEknU0FA2rwZvHdRMdeVNuQZLo+ReC2Z5QQI6C+@vger.kernel.org
X-Gm-Message-State: AOJu0YwMBgZTBwlCXLa/1SrPQkYWTJXAPdWPi3mfZb42HzV3MnYFo/VS
	ooAu9YoFyGoyq0DxXnLs0db/8FyXXgHRQt4FpHdiyP1Ukty9KP3T
X-Google-Smtp-Source: AGHT+IEm2yR2cpxVil+mWKoSNbqIrjenA9TLxT322rLBAqYECbuk0pTTEPLg5nnyzwL7snZPOq8AYA==
X-Received: by 2002:a05:6a20:9c8f:b0:1c4:bbb8:4d02 with SMTP id adf61e73a8af0-1ccc099746bmr3997304637.37.1724781780891;
        Tue, 27 Aug 2024 11:03:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-714342e2194sm8827604b3a.126.2024.08.27.11.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 11:03:00 -0700 (PDT)
Message-ID: <cca42eba-8b09-4552-ab2a-395cf28a6b24@gmail.com>
Date: Tue, 27 Aug 2024 11:02:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240827143833.371588371@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 07:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
o--
Florian


