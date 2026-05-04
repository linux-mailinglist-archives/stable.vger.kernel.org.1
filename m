Return-Path: <stable+bounces-243918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHMtMHUM+Wks4wIAu9opvQ
	(envelope-from <stable+bounces-243918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:15:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E54C3EE1
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87908300BD4D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 21:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F79345CDC;
	Mon,  4 May 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Daz3v3kM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F1344D8E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929319; cv=none; b=ufCw5RQNerOa/EECEhLjAlU1Kp/63NzhRgnT3OITyX7bD6tDNarhzlVIjo0+MvJg5InU980yRGH4oJlmcKk14fU+4Z8wLfJ8Qhlegfo2sz80K6ilJBug+pnoTesqa74VBmj6rWRnwWXxQgakEQAL/JYSA22bokfHczfEIki+11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929319; c=relaxed/simple;
	bh=ZcwHhiQBeuto3+aHd1WgPtJBNLW6SzFA30xH3EUIueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJI6yM4J9bUcWukAnwuoMLFqxqym8jHrQyjtr1NvwHeZEe3wYYbGJH23OZC0kCt0nsAEjHf3uL28vSbA4p8Rd7t+KCt/KrLeS82h6wc7Th7J0yQN78z2rrW9XEYFCfq6r81JbOd1xjyNIkVwdtB07g/dZa5eumgni7d02oBlzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Daz3v3kM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4910295eec.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777929316; x=1778534116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6M6O6vS5rinWV9bCog50NLyMYBW362x5+Rc5/13V6w=;
        b=Daz3v3kMJQ80Iwc4CSJ97RH+eFdm7AVSigI1gGlE7ojUjvQmiCEY9Bl5xZ0I9GYFZO
         YURR0At5/TQC+7KjqRQHdEh2LfFztVWACd8V30To+gx2G/crHuzce0SPVBfg0CJgJwiH
         l86soDXp6COWBeojTTTceTAuInnOkOJXgD6qNgFHvPqh4slXrmKo1VUZiJ/wftiOE2Dh
         kYl0p7k/+ws4Rr+FVBr9/jD/m8ZkyawvCVfRKTwTbC2SonygQG05BUc6FFImnVFcbEqH
         xWXZhiGUZIZlTmpaD8yhlrUQg4bZi1VlT7NUOfZzVZlB7sDzpj8V8rxFWHU23uubpLQM
         o8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929316; x=1778534116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6M6O6vS5rinWV9bCog50NLyMYBW362x5+Rc5/13V6w=;
        b=J89OZ+AIxc1SOZIh9UZOH/mr2H8HyoP3uSuZwyJoRg22KDbh/+fBHLCoyzLkWxNOb7
         llajNfrxTfO4M2Is+n4Oh0a8ikbDLKFCVo8BTCcAhoeHlKY7PghWujc1KhYXYnVJ0cPA
         KglVIDcyqL8O6JfVpPO9qtA0YGIFKU6JnUvMnyYz7cFpECiFZXH/EKcUQZmifyfjPuUI
         k/sY9QYoSXzb0Iq6ZcGid68g4hXEmVOOswKKRpzYd5fidwO+cwAUc52/Je++kTyfcUP7
         yQS+2jG6eZml/wXaQMOWKg3tg2eZ+pFOAbdANRkgw7+VHmoqrRGVZ+sP9hFjIM8ewjxn
         KuIw==
X-Forwarded-Encrypted: i=1; AFNElJ96esTghxqTBr8KqMohu4FDtMJwnosyrIMubl7ftkg25ymtzMK36Q/0+ujm/7gCqpxOykggYRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOvTK9eMdpT/G+K4UujNGldaiX9xs30UjQK86mi/CZ9cRPKl2
	2oYhck5lNQiZ4kD4UQ+87lIHY581arAMOnv2xiJb2FuerxYsh4Rh5c8i
X-Gm-Gg: AeBDieuMnYxlf1UHOF8tYMW2MJhDryCHDDmvkme//Ic+SFP+0wHAFmei4GfXWXO4fnX
	mkyT4QzCjbWdtd2AJjRTrcxFciwsZ+Cz9F9Jd6xRsIpa6EMcomkA2Z/nLAO6X9zqU7Avb/72jN1
	mJyZ494s9Xd8k2NAMzcjNy+aReupKFOhRmpes1cIbbz/uMBBLIgVQtK0uG6Q9YU0eagsMcwMYHZ
	utWs18d7JS8u3ic/PmKqGWTVSgBLTVeAOn/z2SBIT7tRx2RF25S8AwEQMQIJSeNZGObq80PLnfb
	J3cAFYIRjzgBDrL/EHXd9PUXisnJkBSqd7IzDSJf8/DMrKvdfcGJoeTRT873d5yLsYOwpUoXGz2
	SF2FuAh4fsVAHopi4+4KYyRWiV/6Q7hNarq3+v6PzrBFrE2ijgpZHx1eusWMmZ8xZOH0F8z8XYP
	+OStFQNqO44hvBzs8I6JlyS1rSi0apdvMFvFk3yhmIDfup8IChCTRMhdQyYDIQ1VkG13Cs1u4=
X-Received: by 2002:a05:7300:7fa2:b0:2ed:e14:7f58 with SMTP id 5a478bee46e88-2efba7ab309mr5110790eec.34.1777929315837;
        Mon, 04 May 2026 14:15:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71bccsm16830760eec.11.2026.05.04.14.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 14:15:15 -0700 (PDT)
Message-ID: <a0173ef4-c77d-4d25-9f51-b232cf75bf54@gmail.com>
Date: Mon, 4 May 2026 14:15:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/275] 6.18.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260504135142.929052779@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C00E54C3EE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243918-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 5/4/26 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.27 release.
> There are 275 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 May 2026 13:50:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

