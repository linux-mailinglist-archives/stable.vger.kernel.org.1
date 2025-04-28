Return-Path: <stable+bounces-136945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F60A9F903
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB537A574B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1829614D;
	Mon, 28 Apr 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="OJtvYpUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615C296145
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866749; cv=none; b=Ra5Yr/I9tZEmwwh2mYZH2tfU8xeRhf/JeLpfx17UmUnW8ZsiSr8YKGARWNVtChK4UJpsaC2JW/o73e8a22/o0qTFzcjDIjxaczyuc+m2zTq3OLIAhpBcgBvV+YmMGRHfKoLotuJf0ik2ggdXi2eJ30OstFl4eswOiUTVL7gSliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866749; c=relaxed/simple;
	bh=KqCN0LzPDKSe0Ij5RebNdVoKgTXl2SHBKGAuYHoNPaA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=EgdjrSlb423euJD9M36rNKcXGMaFyJFdNEfWhnhSooEcmrsjcO9f0GHyk5C0YsS4YyRr1erONacztEJK8GYsBSV0MlVjn3Gm8QLFD6zP/jthFlFQvInU8D/Bgn4akonbZwS4yHKQ2bwnaWRaXM1+bxCLKk+GY6KkydlcxUXm3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=OJtvYpUr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e72bb146baeso4181905276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866746; x=1746471546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cisemAZshsRH3or5DXemDiUTodbEGL8aw75zdsolzW4=;
        b=OJtvYpUrtAwWsIeX7Nd0Ol2WcoXplIw8h1BUBJYuysb+Y5lFlTnx8TR5yUWD/JnJGW
         yiYDphqWSv+dd00xtIOvlfu9jB9YNojD0KXHD3HzUgEhtZTep1szKReZV4r6JzGRhW5f
         u89E8wpRAH5zQYvitRee0t0SosZE177HJmU4tgWye/D5SSoFwk/PrBUsiigXbCbvvTsi
         36+YNxErAPX08gO/nEpcdeeX967cHlUTfz9/KD0m+1LIHmLFTczOWUQgdRga1W53gy9q
         407P7CMNsVjNZiT4c7WMy16g/yyAaGQjFjkSPwiP8cnWaqPqFJwXKrZ/Wm4IOa66sZRy
         8IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866746; x=1746471546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cisemAZshsRH3or5DXemDiUTodbEGL8aw75zdsolzW4=;
        b=c8CcrmOpjwq7X7wr4B03+UvGfynoGhJ3RVJdvLMIC82Um/LvhjGZX5xVfFfyD2OVnV
         BQEe5fgaKN8V6rJFSHsP2t9BOyYAkY7gVKDqttoaIfnXsSPB7immdkGhVKjh7am9On40
         jdkv7TKR8IgM1pv7355HfJbswNKuRzjkdwoM17I2TQ9dk6Fp29gHRKl8+AO2+tYbb9ib
         wuiQZpQ/nO9pMnZuSeX9tYkcCaupb8kyUSQQC/bqM4Ar1RwnsRRRccI1ZYMEbhU3h3iY
         kPlbIPqlqdqS7pk+pgDLNpKjuD1nojwEiUtU/IP7Q7+Yq476pqoCzOspVuaZel4lmpAR
         goZA==
X-Forwarded-Encrypted: i=1; AJvYcCX4GWopJb6zihziLA/rmVF0+srm9KGoAQjDbEJjavWW/2674uRa9KtH1u2ouF5sUZOp7A0CvRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMmbLUptkXpxbxqTeCb9GJZnlb4LRGNC0BrTx4aWTLWioZ58o
	MPoM9fJLRk4L+/DVbwizkgg6zjF7Vl56YZ5lEZfUVwcEqF5EmN27hMQPYLPvvqnIOHlkKZ1qB32
	r18oi47J+ggfOlYivttmRn5gbU5tAMDpJTzUiHgJIRKQ+PBn0tkQ=
X-Gm-Gg: ASbGnctJjOLj1DqJiW9LzoIVI/KC9Nco7rbNP/oDdMJ+g2GrL6vhMjX6pxJcyK9P27z
	myVRgHbaTSZ2d2uz8cKlQHEVrjAvNEZDsI61TE6hxMA6XL+MhHFOM6a0FCQ2LSyb3kT/41fVPYs
	DUzH9YDTHK2PnBdKF0eMQz
X-Google-Smtp-Source: AGHT+IFsr1J9CKPWiqZbXtftGWfpeBF/eEQ/LTcBiihwBFuC0sfFLQvS7OSTD4cIrbit+XMCqy+E9Gsaq0U3Ct0cquk=
X-Received: by 2002:a05:6902:1b03:b0:e73:334f:30bc with SMTP id
 3f1490d57ef6-e73500b1f38mr1150884276.38.1745866746495; Mon, 28 Apr 2025
 11:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:04 -0400
X-Gm-Features: ATxdqUEwCvOpWc48Bmlayp8lP9ewgyVU9MStqS19U7OH4OkXp0nn8uvvgbkqgYM
Message-ID: <CACo-S-35N1+FZPuwtZuNnCHyO1zrYFc-Z4mUrJS9-S31cUaAoA@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkgZXhwZWN0ZQ==?=
	=?UTF-8?B?ZCDigJgp4oCZIGJlZm9yZSDigJhCUEZfSU5URVJOQUzigJkgaW4gLnZtbGludXguZXhwb3J0Lm8gKC52?=
	=?UTF-8?B?bWxpbnV4Li4uLg==?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 expected =E2=80=98)=E2=80=99 before =E2=80=98BPF_INTERNAL=E2=80=99 in .vml=
inux.export.o
(.vmlinux.export.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:46f49bf36be10baf43434c37b3ddb=
54286312613
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1649:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1649 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1649:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1649 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
./include/linux/export-internal.h:41:12: note: to match this =E2=80=98(=E2=
=80=99
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
./include/linux/export-internal.h:62:41: note: in expansion of macro =E2=80=
=98__KSYMTAB=E2=80=99
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^~~~~~~~~
.vmlinux.export.c:1649:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1649 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1658:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1658 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1658:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1658 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
./include/linux/export-internal.h:41:12: note: to match this =E2=80=98(=E2=
=80=99
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
./include/linux/export-internal.h:62:41: note: in expansion of macro =E2=80=
=98__KSYMTAB=E2=80=99
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^~~~~~~~~
.vmlinux.export.c:1658:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1658 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1660:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1660 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1660:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1660 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
./include/linux/export-internal.h:41:12: note: to match this =E2=80=98(=E2=
=80=99
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
./include/linux/export-internal.h:62:41: note: in expansion of macro =E2=80=
=98__KSYMTAB=E2=80=99
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^~~~~~~~~
.vmlinux.export.c:1660:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1660 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc30543948caad95c16c9

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2f743948caad95c16ba


#kernelci issue maestro:46f49bf36be10baf43434c37b3ddb54286312613

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

