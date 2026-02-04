Return-Path: <stable+bounces-214354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHp2Ndalg2l3rgMAu9opvQ
	(envelope-from <stable+bounces-214354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:02:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227EEC53F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDC8B30125D2
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117432BE03C;
	Wed,  4 Feb 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC0RfQ9w"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CB1F0994
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235293; cv=none; b=KTZ3zJI2VRllX5TYj1HNbiSi+ISpDXoRoVtljk+/CyiO1ba2hhD5eQ+yB72+m8CLel8oWH/z5Dv+MmJwztMLQ5vZU0oaOlPrdYLe24z9t2Zz/9cdMmhtHIM/nTfO8f4zNtK/8g0MnXYs7OZ8f9dlBTFhJ21T7w8QfL2XQ6CuMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235293; c=relaxed/simple;
	bh=gHe7WGg7jP1evuumvxETi4DkTpbAy5LF4tiX52x+tm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdyiK14XhNemVwIY/zdKbnP22uFILoUM5IipJSJCR5rrK4BwiwXX03qk6fWvNhaNa9/xLZGhrkWqWgT0POO/ITg/dOC6Vg9CD11MQYG04v5knoVJuuMLPMtPNPnbrdq1p6CnSELEuCIcXpAkDl7SgQFDzD9mXZBxRPm8Y7vPNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC0RfQ9w; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f171cb842so169428b6e.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 12:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770235292; x=1770840092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShjD+EC9WPxL6ZuNnhCoKEA5OMjpVlimPEf4qFabAiY=;
        b=RC0RfQ9w32ZEddru6M3LwPO6jlauqQFjuCwxYt8cPcaJw5NxjzEQz5ZwENbLIK0Vn5
         uuyFs4O6v/4U71C28+tDQwKWjnpM5xhLvyArDoi4rw+JI6GCd02RdNo2sZsnKWmLKY87
         2qk1/l5UWFS6MnyN615Ifgb2iJ0eOACGlArmp5aR8SG78JSbVLJQHRlTaBD7Xgv8VYnK
         C62W/xhESAg+HBHpkoNCC+LArSZpjH9KW0vq2eGvYMYYR/0rndrwBno5qIjDoRVTT0kQ
         Bm02qsdtm6rIj/DhvswR/s9cij9icfv9lEyoR/mwASEufEpFVbJr69ymFz7JUwFmtFLm
         Jkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770235292; x=1770840092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShjD+EC9WPxL6ZuNnhCoKEA5OMjpVlimPEf4qFabAiY=;
        b=CzDyIS1dEaA11dvmnWNBhz+BM9r7I6hlM+weOFiGCdFotjA5GRYZ4Kj0TmJb6fN2AB
         fTX2kzB5AVJlSYg1I9HT23218xzK9AOav+czhKWuHM4YnxnoW7bffn9P7P6vcaI6l1IL
         dc7DM0oBh4hH1u53lSeoYhhqXEwNqwpspXYU0fk61Vw5TsU0eqqHnL5k+D1nsF4rOIB6
         KyvjHNxakhnJtTxYOKIT8EX7iJitSrmOTXZ6hJ+EWpmpnOKhJmwpN8u5FPmgrN/pzlaI
         SVgALYdRxsXKyawcukCdA3PgK/OEGEmtLzSxi0eL6FdYvm9IQWkYlv0nddH55axR6nD4
         GpgA==
X-Forwarded-Encrypted: i=1; AJvYcCUFr11Rs+aBfygSZ3yut38OSPU4fHSSLp/EKxY7leMv3Nf0eHzXyyC+Er04eAKIHIzVF5kcrwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyep5HMUjYW959HX0PnvKmY1zSKwpfZLCsXNzuXZLu7A0sbb+Mm
	XC0EYd8WWhSFHKF5XHypgBC7sTYJhdpZLvKqFNKgWaRaFsMfitAl6bKl
X-Gm-Gg: AZuq6aLbY2cFbj4nSg7xkpxGLdh1FoA40QloVfvD++4qWcv76ti3hciFjHirGzkvtMi
	ytjq+CFgm9dJgRXHqdnu8r20qvDvTe35m7dMNvEoRF/Mhx+paKrjvwuZ9novoh7FMFdYageEe+e
	VMZTe4Qq8WMKFnw3/+svMz2rQXvDmg2lEfmRHe9vmzGlVBDoXAazsrQYLqGbnv98El2FcqBbaz6
	+jOwR/op5iQwIOCFN807MauaIRnARzg5Jmssq+ZGBaeFYwOAwEsrRT5uIdV/BH0IsPlCOlBRXeq
	67j9BfxSSRCyLn8SlFGmr7J9NrspWJ1cJ+NBpGlCjDnLYq21gZ8jW6CbAyiuUseIsK5GRjUj/7M
	+273K25PMf2+josJR1Vtb+kDQu3FyT61Ay9f4CiikajHwATNjuW4xKwGiTz7qIcpSeb0S8cK9uo
	hLeunuKo6zctqdaoyopUQ2xN/VIrzcx8jAXT3bVw==
X-Received: by 2002:a05:6808:c0dc:20b0:45f:7ac:12d9 with SMTP id 5614622812f47-462e9ee7eb0mr254456b6e.6.1770235292480;
        Wed, 04 Feb 2026 12:01:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d677772csm1900394b6e.14.2026.02.04.12.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 12:01:31 -0800 (PST)
Message-ID: <a56c47da-d40f-4aea-a7c8-deb2813ca3b8@gmail.com>
Date: Wed, 4 Feb 2026 12:01:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/72] 6.6.123-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260204143845.603454952@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214354-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
X-Rspamd-Queue-Id: 3227EEC53F
X-Rspamd-Action: no action

On 2/4/26 06:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.123 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

