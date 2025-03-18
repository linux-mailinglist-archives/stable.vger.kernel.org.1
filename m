Return-Path: <stable+bounces-124844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CCA67A00
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9351888832
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01557211494;
	Tue, 18 Mar 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dYinRwtH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542319DF64
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316312; cv=none; b=YYNUhg9aR5LMcNtF05OKbER9DxvNjTT3IuUgn0HXm3AUwiGrPM9sEq0Uvk2gfKG/sOW/T2cAXOrHBcgktZPopTVdCdnn43x2b1YHr4CAjGHwkKsb8J5Gt+jdgPqla/vlGxskp1gOUABH2CAeiZp6M8P7WzntyClwaL/vG1RGT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316312; c=relaxed/simple;
	bh=pw9Y34BDWe6LnJBry1hRlMuSxholkGAsVqmLUCoHzW4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=TTKCUcyyXbyYld4SNrszx2sqpJ7fCzcnvUSQ40NT/Nh3gHwydENIZv6Fmu2ImBqOu6RXGxlAzgMUD6zzVHef2bB2DBPe5qaSFYFbSWK0UZcc1H9Rfftjha/8ZA0owH1etPUf1xJTDMOGWyJDR8CP5xudwf0+g6Y0hj6fXqDCI6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dYinRwtH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f754678c29so65936117b3.0
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742316310; x=1742921110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dYNNWFgnQiGgXMlO8GkPI0BVH71Pgd+xw32not0PR1s=;
        b=dYinRwtHaMH5DcNIX/v9MM1ga9n8RWp1APaXZ58TchDk3A7664UEHH9joR3kZ2Ggiq
         dMRIwh0tHinKScMGO6AOWleXrvHW4Qb61fJmrZLPoJu5JTVY2M9basnSQuVe+DCIx/ru
         sYLYSs0ZDVgWbFn2AZ2/dBFQjDN4ewaoPH7/41Kl1qkM1Qf6s/dHoFcWALOH+Jw2CYt5
         9voRuLVBskcBVf23TJpnQVKaJnuKKxTlulgH253DtOV14y+1Lg78Y6n69zj5pV9jheol
         ZVTZ41rxliede3Co6rTq11EkHjup4TSwVr63mrX1Jj+y1IIcvhQh81ELHR5DMFXgKNJR
         j5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316310; x=1742921110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYNNWFgnQiGgXMlO8GkPI0BVH71Pgd+xw32not0PR1s=;
        b=qhDooxQRDKLQmw30pK2IoP+3izJ+iZ45dWGAw7W+0t498TVtZOY80ZaOwqJ1j5jhv8
         UYOll70lltc/U3pLUayovUR94F0uAM4JsaS8ZzbNDZ2vxOaQ1RMU778nalFxyiZk8w9t
         MhB5I5OvkExWzN9tHvUa4L7QZgAxMHJptMAmbdx0nFcYhd8u3hLyywYU82wtgyMmR8UR
         aqRM5MRI62YNkzmy9gtqCTAD2GFP0TN2yF/vA2MnHtuffgI+wc1gWwa+SbRezLoInUZe
         M7qu6o88NPW1+nbr8d8ZovJJwtAPbV8zEaFTt7tWRdftnmSdv30ViBn590zjic9Zu8VM
         g5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX17W954/vCnQCPJdQvHjYzZjXJmPPfetuwcSXArvhNPMats6dCHX1xHPrm0FXDhbXaacu1UEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9FsKvPbMiRNAbQ2ndYx2AoGoWQesp7fBV2cy4vEAThp7dK89
	1DiX/YIHmtiEWzkA3NgUaSs9pHEvRyOqwtXlzIpA9BegQmEHXVIyegoSuzgShrnqCvftkYKreun
	Qq06EZMz0MeTyhNXaAF04VnvgEjYxjsOrJclsMw==
X-Gm-Gg: ASbGncs/L+CzVGMVxP9FxXuC661+RnLfLDO/j4CDJ6ti8voKpN2h/sgKIpWtk0oGfol
	9rpqgEiLKjFN1pe7NDrLDbEjsouCTATmJ9wPcCqFRunFQQTzLBMRxd9oPhNg3PJS9h1QlP4Wa7/
	F18INExkYgKVfHX45QjUuT3BkS8BqDJg9GCIFqilubU1KPrzlksjHKVD38XGU=
X-Google-Smtp-Source: AGHT+IGwAJjmDDp8Td//DuOC0b9ysTYF7x3XsjhhY/CmeJGd/pQV6FSmV+iUmt6gbtXe7w/m1y+VUwrIZ968MpK356c=
X-Received: by 2002:a05:690c:670e:b0:6fe:e79f:bd8f with SMTP id
 00721157ae682-6ff460ce8femr233380397b3.26.1742316310242; Tue, 18 Mar 2025
 09:45:10 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:09 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 09:45:09 -0700
X-Gm-Features: AQ5f1Jo_ldOJoAuep5UmBxj4nHsgkoEYe5oboILt1OOKM73T8gqXwH-qNxyCZlU
Message-ID: <CACo-S-0_+v=Yxwg=xbkyowAvYXTtZs+nKZSM=1KVFrmxqbAOMw@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKSBpbXBsaWNpdA==?=
	=?UTF-8?B?IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHZ1bm1hcOKAmTsgZGlkIHlvdSBtZWFuIOKAmGt1bm1h?=
	=?UTF-8?B?cOKAmT8gLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 implicit declaration of function =E2=80=98vunmap=E2=80=99; did you mean =
=E2=80=98kunmap=E2=80=99?
[-Werror=3Dimplicit-function-declaration] in io_uring/io_uring.o
(io_uring/io_uring.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:cbcc52388974e489070975f640bce=
79475aeb50a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  463226a52e45030747cdf2c689bf719e1ab21055


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
io_uring/io_uring.c:2540:17: error: implicit declaration of function
=E2=80=98vunmap=E2=80=99; did you mean =E2=80=98kunmap=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 2540 |                 vunmap(ptr);
      |                 ^~~~~~
      |                 kunmap
io_uring/io_uring.c: In function =E2=80=98io_mem_alloc_single=E2=80=99:
io_uring/io_uring.c:2588:15: error: implicit declaration of function
=E2=80=98vmap=E2=80=99; did you mean =E2=80=98kmap=E2=80=99? [-Werror=3Dimp=
licit-function-declaration]
 2588 |         ret =3D vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
      |               ^~~~
      |               kmap
io_uring/io_uring.c:2588:37: error: =E2=80=98VM_MAP=E2=80=99 undeclared (fi=
rst use in
this function); did you mean =E2=80=98VM_MTE=E2=80=99?
 2588 |         ret =3D vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
      |                                     ^~~~~~
      |                                     VM_MTE
io_uring/io_uring.c:2588:37: note: each undeclared identifier is
reported only once for each function it appears in
  CC      fs/read_write.o
  CC      kernel/bpf/core.o
cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## 32r2el_defconfig on (mips):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b2228b1441c081c54ba


#kernelci issue maestro:cbcc52388974e489070975f640bce79475aeb50a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

