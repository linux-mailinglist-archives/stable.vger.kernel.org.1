Return-Path: <stable+bounces-136965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2C4A9FB7E
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319A91A872A1
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E020E323;
	Mon, 28 Apr 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="EC5sprmF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E9202F92
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873953; cv=none; b=jEflTi6lG0KM2mcz3Ydgc0ZUyifhpoqou729ZJgwBtkExtqY3ctR5an0nIsk7w9hfk2xxXXLdOyRl/dVHLD2wdxadXVyD4dbOHAULOYtxJt4TxJmy2GsNasFLcYp9tIFqtZ82ALe2pNhF8tVbjlomGdWLvh4z4zwrB+Qj7YnJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873953; c=relaxed/simple;
	bh=cexTMdJwXiou7xfXmKO2k8DKxtLfw4gW3c7SaX3zP2s=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=TwLAiLRa5KiigOdEEYgnkcHQqjrDjKsXH48y9caqmPf8G2oDv66uMCV4sLAKh5aDS/Pyn9dXGX2X+N9Ka3pj/kwkcpxx2YqSbvRigUYr/QKoNSJ4OjPPhbhyDKnT3q36H7nUiUqNzRW5HAFwjmuEkrdDvnjKQizG9QqewxBRWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=EC5sprmF; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e72bb146baeso4287702276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745873950; x=1746478750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ON0tWxnMPNhdpeSktWv8d18udGQCrN/UXMCOJHd5/Gs=;
        b=EC5sprmFCrLGlnnTTBoBbZhewww5nI1p8+Rc/AgJyw7d4WS/M7P2ug01Pzu3mrw+js
         dhNqchQw+at4m476Lk+CaDWOHflu0plEFn046IARfM1qdgSnF3pb1lcwUQdtJu1GBfRw
         Zz6sedZuljW3KkpCQ86nMFRlJ8LLF81b4KIsrRKPn+tDrERISdNgXwymGYIMcSP6jWCH
         FvRu9B9ivMq2Or4wH0ZgQL2U09z7XDhveYoHBxW/6ra3J4k4fb9MS33lOsATMOc/g0CW
         vTjgDmt60GgNSG++8Y40WNneFKUCxKcwu7IRfzuQ06P3HzS4Qd/iHMs7fALTf86U3i9J
         minA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873950; x=1746478750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON0tWxnMPNhdpeSktWv8d18udGQCrN/UXMCOJHd5/Gs=;
        b=Nwgxk7WCDBXoOJcb1ZNVMuU74qGnS5/TfVnQftPKmtb1GBw7q1XZRb/X7RSHmxHNta
         ka/ls7aOwn4GCA3kX207FzlnE20oi80XuJpXcPMfZ5ZTdM6oV6lXedkFHNtmcncdAkrv
         ZDweKenRfXHIEkInPVd4uidMr/ewvtt4e8a2QY5eLt/bXsF866vhdsD1rSERcKcju7d3
         ZPgdP6TtMVhmMasqQZL8UE6ebUPccHroMs9xwAjYNWm0Ixo/nDn0GFJ/XpW1nPaqMJwG
         Sv5b1MgDjnYm4EXAqcFr5exDH3DPXKHe7e0mFoSqK9gj36BZyskqyjh+SXTc0Bn6vaQJ
         bTHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkoRQ1Q+6v00DRTyz1A/ZgQSU68jTidXp+DtxgvddlAJ4wHlZnbAGxzxy6SUfVlgpu2fenGhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmI5KiTnHa4Xv18avLr7skGW4SjhmaXkDcxdEp198tSAdQcSD
	rAXtt5iC5rCQbfoCRWe+A9AvKc/2RQninrwBHOnpfYYzjN08bpVBUgc9iAqc7DWf3ykEG0xMlEM
	dzBawJzFdKI3FGRWdbDXPQN0oUTt7pz4YkFF7B+dVo3jH3LYvlh4=
X-Gm-Gg: ASbGncvVgkWSaEW6G365lAdQJCPqPkVtN/tDp1jHmgyLCqgUjBWzeW7D4D3tRhvYe2+
	fiWH0tG4wfY/BP0bnOryDcNgAUvyhqlfW1xChqDJqzadoIsFxVA2VNHSpkXmBpN7aGYvD5qXTjT
	Nbd5KnAabNMI7APUqW+Cjm
X-Google-Smtp-Source: AGHT+IERem5l32tN10XPiVHtA76jXUik99s3tLF9sOq3xXmEoCNHQlvGdtanX1gikrD4AivaM9kGQVNme9GgcUMme+Y=
X-Received: by 2002:a05:6902:1b03:b0:e73:334f:30bc with SMTP id
 3f1490d57ef6-e73500b1f38mr1624389276.38.1745873949984; Mon, 28 Apr 2025
 13:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 13:59:07 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 13:59:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 13:59:07 -0700
X-Gm-Features: ATxdqUEtu_O_I6SZIkUTxOssp3k7SzbmRPp_EjGZi_jsl1-lVo1ulJAOjOs6VL0
Message-ID: <CACo-S-1oRQNfrJ6BAqkRpSsO1dnKokkO2N1WSvvfKgKDbhCqLA@mail.gmail.com>
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

- dashboard: https://d.kernelci.org/i/maestro:b76cc30f77b7553b090563986ff70=
4b6cb486cc7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.vmlinux.export.c:1490:33: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1490 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1490:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1490 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1490:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1490 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1499:42: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1499 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1499:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1499 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
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
.vmlinux.export.c:1499:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1499 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~
.vmlinux.export.c:1501:34: error: expected =E2=80=98)=E2=80=99 before =E2=
=80=98BPF_INTERNAL=E2=80=99
 1501 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^~~~~~~~~~~~
./include/linux/export-internal.h:45:28: note: in definition of macro
=E2=80=98__KSYMTAB=E2=80=99
   45 |             "   .asciz \"" ns "\""
         "\n"    \
      |                            ^~
.vmlinux.export.c:1501:1: note: in expansion of macro =E2=80=98KSYMTAB_FUNC=
=E2=80=99
 1501 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
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
 1501 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^~~~~~~~~~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/arm64/chromiumos-mediatek.flavour.config+lab-setup+a=
rm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc26d43948caad95c1488


#kernelci issue maestro:b76cc30f77b7553b090563986ff704b6cb486cc7

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

