Return-Path: <stable+bounces-124829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1DA6781E
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2A73A7427
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B820E6FA;
	Tue, 18 Mar 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rNP4gchG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199901DC9AB
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312469; cv=none; b=oP2LbzFyJrBH+KWHIpej828n3EHFqP8bKOivk1UNbua+hoxapNao2OjPvYCdjHnvCFZboqMzj8WzpRAPzd50UdVPl7yZnCrrshJ2DmL/k5mNxnBwE+IVcdGI1o55uSr70sNMVjcVcqOUnQVh7X2A8GZTveA1dzLO2bCrXviA9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312469; c=relaxed/simple;
	bh=Xz1AAnYOMSaJQFaCfNZVaJ5JJYK1AbpDI/w6DSj12lw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=O3zlkpZ2kJ5A8RJAgekvFb6A2UzImmt+BJMYC3d9WfccbrsLgv17S8Szjx8K59Jf4HQvCxOIVUcxXX3/BGVZnItNltw79YKdbeulmOYBTZK0mB2NOzTS5NUGQja3PhHz2EO0r5QSjbCZ77t4/YaZdyUer3JTFi1E2VvGFrNBqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=rNP4gchG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6febbd3b75cso51035947b3.0
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742312466; x=1742917266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UckPuGCexHWv3tcwtletWIj6Qf9+jmlu4mTzyuU/eCU=;
        b=rNP4gchGfEkMkqzIzaopXLxKTJI424sgvTXOBP7nzPRB7wuDkOoGbvmCfH2DYcbnhm
         UAeN3i9VllPR1hmZ05zWAaHl0VIVRCQe9z4b4f1vzFfiztKpjoxLK3b2USqL4Ql+40Ux
         Dh9glAwLqwpn5xQXkHoPUxR+U/YMAFaTI+AFea35ZYQ45Km0K3H3GKAOxzNrtcypF7Qg
         76ALHzTPMCFhmU7QzhSpB/QHnZKN+y8TrZkvflKN578xcOSgtJ5H7VLz7Oj5j1+KaO9x
         wpHxwxSAQ0Ef8wvPBJUQ3rCyaVmi4pdqs2vL6VCbr3KVlCaQR+N2/ciRS77oQE3+T8q8
         1XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312466; x=1742917266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UckPuGCexHWv3tcwtletWIj6Qf9+jmlu4mTzyuU/eCU=;
        b=LR15O+17laW4On5nGkKnSVemyDfkBAGmUrTYFxwjdG8pJPcMwEKm5KYA9hX+nfm4P4
         9ydkaO5vQ0DqNYLoJLLed57ldQuzUfklgdgYfLShgDE6st285TSb1z0yD14ilvJoaQ1n
         EHera6LRGcXpMGqzCOjg/w7VcRZ5BlUt14nt7F8MgYwQLcJtB368s3gd+vmT56mlPY0q
         y5sTBhqfcV6zDiTTa8v1m2hyoUSIiSe6LtS0xypPtZzTIEOuYfhBTtWY9nbmuo9fh/9o
         u0dJpZ0hXYlGIVLCAXS/7hcG5IopZSI/lHdZF6k/nd6o6tbHy0gha0hqNjSmzFAsTy3v
         jGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVUdUgBq9Hb9PYf/GOlMZiB8qnSBKXjjmQLLQxOYo2WeHlocOLwbPtOJBcAI1O0anVaH38UX8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytB6hDc+agrah0rlmM+g3+W49iSXMZfdC2ylq0cbOU9APgpZ13
	rt2XfDTcc/0MxG5lBgvapXsvd0Uo+IAr/CUQYCODK1zIjuXd63sUhEjt54sgTe6n7Vap/bbHs3F
	yUNDv8yw5NIjczCEG789tyAqweumoU50H8b6GBRvFN2ejY5agyCM=
X-Gm-Gg: ASbGnct1wUCcAwi4lIML3ANfNo4ADJQkyaEsgftnNLNfA6ozEakq5t5eMnrUXrZOXc0
	id+bBoLr0sPuyVEjlQsW12EyY9tlLMP/PohahUjljV/xgd3p1VSNLssG8MZgad7waRanNmJhSjO
	yITajRgXE/pYJjIFBxtmnmD1yvlDMBUTxXooUjd0h6mAcFD7vlab9+OfD++gg=
X-Google-Smtp-Source: AGHT+IEjnJWTJWxqya3fdQ28rQN7N3BxWBHUXl12aVS5Qrv5SyGif7mu6fX7arz9w5dvWAf7jdvJ9Pvq/rXXSPYeF4o=
X-Received: by 2002:a05:690c:3809:b0:6f9:8436:3d2a with SMTP id
 00721157ae682-6ff46019bf3mr241968507b3.32.1742312466014; Tue, 18 Mar 2025
 08:41:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 08:41:05 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 08:41:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 08:41:05 -0700
X-Gm-Features: AQ5f1JoQn-0R6QUa0j3OiojsB1FyDCZIDslErYkS_eTPHwiYg66dJzy3pvMS1Pw
Message-ID: <CACo-S-0A=1dxQAQbe=S=08g83gozTNZvGLw=M5SsJi7o4-49AQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbXBsaWNpdA==?=
	=?UTF-8?B?IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHZ1bm1hcOKAmTsgZGlkIHlvdSBtZWFuIOKAmGt1bm1h?=
	=?UTF-8?B?cOKAmT8gLi4u?=
To: kernelci-results@groups.io
Cc: tales.aparecida@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 implicit declaration of function =E2=80=98vunmap=E2=80=99; did you mean =
=E2=80=98kunmap=E2=80=99?
[-Werror=3Dimplicit-function-declaration] in io_uring/io_uring.o
(io_uring/io_uring.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:160797c1391e9c7479eace7259b46=
a47c35c7db7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  52baa369b052eae3278dda3062d63a3058eb9cfe


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
io_uring/io_uring.c:2708:17: error: implicit declaration of function
=E2=80=98vunmap=E2=80=99; did you mean =E2=80=98kunmap=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 2708 |                 vunmap(ptr);
      |                 ^~~~~~
      |                 kunmap
io_uring/io_uring.c: In function =E2=80=98__io_uaddr_map=E2=80=99:
io_uring/io_uring.c:2784:21: error: implicit declaration of function
=E2=80=98vmap=E2=80=99; did you mean =E2=80=98kmap=E2=80=99? [-Werror=3Dimp=
licit-function-declaration]
 2784 |         page_addr =3D vmap(page_array, nr_pages, VM_MAP, PAGE_KERNE=
L);
      |                     ^~~~
      |                     kmap
io_uring/io_uring.c:2784:48: error: =E2=80=98VM_MAP=E2=80=99 undeclared (fi=
rst use in
this function); did you mean =E2=80=98VM_MTE=E2=80=99?
 2784 |         page_addr =3D vmap(page_array, nr_pages, VM_MAP, PAGE_KERNE=
L);
      |                                                ^~~~~~
      |                                                VM_MTE
io_uring/io_uring.c:2784:48: note: each undeclared identifier is
reported only once for each function it appears in
io_uring/io_uring.c: In function =E2=80=98io_mem_alloc_single=E2=80=99:
io_uring/io_uring.c:2863:37: error: =E2=80=98VM_MAP=E2=80=99 undeclared (fi=
rst use in
this function); did you mean =E2=80=98VM_MTE=E2=80=99?
 2863 |         ret =3D vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
      |                                     ^~~~~~
      |                                     VM_MTE
  CC      crypto/sha256_generic.o
cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98bca28b1441c081c56f5


#kernelci issue maestro:160797c1391e9c7479eace7259b46a47c35c7db7

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

