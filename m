Return-Path: <stable+bounces-136954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ECCA9F90A
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7EF17CEBC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A8296160;
	Mon, 28 Apr 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bvAsSsgD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E3296D33
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866760; cv=none; b=dCLt9ROqGy2ZdYsokYy7UCpAXtVsNSXH2U/WpQ18MsuS1CVAnB+G4126lXJ6/I6Mq4kmQsPJzqkc45F4lRPE/am9vVEhDtXFNL5Y7BNjC/Ucld4pDJbnbKWbpiwYGi3x5sAHoBy48W+uBrc+dzudb7g36nb2mZYdbCpqEsPpsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866760; c=relaxed/simple;
	bh=y/IymF4WrJDwtmcryo8C+7wE9dyO+4mLdsKywMD/pnc=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=P/MOmeDqfNhRF1GEEdJKUQN9VmBJR9rXZCfEYJ2vHiVe5iio3O7xtGDY6cNcij16Lkh+MGKtvwL32zmwMMuBwgUL6XWFmOQqJXlNnfGVmrfKgvHwqcPqVdme36UAKacZ29o2RvaIBcB8JYAD6v+08rMvqSqhdOgMNoStoavVx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bvAsSsgD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff07872097so49324007b3.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866758; x=1746471558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WI0LuGWqbU4Lt6CpKLpcjsN+w0pP1OH5RkUkYpjmnRg=;
        b=bvAsSsgDkJ6414i8qZvdktghj4geUtWzoFDXeeZt8Fpnp7YwzS9VV1VMm7CgGP4oT2
         xvx/xQO7zzttHLVkh1NAGd+3BaUsYaM2AOPjyWcNeKl9n8g+MpHpnqFHmpciRvFm1y+k
         T9GFRMPKeX4fPVJT6nvIw8zRZfpwVRxQesBe/NBMQFSoqPjpVyLTKsV+ZubSn6He5qiI
         AhwT0IwBRY9JVf2X5S956b5LwDptNzLXZ8CBKcCJpqmv4DYGYs+VcT0CdxH27TzZwi3F
         U1EQ3xtP9SIYtwjPGrebpcR3RkqmlJ6KjRO7LCcZgeNjaxdec3FUtfTmLZdUNrvQq3Nd
         7wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866758; x=1746471558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI0LuGWqbU4Lt6CpKLpcjsN+w0pP1OH5RkUkYpjmnRg=;
        b=lgPQFLbpwBCYElFZ0rDypwqtPIccMY/i6pAWxSLmZkaEb/lZDK7OKjdcl79uIsXy7z
         tlBUbKNbhDpORi/kLvb74sH1dLDLk/HNZOERwGXAa4CiaNrmyDeehLlynxAQVSUZXzMU
         XE4HG0Sti4Oq2w2vOOBM7yLG0x3+tHcYCXosyQzWjRQ8CMOnV7Z0GE0ItZAOgbYcKnmv
         R3v8Fnum1Ewzwxufke1Dfq9FAWMszQR/IeE6enOe3s8S3XOOx0KpqZEzkE9aSdi5y4ai
         OU168iXjKWEdnVCwC94ry2aV5X0CnAHtjGFJ3NaPGuGx7XmQL5hLGcMCx151iAu7K9vb
         ex3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYJqqyWX/oASHoUIJkJytei08DGmDHhjNKq/sB243/ZSiD5FwZvNWkKWstiZWwyXIJiAX2Tjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4LgGhHJC4fO4KxiurMXPI54qey1Zlerkgjtqz/QRtI8CIYKc
	TU3lCLjDUIcAuGG56PR4HY9z2UuNbX/lSepffYfrVJ89SaEHIKVN6YMraGM4cz0elfpbUfXH0Et
	71Yqddb2ZnnngJNMeu+gLN8r76/TxwbXHrGO4SVcXrY3zoFFFLF0=
X-Gm-Gg: ASbGncvEGpsARBez94/WUFk9GtTZjAtzfd4pxCCH3RWXeCN9QctrDOYuW+HZbMnU357
	J2HuzWF4OK5p5mfpKs9rdseuqxS/KCocExUJwzY7iy1Fnaoa6q70RnlRINFvHB3GLgzWMLdHnuP
	frFUhIy10emLv1Fj6Mllmn
X-Google-Smtp-Source: AGHT+IEKRuxFmF3rtthFEan+9S9Wml7IMu1nLO4uPTz5IUWRztokKRdf6JqLo0OTVkfyFYnuBZ7cVcG9prlCkYQ2igc=
X-Received: by 2002:a05:6902:274a:b0:e73:71b:72dd with SMTP id
 3f1490d57ef6-e7323354df7mr12632045276.10.1745866758239; Mon, 28 Apr 2025
 11:59:18 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:16 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:16 -0700
X-Gm-Features: ATxdqUFUTM3GPoa-GdDwmGgqKt5_H5EFqzgOSOXMtgbRx-uRnD45qXLyCNJ5O6c
Message-ID: <CACo-S-1w_c=X+VathvPf=DuJDXALUs=Zhi_9-Z4RsAuuOVaDxg@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSDigJhNU01fVQ==?=
	=?UTF-8?B?QVJUX0NSX0NNRF9SRVNFVF9SWOKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlv?=
	=?UTF-8?B?bikuLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 =E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this f=
unction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99? in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d940d725a86576ad87109055564f7=
d1508cedf2a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  e110b4519e01628bc31ba22c9111554d8944c82a


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/tty/serial/msm_serial.c:1728:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99?
 1728 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_RX
drivers/tty/serial/msm_serial.c:1728:34: note: each undeclared
identifier is reported only once for each function it appears in
drivers/tty/serial/msm_serial.c:1728:60: error: =E2=80=98MSM_UART_CR=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98UART_CR=E2=
=80=99?
 1728 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                                            ^~~~~~~~=
~~~
      |                                                            UART_CR
  AR      drivers/video/fbdev/built-in.a
  CC      drivers/video/of_display_timing.o
drivers/tty/serial/msm_serial.c:1729:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_TX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_TX=E2=80=99?
 1729 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_TX
drivers/tty/serial/msm_serial.c:1730:34: error:
=E2=80=98MSM_UART_CR_TX_ENABLE=E2=80=99 undeclared (first use in this funct=
ion); did
you mean =E2=80=98UART_CR_TX_ENABLE=E2=80=99?
 1730 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR=
);
      |                                  ^~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_TX_ENABLE
  CC      drivers/video/of_videomode.o
  CC      drivers/tty/serial/xilinx_uartps.o
  AR      drivers/usb/core/built-in.a

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_M=
ODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fbf8443948caad95c0b94

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fbfc943948caad95c0c27

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fbfae43948caad95c0bf1

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fbfb643948caad95c0bfc


#kernelci issue maestro:d940d725a86576ad87109055564f7d1508cedf2a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

