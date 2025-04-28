Return-Path: <stable+bounces-136961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BEA9FA0F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359FC1A8377B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBE296D3B;
	Mon, 28 Apr 2025 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="buthpOvY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA72951DF
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870350; cv=none; b=Aqskm/kyYKDdGwwREnTQtmwkWgBoNUulfDT4/ugiJBVCA9yT6Q9pNaGp2kjSHn9AZYSxn7PssD9gHynQzV+lsy0eQaXHY6gBqsnDoaTqwmwpp/usqZRcy+7qEWACocnxezKbn78voQ9wbn9+62XXfBvvc7smhOAdk+a6pGMNNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870350; c=relaxed/simple;
	bh=g5v0QVWHlyXTTwLZ1kWGXyz31b1h4VfjRdxdMGVf3p8=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=OitEBwNI/Auyf2/K33dfWOQ+PDXqHBX09465heIlHybXE6ofp4BmYoEKe3emqcGW1dwBI7lyddgx3Ahm3mISqtZl2s1vqHA5cg0ULyEDBMCIwLptg8aOwP4fuKLtzlBKU2X+S6/pv5GL4VMevaQje3Fk8i3A5lD57SMw2zUmJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=buthpOvY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e72c2a1b0d4so4939508276.2
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745870347; x=1746475147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WCMLq9aIKbFN2fA8ySeACb/Yf3dTHFFWpF6hPnFQpl4=;
        b=buthpOvYfX533LitEW0Uw2kdoylvk5dA0dbwybLpY1WUD+PAJOoJoZLpgigKpC3sQA
         X1TeV71qIqf4QNYzI3PfvKa6yKonM/lEtFObKIObCU7nnf4uvPtxcby0tP/dV4LVamrj
         w6NZR8sk/3i0RpV3Y/9BeZbneXJXnRV7+Wt8Mb7rimL9jTGjjpqDm+Q1Ui1ctMA04G6+
         o4jsBtMqXRiZpvjHUR4ur/0nynvtaKpiTLtxB9b8Gw8vnkjEBjZIji9zrodfZEhTe9ps
         oTvqBgJXL79Q0eEhLH3Ur6+g2GHlsk6sALOZQe84oUPCSqhL+aMBpBUjukdLMINNelJT
         24Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745870347; x=1746475147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCMLq9aIKbFN2fA8ySeACb/Yf3dTHFFWpF6hPnFQpl4=;
        b=qG0pxV8XEhTBQiUg3YuIFuRjJ7kLEgy4i/ajzHJ+qadKVvh0u0Il955UveHAxPmOlp
         dOfX6OyoLeFEaWVYHdmts4GyQHdzqqQimAVGXcxwZ2ri6Skpj3n+RDy7zauOK9c9VTxn
         GckU5u+4MfpIyhpLbVKuLQd7eDE/71zurqALN588nmlSmc8km/q0whznqcHrrOgz4hUM
         mSMhs4PUFMME+5/NJzVFTvP2krwAPppJhZqtwwk6DWy6rn0r12ZNLVBS7H/fdMhVvE5X
         R3bVp0bKiJ0cI2S0LVe0xqD830SC/GWQsq3+7nFC4e9bXmPXJX/3oDiR5dLeD3SJ24CV
         KppQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKNF+NLqbqSGRHNK820zYi3+/bfa6IRUlIXeqH7bDAka4zAoeGGJ4F/TL64av5IfnTRPTxRog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLfbacM8lHtG6yzW3Ebo2M78vGUWkqJapgD/SRFv4f15wc2b7
	CAfd5rfcUO74Ni8yCaVOP9SQKrhn31x1d9WzdrcGqbNbrXyhxBxrCarrTcIAHPeUZd0cmMopwJ4
	snu/QhPuMkKf7Ldd7BuZbPmGccCozLNyxFlYtUw==
X-Gm-Gg: ASbGnctIIvL3eOl2uDmgJrh/TlV7941Ot8Jq7zoyaV20fvAqX40EBI5rIowfpng0acE
	4l6i6gqcHMv4vmOEynsPAoRKr7xuThyh0Wo3pU/9UKaSHFcqinSJt1gYetsIHe1/lMREkPOBX1X
	DQu7RYO8yCRR3EyuNyGzIX
X-Google-Smtp-Source: AGHT+IEw5KnVtcq1PBhAp6xTpOmrgdpj3vNLJKRVmXqstqzLblYF3D3oPr0+uNzFCGg80f8I7KGaPKtCbcCg8Z1P/CA=
X-Received: by 2002:a05:6902:2686:b0:e6d:f287:bf8 with SMTP id
 3f1490d57ef6-e7323439993mr13768576276.35.1745870347097; Mon, 28 Apr 2025
 12:59:07 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 15:59:05 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 15:59:05 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 15:59:05 -0400
X-Gm-Features: ATxdqUFJR69Ra_SeCMhv6TJNPveWQvh2A3QXEomKqZkAlwwv7cD_l45C1MS6KJk
Message-ID: <CACo-S-2aKAx1-uWO_TRG9U=X5NqDRH+yus79+f6g3r5XVEomAg@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:919d41f0579d64c448e7226a3a954=
b0c3f646d97
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1492:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1492 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1492:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1492 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1492:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1492 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1501:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1501 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1501:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1501 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1501:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1501 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1503:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1503 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1503:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1503 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1503:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1503 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/arm64/chromiumos-qualcomm.flavour.config+lab-setup+a=
rm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc27243948caad95c148c


#kernelci issue maestro:919d41f0579d64c448e7226a3a954b0c3f646d97

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

