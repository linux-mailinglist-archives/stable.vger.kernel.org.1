Return-Path: <stable+bounces-180463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55675B8252E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 01:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179C22A880C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990E298CA5;
	Wed, 17 Sep 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d4aj0Z1y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A1283FF9
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153215; cv=none; b=NQBfo8cTwpIk7EMAGHs+iHnDwD/ZfICiAEI1FhCy0DaOWYXLQ8HFrBFaKidHSERgT6q94pRsUW2VKmKO4kogxOoKfZviyW0Hrfv8JmwllN4kQZ5Go8ul/064A2KSSR6xSIDw7OQoiGXXJSVAooqJHzngUu/sk2iDLaif9Qk+ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153215; c=relaxed/simple;
	bh=zHXhaxfq8txSsNL6FuywZq3TbSULGj8UT+faA8DSrqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAFsx5D1GQamWAQyKm364YMszYaTGyxVfIU6teZhrvG6udOOJL7BRO6Mev/Uu1/zB/Hz26051I82hgjotqbawC5qOqgJUWewkYI8HzLfc4ltr0i3pGUVGd9p19ud6Tr/ix6+r/Jbcy4wI/L1zjYr7OfNZvzNSHxgtS1yju74AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=d4aj0Z1y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so3203125e9.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1758153212; x=1758758012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH3dCOcwPC522SUE8y5HpvFj5uDFCkjUJfHRR81NqUI=;
        b=d4aj0Z1yD4MZHeQz/0sXuQpRKfZ4jA8A0+ZtielwaXmtpTizWn8No+jhczTOzgBj2S
         F1Er8CHqZdSvKeV3fSPXhfKdR1w4UFklQ6qUGbM7lsM9o7odb2lPd902whKeIdvGpvD2
         qHvuWxrCVA/amHZmjwyf9Ns1GlW+X+DuD4oey5FRfxr9eGr7q6Ao+VaSQBtx3TPi8QhI
         wc4M/tLH6S1FK2iaPtxYHLVaGiaVCfLJ8//JMUm5UXoIJjskOHK9v7dmJtfxRAqlehdR
         3aupgWVC2JEbq9jvZanhuPWPJsT1fYlivdJQm16w0aNbwOLEPQcnf7NMb2prJeOSrwEP
         L0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153212; x=1758758012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH3dCOcwPC522SUE8y5HpvFj5uDFCkjUJfHRR81NqUI=;
        b=QqSfgUsaTg31cqhFWhSNTRqyjcLOXX3crNdF25KLJhNvX+0J3knMgymHbvOUUrtGn/
         tHze2jXxlu9VGHHX6HCksOoOMChyyIal9O6rzlp1tLvPUEzvmXwz8kQ0waNudjlXslKQ
         4g37eimHU3GJIQGxzcCRgVImimofmtaOC2hbPfPRvbiK4wzrASW62uGlEFuPXQEyylES
         PgSrIIwf7vRlykxaCcyJJ/zm0bMssLp87YGyPaiu5m72E9jxLPEBGVnO6+ojQo3dEOR7
         CyLrh3L3zTh8J6QikaGO3LzfHnzo0dnFCWCPpha4P5W2Rmw2Rg6A7u5Yk8PP8tXVAUS6
         T5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRrv76/2Egqxtg9FuA0bPcwPqHiHbh3Us1FMlvrVOQzdJffBOd8IzCJo5odhNEW7GAetH6fmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9X/ImMP1rmCGJY3riOuwAuZKcbh3Yq+WnorAAsOOMCFTl8l/v
	xsSIOOlNJ7WTbYPf/9BoWkERZvWE4AFlyJ0U0J78uCq67uZvn0UsKJE=
X-Gm-Gg: ASbGncsIb1/XVwh6S9KmSmSqS3CN+tvvt66bI7ZfY3H+RfOnBxc98zOdOdlw4X9scFA
	3dMt5BW4HQzS92t7ueqbv1+DjxBuuheVDwVhabtCD34NZ9IRzbvQXERwwJoWrZwnD/fdVgjM35B
	jUoyZ3vykV9iG/IysYzSYltk/NMXC/YkxZB+fnlXWirhpVuGM9Lh3MMd0BPUO6ytk/PeaB3aizj
	DfwCiFxsn2JCI9fFFwjACiRU/8OK1VHqL4Es7SqoNu0qCD2eay4sqEG+d7WDhTsYQRRf0ESkOVy
	4VmJMMlYFjZZx9BlNhIucUZbyO+TuWs23B1QNmiY3IcthWhyM++P2MK4w/WtzuFc2XcJ89NMmTB
	ZdLWsJyQ0CLeV/ll0e2dmlzzL3ss7KeV/Hg9J5plYhb1P+Y9j/9b2e+ca+k5QEuJV/hnvJlN4z5
	mo95qvxbwZr+/UJOMW8w==
X-Google-Smtp-Source: AGHT+IGHl+QODOErTNJaVKR/wtb9/LJeotK+VcYJyj3xSaimjfMW6asZkiXk10lZ2ZIxdq/EFGb6JA==
X-Received: by 2002:a05:600c:3511:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-46202bf80d5mr37445935e9.11.1758153211721;
        Wed, 17 Sep 2025 16:53:31 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca14.dip0.t-ipconnect.de. [91.42.202.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e849a41sm55028755e9.20.2025.09.17.16.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 16:53:31 -0700 (PDT)
Message-ID: <e5ec3508-6c54-4f52-80f9-1fc4b04755e0@googlemail.com>
Date: Thu, 18 Sep 2025 01:53:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/78] 6.1.153-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250917123329.576087662@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2025 um 14:34 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.153 release.
> There are 78 patches in this series, all will be posted as a response
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

