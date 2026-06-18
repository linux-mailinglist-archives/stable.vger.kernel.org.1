Return-Path: <stable+bounces-267116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0fcAB0TgM2pZHgYAu9opvQ
	(envelope-from <stable+bounces-267116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:10:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E98E69FF00
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 14:10:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FdRkwK9C;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267116-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267116-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB7B3067F08
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396B3F1AC5;
	Thu, 18 Jun 2026 12:07:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85232BF5C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:07:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784449; cv=none; b=t27td1ZP9mvGclBYtIQoPwBwn2FLeoeKVYIG/Q2amV/N2PubfFv57F0Oo09tiTJ4+OB/lqMOsXm4NvW0WOGVFSN6DIb6LenwEzJ2QfMfPD8zDS6lZs0McPi62JHbEG2P535sA7Cg6wltMVaQHlQeag6ZmmAk5yqlgtODfm2Ajac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784449; c=relaxed/simple;
	bh=rvUJtS+4F0/HkiQYZkn4KPT8KMj4ZyTWCGc1dug5DVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqvJFRexrX4K5glludWFtWL1EJriAzzjrZyh2jDtxsUo1a7w9t9Q+DOvTLbs7BPCfDuzxsK0hiCSPOJUT+2YeYckMdid+8JbEr4H9+ZeYrft5Y8DAT1qpKxgTCK8CJ9yuXgh2dfv+T53JDFn3obdMLN+Bg2oi0ZoxccOhRpOrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdRkwK9C; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c1915793so6682725e9.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781784447; x=1782389247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAFu3iieP1epU57dc1h0pgsCpphj+R9P3j26Urr6Nvk=;
        b=FdRkwK9CWg+IcwCXunKeexBh+9wT/hagtNvz0B5dvEjvxFqiGM0iEF3Mdw6ypcbXsg
         647gidMAmKVwJ4QyRqRZ5H7Jk4Ky4nsGfwI2eZTlofsxClH5+AhuBTEdb3jUXxFoxsfr
         Cnqsm5jhWb9gDe4PHFMn5eFCwludvBhZpoZgybzEP88lpihzNUvg/DYqtlHGWsOioGwj
         KjjWwEl3z9ExQavewagH7pt5XGC6CFsFgkrYyHxY7/tz5IW1enMMyOmGKaHL34y5TXOO
         O2N4wKfNw5Zo/tKT2bpQ7yz8RUCU4YJw0v3zUHmdjpR/l148ysQVgB1WoXZoA3/EWGBj
         ujFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781784447; x=1782389247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAFu3iieP1epU57dc1h0pgsCpphj+R9P3j26Urr6Nvk=;
        b=DSrnm1PEo9hc8f6tbNnNDvjKgMB0H+8zXixYMcVmsONH7CWGfdwpuODOCppDyvgVAS
         q29yAQSI6VOlYs/xIdH6Oo6I7HkRovsyxGYzCE/n1RxdAbbm+fqmMFOzPWMeMTSzb2TO
         zUn+pv1NCBFKqrBfxVDvzto41zCRyxApvUn9fVRFg5y0xiu2/35gkFYoWq7Wfg1TYN51
         mnVzr4IPlJDi47VRD1Ng2i2MVVmB3JPnMSN7qU9ysXDBeUAuSqAAafsdJuDck31f5tW1
         EXwidv6pf5rgQPQdO7a4yxCcHcnKIPxYooC7iFiYmHDkE+gLXyjZLnj5ZzMalLOkdU1U
         9LyA==
X-Forwarded-Encrypted: i=1; AFNElJ/USpdcoR9DRqv7ATl59W+c5iaiy4iPrrCEnlU4IY8ZUaH8ElSkmM0yJVDdnHnFo1PNE4O8x8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJTtQ+8YPPXnVSY3iY9QYK6Hq0sjDO602REJtgfXemE4VAf74
	MW9lTMenu+MNilAUZkKXA3gnxXWICxHOzJQB9VTYT2vTXgCa+4uU0/sv
X-Gm-Gg: AfdE7cn0M9pxPXgF0Ml9J2sFmhNJXtEuAZzfu5q/gRBdWvbrb6/qrv+cTPrl+K/6/oF
	R7/Ts3sj3/mvlLa7BjgoM8SCyHJuzu3AoqYLbzlPCeJzxKQADsgW3OY5ILMogRNO7tmPvI7PDAS
	GkQ/zo52yCZ0HGNuJt3zLpOLxBY78uxrTtfWFaCO7HN34NHwPjAPDHQ07ouz/6xSXNQfydZ+W55
	Gg440MnQ6Jdad9FUBMaOP6MORQe06NFpYnvFdpvG3YRt3NbmfHG7RgUeGu88ZsNAS0dpJ0I6ipR
	2D7OGqcyotjBBputZtfRKPmP+3cJsQmFDvCmVNwNjC/vWlYPBgZQwlTZv85Niu8r2JD5c/Qiy4z
	A/xoTuYIjoCcPnoZupgX+SYecSxHjmy8eZo/miKE/AgCo0ELh036+qe3/ACcPyquLsI/O4zK6ee
	BnlX7KtL3VE6SgQoXnRcenhDwaPE9dkA==
X-Received: by 2002:a05:600c:c178:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-49234100907mr131154445e9.1.1781784446971;
        Thu, 18 Jun 2026 05:07:26 -0700 (PDT)
Received: from [192.168.1.21] ([41.140.50.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47d1csm243843195e9.4.2026.06.18.05.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 05:07:25 -0700 (PDT)
Message-ID: <93a18d21-cc98-4dae-9433-a6a68d88d0ee@gmail.com>
Date: Thu, 18 Jun 2026 13:07:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260616145057.827196531@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267116-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E98E69FF00



On 6/16/2026 7:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.36 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENEIRC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


