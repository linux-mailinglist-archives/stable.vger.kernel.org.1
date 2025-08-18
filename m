Return-Path: <stable+bounces-171673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0FB2B477
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBEB3B60BC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A98527511E;
	Mon, 18 Aug 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CP8PALMH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F22727EE;
	Mon, 18 Aug 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558814; cv=none; b=ai2retZB+hTEIw541dTmk9Pue75WpNMe03l434SdLZ2awhJ8iFRKtfVFo+h8kgdv2mKEi5gGumgJmbF5qRhuI6W18vgG+2IYf2nAS8XJqrQ+iwBqf8/hNNFPMhe/LCQdgcSPRlTV8iE/G4K5trimJOTSonSsvFHnx3vJizDQfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558814; c=relaxed/simple;
	bh=c8HzGd/TDaCgrjaWIMeuTNCXcuACmbYECvWUUre4PIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UY+TYXUpYgbX1Z2HJovgqmBbFFw4vE+ijdf/587XbTfZ28KJP85Mep5Kthh0belhcSM65cPpfEoUYQx1yaOs0lgScm3ueojn1Wq0DnB3AV8snnx0h16TNvm8pvjRtxVhawW7SAsOiDVC4DRW0YTgeqx8LYKoE27O/j/BHosd2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CP8PALMH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso25825325e9.0;
        Mon, 18 Aug 2025 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755558811; x=1756163611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mnq9RhUyvZf92U8sAKjR3y1PDGecrVMkyD6LjbdWrCk=;
        b=CP8PALMHPATAiY7l84kAD2Gpf9AxFgT/yWLBSMx/OpW9P2sftKeI2K4Q0d/BlBHdqM
         NRA8Z6XPa/ZCtNa9IzBiQzgCfk8uqelU4zFhjcClJt3UB0ku2lZSFBM+OQZUhyWW5jwv
         KFDW6TCOTWt+gkaEOyam6kUw9dGZLSGZ6Mbkp7mk57pXKin8Z5cJ/vtdCdujRBcSJ6NZ
         sgoe1UzvHKV9C5KcT2RZEo/zxory8mJrhzNYjrnsUPS25fZy/dZRyW1YP2OwVSVZLQPB
         DNXSLhxR0OeS5DdPZ3InCUyITJwxLKUg9/tTtdo0a0hjVqdeg6siUnNwDE7iWw+bh0ET
         uVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558811; x=1756163611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mnq9RhUyvZf92U8sAKjR3y1PDGecrVMkyD6LjbdWrCk=;
        b=lXl6P0ZL8N3Hsz3VucDqHfV9QrH/xEbhZHBerP6EmIcNELwnND5Wq/W1za5miE7xx/
         6RalcN0eYNaqq4+Jr/A3a1wyGTwDqES8O36oeKem1DTFXun+rbfpNDOBKSSPyPYSAC4Q
         h2gWTBAYA5Zdpk24RkXP/JjGWpyL+bQGAIXmE9gk+bnNro2HhDaH9laAYRxM2dmgITj/
         YbghgCnMLEdMOXFodn+RicFYFdLGnO8tHE4CbxXRrhgAol7BU/BD4K4qZt6wamdOAnnH
         28trfB6SVg8O7+N7T05eNg3Eq+kYBDJeaZA3CFSbH2NkBIpPqj7tW19cbcQVt5VQQHQo
         UMww==
X-Forwarded-Encrypted: i=1; AJvYcCWl1hnlFBGs2XPYcb869ZRn7j4uf+hHSbcilmxXdAF7qTGxEkj3CuUQxl7W8dcjDE7PoQ94towQ8O9bMhs=@vger.kernel.org, AJvYcCXhaIAvvKA4kY9C10WxVT20/0hpaVN1fRrNAkUruG3tOUSR0WThdUCPhvyaeu2AoNPoivJew22J@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWyFTgI9xsxvqaXyLmj+q2RhsFd577o0jkDOlR1RnP3d8nb/1
	W6kNTkjG5K9zjIIv767fZOtAfK8XCuVgXkLIIw3bvXeg5cCzV77O3hY=
X-Gm-Gg: ASbGncvDab9d92Ann3oMsRc2d82jGOfz6NtkmJjdi0vYY2Brbplv1KqFSvg6lxYxRZu
	gYxwe2zMx1ffpFBkokLuIq3nsFP0/+bxke8AGEkRPdweAZLuhVDTJ4QUMK2pZYiS8PSyacISkz2
	2UulSjSn2jRIYSpg4NZeXkvxCFcJT2rMmFbGJvZWRogh446gxafNqab9+N1FnTfZppdk1L+lOGv
	Vgwr/97kW5G6AmHnnXK2PDf+mGJcE4ynW5Td/Ndjulr9K/JMcQIObH/dNJdj8EONwxcVNhmkrVb
	r6s45luFHe/BTgqIKbauIhzPkVAi64Zed7fYJLR5O7y79sN3zreTuN6L8/d4cojIMNLF9fdTPh5
	VjS1FimGK3pJRGvqomlvkl1EQg0E9G1Gy6ZHc7OOzsdbRvAICiELqV3cug+Nj1LGwtJ3U6IxT1Y
	o=
X-Google-Smtp-Source: AGHT+IFqtwFtg9Rad+LKYSBINL0XN0Q32hE+79dF5jl3tp+I1u2wZ1gYBLESupv7TuKefkG18KJrPg==
X-Received: by 2002:a05:600c:4587:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45b43dc654cmr2368665e9.12.1755558810606;
        Mon, 18 Aug 2025 16:13:30 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4eef.dip0.t-ipconnect.de. [91.43.78.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1708sm1169163f8f.38.2025.08.18.16.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:13:30 -0700 (PDT)
Message-ID: <cf35c5d9-643a-4dd5-bd1d-45cccb64de61@googlemail.com>
Date: Tue, 19 Aug 2025 01:13:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250818124448.879659024@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 18.08.2025 um 14:40 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
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

