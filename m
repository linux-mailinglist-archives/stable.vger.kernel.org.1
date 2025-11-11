Return-Path: <stable+bounces-194466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFADC4D6B8
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C11814EDB7D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18001357702;
	Tue, 11 Nov 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oCcHtpJ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF862FD1CE
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860664; cv=none; b=r1RSHVL/+nUdn6xoyxKyiYwuRtQu9IYQfBa8EpFJGKxA2KnL6c3V6W7Dj0YTA8L7ZVgAmfzFea2VMpuMtl80y3jwmsg8w2j3h/DkR1CciHjpSBR4MnpxR3ybD0d8QVvqz2x+ZlZbgjnYCC8d1EO+H1eBWTst0L15E8iD3TcwQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860664; c=relaxed/simple;
	bh=oGk/zlDW8GMau27Eh++Wjt6SdcJwmeKA0N5l5WwtFRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3kjIu4rjLas/LXHOztlKm4AwF0XT+gfy+j/N+4BS4gZhtnovbeINQSsRK7na1O1jRNmQ4BRVitTaPc3aGqeYDXP4YCD+evt5qI1eZHZzr3Zpe2fjdUKdyVGzLINkAipA2xHD08TnG+Nh9oIwC8h/YrCVW6EeouL0WzUaSUU2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oCcHtpJ6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2953e415b27so37224765ad.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1762860662; x=1763465462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buuCBtLu5sjBaUd1cQkdvhP5ydCgS09SCl514m5o+t8=;
        b=oCcHtpJ6T2/59bt7pig+DXIewO+kSjPsY72ixsHcyKayTISwvoaocEJkLodp01Npko
         hHfIuwPnUPs9cCa8cUHOkf9x/xSodiM7A7jJNhJZfgnGQO66LkUrsDgw+ULPq9fSDVou
         sja0i7WozvhMiI9pOxTtu9mA7TwPRebDRDsCMMCZK2GkED3CoLmtIh6GK0T0CIoaxbo1
         nopUEuz+Z0X6JJM1i3PFyENguIYnlHntHbRTPYeWIc3QId/g8shANvntlcg9vPMSYgPQ
         OY6tw29QWcdGgjzldz+qEz83YU1Gsf+dfIpR7d4h/S6KhrviJ07chLG0xL+dULviaqMb
         Nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860662; x=1763465462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buuCBtLu5sjBaUd1cQkdvhP5ydCgS09SCl514m5o+t8=;
        b=lI8Scjc4B5xFnm5vkQsZ9TaSbr8rRmgnXSNz+xE9SBts93bSYEbvDfKrz+sp4t0OKN
         Q8ARkixlEfrnEsztMsMahfmYrTM4VY6pfYhmdR3TfGafZFne3zaa6doKxZfwEypp9ieF
         w3pvVPzR8uh4brKqFsMraf92qXvbiHWXMHlr4ByrzqMY6DsCE4ZoblsSPecrzeERbltf
         EPBbLezZ4I5MUEIgVVbQ17ZET1NfJ3esoOiF1jLMZ4MEze/6YFTVHUPyfGv/tEE+BmCH
         2evq8KywUvOH4cGsi+3/IEzVcesIvOjnT2Dvqtc5HfAZpdgjJJZzlCpgV06+lHuYqcgP
         vv/A==
X-Gm-Message-State: AOJu0YyZrv+QpAA6G2A23xThu5QqkWv857foLf3bh4ikn9Wws5qb5fD1
	NWlV8AUQI0HHtx5KSxa/ZnIY4MCNUuom31CGzpd+DvlsBGhw+U9ARAjCRwidTDFcD53ba64DAki
	aUhEaoa+7bZ0Y910kKDqkqnTWy72N9bZDwSlTHoeQTg==
X-Gm-Gg: ASbGncuAw8dlI+j6e2p58ABPU2p1XqgG/CNQFDNYeGEXiopawwKtGfuHnjxydCT+crj
	mXpkie3UWuaqG5o4beWvLJci3aYIApSyT78ek7EbnDgBIZlDrLHqE1oh8PLzxTrI0rl+E2JVO+c
	/0CWhzrNv05u+WVo6QI2n8jzUoLngLPIlavGobTBvUzzyXZFggUxeKAPK+e4i/gv4OUHQQ3jXhc
	ySx4bOPCHo6OoPL0QfO4DRMOrYcvk29HJiggm8NDQd6Ss3ipIqbPdOJt8JhBdk=
X-Google-Smtp-Source: AGHT+IHUdTUrobfYmqXo6iySsvYGHYHvfn+aYtawmVY7dBCZg8aZm/C88dV8apc+dpmQBFkcG8hKPnDtE6uO7icYMik=
X-Received: by 2002:a17:902:f702:b0:297:d777:a2d4 with SMTP id
 d9443c01a7336-297e570dd5cmr115319535ad.46.1762860662025; Tue, 11 Nov 2025
 03:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 11 Nov 2025 20:30:44 +0900
X-Gm-Features: AWmQ_bnVvBCJCVRVuQAMNfJ_GsU_ylMILLdsbbKVvbUi6q-EDqMxAg2oZ8sVGHY
Message-ID: <CAKL4bV53PARj8x8zWf=h0MRg4yidX2SX0wH88fDHMGvC1GLuKA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
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

Hi Greg

On Tue, Nov 11, 2025 at 9:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.17.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.8-rc1rv-ga0476dc10cb1
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Nov 11 19:30:54 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

