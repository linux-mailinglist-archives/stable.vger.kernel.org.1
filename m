Return-Path: <stable+bounces-152389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73ACAD4A36
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759D2189DA0A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691A2192F2;
	Wed, 11 Jun 2025 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I35yyB9m"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CE1F0984
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618329; cv=none; b=So1v8N23TmJnAmgbhtRp46ZzCDR4uzkQUezG3j33qSZNwqvj7b9mcj4wjH68ec3sFhu8ilPcDZyU2HVG/GFe5SgQmQdtyNNX71Y2F8tjg3aUvQaADWnvpv0hIWqHp2k5ZDKY9ELIDJs+sJcrDdDj2J78SQnrl76BdMJRsCxUmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618329; c=relaxed/simple;
	bh=6ANjo/Gknj3XsLcUSXtGPrMzYLZdUtAS3/DytppBG4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv8XaSv0K5uSx94RZFIF+MQXtxuS0sii8ZePboxyAJk01iL+qSAS6CzdQ1c5+InsZHNRqeHapAhaFE94VsCuZITay92bM+Cj0hK9lf90ijhheqGpRwFH1/Bb/IuehQujhEzfmMc3Sn6kzv+r8WYaGKiJt3Q4MOl5zvQgGVUI+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I35yyB9m; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso10863502a12.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618326; x=1750223126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVg7Zd5my65ijy/tF4i7RMdGGVM5lGBKGf0Ub+WfqJg=;
        b=I35yyB9mMz3uZiE1VLOAhNOOxfZo6A5Ltv7A6h4qPQ1MZRszWdxdHmZeQz6MIAZH0o
         QILZwuHkfIvnypIVsL4nlifU5NPBqqDKfZlo+dDHLmhFKSKdlZfqCo318KqMrG6MvUKI
         KWpheyM3VEJoA09tNop+sGChbN19Y3wL55MBd/BEXavgatptuvjw/BGPqR2Xbdk1qDMt
         4Q3WFUaT5KbGYpMsYmqXQdzetslGfts/qkFL3F99cXIMQrPigTtQTHeMHMz1uY/F0Xdr
         h88ZDCawnWAErZO3WgnSWm8xgxm+lc2CkIJxE0tm5R8SaUbvrXqSY22FOcpaKPBugpQ3
         ixQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618326; x=1750223126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVg7Zd5my65ijy/tF4i7RMdGGVM5lGBKGf0Ub+WfqJg=;
        b=RWXGadIymCzvcViQDhRK8gOkXagcDcUCH+LYFgnvohpVKYH6uyGei/XWjWTgBZPIEE
         pVgS5vpUPCRNgaxwcDRyZBUcrmZwh/v79v7RToMX7o3RgXPLZNafxQhOQazGHxy17KTu
         5IzPQ4vOiZxYFHHosihYIYc+VpMk9j5oAYX6tjt0TO4u96gYSqxFhRWyadqBNZ4QsmgF
         KvgZRM2f8wkviTj6MUmRdDs6WkuPpBNDG/pmei6x7LaNDZLPbqyS5CF+p9W0HxzFP098
         /Q3MmIWXoFj5hmpOLn27FPy+P/aCKlcYoeJWiTRG4ZM4jucDy722HN3EtRMnWZDXO6LP
         KI4A==
X-Gm-Message-State: AOJu0YyYTuHp8RVVR18LIjKVSVRoe7V32nZpG59GCuy56LIvZ/6rPcJh
	FGcGGt8tNOdGJgWKuVks0y/n0+RAaKYH+o6Sx0A98TLCMad/yvMlBwEaEiArX1/Bn8YhA0JNV3m
	xOoaC
X-Gm-Gg: ASbGncs98/12yPpkMryDp8VhMJ6FMQAIront8D8tItZTSRKZ2SYkYTgIq09AKqxxwwv
	jhYtSK+KjF8PQLu21QmEBeKrfYqdFwZuKGTYqXftSGqvZDdf9hWHYPsUbdvOCQRhCzWbOknt7iQ
	BztJUGl03AdNWZxDqABjonmt9XfejgWP1yXBxGjxulPymR7JBolt+ycdogyx/y3btcnsEdFlL+v
	KhOwOtVVy7kHsJPzhboyH10OfVr71qH1bvMa8OshkPs9iVz93kkP62Ah/ltdlGSwJ9am1JZ2tyG
	p6Y6UmAkXyaqXv0DA7vevoe6rZOswPh1sSmRLOwqgY7CH0t7gUWN0tF7BPmmBoI//vooB789zEs
	WJ0DSfBa2/3okZ+4v
X-Google-Smtp-Source: AGHT+IEh3IQkiwCKafaamEQfyZBQbOghuXCBqznQlcR5taep1wsHERL0x4HB8jFv8SvOBVpfqB3acQ==
X-Received: by 2002:a05:6402:27c6:b0:601:fd36:6ee1 with SMTP id 4fb4d7f45d1cf-60845cae860mr1639238a12.0.1749618325632;
        Tue, 10 Jun 2025 22:05:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c04f9sm6961577a12.52.2025.06.10.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 08:05:17 +0300
Message-ID: <20250611050517.582880-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050517.582880-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050517.582880-1-claudiu.beznea.uj@bp.renesas.com>
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
index 21f892d68f3f..89d48b61b6cb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3333,6 +3333,22 @@ static int sci_probe_single(struct platform_device *dev,
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


