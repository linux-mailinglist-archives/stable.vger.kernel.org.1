Return-Path: <stable+bounces-135150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB27A971C7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D28A17FD2A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611FF28FFE9;
	Tue, 22 Apr 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UMvgAo++"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404B2900B5
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337550; cv=none; b=cXw4Na40iSbiQnVhm0BQcmEG5dDf4zet6pnN9Qc3ZWWpuPrhONC0J4EgxCyuEYFl6hVneKkD6GX+ZiN2ahcs0Y8J41upqDT7rUACp9lWTRy6PsZQexaAXAXYt8FXw4sTxN4nYfJbCxrpXK9hkwpIoOYySezEz9CpzuiSFadh/TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337550; c=relaxed/simple;
	bh=R2pl/oxO+cwvYpZLpCXudQcEZ+EVvgdkTiHjBytS3j0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ipn586cE8gQkBkNxgDi5hIzoD03aKh01zCN5LEg/NjiFY0Axx5fj7IwlMLU3lR3DZJmnt3ee7+5Wf5qW+KJ3q3vtcfR2XwcxHMMOy8dE8wWAcpGFfX6mGREidfhXGF+awTip4BKG2y/KxywXuwxsy2H8WgJDM0m35bPqYBc96p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UMvgAo++; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ff1e375a47so49145337b3.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745337547; x=1745942347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+uBZLFTOOlIUInh+ZoQEpu4XA/i8pC3scdMl4eTW4c=;
        b=UMvgAo++YHv8PDv5hvudzZug512t9OYAexnRwJK1DKNqD7NPSdaKiANAHIE9M0tFhU
         Aq3hLwQj8z5YuP6mz5TcitLCUkzFfR+hHd0thxW2Z3aqK1bMDYZOZ2MbaG+tawjaLpGx
         GBzJeZJGzYK8vJASG9Q9ERKYz4gotUcjKbnVbiD5DTAXk5GcnB7ZV44AUcSIqBHVufj8
         0IjYt4Rn5TV5VvkjbG86u2wk/XeCreQiHNH0JoGGVv/lc/Yqt7yeQ1kn5b+IH8CkIhVd
         /WVqBfVB/8ajRAqxBgQqh9IdIrjN74ocCRyKmrmAxrER52RyDZbp3M7NrfTesR5MioEY
         z3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337547; x=1745942347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+uBZLFTOOlIUInh+ZoQEpu4XA/i8pC3scdMl4eTW4c=;
        b=SXkefiB+zw4brXxf4xYQEFzNIkttgkdeIhVEyFYgA/2Mn0NT3nyMsL7qsHbHbifI1/
         PTACn7YGve8WQ8/9nD/nIaeQNAm4l7fhkoAcrCQXZhLj0BMI1dWTuGSfQ9HE8gIoGns5
         GhdRHYnnjWaTiYzz4MIVimfLUeW59cmdD9z0mmymBOz2raj8rufpEFa+s2r/ZnK9bk81
         Up+Uqw+0Q0y+sFANq0Ne0PdPCeadMJkO9sQDigrN3Sr5VgY5UHs0Fg4C9hFXHZiebKI+
         5fnsORvh+iGjsq5+ZdVdcgjZyWbM0xicyoiizYbsUha5+p8CKusre6fQ7HtFDixzk4TT
         6vmA==
X-Forwarded-Encrypted: i=1; AJvYcCW7s2Z8NPxdt622mHFkrSfJ+bVZdG03lCg0xyYS30SmwcQnHQMKMRucBoJINk+o+ljGssCDGfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5MmKsHCWpN1VMAD1sv44lJrv+Y8VsKelQocFiSmBXW2NlbO9
	0Ak6yO56vJug4pYIoemP598tJuOgUWBmTZZz4i19v6JOJISakY/6CQKCkp7V7uyr0mDy7Y/YZ36
	xDkkhfvbQZF3Ssz6p9p5JtXrNP3GeSj1Ww8rwXQ==
X-Gm-Gg: ASbGncudv2YkFJwWCZ7IIJvYLV+oU/3/pjaLaukpGrqGiQpL6gxFBzLVkl+O8U77Rob
	whKB+ERY8oZGXT8q3bWWnuzIVId4bdFbGmgsUSihUWUADaPGgTgOLj73D+0XE8O9Ho15UUcX1dk
	oy2hBYyR3EXSC2WkWEkZwM
X-Google-Smtp-Source: AGHT+IGc/cNoHpSQKoOAgnViH6lGj+Uzqtchz+3Pftq5w6WJ7B+lPk5nfbNcCsADGbyscni1q6oIxjT+GOEuB/C2MGQ=
X-Received: by 2002:a05:690c:25c8:b0:702:d54:45be with SMTP id
 00721157ae682-706cce101cfmr214941157b3.35.1745337546889; Tue, 22 Apr 2025
 08:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 08:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 08:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 22 Apr 2025 08:59:04 -0700
X-Gm-Features: ATxdqUFkWprnFI2Wvp6yrmZY4mzGe8l7BrDLQYqN4L8kK9yuQUMG_xMqGNnMUbw
Message-ID: <CACo-S-2iivX5DyXPU5PD+JAuLeXNm13GH=G=C3S2sibLje_dPQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkg4oCYU0RIQw==?=
	=?UTF-8?B?SV9DTE9DS19CQVNFX1NISUZU4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u?=
	=?UTF-8?B?KTsgLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 =E2=80=98SDHCI_CLOCK_BASE_SHIFT=E2=80=99 undeclared (first use in this fun=
ction); did
you mean =E2=80=98SDHCI_CLOCK_BASE_MASK=E2=80=99? in drivers/mmc/host/sdhci=
-brcmstb.o
(drivers/mmc/host/sdhci-brcmstb.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:3d78010dfd35842399e06140837ef=
f2c84b56458
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  09fe25955000ce514339e542e9a99a4159a45021


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/mmc/host/sdhci-brcmstb.c:358:44: error:
=E2=80=98SDHCI_CLOCK_BASE_SHIFT=E2=80=99 undeclared (first use in this func=
tion); did
you mean =E2=80=98SDHCI_CLOCK_BASE_MASK=E2=80=99?
  358 |         host->caps |=3D (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT=
);
      |                                            ^~~~~~~~~~~~~~~~~~~~~~
      |                                            SDHCI_CLOCK_BASE_MASK
drivers/mmc/host/sdhci-brcmstb.c:358:44: note: each undeclared
identifier is reported only once for each function it appears in
  AR      drivers/iio/humidity/built-in.a

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807ada943948caad94dcf07

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_M=
ODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807ad6043948caad94dcec7

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807ada543948caad94dcf04

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6807ad9a43948caad94dcefb


#kernelci issue maestro:3d78010dfd35842399e06140837eff2c84b56458

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

