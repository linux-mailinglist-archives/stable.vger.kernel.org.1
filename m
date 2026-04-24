Return-Path: <stable+bounces-241069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE5cOo3v62mnTAAAu9opvQ
	(envelope-from <stable+bounces-241069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:32:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F44463D27
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38DFC3013D45
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC93341ADD;
	Fri, 24 Apr 2026 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBgd8kUw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227B23B62B
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069948; cv=none; b=J1mj6MwMwm60EWNmLFEN/Nj5P4cd7gbCpop9vPCQiQIBCX4pnihwJLBFuQu3MTiGIMi0PMjJTWmXgaf/1YaM7Gerh8CiQz2xnVpS42QVtz62DixYdZyF2F0+53MzRmYFOG8pj1pAzScRylLZs/lQeSpdxNXdjpkMwJznuKhbTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069948; c=relaxed/simple;
	bh=XiYgjWVSSmvsu9T2rXFWc7XJ7DDFJtdxFEBscoZ6/RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvMkL+QKcWc4JqEnpCeeoajmzL66GkFicDBtbzDmKqNhDTArKEcL/9vnf2k1s/vkvIHffdj28rJUMH/1by72uv64czXsqzocKiGwV92OY6jbWM5xGqAImx/UhHdo5yPwkVPZf21ikCyTfZ8umH3kYQMoj+PtG4ORA9slOmXfqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBgd8kUw; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69489b43d66so2322608eaf.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777069945; x=1777674745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d63IHBcUO19TdA2d3EB3lF2F+u+MqqfFJL5ktUx7u18=;
        b=GBgd8kUwSHDyGHgDVTKYwU0P+ujgFYKsomAUJluDVYKT7VTl/B2xKdYKZB63naKPP6
         PW5pMzy0rFRAtsBKmMYs5//DJRB1nneUiozwLbBf96G8qVzSgXPrvkab25KBvF2vm+vv
         TLz0trIUmzMNJhbgWN4eOZt7TFlCqnWbf7zSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069945; x=1777674745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d63IHBcUO19TdA2d3EB3lF2F+u+MqqfFJL5ktUx7u18=;
        b=XFNQcJjPPxrnQDIa6teKP44ESi0dY3UcoR7xazgNWJ2Jdae3o2G4hWENdjDuVIZxlx
         YLtwt111co3RqP7pUrBoJQfteORBik6WFkhz5hautbL55BPm0VhJQkJLkxAXluB6zIyE
         /pRSyo/ZVUKoeldZRu3gBnK4xZNroj+RcE6tdEsQMWjyQuFwlrEh1Zi2CoX2PSa+05fQ
         O4ik0sZwhNO00lJcixyZ8cs0njmPEzU0O6a1nQLMjnfB8pjr992pNcU15Ratn4dPcVX6
         BdZdD0ak8lmXHw0rDBoS/rb2cA5qDuDZ4xSmQpdH4FBMQI/SG5U6q9H0y+wevFpfSMuX
         ajLw==
X-Forwarded-Encrypted: i=1; AFNElJ/XtGYUeYmq3YRwnZd0seO8yTCatp4IKrFoS4pO9DFzZKm22BgN/x8Fmr8c0L/SsrdLkD8pIo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49vNMm7/aUKQwJB5DfwtGyKG794xVPzCZSzqrQiIw3R7Ui6XZ
	k2WOEELCuznc/cWc4GOFJfLgkUAH4i0kTfv3cePvDcFMWjflSD2OL1pDMR1dk9EnVXw=
X-Gm-Gg: AeBDiesL10tQKfZsrIk4fDb4jmd9vAHOhB5qeYV/bBHCQDVzsrVT3v/f+hVAEPUggmt
	F9TpM8gu46Q6WK2AJ8ugNHDMCoqKQWAH1V/MX2y2BEtcGuIMJJrxntYnV5+Huim+sO+Mu/Lsw/a
	54umude1gE80XwSfNnaKuDuc/YQEAhG+whJwu1/dmQ9fwkZ9SNx3CiZgglOO/JPI5dIKJjydXGt
	0C64teEtgQdEqIoxVveLPZbHzdoiYM4bV/JgLi4bFOPsB6kVkYmxVti7k2Udnt87TCyWBucQKAB
	rgemKwaLpe146eru6MppT9nIZjVdMO1ruwDrIs3NYZibA+LdrO5WvgeKA7ZUPKYuamJPuDRvh52
	vKkh0+/BJSbc9uqqXefSXkRvZ1nPHTiJ1GWO6KzstLMUGv9Efu2fG2S6q1I+gThVrm/kL174vOk
	YA3gUAW0CS2ZhqOSSwN1jIzB9Fe0RxiN+4boqQLyqwUhI1+mQ25uoS
X-Received: by 2002:a05:6820:4df8:b0:694:984c:1a7a with SMTP id 006d021491bc7-694984c1e67mr11447714eaf.10.1777069944845;
        Fri, 24 Apr 2026 15:32:24 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6949eb69302sm7045615eaf.5.2026.04.24.15.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:32:24 -0700 (PDT)
Message-ID: <35bb259b-b74b-4c57-8a04-592b71d5fd28@linuxfoundation.org>
Date: Fri, 24 Apr 2026 16:32:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 64F44463D27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-241069-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/24/26 07:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.136 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

