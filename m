Return-Path: <stable+bounces-92951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3239C7C47
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 20:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4759A284943
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7A205ABD;
	Wed, 13 Nov 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b5dDEu1R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D83762D0;
	Wed, 13 Nov 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526926; cv=none; b=enYOElS3RAFKTHtVh2CtHpuTzFrzZCDFcdcOOPbhljddo56bHkgmRF8+ghUWOAv7Sck98Tt0EY4thVYA4xyb9tATWindC7ohzzo/Km3oQ09ygobbcSvNKTJIKLdjmgQUnx+yapb0YA1VRixnjl59bCoqSE3XV7sVVEra58SfcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526926; c=relaxed/simple;
	bh=yHmG1OtNinzTcnLOZ9tejOhjbsi1Fq67AJDTmo540Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXZEBtTBnmvHTOack54kr3nFYVcwrMOiXXvB0RbequiYzfwGsEJztNEl1ekCRAfgc7phDLVimFvM1IVlRlqTIRwnoQd95TtEQ+qalZ4DgYBasB7XtBXS4bF2rAtlzxDPZ8UJRKbyLy3Se4GmatBQN1EekKXA/cIS22X+hOcKHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b5dDEu1R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4319399a411so69107515e9.2;
        Wed, 13 Nov 2024 11:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731526923; x=1732131723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4wpmF20MR2KddjSS6Im1oBMD87FhsDKqpdHQI+Tkr0=;
        b=b5dDEu1RoXD/ixEQloKUPFklBrqEmh983B6XGF96kTOxAuzelauDqoy1MCVnO2vR6p
         SIpdyz0yCI7t7L7XDY5gln0KZGq9k+WXoSEoVyR2av3V997n9D8A91obaCYMW4gFttff
         yeLMQGZrHrZp+KEoGqs+DP45Xw3J+z0c8LG5jh8lgig1XjAjs+rxIVHuCGjxOw3d8qUw
         FvepPUe9pG/I64WVni0wzvqDuen3zN2LM0J1pHIm4Pva4tUnBmDkvcl/E4ly8jSueFl2
         JGKcTrjn9GzjnL5VMNfGiKZmi8+1TUWpUdzmsn9dMVkH12UlZzU69Uv+hZz49TG5M6Mx
         bTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731526923; x=1732131723;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4wpmF20MR2KddjSS6Im1oBMD87FhsDKqpdHQI+Tkr0=;
        b=Xz+ucD4cJd5+6JXSSISIfuGc6K891MaIK0LBeR+g/BWeP+yJwv7tm96UDopZQQHenB
         GXsgewHdaQcbbAhfDoqBQx87T/o/Ykd2Vw5HX0vzICeE5PXOM/bWByjNLCwanmpq7vAj
         YM17pg1k5NvJ43PrDfGVjhupdFoqdHfMC6EumIwJgUxLoQSmu52GYBPunN1sfoSKtGrF
         rH8LQVZSpqSQDl19oLr9nwgIoqyfqA0ccCu2o4lVT0v2Nw+Y5jf6fHja2UlsCCgB6Fbn
         P2tMTf2XQs639E2sZWdKeKtLIudOmW+54H6SQc9BbnQtv/IP6Mp5wjiarA73BFSi9iXT
         w2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMvjomnpGxk3IjZJA/h915pPeqlRtQnF8WjZcfridhFGmDVcU2cSqCkeD9bxHC1lCDuYqBh3Tw@vger.kernel.org, AJvYcCV5g5954r9HoV6K77CsFwGW+0ft5WfAqo0HDoMa0n6Vdf5lWh5vISZBvFhY6wmenDKBdiX1Wwk7I8gZO78=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtxd73VU4atGFX4cmDxQCmoBAyRpMhkIzCJU2pqE9E8NWMrcnr
	lLHxy5EUIGDzLj9V6sIL5YmakKiUfM6xKbwi1aeKL7XMEJTF0zvAWmNFnow=
X-Google-Smtp-Source: AGHT+IGyHn5McXvwwiYWgD2DJtEreCfG2z9OYWU7CnUpmnWHSJzrw+dyowrVqUi1iMSvljrJrjQwrQ==
X-Received: by 2002:a05:600c:3b9e:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-432b74fcb02mr189251475e9.2.1731526923207;
        Wed, 13 Nov 2024 11:42:03 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4ca6.dip0.t-ipconnect.de. [91.43.76.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97db25sm19314617f8f.41.2024.11.13.11.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:42:02 -0800 (PST)
Message-ID: <da1ca0e0-1b1e-4c1a-adf0-e20d72b61962@googlemail.com>
Date: Wed, 13 Nov 2024 20:42:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241112101900.865487674@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.11.2024 um 11:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
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

