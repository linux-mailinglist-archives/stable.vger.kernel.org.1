Return-Path: <stable+bounces-207930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C1D0CC78
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 02:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D7FA30390F6
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0A238C2F;
	Sat, 10 Jan 2026 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OOn61R7E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD323D2A3
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768010167; cv=none; b=dcF826sT4YNCW6bx7h1JZLBQ4d6JP1hvQq73tr+PRXpuDwpPnittzyrx0Qr9xHvLv97JF74Uu+n3xp7PNCRRUyCvtt1p7IacWQ2slsZu8bZogiff1+pZ3nzDgE+OQf6gxUZDU2hVbLgJ4SEqwU6GC23RsO8QqNjGduoDgISnbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768010167; c=relaxed/simple;
	bh=nQy2cuwmypa+b69obujZ0+wRP1b7i0hIN4QzgRWn5CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENFEvAXXq8nFd+tOhuYjgH1lpehQ5AoJUrBNvZmVE69POGAAL/pAoqe8oEVuTmElmyO8hhGw+TMH7uMmuYX4+f5uLkcKakHoz2Y9tGm6ROnSUayi1QpFRkP9Mm93CbZiStynfScz5vrTbO+W2/doatiwbgiDpH4/Es/Fn/68zWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OOn61R7E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so22478175e9.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 17:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768010164; x=1768614964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wr3TSbzzQ3sO/2vj/aJxD6AFf1BYqAOWr76MuklWpsk=;
        b=OOn61R7EnpfsiQQIexZP3jtBzghazPT8ApJ8zpjvrT/7YosRy06Vdx0DT3NnAHfMGg
         vqXekcFbzmqBwUQrrZB1gpCiCoKEreEdlKsJ+23sIVf1Zt9nD9TePdGAiPYOQAzimBsC
         GH1e1ywWfIOxXkfdXpQnNQwkSVixTjlYhzbQh9lD0ag2B1R3D7PTaefzmuFN2zqghDKB
         tPg91/f3YICALk50cMvY7s4SHDwrpN874b8U9DlTE2oswDgsXCsE4R0ftdC+nGQHH/01
         X053WI324ar2HCX/qKy1TjH1qaIq8IQxed5f/lV5h74A4a+VHKPiMy2U0pIZ7V1dIppY
         51+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768010164; x=1768614964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr3TSbzzQ3sO/2vj/aJxD6AFf1BYqAOWr76MuklWpsk=;
        b=jA78voZ823D9ygn+5CyEYN19MFTbv0kGGclhSPK0FIOXgrQaT2v75XagHy0GppC/it
         +wPMqk6AGKQskbTNE9aV3++q71WwYY9VY2PqcbCqpAYH1YwSNP8wQ3G4YnKfZ226AUtQ
         zifcczMIWoLMnizRxD9Ku38iOTS8sTqMC7BNjBFBZ5cjOC2OIBNrstVjx3Dj0Z8UaJMw
         CWQvOe/L9y18Yi4pjWS7vuFABNMplL9TtJLtZT0eSRSN8kKlhf6Ms8wEradO6JBA2ee/
         BzatVhFx5XV9fH/Uk2xNwxX6UKbxNl0Ea9BSUULOXG+clnXzdIfiRf5SIiQWr8q6hovJ
         HM+g==
X-Forwarded-Encrypted: i=1; AJvYcCXTJioiptZdcGStqGEEw4l+kgT9q9zNqnvtzieJ2GBpvfkEs3p/oORXqSZI+0aFdXw9DfpqRkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqxlptoy55nnyErqIsHHrXxlecl2jm0RHoJXsREQ2rlhIfuZTj
	gXf4KUWrMuc484Zgca9eG9JOOCcs/6YMw6TrVMFhGRrv0K+qL2h0SkM=
X-Gm-Gg: AY/fxX59yLTUnclwVif09sBiZf94Za9dAj9/9lmclqwx67fty4MzGinb0RTqo/CtLua
	iv8/Qxxv4+238smOPZW5z7N1fRmQgITjUZZMSILQf22jOBMM2KgOymp3Cc1niIae3RTbzEerm31
	cHsFYDv0VZiWfuoZbAAlaO5Y6zi2Pp4YtlVwA0yLN+WuRAjrWp/zCTFKEXBIqhZHwyT4U7laSi4
	93qvMqv1S7MCBUoqryhMMP+EFVDIK9e6Q1sIiUJJZvEku4TIv8cmfBTf9UszDKIYUfDNIF/gYt0
	cCFZOGsgDd68u1XNYRW9aOoW1C34nbcckWwSvetiidbvYG0pOyJHbbF8m+FqCgthlcCojbELDDn
	vf1s2yCg0IIvmBG/7ftzgsn1m1z/VwplZ5Fd5IJRiH8T3dsyP4wAaqnJye5YJ6uIX+7MwHi0iE1
	rUVEjDY7MucLwfgsokLlNIuHyu++kF/OePXRu5LbaE49qkXeNt65c97wDdRUJ2J0s=
X-Google-Smtp-Source: AGHT+IFgVzn6Ppzfyhfkj8hZOeoP9vd0MUZOe0iCaPDfN8YaVgfHlZgTh1+eXXKLW1MIhVDp0golNA==
X-Received: by 2002:a05:600c:4f53:b0:46e:506b:20c5 with SMTP id 5b1f17b1804b1-47d84b5b496mr115330625e9.26.1768010163897;
        Fri, 09 Jan 2026 17:56:03 -0800 (PST)
Received: from [192.168.1.3] (p5b0579b0.dip0.t-ipconnect.de. [91.5.121.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662ffaasm74461685e9.6.2026.01.09.17.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 17:56:03 -0800 (PST)
Message-ID: <42a730e0-42c2-4ec8-9953-bfe55b18085b@googlemail.com>
Date: Sat, 10 Jan 2026 02:56:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260109111950.344681501@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.2026 um 12:44 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
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

