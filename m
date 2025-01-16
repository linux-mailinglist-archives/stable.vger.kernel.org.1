Return-Path: <stable+bounces-109309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EDA141A8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 19:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA41188D89B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 18:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94922F178;
	Thu, 16 Jan 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YeUU7cNt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4742361DE
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051793; cv=none; b=MIx6Bz7xlX72fmJqZ5DGTNN4v7fMMbJxAh9GeYx7jTycBir4YHOTSDSsVqR8MqLyAEDtz8dBXQrSnNAtoAycdO20YS84F48aOzPPN9cEjWKaD04vB5aiSdXn65WwU3EhbViFrsjq5bhm+XwgdsJnSOdHAG9+iZw0TlXwZJ6yag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051793; c=relaxed/simple;
	bh=+JZn/ww1FY/kTAFer89gJaTpDgTvbKcrRyepTGJVP18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu2pqKBvWnKcFzceqKhyUez4jIzxyLz4r0FZOp4QWtd6o46qsn44LCwsSxqXSJmrVt/lXe9AN9VTkmdHbzabJ4hECgeDj5uhpGWYurkyi4noXSgmq5TRlq28QdJN0JI3czMCJXC1s5ymdHz62rnnStJN43bevdY7hw8kTbIurbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YeUU7cNt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so685980f8f.2
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051790; x=1737656590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmtKKaWRtLl2vifGgcWTXPqXE2lcLz7qOiG2GbtoKk4=;
        b=YeUU7cNtxyYGjobOoDN8dw1YAkZTfwMsyPu+JSlpT4eS5qcxDlxUymNWWDfZNwD+7U
         CmZR2k0Y6pColT9i8J5vUsNobVwqxCzUgd+8aARt6VeH6R7tPNfiHvX2Lr/vnxV6lVPk
         +nPrWIWQJApJqPMsLtymLbeTFbIjjfp6jllbGHshBwEK56cRVOyxtmHMZBty4ZgFWVK6
         XNhdWJgem5+EC4EbeFgx0Vos6SLMpBf0xcMMy2tsFatfb/5BKxyg0isCBbYSM3TzVglB
         f3kSNGav4gDWgEdBmBim4CtPvAzWLeGq/CvxdW7+MGOqGb6hY1AfqwIJ5UeqIwgeF3AQ
         yg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051790; x=1737656590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmtKKaWRtLl2vifGgcWTXPqXE2lcLz7qOiG2GbtoKk4=;
        b=K3+acdOLyq+yFllk3ENOCklUq4M1HUTH39N25ErOGcIrqQ+wuZz+QivThiKpCyI9Mx
         1aaaxXQXEskvCRd85EZXNIGtaMQwcCP0siRu9qg2ogR6415Of1aQQrT3IFgFblnYvnHz
         04dIEefGkHesU+lqtK+8Jw6yQQdI3QuNkaIg+KORkSSjJnlpvSaDkmLfZ9XUjO8LEdxn
         JPBs0U3MrainCrQ0biHj6StA/Q197iJ8ex+H28l2+mSOTLRhR8nWppZCESOaMgvVCJO+
         frfTawzco/K+jXl3szqe7mYp0evD/qas5tyy3oYlyltMfDQCbsWU4IOA1iC1ZI27bP6F
         W7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXaVD30rHSPWPEVKkNa6BdhfBlR4UQwOrtKSPbMEbRl6M5dhSWbfzcITnU5QC1qkSBX6jz1DJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcNaH/K/SSHl5gv+trqwCdXvYC9nLB5Kx/1VNuKlc87z8PgcK
	XWY6WefkcTbuw3a2p/jd3/UomRL+SpPx0m+0UHqwxib+yKHzirY6cwfwmKco3iI=
X-Gm-Gg: ASbGncu+fiYsbQkrJuwTimBb48jjJLyBTf1zSdvNOL8yVRcO5SlT4p8wyRqfpbO6vJD
	D+fklUH4yjRz/bguINlfo8haeEGbTMY3ogV+RhTSu1V6sG/PVUDTzuQOxMBdxZA1lJoZpuQJtpG
	JmtS/2W5VNo8U6ylADXBsyITxQVCNt2PisHQFISG/QUT3fVj3mTv1+jBLjBNpixMz8HExpA8y/o
	hu13wBdfoW81EatKRO/jmtdR70UCgWR1N05hZRFUdF4pPvHSrMuSTzH5nbus3RYJSIBo+rvFy10
	r/okxe7OsE0=
X-Google-Smtp-Source: AGHT+IHTCLzWRVHhlR7lW8GYQyylUAfvSBIe2YvKqor2RF/6OYe8hunZYeSsvJPm4KC/0CLZzX9ROQ==
X-Received: by 2002:a05:6000:184d:b0:38b:ef22:d8ba with SMTP id ffacd0b85a97d-38bef22da4emr3656439f8f.44.1737051789820;
        Thu, 16 Jan 2025 10:23:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:08 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Thu, 16 Jan 2025 20:22:49 +0200
Message-ID: <20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
          device_add() ->
            bus_probe_device() ->
              device_initial_probe() ->
                __device_attach() ->
                  // ...
                  if (dev->p->dead) {
                    // ...
                  } else if (dev->driver) {
                    // ...
                  } else {
                    // ...
                    pm_request_idle(dev);
                    // ...
                  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes since RFT:
- used spaced instead of tabs in the call trace from patch description
- moved the comment in the code block started by
  if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start)
- still kept the sci_ports[0].port.mapbase == sci_res->start check
  as I haven't manage to find a better way

 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e64d59888ecd..b1ea48f38248 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3436,6 +3436,22 @@ static int sci_probe_single(struct platform_device *dev,
 	}
 
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
-- 
2.43.0


