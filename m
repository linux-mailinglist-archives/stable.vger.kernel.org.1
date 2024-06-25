Return-Path: <stable+bounces-55782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838F916D8E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497791F26674
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30D16FF59;
	Tue, 25 Jun 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P/OsXJkW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5B156654;
	Tue, 25 Jun 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330884; cv=none; b=A5aTlR9lSrLkc/EtnPtVZHUu9uvdTHLc3VjpPBgELFmibFgSo/azUysxR1Z5qU0Kl1dEYby4kZeswUfj2M7hthXQIYqlhbu+N0Ki2zEXlrtwvYE2PP7gaif1rc9VAaldOy5JxBu6/vlNVqWzQ9Dt2ia2FzI2sq8jcNM+Ary1Sgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330884; c=relaxed/simple;
	bh=2mrnQG55tRd27uQwnYDRLuqaqJEbguYvDL9A1PzdlV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzOa7h+3vAR1VUm50U08yvR5BlXFIQBEfhQoFEajQnjM0LMoKaaO/fg4mWrnDu2wvfBgB8dxTojApNcJSNw6hlD41MTQ/C/eIZSYa1kr270Nvn2HB/hSaA5bEObFJHOrwplqbDj5enveGdmcCT0uypFBMPXQP6doV6v2sVWS7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P/OsXJkW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b9b34b0so311812066b.1;
        Tue, 25 Jun 2024 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719330882; x=1719935682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJp76l/aLyzw9yrEVieG2Btqr7vRxW9tKrTvw/WqX7o=;
        b=P/OsXJkW0o7T2z46yJLIxS/ash42JMKk3tbvmtjnNn0eY9xieSVKhmJNwDzvajX3tT
         aDUo4kodpgWOoBZGoTMB1jQSRx0q+CJQ2kCnvrQuozLpERzS5Uyh1tMqQy9tkbs2UMiv
         1gFKpYRqDeiwkpKwuC8hKIXg8Kk7MHTY84yu7ATmj+KkLDaw52CI6JL9Rzk81NgEYKyt
         tTlCA4pKTFf+VpaCgVIPIRyOzCu2EII31rgxvtMeoRru8rLTKrf1ul9IgnKZWSnjjEOf
         y1biCMbOZ3F9vkfm0f5eMwpU29+RYB7xZ4HP92+w13CPa2qiWFSHAYsVeeSDHXUcpvVK
         +n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330882; x=1719935682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJp76l/aLyzw9yrEVieG2Btqr7vRxW9tKrTvw/WqX7o=;
        b=VtKyXpoBGHPvTCgoX+4PIu6W02Ic0pMKTqq6pQC0WN3wCW5K3qBhKojrvGhbK/Kyf5
         bUiBL+c64D5OBBsPfM11tGuu4cb1r34nWwPzi7BTKQoO27ZHD9CiA4flEL4okJCeSzOj
         AgSA0vXqFbOrkY7ETmgB/ikVmItv3Y8X+GybI4aiyJ0Rp6gNBdVZWlKN7FR/uXenfYut
         6YkwNg/W6FEsjbQl5Z6hK1yLYQeGRgbYo9PB5GgpcuW3Cq/ZHAAxtBqSJ3JaWMXVhvyU
         PjAJrIX+fSesv7fPu+DsP2i8omC+GQ8vCVBL9QnpA3wz3nT06WHvztmBhOv80eqlsO1v
         H+4w==
X-Forwarded-Encrypted: i=1; AJvYcCWWRkcOtEhp2g80aiIAftkLErIgjaTawzgH7qQI6+S3ZDO7RTaN9Mwxva4pS+KpnxE/c3EjQJtlwVkjKzqvpp+GpOmfZUtIlNsjyriqQNTtLrzHgyHALD8mK6r1QlmdhSDuGP5K
X-Gm-Message-State: AOJu0YwNCumkewcjDe5V+DWzjSKhe0JhnQmrZn2uxQu1kpinDZg0HLZf
	uKF4ZUxzvgp+kXZuz+TJIF9lE8RoArLlHP4iVonOnN4XiBRDeKc=
X-Google-Smtp-Source: AGHT+IFjq3eJARwUpHREloE8MuQxh1+u85uWLkDkjlu2n5TxUxT6jYFbku3UVeV9wbUvWfgTzF8Kew==
X-Received: by 2002:a17:906:2690:b0:a6f:e19:6fb2 with SMTP id a640c23a62f3a-a7245b93368mr483072666b.29.1719330880241;
        Tue, 25 Jun 2024 08:54:40 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4a32.dip0.t-ipconnect.de. [91.43.74.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725459233csm226716866b.96.2024.06.25.08.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:54:39 -0700 (PDT)
Message-ID: <21054231-fc6c-4382-a66e-901327f66374@googlemail.com>
Date: Tue, 25 Jun 2024 17:54:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085525.931079317@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.2024 um 11:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

No regressions on my 2-socket Ivy Bridge Xeon E5-2697 v2 machine. Builds, boots, works, 
nothing odd in dmesg output.

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

