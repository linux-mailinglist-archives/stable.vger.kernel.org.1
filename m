Return-Path: <stable+bounces-116812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46407A3A54B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2E1751BF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4531EB5C2;
	Tue, 18 Feb 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="LDP/4VEJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833E1EB5C1
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902905; cv=none; b=O5srHn8Xb69Acl5X4NXCTZd9PqE2pgPmk313zq130KyZz08rWwfD2e2Msz2YewBUXEMAq5mBMI0DnvdwipQ9TnqAvJl0Q7oGwOB1yPmNgV4BAP+8fsmzRmb3TNUae5j5O+vasm5DGenjSEfmBA51F1J8znPGJLYsH/TPJgkyO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902905; c=relaxed/simple;
	bh=VxBKUL7A1C3oPhV40Wt0J7vlZZ9K+hkbyB4chJN/I1Y=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=NE1HpzYK7puIUz+qiq95aNh47oRLv3Lrr1Tz8SnuNVsOVXlbEH0SvYouiIuTHxf1mtZKD1c4sKzc7uf+b8eBGTPzg6Uzy4HJgLjPWVnUdGrqil3hQ3Nnlo8kHcSSafehXlpAIaqdE2zxEHXmmXyHax4NnKsekbVDdz8E4qqLL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=LDP/4VEJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f6715734d9so51244727b3.3
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 10:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739902903; x=1740507703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3DLPk5HJOE7dDuCAl3DfZti38//Zfuc6q30M+5mu9qE=;
        b=LDP/4VEJ+0mxvv48JXoKp7GxenzicOWwxAkw4Ds1K/uH4DTmAsFpbx0VT7Hq4eoIbl
         jG4xUKcKRr93IuSuvUfolL5AX1RrIt9HM6OM26DybRQgFLOQKNIjTgQ1NAy/x66cPNBd
         ljlPB4jc1bKJQFDz89WqVy+uRvY9TUa89hQz7jVA7k2M5gpKZuVtGg6OyRvRUCaqwIIn
         GkCw/IS4aq6JIdjOO1tLBeqAMA52WcV6BPwFsmus6dgmwkR4foX8QJJ/dL+b5Imebk5x
         SjhClu+ReUlpJhy5fAeTYCTxxFB37Knn0Lxib4TZYPgmo+GNaX/ibZXc0Dgul3b9HQLp
         pBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902903; x=1740507703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DLPk5HJOE7dDuCAl3DfZti38//Zfuc6q30M+5mu9qE=;
        b=t8bDN4V069gBQ/7R5FDgwo1WB82lawklQK3qmLn3Y0CVKKTEf3ZjBlEzkCmulnF1lo
         WJlNR4jpU4WuEMWseJTE2KUtl2QxiP+KmZ8RxM+2YGC2YxI9HemoXefVYulvc5eU+xS9
         YwWK9JBTT6j+2Z80r0V4UZR5jXkWzmv5M11t7Gw9msP1CNDnYnApbmAAfZoLdHS8t6TQ
         FzP0ZiHWS21jigDaNE6lazvnAQvMrgyGXnM2fvQ6qVyrX574S04W8j9Cj9g5AzrNWjs6
         EJpMxM3Ll2NecXcJD+qvz7i3htm4d7/x7sioG3E7hYzX3BYu0WSZrKpCgIq8wbBFub6m
         MtXA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5Ygg7j2ggPrSCh7dEEV2TJkx1OZgTF83HdLUZmjyBln0QngGWaAHouQ7cm6KPwc4+NB/FPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvdvPjhBHt3eq7KJ81ovcUjb0KrvKnjSkyGCZjy3nL58KHFws
	UGI2qXpcQK3/JVJtYo1jU2BZTS8YpPSCTgq0nlVRToQuTKHQRGWodP1eYbNOptPpNfUpnSuDtA3
	Bben83mOnsii0FMSqBlyVh5UiTsIflFT1fjIMpuXAG1j1dDOQ4pE=
X-Gm-Gg: ASbGnctC/Tujp3k7aoDiSo8XXHpDAThyldGfENUWn5d5RDmttOBmfwe62tDaIDej9qV
	kT5muoHkDxQwKixjl9ZamyBS1IikikkxGyX1O/IL6BXcuao7uamsfcw8GbzvSqbT18j0N9JtQz8
	hjaHk+vWWWW4qNHgxN34batL122whQ5g==
X-Google-Smtp-Source: AGHT+IFiVI/r2JRro8jHkswWZkPjZaH107K8Pn/cEPvQvamYbCbM4GU71WVcxbUswOxs9SVnvtHXjVzxpG1ywBXhoEc=
X-Received: by 2002:a05:690c:6c01:b0:6f9:87ce:71e3 with SMTP id
 00721157ae682-6fb58294c7fmr132289677b3.15.1739902902858; Tue, 18 Feb 2025
 10:21:42 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 13:21:41 -0500
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 13:21:41 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 18 Feb 2025 13:21:41 -0500
X-Gm-Features: AWEUYZloxxOt4-mqol9AqlF7ZKBT0I-dyrv5vsKAksddRNGEKM77BQL8VsoRMco
Message-ID: <CACo-S-3z+WnL=LsrXvK6tWs8hBB49Lvo6Q0_FZcrxpsTDizXnQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSAuL2FyY2gvbQ==?=
	=?UTF-8?B?aXBzL2luY2x1ZGUvYXNtL3N5c2NhbGwuaDo2NjoyODogZXJyb3I6IOKAmHN0cnVjdCBwdF9yZWdz4oCZ?=
	=?UTF-8?B?IGguLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 ./arch/mips/include/asm/syscall.h:66:28: error: =E2=80=98struct pt_regs=E2=
=80=99 has
no member named =E2=80=98args=E2=80=99 in arch/mips/kernel/ptrace.o
(arch/mips/kernel/ptrace.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:609e973861db59e6d6e75d96a=
9f0f0a24ba09ba0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  46b505f46fed8d28d9f0cf8e2aace766b99e48ce


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
In file included from arch/mips/kernel/ptrace.c:45:
./arch/mips/include/asm/syscall.h: In function =E2=80=98mips_get_syscall_ar=
g=E2=80=99:
./arch/mips/include/asm/syscall.h:66:28: error: =E2=80=98struct pt_regs=E2=
=80=99 has
no member named =E2=80=98args=E2=80=99
   66 |                 *arg =3D regs->args[n];
      |                            ^~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67b4a28b50b59caecce1c871


#kernelci issue maestro:609e973861db59e6d6e75d96a9f0f0a24ba09ba0

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

