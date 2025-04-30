Return-Path: <stable+bounces-139085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E46EAA40B8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 03:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF74F463FFE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690E1339A4;
	Wed, 30 Apr 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vokt6mxF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137822DC77B;
	Wed, 30 Apr 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745978202; cv=none; b=tleoyKCLJ3znkwOLAEB2nvu+s0TTZpk2o8Yrw9NnvgW7sV38VqR4oX8egSFVJuiscJL4HV64IvIE15LF3dTjDNU7Xetuhzy5u85LyjViGvEg0kelXx4awOCo06Tg2i+eRPp6iIEqRIXWcXGYuKrlozCHRYzqcGT+EVqk2Fk4qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745978202; c=relaxed/simple;
	bh=+KfHjPK5yIR7Je8kKXT7ZbpVESHoHpgIj07gDqmJzUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXr8V7QoccyBPu/7jP3REWH8bhMZbTS26iPkPdSpePlgl+rK4j/vFvfryh8OSt0KJalcz9btPnFon81u+0XXHswzKeDrdPX5iwmyvsTrO6t1R/YuHv6jhyxLa9ObL78sBTclzBXRIGbN9uWqLw4lF2zEcwEeHsZo3RaOfU6n/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vokt6mxF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso47634965e9.1;
        Tue, 29 Apr 2025 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1745978199; x=1746582999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpsYOY6/z+Z1DTeFAke43VvZPd6wkIifXztjpmPpqaM=;
        b=Vokt6mxFT4hTZOh32wfuZxU7jr1G3SbjESUkcBsJVqlwTo27c1qUkf6+z9Yw04MDad
         qIvybT9M4JO7yRVs53tSfbau3zHn6k2JKvniwuH2KRkDyWFhLwJ97XH5xxCwoRaK5sGu
         X5j2AlpsZKQJ6LeN1MpgmBaeKJ8yXDlyYW5e+YzLsyKGo7YRYzG0f9hpdttAwZm02o5q
         OA+uQtwKiAfo0MPShQ7/ofTMP1m3FuZ2LNgHX4kdkJbEXaTlTGKTidJBJf/Cqb5Fs2jS
         IioqCgx30xLScJPVC5EXT5B26aIVR8lZRCirEzgYa0OPy202Fnj24ZXj8Sy3gID9LDNf
         qwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745978199; x=1746582999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpsYOY6/z+Z1DTeFAke43VvZPd6wkIifXztjpmPpqaM=;
        b=Nt3o4HnNascNori8Z+C5MFya84/T8lWRKAgiqcR+OO0CTzexMAVQdu05jpWpYkHmzQ
         CD6pqpM/U/HTSSuAHYJ+Qfz+XZSVeBsMq7MjSFsfp9DrVIqkSaRuNRYGd3cews6nfmHm
         7iJSGOMZtDxT5GHbuujOd7HzIKDSmqEzRb6ZF3wQSaS2P99AlkUn6pe81JJ7rJhjm4LC
         ou3ruzl9UGc7rFITlxjh0fuWmaCkD5JIV7kN+LubhqlLoeuAuO/j/M7NtVM0KQxCc0M4
         5uFLbVsiAxJL/ma8izqTitVR5d20yC34Pfgec01hg7BfENQZ3b3V2toqxkTDwkXpiV4g
         BHmg==
X-Forwarded-Encrypted: i=1; AJvYcCWc7i8+z5pXaWMxYomAvmd+xCN2FaNVn4BrKWAIt/YrooNEP7HS076NfhbPwCXzml7Sjh5NzWsp@vger.kernel.org, AJvYcCWlNQ7t14/Hus56GLtls01dcaHTDeclIGaHBFyMRQnBWD2C2vAtLwPzdbGDp9Hyd0CKxvgA4EHPzz57mRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBF4TTNlc1yqmQSYTcbTkpR86FCdIkOSpaFOM0RIAGWOyqr+8
	/PnuY6VhYSQE+Yjm4bcXhCcK6fGRYE7N66A2oh6mCdoYL5KLPZs=
X-Gm-Gg: ASbGncvMyYzkkOLJd/XemZBevx1KWO4ZNx/kidd/9CWB8R2nzeLnYvhflgC/38CV5xz
	qh0kHGFhl/F9KTLdwvNaVV00HLjMOcFO1IF+tMTBkVueHFXjGMTAbrFXkV3RCqsp8/R6JoLjs5w
	bg8p8jkZuVnJAyZbwN1acXv4WlnDb1jnXS9/5AF38Q5242vRNxa90FLDOj63VE6+E6vL2673K74
	9Y8J8Smmdhuflhj2sylm0XQYaj7+bJNYEGctgdKmFfkNtBHS78fkx6dKADZkLkE363xZo9tk0Xy
	t7IgoKF2sJ/P+FpXK9FQD31+K5etRQOKFlFF5L7Rw8kHVrb0sV1qmvo3fbXAvy7aYr/rfG96jQb
	SKegXdTA39RkloNPzYsg=
X-Google-Smtp-Source: AGHT+IG2NrJCRDLN9FWQaP9OFYSF4SIsI76/UxFWwjgAlCOpjR+ekqLFJ/p8Fv/eZLk1OIzUutk6OA==
X-Received: by 2002:a05:600c:1f11:b0:440:6a1a:d8a0 with SMTP id 5b1f17b1804b1-441b2634d64mr5263105e9.7.1745978199061;
        Tue, 29 Apr 2025 18:56:39 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac6c7.dip0.t-ipconnect.de. [91.42.198.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecc89sm6717535e9.9.2025.04.29.18.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 18:56:38 -0700 (PDT)
Message-ID: <f3247312-d88e-4075-b27f-9c73998b82b0@googlemail.com>
Date: Wed, 30 Apr 2025 03:56:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161115.008747050@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.04.2025 um 18:39 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
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

