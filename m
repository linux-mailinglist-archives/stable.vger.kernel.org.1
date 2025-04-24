Return-Path: <stable+bounces-136584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF79A9AEB3
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88EB188C307
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE991FC7D2;
	Thu, 24 Apr 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7Au82d7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396212147EA;
	Thu, 24 Apr 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500501; cv=none; b=ae7MfISw0uYorT0fsvT0q295sneYL831hpJxSZ1FnlDkHFiIqjZkGlxOlCmZ1G6HLqNEfZt9i4JPqxfDE+EFV1T0qm5Gy39AN5XyOxoppYePacF8epmRSJevSxgEq+Ss83HdXVUBfgs1n/aXDnmVnDQv7Qwv4B6RVeyC4SKSVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500501; c=relaxed/simple;
	bh=MmQivaCAg8tEYXM2sdUm+aQHV2kEz8YdbukVCtw/GE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SB1y9PgM2bMkIfJlYntb+dBKtCa2MqM7226SVGG1tFTOLZ95bFaUkqh904kohGEohDRUncMEqM3YNfe6tIjAdt437MRlXmv/YnuXOBGyFoYyY9CRm2ySr2ittjhWeV50sVnFByUbGIxki214G8D3wtlglwkIL3PECLMB3DnhM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7Au82d7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-603f3d42ae8so676990eaf.3;
        Thu, 24 Apr 2025 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745500499; x=1746105299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VNC2IbAuUZF0DyOzLAp8UCmn1hn6sr2yALf7UEBez+Q=;
        b=I7Au82d7wTtRrFae/tkEANIZ0aA9gamsS+kQ3EzM78i7jYRSOGK6Je5bMiYjXCuWeC
         QYHDuuZkRxMkDa/5/unPFgDNcbhsDvzPk8Uta49EhLeT7dE3OBGOwj1kl7rvP1TajQwx
         9FBlTAzk1QQu64x8FrftOB4KpdLDTzqPO7yqV8cUEKA06XaSEXWkDTx/arldk8oUxjGB
         DZFwAkbzTtz56rV9We9vY8Tosbm+u4VQixps+sBTw3surTX1nB5Iy5Y7OXXzE7iP3/Q6
         R+YbtH+u3xmHxI9hx0/mjg575TqALaOjVxAJTdO7EGhyMIEzu4AMDrNOGm0rV4sXcDQR
         L2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745500499; x=1746105299;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNC2IbAuUZF0DyOzLAp8UCmn1hn6sr2yALf7UEBez+Q=;
        b=qWLZiicwk75ePxhOJxAH1cfh22rVKixpcIin3SQKw8h6R8i3HWR/FINEID6p1d1M+T
         oDR95XjXRUG9rdW9ebtdOQD1DXAKY/t1dH3Wvxh0CDl3UVN5RsOedOMvIWcg6RCyPgpx
         fRTvHEmtqS6cywXLK4kxhyPvzHuLo9BIbfQ72tN8k0FhOxL+2ITDq24qQooz7FFP/VXA
         VdCUId86bSGuvfiu3NMbrWonim/r3Dm2xCGDggLFcKJEAzHbQIGsFx7wqQYJ0aL4Pi7r
         GIuH3lZG8PWQgIdrnjPUUcI0BVY4xD/9GJMAzX4UqZyrIhaSi5XZZT1gt8B73UydLcRr
         rzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuzIT0dfLDJbf4lQ4bF9VIPukvH2bs1homvQcKBSAy8x+AoS9s5MRHCp3gPVR+1t6/mVkDJX/9AA9AiAw=@vger.kernel.org, AJvYcCWAJ/XYVd6bRQVS98SL7PvWtGM0k4guRTakuhLdOQ+9bCzzTa8b28aG48VL91feqgzWhw/dEca5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3QZBYZycWvFnZEwQBylwKdVYDQE9LafBNfgTF/smkwoSlQYr
	qn/cvt8G8RnS6ku6TfAvTUpPDM0bI2sI3PFX63I0BWJY/4AFaRHI
X-Gm-Gg: ASbGnctlpyalLuKDBxWFNtIB6fcQ5y942NpN+uKPpp5HaMZBSYy1G768qPE6C0E7C1E
	7c8CVM9HY0JyfY+KwyygqCQt7TSYqOno8c2zymWVS/zr6Wczn8dIxVsnWEQEtNt/9a4xAWoNaYW
	AAy85L6aAh2RnFCnuinUGbXbgn4YXlv1vGrlEq5hCyy+TPAH/KK7xYNsiMINy8HkGAGGiWmbCF9
	XlymkTS5Azp0eH3M7KE3lF3W6lH3bYMD2c9y7LsOHB3EC0/xX+zytrgsE1k0imvnDyPwvEI1myG
	ERIw4EmapIkL3QgTX7uIFKeZ5H2anbxuceej/ZKIzvA1QdLLkYHQpFiUCABISYM=
X-Google-Smtp-Source: AGHT+IHE/s2a7c2zWEABf/xYQWKbn3D/rSgONQX1WTfw/F/9R5F4TTHzfMd/Qz/dBw7n0HSIazvesQ==
X-Received: by 2002:a05:6820:1e03:b0:603:f526:ce1 with SMTP id 006d021491bc7-60645673438mr1285447eaf.8.1745500499183;
        Thu, 24 Apr 2025 06:14:59 -0700 (PDT)
Received: from [10.54.6.12] ([89.207.171.92])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-606468a04fasm253901eaf.20.2025.04.24.06.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:14:58 -0700 (PDT)
Message-ID: <1a05e32d-ec5c-4cc5-ac38-92741a4f5221@gmail.com>
Date: Thu, 24 Apr 2025 15:14:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142617.120834124@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 4:41 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.25-rc1.gz
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


