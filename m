Return-Path: <stable+bounces-25357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536FA86AEB3
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E471C246C5
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6673073501;
	Wed, 28 Feb 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="PfRjmuDA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719373535
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121864; cv=none; b=UEazy5Lfm5CUE8rrQ2+a7ykrB1U0xtQoKrCXc7RBCGXe6lzoBhYeMDmqgWjKwmN+k8OJUg0l3gObPeNmY6GgmNPEYWHcBEZGXEHAJtBgRPbBC5nuC7RqpfUAwRgXtw1lAFALlQmmCicrCEQs43hqm68/VKewU3ynE0tgG/X3kC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121864; c=relaxed/simple;
	bh=Mnm19xaAQ5kCIohrvHCI7K09SSPAvZEzrSgRiBgDsiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwDQd8sjibfy5jE9Ske0zkX2L4ijsfK4b59bUT9oHsAerVExJi0NTlnL3k0wvjhCCGrqOW0BAwp9BfBTEI/WR9+NcJ+8nalXK3I3L1p8gR49eHkCm4o2RnpH3uSnV/A2xvceCCzizsBHt6DDf2GmobRh2YhxtIjk4CcoQ1UqOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=PfRjmuDA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33dd2f0a0c4so2342770f8f.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1709121861; x=1709726661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHFmDVf9X2LvHVAYveT1OfX2Grk6oRfK60r+9cQf5wo=;
        b=PfRjmuDAl48et6QpgIcex3oluOFuBf93H4hG2x5nmINdW2DfojRnGPbQ2gtJ2dFHZD
         7Rt8VaErZtr5env53Q/TH2FrEWbIVnZYkjhkFU11W9R/G244miASKO2NRpVae13FzkC8
         vgVrQAYfTZcejptx667fRMcsbxK91WAQsh9m+ZmH8Ky+dehABV6W3L8C6jBgiHYd5Nm0
         wHvLi5h3ilnjlbhwlymsmx4iT6AyCHRlDwLNbXEpBo7fQX2/RYGiUx6oPGAby0TzyeUW
         7XYXhl9Yx3gqlsoRH9CH/Mw2sJl3ZJVcIDtzEwlV+PiWE+1EqT7hJ8/SN8feW5Um6xmp
         IyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709121861; x=1709726661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHFmDVf9X2LvHVAYveT1OfX2Grk6oRfK60r+9cQf5wo=;
        b=S0TSTHhNj8IAA/JL/0ZeO4JqXVdtuvrED8FMhlTl2/4GCIiIiPUQeF/rXlkgMCsgWb
         43NBsOiQRDdAb1GMvCoihs10EnmOaRGiTpaOTz8gCC7FE+lYTW62kwNQszxtsQn7EnfH
         BQtfaCHsZN6Cb4lIx1RZygTQRZz7ejKoXnThKgG/ifwXQD/pNM/cr2yqeUFckYuZMAXy
         VKym5PQD/mzfK6+xV1uVk5oEilBQwP1nzWkMZSJwvlrYxE0pjn0gwAQ5xpWSzDt98oJK
         PZNwgK4jRIxVBuvocm+rZg4A7TfmB4TozqjrOBany1UJuI4tdTFFTyjX1v9tAW0spzwk
         OX7g==
X-Gm-Message-State: AOJu0YwCoX41z+nNwyWSBeSb6OABrcb4MMMH7WYXYznFzqC6HIRM4Vwk
	48FbU2OhuCB6SEKPl4rhP9MU14J3qy5/+d9I3ec472Ewc6wmUSaGIi3LqeRppN6mYFJI4sP5hvJ
	F1tTdilwFvq2/QmMtoml0GmKZGg6gBwtgOTEQIA==
X-Google-Smtp-Source: AGHT+IEKUemO53QKCZd3tRoOdZknznfHKFG5vUI9UV3SBjGBuFo5hqu0XZiHYJ7iAivhB0gd63HXegceEP2Br4EYKOs=
X-Received: by 2002:a5d:5692:0:b0:33d:2071:9b85 with SMTP id
 f18-20020a5d5692000000b0033d20719b85mr7813274wrv.19.1709121860313; Wed, 28
 Feb 2024 04:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131625.847743063@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 28 Feb 2024 21:04:09 +0900
Message-ID: <CAKL4bV4OKYiBS3Op-Eny2PpMgsg1R8sK+BN0so8mjVOk4ixChg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Feb 27, 2024 at 10:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.19-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.19-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Feb 28 20:10:55 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

