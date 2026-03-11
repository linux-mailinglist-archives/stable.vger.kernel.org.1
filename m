Return-Path: <stable+bounces-224760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEgBEvPWsWnVFgAAu9opvQ
	(envelope-from <stable+bounces-224760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:56:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A086B26A302
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF2C3031CD7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48D346E60;
	Wed, 11 Mar 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FiCRkCKq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4A2DA759
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262576; cv=none; b=Hq0tNuri7ujsflXAYWsmnfqJlT6DWZU1QEKYD7Dkk1FNf6bYN87Kl2+iItIDY7Qt11lsp1hZaltbE7K5mvxmw17EWaTXpYKXiZzOVnrioVCByYRUG2rFKcbjbZfvpwbUbvG9MhntMuHiHasNzHGXE8ow0FqK85AJ5WORxr7qKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262576; c=relaxed/simple;
	bh=WGMNQ69br1zaLeyPFa7fZl2ve9t0B2t356Z8FghtmnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3v23NRnyMDpleccALe290lVPLvpSxxi8zJUb+OIwC8m7sWnL9/9Kk3kBe8LZIpY7UIgdi0yPJNbWXEtfziywuNEPmOeIP9+kabABi36+y77Mv017UvOZvJlWp99vTZVankV2uiKf5CWfLcFKt/xWqwM1bfS7Y7wP0RbSXhfRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FiCRkCKq; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-417400afaeeso1143731fac.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773262574; x=1773867374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCmGm57by25NFaSpQsx1PArbJoD15y/mE7q9SJzUR8c=;
        b=FiCRkCKqvDDo+3rR4kFF+htJNEV/bOqlZ0YppsiVaewP121fHyxTRUo/hhNuN1wwTI
         mwHmz+Y6XHYGMyECLCszOB/QVGkHv/wa4AMd2OgucLS20J6HuHGQeF7+xMntoLmaSWLc
         z+YGCgKq4NpZd33SdTMr6QrnqgPp5jjVnrZvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262574; x=1773867374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCmGm57by25NFaSpQsx1PArbJoD15y/mE7q9SJzUR8c=;
        b=NuJnKweNYiNAQGbEC44J9w5IpzGJ0u4qsIZ5bnPzt12bFqCZBc4W5+ZsXTXnDLHyip
         hARbgi8dFL9PPFSKrEUll8s9x8lcu1ORyUGECHH/HnUecHhpN76TPuMIX0jH/vVU0I0T
         e831QNed/ydTSzDFSRHemXLSDGLuDrlhX2nkXr/BDUJETq/tRGvEOYd6SbQdCGNMemS9
         yZ9kuUlNcL84GW/eYcFAlRHub+wwEe+sdKplSwgn/wyL11tFbjmHXWz+S7ZnOjntWDss
         P53FZVBWI3Amuy+EeMT7kwPnnFmHFVB9YJeNuCU3V8ncbbpCCgPuiUl++xXxr53MOU/r
         +8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRfoRsMgrovFTqG8Ugnzc+ZTeitc6pPUzUpgUlhVi6C1DGPV2yZ2Sy4vC9USeCpG9g7gSNva8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhf0pdkRrPQIAnu7MWEwWNmfqURsP+zcwYWzcQxVQy1RZ5Gqqk
	tjj6u31sPZ4jMAy6cNCA6exUheGy4xNpdy5dKPPhT1sygyzHtnS/eKCALnRsGIhKSCE=
X-Gm-Gg: ATEYQzyF6m1vnQYOI4BT5Y5P1+mIHsD9HeKuy0lPEt/0QXTbnVv0cDlJnMJaFjk7jiT
	zhvIztjUV4TZ5nI3q/ydrzBh/78rjQP19Rf+mOSzl7dQhQKD6lN7BflFusS16mJdkHGOhSYjQbm
	z+kj6+hYdedZON/H0RCx+HuykG0RjLx1vO4FnfI8a+ua8dWcU0XriwSWZ6bOihZeN0kmgMMndzN
	z7wvFsXqyTv2F9+G13BFX4et6EnCrxwtjH0Wew+FTH6ONBW+MTPW+aOGoK3ePLjIfLkrgkOhQW6
	3Me8S1Hu+bwQr8OGURNFDA348ha/IbTzWNOujb1Da45fbv74AlsyftlHkFFLPpHbJrm8OPw7/DV
	Xe2Wab3rozuVGE8W/Gy0BjS1Qw6RVLUdarRSFs8bu6d9QpmZLI9zVNgDdiaK4j+dmCv9Oo1v182
	DIXRjCMjjI79cXChC3Cb5v/kkHpDOdXI7lISg=
X-Received: by 2002:a05:6870:9d08:b0:408:7ed6:e0a0 with SMTP id 586e51a60fabf-41798ed18camr665776fac.9.1773262573916;
        Wed, 11 Mar 2026 13:56:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e2df1ddsm3297417fac.9.2026.03.11.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:56:13 -0700 (PDT)
Message-ID: <4ddc79fe-7944-4a59-88cd-4800bc2047d7@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:56:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1773140654.git.sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-224760-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A086B26A302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 05:05, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

