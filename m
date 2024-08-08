Return-Path: <stable+bounces-66098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B671694C725
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 01:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79D91C21C6A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5C156257;
	Thu,  8 Aug 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RugLjLca"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDA156220;
	Thu,  8 Aug 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158053; cv=none; b=jlLb9V4l1k2uKTr+hZdZFXLjUfloumlC2L/M/qGKWfiktwIkMCBphewWc6WzphffbFvfuMK4Wnz/v0KPmDW4nmhJ9ktZdV6G4KvJT5dF2b+LVTKveKF77X1++tsf2y3pgQTLfdZUuN3xAxHbbk2vFd5JM0UH6Ba/JC7Dv1wN0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158053; c=relaxed/simple;
	bh=HDwdkZfKg669WzeK8RdP0XkDkLGs2IT1MuZVSIU56Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyItlKiojLWOg/wb8irBkeDUpg8tIOy6p+0ojISBUB3TmeNNHQete9L5YNj4X/cHY01qf2KJZIFI3zeGBKnsE4mynuay3pJ+uVDOvadABqNkD7I+LkxD5Zvt6P0vWaaN3ZqtNO3pyhlZa6AvPPIu4C+VNm0T6qUQbMholDdHYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RugLjLca; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4f6ac477ff4so880931e0c.3;
        Thu, 08 Aug 2024 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723158051; x=1723762851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlGNe+kQiQq+j1tPjYRl+U7qon1kCBS85kse1myrA0o=;
        b=RugLjLca1Wajt+UhAiB7siQcKRzafYrK3Mtvc0KVmtjuIem00pKSY/bthnZWyEbpJk
         VekIZ7OJArbyt6BfWWd733gvIZD253ygMWDXbAvUgNNoEw//iRWFBVI1CaTxOTq5TuIT
         cSWhhpRl49rGGdW0QX11LOyCpnQlWTEg0gw6oG+sieHwexqTZDnaYbfw5ogWVb7fTG4G
         YcKAfFnqBGHn5iVYhgNxrGyDSBlCenQn73znfuFD0LnuNSWkxDgMrnTmMwvEVaa+BgOY
         NMHlgtOf0kfVxNWakf07eUeqrWuEp4zaAhUot07cbPmOwGBcb9/OC9jTkmX92/u4b5qa
         UaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723158051; x=1723762851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlGNe+kQiQq+j1tPjYRl+U7qon1kCBS85kse1myrA0o=;
        b=XLyw93OpemLzdC487jt9UNCcRzsFWfTz6yGTQ2l7V1K3lascGoPIGvsmypliSUZGJ8
         5hjrIrmpjy7OiYFJhiLDq6+XcOjaeM0lNVdeFM05y39uQ/v79c8UdYPvr8gMGVdQgU7Z
         ld/0M6sCQZLSp2t3kvEiPP6elnjAtW7cbXliVb9s7+P+dfjr2PaxufrVexDp4Twj8vvF
         Ej395Bjcbmew7TVTn+RTbDIn120Gt2Aqj8r1b2Px+mW5OrCOdNg8P5G8aB7Ow5jGfmH3
         yNLZ2O+FMK2Ay7Er9vGCW9dMiKUBSMBqnSD+T1YVC7pp6MttyONmOdwrGVTUVlSteg+K
         zzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr3bN0gu+s/inS8wwjdTPqTF6A8MKtGGQNazs2QsdqdO5b3pinTiaCG/NLI+kGeptqP/89p2yEAC6LAt7PVsgdUi/caFk/igsfQBfp
X-Gm-Message-State: AOJu0Yw5tc+Nu1r8kfYbm4J6at6BMIedwDXAs+g1wF7PiqyZ9bGabVLZ
	wSvIakGuI1u2xhP6yrvMQoawq+vy4b0aU6MPgH+PsPl5bG3wv+hieh88Erfie6X09QX4PVoSNyE
	ka5BDoZOFBpBehqB9TLDy61bIrP8=
X-Google-Smtp-Source: AGHT+IHaXz0XGhbgdMz6ZETiBjPaaWJ6Y6jGZviOb118NgDdF5UhbWcuWjSTpTp0tnBE0o2xV3kNYHYP3zL/M6bomrk=
X-Received: by 2002:a05:6122:459f:b0:4eb:5cb9:f219 with SMTP id
 71dfb90a1353d-4f90217049dmr4594541e0c.0.1723158051328; Thu, 08 Aug 2024
 16:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807150019.412911622@linuxfoundation.org>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 8 Aug 2024 16:00:40 -0700
Message-ID: <CAOMdWSLk8jU2Ea6EpjX8bQo37xJU8pp46TTmejOG0Cc=SMW82g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.45-rc1.gz
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

