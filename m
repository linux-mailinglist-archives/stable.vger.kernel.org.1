Return-Path: <stable+bounces-211253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOXuEdw+cmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:14:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDF68834
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A399E300DF43
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A56346AC0;
	Thu, 22 Jan 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HXtW7ZSO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD4348889
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094558; cv=none; b=W+Qz1aqTpJJ2vWwSQQLjkQfNO532W9LBXFHHlIxqiSwDov9wdaRys2bZ9BcgsshpG6u7Xk+5iX9lWbI9UaKFxN++AclGsNWKYKxtBWyoFYB1NnCBoJWv8cc1Uohk1m5z74ng56LoDna9cXZPjgCeuH8eJhi7g+KLhB7XR404Ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094558; c=relaxed/simple;
	bh=kyEswixmvM/2R47ee1U1Zr18TYgwgtQzWQ+AwQwssus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nI0urTEYmrm6TPa5cRoyxVwg4MQgC+SH1uRGZnQ5QXtj/YhAg9BGy2Xt1s1kucXeuv8ezW06bII8LAvcD+XBSKjyo0m0p9CX678Q3cY7exdS2rLpTLns+LILXXxu6UUBnpOIOVfmAEMllYEAGx9sRilhzX7jJo1FEoG1rjGvcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HXtW7ZSO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359a16a400so989194f8f.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769094554; x=1769699354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HEkV9VzWvAzp4mpcZik2rJYLi6Ex4JtD0e9P4ovCps=;
        b=HXtW7ZSOuqq0Y2J1xVGYtDN7HsxWyJ2fd2hiAc1RV7NmtCP+3m6p6RD3GwcqQVsgs/
         xm+oaeR/0tJCVPtee3D+DGaaSPp3WvpHW3xNN7fKX2gKDymCPK6Sne0qilfQBsdUsAc3
         DYunOkceHJg7giYtOcETIhjFrAKI9zHjLn/ewhIoL6HyLkPOJG63I3E+K9SBUjLPQczN
         VIlJcs4+WGPdGDvPeXSg+jC3Ry+Pl9Xb9Fs2Apzo/jzM7rRM9T9X5MRYBzF+3YZkJ2AE
         lKyktm6vZeDlglS2qCbVKHaybvYuLoth27AVQV8be/rHbeFMc23K/XgMxTFW519+/Rxe
         AGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094554; x=1769699354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HEkV9VzWvAzp4mpcZik2rJYLi6Ex4JtD0e9P4ovCps=;
        b=YczYrkxHlx5kXpDsHIEHByZ75LCeZqI48JWAElEtypdHIdC3vdIXKFJd7M1QOqogkR
         CSf3Aw1tBiBoeRtKNi83kZTeljRbjUAKiDio0JCLA5bbTrklhzm7HKVDbnQtSRE7VWkc
         AGfgy/TLP7hjpKWLyh8RfnKJnLfsAFX8601QZxEy/qmopkbBD6mY35KrFAbSUGsoLGPQ
         ZkB7Xzf9UYAzUDAWeWT9RqBTtcKZZyaq+Fy+iasj8oYZIvUS6iI/hGE1SEzVHgBLwkg2
         FGDONKdqjPEnN1MQA9uu4vKonjWcaTCFBAnpe9/NVQp4bqHJA9lWYa1z3vLTZdDJxsxV
         WPpg==
X-Forwarded-Encrypted: i=1; AJvYcCUimtYZ79tBcSYtFoqW3mPVo0CztBwApkl0nHbVps+esqVz+UQt5IHwtt3DzxXP+K/MypGpYXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywrZrPzWby0jwnhZfggymmKRHC+HqmUJyEumsXK4e2xcx0ggBI
	pKj4/3PtVG7yQuitPR9Ed0Kkj6pz6uNLMQHONJodN5Qd8y1bSvW2MgQ=
X-Gm-Gg: AZuq6aIJCFeigVbO0ZLW20qCo0j0V4oFcgbYdJn8NWSTWO/9aq7nZCuIMLCw4rBtsnR
	Iwjk1UVv+ze+dq/JgIfDAFpTebFKeP770dH4Yw8A3vMC9JrObgJHE6yelBOYfPhuKmOrUOG/pPL
	kwJNnJyLvxusF9I0Cg+OqXl83Ofv6moKSvx+/h9Sa0UA4nLzvv+b5lwDwujqKXAI6PTU72aM67j
	GhOnH7ro5iPEhM81JGwxp9kjf4OwxM+Uv+5ftM6EHeKIR2Y5nRIpuXpS94wD1liOhxlbEzav5Hz
	FknBhSiVsZ92155pRD/0g6QKQwrkDfCDIJbV8Nc7FNkKo4Z6KU08ZJTzQsEXaKApf0beddodpQ4
	UqFhF9/09mlGn8/h7/S3GBnkg+wt3oC9N6W3zkeKS7RNeZs1oM0FD8vJeYHHkp1u3R0YNS/5gS1
	yc53LHA8MxWjh+mckYlGX/hN0N6757iQE717luoyXcyAddI2d6LFPS+kw6E2+5kjI=
X-Received: by 2002:a05:6000:2f81:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4358ff3988bmr14224782f8f.55.1769094553461;
        Thu, 22 Jan 2026 07:09:13 -0800 (PST)
Received: from [192.168.1.3] (p5b2b44b4.dip0.t-ipconnect.de. [91.43.68.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992211dsm45679808f8f.7.2026.01.22.07.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 07:09:12 -0800 (PST)
Message-ID: <2385bc6a-6b2f-47fd-a376-fcaff53eb232@googlemail.com>
Date: Thu, 22 Jan 2026 16:09:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260121181411.452263583@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211253-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: A9BDF68834
X-Rspamd-Action: no action

Am 21.01.2026 um 19:14 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
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

