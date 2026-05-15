Return-Path: <stable+bounces-248945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD8dD0akB2rP/QIAu9opvQ
	(envelope-from <stable+bounces-248945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:55:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A355591E8
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43972302DA07
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894B63F39E5;
	Fri, 15 May 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWZcpkHy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55713016E9
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885295; cv=none; b=YN7VIeHQRjj4o8RQ82ntuYataihH/pf3lXevyGLU60rXZDtrI7/9syqIzGDNLW7UCvoRYVl45kkvYrML3sSKF4kD36K0x3aq5vIM2z1B/Bs+G8isumJouCoaBajb4nxZgqZ8T18Q57tO+K2zk32ql4oQPdRG9p8rQgcANHqL/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885295; c=relaxed/simple;
	bh=EdDOedeMerSNN3gY03WEabZ6oTdFxCDK0wm0Z+xbmoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBmz5zX8MzREINwtnz8JjSZorLXCYmn/LI1pB0xy7MzBg3mS1+ZDcR42llH8j+6HWNRnrwZMaBa3f3vpRfdOs/6lRrbx29dO+NjD/OBi21vA0WzRdnJF7Y1aP5p8E5PiSALx4kzCyD/56hgOm7YVmAL6la+axKyEpWrgw+qCNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWZcpkHy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dbe437b072so185134a34.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778885292; x=1779490092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqnzQByjyy1E+SKpYzIivj3iQcyds1Z9QBuuYKjzBLg=;
        b=ZWZcpkHyoRZ5D1a0X/fkIRgdqKHLjSidXpl0quJM2YlntHfd4xeoFDjefI9hAGLKY8
         GD8J0tM9BSR7lcDkeSZf1jztwUYB+HGsuMg9WVNxx15N8VHWCxKbAG1rdfiDd1Jrq6Kq
         3WtNY/vk8WQc1XsBHgStaUBvdr6kHtixJeIgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885292; x=1779490092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqnzQByjyy1E+SKpYzIivj3iQcyds1Z9QBuuYKjzBLg=;
        b=UjjQj8W+yJv//vy/h6i7END4dUtYEx74TgSz86aWutyPkoIz86/kHjLR/jGPEUssi3
         86HmiSZLbPSHPBbOIFFAap/zxQyTflee3MoUQGqQZUayl9OvH8ZZEK7k7U0Bw9siFLdY
         jJZXxVcOmVmV92M9zAEon7Hs4fR7SPl3fe0XojzPzXgn+bKV/RDMWp00Ra2OGqZvYKmH
         QJCHrRjuO/9t+wQkrk0KOZswku9PVYnBJaNGwM8VNWjcl35ZN44Zf7t6+n3obm69iKGb
         coe1XICaAAhmuGDw7oHB3I/0bRnvfwEdLKD3HMHuGa1/p7QNlXZcM/arXA5osBmbXqOB
         W/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+kdG2F4BaUfHDMc7ZhewJ4YLDyatszu3jpfdvvIadyYkLWRx2sdXGnwxv6mPEyHJzM6uNW9uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnRca3mlh+FH1AlJ5Nx4yfRUo1PocyDgVSDA62b/vVOYU16gX
	CiiTF7xgNxpbgHB0gI4JZJJt2TafNTg3l6h//DnALM8pFXddZ/hUEBVqiE/xE1C+Z9o=
X-Gm-Gg: Acq92OH/OdEb/MrWqhvCyLb0RRAP1S6gdQKZScjhMeB8Rg2tcxMaLM/9IziOYOOfheZ
	wjBYFoGAZhjX7T1osSPmKbRmAjYPa8LrYwYMp3n7YHBPHNxFOlr1FdbM9vPJkBJrR7z9hFOyex+
	d0FTiBVD3XrJcezm/MC5Bxh63ZAAb02+Jat2XwWKB8RatPHvkQymCPM5dq2dWvCB/8JKVPNivAg
	Z88qoZRWcks58jjj6dkRjjAH6tiMdyGX6GOSzQ+2wkT0BjJtj/qaQTby2FriRQY+eoGXLEGwNC4
	uaHiE9naU16f3TtlTbRExefnCIwvIfvLplFizbOgTuUNCVztRcvs02I0bQrGyCHdy6r0X3PY6vF
	NU8tXeVvb4T64SnrDVBkCc2gJYdOrWn/V0eyoLkgRKP1mDjmgd3WQgiWGEeUA739RA52F43Ycub
	k4J6lQ8wjbUUiNocczhhyUmrDypIqW+ew=
X-Received: by 2002:a05:6830:6604:b0:7d8:b269:e99b with SMTP id 46e09a7af769-7e4f2b8074dmr4018861a34.17.1778885291688;
        Fri, 15 May 2026 15:48:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd10aesm2277398a34.18.2026.05.15.15.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:48:11 -0700 (PDT)
Message-ID: <6f2ad9ee-b8b3-44cd-ab42-7cbd03c2fd0a@linuxfoundation.org>
Date: Fri, 15 May 2026 16:48:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/144] 6.12.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96A355591E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248945-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On 5/15/26 09:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.90 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.90-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

