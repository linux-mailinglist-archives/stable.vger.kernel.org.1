Return-Path: <stable+bounces-180513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0AB84638
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C87B88C2
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39584303A1E;
	Thu, 18 Sep 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghFqkrGt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE39302740
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195800; cv=none; b=KwDA3nE25Eu379KcMlq6zmNuJzy8n+Kn1+HbN+kO6yvmpVuahWEoOahqGNLasez74fB18Upqph447JZ/4LoNiIAM1U6OzVbP9DP/c8VGr+SYUNMNg9SI4V/gm+suFq4BapyVwfpsBf4azEQqearlhYymJI0h3jKQWfEHTdUBsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195800; c=relaxed/simple;
	bh=D0qT/j8mgOQHMVtdjpb+0Fx+sFTbsplo6m2+YqZFl8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj/Ixhkd1Q6EDRzw+cLuAMKMLfeBAmquNNwsfwwdODFH97mkf/axlhAh07bBbyOpfe1ZtqAt7h+1njbR5Bz4vOMP6iBBhrXiw2h4E77GdldnTJY/aZOuM1KqCHxKo6dJ+PAjYdHUjmLGtMxlQTrSgrw4cGAJjQMKoFxiLGOlPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghFqkrGt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-56088927dcbso1013059e87.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 04:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758195796; x=1758800596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mttDaVgnou30m6qIadwuCBtYMMTHSA0PElHch05zpGQ=;
        b=ghFqkrGtxPxsdBvDdjI7h3ZsS7tzSt0oAu6G8lp9SV6V1au8odS4qShlZk/ZBPg53T
         wRFw2QRCzhVF1XCOgSshSZWjJGOB1X3OSw8ZQNylFF5VGGW3WnGawgSzbMcOnLSzjGfi
         U7W0Vb6tG6Y4nDfOZY37i3JeJWJXivm/niGwVmpfKnCbQlNjNV4Cz14gI5s1DVjpyBTu
         CRXFgdrxTQxIM7qFLhtY4rcfpq12zPH5Ux1KZbfEJsGcjIpIHFjd0Dey0z+lLUdx77id
         ZwLeCHJ+QYi4INN3jtZibwxKtR1CpLYGniSy++ogLVqwLM1eEaakNLRfrplbhp6pODLf
         iIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195796; x=1758800596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mttDaVgnou30m6qIadwuCBtYMMTHSA0PElHch05zpGQ=;
        b=odp5nJj30M1+N1T5dlJS+4hQ60VxRo98j7M/GYHVg680wLGI6p6abNeGeMNXk6HCwR
         NnM+86DZjq4iHxUPMGzL1mpXD2xp0nAsqovLPPaj2PSIOLzZ5RGCznnXrYxcjvYjbqf6
         zRtxnsvPl60JfRY1uRsvv0X2zxj0KbGXBPa1urKae1mwNrCn4okRaRH/rCf598kq6pyZ
         Cx5I2xHSPcD5NJMJM0SMQb7jTttwqk40lB+VjTQPvP/gdilje27AL/LTx+ELqr3FHBmG
         4pht0XvwFp3VDiuNL6zBq8YluHMpegTY3cUnk8G2gkocFUr+AZBZ/Wj5hck8ibvH5idy
         r/HQ==
X-Gm-Message-State: AOJu0Yx8XW9BTMJdDO7HT5aRW+C4e4YfXywtoGuHMkacT1TAlbYjrZQq
	s+BImYeHUuJs00WXFlGkO/qOTmFEdYvd24KO592jcE4/9IIxX4thT7g5nDodBmcOofV5t8WP6EK
	0TNBXLzdcmdWER7faQH1OiuPFyqF8bF4=
X-Gm-Gg: ASbGncumkhXy/57cRo2oXhXdogXZCzWclsutSXSTQ9G9jvfPJJLwXUPkjxG7EkchTx7
	S1VDgUXH8p/vj/sMFtrJ7C5MJqMp1Z0Ty9/9tPzB9qzagrvKrNMwKMGL/OMXSMGiDXOlWsHYnXq
	Dbxa3Rt/NReooCCIIS6KVmh/iDo+bHsWaOm92IM940P0frMwzn8VAx3FCBm/QJG5P2bXuBLJjgq
	vDk+a9wQsy6GZGexvkFWe85kdPAxnzrx0lXZ+I97KzFqPSp/a5VITUZmZDXiobVQ3nIhno=
X-Google-Smtp-Source: AGHT+IFZ5w3GAzz7FR/Jj3KgJNtD/D7A3e4TaXGqydX5EqbXflMlxl1MTipZAZVLe5jiTdwbW8rWf9Jesg9Q6tJ5zQc=
X-Received: by 2002:a05:6512:12cf:b0:55f:4c1d:47f3 with SMTP id
 2adb3069b0e04-5779b9be614mr1933467e87.28.1758195796193; Thu, 18 Sep 2025
 04:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123351.839989757@linuxfoundation.org>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 18 Sep 2025 17:13:04 +0530
X-Gm-Features: AS18NWDWssrlG-K0ZlWvu9x32iRhOcTvdFSygqtOTPhd_LkBMlJmE0oYnHGYMj0
Message-ID: <CAC-m1rrg6BkCSvE2L7niQH1E++daOrFYX6p0s0on0Ykt-TYbMg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 6:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and boot tested 6.16.8-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Build
kernel: 6.16.8-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: fb25a6be32b38a3267e8037fc4bf1a559316360a

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep M

