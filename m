Return-Path: <stable+bounces-61277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F993B101
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774861F21B9C
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCD6A039;
	Wed, 24 Jul 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JFYbrJkQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AE148FFA;
	Wed, 24 Jul 2024 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825048; cv=none; b=uVrEVmFpfmVokXAU+m5rKc+9jGALf8HJLJRlm3FPa+ByQ/hIAel54lr4oj4lRcqyZ6CHBbTc8aYz1k1anH/AnGuW9ZvF6nLwg8q0MOJD765unmjzC3mKy3luzz+BT35cZlfyAUArZ63xo80PMn8gkpkujZ0RtoabVZS+k5YuaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825048; c=relaxed/simple;
	bh=yv5/QFhFAPb65M4s7ugL3tGNyxlTw74LY9qjyiedrP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT5YHHTmx8Rq15tN1cC7ugVTQzSLURP0SeJjDXdcU1rSD9TSRg4iWJi9FkIGbFOhfU1JXCeLQrQlyiE1KJWf6wJmslS/Zc9cWP10FabG4ma62PkgPUEp3dU0fEidOTsC3VUGMNrInjQQqcPYbY3hbIxRVuAyalEDKaJudMFa9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JFYbrJkQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf989so5389236a12.0;
        Wed, 24 Jul 2024 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721825045; x=1722429845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljAWzXfJkg/wQZiKSeXe2JJNOkrb9s8c+erMRLk0VVk=;
        b=JFYbrJkQM9XAUFLWMUU1IztjQpGl3lyvX5Sf8hgRX8uUplL4WPE3nJqQ9F2QVvONh+
         fnJ5E5ylr35HZ58F+IFMH/vuQ2ZISZxKJGy5NqDuJKiy727fkHdfCcjs5Sx5xD6yYu0E
         7rccKG7VkbNG7/eQfFFqaMQqCneuhjlRRC6NvECnQvlvJBmhBDCcXcLryKj+bFBq/NgZ
         HJLAWikEkBh7aJSFCCNqfP/XbPPEkm1y+6F3ZT89yKFL9+f59yeCd2/TdqAC9yjElxVx
         nBlJOzajDRcRDvlwSAgymAVu3BZczZPWfYQkckJwXe8TEqR3AR2sdyHd0IGy7xq2fzNv
         hudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825045; x=1722429845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljAWzXfJkg/wQZiKSeXe2JJNOkrb9s8c+erMRLk0VVk=;
        b=pDlcuOA/euZiK3ni3ppIl4t8VXIzpGnkn6Q2PChnY1t0bHmj5FqkBNiiu+yB0WZhl0
         lVLEPfL5bdBHm1nkJSAkaZN3hBLEdg4iAcXDtEzzey7rBwkg6QG1Xl5inXYvbp4dGgEQ
         ew7EKmaJgeobxSBQydRutxxK6Lm6HdxCrJqjwUsU92WAMyr/3dSZoLxKhzHIyUC48AHL
         m9nSyNkvGx9dGrnN5F5RgaP1fTPn8Eo98xWoarGWOafq7K6bYDvp5kB05yX3JkIiZC5K
         2kUOCDdFqx82lBNssuQOqoOnBMEa1eYNRZlP+FDNUFiyVqWCR+qJ27Fm5Qf4yxeD26vs
         3fow==
X-Forwarded-Encrypted: i=1; AJvYcCUKe7pRUZgqOA5IlX8IQ9xTtvB1yc4+RL7vTDtHwY/yQKaP1na0TxJLOG7BNK+qKnnDqMR8MDhGQNrVhZyojGakA4fBi8/ZcjGLoVsaug5OlkHdITJPanlFEvIopOut4zq6Ztce
X-Gm-Message-State: AOJu0YwNwf8fJ2FJcRz4+RuhbcGb/5mHPTNG4yvNOSfzUTOmLYykWaYQ
	l6uJetilZA2hBTFK/8GS7m2rh9ejCq0QqmR3/XObHnsDkcPi11Y=
X-Google-Smtp-Source: AGHT+IFVd6T5XYoTUmgpbHhyW2avvsdaGGLt+mZ1T0qM4LuFCMsIW8oLboKrmG0yXmG1GTZOf9q/dA==
X-Received: by 2002:a50:cc97:0:b0:5a2:597:748e with SMTP id 4fb4d7f45d1cf-5aaec1608b7mr1359251a12.2.1721825045039;
        Wed, 24 Jul 2024 05:44:05 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b1e.dip0.t-ipconnect.de. [91.5.123.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d6c17sm8934583a12.5.2024.07.24.05.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 05:44:04 -0700 (PDT)
Message-ID: <42fcb54b-c50f-4a4f-8248-e0e4f8ebf539@googlemail.com>
Date: Wed, 24 Jul 2024 14:44:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/105] 6.1.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240723180402.490567226@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 23.07.2024 um 20:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.101 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

