Return-Path: <stable+bounces-136962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04710A9FB7D
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520441A87405
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26381213254;
	Mon, 28 Apr 2025 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iY1kVYIQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDD20969A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873948; cv=none; b=FwKvbEagTt72BQ9dxMr38cqEncNJZsBm1Jrc8clVxA3Wo3cJkrKIIbeICWsiJvy0jdtJZWzgAsU1X9MDXrqO9T6jCSzqUbACynCRTEJc8gMQzavLpQlk0EAYZu/ycBafC/tosdFVQ9Zdn0EXl0sh7R+1R7XW6sd/UHCJrFIHexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873948; c=relaxed/simple;
	bh=C3EowzJs9lOMNGi0zpMcYhMT6CbMOUSheGIRg92wBJ4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=XZnXboKRJRFEOxIXQOCEcSoqycjwPMu5+obytyzJ6fiTx72y7A6EZ9NPEbIfUwwYpx1geDOmDgaz3qwBVM8T9SyxvfSjh9tygO4C9U17t2tFj1Ej5vxi1k2Wu2+sG6Rn6KxIBuJv8/bqiRX4Lr/22MZEV/v+dtKfF3Exp+l7v0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iY1kVYIQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e694601f624so3985876276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745873946; x=1746478746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IWYKvfMc6EMNyFmb0QdU5MB78CmLLIcQA+wZKMR3sPU=;
        b=iY1kVYIQ2lbypoRIrj74T9P57BAfkGvLiiQXraQefzrSOx/sKcwCz9bK3NNt/tWh3M
         v7IxejDp9UZ0/rETJX/j6nzTAgWLKJhyp+8HsKpLbo5EC+RqyWaelO91MSv/3LoX+ita
         gYadouv8tpGUt9DCAHXYJyPAzEynG/rgz0UvNrQMey8/oNpqa1p2F7pv/TmWTMzp4QHy
         N/7L5P6CtsDdUc3WN88qqmBCf3YSw1P5sgcaT2CJiACDF4gG89OICZEA9U6GgfjN/T9O
         J4PgvO/gcJlkGkzHeY3wD0BbezwZRnQNyG5Yh2N6yHMHR7iz/KaXtpUnX6Q3OCas02tY
         TY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873946; x=1746478746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWYKvfMc6EMNyFmb0QdU5MB78CmLLIcQA+wZKMR3sPU=;
        b=sV/gRukp3xncFNq8NFpVRy5U4Em9iSfTCUDFpExgtr0AdA/AWkHMCt8AIcrSNnTfF8
         EVJ+uFBiIJKQfx+Of9v+hhEB/fVclHsURYHHW9Tt6UKxUGKo0+PcxBq0UqoRkKJRU9o1
         pV4yHqBDfm/DSZRgTGYEpj9M5XtIUZCeiJs//e/7q17PbWX2H0UKDJKiFqiX1koR2afn
         vrVI7n44p+jtUvt+cp7o30IVM+QjVTKTZ+TjfJptVRhy/qkHjVv3Sl67LmdOFHpi0tWA
         k7Qz6+Xbj8k5yGypXJEx4nlJuFSkJSlQ1pJlvDG4dods1LMYzg96kKqymji2VbNiBJzb
         AUUg==
X-Forwarded-Encrypted: i=1; AJvYcCXwWxuCAmL/HRuzS/uxSiBzT7sJyhaqVM0ha+Lptiy3BPdcqRQN7p1L38fBI3D/Fya7oUi4vjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46yOtLDlYr7iyrOxr50CzkFhQ6+2p7yUYmQkqVf88uKWkQclu
	owYB8Cg5AO++3MDIG+ySYZW2cRaKuQamFuH9HOwEMxzQylT4bLGbWqNIwwY2JNXhDpbm2AXJzGB
	bC6er/vSPawB6uNgKBi/jsf8vI8uZgQ45o8a4uQ==
X-Gm-Gg: ASbGncsRpIu5BCOms/ZSkhCTWUfQu+VjNb2WZAKsJHkvlwMWtuF+h82nr+CStPLx5sW
	B/CQ8VUX9kpGZGLU+0ApP33AfCjoIcHiUFaCzrmlgMFBGGA46y2qMTbBI6mDlj8Bsp+gEQhK64r
	407FjkxcQe7hmyfVngEH8/GZGsJwagrmc=
X-Google-Smtp-Source: AGHT+IFxXcze0JgopvNlAd/9Ea50XGZbPed3CBSeYkKG3i+P0T02F/ejGa6EJabw5ze/aTDuWAbwGquXlpyH/oE359I=
X-Received: by 2002:a05:6902:c04:b0:e73:2fd7:efd2 with SMTP id
 3f1490d57ef6-e73519fc34emr633531276.24.1745873945952; Mon, 28 Apr 2025
 13:59:05 -0700 (PDT)
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
X-Gm-Features: ATxdqUGdt94CPZxXlwpfmLHUWuWIRHQ6UVb7hTxUvGEteYPRlaM6zj13ML_vKDs
Message-ID: <CACo-S-0=nTSUPtrJBG3Oxg4akZVg3UaMu=eXcBO61z6nsUed1A@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:8421d9bd7d9712918c240a3ddb25f=
8b423e6d1c3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1553:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1553 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1553:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1553 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1553:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1553 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1562:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1562 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1562:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1562 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1562:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1562 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1564:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1564 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1564:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1564 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1564:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1564 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2c743948caad95c15b1


#kernelci issue maestro:8421d9bd7d9712918c240a3ddb25f8b423e6d1c3

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

