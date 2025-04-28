Return-Path: <stable+bounces-136964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9084A9FB82
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610D63BFAB9
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFD4213253;
	Mon, 28 Apr 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bsmTAaTw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FCA213227
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873950; cv=none; b=TUFAXnzR1RTdyxaGfh74Q2PLXfVaNutfuOKZODa+NfnENTnzlirWKOIDON7LaJ9j3LrM2Gkpo6FlvFIT9yHRbWj0tCVqHL8eYETMvGRkqgoYihaK7g11JdjWXONXiwS6Gf69Gm7KFTS1vNKECAgxtJsS0GgWrsFwUgmL73rtwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873950; c=relaxed/simple;
	bh=8x+dME5ojvE+XW7iP7UA26LmhsVnoOpv89+ZattUsiU=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=mtNDHcNLgpqTBwj29nka1JDHr22q7bHnZzm5BQU43+xKIPcd5STTNzXfMCtTpm/q9RJlL+mUHkxshOJe2fkvhcGNS886Al72ptMLf7m/4FtxH1bY4OrzlOzgUcAdvkDHRlo0wDcH7nrk0orXtesgd3U7UtDpVt6ppegps5VDcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bsmTAaTw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e732386e4b7so2430842276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745873947; x=1746478747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45UaEjQg/TWc0AkzZ+lNabjIytjpMElDiXM0ymr9Lw0=;
        b=bsmTAaTwZjBtwRowz5XK+jn5OBLPOB2NJRhlO59xBL8INmCT/+4RJdLyhLhOL+ZBwP
         6tfHuODAGIdlGcgYqyhp//3JWQKQ8NR2RWW1w5FL5iQerr/fpFydsQgldHYRBmAYeZ1Y
         EaZh59LFJL864RfcRweRdRmv65gQOY0+xLqyxLnkol7nh+x3CeOILNvse9tJjALkQkuk
         1QnocO7Gq1KJyMtsCqDHzgL/bnyT5dqahC5SMTH4G34l3eh8DFG+bqpaJNl3TZs4rorp
         Y5sTEn1GWg0mveZRM0/SIccji/mcj0OVPvsPtqTP+fYzG5qlugdjqgJ1p8ehQauTI1ek
         B0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873947; x=1746478747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45UaEjQg/TWc0AkzZ+lNabjIytjpMElDiXM0ymr9Lw0=;
        b=FsOZbSrVkw0ASoWDpZ4HVwP1qnwzoYy5jznVK1oD/PkPkBMO8F4xUwcDnps0ay+vjV
         X/WAfXUTdSlHSpCLYULK74hgKS2nV3g3xNwC3NU5c82yO7DxDzjz1ljhWVdQTOXjtNWB
         hFjQ3CL0fnRkLBwPhy5ao2GRERnZNGCaxZfv0M281cUE1P798HrP9xosQzb05m2+bJdE
         7Iak3m1BcibtydnnWcf1IU0pMmv61D6s0th6aqsPp882cIgxpZy9uQfmM2pT3O6q9ra1
         G1RuYUA+gz9eTah6u+fOzBUWPDkDrbGYI+G16Hti8MOaIRCfx8RdKo7PET/ycthHtf4g
         Vuqw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Vxhj2H8QXtIeUV547yYIHUJmaoSG/IacrS5oa3TPlvzvKQGgTpRy76flohszZdtsAov1hF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77RFLfLfR9SDgG6Vq0p8XlRUEhrqygFxc9bfq7wm+xt+EklCm
	T0pRRY03iKuKJqIfsQmbKycLKLyqmrPwwQ0Mom01SV5zWisj03ZontPyFgDiuL5m79VuZsiXh9i
	yNYXilZ9CBojGsfaWJv4oRx9U3kJjmVU347ne88yvrDKbLnb6f3c=
X-Gm-Gg: ASbGncveUS2fF3+MxQe3UWnaAdn+juYiC0U4dMjlYaLjGnv0jpVDgqZ+10+GhSETXNc
	Hmd3PjlahsnXMSdH7B8tVkwvuB5mEV9ysgGLnshbtyW2lxdnAtl+w9sU5mjkf3vDnhHwQ3qhre4
	svkOB63jMNGuMCTMEz56BD
X-Google-Smtp-Source: AGHT+IGbbT63FKujpACxBD71Wxb5STHWPGTu6QL9/SHJHXrSmpr1ItnwDNwZAFwOfV57yerBPHtf38n5ySntnnhtSGk=
X-Received: by 2002:a05:6902:e01:b0:e72:e0c4:fbb6 with SMTP id
 3f1490d57ef6-e732347aac5mr12549104276.42.1745873947729; Mon, 28 Apr 2025
 13:59:07 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 16:59:05 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 16:59:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 16:59:05 -0400
X-Gm-Features: ATxdqUFPiwIJYCLn7wPJpk9j-JX0pIcM6jXXDUb-sf0Fm8z-YbN2auydhCG5YgE
Message-ID: <CACo-S-2QpBpKohLioMPMvzbyMm3a7MnpnNWexw+Lmq_dZ5+PVA@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:8e2865f6194683f33bbb8b50a0b34=
432ec684c04
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1190:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1190 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1190:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1190 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1190:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1190 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1199:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1199 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1199:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1199 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1199:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1199 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1201:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1201 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1201:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1201 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1201:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1201 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc2a643948caad95c1591


#kernelci issue maestro:8e2865f6194683f33bbb8b50a0b34432ec684c04

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

