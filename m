Return-Path: <stable+bounces-248943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN86O96iB2rP/QIAu9opvQ
	(envelope-from <stable+bounces-248943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:49:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6735590FF
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75BB304C8B0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C53F076E;
	Fri, 15 May 2026 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FsDIzvbc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C4379EF2
	for <stable@vger.kernel.org>; Fri, 15 May 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884997; cv=none; b=N6o6loW0S7A+g9UPZkIuolWDmsmde2TQz3C63lFA+paapx4qMAAF3pRW8QKmYMN8Zvq0tGIxbFQ+E4068QX8I5FjPFhySO83iDkHHylzc0WIySzF0iTER7q2qHQIXs/ksIJfWZq9kfbYJ+YGiRdDEG4byBCzaOcuLuq5s2d49cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884997; c=relaxed/simple;
	bh=P7yoart6L3Ptt0MALTqzUGKYcd9a9n370pSWilATlCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEiEMpUOCaqai2F91hLtCRH38yJWaXInyAPn4Jtdd/9oWT8yvWZzJocFDfBjlifuAwY5WuFh/ap2ZnDSAYc81SklNbObEE5TerneIsffV4yjRLeuhm9rAcs2LN2rTaHRayAEbYw938oNuLEg8SfLnfzRQdzqw/BEXvLmwf2qqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FsDIzvbc; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d9b155deso133268b6e.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778884994; x=1779489794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9OMOeDr8S/nLTCUWWSGldKz2xqUmkNeXT3iSS9CR2k=;
        b=FsDIzvbc7WPTOD+owBNL1Spn5uBCNi7tskmcE4afXcVR4ny/RdG3sPm6ZJSms4Q3Wc
         CY3aS/Pdg9KPSJc0CiS2VzxZkR/OsnzDkxYZzufjXyEDAKQ6cIYBMagP1cNnWvAnnaZK
         8obSH0fbN4M/YvTn/VRI0BQmKaDJ8irSvxm6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884994; x=1779489794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9OMOeDr8S/nLTCUWWSGldKz2xqUmkNeXT3iSS9CR2k=;
        b=JEsLaonk7nPSYI11jzzSAZ/iYyYvjMbMsxShNji79epKq+d5jTXacwt3IRIRB0wsfa
         0x0QzFKvyh9We8QM7bjinoKiRG5bfgBmbw61WVHKpUHb+dov1NSShRtaUwX3zN/EdVHt
         UdPoYAdBneBDGrH9O4w+beNdQde6YOFDalssvapV9MHjza974jh3x1hg+VkIzTlHJAId
         LL6Syazl2jdteOmizshQXvaM0QBhGO0q93ncxkeo25HKsOnVrkJUQKd2N4p8SdeMpRtp
         VJtFt2acOtCthGwJGFmvpUyLyKx3Mm7D+CxjskejWEeqgVRps7lkBbXkv33+zxTG2bHp
         02Fw==
X-Forwarded-Encrypted: i=1; AFNElJ92fxrxMQL6qrfp/1Aj7loMEzZw2KgvgV/txD274hg4016rb5v/iXN4cVedQ+5RrN/sP4RgtOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOJ711z+a0pC1j4TqiIKx11aDJ3LWEAj4iKqldX2Ny1PWEs5v
	3rUTKc5ejCYqsNNJUfkWCrrktb1soyHThN7cs8lkztpXZ1ukQNyiHUGnMT0wx7xPnjY=
X-Gm-Gg: Acq92OEQgvL0Q5+vct+TUmpST0kk+CCroId9HozJcknRuDm1Kzpd9MuZ1riCIH1JfM7
	EzI+TBqLdF+E08ig7G77HMa1akAjHVXnckQPczzCxAcYeghjDFTnSAc2cB+ZyTR7HbhJeAgZE9z
	T3VhS5qWrusWu7tDnH4FMPKM/NCZX8HOQ8ypp8EdgVjXiwLA8+JCgbOjRIZrQccR1Wjy7HdrKZN
	jWSNECMrlg46Lk/gLkF38Ar9KyWhU3Lq+g+YVFdq9KeL455KnSPxISCyVaKmEgmhJYQ4KxyVk0J
	sI4zmcTH4xNXOXykhdWtjbZCyijWfLrNcgQxrRyPKsSoLrciwYuydrL7of2bazj/8+CEqvsKTPe
	a4f6d7y0SxFOLuhkBRl4o11yxmp8wxKMlFNrr7IybolpQI2ED4V6lZNlK5K0Bh+mnN366oRC4yb
	JKqgXXXkjJcw9CAnIUbMmEenjY58YgpKM=
X-Received: by 2002:a05:6808:228a:b0:479:d16e:961d with SMTP id 5614622812f47-482e563231fmr4169565b6e.20.1778884993749;
        Fri, 15 May 2026 15:43:13 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4983asm2254977a34.26.2026.05.15.15.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:43:12 -0700 (PDT)
Message-ID: <bd75c4a8-aaaf-4072-91bb-fa491a00ecd4@linuxfoundation.org>
Date: Fri, 15 May 2026 16:43:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B6735590FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248943-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

On 5/15/26 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 May 2026 15:46:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
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

