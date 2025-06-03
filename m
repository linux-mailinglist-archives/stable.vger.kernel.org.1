Return-Path: <stable+bounces-150676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E238BACC33F
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6B8169D52
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33F281524;
	Tue,  3 Jun 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mUtfJxzg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02739281505
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943430; cv=none; b=cPykMa4SWgKNhKB6S2tGsqyBkIlPH+1mwm5mhkf9u91xTJRPDfF3caMr4Y899WqaoqIHGWap9kpuW2/gdM8q+5Ujxuc5QJqA20fAiHbos9P8UVhII9CvK6EMfKwG2JFGqPuYy+vwhGHPlm7SE6Hn5p0Qp9nvlAT5N5Pzv0l0uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943430; c=relaxed/simple;
	bh=T753QEGZinNlv/C3kLNOxMTQmZgDCVy0TztIe1ulPpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAr3zi0ha3QLGsxyvcLWCkRwWp9N0mbIDf/Yo0ciE204RvxcNXjJAkNB/RC3ZHC+4AqBUnCRE7ueKycevaI6BICPEYQIqDlhvXB8mbL6vqbxRGn8lXFIZui8q4gSyPYUh/jmlW60ZJ5SP0aoVvqRsvEJ8eu0H4tpzx3lshsjMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mUtfJxzg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so668052666b.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748943427; x=1749548227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWJfLLS27QWEPyo6rHGegekVxELrhw4yk4Q3OJJM/8U=;
        b=mUtfJxzgSTtRyzTCza9bhpX4jULJJV91r+F9UT8/EgyTDwLIFzeTY+trLQs9qNa357
         UqgAb8heVju6hVPS/nmJWPMwWSypvkPrEnJcX83ZsTNwCzTMPl9bcmBrUkB0NFzu7Lp4
         ndY8kx/MhnBKObGDbguah9yiFifB56FoVwIJptzD20hbA53lu6NXNLZCUcfFyl68WEl9
         88vwEZkKjKqeTaIyZ08r8yNUthivqPI7Kjt+RCLiNj4k9pphyb9S6hAnh+DTB+dMJNyw
         qR2YXVlEb5snzWwH7TxTpWNi6I8WgS96BlRvny7hXGGLzy+NItP5xFV3UuZRLo6dRts4
         96Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943427; x=1749548227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWJfLLS27QWEPyo6rHGegekVxELrhw4yk4Q3OJJM/8U=;
        b=ddhMt3Ij9vB9TFiB3ZMbAfL4bx9zhLPHd5pE+u+StcPftBkg0TuVXwSfByHEjFEDX5
         PNOwKoeV4YqiRWxEzTwKvo8gAJHhItyPLSgMKwsQgm6y5nDw5ihlk7UmNhdppToPMQF9
         XhnYRX+TPUs6mUnjyMQuvYBTWmaohncmBOf+8pxp+bTkJ5UGJ5w7QM5bbGAY9AFjxn05
         p2xBr1LmN6ukelV3wmhD6v0hIvCKl7zxdfdJxJmgRTaRpbmkkDW6FnO4da373uWLKFkI
         4N45aNwx4MkLOmso3Nk+eKDebeyTqTyDaWp0+SjE3YaOd/dqbmNgYyeQH3JwvfFQaTIy
         8lMg==
X-Gm-Message-State: AOJu0YwaUUMedA9QTw/mTVqw932Wc3L6grZavWHMYFG6ASv4ZboAUNQ+
	qIsU41dguuawijNVJ05IOQz3cJ0Gw1HAWG4VbW6aSHmDkEb3CBoBVABp3KGwkC9iNjectDdOI1f
	cDK/5
X-Gm-Gg: ASbGncuoZe6UcymRFKTUNIazXU7Nqmf0xPmbc01wf7SvJijb39GOek136ZP7erhTAYX
	WTRTrwAwKp0zpHmZRTFvyBI1f0ktk5Zx3cn9sN+24IkXwDkY7klBwXuIXOteTXf014YVR6QQ7WW
	6siyvM+EKFupKdrQgrcsjJ8UfVxTZTcfdUsEngAlPZs0JwfczfA2wO0k82+/1nDGqlC47811UQq
	xGsO2lcRAMkCNgWe2yWRB4G8+Mpyi+cOczBZuJ0oho7D+TMQHydfvHwB9o6FNBOBlH5cIiAlhN/
	suevTyPUyIvOBkIiLtVP8tqIxkEx+5B5k7unxtkTOomfXKo7Z+3COJ3ZGsgz+YpuxxnwXEaKxN8
	GqB4PWw==
X-Google-Smtp-Source: AGHT+IGzppZkx1oLNoUouwLt5nZzQMcS/B+XQ41FEQxJAuI6dI+W+fD78AnnuFdoolSEbTGqkc03Wg==
X-Received: by 2002:a17:907:3f12:b0:ad8:9d41:371e with SMTP id a640c23a62f3a-adb322fe389mr1814750766b.36.1748943426879;
        Tue, 03 Jun 2025 02:37:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606af7bafedsm779334a12.57.2025.06.03.02.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:37:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Tue,  3 Jun 2025 12:37:01 +0300
Message-ID: <20250603093701.3928327-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.

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
Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 000a920727b3..3b30cf09bb9b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3358,6 +3358,22 @@ static int sci_probe_single(struct platform_device *dev,
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


