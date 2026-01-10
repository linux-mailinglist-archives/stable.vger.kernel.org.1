Return-Path: <stable+bounces-207936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E036CD0CF4F
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 06:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A4B93004B90
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA657248867;
	Sat, 10 Jan 2026 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="A85wPv2E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE82AEE1
	for <stable@vger.kernel.org>; Sat, 10 Jan 2026 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768021434; cv=none; b=fZhG25M4ptaoCBMMm7vzMfVWNYhXo7y7qhL4wbQ+EDJJ518icHb7c1dC9l9N9w84pnAQRyCcxEulCfeoFx12pZqEoAGJtE19WhpiGkQiIycVaVpDQAx3Z13MCmc67pziS2CrbO/28kKIAJE0/PjM82mAVwzYvfmxsqnJDQt8H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768021434; c=relaxed/simple;
	bh=QmsyRyupDkNYP2ROO7/MGNRneU0BZcN+NXktHjtRr6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6q4nStPAx6lmvYgD18nDm6UuhA6FB1cHynsaZHhN7Rw4HQySm+MehSdQohmnoF5tlw6ZgZIfvdgKkBfvW7kj/lw5tIy/RpjWzJbH3mj0ubRL8F48p0U2/Q6vQE+mdtHpoXxZ9t9s3t5I99tIhVoX0Yp2NH5BPJnO3wvR0yDl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=A85wPv2E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso43813585e9.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 21:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768021432; x=1768626232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SkfwYNksBv2+Yd/5xYDV103bMEakN9vgXSxeDSRzLns=;
        b=A85wPv2EafEoKDRMMpNXxMWNWYj6/SgRegofYi2LXnooMk1vj5BGB+ExAqq3yu+ioH
         tn5s0k0xEZUAcCP8iCjY52EYfZV8VUoiITcezXZWrOgnLr3DX9rdqKT/zCimNQ473sSX
         fifywkXWsjTrs9xLLvFu4o51zMJ+zLqIfDWgpl+cDk2pd9UPTXV1Yb8HqWmIhTFpIcz3
         ETbWOXFdIzmg0tOakGi/0K/s4U0zDgyL0ud+iaoI5y7nKwiKo/Cv9+eSo8Fbf2m1k0FJ
         NKSSUC8YkXoR2giJ3vnrFpcKa3h9F+wFgMhGMIYSxShCJEBbWRNrtCPxIEUqwJhJbiHb
         nEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768021432; x=1768626232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkfwYNksBv2+Yd/5xYDV103bMEakN9vgXSxeDSRzLns=;
        b=El/LFhjG0x1+K6t7Hkvgf4TMlhibWwN9gswok9wliSYF4aMO7MJLlPJcuHp0+Jy4Ri
         GthvtrJlL8hmy//8Wn3Mvhhpso7yEQUB8/rVuBLBCw4r1I+n7nj6l9OXM1KedRjRSHdf
         OZen9h5syg14O82RLQWQgMrtVEhVGh7JljMc76HPNLJLEXa7FNlQ7XexNf2GrvV4di8e
         lfl2/UNjiZXgzIadJcW2H/H29iNCLvI3hPliT/HrEF5MreZsVJNIPFqP2qVNRqRrXPo3
         LrzMTbYF7nF/ZlFv7ocwrL652uU/6d5z0u+j0QbEhlqeoWj19mGeOwC+2daFw3b+jXKD
         6U+g==
X-Forwarded-Encrypted: i=1; AJvYcCVZG++57ltBnYsvDjLDZVy3qmTgLE+jyGjM9BsT+UgTAWD5Q72q8hKoL1VYXcp6fSPnAzTsU6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeh1ts7OAwEcdeN0EWuhQJd6lkeTEyfeEG6FXY7PrHbipTS5MY
	HPe9+a7wFeDUFrQM/Wxg06C0qubBattkwDds+meZt427SoIdLyvT8m8=
X-Gm-Gg: AY/fxX5vKgDE6nKbQIek6n7e444szYQDxTVJqkhvPS4E1/HN5+zFr9uMO+xTQR2xAco
	fjZzBEplBCUQ8Jz4uoQhD8hH2NooY0HkrWO6s8Dy5Cuytck8NGkpI/uI67WcoTYNIMJ+kROhRVp
	Ti/qGeT2ere5MyOlcXT3PpWRRFSk7Wt1LLj7sxLFNoHuFPlaCRexuT9AXLi5T2c28QimL/LQVzy
	MkdZFqFv99D/cXh49ehO/f0hzkAoLYPaIqIeXagYkbfUgKQvEWEHZ9pAOv6DuUclisu4JHfGLk2
	01GSJAqJJ5Dg/qxZOICpvx1SSYkuorSZavhQNA/qN7FlvZiCDWmnlWYq+6ydhAXlXyRp1TIq99m
	TZsKkqcP/HzkFLfNHo3nOkKS1Zf4d1NhglaqK0EZLHbz4Aqf1j6Xn1tpSZiPioKJ4aQYhZ8eURo
	4cGs2ij67LDOb538h2+PHdJ9+6cwL8y7ZxuoeDGjbTL08vTbAPK+gtWi4rmA1SxWMBX/KEOJZPh
	A==
X-Google-Smtp-Source: AGHT+IGK1885DvIghdc2ErpVZT0GXmuDOF8nonISDwojI6/iV81wnB9mskmxzwccVmERFAtKKnC2gQ==
X-Received: by 2002:a05:600c:8706:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d84b407e4mr133081615e9.36.1768021431478;
        Fri, 09 Jan 2026 21:03:51 -0800 (PST)
Received: from [192.168.1.3] (p5b057af3.dip0.t-ipconnect.de. [91.5.122.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86372c92sm87105195e9.0.2026.01.09.21.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 21:03:51 -0800 (PST)
Message-ID: <dd29e500-22b3-4583-a92c-e338699d7882@googlemail.com>
Date: Sat, 10 Jan 2026 06:03:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/737] 6.6.120-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260109112133.973195406@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.2026 um 12:32 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.120 release.
> There are 737 patches in this series, all will be posted as a response
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

