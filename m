Return-Path: <stable+bounces-124842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C2A679FF
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33DE1885D1C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57632211290;
	Tue, 18 Mar 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bGVTaCOk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37F20FAB7
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316309; cv=none; b=Ulsj/NUsCuNzPEUd9AiaAdX2L+3FFckI40l3PqKFAmPzt5PX2MEsl/cSb8OokJf176UR7IBxLHn9+oolOeqfSj3yFCIdDkeOxHZjepvOYfgKRVfy6Sd3LQyT0Q7f2DdRlB22pr23cBvJ9Q8HkfTxAxeZrXSDkYrAzQddnenXCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316309; c=relaxed/simple;
	bh=Xz1AAnYOMSaJQFaCfNZVaJ5JJYK1AbpDI/w6DSj12lw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=dlpH9+YL8aSM0r9Zbrdx7WfkE6q04FdlhMarSGG7/Lo9lkizP4DX4WYZAZZr8K8ki7MnWeI8dmAY4zj3ANACYoom0IAFkl7IVyQGX39R2RlQ5z8rJLtzngeTd90doA6ZtoDZzmkfC/Mdj3MhnSiX4jdY8hBgZDAdqdb575MN+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bGVTaCOk; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fece18b3c8so50004457b3.3
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742316306; x=1742921106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UckPuGCexHWv3tcwtletWIj6Qf9+jmlu4mTzyuU/eCU=;
        b=bGVTaCOkEt2NU1KM+dJIJ9HR3iF1v3n6TAvJOy16mqWVk94LcMzJdPEuJh33Xnjgqq
         13tN4jtWtFADneOLooT0Kph3a8U3SWDXSaacVXIM8eY+62pIzeWzkKpaB3fhHKZjK5dV
         p7nuSZkz1GDXaUMt8WCN6x5fTd9sz1nF8oIBABPdKCY4EL0DbaiqW8IbfZzMJO6iOT2K
         Xfb4glGqTVKFAnmY6Aj6qmyzMAh+jYNX83majT+A5w78NPNP0QuRNMwReIcdO41JNvIK
         AC/88di+beRgDZrxOYrLfpUrpknuUQVgRnBTmZB7Wm3cz6TCqkIm539ZAY7V5xPAbB2H
         FdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316306; x=1742921106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UckPuGCexHWv3tcwtletWIj6Qf9+jmlu4mTzyuU/eCU=;
        b=L1PasQbHGwOuTTYvlhGiUjr8mz931nEup14ivOpyAyRfoeKxomUBNeqogbfUq79Zty
         FqX8Ek+ZcjSJS8ArZY0JFqrgz5PT2BmUSrrE+PkAT+o289Ip13gZ2Kelm6dxkVp9D/cI
         4Uaun0PIf8+hzMgV3yA0jNuuvsi5x07bxtXoO/GkYXK2i6tcejxd9RCbZZUI8r0VW10W
         fopKIWvfScecKlqcZs+575SyYy/87K+jz48LCO2CWg3E8Qa3onpxTH4NgwiJ0vHCguw2
         ov+Bnz9f5OZwkgExXmuAhObDKWQdYKVmqGKxaNXONUDIcNX9qdGaMVHAax1ssGhrQWve
         /CpA==
X-Forwarded-Encrypted: i=1; AJvYcCVOQXPekTvkEa4BS/9FkuMA+WhvKo76kQcsTuZ9jVfcgCKfSkN4NZEZhssisvOs/2Z66Xvca2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjbqWupHCp4odjVsFfeyAGjQjLtJeZRfsQQwMIAygr6ro+2N2
	qstuxKNRD4OFI1ttPVuZzXis8lCB7ohc5Z/A6gt/92UA7I69Ip7Z/e3kndwaxraA35seypc8bYm
	39Q5JOs1sEw5dRAxLhZaKHtazxwKAIB4mgV2Nbw==
X-Gm-Gg: ASbGnct0xbqllfQqKg3ck6vXMYgjo3X//a/wjrLbJbUTIFI/743BMQ+T0iFtf/ppFhg
	vhKx/QyEjWzrN4wEbPM1ucfBg7ChJoScLYUW4MGMT3ukAxXrNXYWGjKMc6RWRoe5nxUw5ddGJOg
	2R9KFvgE8ji42CRmbJCKvv+6ulEzIODeXS0iTRjZQZcI1WQzbshIxu6+C4+NE=
X-Google-Smtp-Source: AGHT+IGj8Dw4U+eeF7sIGfrMDe9UYe2B8e6lOzO+T2WvcpP+WqtXx/lQprwrxn5h08hxV0cYFANYLdXbJX4Cn0coQkw=
X-Received: by 2002:a05:690c:d1c:b0:6fe:c803:b48e with SMTP id
 00721157ae682-6ff45fbdf22mr221807947b3.22.1742316306115; Tue, 18 Mar 2025
 09:45:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 09:45:04 -0700
X-Gm-Features: AQ5f1Jqb8E4ntCF99_XZaL-L8q7y4RdEAF7vY6heFL1cOXZ2iScOwmZG85M6zG0
Message-ID: <CACo-S-3_yGcwY9m8ops=+4FXw2tKs0ySER9wb6fWW80zOx0qew@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbXBsaWNpdA==?=
	=?UTF-8?B?IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHZ1bm1hcOKAmTsgZGlkIHlvdSBtZWFuIOKAmGt1bm1h?=
	=?UTF-8?B?cOKAmT8gLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
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

