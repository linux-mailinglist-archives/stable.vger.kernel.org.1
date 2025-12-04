Return-Path: <stable+bounces-199962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A4CA2900
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 07:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FF7F3005683
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 06:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D52882BE;
	Thu,  4 Dec 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bhPSllaq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF162C027F
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764830870; cv=none; b=BJ6BT7J/wwrXeRwWsIFkFeJPuuiAFU3eF6Kq+OBytp4ZAVLf6xgH/6iyKHnXqYUvOM+jMBjNRnPHEuublYnzVmJUWprZcpgIWig9WrXhm4smCbYPFVzdIJt3ICAzP8Vn/q9PDylt0i38gd6FpmPFat/1idmwAwPHjD9rR82M03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764830870; c=relaxed/simple;
	bh=5TH8jSxgRBK0Mx4NU+4zrUT3lUcr1yryUkNy8igJ/qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYcdAD/Y6k9dH4dalzMKNx/lphMrdhU8IyRSFsUoX/gyihd0AhD8NnHw8M6YcNGUxmI3jf5+5mB7GbXYPk0rCqE7lJhmh+pwij1R9qoz8xVdncpMWxLB7vjd0L9dBndGiJr6/KltqMEL0eEsULksULCPvnB3q5r/XRtMooug+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bhPSllaq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47796a837c7so3798815e9.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 22:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1764830867; x=1765435667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdcU8Ukz/TGTW7HeVVp4M3/aeghpwjrkW7iKaooXt1g=;
        b=bhPSllaq21bJIOSBxdcWlqUPWBPMBYHfEBjyJsLTi1huBAjR+Czh70PFGmesOk4Ecx
         6Vi40Vm4fL/6I4pHYMnzqMjGtSW8XCPJUMgzDS82dI7NzdBRXU4OdINyN8/rkSAMinNN
         7GtTb+iW7Ql4fUsrlAN5t9KQ5TYY9Mnz5/M+WTsbKgSDFU2oXdcp5yql0e6GUSbhJW06
         7DJeRtYjDxuD/ktmY3kmCOVeZUb2yCi9+7kt0FuRg2+AHAy0JfSkeeqIvS4lRTgjNhCI
         Jhsr/lj3Npl12Xv892AcRP8h5c4I0YV9hY/2cdySIyT+k2bTdRDA+XWK9qmSKJM/FW4I
         9q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764830867; x=1765435667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdcU8Ukz/TGTW7HeVVp4M3/aeghpwjrkW7iKaooXt1g=;
        b=ckYhbbBP7qqIOQXFlf5R/0D0sLeoqGbg7449b705RfM/Fv/+SIGWDaXedzyZpldz3P
         P27JadqdK8DXMmJU4F/RPzKIeS+8iY66cO3ljL0I2XtFyvx6f4ErSME3fp9wB0agALx+
         EEHvvjA04DmVB8M3xzoDlm7cDsiENeyrCVPdH3SNN+fnvKqJSgqSoCEadW8aB3hrC/Rq
         LHJcmIZV1/oMRIEEkvNxEY9slr6HdC3S8i0x0SnXvqZmPm/dxoNAM0EnNX4KugfZH0LT
         ko9iSqQnl4n7/QWeYg5qf7Uo+9UIzje11eonWO14C+3b0WPibFbU6N5PT6hyJ6DWMGOV
         951g==
X-Forwarded-Encrypted: i=1; AJvYcCX7/HIoAO98J6g2kJFF/3OiHGYiVOjx/+YUzT3RnkSRGXFOoiU0WAZJkgA2dPa95QetvPo6UoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/3JJagmD/GDX7khpi301Tv/MMiRkpylFv3SiRbEeBM101bPr
	EBmjmA7mTv/28ryIxx/b3K+xlrnEeXxGrI+PKlxt03Xe7DfS1Uv7TDI=
X-Gm-Gg: ASbGnctI46wApH46o4kCYHeZrrWDpqmKWJCZNwPhyqa+okeuCl3uJAlklOc2/jOS/Dc
	02zI3yuLXSZksWOPoQkqCGiXfDRaUv7QZus9iwXChbmr9TpISRCvKMMfuBKAJz23EeBfDr1Rc0O
	M6x3UidjAtHoqbPiWGuEfKytItqff0Dx8e81veRF2cP2v6k3AbDTejQi26yGKZBUX/HuAhqEZ10
	uWJbJEr3yJy+RL64wc4C2hKOa5HrR89XvGecqo3cBgbxP6qrJLJ+2OwQXei54U/Ty3tTmNJ49aW
	xJUubn5mk3bJbyqMYOoDhC6dr/YZOOcoxDEDyUT3R90n/ICvP0E1oxLclcSVL1Q2Q8+P9E+Z+VV
	excBHJTJp+h14h7nMl0uSi6F6Chj4k3UOAiMSZuEemZV4lwUxF701OVF4Fzs8UjBiNs5oq0DKlt
	Bv3r3zUa+Dster1tOL3+KS3jSdvG3Yd0S6xV/YpmGElSjb8litelEObuzUenkoAmA+
X-Google-Smtp-Source: AGHT+IGG/8T5jNcj/rl93miCheVqoRkg7y2S7lTb3oL9kLEJt+kpGHnDxsLtXY4t2LVXrkLJLEG0KQ==
X-Received: by 2002:a05:600c:3513:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4792aee39a1mr44542175e9.6.1764830866832;
        Wed, 03 Dec 2025 22:47:46 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac6aa.dip0.t-ipconnect.de. [91.42.198.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4793093a9dcsm17206015e9.7.2025.12.03.22.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 22:47:46 -0800 (PST)
Message-ID: <efd5a144-21eb-484a-b0f9-9d0d46f68652@googlemail.com>
Date: Thu, 4 Dec 2025 07:47:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 00/93] 6.6.119-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152336.494201426@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.12.2025 um 16:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.119 release.
> There are 93 patches in this series, all will be posted as a response
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

