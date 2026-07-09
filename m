Return-Path: <stable+bounces-272938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eAfgCAasT2oHmgIAu9opvQ
	(envelope-from <stable+bounces-272938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:11:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F3F732073
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="de7IzDi/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272938-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272938-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46E19302EC46
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE1330646;
	Thu,  9 Jul 2026 13:51:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1842E8E6
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:51:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605081; cv=none; b=LL1zODaIjgPMfU74DRBUruc9RvdbYmswDGccN/lExNIcABUEsB1NLVc6Ca5P69Oh9SNgFmL1fuu1U85ylYH6NoaNiTJWnSA3QXWxw+cWHO6purt28djFRm3Q5EhIFtki0Ug6O13MvxzIHAQw9au157alcrZxIkZJmp3wR5yo0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605081; c=relaxed/simple;
	bh=qpSIGxXePD5q+WNHiKXJBHgaLMuHvc3z0oUjbEqV+LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReXNnVWvIXSgQ2+nBYZdshiOg3buTVypXbJUUSdGyc2XmILXfgAixLX4TcUEdVWhll896fzIWuWnLZY2z6Y9FcUdjMUeddIxZzTbV0tTuaZJ/agbqWXzcJ69PLN9fsgeBhYSN1y0D3vA41MK0Vf6X5uIL3aIJhPl7TKIzkrP+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de7IzDi/; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4798bea72f9so454892f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783605078; x=1784209878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1i15TENNOeFnpEjkQ9JLbwEKpF9zI2nmRMO6KesUt6A=;
        b=de7IzDi/LPu9NBVfqrLISb9trDGs6yHqjCReBYHYYiBLoHaJZY2Vz/xmIytuSKyg1i
         g4/5CDBJiscEOatiYTrd3dfSDjEGAnyexBLj/gCV0OA+RKw8FRd7e4yyV5U9Ph/sDZQy
         pxkqXKgrK6m+mFmE7uH9GPjcjxo+xlLktAqyzhWp1GJp/MrHkaqoIz8zd2oLYq1T0pKE
         9hBn30AKiBtXnCkyMXLkqcFb2E9yeoQnxH7A/Dst50acyK2yitNOklIfvEKD/RN7OoVo
         E7WF5A72njk+9hVP40gy9wOlD57zOYIhEELO2WbYj8HVbE0IQOBVpyqssuU8VA7AhdwO
         D90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605078; x=1784209878;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1i15TENNOeFnpEjkQ9JLbwEKpF9zI2nmRMO6KesUt6A=;
        b=qdp3UXTEtnHF/dmz0CioglPnlm0UoyzKX4RgfC5363h+lPzSyzHEcJ0i0rb5wV0q49
         +YEAE6Mxh0tuUWdG6XZSp1ouvgd0MuzbdLirhJimkwbYxy6FPrWmNWoNVx/MR961XZmV
         uFba6hk1auJ509AKl0/3Wk6PDrgDBp+JPxR1UiB5/KDj1rKulNMe+MrZ167TXQQD6dVM
         RehZ20bQv4QL0qkcOs7whbxZYeBbRHXdwVm6JFvMYi+5KG1vVJFXn43L1q5BUcFcw1X6
         COb65xdeTPXkTqxOs6q8u29TrILUElD8RjI++JY2PzClbwLC9oV7jRyb+dDoX8UBkL3S
         DtAg==
X-Forwarded-Encrypted: i=1; AHgh+RpHDPT1FwooxUm37XlgDWT3chfvQwKXfn63lRiMJbl0P7SsUeLvVIWqlISWnLOO5d79wOV++tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmsm3bKxgaKl4le3hk/9QBElBOpnjT7RE4dPvplkH/PmQ9NPke
	G1GY7XXNYLphC6FCwFKSuL5agApkwoDtpepAS6wGTMX2BVlwdUBqLYV0
X-Gm-Gg: AfdE7cmpQKqv033SpSFXW7R0agDSkrhd0jo6Ug5R1uFMEZxNWXrw7cov4YYHagcnXzN
	eiOV9dvjdwf8Y7IEm2CdgtX0aNJPoWWbbwV0/5WUhvqLctanw1L0nE/EEctXYlgzKwRQbdcDF2q
	+weUXe9LQmbr9/Af1BbKHneYBNQPGbGi+4hR0sw4T9jhOToTOiAkog1Zkk+4Ve10RVSlNiX2tK8
	epptYVTTZ/uEtJlJpE9MJiPeazgaJWovzqHT8kJMVQsFKi+OYsKKbRXw8COgNBYmHtqykvVozqU
	javPAvAkq+y+5qoctJNxr4XMt1yLg6COFQNNQSpwsLk/eN7ek2yDgaItrK7ANn+0NpWewp5ccyK
	GXr084cb49dz9ELQWwNxrWx2/5p0Cn5C/2kGqWzj+Hpua5tnZr9Cm5jIl91Ujq3+F84hYFDANHS
	1/XVIgoZi9r6ruJ0aI1QhjKAXVAQ1rbbGO3M01wbRRY6juIWPFbBTE1sqhF+H17Q==
X-Received: by 2002:a05:6000:46d0:b0:47e:5c6c:5129 with SMTP id ffacd0b85a97d-47e5c6c51b1mr270729f8f.27.1783605078517;
        Thu, 09 Jul 2026 06:51:18 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm51644657f8f.13.2026.07.09.06.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:51:17 -0700 (PDT)
Message-ID: <b885d245-bf13-45e3-8c60-28417a63fd91@gmail.com>
Date: Thu, 9 Jul 2026 15:51:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260703072822.817328079@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88F3F732073



On 7/3/2026 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, please backport 
7ee7f48413c42b90230de4a8e40898b757bc8e82 ("perf trace beauty fcntl: Fix 
build with older kernel headers") fo the MIPS build of "perf" to pass:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


