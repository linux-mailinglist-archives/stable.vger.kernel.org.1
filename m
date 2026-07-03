Return-Path: <stable+bounces-271591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkVvFOX9Rmo0gQsAu9opvQ
	(envelope-from <stable+bounces-271591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 02:10:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A417E6FD8C2
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 02:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=googlemail.com header.s=20251104 header.b=Z2Q608+7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271591-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271591-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C02300DDEE
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD959EAC7;
	Fri,  3 Jul 2026 00:09:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38538D
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 00:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037384; cv=none; b=DDtRY+j3CApd2KrDFkAWjIB1lrdqrcUGKr7n1zbKVgktbVmH+2jRlEmekMKbRjpMGK/0Rd3UoL12dv67OREVs/DgrUsi0BcrirA8CZWeDVdvL6I+7qMDfcOgDfWU7eI5LgAZaMO5sbUoVZMmRSf4HtOUltHhv+bI4L4WrE7EeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037384; c=relaxed/simple;
	bh=FOzIp37rKpRj/SO9uVzGIhC+9W9c7YrpM+ZvGn1yDbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zr2XRlrSgQ3abEUuzrBX8Dhz4YU0vLDsP5jmouRxvnGwF5g78pTKWB+EAQKYyxVUfeAKpV2gD/MjZxqbRFGVldHP8gvwWlMgz6MoTtWSBfUIEQx9uA74gxqgFQlyyqlW6bM/Q+nKftgQvUKzQyWVcSmJk2eYkdTtsAT+MBCEU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z2Q608+7; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b966dd74so9853365e9.3
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783037382; x=1783642182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBk1Ffw6XB/+iGYZcNWrkSf57ibwU5mrd1Bbf46KPkk=;
        b=Z2Q608+7v0zoy/c95gIIpZBB/zeBo9Rh1kUhAmggNY1ILSYNR9m5FQ+IoRSM6r3r0l
         DGtRblwwu9ya8UHuj3hnTNCCjAib/hF1Hbr7nnsR3MiiapP7JWDGBq81Qmwnqko7dDXF
         yNR1reNx2OsGMSIM6XKUc0/ncRZVizctSRV648SEOHHqX1TN7rS4ePjSI3cOZonLZW0c
         XIncurX2RB5U3Yy9tVU71bxxw6DloO1Znp1XvxMKEjzrT3AXww/alkgC7JXsmWO/Hy7F
         HXx2EQDiGMMm6sG7zOD2m20tkhqglIv1iggIFF0jefOVO/DgdpnhhJi/us5PyGAYeOUu
         Vybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037382; x=1783642182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBk1Ffw6XB/+iGYZcNWrkSf57ibwU5mrd1Bbf46KPkk=;
        b=kPDmoiO1vPbc/H8tmn737egIUQgR3lBsMmAllc17A5tP95QF6RFF+lD40E6WUR0qB/
         xrqQWZ96VS2SFNXmPCuJ+b4MF3gNt+wGkidXffOzXnuLt4WkGUfxm7wcmknWy5r3lI48
         gV68nfi4QZ0xEPYcAGFVnid470o4L8zV37BiKGg4gW4VvTAA+vyJNukZlzrPNd3r+/nR
         yM5F1Fsebw6rAqMDp1jP6PQZn3fOV8b2+6bEW7VrmkZuvL7WRMRoKY6XphXJqyl2Sm1/
         f2VFCA9Z4sZIuhf4A8nyOE01mAiMpg/IMIgzAoMOpZSbN+7XvCK+7Ib5+rYLOPV+ECpF
         4PqA==
X-Forwarded-Encrypted: i=1; AFNElJ+XfA8c0QDT4FDKACIXXujNZkTkq/3BauEGcoBXMBZbW54ltis9LoUXkTW/1ypSVsKUqRGc9Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6kS9Y/h7i5OnmUyZApvIepl0OXHv4QBrw8NXcbcJrc3ZwO1zY
	2T0m8lO7VGOBMSqSMbZXsloS7BSarZOJoi3nmqlYML227WfAoOGdVcA=
X-Gm-Gg: AfdE7cm/3Whz+Df6iZ5mlFZGCOsHMpM2Z7LrojlVhqF6/B9ORYcDmJwirmTV/0JzL81
	/ZGJDVbS2ickxJETvSwxj2w4DP91MoRT5Eilidva91rd8shp/pyhhrwgYLdzyP9DLt/1n21jhgE
	aPoGpoAhHzMZ04g8SVnsx/Pbzk7nkNb2yuSR7pCjC9LIBvQI9Ex8CxxLEalO6P4l5ih3Ic1Dkcl
	aTDjsWgmrTeeanc9YvxQxh9+iTs6vFKyCiRsw4kDgrCgGO99I28GqaJwNfFyCaEGd/WkF4fTEwZ
	fterDRTKvzrhpo6EuKkIyoSYCXV37UbM5Ls7sycplGiUWZ7s71j/hYIh5QSIZnHfxs/00krXeID
	R5dvboEpAV7B8y1scFGcqQgIvIIwg9Uldli6h2LvGkorHC+GT+6efN/LC23pL9SIumvlelavOA0
	Mi8F3AGagBqnX7ZQYlsBUfQe3Q5F7zoov4DL091SxoDfMovCpi091FRji477EYlhU=
X-Received: by 2002:a05:600c:8b75:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-493c2b3ce9fmr114598325e9.2.1783037381630;
        Thu, 02 Jul 2026 17:09:41 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac307.dip0.t-ipconnect.de. [91.42.195.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbb79sm12804574f8f.2.2026.07.02.17.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 17:09:41 -0700 (PDT)
Message-ID: <71e04acf-4396-4b35-8cdc-251684fe319e@googlemail.com>
Date: Fri, 3 Jul 2026 02:09:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.1 000/120] 7.1.3-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260702155112.964534952@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.05 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-271591-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,googlemail.com:dkim,googlemail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A417E6FD8C2

Am 02.07.2026 um 18:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 120 patches in this series, all will be posted as a response
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

