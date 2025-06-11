Return-Path: <stable+bounces-152379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C6EAD4A29
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A29817A2D8
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4A21FF45;
	Wed, 11 Jun 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bOJ2iYva"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44A8F5B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618063; cv=none; b=iMTK4z2D9d9DXevogEfVo8qxzbA7KstdAaSEgnGL+YZ7lb0gKfYl6oiBaKlxp+cVV2/XcjN/YDCp1Uu7FXh4iw9s4Y21PWq1bMsddSVGPgkbtLaXu/JkNSxTtQrFAczQg65AYAzjesAtl72+kWZSp833LXWkVXdTdtMGeIvY1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618063; c=relaxed/simple;
	bh=zqu4id9BJt7HTjJN0D9q2S1L7kbyUQ5h+zPj941gP38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asTDnNXHSSuY2zTh19gHviEFJhcBDI9gO6IemwXhgq8pre+dq3iOQb1ytg+9eDy54HE/pHK5uXCXMDO40QlI5nN7yHkNQhI9q4H9SysLvPDaronOwdPzUrt+GUV0qpTNU27jEph0wB5hMVcORBF9Yp0zcKx+Ztul+5WgyXqbkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bOJ2iYva; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a510432236so4828311f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618060; x=1750222860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcqnDL4QGalCAimuf8NBL9nIZJPEah0e7XACPTISPCs=;
        b=bOJ2iYvaIWGRqRX5FKgBGgIRI3R7PrUolf4LNOu4GZm5QMLSjGPdjNmWV9yX2vRlaE
         VtD271DBY+v/b3kBVaU6fp3wktR51izzOB2OOF09LXikxbeFSEZ62YNN4W5mRNitmCgS
         ihIHoWvsEM2bpfPpFWRDqJwdZyzGpHSbDrszWej2J8PyvKRmbXRn25gBz4aKekBbvBng
         baP8beGaJJlCHko+3yw0GbMPR1O+Hqbo3ZG7plEEmgFzTxoKzcEQeot9CGn6rdIHEy+o
         iA/xYhywnRO4/iHspZixK5urGtwPo9DQzXC6JCnlgVT9QnlDr/CWfdF9J+TTrYN8oHrY
         xhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618060; x=1750222860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcqnDL4QGalCAimuf8NBL9nIZJPEah0e7XACPTISPCs=;
        b=HtxwHhyuSp3/lD+GjS2iockywRw/yZWy7ua9VsWRBBjxNUE7C1twZt7HdykqpMKtBS
         8+OCrhmVIxxoGcxNRsH6dhjPEHyKif5wsuOCydE2mCtMiXDUt9omhznGrLKlb42Yv2kn
         wdtmWrT7SXRtzDDTYU4VFrAHn6w2yE5NB23+lYjlhfDVWzmD86LV0Sdd4daSfJa6rjLl
         5DD2h4dO2ziIJXZO8EVLScoYZ8QssVnsXfyDkuW9ZBxlDY5JOmcVpnuacykdr3AS3Uqy
         0qv6UwmLSopgNUKFdxYno8MYlP80m9QIsAnADTzzw+6vHAl7xS7a3cemNLnJzLcf8m5m
         9How==
X-Gm-Message-State: AOJu0YyhVnXR85aeRdDSRnHDSiImzqXEmz650JRwVb82lq1ReZK0ZD4+
	GlqshNUhOzb7hkEw+m5wE9O6W99gqWR6SpOAc4l67i0Ys8hH6XkCOJKveYV8XNdeuI1M1O9B0eK
	GDKee
X-Gm-Gg: ASbGncsagfsBZDDn0SHf+XIjCZlPwWDCxCrQgiPA50P9nqS4Ikp7AevoIY9/Um2TooQ
	dx7a6mY5uiZEPl32kbIysmxeNzsf3GmZd5v4igXo5IAETJnFjCJbygVPW01zbOc0BMizYSPolxc
	99BuXR2ZrFjTooKVbjTaL3boOsb82XcT6sU0vnhgFsgLdgr4yIteXKqE3X5hjdWLfIY+u/LhbKS
	6BL3b0tvSFoQBFoZwxgPSwLsM7L/0vW6uOYaII+hAn44oacNhtZRruutE6fXkEB/NoaQe7QWQyW
	K7lLSS+nP7QKdx8zAQhGV5tGJmUcn4JVZav4T6eeFFqVSQ5USxKOKbvSF6nw5IW5GdGrGDGz+XR
	LcWkkVgE5Em5Jmeuc
X-Google-Smtp-Source: AGHT+IGtWVtejumNhVSHUSPlNlEsZltwP96h9kjrjpwJ4LvFdCvmQtRLxHwdfb+vrcoc3Y1s8rl9vg==
X-Received: by 2002:a05:6000:22c1:b0:3a5:300d:ead0 with SMTP id ffacd0b85a97d-3a558a1aedbmr1095921f8f.43.1749618059980;
        Tue, 10 Jun 2025 22:00:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm14252044f8f.99.2025.06.10.22.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:00:59 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH RESEND 5.10.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 08:00:53 +0300
Message-ID: <20250611050053.454338-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050053.454338-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050053.454338-1-claudiu.beznea.uj@bp.renesas.com>
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
index 7c574901ad1c..2e1783ae8a9b 100644
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


