Return-Path: <stable+bounces-113965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A180EA29BDB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CA13A69C7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2881214A9B;
	Wed,  5 Feb 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PU5XojhC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01546214A8E;
	Wed,  5 Feb 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790849; cv=none; b=YrLr2KvGaxEWWQqiPLiy6cU9E3eG9fIWRkzjHzLWhn0KBckI4ds4s2H1OCmJ671Ry0AkL45oghL99q8zV+na5elL2DsbDzVj8ua8EKm5bzfHgS5/osUtpZkw7+PfzhI1c6pYMY69M++OwgqVy3fOJ5DaEFI9w/hGbDPv2OtJKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790849; c=relaxed/simple;
	bh=QD9y9LQemVKTii90PFWUVbywYCREixrRCd8nLKIawr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fk9A6pco0nBFPhRrM0DTqM5shu2XUMK5FvfxEzv/xCpZXMErZSgyhof5VTlNwTTYh/NbDVEw3nRyxpjTIkIv4oztMRSMALrza3iG3oIEwBPfwH7bZwDI4wZYO2oFE0eJQJ/XRIFNaaZ7PGnJh6T7R04VkOL8yMVWzqWX2jj7A7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PU5XojhC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361c705434so1381525e9.3;
        Wed, 05 Feb 2025 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738790846; x=1739395646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rf2mZryoWttHMkV+6oJudmL5GwtECSwKDELUfw8XxI=;
        b=PU5XojhCk6/O2taM2+zB0RqJZBw07Tq/dxvnDk9mruscn+eSeRgwqKJF7C+nYtgqtU
         yQXfMTOyksZu/qbdn3xGnD1m5KWb6jBRpsVa+TJahq37j89tTr9ITKvDnrogM3Rq34Na
         agslRSZVzlys8SPSC3M0966040rftYoqn3N2+Hj4bcLGP9WW9SangoKkGB6VJPkNx2mp
         nXlkDX0kWxlm7nM8jwjwhYffGgRV9wpszAhXatlvRfX8rTfBr2aIdbt+sv8kTb30omSg
         42W+Jh0XODQqpRxwORCqpJqpANduvD09GrhO3vneXl1dpKuZZtpJp7r8X+AA/MfXn2/U
         rrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790846; x=1739395646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rf2mZryoWttHMkV+6oJudmL5GwtECSwKDELUfw8XxI=;
        b=s2k/fEI2c6keXLOXOMr3HPD6i5xfYS/ePR5AzFlUup4oWvkHUyHBj4+ZJ6dnJspdg3
         6j4yMuKBXbUExnB2k07l1MwD/+hBGrg2pTmz+kz3ebxB08b7WWS/+nqZ7VYTre2ZlMsR
         qyd2+pfU02h7xzVwxvU57t1HbsJt5V371wzMmG2dpdIXk4HIakk3pv4GV5hhLLCQS/Ed
         ygs43djDWtB+aal33+8vbC7q/ZsxUjOzvt1cS/OKbeFylDmvUZkSgx9SXJj1LakRR9KC
         imvIfyAgoWKzy1xgbzB+lDXS5JPyCbrDBiYBADn20P/aw4OA0ITjOyQzelaDqPsDJm+7
         M7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU4btGouwZFiVnUVzC+xJ3FIeXF9IB8T1+vIRy+soUpEMLT+dwkHd/SA+ZhUZVZnJD7qjp8pGC2@vger.kernel.org, AJvYcCXbD8xsZCluwuPm+KNVMbLRxBEX1r9EH1p4Dz+ptMbJPYLA6xF8YB3UxfPKt6BN324g2pXX4v4WfVUzO5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIAw0XFNTYcwCN3aVuTRtEofS6k2/O6ln67yroCFEzd9X5VpU
	BPJqswZ/qjjEEfqeg4d2QbsyromojKqNIWKIfj/+Ob5AgildVM4=
X-Gm-Gg: ASbGncslov3O7aXA7CzNLMJC4nLxo/fysjWRfQTdXjvmgjdc7tJs7I4wjTVJSEQ3DGb
	XrCTLyK3u4B4siZSgWRmrLMF0d9yu0OoBFyOMKWiW7XP5UrA40ewfz90Yqg2Fqj5dIEAYsiD2aH
	yGyb3dWCZFVwPIb6Il83Ignij3GgL5Z4Ol8BJD8xOri2wVaG7le8av8ziNXi9V4BrjxNMliL3pV
	Z6Ob9+j7tEKIzhkTOhq4+ZJL2XLngOK24QmmJTkDKjU0CRwocPAH63z56xbKPET2B2ey28HIu6P
	9JKMzJkZgX5ndZHrvAnsbOnsLKzAnCOBdC/3+kszkRUzrqlEHKqV3WPuAMEzTcHNX+HT
X-Google-Smtp-Source: AGHT+IFFQpAZLv7hW8UOdcGZ3nVzkW+8Tj96nnnPtvS+Rrjykn9y47soqVCJLvivO+CRYt2RCFFHRg==
X-Received: by 2002:a05:6000:1449:b0:38d:b107:d541 with SMTP id ffacd0b85a97d-38db491f553mr3458351f8f.37.1738790845944;
        Wed, 05 Feb 2025 13:27:25 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4bac.dip0.t-ipconnect.de. [91.43.75.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbb34ca6esm523806f8f.62.2025.02.05.13.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 13:27:25 -0800 (PST)
Message-ID: <163e78ec-5c5e-4b9c-8c93-44179f93268f@googlemail.com>
Date: Wed, 5 Feb 2025 22:27:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250205134456.221272033@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 05.02.2025 um 14:35 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 623 patches in this series, all will be posted as a response
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

