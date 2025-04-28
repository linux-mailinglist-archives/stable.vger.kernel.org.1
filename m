Return-Path: <stable+bounces-136963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36305A9FB80
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC543B5994
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628620E031;
	Mon, 28 Apr 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="aX121ffD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3C20E003
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873948; cv=none; b=J21Q2+NWXuDp9CkPtg/q2lesEPhuKb5DwhfkBAhuW3kO4MIOdxkxlLdOPOQDO91riXz3xaEhkFK8Htx08gj1+tp4hPVlt1bQDwc9T30jvpXBMKdH05mAZdTjeZMTXhDo9nYXOpqeh4ELCNEFrMg5B/KJ01Sh7u/RRCifyunOT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873948; c=relaxed/simple;
	bh=gIo+bZGyCJ2h9Xg0iTP5mmBhDWaEjXrsHkXgvuqmx/Y=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=J6VSxR5WWqzLcNlY6InyhvlPGvAr2v/eJXleLqrNFb1yYHgn+1GS95TZrcrwf9+Qoy1+HwK63LLzclTPyP5MdAhGk4d2QQNOAkX+VGfIJ+s6RTWLshhbhdEpI/lr+ZMqnyxbvDIvNS0b69ehVGT0B1YHA5oaTBNnonN0xOtaXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=aX121ffD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e730ea57804so3836780276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745873945; x=1746478745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v2Hy/w3RnXfZhYai102rgEYYA4JIyAB+cNPv1ESs2KU=;
        b=aX121ffDHtei0XzyFqd7R4NG3WATjzbkWzTTdbgmUfJdTCKf5FfxX/dSvgchY3u/4A
         WbwVawxwxlwujxeCsJSGvmgYRtgYUmHhlfBbesga8zK3xIpAGPRkR4QC1QvIzJZRgm9m
         9s21El0F/pnp/7Q+NsaFJ3wnddWhcky5TSOrVLCBbLJdSTHgXINoLBOk4UmQr0md7ha+
         PnDffIxF5znA0A6CFerJzFK14TuOpwGB2rKsaA71YBwDLFRR65BC5K1UABHSp/Q8pYY7
         qL0BacbJDV0KaBgEgjgEt9UJLPZotgzjgozZxeb7qytVTKl2jIW51gCcpqqv/8NEKXtV
         jZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873945; x=1746478745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2Hy/w3RnXfZhYai102rgEYYA4JIyAB+cNPv1ESs2KU=;
        b=H+XTR2nhc/7MSIA4ETkmDJp/3oJA0WRmTxzs0khs0DxoevO8tzK8FPm/BV7fGRGZKL
         4DqFrenHCksQ66gUkqVtzJk9bvjP7YbBEIKRa8fd5fWTcjmpQhP50ElPTZyfabucja2C
         vtepGT4JCFYaU48rxT46Q7sPzfg3XyuxRBgZ4i+PDWks/LhtNx5/rIJC58DW/odWckkr
         J9XKwKnLoUL1VCx05rkksb+Dv5RDEU28UcI/1JJ9u3T7oIxgjnu51VXlIe3X/bn2uAIM
         2ScRCw+HUjihWhP+FBisGLgyOwrDj9oJPEKx9wwNrB/T3r+bgoqFUHPF1A1lhzSJ6onS
         jJzw==
X-Forwarded-Encrypted: i=1; AJvYcCXwM8gzRJP6hKH77o3cTHwYuYMVDsi6gltKYYQMiqMUS6lN6+iZpXMmgMHOoPcpoimLHXBPjxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvZXWpAHlt3GuXela0e8A/Lzb1eU6svalfF+bNuI/3e+7fqxU
	9XnR2NLopDTBebsTeipSt055oB2SNuAG3ccAhE7jYpagbu9696zoC859UgbxYtnwWo6e6VUL+Qb
	yhsoTfmKeGLukt4Q4RBa0xxWH4qqbyV6IXl/gWA==
X-Gm-Gg: ASbGncvQLrUT++YVfOwTN7akJicOg19Jgbfw7tlVLDi6PtEQQMvTp1LdhEViYrdkLxE
	gbB1d9T6JwDCCnLt2GcIq0UOu7bhIBaf95YCe9PSFzyjNgL9L3dvhJtt0pJnCSb0gQbpZ8/Mzr4
	IvbasA/IpmZx4ZQEwjnmrY
X-Google-Smtp-Source: AGHT+IF6VngsfCpzHwLEEi9Kpx8JclIbKiBfSJjtFlsEZgC7HxvFNITepiuGhT5WHdlRbIRTWiu9o88U59gKe/Z/2E0=
X-Received: by 2002:a05:6902:2301:b0:e73:2ed7:4c46 with SMTP id
 3f1490d57ef6-e7351093844mr1034682276.5.1745873944865; Mon, 28 Apr 2025
 13:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 13:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 13:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 13:59:04 -0700
X-Gm-Features: ATxdqUFy2g3V3x8Nd53Ix3uLPg7DEcRJDndr8DRKthXWjUG8efa4xqUW_o1ziB0
Message-ID: <CACo-S-22VhaEWcD+c94qAjn1AkmebdTS8F49W56hmj7BCSUbnQ@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:226919bcaaa9d40e69f47be32aabf=
5e7ae0c04b9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1622:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1622 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1622:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1622 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1622:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1622 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1631:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1631 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1631:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1631 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1631:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1631 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1633:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1633 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1633:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1633 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1633:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1633 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## i386_defconfig+kselftest on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2e443948caad95c16a7


#kernelci issue maestro:226919bcaaa9d40e69f47be32aabf5e7ae0c04b9

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

