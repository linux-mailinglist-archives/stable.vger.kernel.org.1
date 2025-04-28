Return-Path: <stable+bounces-136950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE66A9F906
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3031A16D399
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D595296D28;
	Mon, 28 Apr 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Rg2JNHZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717F296158
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866755; cv=none; b=C8kBgmnxGyKIJ5q6yw/5sa4xG+tGV9n1lLPu4hjhX9UGmrjB22/DSJ/LpMBHbLzv52E1W0x3rr7ounflAder9VdQY3jVAf0imc9aAW9FTdQI/mt24s4BQxHyysjM2au9FD9mgOTcOr8vEl6g20fJMyCo3Ot5X1he1pT3T1X2Gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866755; c=relaxed/simple;
	bh=ILZddCs35LEbKbkSPJobjAMI253uNFYoRQsygjQjoJ8=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=etzcFg0oHJ+MPDbUuyBmYdNsWy8hMZw8661PlBwbbg6lfQndkbHKVh3wmb1SlnDhVDprrlSJJK65xScNEopILPUrsjEJXJrUXVHvrLraiII1QbisSLNSz2/KGOSnOMUGbSLcgvWjr9br9l+/XCCgvvt/Lp81mSFI1hUDtEYJss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Rg2JNHZK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e730ea57804so3723630276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866753; x=1746471553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHp5KEewjGokJGA/46C4qDkJb+8wTnSpKvm9nWKsFvI=;
        b=Rg2JNHZKthO8CWX9U2bQyjrWEK3mAHcFqutejw1iBaJmA+feGjOxW9Eteqo49ZqVaU
         6sDMcUylfmjRIlAnPT52x6cxgJMPstxaB8THkGp7AXxuhA09wJzDC6LMIJxqtWB/lmo1
         QTSENtmXhx1NgbAllXBV92JA3Dd/2lGPqMOmOC5gpP07xyOI5ZcH2L3Ykuah7dTTOamz
         RspxAfx9oC/eBgMBO1THuFdcLKjw1RcgawVe1Mp8m75Ev7UP5Szc72zZ5eFnVEXM1SLg
         shiYcRU36dYt6owSnmP+GdfoYLvxNdotheHWMA5Sb/uJYyH9n2k7TFdxCqKAKDL4CND+
         VStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866753; x=1746471553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHp5KEewjGokJGA/46C4qDkJb+8wTnSpKvm9nWKsFvI=;
        b=gGaEOIA1XN3+vXOfRsQZx76zn59hOBGLQpL/F1uM2inccSyIqPfOFS84MAfyXyMW2l
         olmTBpGjPzVQ5UuEAZu+tGIut7tJ6VxHPYg0BVuLb+ZVgnK7GIsvNAjOz1SnZX61LSCC
         SBdvhF9JgvZz7lnMQXmDbthorrdtZZzn1OY49H5SE+hJaL27F59e9ua92sHEBBtwgUBL
         IrdD1MtD862YNdGYyQg9If3ic9wQXqAVihroUGBe5544+eyu5Kb06+7OeqmC/EMeQnOA
         +f/DiRFP6MAxNHqr2ppd6VqPjfBF7c6X9WI2zEpZG3PeOPJTi6oQwqN5IXh0RAdmtkW/
         RDeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBx/h9oFr8OnIHXvJ4YdtfvbOzppHSkziT/AkIqRJCvAgJXcPoXeKkxAlKEjnVxvfdgXw7YWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUdIhgRHY7qxW6CqOZ1fYlUuB4vryxyBhgHPvz5+D8d+WrMAr
	A3TcshrfwXItLSP8DT2slNMblVnUhpifRcMPYQAeZeO5lIHpSG44u6f54iVfOx6WHiXUjlOzISl
	B8iMSG/bsDsMivRiQkIcNDMpRqcPzmx8b9qJBEhPbkd0CA8UYMmg=
X-Gm-Gg: ASbGncsz1U3QwI5yaNz9JjQp9e24vi1fBWYkFf/uTun1a1TWZQB+2iG5ZZg5xBWDuQQ
	R7g+MqOomBKCdBiCHRJmWXCgZL8ym1hy5MZiDiuS/8RBqISGPmSeKXP0CakChCcA5Uo6LMacaxS
	4IxSKSsjXNbCaKyJ1uY30y
X-Google-Smtp-Source: AGHT+IHsPN6L1vbgloT6zLQ4PGVFtbcsBRQGSj53te4SQUEmyXY/AvsVv7UBAKOKXk2ZxNrJ61VU1vj07gZlBb4vJG4=
X-Received: by 2002:a05:6902:20c6:b0:e72:81b7:bf80 with SMTP id
 3f1490d57ef6-e73510f3336mr532942276.8.1745866752593; Mon, 28 Apr 2025
 11:59:12 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:10 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:10 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:10 -0400
X-Gm-Features: ATxdqUG1dsf4NZqLRlAJAR3-ElgZXfmUcjZs7PJXWQb6cB3hUsxdOgfDAczeS80
Message-ID: <CACo-S-1HzQdKMRuz+BnCmHkinkPSRd=DTSqfr4W5L91YLq6o6g@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:6ffcf98c66c5d150243f133e2b654=
5c2360d68a8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1417:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1417 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1417:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1417 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1417:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1417 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1426:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1426 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1426:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1426 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1426:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1426 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1428:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1428 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1428:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1428 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1428:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1428 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2ab43948caad95c1595


#kernelci issue maestro:6ffcf98c66c5d150243f133e2b6545c2360d68a8

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

