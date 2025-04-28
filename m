Return-Path: <stable+bounces-136948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156ADA9F905
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3916EB6B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4C296D22;
	Mon, 28 Apr 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="KFqJUmHo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD82951DC
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866752; cv=none; b=AMOhycVTDLkOJ9M/DXaWhXGXRyv69+eMnT2ERsbYPcE0RaEiz44d1vxgx6niJDcFP0deB/9AWoIfFk8zFAYkddsxn4hZoYbI518XBIMzkdop0hfwoY7z9Lgvq69NUfrCBL2XNjBs6C6nCPOc52Le6jhsvHJFUZ+88KoOQ3D2Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866752; c=relaxed/simple;
	bh=Tt7K3arYCuu6y8S3UNEDOvsTpqCEOBPeeHSoYyHmsUM=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=PVUidj/3Hl+BtacjqMXLOslks8lShRYviQPomx9RF4/Qvoc209xvDYF+8HPg3Pf6kiz4VzcqlXxha1MZIXETHwUqQcLJDzmRSry4v8iIIQNSuwF6rvQB8378RkzsIw8wIAT5XU0muUSV9UKoE5WMPEEKDByI0Ep52Vo7KZS0XkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=KFqJUmHo; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6df4507690so4044424276.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866749; x=1746471549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BQBDzOzD0P5rjVzWYAIAV3yUy5tYGu2IVvfn7S5W6zo=;
        b=KFqJUmHo625XLintEusw32fA/vip9HO67oKQz1ZNjNyyB+4Zy8hl44wX6Pw5ThYnMh
         Cq1YXm4yIBqa7U09+1odWEiSIgmHQ6YPDNYrrYh7wxxEjE06mHbUAWXcG35cZBPlMOJ/
         BHk/Ok3UH920Di143JlRWh3V9cpwK6sGiEwZhZZvXT193A7GfA5QugmDz52J5UuhOqc/
         ZSiyKDbZ53+2bhB+J9p6AdEHtEBZq1BRG5ItcwHMfZ+z7L4CP5ifxHmaBt/RaCbmGNKo
         /PCdVPkZEpGxQxPigaxPj++RL4ICdQYXSpn67s1C729a+3TcsamlJiJmwLmqbVz156oX
         fZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866749; x=1746471549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQBDzOzD0P5rjVzWYAIAV3yUy5tYGu2IVvfn7S5W6zo=;
        b=hrgDQfH2vt044TUwQZr84MVKW/3Rax2IU1XDZHxryv3zG4mB7B9tpn0wAvgh9f+8j5
         8ahoYp/dIxa7WOsCjIzx9GGEQvtCcob93h9H2CCXtik+1FOwtCF8OFFTGN1ISvGDBxR6
         OlDOBj4yu6N12AvV7Ln1lA34muJnrLc1aXQ2SHUTFPoZVLACdmSwSF1M9LTiWKMiPY9r
         iFAPc++TNfHvWGhPIX9AimkQ2Xd7V+cnSqFXuRbqGinyOT9gzkQIuBE+06MnkD0lXunp
         H23NBQ8no6gmobm8YHNaoA0c4n/4dgDxHVYr9tpr+bAGMaOkZinZBD1qsACXrLTPc9IP
         03eA==
X-Forwarded-Encrypted: i=1; AJvYcCWeRDXDI2aVQ8wAVz04Sw8zo4Xz+YwSng7aPMeFmZVpESZbsIPJIt0dvqMp1rw2gR/d9EHMzlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcCyktG6H7tuSgT41mFIO9PuGIUAL3AZvsWjke0EoNC+njMRV
	8LF8YfIhu6RWTJ25wjaIfhemWnaHsI/VNsd4RsMJbACNkHIarVR4LbLaynLfvm40L03xjY0Muwf
	nHfpP/ehHw8aywrPiakefNizZ5o8Wr1KUJ77MOHK6zbwTaeGQG68=
X-Gm-Gg: ASbGncttkUS4AZuEYRnQNVNYMhl2EbCO/SDQDw7yDJOvY8DyZjEcDL5jQNU0Ct9PpLj
	91x1N2R+q4deNDA0fGbLvypb7knJdlh2kFrRjRRQx4AsF/9WeIpWYU4jB7aOgfOG2KJkf873wuz
	Gbd81BA+Khu2Ow2wLatpO9
X-Google-Smtp-Source: AGHT+IGLJ/73fj4jbpQA6wIjSQsr+1W+GVlV3gqElAa7T7JeVJafqtvWY9M/qUFFLRaoEL7kurr55ssblEDIauvA3Gg=
X-Received: by 2002:a05:6902:1103:b0:e6e:1a1b:c026 with SMTP id
 3f1490d57ef6-e7351138e1emr511955276.12.1745866749676; Mon, 28 Apr 2025
 11:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:09 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:09 -0700
X-Gm-Features: ATxdqUHdQD4OINmT6Zx_pMHKG5OjzA6nhvpMHXAUMzDZdTtwZCKXQT2bWvhap_Q
Message-ID: <CACo-S-3XtEfCetoC28eD_=eXHr4zB66DZz+QGanGPg0iNKfm3Q@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjE1Lnk6IChidWlsZCkg4oCYTVNNXw==?=
	=?UTF-8?B?VUFSVF9DUl9DTURfUkVTRVRfUljigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rp?=
	=?UTF-8?B?b24pLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 =E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this f=
unction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99? in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8f9e585d814ad41cea3f055c8d011=
c099a1ac9ad
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  7e1718e4648c8d93f1738a07033b83f2fd6b43e5


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/tty/serial/msm_serial.c:1737:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_RX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_RX=E2=80=99?
 1737 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_RX
drivers/tty/serial/msm_serial.c:1737:34: note: each undeclared
identifier is reported only once for each function it appears in
drivers/tty/serial/msm_serial.c:1737:60: error: =E2=80=98MSM_UART_CR=E2=80=
=99
undeclared (first use in this function); did you mean =E2=80=98UART_CR=E2=
=80=99?
 1737 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART=
_CR);
      |                                                            ^~~~~~~~=
~~~
      |                                                            UART_CR
drivers/tty/serial/msm_serial.c:1738:34: error:
=E2=80=98MSM_UART_CR_CMD_RESET_TX=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98UART_CR_CMD_RESET_TX=E2=80=99?
 1738 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART=
_CR);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_CMD_RESET_TX
drivers/tty/serial/msm_serial.c:1739:34: error:
=E2=80=98MSM_UART_CR_TX_ENABLE=E2=80=99 undeclared (first use in this funct=
ion); did
you mean =E2=80=98UART_CR_TX_ENABLE=E2=80=99?
 1739 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR=
);
      |                                  ^~~~~~~~~~~~~~~~~~~~~
      |                                  UART_CR_TX_ENABLE

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc0e643948caad95c107c

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_M=
ODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc09343948caad95c0ea0


#kernelci issue maestro:8f9e585d814ad41cea3f055c8d011c099a1ac9ad

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

