Return-Path: <stable+bounces-136943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0BEA9F8FF
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1231A85A7C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE166296169;
	Mon, 28 Apr 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PVu1gKtU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E58296142
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866748; cv=none; b=FXt7DZwKap2QWpyYZ+pD+qv/1LAVxsjT6NEP2aBWDIZ2jst4D6xnisWdqztamql9sNjrZjlCAEqQY+/xkfCdoWIyrv1ZpEQ0F+bsfXPEga7NQaijcF37hw+zZPr+nXW+LpHl4qYvsf4aTYhZiWdZP00pbwpwXsOJCH1alBtxJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866748; c=relaxed/simple;
	bh=CmsdH184eVYpLjGm5xSrP+QxmnrwANnBmZoHoZffPE8=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=G7Z+n70pLLMeZituXhR4QoVKzDGE26equs/9uyBJkT1qp/SHXmGOAa1HPZCjAfoKerUq+EQkqsGDJF8LBeDuKnjgaNInqqiqEcK2lmPkEL2wtMGho24q4JU3OqdECVmqIr//hH74/NtFB8oxuDAlZJZB/Eh8S7OtOtLVFll9rLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PVu1gKtU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so4601221276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866745; x=1746471545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjA++I2IX6VjQJlt1yx91cS82STb/ZmjqA1U0b0q4gM=;
        b=PVu1gKtU2GAWuBS1/s/czWbFzLuJW2RFBnnSNdlsHp9SfoW3O3Q0rn8M9DDpxpDaZG
         xhx3Q/QONcTuI4ZhN6kwfGzhLbH5AoHQ85f0+T2Cxnuy2JYn4nWJvW4CPWv9QvGOw58n
         3rul+CCwui3rMnlpoFAmVLgW4F9nxaYh4v4BD/n6RJYtoEtilE6JfgNdp7/aIlvOUmjG
         DSaqc4lO+ElMq4QR9Ni3WbnweURsOPRfzx9YCruQ1nBYu+I6FV62u8kKeojxQYQ6Zmqc
         OsP3B1QzLWEyf7jpt1nqwtk83NAiiPvD+DTcaPcG8LWc8PEvxtm+E92yEZQK2CzOruvw
         uB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866745; x=1746471545;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjA++I2IX6VjQJlt1yx91cS82STb/ZmjqA1U0b0q4gM=;
        b=aTzZdaCY3ECgAIL11vVQoj4MVFTODgFV9CHsheqEf5kcdJL7WiOQI/B0qiYpeUZDB2
         m2LNgjFzthRixeO3/lkuc7yN/IP67Q1L5EJzTJr7cv3jfBzwBW3NAx6Z9vqoDSTEX5yX
         tvLBCIWOByCCU59RfQfWZoG4pPyA3+Wu9Z4eviNvSkfI7+6vAmTD3ZCgiNkNnpeG/9rN
         dSPI+L8rQ5CJWmROYgbhpL2wpXz9xPcFE+56VOOamSDzuTEf0oapBdMfNAQ2PQpjzHlc
         vl4FiKaA2KfHO+FShWIvErArgnrZRQgGSav9EYM+1/17j1jJv1vnTPu20Pisi/JKWwzB
         cA1w==
X-Forwarded-Encrypted: i=1; AJvYcCWvQIOUPz9PpVccnZzkBw25RQXGvDlk6oOk7iD0pqeuv01Ypkqq93Co5OdjRRovLYYyTQT4+CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7Ln5ieCbeBG1IlJul1uAZse2RGBPKbJEqGk+bc8hQx2SMb6C
	p/6WZXrOeZHbR8m/mD1OXdsUUAe+Er16cLsS65z5kPEp7KdZGO0ttLebnM7CfI6HtusxhVs2HAV
	WuawG67hMSfAuEk09H+zbEyr80PM9Z9bWndNfZGR23kZr+WohtoM=
X-Gm-Gg: ASbGncuKu5FxuvnuuXyNL8u68OyfPoUkq5gQsDR2mAuO75PvUoEJZY8dJawupc9F1eB
	VNaadydwpXkzETXo5hUnWEjmz/Q2OjZIlf7qyn/WjFwmxBZSkRkZQ9d5uXoeGg3AgfKfP7ss57J
	zpJhA6YBL6S9S0Onv1fW15
X-Google-Smtp-Source: AGHT+IGPb8P9chk1ke3wTkuv4qPaRShZB5ey/5rIZ+0IHkbBB5wJkHWsPrXirXACQQM9hMgx/N/ya8lfX0au+cXrJlM=
X-Received: by 2002:a05:6902:1b86:b0:e73:2fd7:efd3 with SMTP id
 3f1490d57ef6-e7350020b41mr1185047276.18.1745866745612; Mon, 28 Apr 2025
 11:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:04 -0400
X-Gm-Features: ATxdqUGt5n65L7uIN7xSm1M5wCwd45Pim2tHivzAscJIOdNJP1wudLgkZeR3QyE
Message-ID: <CACo-S-3Q70HAVAFbB1-oGjoNg2hvhe3O5jJ25pKrsQ9KLN+opQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) use of undeclared
 identifier 'MSM_UART_CR_CMD_RESET_RX' in drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 use of undeclared identifier 'MSM_UART_CR_CMD_RESET_RX' in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:d95ff390762699864781d2727badc1f762a8695e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7e1718e4648c8d93f1738a07033b83f2fd6b43e5


Log excerpt:
=====================================================
drivers/tty/serial/msm_serial.c:1737:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_RX'
 1737 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1737:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1737 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                                            ^
drivers/tty/serial/msm_serial.c:1738:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_TX'
 1738 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1738:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1738 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                                            ^
drivers/tty/serial/msm_serial.c:1739:27: error: use of undeclared
identifier 'MSM_UART_CR_TX_ENABLE'
 1739 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1739:50: error: use of undeclared
identifier 'MSM_UART_CR'
 1739 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                                         ^
6 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fc0ab43948caad95c0eb7


#kernelci issue maestro:d95ff390762699864781d2727badc1f762a8695e

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

