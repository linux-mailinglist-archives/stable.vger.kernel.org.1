Return-Path: <stable+bounces-241067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MYjFMft62lHTAAAu9opvQ
	(envelope-from <stable+bounces-241067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:25:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACD463CC5
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EC2A300138C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E77303CAB;
	Fri, 24 Apr 2026 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZT/z37D"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29327FD4F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069486; cv=none; b=jIUJ4V8VishlTYyoyy3dNJIPIrNBt/rTvF2xL6rTZvESiwkn2pJrUcH1qi6NYEWgeS8NsCmjWdcnt8580FSbbWCo6JpVc/Dgha8FavJksc3y1pJfEUxr+8GfUivnDAukvrA+mWecW3MVdpYhHElY2F3Vbk8kZd82+dPtpNZIXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069486; c=relaxed/simple;
	bh=QRTQt8IYZ1PoJoyPRwAMIdnKbh+/mDsCpuzGqRWl3J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWECKaB1bzxNfOOHurg13Cvgc8S4WqNdX5WItWaDelWqY69zFrsZalML82pONyG2KCFFwd3Dkq0F/6iNBPMxm/JXUYOBGxIeb9tzpm1FQnSYUR6ZExTS4Fj3LvQBpzPI7ZsGRqPrEYsb8mRpb8mjpwPqUMoEzKVgO9o8zC72bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZT/z37D; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4094b31a037so5067729fac.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777069484; x=1777674284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hoOTgbH8m6VDooPa7iPwA0AOawKhYjioyD8Abk/9cQ=;
        b=QZT/z37D5Cu3ylDf636EdNY7vuiv4JR1ZE/jOFGWLrChU9vGpvgVpDdjN/oRhXESnG
         h9hhjA4+n/Al/9pyJzzbeVFC5Qpe/AGuD2/sv9aK8x2ou1KoV8TqjNqrzNmSKo7e/Z4Q
         Gf2AUTwtdJcdOOXonlyeTO9XX8h3I16w+r6vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069484; x=1777674284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hoOTgbH8m6VDooPa7iPwA0AOawKhYjioyD8Abk/9cQ=;
        b=RYy3kA0Q5tjXrkB9jbXxrEWHa1p4ZGksecvu+0RvEZc/sPaszp0jsPb9OTG1knBhgd
         n9m5EtOSUdV81H/z7TPJxUq9C+7Vf18/nmN5OwUBMWsaIvMUm3J9YqxHT4oMrcrhA+Vz
         AmbvvvqIk1TESae+SguGMaBCHBtPDAqWL5QcyKjlx2y14y0FBh0tuUaotICniCb92eHU
         Mu5cJPR7wxaTAcG+x+tmMZi0hHs2gt2wN8K3kG0e92osf7vKSJExWY+hf3fv9QEuvjqi
         YvaOnArulR5U7lrOJPiESZaDALtp1i90vy4kr/JNpQIJQh348mW0fDVGrJFNQgyB43hi
         4pFg==
X-Forwarded-Encrypted: i=1; AFNElJ+a4CkfHYnlRQXd35WxUJZvgLjzSI2fpSw8mlou37xCUPUqbzS3Y40JKChofUd6uosGMsOhHmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepHYqMgifbKyZRlq338FnS3uWIBZwfo02UVP/rzNwzutbbpKB
	iQGU2yiKMbsBBoTMEAj5cQLPmiIey7O6oczr71H/IzFPkzXUCQecIyy6HG/qRk61Xak=
X-Gm-Gg: AeBDievJ+HCuK4q5Ir2SCMAUC1qrkfKoPkxCXL0FljH+qB3xs7hp/5S6sCHoyAw/44D
	32unHXkz/ienkRqazYLR1GPQ1w5rlwtyBY4TcShz1YdgQLocKDZKjypGEyx+0fXasfW91Dvun6k
	zWM7RoUjW7EFDxGIBd1bRjoxBj6ipMBsGw1F7xS6V1g5XOEZEAEdKUSj6dips6eBtLEUfdMQ1Yz
	FPkYuHB6xWvCTGHD7aci3vs9j/YbHxgpqJ2K5K74LsdkXc61G4nM7w+slJWwfyl3qU4KIveLDr3
	oj0yIsD5uIdEiwmeFXKpi1zy/iKx8CuyOfKiKiDRms02UxNxiqBcPwWGoXYHogfneJg9xdI34AQ
	m+MVMGm2/8OhXJdcVZVlyykUztTu/hVxh349VUQUSw7vL+AhRYYn0AjG1pILWDhAHoHtqnU9TIs
	EA+ZR2enOi04AftpsV3sMeOG/Nbmg5Nv2MTOve7uQf+Q==
X-Received: by 2002:a05:6870:d0c2:b0:42c:2c15:376c with SMTP id 586e51a60fabf-42c2c4307a2mr12056818fac.4.1777069483982;
        Fri, 24 Apr 2026 15:24:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c054997absm15591799fac.3.2026.04.24.15.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:24:43 -0700 (PDT)
Message-ID: <c939e98c-8913-490a-86a6-318942f6fe91@linuxfoundation.org>
Date: Fri, 24 Apr 2026 16:24:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/55] 6.18.25-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 54ACD463CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-241067-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

On 4/24/26 07:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.25 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

