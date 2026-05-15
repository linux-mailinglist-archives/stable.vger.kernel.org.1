Return-Path: <stable+bounces-248947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBfqLKylB2rP/QIAu9opvQ
	(envelope-from <stable+bounces-248947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:01:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9605592C0
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B9530356E1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3B3F5BE0;
	Fri, 15 May 2026 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U8x8CkKf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF313F5BFB
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885955; cv=none; b=M+IzupH9/9dvEvIk5Rzl8oSoz9WGcc+3qrm8LqVblu4PLItqF750s93CxnbRjTnsS1dq5xNgwLYD0iqAzEEKrTBu5Lc1UQ94Ss6HxEwZcTRfpB7BPNX8Wp1x1955plCzzMASShh3oLUHSYYGA28ILqZNYKF4Y0Q20qvtiukFfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885955; c=relaxed/simple;
	bh=36OVz3yTyMZDLrx/hKQq/D46VISxeIE18gt4d5S+aWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFlJ0O0LZS1jyPWTvCi9GpR/8vdvewVzwxzctylUGAkW3/VG5G1ueJOQWOmnPVr9BfwtDieh+sYc1hgGLmxCyOS9lpog53J5X8IcW57bxz2Qv2HSwBD+/FD5eli1WWXBvsaDmYcWCMws+blHD4HKcalfAVhioYql/JBnBQObiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U8x8CkKf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso2270265e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778885951; x=1779490751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1Z7Gd507AlVs0q9KxG1L8hCgtq1/22hFcI6QXLL81s=;
        b=U8x8CkKfSf31D3sbnjOsJeokV9e6e4rYXHg6WHB3+64K6RgbehU4+hM2ijzoLbD0nY
         DInEYbyX7B6aHWqCZQoZ29cCHxr8A494m12nG/0jwT/NalqaB2AwWjQX0jgPioV64xCG
         DyiyK36LPLIx8YNL5WPjoI3uWpZfAR9+irlkaB9GwYvsBotFglmGJtHdjwMMuF5qn1rJ
         RActBQbJ9dkb5WUZsPrJ2pT6Tx0JQsWAckB5X/LDFuNLm+p/jXDJiS5JNjDYl3o3GHyI
         St7fWqJdo/oEzsXv2jQfTPBQqhcvhSQKkbOjiiF81Myjp/daJ48pLbpQfecDOdD6+def
         3yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885951; x=1779490751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1Z7Gd507AlVs0q9KxG1L8hCgtq1/22hFcI6QXLL81s=;
        b=T/ERluLqndn1/dJB33px7UH1HwuTwxAp08xp7pjcORXTRc3kA1A6iDfqDOaqayTXjm
         SE5dq4jVx1WUNEYnJkbASylrTEIOIt+35zxhELvkQ3ir8ezYWiU2QwBplIZs5rDKcTLi
         crMP6payFGjyk6K0YSXSzwLfxy77CDagK3VpENg4WB1IJxh9XpwDR8+eEJs4Sjt5DTjx
         05f0h7ElnLBX3okANWTl+GttukCgBfRlsP3lIKD25BWs+YeE8bFskLRKINHWnU3Xm4vW
         CWziVn8ik6g+D9HFNbm7R3WY8gSjlrKkn2Du35xiJgvJgB4TugSl6dPAOyUPRBj6mreG
         Tqig==
X-Forwarded-Encrypted: i=1; AFNElJ/owUVIJ2G00cv41eLyynXWegzjddBKkTnaNLpTdrRfOQBmTrn6y4Tp/l9aFcA7nZBn13FIjEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9LM/+Z9pVlUHv82+jOnA4u/QDEort7kZ4QibCJlm6eKJs+33
	5f32UylOPU+7pG+E1QW5fU9DEswSy86EPtLI8LZwTA23bw7Gxlnriz0=
X-Gm-Gg: Acq92OEhTtZ9rDj4Je/MFWYO5XwXnIVMKM9j7diMlpf4r3R7KQlAE0siW/bfWVjBSMr
	nuwXtAiozbobDgbqUcce/yaseyy64isS5yPHFMLs5I2fbgwC33mPXmppO45rrSKdNJrtqOD89Hz
	fsHUlyYbbInwJhRrMv5zvXhOwVWsmdIFCaV3LIkSSEF84SEwMGrxpC6LkOI8lDoxaNxSUp4bOKf
	6wRZfc2dnjl6s6oMmzQvxhaUWiKcQ8sU/rf4Irb5mdrTc4IZIVeEfwg37J7LuEp4Eod5HJb6PQi
	fTvLe0exrPmR3L9fZEb9k+1bopDlfCsINdfm+zq7HAnarO4Ui31ScexRdS5nrZtlzxdRehQv6qy
	4DyHrGw4gWfIDhqmPoHFp/d/RIDCf1RVZP1VYLfQ9SYsQ35JxC1RBXHPY7rocG+WHels1d9wwtg
	9YZeazNF/V/zusXz3ehn+OXALuMaTkGBpnTvWV72SasR2PiRgi34ab4IbnY/MQn93aLWlzu8oya
	5E=
X-Received: by 2002:a05:600c:5ca:b0:48f:e6de:1cb9 with SMTP id 5b1f17b1804b1-48fe6de1dd2mr48916965e9.19.1778885951154;
        Fri, 15 May 2026 15:59:11 -0700 (PDT)
Received: from [192.168.1.3] (p5b057eb2.dip0.t-ipconnect.de. [91.5.126.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm90717535e9.14.2026.05.15.15.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:59:10 -0700 (PDT)
Message-ID: <a556e32f-c640-42e3-b951-fd0c1eda010a@googlemail.com>
Date: Sat, 16 May 2026 00:59:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260515154715.053014143@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F9605592C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248947-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Am 15.05.2026 um 17:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.140 release.
> There are 474 patches in this series, all will be posted as a response
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

