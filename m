Return-Path: <stable+bounces-136970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF0A9FC9B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF033A9495
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764AE20B21F;
	Mon, 28 Apr 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="uFr7kxvE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8C1A5BBA
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877548; cv=none; b=N1JXGYXYJoyqvvrbV6wemcQd6aGKsrzABdsVsb04qqpOpJ2/WV+AmNFtDWS1J88917E8sK8S5rKFc8Q4nq0rGEOVoAhK22pe6tCVcwGquXUlDiuOM25ajEarUvy+MrOnDv8pca5/iI8j2dhWnR8FgDLu9vxq3u5F3DQvMfXaPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877548; c=relaxed/simple;
	bh=sWeFbzlFU165XMCDLpcjlJULL0aFblS3VOU9QPt1Qyw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=CQHKvfDE7z31GPlz5dUZJeRIb0+HKKtBpcAVNJKty9+7ASW2EveuKsjhpZ2698cFS7Yx+c+vJYrOlabdWJIK5TZ85kA3keFU6eMI96zWrwkXAnUVDQGmK+LWuy1j81D8Rd9iLJloMeCkYTN+JI5X/Zyi42x3Tb++wAZFk0U82L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=uFr7kxvE; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e732fadd0ebso2021799276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745877544; x=1746482344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxFrdDneqpz3d9d7DbJCg3RQ5dCC9e821iv+YtMl/pg=;
        b=uFr7kxvE2nEN5Niued+sKk3QjVm+751VNwDQ6/bZAHKoTfr8oWioVUHGr0hkyHCn11
         +GCmk4GCzxCFVIxEehpP/fwPht1w+f1pLuqZNI2BI9DQtBRKJu0YVhi1ABNjKqvK9Fn7
         B9ENg5J6hpUDwnQeG5M/zlXDwwkpqjYXHk5n/cP7XCdhByPmj2i19BLaySPQSYj/9KCO
         KiSJ36WahNZiLoiDJ52V+Oeqo2TsSpDRaQfqvV6Ud125D8rNvXwCwxBmwAg93SiRA+9K
         Ohm+NKZjk9TN7V9a4EMlHt3Mgh/wmeP/L+x7KRbgWTTTI4/IDkywULRPPBJfMvHlk2Qb
         ElCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745877544; x=1746482344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxFrdDneqpz3d9d7DbJCg3RQ5dCC9e821iv+YtMl/pg=;
        b=ic79tdN8PT5CH3FBxHaXj7kHgHiVMq0bI+rjYx1NS4o5YYUz0dDrzBWCRHYkE1etrn
         /vPsj02AuMtf4ucRtA5FAianJtRQp2e+Ed5C9wQGdNeiPrYgLKOjSV0uz3JJTm5/EPXL
         3VssBJ+iFClA89udCVpl1WdU5GsmpXd9DNMgECEBIss6a00ZqFK/8J2h84vuzJxIoxKY
         MnjerWv7mXe8eezwh/35jEYTyqFWRtRBZsjzaMmaGNJEyPtBC1ZWINfLC3MURcz3vi1M
         9C/ZtKn8vUUS6L8DWGxmev2hL8BLjBxHZZIcKoB1YpwG8E5Yeim6B1aCwW14R1Zc0Qxo
         iCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVah1LoCj8Xy6Sz3o0uImiZJLrzbj8E8PK0Z69rSIacF3NoDkuOg2moC0dnMUghmzFDxmGsdb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rigp921hUrrq31vQz8h1ETjbS/CJnL28k6RzdcmBNmdqG/v+
	0XvsEL1+qSICuolXsVSCYVnLieglrHGQT7fCBTf435Q/8M+GNAKpta6tTW/HsVZXiZZTCKYER11
	hj1yTljm+RvIZzmBF5WUP0DWyk/QAVWusqBccbA==
X-Gm-Gg: ASbGncvrD7p94FdYEW/bYy//Ke/1NUcTTiZy6jH+V2coKbKsj2rf04/0y8tgAGKFshH
	Lz8HOaxD2CaC8FQx8h5LREFggZvrsDVpintB/UbRHWRifXdadIpLK1aoBdHdd7Sl6FsD3RCe74N
	VjBC0iIjkn0Ctm0rfwn7Iv
X-Google-Smtp-Source: AGHT+IFkA9xAPum1MB3Ys8cfw/0sWdmGkzDXDyZOhMeKW5Rku5xqiFZDHH5EZJG6i/6o8Z/0p6fd9ZhwXGZ5RSBAMo0=
X-Received: by 2002:a05:6902:e07:b0:e73:29b4:d563 with SMTP id
 3f1490d57ef6-e7350021210mr2117518276.15.1745877544497; Mon, 28 Apr 2025
 14:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:03 -0700
X-Gm-Features: ATxdqUFIUO2tglmhDV45C2nCTp-oFupAu8LN5N9_f_seN3vW6TE6CBVImG3pbFA
Message-ID: <CACo-S-3iKzZ7HbZh41G0iShLhNKy3sHUnxhEEs8TDR356TAxow@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:bf938601ba6b379bbb6d272604bf0=
b09f4c945df
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:2020:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2020 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2020:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2020 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
 2020 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:2029:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2029 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2029:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2029 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:2029:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2029 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:2031:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 2031 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:2031:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2031 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:2031:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 2031 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-s=
etup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc27743948caad95c148f


#kernelci issue maestro:bf938601ba6b379bbb6d272604bf0b09f4c945df

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

