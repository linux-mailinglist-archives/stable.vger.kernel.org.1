Return-Path: <stable+bounces-121734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA9A59B91
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858F31693C9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B2923644D;
	Mon, 10 Mar 2025 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dBuzRACX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B139236A9F
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625229; cv=none; b=sIobgocoWnH0yEQV3rNt5mGZwoYZ6q8PdEtr2gVg+Ba71gjPogkPRNajPNkop7HL3TGC4GMhTvPI9pOy/ygWPtDyhA2MH/05yjBosRl6dmolOkWYw0GKH/aFSQ1XqQLCXREQmMXFoRRDJ8ffA42hofhmkRPTwa2YCKFipf+oOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625229; c=relaxed/simple;
	bh=89Np1A603rVg0FBlXLmJ6YAP44LZEKNYMw/xF8uOJ5Q=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Lir5Z2yJmhmyPzD9WLIyJfp9UBs4WYzV9bGnN57UwdlboLUtc3EJXO2gQyP+b0zjuoFOmubTRYSeBlPvhgGGdpj8Z+cFL49sIXCbxwYsIUFNwuHl+2f8djiFmtyBz/DBS7A5KxB1/buC7xkNSg6pyXOkk06gKu34KNSzgF0xwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dBuzRACX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6feaa0319d8so31551447b3.2
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741625226; x=1742230026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QuJ1txQO8b343dFZ1VmGAXhCOoaaPasTv3WPzTN4kms=;
        b=dBuzRACXA53pIqQQrWvU59EeSAYlCGBWhTl+nGZi4dX0yjyI5wBDKd7ETFEvAIjq+1
         7jVz8Urj2hyueunwSjFdCP1AjB00hjDGQJ1yBKslo+nKUIYIjxz+4MZKB9cFS+jWOEpA
         443mAlAKKOttCYreTk/bqheZlUrGJGcU26erAjxZjYf9L8qBLZzJEdv7gSmNLrgIWA1A
         8XWZ7m7XpMEKdcc3ITdqrPj3a5WCEMUn0CRby/5et7vHP0GAhzYvS24rCp2llFR4T3mC
         H46wePkxOk5B/vRM2qSa3duWKxfiSaAszovoZVO2LHZXVTtQyHq9oNi9kjOChVxfEy8L
         Qt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625226; x=1742230026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuJ1txQO8b343dFZ1VmGAXhCOoaaPasTv3WPzTN4kms=;
        b=UcOxljnBI1wgyHSEI95AHHCAoro0XQLvL/y7CqKcaQo8/5h8YmC62NL8Idblcc1iPi
         buBy3gQqBRpelmHESe9juj10pd9wJNb1aTwO+pDElAbiwntIxb+4xcNv2xzcHVOCR3dz
         M8ayVGE0q+1whqUUc61HA/vKPEbL04007NITMbjbmEjKLsobgpBGaa8SsyNEDc0fh13M
         sCT3qE9exwUbleWV2Ko34W4sPrvQ1o4xFdG1Wn0l00TfHpOeMjYKd8ih3IPCbD8IOefT
         EDD3ltrZVFbAD30FGyIE7s+Mk74RZzPjHgrp823S9EVyHx2JSHtyM6COFunMTdZ7kDj7
         EVzg==
X-Forwarded-Encrypted: i=1; AJvYcCUqoYJVtRkEsAbLd+0xDg6hKpzXlrr1ikJpg3G+frO+W0F/OyO973mpfsYBU336Q3BXMbBjMJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH66JKk/cPXFAjH2GxmdFUbunCzGcwidbwiV0lVQ1AYGz7NO3t
	Hvt9QeeC+MXFEgYAFCzkWUBZ4jMKdFq0EJTvP1PkJLI4nXk+0JxT1aRtXlU7tjFZwp8x0P7tWC5
	igJhbjVvigizB4lgfzPdhpx8WchzXNgKAl1JQC52Ikz0z9aKVeUQ=
X-Gm-Gg: ASbGnctF7dl4XW35D7sk67LI4RRpJQOXmkmStJJYi0bnL+Eurw4EQcXsqYqbDL2cUsJ
	7yd68ZL+O7LtIfrz/l5hWABm6OgA/oO+WO/TQnXQ88nMxuIuW+CReYuPo4KXCNyLow6uFBLxfq7
	egS1Vvq3rSWMUKWRLaptRW7YJJ1Yi00x0NYYH6WjYMLiC0ML9x3TwqI9tjCGA=
X-Google-Smtp-Source: AGHT+IFAO9GB7vaHNirOb2inejjJegpO328R35Zec5mHA+ILNfbT0FUcv7FZ3ew8lkWEMYiPb7Pg4cuOTb1E8dNTXDE=
X-Received: by 2002:a05:690c:6081:b0:6fd:5a3b:7af9 with SMTP id
 00721157ae682-6febf30748emr201954107b3.20.1741625226330; Mon, 10 Mar 2025
 09:47:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 12:47:04 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 12:47:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Mar 2025 12:47:04 -0400
X-Gm-Features: AQ5f1JptyV4wsZcTzk1TvvbFIZ0kX1F2fxkjMGeAhNimwtbdf0fllmxfduox1-I
Message-ID: <CACo-S-0UxttK9HrKcSvSkUMVu6Pp1bLitPk3z+ydLDnDjv9b4Q@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSDigJhSSVNDVg==?=
	=?UTF-8?B?X0lTQV9FWFRfWExJTlVYRU5WQ0ZH4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0?=
	=?UTF-8?B?aW8uLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 =E2=80=98RISCV_ISA_EXT_XLINUXENVCFG=E2=80=99 undeclared (first use in this=
 function);
did you mean =E2=80=98RISCV_ISA_EXT_ZIFENCEI=E2=80=99? in arch/riscv/kernel=
/suspend.o
(arch/riscv/kernel/suspend.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:f277022d07efdd2a5858eb44b=
3c3dab79cca847e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  b49d45c66a5e8cc1c82591049bfc0d04daa1e77c


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/riscv/kernel/suspend.c:14:66: error: =E2=80=98RISCV_ISA_EXT_XLINUXENVC=
FG=E2=80=99
undeclared (first use in this function); did you mean
=E2=80=98RISCV_ISA_EXT_ZIFENCEI=E2=80=99?
   14 |         if
(riscv_cpu_has_extension_unlikely(smp_processor_id(),
RISCV_ISA_EXT_XLINUXENVCFG))
      |
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |
  RISCV_ISA_EXT_ZIFENCEI
arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is
reported only once for each function it appears in
  CC      fs/proc/cpuinfo.o
arch/riscv/kernel/suspend.c: In function =E2=80=98suspend_restore_csrs=E2=
=80=99:
arch/riscv/kernel/suspend.c:37:66: error: =E2=80=98RISCV_ISA_EXT_XLINUXENVC=
FG=E2=80=99
undeclared (first use in this function); did you mean
=E2=80=98RISCV_ISA_EXT_ZIFENCEI=E2=80=99?
   37 |         if
(riscv_cpu_has_extension_unlikely(smp_processor_id(),
RISCV_ISA_EXT_XLINUXENVCFG))
      |
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |
  RISCV_ISA_EXT_ZIFENCEI

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67cf00ee18018371957ec83e


#kernelci issue maestro:f277022d07efdd2a5858eb44b3c3dab79cca847e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

