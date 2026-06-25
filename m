Return-Path: <stable+bounces-268550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iT7gEdQwPWrqyggAu9opvQ
	(envelope-from <stable+bounces-268550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:44:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C66C63B5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:44:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VrPnra4R;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268550-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268550-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64043303FAD4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B4F33F8A6;
	Thu, 25 Jun 2026 13:44:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D0342CB2
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:44:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395067; cv=none; b=ppbZs/Md9nDswPR3n0Na9P7iZBtkNWeLIn+tBH1/6+TIvCbiQmCsxfDcB1GrHvcylzvKt3GjCdfDmTe5wnVr91etNBFyvsXVEsFl9ZlZr2FeyCVD9lzhPX0zP/JHG9OQa+GvxVcuMChq4z9ExmyCHCz5WEIo2OIEs5dRVAv6i/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395067; c=relaxed/simple;
	bh=O7q8146JQm/YlUoowWVTcwGJhw9So7vgvY8LErSP3pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVJ0L3SYLPNN30NEcjboeIJc21pfQxxql/fMcatjOg2AU6+w6LfZUntGDnLKYNMNiJ9AEybhSfuH+I/yn37GsG0kQZUetsxyo/f0AMZ6JMOHJ7QMLzPYxJRXmAnwnaofjbiqQmlXNjgMb7mInz7wR/09Ss46t7P6x6D5pPXqU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrPnra4R; arc=none smtp.client-ip=209.85.167.180
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48751bd4abeso1277696b6e.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782395066; x=1782999866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsZQ8NEzSIJcyszQacza8u1NaEbFRoBwhUpRkv25OjE=;
        b=VrPnra4R4g3nNrBT0fgq0FgSQdFf2RKsEqy9R2VZfC+bVoyq6i42oa02z8CT8ZtKoF
         ksdJrtVujCEuXjWxQCywa2B9fvDgSzK3Ff9QZ+L2sDZVNesquIItQf2+Jl8j0umiA3cc
         flmbwvvq5h+whfY7V7CuMiBbpw9kWs1zr3CUiGfhD3yN0dzr2VGXGPvFHTFNxmbGe4C7
         aTXbhY2goVW6gB/IUCnL2ITvJT+94BlTBaVIIh2cyGnmRoxOYXNM5VA8/V6WBc8yISGI
         Kwx7fOBmRZIdU2xc0x3XyLgiXkxYykiXLVqe7gBy1WWgvLWk99SGyvILmS3dg77Ja7OG
         QPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395066; x=1782999866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsZQ8NEzSIJcyszQacza8u1NaEbFRoBwhUpRkv25OjE=;
        b=PmECTrgv0uESS3BL1DsuNGmH7BlaZr9Wtjl3YHCV3HxHDaMBePChfXgdtC69UjckQO
         9LNpv6UHL8aOr12JMoSjfs36BYnAxI42AUNkUTTRAe0A33PVTq3yYk18GydnhsDP+nWv
         NM/iW+petLzEmwc1rDk49UlOcl6OLChDYkednaYQbFl55BfiG7nlHQkRwjunjgNR5hR9
         fxdoKS/yu3Rg9F+DMrmB11LhTPogexcoCGseZnoQbQh5foiRUCrG5QyiuOPti1QPIg3U
         4dIaBsNXiGsYnkvKlE0W2T84bar6Bgvf5WjWTwlMSbY5BQUyewsGdiQMC28i1Jt+t4A+
         wTMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OhbTCNuno3H8u3muBxAjYtlOnscutpVWEA1qFjdyry4B8CzmreLA6SiNZjld/gWO3uILbJnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJI0oKmnQip20cJ6IjcDLN+RikuDhmUyUcgdE1Gowvo0p9CVr
	gqJDPkDKBZbAU8GhRwDxqv6sFQRYpevqzvhtIzxgO5CIgg8TqYups+ZHAWUh82z9
X-Gm-Gg: AfdE7ck2zkhxrwbg3vWwuU8XOpf+nmW/SK7Q6bK4uDJsD6vStc5cthV+rjvWHHVLe6C
	sHLkJ2B8xdElVggzEzIhVxv9tS0Ad5wHAiQB1tvqAEhfNolOUHPiY6hZKKpwA0RB6JpX3XG0Tme
	QuxyOR0psdPbrQ6JF+YGD4QpvwuZsamv8A+/IRogBBaXyJ7cB4hIDcXN8EpjRuO6BwRs2mfmw8G
	KDOhgkOjlUgrKDcMpgHfNhryUhO63mmsjt/HsgaAyWfIsHxFvb+Ag0QG1SaXyKi8fulHowX45bz
	XN2KykVGfbkJ3eatNxFchYJiGJPiQIJdA4Xv0oaTqf2JAN8/wMHvAjzdLcqPqfs3M5xI0Aw9Qnf
	xEPxlzAqkZgoNrRjYMV341hnkDB9edaYj0827tWPpMZUTo2wOlfpkftyGwVEY1gBJg6lr5cuHB9
	HF+J1/fKobfLT8v1yaA9PHL1QRr2lkog==
X-Received: by 2002:a05:6808:4702:b0:491:efc4:1a33 with SMTP id 5614622812f47-49216e35940mr2607437b6e.3.1782395065712;
        Thu, 25 Jun 2026 06:44:25 -0700 (PDT)
Received: from [10.178.4.71] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944069d22sm13834919a34.10.2026.06.25.06.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 06:44:24 -0700 (PDT)
Message-ID: <11f22aa9-b353-419f-94f5-2a7bd70bb737@gmail.com>
Date: Thu, 25 Jun 2026 14:44:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260625125637.527552689@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268550-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2C66C63B5



On 6/25/2026 2:03 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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


