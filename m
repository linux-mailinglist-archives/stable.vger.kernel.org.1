Return-Path: <stable+bounces-57954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D893892666F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FDB1C2141F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50717B407;
	Wed,  3 Jul 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z9rygeo+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BF17995;
	Wed,  3 Jul 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025689; cv=none; b=RCv3pD+9k5uR81gCTomYRCJpSo6vbgbfvgxqZRRLAX9OXFlfQwSes4T4Oc5s/BoYyYPnwp6iO70p5WELTg/4LP+4UJXQq9dDp2mygwyi5TnPc4aJsLwOpMdB6aCINOMKS63VHMNb/OPHkFShJbpF/K7cPsCkvcG+nYckfkOoPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025689; c=relaxed/simple;
	bh=Sv84Cuh4iseHWvlXvXyU8mQ30EZU4NbMB5oqIqEBxis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQe/JVR5ItG0Rx4oxRd3w1/yPmz5Rk+iivQQllZNXXdB2myW4hL68V3vj2VEeOJrHQ1MgTlp8yeTdIE+7lB1+KotqP0JM5C85ht0c78r1PxJguF/9Ft0fURuO1xnxIv/icBctn+RNu6QsFMaRvGrcoWy9msy9ihis3wDtwYXM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Z9rygeo+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58c947a6692so1835132a12.0;
        Wed, 03 Jul 2024 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720025687; x=1720630487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3JMF8+gV4sO0O/ZbwGbcfKFD+3y2b4tBzO+SesbF9Q=;
        b=Z9rygeo+dQai4l5mnqwmVvo8DbQuddstyEQwQA7DRZlUUWvjBUHy5JkReCF3RFPOzI
         qPcql9v3MgzaU0J2qkU32x+UPgsEiXaw5xlUFvIMArYYUcXS8yfWMaumtJYll3zeanCy
         QMAG74pI2H+R+r0vVIlsFS0s9gMJw18T214unbYruQwamie5G6HmFflXBhVE+PIJtHKs
         ggJ0wSDxwV1rCVlfOsDI/crVtE58AcCbSfHaw9oz0JrAu3oteGRzdNnpz300dyZagdjS
         NCAk3oGHubSLeNCcapdEhhZKTsQbf07uvcwk4fPQ70V4dwq9rg1lVZIDzqpnmT/BXeaU
         /13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025687; x=1720630487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3JMF8+gV4sO0O/ZbwGbcfKFD+3y2b4tBzO+SesbF9Q=;
        b=bDrQjbDr8eoTcEG6trRBXYTcK4uJTbdbPxu3MmJCZU38tUDw+2LmDRyosgRnHjWtmu
         hnwlGnUhTiHhu0jsq6F+O6zx0OKZqj4xAgWCq3GNuwFBms5TiPuxrkcNoMmMCHxjXWit
         kKP9dMsw4JTZh85kDf8sBJxvYE54PTSt2bpd2WzqP6cyUocXO+3HanXuEMO/EOZVs4N8
         5fqoDqgK+cBVAxz+KdC5CfiA6NEjLFeKEU9Ax1qo+pQn1QPai8FoBnboe5nlmDGPocdh
         RylA6TcnsDN3yyX/GsMSlCwZ/eMWCwv+tJIstZKKDKjB6DeGsOWax/kvT0CocRbY7GN8
         ABlA==
X-Forwarded-Encrypted: i=1; AJvYcCV1uDpG+uT8+ylnXrdo0qgvDYE0g/NXoZUOm8Lm6okDuCS9l/TQGPXL6ZzAmqbb21xG3tVc8ZXv+PYrRWKuHle8timXw8kwJrZKo5RbnxbxKTldZYIsHKYFGKx/8EhCoEMc9GeF
X-Gm-Message-State: AOJu0YwKtQ3cwy6nfWyNJQwH2rp0voJ8FKt/exC/W0cL3/QmMPKOhkaN
	VUGjy44fsts6o7gV0frcd55G1RM8Q8llZNRlgLwU4w8+JXHYUZKEL8FlnMM=
X-Google-Smtp-Source: AGHT+IHIiXhPICKwjl3o4henIEjmhYAWXRonYHY6ZF5viha+yKcuyNtQq7gnd7JK/2RBEOT4sLI5Ag==
X-Received: by 2002:a05:6402:26d4:b0:585:a885:da28 with SMTP id 4fb4d7f45d1cf-5879f59bb3emr8688869a12.24.1720025686454;
        Wed, 03 Jul 2024 09:54:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4597.dip0.t-ipconnect.de. [91.43.69.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58dd6f1fb85sm152465a12.77.2024.07.03.09.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:54:45 -0700 (PDT)
Message-ID: <53f16c23-c6bb-4b17-a254-9c8b73109c2b@googlemail.com>
Date: Wed, 3 Jul 2024 18:54:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170243.963426416@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2024 um 19:00 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

