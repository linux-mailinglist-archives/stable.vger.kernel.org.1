Return-Path: <stable+bounces-136949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F19A9F904
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2781A85B30
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96B296159;
	Mon, 28 Apr 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="B7pZea47"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE012951DC
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866755; cv=none; b=cA0B8M04xzR9o+YCwAzPRH+lkPyRhz0QM7Yab3ZEcQ5c3BkTdMPfAeW86Ij0RVTh4ciw4GEOUccyP5CtKhJHu4pFGiFdl0dtTtCxIGkUhW0wJBmzmtJ7b+U5UIYv6i+IG3771zsOgfqvKYUIZuM+MsWfDrF9tbCsTZIQ+ufvPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866755; c=relaxed/simple;
	bh=ZEMsEuFETnIis/f9N7vK6hIpdo4WY0dY1VYGCezSA4w=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=qGRRKc5RdyTl8VkyuqMjGz90ArWCdYcFd7isPU0xQBU4iicFumzRw9OHwyVwL308wEpz1b4f52EzqGLpCrPpJTZyyhp8zP6KsgGstfFvmkQq79iUClk+UCOUAAWNJwRkxrx/+sL6MHNWWhMuWZxaQ4w+W4fbPX7Lw3BaFT7xc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=B7pZea47; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e731cd5f2adso2506014276.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866752; x=1746471552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KtarafZnu+5xX2bVxdhO12cxhaNXT650YwvCll89/C4=;
        b=B7pZea47P19xpZmBWgsDJ2ffPbS6y8reFHw9L9GeaLSCD1t8ho1flLKEHtDAD4gRY2
         Q9/YONLtfLYr4oKdNVr9Opodde4rTPYNUy34dCIyGCdepomrHsQLUzKYkqrfVw+hEzXf
         xu0nX/sAtPG90gr4atPZyWb1WZz/fkvgSu+D10vuqssnRAlADyzi3iFUCYPTr5H+SONT
         MwrZDcXTMVEU0PMdVtX9pwk6jUzL5m8MvXfEsfeM9gEKwXMQDHGLMfUnl1gyEC0uwSxa
         Lg5dcpKrbpEx6BzCRQqOzzpcl4J4f4p7h07VghUntRP3Yq7G2ATohMWaW9Gz2xiXusEl
         l8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866752; x=1746471552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtarafZnu+5xX2bVxdhO12cxhaNXT650YwvCll89/C4=;
        b=QksRLYzOO35aHij+YecNZJGOUea/KySHXpuIZvWAN/CdXShsh9titqBfw20EU0W8gG
         LwgLU4Kp5CtDqY1Qej9QvAQU6BDfpQae0sXiPEUqK+38w2NUBtnzRodjTbj2AjsgOwKo
         R1aMCgp3PwY+/OsTwmyBFNWfcGfrco4XjFe2JDm2RPrVEgag1FHqOLJ/GOXIVFRNHiMX
         DPLzpFWYq64F6H5JBuxUwqH/KFJQdj+4FXS9IVigRmHHXHwmtvpemz6e4AUlOMXJrbN2
         4yBl3w1qEhk9OBnP+wWockIh7dVKbPNI36pLTxUQKNo3r+JBwiAgsWwwkBBqV3LJB/eg
         c0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9AYNJrQUYAG3oTzIfITgnyTAItGV2k1/dwNj/XtUJsyb7kUoiHnf9vXg7shwVU8ssyYgi1So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEYlFeIMbcEJ+7mqnrCx4/0Pr9jE0rsK52QLQmv1GElIj4YiN
	0OX+mupBwXGIVKWkZcm4N2HkwOSL1yvE+km2rG8E+UTLCedzOxoF8N9IjtpKl9lUxO1Ph+LtU3R
	LgbHXpdZ52g1I8qyKPZYBtw9wl5PZDpbwOoWHuswn6qLgbnAjHQg=
X-Gm-Gg: ASbGncuBN/3lHawlUAFmBFNkxOaw9Ldzp9iSCK6HIkcEHpvLr3KQ47H4NwftErTazAF
	mHU0mjYH0RJWNBTKTT+0yCeJ2UJYq6VHEeOxuO0IwM+AJea9MzgX/uVfS/hWyzI+E3qXUKzAumk
	ULGl4K6TgV2FA6KLpY+Z5OgqapSpwAnQA=
X-Google-Smtp-Source: AGHT+IF88D+FbJMdAcgK/kh4AsHh22lPNJTD2Yrn7BNBkPvG62D6GR2V3ccEd+LzFzmrGqNEmWV9ry0TOP5xbkF8QCM=
X-Received: by 2002:a05:6902:2510:b0:e73:31c0:5477 with SMTP id
 3f1490d57ef6-e73510bf201mr572306276.18.1745866752474; Mon, 28 Apr 2025
 11:59:12 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:09 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:09 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:09 -0400
X-Gm-Features: ATxdqUF6UN7uJalUvx4RxiWweYKmmnrNHZvjYIyG48HPELKKwwA-tbcMEG03iw0
Message-ID: <CACo-S-2iCgWLn=jYqkUR_bOxwde5Rx0dgd3e-K0-kDN0mguPXg@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:5da0a9a420589f98d3a8ea7cb0afb=
ba8ecc7606d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1260:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1260 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1260:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1260 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1260:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1260 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1269:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1269 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1269:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1269 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1269:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1269 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1271:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1271 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1271:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1271 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1271:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1271 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2cc43948caad95c15b4

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2c243948caad95c15aa


#kernelci issue maestro:5da0a9a420589f98d3a8ea7cb0afbba8ecc7606d

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

