Return-Path: <stable+bounces-136953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D6A9F909
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A348417BE40
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1D2951DC;
	Mon, 28 Apr 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="2tepu2Tt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EA296160
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866759; cv=none; b=lBP3ixPv9UlJXGBYRa/tgET6OvmWGVgWeIXUJRyB8O3fvdrvxOHr1CRcD9PKN3i0vfEaHLBV1wqq4lIwzJllocgcdoCcG5Y5J1RZH07qM9CSuvcDpWNhojsiHmyAv2T97W9Kyk0f7ffgD58M5STR5anlx1xFN2T7QwUw6dFKzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866759; c=relaxed/simple;
	bh=1k09XYEPVpS4Lv7nAPQLm5wKqaq0n41Qu+0exbjX7PU=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=AXkxzNZ4MKZcsAs9Zq6mP37DhpoRMcaCvlaFvSWn8MZ0KFWlwDJUqxDCZ/F7gS4OwOwxoe68SJSXU4S7Rf1j0h7zNM+4IcUq4rWliKsClU2uNi4hlddbtFPFjMYeJt+8+CMCw41mx4pSXfwo9G+YIEbW5spWL5SQdZ0V/Xa6Ajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=2tepu2Tt; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e6dea30465aso4304724276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866757; x=1746471557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XcYep7Tteb+7YUxhhv88RJcT9rBW4WsOUpS1TtdfqG8=;
        b=2tepu2TtksgG//7fkzh1xKnYcSYuP39jj7fiNHcNiXk9qf7SoXf5ulnX2fSL3VNoah
         bin2iyNgSHdLLAErQkbCc/D4DLY4lDQIRLJy9XuwTq2ztUxsuGCSiFcvt2kZmm60/v0b
         63kjoR7LzuOypdSfitvz28qLvyoaB6Ko156HRZRO9eGjs1H65iMG3ncFBqHepRJhbI3k
         QVfhknkNotQwoc2XS6ssLjZEJMhMokFUWE4KRwZ/1w2w+kkTqoj9hrtZW+roYs/GqHfC
         Thi8BvjBwbRAx8bSiocueT1rLxxPFJUVjybnYVW5j8NB0ozBqbjMW82sE+LiYAah101q
         g7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866757; x=1746471557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcYep7Tteb+7YUxhhv88RJcT9rBW4WsOUpS1TtdfqG8=;
        b=UF4YoyHou9j7febERybAEdTXpVNfF57fDBDdtcqkBDdWDchy1sXWsQC/msuQWBJXgr
         TP3hSIlqtIt8ffa+Db2ihiVGEflazGtoWwIePnQo1GWfBpN/T5me3KhTgJiplj06BX0E
         AeAiKUT/fyzAZXajZvZTGJ99fQVOgSPEBtqYDZrkEf/gkh9YnJ0prtgovfIzObisrjmx
         14aoIcGEK3NQCTyCrJxXHHLsUzU+/8B7Dt3wKtNsefk5/mzL9Dn02y4pFzuh+G15RKyi
         nLP18nfT3EwPeP+j8VCUqseFYNoDZY1uMdENK2Mzod1p+d2zM5EZY9j6L8BWCg1tKXUp
         a+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUFIvTIpFjmNZLOo02FWRfHARER3OozjWnuzZx7YPH1841M1UwPkYuvAgjxn/oyZg8elAyDynE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjhF8HKrKHCReyiB8z1zmciknbrCIACl0qWhh3V1GWxNMTXTp
	wswgZ33eBTd6mYWISAO8u4bYECTxWz3lcF1WMX1xeUXkFH8w/+QCxdmEyIbDSwdU8B9PcEppZet
	0wG0cLXkSuplCJ07OtX0vFuL4Th7Lozfil2zDVQImqgIbcQ05boQ=
X-Gm-Gg: ASbGnct83hWMex807TGP6j5Ey3ew06eqmevPcYsZnrnVr/Wq3DfIALG1OPmix2p93Tx
	L5q0sOCluyfc/SO/y7PpK4Rs4IW4y7rIP3MdVBMbtAsWoQrHfLqICvZuoJOS1hTEEZ/2nzF5izR
	a+sqCxc5khthuCdCDkOx28
X-Google-Smtp-Source: AGHT+IE2KieHA8om+bjTgofkCeoxbAiDe8C30dunvyqSdzD9l+oDCxpkvjm1M//iqPXq6HHyYtCtHFg/vQs+/Ybu2Fs=
X-Received: by 2002:a05:6902:120e:b0:e73:15ed:2dcf with SMTP id
 3f1490d57ef6-e73519fc35bmr109480276.25.1745866757173; Mon, 28 Apr 2025
 11:59:17 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:15 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:15 -0700
X-Gm-Features: ATxdqUHmqt9CIqrKyqApiLW6a5djE7z-nfIqSOjfI1vNn21WNVvKLGt2HNng550
Message-ID: <CACo-S-3Rf7A11gDX9kvPnc74D+69-CdNQwVmgN5NmLDWBYQZow@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkg4oCYTVNNXw==?=
	=?UTF-8?B?VUFSVF9DUl9DTURfUkVTRVRfUljigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rp?=
	=?UTF-8?B?b24pLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 =E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this f=
unction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99? in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:4658360a1ef3b10dbc89e4bd12a39=
4656d4c7b8c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  bcf9e2b721c5e719f339b23ddfb5b0a0c0727cc9


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/tty/serial/msm_serial.c:1742:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99?
 1742 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_RX
drivers/tty/serial/msm_serial.c:1742:34: note: each undeclared
identifier is reported only once for each function it appears in
drivers/tty/serial/msm_serial.c:1742:60: error: =E2=80=98MSM_UART_CR=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98UART_CR=E2=
=80=99?
 1742 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                                            ^~~~~~~~=
~~~
      |                                                            UART_CR
  AR      drivers/base/firmware_loader/built-in.a
  CC      drivers/base/regmap/regmap.o
drivers/tty/serial/msm_serial.c:1743:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_TX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_TX=E2=80=99?
 1743 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_TX
drivers/tty/serial/msm_serial.c:1744:34: error:
=E2=80=98MSM_UART_CR_TX_ENABLE=E2=80=99 undeclared (first use in this funct=
ion); did
you mean =E2=80=98UART_CR_TX_ENABLE=E2=80=99?
 1744 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR=
);
      |                                  ^~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_TX_ENABLE

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc04443948caad95c0d37

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc03c43948caad95c0d2d


#kernelci issue maestro:4658360a1ef3b10dbc89e4bd12a394656d4c7b8c

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

