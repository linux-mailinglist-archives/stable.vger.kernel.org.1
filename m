Return-Path: <stable+bounces-266889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hjWYMsvxMmrJ7wUAu9opvQ
	(envelope-from <stable+bounces-266889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 21:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11369C189
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 21:13:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=UVvqif+M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266889-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266889-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 444DB30C3451
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 19:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224E30EF94;
	Wed, 17 Jun 2026 19:13:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD232F7F1B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:13:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723593; cv=none; b=JmWjlB09EA81KXm0OcYMiwOVHCIC1ucy/J+pmXhCR30yo3Kq33Jpy2c5Q5czxLNrXzTYPZDqaWv/ZXsoKwH4jgM4redTQiNwNDCVBv3Z2RscxNQVzh3U8JgYk6AcFiBJqMakVbsBjtkPZQ158lh+CY5czmYReMRynKwmMr04NJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723593; c=relaxed/simple;
	bh=i8GXMSjylUaWXKf02swF+ynx80wZdyqOokLNVj9JO40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpaUFPSO841T2g5U3tOLa1OIbxaKw5EjBzpCrJh/L5iC60mhZq8YKrYpBpZ2j75OoP27KQEaQb4XDn0eSGth1REBg8XEKvkklloi1LtUkR9BhP0oNECIm6KFo3DKYCFyHppLWjZjmcNKjCrWzK/PYMWZAeNjQwbPPHbVc8hiPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UVvqif+M; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so135248f8f.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1781723590; x=1782328390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXeVI15trGjKaAMq8Wwad56zwjREDswHIOyfK4vs9EQ=;
        b=UVvqif+M9q8f8jKySzc8l3RVp1bTa0GM2C8Ut6ZlnWg6etGD/N7M+ntfgTC1ZIWnyy
         XdH5fyKaIo6NGTMqoa6H0RddOa9xecuD6A7oxLhfRTSS1Jbnu0FpbruJT+Fn07+UpruW
         CYRZMkFIpFs/N+PJOmCNWebTuA4aHvNYc+R3q19zMH+SAoEM3mWvTM1R9fRCQ592KByT
         GuWtprHTZV/7YJYDi2l/l6wxEL18h4jR+hSsb8Hm/VSpYgM76Z0lsXJYxUAvKk3q71Ji
         BSqy8T9Jvl4nMbDCkVU+kVt6AE/enSkPl2n7QFJpZC1of6kAYBYnngpYlFuc/zfMI61y
         tUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723590; x=1782328390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXeVI15trGjKaAMq8Wwad56zwjREDswHIOyfK4vs9EQ=;
        b=MZY/wqibPM2cwB+d78Mf1EywFHGMp9AXobqCDeQ7CNamLHkqWf6J2UADu/OuORpvFT
         oKw5V2xBPYEqUqpB6X7VHHvKOYCKAwoelFc/ai8xKcCCPMXr/V5OgoV2lNJcPWftQMQU
         8f8OeBH7GKPZ8fB0YqINWeWaBKz27ZS+wAl8RlvmtLyehb+18h9sW8EmpvVg0upuWMbJ
         q8WInC3NaaGIEonQhPP8Mm5wFmkoaNnVjqsA/WY9WW45j2ZtRQT32nG9kGepnkQPtb72
         UYnJ1jnIXUa3YeB2CTlDO9JVEDRYq3H+b4saT+eT8b1scakVH7xt/wwGr6MZhPobqv2+
         PXZg==
X-Forwarded-Encrypted: i=1; AFNElJ9Mi0nmDPCAQEv35zvmZaNi0C+zjG8vX6/keJaem8VHHtuL60ajIEghaZRlbydFIl2B1TKlrAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwAe+JMFN8qLMUzCrV6Oj411fUh15Za38P2zOT0fAE7zixgf0
	gF5pN/HVtBr/Wjl/yNBEGEAkYMdSPrgjwYLdJ7eAlQuJs1FC33/xeYI=
X-Gm-Gg: AfdE7cn4L1rD0567DJu0vU+8H3E1+TXrHRKlE8IbyRBShmPJA4U2OHtQ18JE+9wY8ex
	am9CFO4V1m05L3gLovl7Fnib+FJPbArToMoY/3F4rTlvbDQVt7kT1oUhLsESpw9HWcgci84P0i1
	WIUJQolMocRX2ruQFLK397qsecMCo90MzLvuUavmS3xPrX/GKcPxgPV4nJXv80tBZHsYHKnHzQf
	ddvB+Qs3+Cw3zD1w5fj7fuks6NGrQfz0IxH+3oLwL6NeugJ6CxghzO1TvfX7CewMiZamij4aA2U
	n06LSgDyuaD5m1x0MR41EYmlRcirdKO8nmxQzVkk3ejSB5NE/NO7pMzO8SToTKfV3PkpCQD+aSX
	fdExu0Dzh45lWqCpIcG4DqbO4/GfwC7vsk0m1Nz6/nFA3z05b1pZTMSb3/c2OSlQYuKiwfFt0+3
	EMGNWvuFk88mcVm6TcmvcgrRjic24wCD4g+RC5QvDvWeycIbv3X9AIDEOF/gBj9KFg
X-Received: by 2002:a05:6000:2893:b0:45e:a314:ce0c with SMTP id ffacd0b85a97d-463ab70242amr775312f8f.1.1781723590301;
        Wed, 17 Jun 2026 12:13:10 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4777.dip0.t-ipconnect.de. [91.43.71.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm53454982f8f.31.2026.06.17.12.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 12:13:09 -0700 (PDT)
Message-ID: <f33dcd2f-787d-4705-9272-394e1d560ae0@googlemail.com>
Date: Wed, 17 Jun 2026 21:13:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260616145109.744539446@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TAGGED_FROM(0.00)[bounces-266889-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E11369C189

Am 16.06.2026 um 16:53 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.13 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

