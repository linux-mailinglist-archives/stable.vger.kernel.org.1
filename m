Return-Path: <stable+bounces-199959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14BCA2713
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 07:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D978303C9D0
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 06:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F062F999F;
	Thu,  4 Dec 2025 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NMU4Z6yN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481030216F
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764827998; cv=none; b=iFOKZ5vxuIDRzpUnvYOL3ECwQ/NDh64qUXYDWImILLdHPd6t0tJGJXPoXxF+9lANRX8Jt6D4SPgvBKZFvfYBvmxxF0nSS7NSBUh4TFqmTD0v06Aybk5H6M1wRF9UAgKbK+hjM4T6BrZSt8h7306BXxz8kHGsBlmwkpWVg3dgE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764827998; c=relaxed/simple;
	bh=72hvBrbG4zzHEnzsLBUiKxK6ye8DrkxZH38BILJu58I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW6Nen7ViVzFxqahHzr8Jqbh3am+9lbw9sOAGVvUVhi9vQMUNbKEm+jI+V52Dn0EK2x0MwJmDTRmHz0UJUIOSO4HsdeWX1Sy+ioEhvAD2QRwB/lYp1lthOaDt0ewTYpRlqdoi2qTKX5zkIpiyRwqxW3uAvGm22M2rKs+mtjmFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NMU4Z6yN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2e167067so241448f8f.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 21:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764827995; x=1765432795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgS/O6/Sl8IAMxGl+9k2XWQCGd5oRGPkIOX63aTsOEk=;
        b=NMU4Z6yNBxwu2Zsb9drE+gVWV026bjT1jGMVfacpOY1YjlY+aZO/16Bpw7gHBZLEuv
         fpKHHhdRyC9iovfL4pN9eFQZUmYG/0EC5GGqBaYuRKvuGAbnV9gWfNQKuvjERcVzwNRd
         4I9Fe67b89lPE/12WHY5lN1Rb+WqeEaMmoJMKNNGzNlHkiDVAhAyN3mr+xw3xSGYJeBb
         vOQi9Vv9no0N1fyigKbuXZmd2NLbom61Ir/wMy+iCm0BRufepyJWjKOiGDJMzkn3ceU6
         +wX5iBEKCElDW1if/WJTcfsYLMlF/kseUGkAN1d+TnabfWOfFv+csQtF0GjYX2Sn1Jcb
         ti5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764827995; x=1765432795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgS/O6/Sl8IAMxGl+9k2XWQCGd5oRGPkIOX63aTsOEk=;
        b=UMuZqG2xKjtoKoLkaYEyu8FUhfHucxkqfOgtICsadvvyYC3winXVgn1zZ1+k1PS0wl
         7aJSzJpfXqPWXTmgtHIYq+XzM9Zbk+wt0Mxd7u0jCqfMMnf39iDsdjMir0bDLfRW+8hl
         81TBCA6KuZIf/ilcQzInk/SzrvWOKZydFv1UzS95yNTCika5wThbtB42E9p6UQLWhepG
         Yosv1dugoftIgzLRDUILpgQ+wbQNBglCuqm61TtyHypoHAoqdWM13fqbkViZMWcIzs75
         y7fqL6nLDvztsBIkioCI9HI30Gz6lW8KlCRzMlo9BqqBbR/ESJetf5ZX3/jl0RKEzjzf
         wm/A==
X-Forwarded-Encrypted: i=1; AJvYcCWeF2HA0krAWlgSVSosnRKQsaG4iuMsqg1mW3YXSIx6hUrJg5mmsH3gQV2UyVpSSDMx2tkeGxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIEsFl4w+lXzBrXMOpWxjs6RZoU8Whmw2b+bmOlUvR6LlnnhK
	zKJMijQjDX6HZUEo3OD6m1rsP8rwEwD/NlIYZZC/6rfABufgAqvDjnQ=
X-Gm-Gg: ASbGncvRtIpELKSd2BJg4XGbJMPY18jkHcBHK/JSwNlmVuR5KZsAUrOZGeXNlC9aJWW
	4WzHUPmA1oK3Ky+c8xE5h0jpcoTCnOInoepmymLN1iAZHgRqeQ3Jd59klydKFHHz83xiYFuNNVv
	KnG4KmiRXe2Vxot+wn3kHNhTeosQUVngkaOPtSqx0N5U3SM63w7Qo6gx2u+Nsl/DvORWJUsVTKa
	+7xwxE4VqkX5iONzW4oV1H4AIjNI3P3nKLsvSLCtNFQ0szcEYNqLGxEQiHdB2RnSdt6a5JbzAs+
	ez6OqkYAhYBFMxP7n4HZV3vjXhXPhOPRllymhRicVC5xvUMeIhR3VpdpNMvNjnG28AGWqxhmdRl
	PCCdGiP1hBjX7LUqIJ4eLVLyCs8GljrzLnVKbXjFUWZZ6EdIJmykfqPmzvB5O9eYQMdbUEjQuzz
	KU1OB3sb78ZF3Gns2v36HdcHb+ykFLPYSuIE0c7V9pb3NT8J9gpzY7nH8cQEL5YLLdxezuAyjPv
	FY=
X-Google-Smtp-Source: AGHT+IH9D+k1SnCVN25YpRn4b/dyEdDyhiW6KnqgmakDVpUUwqiq+qosJE/0arN9UTx1Lm+BXs4wFw==
X-Received: by 2002:a05:6000:2013:b0:42b:3246:1681 with SMTP id ffacd0b85a97d-42f7317d5b9mr4900772f8f.18.1764827995335;
        Wed, 03 Dec 2025 21:59:55 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac6aa.dip0.t-ipconnect.de. [91.42.198.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeb38sm1199930f8f.12.2025.12.03.21.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 21:59:54 -0800 (PST)
Message-ID: <cc2b0762-0dd7-48fa-9630-8bb895cf9ca7@googlemail.com>
Date: Thu, 4 Dec 2025 06:59:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/568] 6.1.159-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152440.645416925@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2025 um 16:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 568 patches in this series, all will be posted as a response
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

