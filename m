Return-Path: <stable+bounces-163195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E827CB07D5C
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2485D17152F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61B263C90;
	Wed, 16 Jul 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d83IKN3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DB2857F1;
	Wed, 16 Jul 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692808; cv=none; b=CqxX738KbIW+dW8ub4gQgJroGNUmPndAvnhxtujNsTQrHus5YfbNArhMjNbwEkZCU9GZZ62vHwAapgt6djFjsn16g31GBcKoGUR8myIn7aIxCqb6K6II7NTRhw/GG5FYQ1p34tE94jLgZFllAw4uXZqA+lGYJnQQejEAwknIl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692808; c=relaxed/simple;
	bh=/vKcTK2gS9ar+FkbSgOeYbXSM+SH8/yNSbDBJIU6g2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/BkceQO8yD5r8cMLTzNiAvRZc4e7vNfZHtTy7MFj3tFkJe1qyEG/rZjpIfLaQH5yIklZvn/n5+DqrwOWuGBq5LaARpwRl67EspJrUI2e+EGK3qbuTEBYSAZWODzCzOupxkhMJgk5C8b+hDUsrwF57W/vCSWMDdlIF3rlmaL8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d83IKN3o; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e182e4171bso15376785a.3;
        Wed, 16 Jul 2025 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752692805; x=1753297605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BYO9ZuvIfSuMq7ItF8gvh9ttb/3g8sUP4ACrYio1CA=;
        b=d83IKN3oHc565mawSV73IsrXJgkKtyyoBItEOz6FnMkFKvZKovZKaIu3RD6yUyFy1c
         G1HTWS6Xqp+WT7te3eorwdMHBSJJpxbukauBMm0ixm9Qlv0hITHFedciHrMTO1EYyWac
         JBZYw0rOnxkdUmpSkIPOz5eJ+RDkHXulklHR2swvatzuciilS03pwUVunsOcRPIxjLYV
         rdwnKMkJeT13Er1+iOKatpa8rcxw5PeXaPrFJrZNRmE0ESOUYVW8VnItXLtVEY1RKpRA
         vzPrU6ZTJk068RQ5GPxzl+TQvvCuY8iZBbxWBalxKLQNZ8dzXD8VHTbt0ZfSs5eSs05T
         oyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692805; x=1753297605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BYO9ZuvIfSuMq7ItF8gvh9ttb/3g8sUP4ACrYio1CA=;
        b=XYCt1LdocD9xFp2hH/swzOaEcPlvvSg/LAOMjla7PnUUaifBc9eh2OuftmKgIP46SG
         F2OyDV3dtsyq0qsnPnof3RZsdPvo2JU06u2l+8bICgGqP4YNAPqcvhbWT946HE1uyD/a
         xLicHDbAD77ksBj5hDoUKUh4qjqc8J5Ct6ReDh5f5sGkiSb0VLhfThdFuzHx3Rdn8Jtz
         XMJKLmXilDvF/T54i+NIrNcHqIzbEU+6mGDNuOVfmdeq2kYTdZasDc/2tyXju73HnjV6
         F5KMFc2OvgFVfyxkrtl1KvRm//6T6j20DpS0y5XEHXEB63egDsi8nGuMtF9RKKVpmzI3
         pXHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1KQl57ugG8XbjtMHIrBFmnxOt+4ZsANGOHtNHvfJSfisAM5lPBIt9fwDLOh81m0br0/v/6jFK@vger.kernel.org, AJvYcCVpQUKiWuRnRSWaaI1EcsfX/T0QTzxE8/kHaXtQsfue7depUBdOKr+YgVhnLRjxO9DbVTfiZ9nVvMhypUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEqojttc+CPkkI6fkHhNGmLzKcmjzsE3bPOJBPufW5Y3zoQjq
	Zix0wxoeY0O+2+fOQ2XoW30WBinnyRiC3X04DttP/yNYokXw1+1+saxm
X-Gm-Gg: ASbGncvWRAs5Rn8PozQG8Jn5WySOj26HnsAhzITImOjok28t0ijiBZ+pqt5Qg3YU2KZ
	Dei4dD1Z0dyumM3lejJBaC80q3WDxYtO+ktxJDAn2U7Y+P5Y1joPZcpkULg3dTXtZZoaeP4ByYZ
	O55Ra0smMl7Tx8l9Whnl/ZIlJD7+BsPhdR00qXbaPQ2pFpIFtgsSkK0Cb3h+D2wIy8LmFWiQC3a
	NX6Gj3MUf9Ybb0IxeWex4+ve1ljT7i2Kuj1f8TSqzqJsDAzGZ079ebWcgtmRUYcuCQanG1HwNFj
	K5MSnNl8Ppdsx85qn4g1z8OuA3FNDTkxx7460im7+EzQnyql7F5dCM/9zZbFUM3epwQVqVsFbj6
	3hcJncAoTsmiIfO4E35kjJMB0xEOLwHXkyelAshcxu27yaqlFBQ==
X-Google-Smtp-Source: AGHT+IF+R0G/Oqa9G2czscwCIzUnomPjI8ys3AQGvbnlfLXmg7fVpfblVV0bjxR7QV9TucOkRP8qQQ==
X-Received: by 2002:a05:620a:7207:b0:7e3:43c4:bdaa with SMTP id af79cd13be357-7e343c4c0d7mr433576585a.4.1752692805197;
        Wed, 16 Jul 2025 12:06:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3456768b8sm114114985a.90.2025.07.16.12.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:06:44 -0700 (PDT)
Message-ID: <829046d2-bcc3-46f0-bd6f-8958932d6fa1@gmail.com>
Date: Wed, 16 Jul 2025 12:06:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715130814.854109770@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

