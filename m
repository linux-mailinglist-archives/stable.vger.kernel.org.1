Return-Path: <stable+bounces-37954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9989F026
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9291C22726
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47083156F2F;
	Wed, 10 Apr 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="B99zIrzF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBCA159576
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746101; cv=none; b=kOtsh3J1eG5MABD1gM1zhDQ20zhiES0IzqMbOZGVBeHR3xHmr7AzX7XdSt4VNyj8cmKW8O9J69UKE5QYyTwFaZRQ5OdPUH7/wIAQZdoD2t6Zs/PvbTTNm+g5RXjek4ZHf0BgjFAqkT/X8ip8nVMwYhLptebBffG+OYNx8Gdv5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746101; c=relaxed/simple;
	bh=eik9m6cp2uZohOzU8Oz+3bZ4OUinbaNDJ9WanhK7KSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asemuTQ+L+NmXp52VgpBYLQxMFCFuFBwmzfrAbm2SNXrVNH+OqKraXb6ynRM2LEG8MO3t6bVhuvh8/eFQKfYf4c04BfYma9cQBLxfLA4x2eWdz6SmoD3YTmLrOGFjfcbDNKdeFmDij/6S7dju5AynuVo2soOqUYGynECsAonlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=B99zIrzF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a28b11db68so4168047a91.2
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712746097; x=1713350897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNqD10j5CZpBny7jQPfQMEvtKqWfKf6kWfbDUoXBuJM=;
        b=B99zIrzFlflE2Bzqw9bXXwdpeUXPRgvt4k1P3JL+kXEeZhyvMcvokLmpY5sAgedsx9
         Krtvctsrbn2hfOOP0yWcIqIisZe6+qk4DQQdA2tN4KCVeASk2ss3deTGafUytwmN7APW
         Qp+CLood6X6PbFSTsoV5bR7VXYEoPzzOCkyzgMf8CCtt0XJIiW6iXzqJ70q4LObGnSa6
         C3vukccb7zzx9GczTo1qP1lRW5KKl9GgMWlE2/cCoFYedb9mSCwJvIqIOmUrXIF+PHoT
         8FP6/7UimXXA6DygEM9so9DdHFjQrKPFAi59GORhmvO3fxgGoc08ptBOh/AZgle7bg9a
         nXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746097; x=1713350897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNqD10j5CZpBny7jQPfQMEvtKqWfKf6kWfbDUoXBuJM=;
        b=s8oyLe9tC+sns1ZuGkLp6TotaNLdM2P9p6m8ga2oYyMrWLbGGfCJMX4eVS58A5Rwu+
         QrnEcAirD/cpmCeFaCRbWac7+Iupdaok8BKfcJVupqfVoc6nY2LsV9eoEEXglof0UAUE
         I7SG82dH1nuNck2tCneTpPb9QpT/YIedb7z8QCm6KiMSnY8BEzkmJNcLrBX4oCiy/ilm
         LOnSIFkwK17iw3hDTQJqbRQbfnU5j9kuiv0f94SBv4e2ACNviby9vwKlCbZvtdUolrZh
         euD5Lx9HNt/rL2DDmpAVz2hxJ4xPB5JZOJ9RARulPWk3wu1kbxm2XzQFn99dsSOz0AcD
         9ioQ==
X-Gm-Message-State: AOJu0Yz+H7MjMwyru4+3qHCXOsrX817vrSixjF2pdtCT+XRgXoDsACmO
	NwyZnc+o+V33HeC5KdsRuG9lcaO6qYHjmVrWxjR5m9hcSJ4VmW11kYeUNrM1jJp4LodRZ3oBscq
	XHirYHjBy18v4nqOkSLoRa/BTDkqMtU//x2Hi5A==
X-Google-Smtp-Source: AGHT+IEOi7A+jM3agseYiE2tgGFF/lIKAomfhvj5GEMdbiDzHPEJRuS+/3WJ05h17I71ATBjBeaOThBJ5VRShOGE6pM=
X-Received: by 2002:a17:90a:6b07:b0:2a5:3438:a31b with SMTP id
 v7-20020a17090a6b0700b002a53438a31bmr2111883pjj.37.1712746097485; Wed, 10 Apr
 2024 03:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173540.185904475@linuxfoundation.org>
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 10 Apr 2024 19:48:06 +0900
Message-ID: <CAKL4bV4Ltkhh=jBBoy4CbnLOG25Eb4eEpLC5usBmeJFXZEf28w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Apr 10, 2024 at 2:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.26-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.26-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.26-rc3rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Apr 10 18:40:29 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

