Return-Path: <stable+bounces-40000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766208A67EC
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00191F21BB2
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236CB86AFC;
	Tue, 16 Apr 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="Ou/+1mni"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1186659
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262423; cv=none; b=qyQiyYSMsogpZr44vTP06I+OLbbZq7IBWU1iNCksg2AM/Lkp8tyeZ6MnnqITUaEZvrP8hVWpfxEGW24s84NCy2dmoaj7z62/E0RXFTTv4/hQfsNYvrs7j4Y5iesMljF3EY0iBNDHhvt27gzdjvmkgY0HeVeYOJGJ1kPJ6qbH6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262423; c=relaxed/simple;
	bh=PLfHS/pr861fPjFBeMBoEopPIt381ou0qj9dA0o7sxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TknyXeoZMBSeerhY0U9EyUlsLd0SMs0HYpSYd9tlHwr1JSgAv36itw13w5Rb1ePXCwpIHo2nXSfhzW6/0dpcXNJ/LJVeF0ankJMNwFmVmqAsBzupe5xGE+p7Gqkrawk3BUCAL4WEZ9WbNeFzCgHBgCM9Sj4X0m1DulBGTDXpZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=Ou/+1mni; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2782458a12.0
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1713262422; x=1713867222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZfb01z1cElSdFgczCPztvVWoygfwcGgF7HnVAPTuEs=;
        b=Ou/+1mnibDBFuGPcQ0dWFkRgXX9GC0Nywe2x4pGJI0/QodftMdTwehlyON8vOOciQa
         BeEn4O4ss2KnJQII1/G83f3p4FPr2znkx7MfwCmsLz4tEjrxeKKYnr0HrzZAlTPync7d
         xBrRsG21s+E2Z3YyG6vO+6rqOoZSFFxiYAsy6eCkXNodDsPsvKA1V7vh07Qp/S4JK4lr
         hq/cePmHYYJqfMWHlQH18BqKdrjXsGlaq+ybfpYFBLuHHDSxHRfw30z+hfcXA7xNJIu8
         HXOkF/sBRBU6/97i24RMvIIWwUsiEbDzykoIxTo+nUV0/5dl+7EQICdKAN1paTWYXpLJ
         V4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713262422; x=1713867222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZfb01z1cElSdFgczCPztvVWoygfwcGgF7HnVAPTuEs=;
        b=EVvV15MOfjb0OnzD7enWwHge0zqXNaSuDogHxdJj431pxrNmrZIuaOt0yr6Gce8WXI
         AObI/Uf78o9D1Yrja9zj29tyj1kPUoukHOvTxlg194B9pF6TjbsaV8FoDuJy1E20Qmnb
         RFWi2MAyc3xD3D8lr2Ln/p4z+BnP3I8RWcQyrElKI3pO95/CiHmAtih/rL6lm3swx2hR
         bj1MUpaXEnrntsz1lHXMrsCAZ4DiHDdjz2uuxHNizImYLpH9uYbVuAMKghugqGYVNrVX
         FHxh0Nsl/OWnecb2cJV2rxs3DEDUs7e55gkJERAyL2EBjauHGdgrZA4Jh202dnRaS+rE
         c35g==
X-Gm-Message-State: AOJu0YxCKbjHrWigmQiw118N9UNVieb4adnp25fpxHkzOyFYrsupOjQ2
	tLCIx644mzIV1+K7ZQrPu+cvxZSYN0DSEkaTTimnjJXyVC9JirLWnQxMt9c9Z1QmULdluxH1Itz
	Dgl+pRK9OEWwRx6i3ik4cN8UF7Dct8uKJsyPZyA==
X-Google-Smtp-Source: AGHT+IEAmCX3pj6Nd8BE8HVb4J6COM8iyob7Dnrh8XVaPFzBOespQeJDXW+F7FT5eUBAa5B9DPn9VuXJil6nMAitpYE=
X-Received: by 2002:a17:90a:f105:b0:2a7:8674:a0c8 with SMTP id
 cc5-20020a17090af10500b002a78674a0c8mr2945956pjb.1.1713262421827; Tue, 16 Apr
 2024 03:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141953.365222063@linuxfoundation.org>
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 16 Apr 2024 19:13:30 +0900
Message-ID: <CAKL4bV6gTOUt=LomZjGceMm6SjqWeOXXeTE8EQ7H-ovQvnfzZA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
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

On Mon, Apr 15, 2024 at 11:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.28-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.28-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr 16 18:32:52 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

