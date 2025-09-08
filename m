Return-Path: <stable+bounces-178898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E1B48CBB
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A303BF352
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FA2EFD86;
	Mon,  8 Sep 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nNixvJgZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3B1EE033;
	Mon,  8 Sep 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332913; cv=none; b=rvLDj29pU2Yn23hIeTTH4attaTXXjzNe/KZsBQdzFHJsHAfqzhI7pCVnknnAS+ti6e2uh9q0vpdVRlTX61xmODIq1cBe9xGFfwKrYuXmHbWRSthNd/u23beArrrtdvNaLZJ3sQdra7/I9KxVdOUmF6CMcsTwJ5jAq28HE6v9jMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332913; c=relaxed/simple;
	bh=3az1bFP31PmXKgodlWrJN4R7NnWbITfEuKRWNUsgvhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PE4M0tY8SZTO5BO3sGARY7QraN0GfcEEmv7GW4049SG6qS1ieTT0ueGutP7suijyI822Lf5dvH4OAwggSWxOyi3NqPhwfNITktll+PXjXFgAjjv82/bR7YEdmtppow1Co8rPnXzEP7okURtsDNqdfo2DJK2DY0sRi9EqU0Gpscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nNixvJgZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so28565915e9.3;
        Mon, 08 Sep 2025 05:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757332910; x=1757937710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abO2E4antkIr+F9McKxk3C1DePF1URlorKr+lqTP9uc=;
        b=nNixvJgZIisD2PkHJprU0Oh3DoMUX+lAog1eKNJ/tIYnyteSn32Xzz+scLrXi/6kYy
         PmhBHl0dEas+MBcd3E0wxVtmPFOSC/uQ3UsBZH4dqLhOpx/kNjoTPm6qcP6ujKcItGN/
         YMAA8mE8QLSujevC48e76EOleUGcwZXWPl1a/06gxGfWAOqxxDuZ8hIZ82muEA+NV77u
         pV3PWXUYzyMa+BsAdjm5Mqjz7xIDoCpmMACdp7357xn7bNWMgVQf6VhZVKNdCcK9GloP
         Jy0hGseSRQx/73jvTEHPV/QW7ptqFRsrltCCQEe4sEVHy7Ct0OaJcvQII+lr9vQwuD4w
         PUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757332910; x=1757937710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abO2E4antkIr+F9McKxk3C1DePF1URlorKr+lqTP9uc=;
        b=RGF0wG/V6U9JvTpOgogFYhCgfB2RXqIIhoOLtWZES/l+gvoG0j32YjBAl3WSS+Lbj9
         Pa52IH4BZ8oBXQ1InmwoMoYmMCA9bHPFODVxBbWO8RAFF37CZ9xBOgO7vBGZRMfcjCl8
         JlSCf9OvMLiLxm117vqCka9Xc5ltKSNaf7r+r/vcJrwBYWHBkUpowf2x9Z11HDgGRSzT
         ZzuuQnKQAGypJRj+bXZGKjguI9liUFrVmsBaQrOg4sApUjgSuutNv/kYf1nh5kUGLOaL
         OThUJdxIX2eEoTyPXNojuiAPy9lT+3OpYLc60gqyQ7xxqsqWYN3yCNZvMhMHZe2MLceC
         Dm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5CKo2tv81PS9natUCPbhN6ukVw6ZYHwtbUpk27QO58BeWS0y3ybN4ZOcG03p5vFZaA49tGMywIMbD/H4=@vger.kernel.org, AJvYcCWZLjBhOs8y7Gys+ze/YeEbqIQc3T3a43OyxgEOktjJL0M4KzzKE6ue3jEdBOQjA1gwLZdfh2ZW@vger.kernel.org
X-Gm-Message-State: AOJu0YyxE6qmdRUc0hcuRrefZxdEWykSsFFzjTJKNAOakJT5085bbkn+
	ogcUJXiTSH0pehUKE5rDtOpPhzwth4FK8QkKyqrEBSChL3Erv5isMZU=
X-Gm-Gg: ASbGncsF+1SdRPSj7IK4FkN2dOboNQCIGN+CFkSh9Gn3ZrrIZJVPgozw+6nuILzrHgw
	AkeLPXTRzuxE/Ku6VxtabMN3PPhVgFbqiznxXMX6psLo9Mfard9MbjnGnxKfzjf3xZI+a+fxkzH
	wyTFyjF8upQUugG/rvrMlOWdOaJU5ByKEwjygfkmM1si25XcbDHjmIGmCMsoiPwFM7iTFw55332
	+WUrGJB/naY/DHjXpzm56lXTiFIJ6aFQW9znDjZEjc0I5U2hTLQkHYrzt3feBCzymAnEJfta5U2
	GyqF4/DEP+VaKji9nrZRXZPMf/qmJEd0zfwaEAa0pdOHkGN0g/Amzmy7nPjBimE5sqH23iVtxj9
	EA+rNDL8BN1KMOwZtKPjOg1hjRSBBk8gvFrn4CIseh+re37SyxrHsBHSOGp+iFhKw58PyHnJo9J
	a42bmOYwi6Og==
X-Google-Smtp-Source: AGHT+IEvFwbaErkvEQ7nTpClR8R3mKOcdV2H4BXfSyWktuAsA5jjbG6BjNElzDZa4f2vafytVtj+6w==
X-Received: by 2002:a05:600c:1ca0:b0:45b:8352:4475 with SMTP id 5b1f17b1804b1-45dddf02148mr70641025e9.36.1757332909051;
        Mon, 08 Sep 2025 05:01:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac262.dip0.t-ipconnect.de. [91.42.194.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcff67787sm191651675e9.16.2025.09.08.05.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:01:48 -0700 (PDT)
Message-ID: <9d9a8d72-fe59-45aa-8336-f662db7fdc2c@googlemail.com>
Date: Mon, 8 Sep 2025 14:01:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/121] 6.6.105-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195609.817339617@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.09.2025 um 21:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.105 release.
> There are 121 patches in this series, all will be posted as a response
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

