Return-Path: <stable+bounces-144711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64407ABAE91
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1183B3AB235
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A4A1E1DF6;
	Sun, 18 May 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="TTuaOQbF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596EF1BD01D
	for <stable@vger.kernel.org>; Sun, 18 May 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747555148; cv=none; b=gEg0j4rsPFpN54FMWf75H1DtAFCHvLx9FGziOT+QgDdRimQ42lUgsY6+LsYZT62AYO4+dsGUmtSdGLH0uniRw6KZVuTeWib6Xx16wT5Zi2YTFkcYuP+qBluUylP42tnC6vb7YX2GmVsSfhs1ogz+gC/7+k0ZKiHYTQlztdOgZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747555148; c=relaxed/simple;
	bh=UjItRW5vAxXszSddQkXs2J9jQ8Yk05nep2/t8sSGz4s=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=mMHEcZnwzV9G9P3giaLHYBT/szzrCI4ZvbaKqC/EAXM7u+MAOPPrz1B/xaXS5M+hcLCgevSLI3nBUZdBxtldKIXDM8iKuA3fQrj5fbkWQvgHft89kRqTpyta9LqxMEUYUU5uJBI7ILfy31m2CgyfC6gpFeUJO3iwfRyFKRmdtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=TTuaOQbF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b99f387e8so110275276.0
        for <stable@vger.kernel.org>; Sun, 18 May 2025 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1747555145; x=1748159945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SWDprU+MirknmPy3+aAvoTpjO5w/kFnauLBzbcmVCo0=;
        b=TTuaOQbF1+JOnxMNzuWlahD013xDaHARHSbhK6/jLlRy/1qAf30owkvw6nZ52jB/6V
         tX1nmYF98H+i4BiqHj4oHer4Zmo/PTFH4a6gfB/2dF2j6/q5dNWnTnAgvuVJv667eljS
         vF7sYENp7qDoOtobre0gFcQGY69zfoysa/f1GhKjLAuB0F84wCWZu4xDFC3Xu/MLbKtH
         J2Di81Q8SJmUGdJZR6uBkkhv5Br/5XckMp7UFHetUlyndwSh1UMW0+FSmweQuYT/+yEJ
         qdMGsdhVJ2uciEeAUYTQ8YwDu4XscMb9i4m+cV07/hXzRetXEA+rpHChJazwjWgmwkzT
         uYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747555145; x=1748159945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWDprU+MirknmPy3+aAvoTpjO5w/kFnauLBzbcmVCo0=;
        b=PU1YVHC1/r1HTSz30hZiuak/BkQE7p1PoIru4M9MWQ9cxRWAGnIGG0pBOHlggfutQo
         OYU4yL/XEWEfToeMywJtgZOVDrqFs4nj1qoozliXSouG0rnCIMRn9lCoH7KB5xlIHK1H
         hk0w5Gk/j//xq5m8kyGVmLNlf+y79TMljMPOGbs4HINi94QK9PGKPWXcNk3BMp2Bq7vI
         HcZX5L2LvGNx5MQg/+Y97Ms6j3kuFe1TvhcNAlpQuHG5CmAbUMOKCIVs13YDO1GZbqR7
         nH1jfrfyjVjPsCwF0xMu31rIHGUon4yhwTjc7dWrUrzoof/GyII8Q3lZjWxS6hJS/QUx
         ulCA==
X-Forwarded-Encrypted: i=1; AJvYcCVNyXeyGvXmikrVGjPc38vsGA74Xm9oHij8qjHsF8x0Ud9wrfSZ9eAbPrwtdrzZN2mY1w5jgHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwikAD4q36KHLCF+HM8PNWnLyP+I4Wp/sLTdhKeX2zRv7y+mVWC
	GQG234kfCrURzDUyNYq+Hdc8lOnV9N99oqYPkfK6TlWxRGEiNDI3uKCaSgrR9WMMBv1bUXmd4mY
	VkJ5eYeaMfgvxX9c1HHtkpFxiYJh8fu185QlzDcjOVzvH4/0snuY+
X-Gm-Gg: ASbGncs2r4J1s0upHVr1xL0AUGZE+7Aq/5qxLQre/FSkp5t9XSAbHK3SPyqldYEoDOQ
	UIbYzQ4ERvHfBreY+Wm688jchBnQZ+4M1rKT5t/5IOQjqZ0+qbv4+HXtHSq09FUTMZjVV7PGp7G
	VKMLPe/FtAiLw8dVH0KIt1l8nssj5+JEw=
X-Google-Smtp-Source: AGHT+IE8PuU2UVkY453q6kWMd0ynYO0quD/9NwJbNotVX3d4pstts24OaXUqayjw7Azu6cHwx/vCtB7WlBZxQq+126g=
X-Received: by 2002:a05:6902:10c4:b0:e7b:9220:d5b4 with SMTP id
 3f1490d57ef6-e7b9220d7c7mr3990824276.25.1747555145157; Sun, 18 May 2025
 00:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 00:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 00:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Sun, 18 May 2025 00:59:04 -0700
X-Gm-Features: AX0GCFv6_OiXkatWmuU4hCkIj95pSbxaQtXUYWZVxGMuXHLA4x44RVihYCzdLQA
Message-ID: <CACo-S-1T4GukZGCTfmzpzwWWDTqyaK8YQDKmdM4Rc3X6ZD-3gw@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSByZWRlZmluaQ==?=
	=?UTF-8?B?dGlvbiBvZiDigJhpdHNfc3RhdGljX3RodW5r4oCZIGluIGFyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2?=
	=?UTF-8?B?ZS4uLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 redefinition of =E2=80=98its_static_thunk=E2=80=99 in arch/x86/kernel/alte=
rnative.o
(arch/x86/kernel/alternative.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:9ad63ff53451e24010f8c5d4d7d28=
1c39f8e2f6e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  615b9e10e3377467ced8f50592a1b5ba8ce053d8


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/x86/kernel/alternative.c:1452:5: error: redefinition of =E2=80=98its_s=
tatic_thunk=E2=80=99
 1452 | u8 *its_static_thunk(int reg)
      |     ^~~~~~~~~~~~~~~~
In file included from ./arch/x86/include/asm/barrier.h:5,
                 from ./include/linux/list.h:11,
                 from ./include/linux/module.h:12,
                 from arch/x86/kernel/alternative.c:4:
./arch/x86/include/asm/alternative.h:143:19: note: previous definition
of =E2=80=98its_static_thunk=E2=80=99 with type =E2=80=98u8 *(int)=E2=80=99=
 {aka =E2=80=98unsigned char
*(int)=E2=80=99}
  143 | static inline u8 *its_static_thunk(int reg)
      |                   ^~~~~~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## allnoconfig+kselftest on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68298772fef071f536c11071

## cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-s=
etup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68298702fef071f536c11015

## defconfig+kcidebug+x86-board on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68298775fef071f536c11074

## i386_defconfig on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6829874ffef071f536c11056

## i386_defconfig+kselftest on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6829875efef071f536c11062

## tinyconfig on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6829875afef071f536c1105f

## tinyconfig+kselftest on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6829877dfef071f536c1107a


#kernelci issue maestro:9ad63ff53451e24010f8c5d4d7d281c39f8e2f6e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

