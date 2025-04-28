Return-Path: <stable+bounces-136947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03621A9F902
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AAD1A85720
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A65296D0C;
	Mon, 28 Apr 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0sHYVq3c"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BC296D1F
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866752; cv=none; b=G1OatV3JbI5odmfwbujepRDITwlOPxR26d4vLL2xPaKaiwiGgAWGJER9BHKDeBdkjfWWiyjgSiic91foCkCRXeGqfdADfDcGt9AqBIoIfXCXjV2/K/gA+6xGByjBLBKLUqmdVu/PIUggToLoT05+RWEMj4mgqhLf2fxNQKg30+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866752; c=relaxed/simple;
	bh=hX7eMVycY1taeeP0/IoXivRLzV8ZKR8sItjP7ElepGg=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jz+dynZKCKGP4Ot828qqDbvtKv4onsRkKR5Qh7lmF+drF7ucoABlvXk3TFzS62yM8W2ZvSCkWN1pbG4gEQ19Wzse2A4pFDsSJN0/PROGwGEJv3K67Jm4R03hLAiguyTxdRl7RnFUa6AZOLsi8ZLoGCtcRtCogNDdGtyk0F+AquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0sHYVq3c; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e732fa4e2f1so1807507276.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866750; x=1746471550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qorpiJ67vTNCnetQDaBOCazX8jc2XRN49rRebTRh2ts=;
        b=0sHYVq3cJNQRg/tZbDDY+9v45c3CkQcSY6cseaJ3VeEd8BBqcQ5GRU1Jcrz+ZY8/OS
         08os1yHpYXJaEokTbCO0GkcSU+z4PWyKl7j4adj5nbLONxy0tjoR7LzDfBe2c9OtfImp
         7C07DFipskmwSDXmiZjaXjA3uYaWO0rC2KjAFcItP6XViLQ5N62kA9Pje1t7s6SPoDsR
         wZSwyNmXFh4P5tGfPW97HPghjcm74ubRBHRUNu9m07W66NvmebMYwN5rr3DF0MVVjw9L
         7h4NRGZARWz5wbhv75yibkU1Jbth829lT+NFZ6SJROa5/XHEC1viHL/gyHjLek/GGOK6
         pzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866750; x=1746471550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qorpiJ67vTNCnetQDaBOCazX8jc2XRN49rRebTRh2ts=;
        b=pv3JfazfehLPl4HXNQ3/i9LAUIDFIKXOoi9bKEcpKdj3p9Jk3sGSgQJu6/Rm7JxbwW
         laYjhWVHsIibdsSSeNjsXIdV2ZUi+PveXv3ZK4ePtmIbt7g+zR/xSdnU7re4/6UV26Gv
         CETzJ7vyAQGYwx5PLNL0fVSvQIJ0CrkY+Iq3Lk7JCZy3OeRg+KKt7iAXW0ehIx8zjeBa
         +rRUYDocSPRhb2RCiC/TWTLfql0yMiEnGA7rbmiaU3Zku36CmEanbOFUm3xBskbkqykK
         qM58HB94OCGjx5pXD03njhxdn6R96f0Qr97m7eaJEPj2de/lLj8K/D8HiGQA+OXcMD7G
         Hehw==
X-Forwarded-Encrypted: i=1; AJvYcCXNbco/vqIbonjmPUpoRvUrsbi5UFmEQasamjRPNuDO07bnc5htCuAW6qwgpUVf0+/QWEhsMJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Qy8GXO+PJ1J2FhaHVf29KzaIVlTlhuV6IEKLpLjoPihJYODw
	W8k6Tkt/rS6BXAnLsUSq/7qRP+1Y7IYpONuHp4FGTLO471jRzse+A1XGyxmsOJc0BpkgYoebolZ
	md35OlnjTnwwB7ADbQA4uAjpkhC3tSkb3/ACHpCCVXPrcNSbQZKo=
X-Gm-Gg: ASbGncu5o2Z7Mch68W6WBQZTdkyo87SuJIdncX8M7MgrwkVhCw8iOM/B7aMHemm3+1o
	7Jr2EjKOkhjGBNQMpjTU5i63HNpp2CMtwULj5trrnMNyGZqnptwmoEsgRPN5v1GSGvo30cyxxEo
	anQcOGuUNIn9OlDB0B2MjJIcL+QAWH0Kw=
X-Google-Smtp-Source: AGHT+IGht9heEGW6n9ar5e1UEHvDUNNOqLdqAeA1BcUTcW9TBl1wphiJrGtxDhlIykLa8eMe3T1MdiGEvXJyp1MGM50=
X-Received: by 2002:a05:6902:1024:b0:e73:2a10:3ea7 with SMTP id
 3f1490d57ef6-e73519bf0dcmr115276276.10.1745866749545; Mon, 28 Apr 2025
 11:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:08 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:08 -0700
X-Gm-Features: ATxdqUGcdULKVVgE45-6Xqrd4YEaGmKchI_NGaM11icBCzubvni1OE_k1-rE1-c
Message-ID: <CACo-S-1uu=hu+nL5EP0nVkpquYuoENjLgkKYtufnF4hR=D9q2w@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:b3bf65712cbf0afb6965b8e30e3b0=
b32d73bf462
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:2011:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2011 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2011:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2011 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:2011:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2011 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:2020:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2020 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2020:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2020 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:2020:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2020 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:2022:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2022 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2022:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2022 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:2022:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2022 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-se=
tup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc27b43948caad95c1492


#kernelci issue maestro:b3bf65712cbf0afb6965b8e30e3b0b32d73bf462

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

