Return-Path: <stable+bounces-271560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZcVQKF3JRmoDdgsAu9opvQ
	(envelope-from <stable+bounces-271560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 22:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F36FCB78
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 22:26:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=gj7V522d;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271560-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271560-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F2E33073EF9
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17439EF0F;
	Thu,  2 Jul 2026 20:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BC35DD1C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 20:25:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023935; cv=none; b=AmZvFjxIypBDeYeDwQwEt+VG/Kc2gSa1+vMSKAojwYlJcrvuH/nPuR3cR351ofZN0Q8idrp4fGyoqMGHntXGxlaO2eUFVJ9A/SVf0eaNFnLo52GGneK5spkPeDzwItoBppZJpc9uPqpfCs0QC0kc4JrbQQyGPWQyUgI2FLc4v3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023935; c=relaxed/simple;
	bh=vLz0RP/pwjcvD8700PkIjsBrjDT44NCOXMuN85WlfJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCteiv7qdfOXNiNQtMlZubq/xD2fKcsBOInvINtQgA6FvLAJOJTgoYtYywgDGBBSmWklXmoGJC16/Q2zTEl6rTJXeFSJmzNTuiN0rLgs3itSo7RXjbetjmUW3WBKZSRm76MLH8cJ8Sj70EYk6GqOA2Z9XlyEUzqKGINVajxVqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gj7V522d; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4758bd3731bso774649f8f.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783023933; x=1783628733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE19y7mESN6tMsAW2lIFx+MqHczMs9gwLQhyQhGrzrk=;
        b=gj7V522dwAIhhuC43Me+cIDlZRtivZoAR6zg1F3sTXNg2MthI4S8Ww9sChNrs/GS4k
         e8lCY/5BkP113qEgoYA6dYOjmgyZLfnIcA2uZaS2+5lMxY1IuWHD0J9wH0gIwTDs+7f7
         MOTfHvBNetlOhuLW1ogMBO5V9lvJYgkMLQp02whkFVtrjui8Z+FCrEpdMSHwGbWvM/q8
         RdqTHUoFVnjIatBlGMnm3gAQzFKTrLnwy2zEj9gi+Io7yY8CPhAtFMvVMnHKK51FuSSf
         H9wzualvoT6C93XwtWJ5nzyULulEiRnC3KwplPcF2RX7ggGs+wvqAydBZ9RsoAJtIERm
         DKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783023933; x=1783628733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE19y7mESN6tMsAW2lIFx+MqHczMs9gwLQhyQhGrzrk=;
        b=GKzf0XY9O3HywwMQl5iaZTAe2PR2dbI/22GbyTdxWxMmrGxqvNxeRvJWvV2aLFATIo
         a4Q0sMB9JyRYpReacV6QcCl1P+2WNaIjXs8n8P+KbnlZOSgWuGIiBQltN8FcFeoCdaGF
         nXR6xntH7n4sbl6l/GAgtzyR+C9F1kJtUyGeJmUB+dKcaFhwnNowOMUAvWbVwgJlF7/U
         0ax7mNhyXSTMfvglFdvuwDXroXmzm0IbGvlaJdgW8knvrLd71dq6QUfhYqZGimvGQPpf
         OrWGfhcn+iQEghjYyQtwpRjou7vFjZVN48AiDnxNYjy6v1iIoJwTNGot3goUiGsDoN5W
         O58g==
X-Forwarded-Encrypted: i=1; AHgh+RqVP3qpkIjfkvJK0I2zMQxKfqw752OTaCQ/Jb1c7qHxSLWu9S5kjlWj7s7IqHPuyBfHqsVIZi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltFbdLQs8E/YlybGhQUyikzEdBMvmJ4ABZ7cGwDOkOPKThwry
	+pFHA/XSufkQWKSHCbheoTkD4+SgyO97mMUwps3veZifAqU3OlX5yE0=
X-Gm-Gg: AfdE7cl+XQ5zNGMibyPI6pjeCmbBpP5rVxvCISVQUh3Yu84KlJDypRW6rWwmPumGh33
	lOOGVj8kRbpvqkt4s8y9OTWPK/+yiLTCe3EjwrUpA3sv+6QuUFJQQTbELr/4HSx6mIoIbUV+jDl
	nXM0LgLN5O+qNrUptoGK+LecJm1yscD89hm1Q8rDA9FJ+6BV/Gfe1Zhh1FJQKbP8FGD+vX2p4RF
	0O0dnMugI1Ut9fsOLv86AlWKYA3XRqQSdzvgWSsGPQ3xdwrC+vydyKOabLSe0A+3ANyhDbtWi4U
	dp8pHPEx+8wacGyWazTAVdgUJr1rm0yIYl6V4SqnL9rj+MVSaRgHIQOumY/VYrB/l2ycq+6bzoV
	WSpv5YL5uxT7OFBOrtwvcCREnOIL14KzbRl9k+PDJxxD1uK/uxRn+juYUShUL1kQtXtqPmIP0UA
	Eb3XbyeUQYkeAW7BZCqx61z4YAjHLpdpwBFLVgiMPeJy/AexkIG96MTDmgIhbZHAY=
X-Received: by 2002:a05:6000:188a:b0:474:88ef:cdec with SMTP id ffacd0b85a97d-479347abc89mr2414532f8f.6.1783023932557;
        Thu, 02 Jul 2026 13:25:32 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb64sm12216643f8f.23.2026.07.02.13.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 13:25:32 -0700 (PDT)
Message-ID: <eb95ea8a-7a4d-4e04-83ca-67242a746a1b@googlemail.com>
Date: Thu, 2 Jul 2026 22:25:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/129] 6.1.177-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.163984240@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-271560-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F33F36FCB78

Am 02.07.2026 um 18:18 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.177 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

So while I'm watching the Spain vs Austria soccer match, I managed to do some kernel building and testing...

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

