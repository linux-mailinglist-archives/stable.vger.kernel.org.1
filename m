Return-Path: <stable+bounces-45082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13C8C5844
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586BDB21AC0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D117EB81;
	Tue, 14 May 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="2kCFN+9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAC1E487
	for <stable@vger.kernel.org>; Tue, 14 May 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698100; cv=none; b=k1povd3JSunWsPwk5/zWMjtbYPgaJPVQQxzCusZrbGEZZGYXLNvNHzkM6kqNT2n+ne68a2b5CaeRRwfdp9JLs75sCZJc5BfjlG6c7x4f0PQ1HErA/60FdPqVeI25jADrH5ZRc3XRmXcKeOPmdUAZZqDbU8xOfVz43M/4YXEdnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698100; c=relaxed/simple;
	bh=v5cKs+69XP5Np4L0qIMo+yZTTs38YWffGnAEMsOYqxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFwKTncnjyQQVNW1uFSwxAiOLwsskdCnN4cRk927aXLiPhbfsvnoaZ7r2ZniQQYT1vt8WZkYiRTiG8ADOqDBoQLOL0aueNglc/OxWJVu1i9Jcz2bB7HedzBMKBBIU0ihV+vU6YU3MMzFb2fsMM2s89vA+Awafz2svnijUTGbezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=2kCFN+9M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so4875311b3a.3
        for <stable@vger.kernel.org>; Tue, 14 May 2024 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1715698098; x=1716302898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZk3CwTUVB475tkoToAu9QenbV4AhIaVymB/BlnOoyw=;
        b=2kCFN+9MmYwF5pI1UUsbYW7ZhtJDbAYPwo6SqYU0s0jjzU7ORu1EQXjQ+1Og9Jagcb
         CIEbZlkjySwUTSJ5spm706Y+TUpIJULE7seKjsqutvWLh6qN+7D3DWlasJGtRqew/zZd
         /ksERnUpAXeWBvBeDqoLkk7fLJ2CRXNEutlK5ePrXkpZCL45huXh4NH6SxNPuNC3/5xq
         Iq8uvk0HiyWTGvcb3/+otkDgTOTaq5nZAV5QIM2acErIJ1KKgW364eUQ5qEhznlHzCDm
         0mDA/Xs/SWCeraaKFmax6GSYEPaA8i65dLCNWlx+2JBGr75xRT2OXtyRnjQfvuvzWBWj
         XoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715698098; x=1716302898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZk3CwTUVB475tkoToAu9QenbV4AhIaVymB/BlnOoyw=;
        b=M1n1ovEhCTmbPgH6hQdcJmbQb4I7mujnJHRVH/7PzvVUg7+qr7BLZm/1Ga+NVojTNO
         yoqddiCKJpO+w33bi503hpaEYN6D7GM2tNJn5yQNJuO3tfSZ7eOb+HlIf0MmR7qSWJ/W
         CcX9cDnMskqrEXOeIZx1xMYT73YsUZg/5N0NbXA63U7NQ+IaWm/LS1Zr42Pb6Lp55dfY
         uDKDYyHATllifwfLUI0ogFpUV/wgPCasGv3o6tWhk5DkwW3NRRCA6Q+53ud83Q/wLrZ1
         8k9uqxxzRy3lK4ci6hSwq6pC1eNZvAGtjP3Yq8cEqDOjr1pmYiToBGijNXXzH5eQqFrr
         5G2w==
X-Gm-Message-State: AOJu0Yxd+wGPOV985/4UPutufjDJBShHPCYsOqjApdUmzmMvwDl0vfoh
	hfmOe/CIBuEhMoIhjS0qdqWckunM9PdiCtgD8QePSZ/JbpqPuFXd4aKI4LHJhxbAEOD26B7u43R
	tJGBmOCTefv44EGGciHsZ/cba2oycLkpnSIudOA==
X-Google-Smtp-Source: AGHT+IEMDE14BQJ7hwbgCihLMNzbQ80px+rakB3WXBnAWf/pBUQIv0Chn06Qv5WDJjyyU8qAjhHS3Rmz0+zRhzvLJo0=
X-Received: by 2002:a05:6a20:748f:b0:1af:acf5:f9e5 with SMTP id
 adf61e73a8af0-1afde0b7309mr20033005637.23.1715698098122; Tue, 14 May 2024
 07:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514101032.219857983@linuxfoundation.org>
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 14 May 2024 23:48:06 +0900
Message-ID: <CAKL4bV4=MjQAWTEvvp9pJ4JD4ZbC=7hjhbc2S=Ri_uPMvRG6Eg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/301] 6.6.31-rc1 review
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

On Tue, May 14, 2024 at 8:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 301 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.31-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.31-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240507, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue May 14 23:21:48 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

