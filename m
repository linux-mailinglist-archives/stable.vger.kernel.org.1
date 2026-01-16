Return-Path: <stable+bounces-210120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D8D38906
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 22:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A457030021CC
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC930BB88;
	Fri, 16 Jan 2026 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="UU6S+GdT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB22FDC3D
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600567; cv=none; b=QnwzRYIkdoROZGBLU7REHbLTSmEWZuF5Wmfdl31Tkcng9tPrzOsp8rtT5Zarj+hFdkjemnmDzU2rAXuBKVHTVonfjrT/tvlPUsPtzBK72veAc/3YT6DSXB1iKSSjoDXawNk/f/A88DNkclc3QUhR89CgjRSUbVnJ770r61RqB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600567; c=relaxed/simple;
	bh=jQKYgO1fO+h99uxsyrogt/jaI/NAbt/f7mqYugBO8fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeWrivleaPWcMlOxefsLquTfPazxHYfqNCuilhLkEn12u9SMbv2d5zZZU0x7Sw3uvbRS/4phXSWZNx6cq1mXVmfBVFligS2/+Y18ankkA9hrg8LRVFsMjdv3JG5UdgpYqTRpm1LIKAOgGDEJoL8tj/vQBhBvuxLqIUg1AdSrZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=UU6S+GdT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c0f13e4424so300051685a.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 13:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1768600565; x=1769205365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eZ9D0LRjF1zjIiPIQ4+n55pi2/vjND0r4M2Z8nEoV4=;
        b=UU6S+GdTAMjvtN1HGuHI4KLUymcUTI+Iz91AYDt1xbuQ/lm1wR6ipkfLKPO6+h0sf3
         O4jBMkcO/U1qX0RWdGLAWxwymkFLZxutT+VEc7j/q/9T0gcIdDXKF51jLF7cBkZzL6Ii
         xxJ3tmuBDshcQFjEnDj6Cy5BSbcii+o0xUYHT4PM8nn7+QFXti/GsOlOXmywgoAok/TF
         DKtcli2nUxx1AeUPqjlwD2lsx36HysyumnjJVHPq25mdZ+q4diDsdo2cb40T+Pa5L6YZ
         fj5etf5EnqcESP1eyrP0XGOGJ3dVkI8DRCp5s/c6UxxgLfDj5bBLXEsrgPL15Pu9DVBH
         zOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768600565; x=1769205365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eZ9D0LRjF1zjIiPIQ4+n55pi2/vjND0r4M2Z8nEoV4=;
        b=dRwKFlkZqU2S2tJ+z8dwTHA7sRhms6rPHEV+lks/0wa8hZ+T6Q9XWJwuyeFAI62vXF
         ZON6knjBzv0BP8h8kBfLfWDzUlpUP7xAi0EAJBfD1biuJ29y7WZSr+GTFY2IYDplDU70
         rKncefHIu8IqPeTNp5fuCL71J2D7WVmyrI3vUOS3NY4RLH0DkEHlpvOnqomHu9En4Hpf
         GK1kIzo5UBxzrXKx74wBJuSZT9ldwGa9knQR7h2KM0TbtReh6lipUn++q7NjonDkAXJT
         RRO/Pjx/eY/nanfW/h3GGqHY474Vyc0+wLcBELBaTS8RDaFveh1zzYyFepSL8ankChWm
         jXLA==
X-Gm-Message-State: AOJu0Yz04LTlQBEWk8RW7OrukWKHnhLchFO+Iug0ttedxvkSEXaE4z31
	no8YzhkNYnMsuBU3i0kenZy9NkIWs3DnlkiKyRa9cJ6jh6V6aqNfO9Se4XDjNovFt4Ej48ClC19
	K3Ukp0Wy3L45Jqf7nPTabxt5lmSw2qszXuPr4uCu8MlJbURbKJm3IT/cbPw==
X-Gm-Gg: AY/fxX4cFEV985XiHE9zAGFRRt4TMFo+UqCxzuuh0sJM0WmDbsD1U3nWEXgivBqONs9
	t8gAFsqz39FIKenLaYI4/RyTvvv8yYPpdQ8gdlIwvOXdBwfrzzX2yv1JhQu70qNUS3NYUaF8SEB
	vB9gl0XldETmda3SESVtBS2xhLpqg2IPwx7Hj7jUf1hkXIc0QY2OGwfwUOezAICa+oFp6cJI4Ft
	ymRdzQlL5KRmE1CJCtxMnCekFSgLOa89jxfthNdyJdiiMQLoBoXrv8Awi5D3QEbxZlAgDGkXPiM
	x3uliiM=
X-Received: by 2002:a05:620a:4054:b0:8b1:110a:e14 with SMTP id
 af79cd13be357-8c6a67648cdmr581602085a.55.1768600565283; Fri, 16 Jan 2026
 13:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164202.305475649@linuxfoundation.org>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 16 Jan 2026 16:55:54 -0500
X-Gm-Features: AZwV_Qg7i-GTu8egevic-3fB-43vNln4v5HedxwZ0L7EIgpkOdNYwGQZdioya5M
Message-ID: <CAOBMUvjRY_U-hu+nk+Nc4n5WRwaFSM34YFqP8P1SvSp1uSSzeA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 11:54=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

