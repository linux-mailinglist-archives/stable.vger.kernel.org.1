Return-Path: <stable+bounces-235477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BNqODPt12kbUwgAu9opvQ
	(envelope-from <stable+bounces-235477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:17:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A33CEA21
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E6F301D6A2
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AE2E7162;
	Thu,  9 Apr 2026 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imAWiTYa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BD2FF65B
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758601; cv=none; b=k4qGaBJGuwPM3S2g1yzlF+S+teuw5YpspDhVsLkFAoC9mF8kSkQ3+AU1bMOoFXPohlfGx1XvH/tix00CU1aZpDd5oUrBlyfG+HAFQLCWEdGK5ClP/aQGmxCmlBZxi8RiREcDTfbzZoyg9M1Ge0RU+MvhiiZxI2++7CyDjs3k3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758601; c=relaxed/simple;
	bh=UmlE+6ZdtmlTuBH3guz0WuhhlgaoQ909RCT5n8LexNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4OPi6tTZ+7mQ4U8CXYjdEVrO41e/uhTOYVkf70yIkkgbIurdtD6DzrZ5XloUTa0uNNO+H9limLt/7ktdASXF15dcwnhj7aIXJFcWe/3IRWDmHlTyXabWUcEyJb+V1IGmSIXmfnBy2tOkVAznrHovfDW25A1X51BTZ99+nqUthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imAWiTYa; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d18dfa2713so956428eec.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775758598; x=1776363398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuIL4P3B2HTR8rrr8+m3taUTFBIHOuLuzCd06XG06aY=;
        b=imAWiTYadMjudki6YS3ZYIxfxhe65x7ZYorGqf1qnsPffxR8NMFk7VLi0tTZnX3s9t
         OHepnjHUtPrd3N8DdHD14MCbKIi+omA20214ROoKmZYshlfNqQqvLsOA9PLmEb8I16yW
         uY/Lf81gBBIyDRp/JquJOhA3oem4+ykyyyqrZs2qCzIn1V26586xj0mlD/cCR5NfsA2v
         JUO3hY/d37EHtwar091FzLrSCUFyDQGEDLLDf1XJGEau6iiGWNh/bb/etJV+TWiLscCe
         d+o/l1HlTOrbQXfdEPpUwdvb3Yy6RNtlSkcYEQN2HOGjGFclj8GCZDNsOoa/3QqLWxB6
         jzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775758598; x=1776363398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuIL4P3B2HTR8rrr8+m3taUTFBIHOuLuzCd06XG06aY=;
        b=cNfm5qFuvW0Uyvvpft9zMaVWIIaEzni4ttuBy8/Uy6Kt4auOlxEoPzmvpWEkZ6nCwj
         eqseO1Qy1Ao9uDskl7Z5WT3+umJO4cIU5g2CcXjccau92R/p20lEwXnO7Cs5VyjTfxj+
         JV9zuXceZY/zLWde90WRO0TMAvZ65FJBxpEAPX6kBGN2BzKbjHg/gIzTrqGvCA4S649Y
         gsNz1tp68yuVezwyriugy/xxq/3fyNe6lDzxKUixfHMzTAJC7FlkKYamAliPAUcu2U4l
         x6BojdHJfNpmEGZSdqjPy0IkJON5b96uLJAW+JmEXIYfpRDoxJ5pXt+UnbXwGuq0in0g
         kgzg==
X-Forwarded-Encrypted: i=1; AJvYcCX2HZDqXLBsH8eQ8BBahdpq6cIexVJf3nNz64W0casSJFi6tbKAciCcv42iA255rBOC/d2Ia4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCDlv8hWJBiSu6uz5zmZJCtOehxpf6NgcS0yx6XpG27HFTRYh
	soc59PWyMIlYsplpAeqLOPScfJcK1iBd/ahgBAdt5+dQjQON+dmpF62o
X-Gm-Gg: AeBDiet0En/MG7/g6CwFZFUj4VO1uKrfQjmMNTK98XW5ZcYvXkPmW4FrC2urAkZ54ci
	PdzX22/6yxXfMrzDlMsFXPeeN+FaoBPJ0/epxOXfhVyrG0rZvwm40qRnLyYMLX02QFOXwFNG1++
	K7lxw2C9L2n9dqqVi5jESTgcF73gWrJN3pjrrGP3fLvWdxN4GgcgUaUBOvhveqYGH6LRgalAJly
	uB6tzvC7Xwln18haPWbCP/KlEdgDi3cE7V1mNTPZ/FGKT5NFWFGd1w95ia8LWtdy/BsVxkwUKDr
	zn9+DgP/975JEGaP9w92Q4tAyzVtWnJwoO/13DghZereP+T1k6MUgAd65USBZClp47/sfMEkA/s
	q9QaqJOHPR0NTjVmQXV2Wtdvqu90jT8mCHJ+voVqdeFAKIyKNNdgrfc+tHNRHNcEebVxx2Uy/hY
	LNj0TSoXmWXLxgfq36LugoJwiz5rDc8fOWN7gRwDCxfPaEhSVodQ==
X-Received: by 2002:a05:7300:570c:b0:2c6:2bac:8ac with SMTP id 5a478bee46e88-2d589ba8011mr57164eec.27.1775758598240;
        Thu, 09 Apr 2026 11:16:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm745677eec.23.2026.04.09.11.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:16:36 -0700 (PDT)
Message-ID: <c3b13741-154b-4c03-bdbb-e1225e1dd34e@gmail.com>
Date: Thu, 9 Apr 2026 11:16:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/241] 6.12.81-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260409091733.126574279@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260409091733.126574279@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235477-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 455A33CEA21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 02:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 11 Apr 2026 09:16:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.81-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

