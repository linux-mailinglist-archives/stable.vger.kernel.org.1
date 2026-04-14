Return-Path: <stable+bounces-237944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EwsO0Z+3mm/EwAAu9opvQ
	(envelope-from <stable+bounces-237944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:49:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD983FD45C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A20306B096
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DA3F0A92;
	Tue, 14 Apr 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C9GA/Rt8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA272D8DB5
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188617; cv=none; b=J3t6ld9kc+aVwB2H1qPUmeXOhek0RkJD3OzsnGmjKi71QB2Aut/fmYaWE1DCvvV3xHplDnqLkXUY3eLOShbX3eCKiDHsoJ/MyxLa6naq0WapzRaGBArLo+KAeI/0iDx/OZmMfN+gx0JMoISwZ+30Oa9z5YMrCFOO6Kl+DA11UbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188617; c=relaxed/simple;
	bh=l5bn1W/u+cU4A3aF1wl8yVgEDNPAMCw4MG1lEQEWRVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYYI5JJWrwwyYddQb45MhrUKDXQm/rpvCHmFIQWN824IG5Sf9BbL3PJkn7kmRmvrrHV8NvOkGHEWOwokhD3vdQhWxhvGE97p2wU958RwOxvcdiRhhBNaiuWM0Elj1q2aXCGSsBspXFmPLj8KOKpV/bjGA+i2l3M/1BsdfI3FSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C9GA/Rt8; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4152698e745so2256222fac.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776188613; x=1776793413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBTnl1lp5ZydNmagsRng1mXgZMebui5mKrZOOiOEtIo=;
        b=C9GA/Rt8s2OPtkWAJWT46mlXMZMAisimIhpLLBKvRU6tb7Zx+FZjblrSGjPYIxJU4Z
         8Y71BvtMmCp9nZWqOwsTLjnsZHZSohkX1AtWc3j2Yw5DTZeuaBUurZLgNiiOz33Yezj2
         mLoTSLeb8J887SRmsuNScr3rU0KbthSsCDmEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188613; x=1776793413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBTnl1lp5ZydNmagsRng1mXgZMebui5mKrZOOiOEtIo=;
        b=gIByE9RkKg6B6by3PgRqR2JCcf/ghU62RuTyKqvixKn+w0lFIxPXqKiqR+Qhqq0QeD
         8VgdOHaxQ1ZoA/EZQfAz03VnjbQcOtrh6olNnXx+6J5TWzNaN7apn6l4hDO3ZNhnWWDA
         hTWVcwr84HNh3rBQgJta6GXWJpkMScUGxUIvQVziaS2cq5ajQ00IZM4auli1CqZeaZ/x
         8UDZyUSmiUbeKXzaYwzC01ZNTDuZhWfp60D6yHWuF1w1JXBwoDMSYiOBRqU0kMnVIMC/
         EiyPB+YwUMZlp3Pg2ixJmd3X4F+HiW3oPWU18nCs7SyAAl9QbFtZID3LuhXtQDeHoP20
         CtDw==
X-Forwarded-Encrypted: i=1; AFNElJ/fsJJ7xUF6+mP8QSJ22PvPawQDr5uDi8CQ56hh/mt+OShlos5AS4QA99xcFkTpNtIb+Qa8IcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutQ82X/ptINJUKxnlnnCJUAuqe4RjjUivH1v7o9+NBghj//f7
	Kmf0oJ984FQXL635/Gp2pTzLlNPlOIagD3g/IBksrkKP1I/u/VVrOg+gQxey1Gi+MiA/S6QHYg+
	xB0FTDEU=
X-Gm-Gg: AeBDieuy4CbuYtm5/Yk1oafWqo/YKA7qV4eGuspIDJdFcpzPNV+RzxIdOdootkmTXsb
	FR/7Q3PjXhiYcjpt5A/ODsXsW67D1wUPCM1vVPr1kO7KJNPqeXPqgqTS8rvY7MXF56kdejxS0fs
	jFoJpuLzCyKviHJS3+UEm/sl2BjDhy5COdQMw6HHbvfiCgpoLsqX2m/aiMdZqIVB66H8OSpeUcU
	4n9BXmcXUFXOkF3Jo5a2InVtCCfcoqWOhgfYJTmDbPzUSy00P9mQP2wK1//yZZr1UZRYTVfb89Q
	F45W9Vn+nlO9TzubXoSEc4dC99URVteRJrQWg0x0IZbf2r+Bdc0faQ0KJYNmJNP8z3n84aQ8UK7
	i3pFrY5W7k6WHIWIXyLtVEtC3ilq4dbvv/xDsPUoANaaX48+9MImpzN02+WiTzjlOLopi70EOP0
	S7w9Rr4M8U0HKrSOsiDeigh6QIOflI5BI=
X-Received: by 2002:a05:6820:1986:b0:68c:1689:697d with SMTP id 006d021491bc7-68c16896cecmr9301885eaf.42.1776188613389;
        Tue, 14 Apr 2026 10:43:33 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb23a9asm11674765fac.10.2026.04.14.10.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:43:32 -0700 (PDT)
Message-ID: <0ddad656-6cd6-4566-ae58-204471a9f7dd@linuxfoundation.org>
Date: Tue, 14 Apr 2026 11:43:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/50] 6.6.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-237944-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FD983FD45C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 10:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.135 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.135-rc1.gz
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

