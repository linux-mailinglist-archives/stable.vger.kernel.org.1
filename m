Return-Path: <stable+bounces-209969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4ED2910C
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDCE3045F49
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618232E15F;
	Thu, 15 Jan 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+B5Gpwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4A272813
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516874; cv=none; b=IeKpCeVUjx2071JjKrk2VcmHqylvjcc4YsnQjoygvSJQsmjlufcrjG4DyN/IZkBVMJCjI5nYTeVfGumNKOFqKf/Qkq/NT9Vd99T1DTCHt9uc8x05EjB99L/6KUcV5uEggtc7FkGqbr4XaE5M1yqtM70kxFwSsxV3Wjw5VFYZTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516874; c=relaxed/simple;
	bh=2lYwqcpD1qh8oUgxiGPRQqTQgcICEOUzpvRx1FHvRK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4C2Ojwg7HF5sWThsBFXeJnuccpCifmF0sEE2Hjxickgo8aHjJHSEp9kMmGdxGP4YyoE5GIMSNP/Rpp9rOMNdoKAyC2JSJLqE3OzPomsEWOdjqyUXjPkd2vTSOCBP/S9IpkdUwVxmri+Hmm+445abLFD1kL9NKxB+JsHwz+0uNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+B5Gpwb; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ac3d5ab81bso1672357eec.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768516871; x=1769121671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtP8XvmEW21KLqk2Lzwa2yyH3DFghc0b3G/IV7xLbn8=;
        b=L+B5GpwbD7MmDTNNvooAX5YQh9uh8t0E2JvywEOhXFGElvMg5zeUZgJwJ2EeJLoTCx
         DVLu0+jSUTSBOy0pSLIukTY7KIGEN0/2S1UWsIlEAa8z5QBSCzhU40JWnXWIc6akFsdd
         AVxslT7oqHfbWGTYPp2kqQ4ETFRDkASMeCWLexzJUH9bN+oqCV56QM12i1ifpbMpOZQ0
         FpVQKDNJVe6+SdKjk4fl42TAWB8Y8rcHHTWat669fwAxjkbhytZUXUl+4iWmefkaCtIU
         +tbK07F3gJRupop5NoeIf1p8xNPxQ4cDkjWkEvFG9RyJJuVWrDr6sXIiY29TM59EfLq0
         tW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516871; x=1769121671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtP8XvmEW21KLqk2Lzwa2yyH3DFghc0b3G/IV7xLbn8=;
        b=MxuBQVfZPfg5yQ+MbIT5Gjn4cBiZ9OijNTddXpLNRiy2IhdIIRFC+llUk/6MmPm4AL
         N+8SYXBEfFblbmyWElmPsAX+1Hnlf+uz4mjkCSdXkADpvQCzD8029yXXCBg+eZNBCyaQ
         X2tiRrDt6VSOd1FR+RqvBgZBKTBAyZmi0/0Fjhue/vPJh9jO+j1Md9ZIE5XWtZTcQNzq
         mwJ0q/itC4M+T2hGqETn3dJgPVKw2Gh9sJqaeg7OYFPi2h3TWtldWM40sY36HQ4LOQVY
         vRPRcPo5q9ljg3KjFTXYoQXf69rjg4AnUmb7x+Hz1g1uty1AtWFrPtc8dX1Q8lGzghw5
         WmAA==
X-Forwarded-Encrypted: i=1; AJvYcCUDUDV22UaFNYOCwzm1buDfGzy52rKtnjFuVKiy9NKWHv3ahMUmpV6w0g2TqMLTqc+Q7A7V/sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTkSrAfmkY5l7MA4exRDOCgcsJoLAFa9oTZfCFXrRTF6D7kBQ
	iwIIptT9qhfEGHW/iuONR1tn3n0s4XSlcJ8FTloLMufKtvHy3qJcAdWG
X-Gm-Gg: AY/fxX6dHkK/cJnLClAMeYNoI4ysJMh/HzQBUiQl0pnz+qkWgfX0X42zvLB14M+f6vy
	Ezq+isLI+jPql/gaWrKP8HGbkJgUiYl027EF9flHF5jQuR4D68iY9aPVIt+wN6XZp1gnLdBwws8
	x02G+zWNiG16sSXjluY9GqX2vt5tr6h9xTX2JUziP62D9f31YZiDMty9+/jcd8EBlae0P2Z2mIh
	0k2hSlW2j9sRkhFRMcHyY6U42VK1Gc2c+N8u7RjoBPONCtio5uNI3FUCSLrfwIPt+rUanSQbZy1
	8igTEPsQcPHRVfKk4csC7Wmbd66M03dbWJjKFTqcBNxCvqr1NowK4O1JE0N2b5pDItSIIUFxpmY
	2Vej9CorJpfWB3itJJyfyrt4WL6cndrumpaXFpLd/b7t+Fm+iNIXbV+3Ih4lC/52uAKVFmYOfLX
	nViwGRX2/nOus3twFS+X+GTM8w5/uNAluFOnNqKR4xq72fD2L9
X-Received: by 2002:a05:7301:4184:b0:2ae:5f34:e93f with SMTP id 5a478bee46e88-2b6b46eb0d2mr957343eec.15.1768516871197;
        Thu, 15 Jan 2026 14:41:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm631683eec.19.2026.01.15.14.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 14:41:10 -0800 (PST)
Message-ID: <f1630172-8a6e-42e5-9771-563cf626478e@gmail.com>
Date: Thu, 15 Jan 2026 14:41:08 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/88] 6.6.121-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164146.312481509@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164146.312481509@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.121 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

