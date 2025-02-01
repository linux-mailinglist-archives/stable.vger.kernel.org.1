Return-Path: <stable+bounces-111884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A4A24962
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3029B165ED8
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A51B4135;
	Sat,  1 Feb 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P8Mu6qFe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206DD1990CD;
	Sat,  1 Feb 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738416575; cv=none; b=lxrEL/wRvLfOI85ICs/J80BXzt66HTCgcPBdkhpEwWEScErkQoNK8zYUxAmv0mWHqMpUzCDuPHjAh5f3FMIq3/i+cxEibVy2WoI/rY50BjlBLQ6/ybK69TMGOIe9moyz+FFaUH5lFnS1Xvy7DAOhiFfGk5zrbB9S23wP76NaXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738416575; c=relaxed/simple;
	bh=YGh++SeYwAxijz5dR/paDwRNN4HBFL00uxMuc8Sx3sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcJr5tJHLDgdvR02/S+3n0bp1pxFuFe2RlyxZV7nORsYNag5eXwe9m4Xcl/WGN4SQ9KtCKiSw2Eoc9PXZmvWfkx9Zb+BHQecN2KaCo9CIQWbZqcE59Ue8bsst+v2C7+nMul8dg+pWKKVGkWGIEHlL335CDAbE3pNX/1kGIvE9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P8Mu6qFe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso2613594f8f.1;
        Sat, 01 Feb 2025 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738416572; x=1739021372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7cjr2yhoNxeoGoillh6jBU4BklgXKOyvt1t79LqLvCo=;
        b=P8Mu6qFe8muNETzIDcH/UPApWCp4R3muOAn5KAbR+PX5oYqi0OJAgaj+xLZ8dn0832
         10DCjQ0GScLF0Hguxr+xnoOl1ZPbKLXWHUIxm2C3HvJKny2I48Zz3kPgXi5BFZk99DTa
         5EjJrAZ20SYCRJV9UkajDpiSOCGFWoTvxnbqdNOUbzZVZc1FzrteUxYo+B2N4h0c0lGZ
         ky3SB4C1tVUDA1x8oMmvQOp0+GWgx6FjBJLZ9qLqOlNuRI1RGaM7IR+E4StaTvHjb9mJ
         eDMEnN8Pz1FBi3OUKaX7CINv0jtSUWmh/DMmB/US0qBLd+RypUud8b28KAVnH0DAfA++
         dQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738416572; x=1739021372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cjr2yhoNxeoGoillh6jBU4BklgXKOyvt1t79LqLvCo=;
        b=DE79zdG3W9ZSiW6ds6HGzrY6VlK0mjuWOWIOWBfVAm2ePwmeNkz1MWm0+xuKjR6Q2q
         A98byvRCaUL62GgXwMYYJeWosIMy3LonElDIaKOk6oNsVgX8pDJ/HaXAipzYXM70xi0g
         XKm527aWFO0FkJiYKVskKQ5mWUZxjeiyOph7SgleuX89WbqgyZjmzoLiD9PiUKA5zCCU
         ExL3QGsKaqTzoBsEBITUBcRFngp8jxT2/ggXfpWcHhDn9ZJ5UeydaHq02inUIBaewjbj
         D5TP/1gq5+i8HGg7zOhp1KBApXSf78icLXT4BJnh8Nu2751fpZpaCm09iAnbQQtzzqGn
         b9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXAQBplVzlCsjEDkTbt4+QE7lm2uK1dxYIENNauiAV1NBmzOQPS2U5dg/mazNnjC6RWsaA9agdUyO46OlU=@vger.kernel.org, AJvYcCXyhssAaeaYTmCZOxKyy8yFDFzf8EDDoD/5sue1uTz1HHhaSu0ptStk0RO+bSMXZB4uuOfOBcb3@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNXC6j0NcAdctRasuMQXletuvGMSe5/P0gWcqaDgMf8Won+IT
	PgdNdtjpPoM6F7rRSPzRZaDnTdLFYE7i3+HSHp6PO6fgBUs/tJs=
X-Gm-Gg: ASbGncvMJ4juOOa4Lb4dz1tHSsX+ZQbVQ/gEuv/Kz6MpqcuTbXP3zLA9Qppv7q7W2JW
	gnFgW64kJXgr0lead2mZ4KT4dvyK+QSYtG3urYOxF+Wz02D+vJHmzzHdO6OaGv5qRTJbdE1Bhll
	kMzb2SbXO1ybSGhGrt/wq58qtvWVAsApjio6Kq8Thl7TdySVgn8QFpXP8J2epAVH3UYUWUW3eXF
	9Mlfnqrq5QAy9nQOJGjywZZvDogrwQljqN2bGH3ah/hqsfaOpX0SC0IruZJ5dA6euaWsnNf23Fw
	3Djhi4kigCOtvCg2zdcoeq9YQONIx2gLLn1AleEvx4QFTJDjczyie6Mq/0+HvgDKVmUf
X-Google-Smtp-Source: AGHT+IGBwosdu4S+bCDxuv+85+odZHbCxNBF+xSwi9KPZ5qDqLC9L36cOWNUCbQoTZZpolAQIbUQOg==
X-Received: by 2002:a5d:5888:0:b0:386:605:77e with SMTP id ffacd0b85a97d-38c520a35e8mr15757255f8f.49.1738416572199;
        Sat, 01 Feb 2025 05:29:32 -0800 (PST)
Received: from [192.168.1.3] (p5b0573ac.dip0.t-ipconnect.de. [91.5.115.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cee41sm7193429f8f.81.2025.02.01.05.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 05:29:31 -0800 (PST)
Message-ID: <f30e70f4-b8aa-4edf-a272-e848c84418a1@googlemail.com>
Date: Sat, 1 Feb 2025 14:29:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130144136.126780286@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.01.2025 um 15:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
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

