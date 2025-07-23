Return-Path: <stable+bounces-164386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA48B0E9DD
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24B91C8754D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B047E21B9C5;
	Wed, 23 Jul 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iPtvj7tx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CB1DE3C8;
	Wed, 23 Jul 2025 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246678; cv=none; b=NynO5b7gTXh6tUtvPgxUCxntNXU4F3QRYAxvV7I4Uf7CFjJ904z/eew8bhtwh4IqVdOcSq1OyP0Ex+nq4KTh5g226oKHt5ImaRmJA/y77A+clbDh0T+td3p+KdXjNIErs70z/aCJ628PjjS/LUG6NNTDApwWqm4TpjrMv4QqCFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246678; c=relaxed/simple;
	bh=d2mxgsFxyvMH3F3I+a1W2pCTRdrC2KIPCY3jn2A59s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7BlpUrARXmqdAPZFT1QadsycFi3rymHahkxZARCTjjDvYrSABQshn0FwQYezcaWz6EeNxeU7KuqUmk+z5U6+avNKa6C/K6by4OCp0Nbvc17rdbS+roX9UnkUhDj4gBxW9UVTLwm9AUTWr7WAytjeSZwnPfINxZDu8KPXa6TmUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iPtvj7tx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45600581226so63976275e9.1;
        Tue, 22 Jul 2025 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753246675; x=1753851475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NepAH6k+tY4m1L6v0rtz6kWuAIA7DEfti3zsdAQIUXE=;
        b=iPtvj7txj11t7YaC7/yT00aqV3b3ZGaoLitV/5Zq3xGMlxisx2VcOe5LmVjFJ4sLXS
         ktqcQyr4h5cVNNld62Pw8YxENnPQlLaodGh4ZRj9njS6b3rJw+o7TmYL+RIiGRxlg5eA
         kTFoVJPStMpyMM9Da6HeBxi5v92HHz+aONYVhO+Y+MFngiFG2HQNBG4D1C85D6ZovRcW
         9eaHUaQDazKBrhrDVby00BffItOX76pg8jqW7OFkeQDupa6fAmekM9ov9GEsaRSHS8Yx
         bWD+CVf5n1tX+RD++3hIlC3QaNjPL5MUiOfLu98Da8puZoEpQakCwj1EHaJXehhWaW2r
         +Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753246675; x=1753851475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NepAH6k+tY4m1L6v0rtz6kWuAIA7DEfti3zsdAQIUXE=;
        b=v0MI45+qrYzRudAYumPbsfD2srmE1RIpGODdHGbVSq7cMuAK0uweGPeT8LVhoi0Ew7
         tJ0arEgtVkQQhNq8akyJOm85OokjiBMHh6gt7dr9cpHInm63xfI7YukEwW5cKgY1sHWC
         2ia6Ch+Dp8Ke3+Tbqgbj05wpeb0cRbBJFWhYlPVK80fsshaUcAEIHA6L92UdQKBx4DOY
         EU8zT2YMDcfuE6689vsdEmzXv9YQKFkubWiX4ud1CPOFg/VoPqxc6JoxlSC2vl+pGuqQ
         zFhjeYxrQ+wJEMSwEgLxHa2elnD/B5sA2JgKPe7+JWN5qVRBgy6ae/f3/qwcIGP7cbUA
         k3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUzecO7RJbhm7Lr3MBI28Xb/SLdgv1WzkkTA7pSP6BKeUqPqOdNBSKKdyQEekpuzgL+9oKKqLDO@vger.kernel.org, AJvYcCXgLByeEDx64piNBwWH6GCH/3GFlP089xDvXulCawOYvGz1ttQE2g+OrG48cbmqO6d9ecNwKaNTotAhQ8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR6RtF5qE49RB1uWfug+bY/jwM8ogucKGv81pUPLakQCOPok/
	xdKqdCYdQwAXipVmOIkCsXhW2BcCV6Yj72uHxqtnGdE8kROw2tMkPlc=
X-Gm-Gg: ASbGncs7lyBrQ4g2PV5gusamivcEUEJl0cXp5TihWMeknHKWbZQbdmFuiRZgwMpcLEt
	tNPYM89qXkjmGh+BvuVrO1Us/dKlvltxo+0EBtcW0uNjF1aelCIeZzEkqHst8B4MUrRzrSr+dPi
	xEjsu2zxaQ5A2a6WKCRMebZF5T1nFTL7O8dsrkvmGfPJpEA06ltZtPDzUT0D1Qc7BMo1+ywXdUu
	pjxLKJpVS+lzcEIU/OY4JpXLnv1ZqjvdXQqHIjlEa4PZp6Am1rD6otyUGYCQnW4XzUl0P6iYKom
	fpbb83Kxz97ceZj4qsz6hlVoVJJkENe9R8Gq5+1JTQQ5Bz+LJH+FArfv0dbkAlmj9Bi9ImDBJ2v
	HRAu2jIa76SB+OrKpTjk5RncNjR1hfDgl0gfJIYUyWuP6GmTcYKovhaXb5tN4ppzs819xvJ3JcH
	2b
X-Google-Smtp-Source: AGHT+IEyCVYFeTrjAkZbl5GbRRmSRJvoRd2ribReC5DlPosAv3MiatO5YKWwNATHBBKo9G6oh6sj4Q==
X-Received: by 2002:a05:600c:540e:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-4586af28accmr2697525e9.4.1753246674840;
        Tue, 22 Jul 2025 21:57:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7d3.dip0.t-ipconnect.de. [91.42.199.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45869198e23sm10119485e9.11.2025.07.22.21.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 21:57:54 -0700 (PDT)
Message-ID: <5b1b8297-7251-4e7d-84e7-e6102c712699@googlemail.com>
Date: Wed, 23 Jul 2025 06:57:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134328.384139905@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2025 um 15:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

