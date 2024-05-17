Return-Path: <stable+bounces-45353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02EC8C7F34
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0861F22B3A
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE87399;
	Fri, 17 May 2024 00:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbt4d+qT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADD387;
	Fri, 17 May 2024 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905792; cv=none; b=j3sYyVdcvOXCdqJ2KYmLWaaII79dQ8Tr8/kAyAjq27HYnlPDQ46bOEXAKESTSzJtI68fW4IViY+h/II3/BG/wyBRqyaTjYYqSMDr0Azc36cOB5bjcq5eembWOx3NG5/w8UZCC+9uKupZT2z1hvI2bvS0yCzIxRIbrXMWBpUHhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905792; c=relaxed/simple;
	bh=KH0mu/PBKvyDTtRbZDfMad/j9+AAEqnKA8oRnYYewaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccBr/j1WuhtPvU5tSV3cPK37atlN3/zgBiLO2AlIHCYu4sUa2Kv7PoSG7bT9sohordQFD+tQfHXJSMZsJsN1ybO+HoDo8sQwj+ir9HH4CsriqAepA7u2pPgfXWiE0wlw0tCM4F5mxCTWnmAz4sW/DepW/QM7mfM0FvQvy0eQyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbt4d+qT; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-481398a7381so1698413137.3;
        Thu, 16 May 2024 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715905790; x=1716510590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+KmOyC/iV8n/07rVcqpUpUm3beAF6+iOzU5m/G/q6o=;
        b=Tbt4d+qTzmsRUGEGyxIxmqLCeQTDsruswGIhwiWR7d7didwpHQNb47wQx1dOBQVuBr
         P58bQkBlNbbZEqFU4G8a94BqnvUDs7OhdUzjEhRnwwAOeqY3i/YndtvjX9aNt24mM7pC
         zWaGscvWducpCEwcqY8FNvKUdLLKe3w4nNdo2rYPioNU+oVuIbKvtyArpKfa3h5HXC9g
         ieW8RR19yocuJNXRRo/5nhtGsVXcUCEsr6XwtG9wnOCWFUvy9is041lEkyE8EMmr4A/r
         4HGE/Ig2rUYTqWNQCSJMuQKaftqIT/F3dT+Ncs5BIwiubfv4bU0lWoLZxTKs3Z4+6g7T
         BFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715905790; x=1716510590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+KmOyC/iV8n/07rVcqpUpUm3beAF6+iOzU5m/G/q6o=;
        b=K+d56ZILAjqLGg1BoIyYJt1D+Ex+NGCFnry3o5wUJ9fuHZOP2aK/KzZROqNHBR99RQ
         J4/+cC64WUchkly6S79Kg9PF8xK4LQOl9e0yT7VVkWesZlbaWZBakXo8LoKNMht8lpLJ
         4K6kW4NXeXYb2vtFUWFIf8R85EN89OqVTPXF/RXY/Hcfgg+n+bwiMPoivI6YGSTatt3o
         b2OUEQBdsmVEbSxD33gANKvRdIvR8CO6z2oB3C4467Q/90VvuEhInxp8AGFjPj0XqD4J
         KhNUag3BE+eMGyvaSgqbEqJz39KdWoq6LJywmz/FtVnlnSGuFBaMLU9H9l9ec/L3c1/p
         4chQ==
X-Forwarded-Encrypted: i=1; AJvYcCVflsn336Fi5eV81xEY88diOtKYBKyNLV87Fp8/JgZwQXf5y2jhttt4laffOHYjPAbaFS0HJVLZvjV07/v6RscpBF+TZ6uODfNPPhdA
X-Gm-Message-State: AOJu0YxdnrigHAfF2gHX64NKCg3HkSmhjp/VlX9EyxIYrKyWUW9LKu+d
	ZZPbiFGVCG/yqdfM0erJ1MSiEu3JdgzWKFGareiRAyTVOaD4KYJi3lUBGaR1x2t0BQtoFkOBTrf
	mq44Vzsz9sur02cGkjR6gXDms7vg=
X-Google-Smtp-Source: AGHT+IHvllubFZaKY6KPvv1qxfS9Saxnyz/cYL94fUH5oUTlB1YWBRPY36H/Sx5fd2+exy7HAXc8Wf55NEjs5679QeY=
X-Received: by 2002:a05:6102:14a7:b0:47c:28c1:5379 with SMTP id
 ada2fe7eead31-48077eb3c8fmr20452446137.33.1715905789817; Thu, 16 May 2024
 17:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516091232.619851361@linuxfoundation.org>
In-Reply-To: <20240516091232.619851361@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 16 May 2024 17:29:38 -0700
Message-ID: <CAOMdWSK7KC18aVMn9mo22s3g8BFj2oGVRdosNkF4fY3k7xPp2w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/244] 6.1.91-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.1.91 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 09:11:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.91-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

