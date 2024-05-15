Return-Path: <stable+bounces-45229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440658C6CFE
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 21:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10072845EC
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352B15ADA8;
	Wed, 15 May 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULKHNJO5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EE15AD90;
	Wed, 15 May 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802648; cv=none; b=dW5MhQV8Zo2p9vjO0rpI8dGmfmPm1MZ8E5rJ3MRWBZevEqTX4W7QjBRVlP+dOwntjAFmG3qRt7rku+ZhcsaQHipNUw9aCGKZ5X6EalAUH+kAzhJdOZIGjKF9VuIvC7v9tKee07nrncYewiDlzJGs7piUh9f6rR0bEBzVgFq05v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802648; c=relaxed/simple;
	bh=TMWtx1q/4CT0Ytzn0MpvQulQwB5i6wOAVyq44uuc7W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jblEDHuzKRG58XBMPK08qckoIrf7kOqEJ9qX8flZop76dHrfqylTBQLXsVSdYw7NZovUJmVNBS0gO4Pqzu/dQElfsch3xv46f/LFNzhv590meM67Ms50luzNPWI5WkkY+dBT6LL+Ri65L/q5h1XZeRsJhiGtRMOxFOmgVZv7RDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULKHNJO5; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4df2d7dca64so2512481e0c.2;
        Wed, 15 May 2024 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715802645; x=1716407445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rcJ7Y7u5PRJkF+YuWFW6oG9ZRqMlT50WMVAy9pp6As=;
        b=ULKHNJO55Pd/zmA/6WVSFm240NatCi5Zfxzns5SXHu5qxf5UtCipqwurJUhu7F4+/V
         kv+5dNlSuOUy3akjki51ZsP3YLv/vvSB/FX7uxD/BECE2cr0Q1PXlUt0EmwEUKMLtaCP
         8T8RC16oQy6WZEQGe4AV0rWk2u7+GERE3f8qsIJWKuVPwe0sA980qWrpzLutFiJLErnR
         FbUF+HTmPtaa7Z08epDDHm5zqfUxlWG++pLHSD7/AZ3CNA+kQj+v8R6I/HYQ9lIxzmIk
         H3hOS5KfNjW+cXKpgClBFMmAXAzFrGURxk71kuVrh9eyXc+8n/o1eVL1s+dwtxmouYAZ
         +ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802645; x=1716407445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rcJ7Y7u5PRJkF+YuWFW6oG9ZRqMlT50WMVAy9pp6As=;
        b=kuJAKLKe3pG/7HRycBDUbOue+ZKk2l8d7ieDwv9hNSgRbbnfE8y3F60dZVOZU0YTOb
         qfSaeTybRs/wz0e9dRRoG5nhomCEHQePASNhrAMrmeCLj6mtxVxlyowS6tEyubi6uOde
         oCQ7hs0Rn8K6QHVqDMFe5fXv+/XBtDHKLUsUUPQoZpjZm6CZFP4exdZh0Zj53Afljgnu
         uJrE3YNQuY9KVO6M5k72RFZgXMkBUsqEfjv7RYt1VbqMM3zkd2DvvcArPF5e8b9F/DHf
         oPpS1Fz90sy1AYtM3bfAtP5He/jFOvTNvddwGHrOrJphJsEX5vtLIv9UScD2bdEwfffS
         qpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl+8cDR3wZl4tJLiOsh8LVUADkr7RRuhl0k2Rz2qW8e0658cyESqXNVgxD5zVrOzaF/QaRwFYEual1XiLNdSKuVhERrUWUUAVbqAhl
X-Gm-Message-State: AOJu0YwhsypTiKbW/YtLtmtNzw3B7wGVvCTV3E44FRMITxjYNv7rX4bG
	zmptLWJMoeVQSZ9fmMWw7H1vYWywKRpicOB0Ek7FrR/IMo+LZO8yEQZFUvyM4FGJ0TQoOUVqaOO
	T5gL7vuieA599q7DlEXLoOn4s5XU=
X-Google-Smtp-Source: AGHT+IFz/KDfBjvaBpcxctcufOB/sVB0Gj611XP5ZvaBwqRhFmoHdBgYz2KoqopVK57g1dwY8p0Szh90tObrV6db1gs=
X-Received: by 2002:a05:6122:2018:b0:4d4:ef9:719d with SMTP id
 71dfb90a1353d-4df8829edfbmr16056592e0c.5.1715802645485; Wed, 15 May 2024
 12:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082510.431870507@linuxfoundation.org>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 15 May 2024 12:50:34 -0700
Message-ID: <CAOMdWSLSoxj8_oG3aZyFw+wv_cUWU2ycnDvikpO-K_Rcsre6vw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

