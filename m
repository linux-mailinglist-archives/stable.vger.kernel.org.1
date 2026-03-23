Return-Path: <stable+bounces-230021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMFcE0i7wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:14:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0B2FE23E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EF5A3027BA8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BF382F0B;
	Mon, 23 Mar 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LzkEt0N4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8098382F0E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304068; cv=none; b=Zdo4AhFOcnUhUBJAnp5QFKNEhdZmR5nyH4HnEwlWVuMV3nri8TGR+KGF40nsjJDX1d5nYcTZAKwLAv+zNfBFn1dk4BRJt9bFvdyfZPVAgERrR6chGWLI8P2ljyIlBN5o5cl3vjPmlSanyavEfesDoMreUkUI2RlYUJxRvUEHGiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304068; c=relaxed/simple;
	bh=u45GD6ljkZzzO+s25gIyu9x9FXNK40ZR6rWB92rZkB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzTMfsf3ExoN2oLP11RyLbNcrmyL7EHOltvT0x6mRTdehsewrBf/cHjTaBXUphiEJCQe+g1v+ZkNqSEPG73ue+/4dkFT1qlof7TYxCjGYUkJo/CddeBZXz27W18IdGervlKHZF4HazXphxm66z5RjKi8FCnHj1DIfnl4jN1Cm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LzkEt0N4; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f387a688dso3621993fac.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774304065; x=1774908865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChdMT4MylejAuCZm+2amkaY9v69TqoANZkATUoAewQc=;
        b=LzkEt0N46KLDnXeC9PZzb0hmwG9htWL454MLpkUBkElp96mWO5dFQwxhOYWj5cXnQh
         BJuLizKyWKIlpzljq9AP5P3hziqMAHX0QdJJtVYt7UoFcJ2X6Ws6gbX053lCo9woWQ6p
         YoF/zb+twQez2Ru9CfK3CIaWq1Jpwvfq73dE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304065; x=1774908865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChdMT4MylejAuCZm+2amkaY9v69TqoANZkATUoAewQc=;
        b=fFWewhHYxV+S2MD6j11FfgjPSf8i94mOd5CRqT/TVarFOPA9zTBDuT7MKCyFZScjGO
         2Yv1VG+n2wTpwr3cyf/5CnigpGPeoc3ecW6bT2CtFBskKUtnmbT3gdLePi/5BthWpxSS
         ZZtIQy2oAPVVgx3tu85wkJCff2ST/QFMaA7np+8/iqPu93aaawG5GBQPVExQa/Qq21FV
         L7dM7c/wRFdNKhM1gEj+GWJwq6SU1OYinPaiUe1cPPf5zJcMBd/1h4BwChwZMgfcHjVK
         ijRlYuUl6fIph8EiwbRAAEJELHeghxYUGgsVhN7Z57JfOgxL+tNWZpUDFnL2Kvsn7rG6
         YTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXZNpShPdgBHaW3rXdDxdjVr5CBWc6ef5Wqf/P/nVBzhdOjCyH9II4A2OmD5cSwzQI0C+lzfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpX9Ii1ZO1dVOlJ77Y0TveEUSr0wKSwQMjo4iV3ndSXCj7XpGA
	pFMw8x4OsordlsRrh12s4lh8I7aWJr6yjK5gpzpXdWetZLHHw6OaHqUnOpwqetZvtCY=
X-Gm-Gg: ATEYQzyNQtSXjJjUfV8XSq3mkHsq/5+2n7jixRQjemKh8a5LDQaEGhi/3Yvwt8EDUV6
	4/Gm9DQ+1E0QFKf7TFRFV0+iFtPyzHlV6NNfl7vHPSE7vGtOBo5n8djU9AuqDxzVy0L0Tod/U3Q
	vKSgiXLm/P/u1Z3ouWI6WoxKODHVGmdGXiYlkwoyBPZlZ6toB+7TJ70SHXWUpY6ijJMq5P4rUTL
	LYv4gvz0J2e+ns/apvNSMs52iLZVR0EtLrYXgKVVtlYhQtCzRTQEN+Pi73yYSmosLC1g4Z4xYJ9
	7w3BoNtwOTTyPNrrm3tVQhU9Zm3ct3grVBTkSdjtS+wU/8JUkFGEDl/1OvIr4pERB4Ha44koY0X
	Ejc9N0PKAOFk4NmD8WWLi84udv5hyt1ajh2Q9/6/YPqlYMoScVUluqpU8bpeZDYRv9Cqe8rw/2q
	3Q4sPnRvkMxK79STTo2WsSw1DMJAUDVHUhuxbdwgsH/29SOA==
X-Received: by 2002:a05:6870:b52b:b0:3d9:2fe2:f5c8 with SMTP id 586e51a60fabf-41c11227833mr8798048fac.32.1774304064791;
        Mon, 23 Mar 2026 15:14:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbcb3sm11505467fac.14.2026.03.23.15.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:14:24 -0700 (PDT)
Message-ID: <959e0530-4991-4d4a-8b65-3ce0b7f6ff86@linuxfoundation.org>
Date: Mon, 23 Mar 2026 16:14:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/481] 6.1.167-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230021-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EFC0B2FE23E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 07:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.167 release.
> There are 481 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.167-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

