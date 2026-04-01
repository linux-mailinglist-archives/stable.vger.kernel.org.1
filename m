Return-Path: <stable+bounces-232696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJovNCu6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453C37524B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C6630616E9
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4CB329C49;
	Wed,  1 Apr 2026 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lNpN+sHN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB32D949F
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024516; cv=none; b=k6btDOjGwIOTI1hjSwSlvLaQpCYnQnOFCEGT+HkXXOg7oL81n4aGrucazxB5OOFYD5vpvxhE3trVaMWVKRZIlhPRUO+EPyG9e0xvzNzaweLEZAj1oy0rx6aJ6vz161HkYy3dH8Avo8V0FJfSsI6a4u5DYJpNHBxPruhxV2GJN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024516; c=relaxed/simple;
	bh=vX3FhxugoGwWypmAc4zoaCcyRW91U5MazWulxptjW1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggcauC8stiazzRLC+wzVe7GaLuG6i0f6voNy3m67b0G2vvRP0aLmAh8zv/DxRD6BsEbxbAQRq2BrQdD0o/733xsUOXh7m1lBDbMZVCVbp5lq2p7WGSotXmXDo2zgr8FrL6+nRaZYxl36c/iKTGZ+/x3dc/+lH1jDjREmXeRAjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lNpN+sHN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so4807648f8f.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775024514; x=1775629314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jPg/zlaU/rwkyn2oC3DH9mo1UfksYtUHwnuv0z/Jrc=;
        b=lNpN+sHNNeqkzjRLEGodgU6o7MZ9g6Rk8XYMK1Cc4Qz4CFXFzNYmDW7f5pdRfhcdEE
         5HU3Q1f3O70Z3lFgd4HhwNj31jVrO4eQvPAQfRFoD15cIRILgWeLIE9cFq+Vs5mj8Sek
         jnt4bnKU2DuVT02gaMI390CPv6rtPqB3ZATyb+qf1K5kT7dUTjGVCyDLKReGtx2i8ZIJ
         YozSOhw88eAuSM/QGHnvI3oi6zXmHpxjINhKi7/ornV7tLX6GuS5EY7/Pi5sTdatqgta
         ykZuD9lgS+P8XUUT2pzKxfMUivuePJwo7ZnaSlzGLP9Rs3/0zMtgKnOmjNl2GAobPYsT
         x22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024514; x=1775629314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jPg/zlaU/rwkyn2oC3DH9mo1UfksYtUHwnuv0z/Jrc=;
        b=pUql+1AEdMXEr1KI/nv5sEfM6OUZcc2caTT5gZyWcYMp4WBLO6q/N4XroY6F4lOzRQ
         VZMvAEUqFQpW52yuQdkMpXapN7XVkjvFnAHx3K3sqY7PsUj76Vzbk9KVOt+Kgw36lODK
         awPHrF9VPQ3hi95mIXxsx7DhLcfNnoDqeJMSNq9iXgJ4SY8MnCRDtDz5sZD2TZJCpSDY
         Yg8M3kOimDPkvYZrP/1cduY0nTf3gF2HRQXjwz3GJpiOB2Aav0XxrJq//z9nIK/1aPrB
         0RlaV2LeimP84ZEsybEl6S3G1q2z5OdxvSO4I/9Tb79vJ9fBoN76fbV768e+cbG4GVOC
         /9ng==
X-Forwarded-Encrypted: i=1; AJvYcCWnyhHCMD2+MECw9aUyo/YkCDlYH0LmuIrE/fXYcA0oS41r9bA46oiXSV4RYDuSnUIL+vyoRpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlgOp2a36KpMLaRY+/kzpg3Rzpu9GJcWQvKP1ww4SAk5zOQPT
	IaCuzD9FaNrxuiaJzNsWgeeO2067c+yoihJdam/EoJT/4s1zLcdx82c=
X-Gm-Gg: ATEYQzzUNjBb1w5FKIXYCWJEe9XKY838hzicpsUdJT8bErSmo6Sl+EBBLLBCZzAlyvp
	dgrGX55paH7Hk44W523i/fdj1aimSiBE4XvJPwkSC8AzlxTtpsR7aZW1j5ietn5pSkFI006Eduq
	RU58e7arD8QnvvjUZvhWUWRfyNwczn2lxvc9VqcxNz9Vj6VBnN9YEB8BnfMoeyE1VaUVdA6847s
	9bFDDbl4Hdcjxyzr06xpHZz7Jr1ll80LPRZNmwTkM88rSB14bjc1GTDvWhqqEp7AtYL5BMBFSEO
	7CKpehUWPb9fMw9s9uQH5JIlfyjB9H5kBERwoX74a9QJ2baC5PlTjVVHsxQvMHnzx8/OTbWBAkq
	gfHde1oMGMoUEppmIwvlDFDnLpR+B/02ajptieCmS0bG+ZoibmMNzCkz6zeV23CioO1mj0u8ztP
	aYjBqMUjJGXHdYXLcxLH0Tmu/WqbKZbJGaMO+LTWmZe/f6M7HRfA7YpYFhGcx5/TOOy6tpvBMfS
	g==
X-Received: by 2002:a05:6000:2912:b0:43b:95e9:4150 with SMTP id ffacd0b85a97d-43d15049ecdmr3953798f8f.2.1775024513595;
        Tue, 31 Mar 2026 23:21:53 -0700 (PDT)
Received: from [192.168.1.3] (p5b057048.dip0.t-ipconnect.de. [91.5.112.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21f279bsm29769357f8f.16.2026.03.31.23.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 23:21:53 -0700 (PDT)
Message-ID: <d3225542-78f8-4efe-882a-665f233aabc9@googlemail.com>
Date: Wed, 1 Apr 2026 08:21:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161758.909578033@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-232696-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: 1453C37524B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 31.03.2026 um 18:17 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
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

