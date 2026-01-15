Return-Path: <stable+bounces-209949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78CBD28220
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98A73011403
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8130C618;
	Thu, 15 Jan 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="EmVrkmPL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566493191DF
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505792; cv=pass; b=MxBf5I1FNqY5Q5Dvp65kmtQCM82EISwXFM7KcmRBwIIn9OF1F98OrdeEHUHQ0otQEuLh5ObRuySGFQMV3XaUJ8RPS850FZyo4iLZI3N7dHl9T3kWrVECjxRKykZtZEWnczARFrcj7LmsuQcmzs1F15B6sfMeZtMRExNkuAE0sZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505792; c=relaxed/simple;
	bh=XiQU9ZDChgsS39EIlNdur2gjWovxszQJ1rlo/pmMEjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjTcTfUfLWEwOpOmoR4MAmcS7scjYPtLbxZiz5OJrxrrJGMUMmBwW0YUG2OSv5+d8WQv3PaCr74GMlHzQjGZunNi51t5bhLPjTM1txkG9MJ4n6iZCy1KOJnDTXoDiVH2a40vx9x51vvl18edtfM4RSZOqDkTztjeVOwlV5k6qik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=EmVrkmPL; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so1921203a12.2
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:36:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505790; cv=none;
        d=google.com; s=arc-20240605;
        b=cgCtxSneFT2Y6Eh2Oi/MYzvGTOOepnRH0uvmkec+zNjrpd+uKhCsVB+pOoi6JShgHy
         FUM0CSBQ2VNzX74g1ch68uEnRSxuIw4eAlYjiSBRihnRzAtCSRGRFfF+G4iOebB9Rg+W
         jISCytk3Q7SfT9s0h4xyl8/fU7t21NdR40nGI1wG1s2HvLSzwM8Ae10VGRsLArDlIGDa
         4BYvDgrwNyIyg/tFdiJi0xBr3uF6YHry4OaL+kGcq3bF4m9NSRkmgb3Abs1ffA2Yakxo
         CBihmI7XyCPuUtnk7aRPbOXezxHZwGjPcEj0UxizY906e+6Gvf8/a+uY+/PXZbA0j2t7
         6nsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OA8pnSGpkBBg2tyKEwAg8tDi7u8iC/ssDeQrqAUXOSw=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=GURXEziPid/83mA93cEpfF9eGPXUNX8ygxV5bZFirJfoIUvjfEgbh1BqDBGIDeX/oZ
         oHRlTJ4eh2HZNo0zR1DH71/KkZ79JF/aEDq1+IuJgZyElPFpNWi8GglgBsFEja4ZS/Cw
         VTe+FMmFdTFYdQ2e4kx5OwseOYkuf2krqHSBatfct6WqXP1obxzFqyNaKNRarfaWTmUz
         WDV8ZsXf7ToRRkgmO1zjTgr3Tb8QmxvPXoO3WpaFDqibaJq0LPDUc6UmO7Vbiwd9i6fB
         jHJOeV+HR8dCvZM6ishkXNhb11sChJpJu4tV9nGwpwTHJFTaWIUWFMMQhj7qYHefkvnC
         I8bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768505790; x=1769110590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA8pnSGpkBBg2tyKEwAg8tDi7u8iC/ssDeQrqAUXOSw=;
        b=EmVrkmPLahYHIbCGCh7MuIyMnN9NAnlMm43JuWc95OSuZuZtzBiTJuqUTPhV34ME0S
         POJfMaGzA+DNXNNS5yTMmdVbMdjm6qvWsYZaVAG/mqkA5Umfc1G5dyOa44dnO12JeHMR
         WGo5d91Hw4Nv2lED3yW2lWcjZcBFpKcQvnULvikLu28sE2nHDDZPjDx8FbGgKK2SC3h2
         i2Glhs6n2vyAy6gzubV93ou/Y/F2pBvrohPs+DgdZs7YLVo3arVYxLUrN0eOhD/A7M6u
         pBRuJCRNJFUF8CveRXKj2AQE0ITHwAlGDfvrZ7YLZvdDXFL2dZ/1TldqDoA8qtNqqNUR
         LSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505790; x=1769110590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OA8pnSGpkBBg2tyKEwAg8tDi7u8iC/ssDeQrqAUXOSw=;
        b=rFcCNhiTkcGWmdJkejMp1Iqa2sS9Az5aYF2QcPYxJ3GrsB02xrXwaAtZ5DLCUuDm8q
         cx7l3hyG8rYNSvmTYke7coXLJEWsxOLEr0wrSht1t1S5ATQ5zDWcwPXs4HJDbiUhybAq
         6PQEQL3C/6zKG0BXhjrBZOZylna48jE2MOR6pOXSeyEvkU60Pz4bKStWkgxqxar7xwQp
         kKlDbmdgQ0m+eUbq/cEh5BU/nD35m06nBtQkEsGPgYfR8OSqbYZvP/crEDy6wpFV280X
         WkTJ5uCc7Bk0lPtszT/qFP+YIF7qXWTrIQhTLUMfSrtnWVjuOmskK92yMAT+9AvBnYfu
         N1dw==
X-Gm-Message-State: AOJu0Yx206ily9cUFAviRVY8BLgWiRzUo5h25BnnAOce1FQnJfz47H0h
	om5bfeQZRttJ8jjC32X7wMWkWHYGYzTZvZhaz+QU+qz8+xiy6lUDYxKwLOmjEULnN1zR0Bpd8AJ
	BdOmIzgo+fMJlpPSVut2U/4mrtcAxMQ4HDda4thjdmLTzg7xLgAYh6mjvt5VrKvtcxUAiLgk9kQ
	sQ48HORAuJZGbYv6xHNatQYNrCDQU=
X-Gm-Gg: AY/fxX6W/1JqI19jfRJcuMTq17HeOMBybj9RRx5BCHsERBs5Beh32JO1SLC4SCPu58y
	E02q2cNnw4PgTdmHcknhXt01SWEHZqJsDb2w/dGzXoRYRfEfcuHpDLqNLSwzOdKCZLHrHahcQbG
	9GYG4SoUrU2GSZiyYqdVlofxPEQ/oBX+2tm5EW6J6gWOfiTXVU4+692CinJY/kQAwrQ8/d0e4ip
	SmB8K4fbT5iFy0J5bilx0J9w6tVASeNytTDw4xZ1AmwkQ12WCEF+MY7vgQZBpKkqe7xOvph8efc
	8vTQl06UxgMXavtiMDsngDVjqjiXaxaSWv0lOJU=
X-Received: by 2002:a05:6402:1ec2:b0:650:891f:1c07 with SMTP id
 4fb4d7f45d1cf-654526ca179mr489861a12.14.1768505789730; Thu, 15 Jan 2026
 11:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164143.482647486@linuxfoundation.org>
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 14:36:18 -0500
X-Gm-Features: AZwV_Qg9AMTX8q9-yVkwdpHe9DJ202wYjtxwKtFQxf_veZlFvCQoozqtWFMtgrc
Message-ID: <CAMC4fz+yyCbgLbgQZpP2swkqeROjaz-xyqyPf+DBtWOLGzieOA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/72] 6.1.161-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 12:11=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.161 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

6.1.161-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

