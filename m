Return-Path: <stable+bounces-136960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC1A9FA0E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D563A61BD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFF1DE2AD;
	Mon, 28 Apr 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YW6gTFsw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A318DB0A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870349; cv=none; b=oT2RZnAiZTkUaDulpf3wzyMgCiiS2cUKfeWv3/pibZSZQKaaLZM9TZhOk4E+s2UPFkJfVIIHeVyRdo9GUTT/kdTAFqIyF+dz3aJ3bZ00kGc3GGGu/+xXV5jsYlCl+5LdSi3vv7T+ZcKa72wX6dv+9Q07YV6gMnIlYbG3+SvWnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870349; c=relaxed/simple;
	bh=6RhdtTZjwbviIehBSPuYM9eQhYldWKEYVupVRPkoFh4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=WK9+XIefIZri2sG9OxFkMmjfb6f0o0d2dz5KA2miswmXbgnQjtY2qgkFKXBzfdBgdjbG44XS/x2mXoqMpfkTldEZU9/HPYIPwBjFlADA3OTDOHZ/bG9DY5sAOuo1BF1sUQlsHjhLtaSdDKbm8vYgKtq0p1tBX79ClKm3uURqnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=YW6gTFsw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e733e22505fso1358010276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745870346; x=1746475146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aem06mHQx9lNIN0bxhyyhLGyW9ZOHOkghAgATL/g7uY=;
        b=YW6gTFswnBPNR+gi6Nn7HBBr/zIzHix7Z0ev7Mv9R/qoifwJx8VcUIem1wi22lVK1c
         lsp9xpwhpUJC5/zkc6XObBcpisN5mh7LBilLcbEb5KLCTZpZU73LBk/dp/rIPh0/Sikh
         uBiH9mV3Ek//afyATNs5JgqNU2/QaGSK8pQYige/laivgYWuoYEbUIk44cH2MZZRM1Pc
         fRiXhynMxdlWn67weMxI5BP2kqwinDhJRFedw7ofUDMUSJypzRl/2yoHhmp8bA5+Jww3
         ZMgPNsvcga0Tfp5vQKuI66aPnXlm2K3wqvU2dJRoVe92vRwGXowP8eWjbs+DzO8YUu4e
         fPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870346; x=1746475146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aem06mHQx9lNIN0bxhyyhLGyW9ZOHOkghAgATL/g7uY=;
        b=TXxdVPgXLQsddRW3U14ln92GByCHQEpGgagBTohQYTFrSRM9mR67QBKk998P+KFgFq
         sCQrCM7wScVSBPKdH1o+SVJky88Y+oT1Tvb+yqW/mjK7kaWYP1hFGS28O6DGwC0yFfHT
         4s57CMvj5McoDfa9IrFGN2pIq9YbrLxdpAYe/a4T/WD0J+KMK8roPl+qVTvecdbQGAEE
         vhkKSTVLQ9avlrLo/Kruf2t2fLKFQ7pHnRdluRA1//pAPwjmD1awjHqepyumU8g/z7+t
         MIGVUnq+Z0oVF7FGx68DR8SFYVylodknjVO0jZfzqb6uBFFT88wocK2ToI1E0n28+b9H
         NzTg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ob4BTkeZiNc4FB6ILbo21s7f4Prv3q+BnTq8aAwPShp7RzJs92L8KCmcCHMzixhDickoBrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsG3qCpWePQgPUSyzqF6HCTIaWxKfLUNqDpc1/uyUxURZPoUx/
	1Q8Vd0aqhHbDLqnZcAbLZj2vg+Q1Q1VoE1NhUhN9YsCCw3zw71BWHKYuSe05YM2SSJHVPMRh+2B
	EL3v3UoUWMxjeqe1M91x/PE4S6rSYlbAaz42CYnuBHODfppxE1EQ=
X-Gm-Gg: ASbGncsushAgWTX6cit6cM3jZhA6WJjx8RyybpXp6LCrpeUGJVlTeYnzl3xbcKpmNY0
	zsGk4+BYruznhEeeV/iLbAtQ8HK1I8XQ6xxR6Hovr8PZeR/NELERj23lPjKrTN2qCm4tgXDK2o9
	T+niQFpnD2f/TxFG9F8Zas
X-Google-Smtp-Source: AGHT+IHle5FhpD+AuJUqjCBYqcOT0p8K+PiOiQ+icmdwKLr89dtT9UxTEWVr9p4wsqgHDDUiS4nAMnQn9Q/LW42ONYE=
X-Received: by 2002:a05:6902:1146:b0:e6b:834d:f0f5 with SMTP id
 3f1490d57ef6-e7351a7c6a4mr356280276.39.1745870345622; Mon, 28 Apr 2025
 12:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 12:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 12:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 12:59:04 -0700
X-Gm-Features: ATxdqUEzdigqe7GIpNes4FBxCwxmz0hCjMEZmBHjHw72859Na1dvBnvHDU0DeQQ
Message-ID: <CACo-S-2c4+gCCzKFOWE8VSfP40y5mMiq3rRRJerBrRfKODi4kw@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:481ef3f3cd91fcd1e324a4727e4de=
3d82e365420
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1126:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1126 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1126:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1126 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1126:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1126 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1135:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1135 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1135:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1135 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1135:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1135 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1137:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1137 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1137:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1137 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1137:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1137 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2ee43948caad95c16b4


#kernelci issue maestro:481ef3f3cd91fcd1e324a4727e4de3d82e365420

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

