Return-Path: <stable+bounces-241031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOZaN+7P62nfRgAAu9opvQ
	(envelope-from <stable+bounces-241031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:17:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13CA463299
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A148930074BF
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349937C911;
	Fri, 24 Apr 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTyyk1Jn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC437AA70
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061867; cv=none; b=RlcIENSan0yCuNw10EpSRyoizD/ZbpkztJUH5TZvjqqCakyrjUtMpL1r2toNVSpkyUuWx9MYTXwCqBOjTP4YfydHCF37ELBssNi19G65kgErVEtezeUdvGMmkLLieC7NZpqiT3Debp4BVLgOmBzHtrCpSzVGzZ+2CL9UGdys0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061867; c=relaxed/simple;
	bh=Gkl1QzrZ7N4bDfiIdKK+4iFDj1dRTnHohqu0nRIJo0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JluMQ0e4ecvwLziQLPOcYCk31Qc/AXX/QeetX1vBpfWO1KGOPP8fwHYdLZn4C1g9EL5BNREMRQ54uVHhothY0JwtaM1puTryW5Jlm1yisiQ+sAZ0nXKgzjApL73PM1/4poqR3t7RKu9bX0nUVVuKsblKhO2JMrePT+VGmtMByjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTyyk1Jn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso53029676d6.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777061863; x=1777666663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7c2lMMSx8lhoxtQP1VdjluOjQF1ubaN8Vricctt/Pq0=;
        b=pTyyk1JnuhaeJ6qXxHmSlSfQE1SKbh2Uo9hQqFbt+4ABVEhbME3RQyDwsF7B3lS7QJ
         ZmbKpAlU+go+SXwyp940X8f/s+ob0P17nmzdyGqooLrdGwLqH2XCGu3RKnZTgSaJXNlm
         5YgnUIsymSBiTRjX2lQqv2s+e8P+NVa2Nb036sU57VIB7VE/bysELsH6396j2nyHt6QN
         5PchUMwKKahK/o8fLkv1E3YjPP7HUkBY76qQ3Vw0jS0NANy+FR64ibo4yWBSgx5WEZp9
         5ylMAKCfJUxYO10tkuTjNPvE4DGDW8r7QNJ7njYNQBbYoT/VjkgVWUCEIA7VZ7/d9XFw
         x3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061863; x=1777666663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7c2lMMSx8lhoxtQP1VdjluOjQF1ubaN8Vricctt/Pq0=;
        b=mMcsGx1PUp3sMfc+5u4et3eI5JPUQaizBsSI36NXabTHc+gFcuPAFAe4WDWNbUTspq
         zs8mC7UrflmeRV0fP/xepYBrdm1pA/c+ihD2g3jshc8WYd0A5Cnx0zZO65nStlAqI8Oj
         6rz+J6inVdch1MHbZ+RQ+IF3pz/1yeBCM/imgmceWCv2s5WSxlJRr3pnat/2urukK9zN
         QVGBOKnBivc0LCg6WgIdcPm2OtjSXvgZ6woA0vYustvbHRkyooJrDdRJ212FTC4SvVOE
         +uBQRUNP7afDzvzT+OCMZfq63EP8uLjOWHh7SH3eJ37jbeVts55qSAL1NhbCq1PBhXpL
         4SoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x7o5cKVijD3Z9hM14YnBW/iK2g7EJrposwjT78xwqO2yYgcW6ZNry4X+2Npmlw92UD5z0Tow=@vger.kernel.org
X-Gm-Message-State: AOJu0YypK6wfehg7Rab+mw8A+joeX2NfUBFun6fJyUaHHlwa1K7dnkMt
	MY1q3kauWeX5SHYiTg1pmyhiVd7oX2MGSmywBDbb6GhXev/X0fgWWxvq
X-Gm-Gg: AeBDietdyonhw9nTQXaFin0qm1GjdDlz9xS/eVAAPStEze+Dn7rBX6YcQntA4vWs7dk
	00a7CYSoBwvStdswsyyU7H73KcF2mt+FThMx9fhOz1Qhm/c9NTQtwflBaC5UkYvKuOL0nv8F/i4
	x2b/yeYdVO1Z/a8tGfq15kVdh9ehQZlUGmHy7k6vLp64CKPLcUh9OqG1DKBmCNUQb/UV+koutzx
	6cGNykUWl+QwxoFbBu+fpwkEZmbjci7YzieYNZpPqTDGD4iHL7eqiCPA1kS3//FXZhO/H8AHI4P
	PmeVf+FKpzHRN+JbqwSOhrrQTB4k/wNTMOVz0w4VnntcvRn1X1diZfOZdN95PJr+j4mudX7KQGF
	uZXrBeyZUt/AAiJreWtGKrMz3ar7r5lForpJsWX3uKk4D1MsFPkhvFBG0XIY0FOvQB+Yrg86QCK
	A9tgN+/DrOp2tXzvHFkOrJSgENnVqQdJdmAYnBPO4oxSIGeNmFvGVpiQEFbHrK
X-Received: by 2002:a05:6214:5912:b0:8a4:db54:b3a4 with SMTP id 6a1803df08f44-8b028013decmr531322466d6.7.1777061863457;
        Fri, 24 Apr 2026 13:17:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm264466736d6.28.2026.04.24.13.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 13:17:42 -0700 (PDT)
Message-ID: <7589e56f-cb44-42bb-9427-cf0ec65051e3@gmail.com>
Date: Fri, 24 Apr 2026 13:17:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/35] 6.12.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260424132411.427029259@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A13CA463299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-241031-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 4/24/26 06:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.84 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.84-rc1.gz
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

