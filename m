Return-Path: <stable+bounces-136951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822EA9F907
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DCE178ECB
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C0296D29;
	Mon, 28 Apr 2025 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cI//nvSV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A12951DC
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866757; cv=none; b=lw20D2dyGSqIIaQjbeogS6lRhRIGhxOMDdTgjMEjz1iwHGfoSn9sZ1gVP1skKEm5bKCDpbrowUFcSb5xJmZOFcXOFfjWpTPjbI8loYIvJmiNtlBwxOjQbvfZAf0MLv2Uu+QXmVuJIHsx1RL5RHvuXr2pBVYJ+y6pYHFNQMxbZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866757; c=relaxed/simple;
	bh=/SyT4hRYLqkDJABcDLNSKPBO0+KcmIOzuLMlI8JyWNg=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=dYr+mLO5FYk3jhoqy6EuKgQRlX9d0fjguk/FLW7/mg7ziwOYxfBotGzH/zyMaxsyj9q/TQs90RTCXP6Ia06qY6tjQvrXwSD67j2xCjQYKLZBPWdWzd+YsCAMeR/8HioDWG3vbt+1hzaOMyfdYnA2ZCDeLskfnsRdXIw5X+tAgUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cI//nvSV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e733e22505fso1301294276.3
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866754; x=1746471554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJvH08bQcmnNaKf3rOMP8iVgcjRLd4DP7y7sdoMu92k=;
        b=cI//nvSVRCujGks7G5GOfjQ2RzLgnC+8eNY2VqHtgBYeHVr6kuF4QT1vdf5sSOlhqv
         H0Fl4s4HdOa/ae5TT7xwcBkxkjyrBTT4KCU3HodVgUpdnKctOxiKsxXwCrZ4e6Qjm95q
         BWq2GwzVqmtnDtqYxmaE+qncNCFM6LxfQpItdpfrSe/0yXUXNBJn35f7czg37WCVm69J
         fvk22CNDKPX9JtT6AEoLo7zUTJzLHPZ2a7kICjMnI/5Dj8e6OpvtEcBa5nW7xhsc0Aa8
         dfrYFoavj57pG3/Vo4uXrFv0kFkDpyjvcG84aT9PXJzzgQPyxb+SGaQ39czZupq56IGF
         fUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866754; x=1746471554;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJvH08bQcmnNaKf3rOMP8iVgcjRLd4DP7y7sdoMu92k=;
        b=uhv1S9QrYUko2ALjSQnQjFBi2vKvp5VVgyECtCWZ3/ARAVIQsbBkITCtZjNDQeXy5F
         qBpuwSyLezyHmLW2z3OvjBGZUpgrVEM3QWm6JHTmQ0moZUziCH8WFmdHR/+k9spnok5p
         h0oqzA4sKBvOmVE+r7tvwbkpgTt8iflqlynbr0kFaXe8ZIg4R3AXAR9mK49qQ8EgeQkP
         2Nv+XpvVHVR+tPYaLY+abCa+e6K5ROsxVWLqHJMc36GAb6FBMcwj7N3xABjTm5L+bg/+
         vKucnN6VcSov42IzxmCLhJ2DsGRlE4InLsSJf5KrtlCp+0dPMfFGb00MCegHpYd4tr5t
         zepA==
X-Forwarded-Encrypted: i=1; AJvYcCXmZHUhFyxGCL0TeLeN8Y+aFWjQ8kurD6HadryID8IvJoP3nV1k5XvyiOqJw2/jDmRNuh7+Dk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRmYB8XQPEVf9tIGAoS67OCnWyN1ZIlgJnEN8ri61CL3gQEBK
	YmqrrFjWFKgPUr22TNF973dx1X1CKtisDjofrQvMpWpOiUuQSA/96PAjzUVfQmeSgiIbq8ifnPN
	mWkFOkvlva0KkKQKtPco9Z5Ne3TyoY/7bYD5VMLHy4BhfyAlMtms=
X-Gm-Gg: ASbGncttU5RXmTdZM9MQOgzeXz+qXsf6TC5qhiCKs86QMcWAA+Spvoetagsp2pAkZs8
	ML17Vvbu9+zuO2TcdL0yPgCmV6xxZ/7Y0Su2C1ehU9UVAm7IUToU63AqADQ+R5eu86py9dgQGDO
	SEAb3I/nszI5ElSBhV1Q+F
X-Google-Smtp-Source: AGHT+IH3Xmf9R3metsDl/0zGWMl8EFFnpkj1fkRcabG7txZo+lBRLxAu1j6PrvcZBk/zL5mKtG37U1gSHynou5SSy9U=
X-Received: by 2002:a05:6902:120e:b0:e73:15ed:2dcf with SMTP id
 3f1490d57ef6-e73519fc35bmr109283276.25.1745866754591; Mon, 28 Apr 2025
 11:59:14 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:12 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:12 -0700
X-Gm-Features: ATxdqUEJqFHUP8Rq1u0odZMdI6QyGJhkipgjVeKJnE6S7Q2ene0Q57vqnPzjSIo
Message-ID: <CACo-S-2370YzugRT-0+BaFRjxwK1pnZLco7T1-5cRbuhN378vg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) use of undeclared
 identifier 'MSM_UART_CR_CMD_RESET_RX' in drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 use of undeclared identifier 'MSM_UART_CR_CMD_RESET_RX' in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:e97aa40b96988fc4cd3e5c2e0098abffae9be766
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e110b4519e01628bc31ba22c9111554d8944c82a


Log excerpt:
=====================================================
drivers/tty/serial/msm_serial.c:1728:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_RX'
 1728 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1728:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1728 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                                            ^
  CC      drivers/scsi/scsi_sysctl.o
drivers/tty/serial/msm_serial.c:1729:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_TX'
 1729 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1729:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1729 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                                            ^
drivers/tty/serial/msm_serial.c:1730:27: error: use of undeclared
identifier 'MSM_UART_CR_TX_ENABLE'
 1730 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1730:50: error: use of undeclared
identifier 'MSM_UART_CR'
 1730 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                                         ^
6 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fbf9b43948caad95c0bce


#kernelci issue maestro:e97aa40b96988fc4cd3e5c2e0098abffae9be766

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

