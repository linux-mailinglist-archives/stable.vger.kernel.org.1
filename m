Return-Path: <stable+bounces-187799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12416BEC599
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 04:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E36319A5B95
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9C24C076;
	Sat, 18 Oct 2025 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gOOOjBIU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B9248F7F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755389; cv=none; b=XaZkjenkGjTT6MNRcgP/BruSUz3H9yixx3UVNml40tqlr6kTwoclwQAvYB0RZeAA01uB212l3M3XW7bshQe7VifoRglgi/KQk1J8oA5KGgeSeDz5V205TyHWCVkZSzM9rl5PLsF+zSjTR4woXSQo9LyNmGTG3E6ExcxAWdMF9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755389; c=relaxed/simple;
	bh=+b2DvE7xTQ+YplYhEJssLncHPzlO3qrdo1+/WrFFXQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEnlYg074BKCSnc9SJsGxgAMCar7eZpKVn0uMt4J5PEuYEGFH0c8K0Yz8bPkmbCSfYtxyTz4Jq2jQt5XnnAnG+/VGxVPwL7q68VTWq2BNqe4GPqNO0WIgunaigV5Jwu+ePzSqBZDfpsCVZO+nZ+H8Wv5fsW5oHEbxBwrztTs5ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gOOOjBIU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47103b6058fso18381825e9.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760755385; x=1761360185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KedOym6ANAjmntB6MdnT69wUxSKMRmT+YO6XJ5I6B+A=;
        b=gOOOjBIUkUvo1jjrvQixoM7SbqU7Brmhj41vhBGQ+h0ES/WIdLtKTScDalZ5c+M1tR
         gaAwrCLrMeIAlzpizY4Y7C2sI8pKQ84pDnHocv6wE/bB0kdKVZRxa7Iuiky22lFdhaaz
         ZTLK62LWDSbjqfnIHYWiFtSoxJQ2BzEDASGwAL71i7NkKBgDS58GRU7JpcWgWjvr4aoo
         k5ife4MRT6BPjs/hn9WwzCxjp89w4hZGE5j0ok/4PtlrMegT69Z+4bDUX3KxreMXmgJp
         SbPHe1n8J+AIj/XuiTYKrWX+MUKQuz0qhQsoYxyAObOfvl1dD3t0nHXhJGxq7sgCZito
         RFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760755385; x=1761360185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KedOym6ANAjmntB6MdnT69wUxSKMRmT+YO6XJ5I6B+A=;
        b=EEFhiAuIneXDR0O/F10a6micb0qSp1KYJXwEHwrpF9AzWWL1BxC8g1WCRg7FWQx8VE
         sJWZV4qyjWWTZ5UE/U5c9YRbvn5skIEzN+y6g0kI2Moc4t6Gdw7m2SYUe7p97oSIefhs
         /KJ3MvXI7Ko4hL06QuAt1LCESYTSNHjPLotTCEYB176vmboEkojR2U5iOWMJR4GPQEDQ
         LAl9Zyz5ce6Qq30SrXYi8nK58QgZXEnBrcJi8Ii7o7uOrYtAm6VZB4taXZntAE6KEm0p
         nH7sEdnY5AjsGamXb+2KykvyGiWb3AvSHt8w7oOjOSh2XBToPs2dnvwyNzrLFF7TyfyC
         w+9g==
X-Forwarded-Encrypted: i=1; AJvYcCVaLpmW3TLmJg5mfeeI1PhQ/UYg8XP8fEVO72zygpTwFAeqzvuNqu/2wWbwXk2H3XUTZTSN4Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6CsfAh112gI96ozcnk63PCvqmL1jhyJ2jgGeoUK1ElAkMhBu
	O1mWSKLvPJi7iqsEjdTgYhwp9eL6PiC2eXnYGkiL6MTMTvoNBl+PdQM=
X-Gm-Gg: ASbGncs2VLvlbBNh/hMJOhYDDRP/RHTdT3oXEfI8GEQqZVuIrbqD7FCTdwTJkvcptBY
	C4xQfkSfQH7sbwlxf56IyjL4aZKNUrZnOg4q+TjXKRsLbuW1HHrXzBMSduN3W7kC/q0gvsCuoN8
	NZ8/bCAhILfxaPDIyJDZtOZfmpgHPwsoUkdiMKHWpF1Cv8gqUyg6HITjnnPuw9h1y9hlMzgr3pg
	LjwcQYY1Le6rS3zdpiVuUJ7BIkg/Pxe6zCWjUMRa5JsZKwDAhiPbGl3Ar2DInzOCBh5Uci3JX7U
	QdBE+Pc9DP3hMCnWNCr2S4hSOco2D8moe5fkpTwj1MHhH95hYKfVxYCaL8D2o7AT/Ew0jC9W+os
	gDqCzRt2jIrRxhjP/WOM7ML0jZ5u8/SLuLcfZ2BjNhueDqAiU/79pFD/6NDVvIaQf26sRFYAi3N
	7jtXTabW2QDawdQYeBj+JL3MxtEgOh1HPGxuGDaXZrwgEmNEMbY4lv
X-Google-Smtp-Source: AGHT+IHJCQEarLyt9R2soYu4NGJRlr1qtMl+VxBgaRp4vpWrXNohBal3V0rIJ/WL73KWrYBnM8te3g==
X-Received: by 2002:a05:600c:190f:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-4711721a479mr46610845e9.4.1760755384377;
        Fri, 17 Oct 2025 19:43:04 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b488a.dip0.t-ipconnect.de. [91.43.72.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm21954375e9.4.2025.10.17.19.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 19:43:04 -0700 (PDT)
Message-ID: <8cc5cdfa-e25a-492f-a75d-38fa14961ebd@googlemail.com>
Date: Sat, 18 Oct 2025 04:43:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145134.710337454@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.2025 um 16:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
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

