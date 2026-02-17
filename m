Return-Path: <stable+bounces-217195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOzpAwDxlGnFJAIAu9opvQ
	(envelope-from <stable+bounces-217195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:51:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB9151A08
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 503BC30457D0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA32E0405;
	Tue, 17 Feb 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brl2S/5E"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2011ADC7E
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368699; cv=none; b=sh2/cQQ8cpoA3EnraYfgEXTA3Pyc4LItzE+pLY5rVcjANMhTJ3GoteQxbROdszOkBX0j2H9StGZMTEat8TSn2nRxe8MICTLhShcl6TE6zI6Ts6W1ic/XHIeqIQSy/19VjypBoDciz8kXtbpBjaM/qv6Jm0vJR26/ifcLd+Wh5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368699; c=relaxed/simple;
	bh=U0nA+fK6yD5Rb7CeWzI44hA5+w3rV5gPvycC2EorD+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0fkqM60qGfdfYC7s7pnIMXDLKnYuJRlVCjWo0i/e5TBhJXI31uXpii8AMS3Lu+sv/AN4kU7CHRqWAb6FlX+7INA6GOxoqvgu45EKq+AUj5vulnuvZEaMhAoZoSIe++HGc1rwcxCw5RKrR+yLwvyRPSi6OFPGGm8usxMuGbHwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brl2S/5E; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso4572962eec.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771368696; x=1771973496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kR2zuUHrSIpExMYdfQJhQHRA53KANikLoyFuVoTFqJo=;
        b=brl2S/5EQvTh6OtZSJi1Kek4ArGcRQVVkdla+F29TqiraIzHXNfOynOFHh6BkeZDvO
         5VnkfCiX4glslxdrx9tszB8Fk2SqW5f3O1pBkchjiW9Li8HqWOeDsG+te/czEWkCNk5m
         NU1RYgr8jzCpTUHMS0fLa5r+WuaMZEtDO+kG817yR2O5Z7tcranRVrqWCAhicUYSuCMZ
         jBGBEyRsXBm7nRZ9OcPvkcq7vwbFf6mZ2C5H1ec5SxcWb5B7VZWP5xccMY68IRAI7CyN
         HYU2EFQcxlTPVTPyHKTF7YbhM+G5Y+c+3I80HbxvCkSuNszQSFQnIxvy3rc/5dG0ZM+g
         PkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771368696; x=1771973496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR2zuUHrSIpExMYdfQJhQHRA53KANikLoyFuVoTFqJo=;
        b=Lhv29TOnLaqp3ENQwLEU82Ul4et7dDjDc9UAlV4ZTj/dWogkx8yuvNu8QTN94OsAWu
         zQdme4uwtDxQ7vnT0wo7Jj4jtK3+rhO2/mRyAiKcJSjWJSG4pXtGlgldHWRfWc7zEoEi
         Yd0xwR+BPwlufcSN2MvXzbj5Nk2ZXrUMSK2FXs1PaCAisyNeM52/lZ8qb+A6tIxu2uLd
         QfGt45Y0yL9fhoiNxKVM2bEPfYaShPurdsHyynbJMK+wJOU/5jB1UjzW35bOO0I2NuZb
         vcu0Yc1U9muTyFaJH4op3mvug8EJrSmnNSeJ4jgx9csNTNT72QO8YE8Immlful8v8HhW
         svQg==
X-Forwarded-Encrypted: i=1; AJvYcCULtaa0cPLTv5+8JXTAsWntc3D3CD7Y+e7Yi91MyNMSTHCpO/uKcafVTiRWmOSfyu29676/yWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsNZ3t3QKcpTObZugkzRxYfd7kES0z7Xiv+8rzAGVlu8qu9wbP
	RETNbQhld1RbaF1N9QHg3zPUHxh+8qkCSBLPPNaBsuhFZ7jcCSlztGWN
X-Gm-Gg: AZuq6aI5/pn1g+mkkKkEh9Vj5K/yK9cQZoizeENr4KCZuf23ThTQ+8wYHIDmgEbGWh3
	r0Ql0bwFboAHgB7HLdWpuuMhQTZG6CRSdCpF6LBMlOw5OV2FhBHSKBjvk9lR/HwuvdlLvv/Tbfg
	Jw2f+iXQo15yhYVjgNt9LXb3UrGYAslHXW8ZDXEP3Amkqp/DY53dC6v0aMkBWEib4jcGbyyZs/O
	xKFFsK7QCtga7OukNOchXMYmt6MTtFp4lqYVldOY68e0g41/KaJ7lcUv3gQo0yV5y/U41+v50gQ
	DLa9KYgCS2HPFLgv6sr2y89TI1i/HDCNhVKWeLRIf63S5lr+tJz8RsVFwcTM19C9WM/+gmjU0qL
	8YXlZYCaS0tUvpDNk6aU4yVJ9KG/GBPjy4Rus9Vlv+QGCiOdRhT84jKHRofH/Cs9I4dkox9Vg/X
	SqRi+hMWPCOwoE53wdVZGLGv6IlwrBL/TV46n9kgJ6kqnZeIIS5Q==
X-Received: by 2002:a05:7300:d517:b0:2b8:64ad:ad4c with SMTP id 5a478bee46e88-2bac97cab51mr4764746eec.31.1771368695946;
        Tue, 17 Feb 2026 14:51:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543d80sm18328440eec.1.2026.02.17.14.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 14:51:35 -0800 (PST)
Message-ID: <31869170-3919-499b-bf86-8a5ff4d0ec4d@gmail.com>
Date: Tue, 17 Feb 2026 14:51:33 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/42] 6.12.74-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260217200005.998240758@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260217200005.998240758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217195-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DEB9151A08
X-Rspamd-Action: no action

On 2/17/26 12:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.74 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.74-rc1.gz
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

