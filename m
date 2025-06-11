Return-Path: <stable+bounces-152394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAFEAD4A3D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C9317B445
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B91F0984;
	Wed, 11 Jun 2025 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MAIkdO2i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3103176FB0
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618362; cv=none; b=Bx5m7EPwsB2aak3CeEvsHDEYP77hzAp3SqKtH66sxm1+KNd8/3AkVyVNM0JhqpwCqstO0BVVb2kPab10PEqykHcOI/Z6RIFO0irfuCtqK+8KHPo87tkawyzfPs3o1opA4MpWXEuhhbg8kHE+6Ve3+Vkv0RQ9SSWE1+DapuKoJk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618362; c=relaxed/simple;
	bh=0uZx4Dawgy+WGMNELH7SXXDGoWAqPePcTrTbj0TR/F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orekbB3QnpjjGy5zG2nqLHJJ5yLDbDZknqpFMD7+VGOnPNVTNitA1oP8P74bzTZPXCl1GhQ3TNLQES4RKDiRKFZvc3d+MJFY7jxYw7Q4EdgY7fZjDoDvsxlLd84UmSPnjaWWdAHR9svXu15UgwVqjA12wTWlaIuo+oEln+EdUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MAIkdO2i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade750971f2so240516766b.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618359; x=1750223159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7C7slGmOpsfIfSJYls1KJfjGXzs3t1bZ+iMnV8B5xk=;
        b=MAIkdO2iyzAyhoMmEPfpM1S+yz2s4Fnh3n46D75BJBLDh0/TbPXuudoaXqAcCWxRif
         IRjPu4J2NbA8Y2LkGXtQoKAkooD+fVUT7/VE4klf4QPCFca10UY0NnpjOa93KDHF4ib9
         QpFiBLpKJsXx9DTQPd01FONpBdAau8iEByN5CRgvca1qVxUvmeIu8eAkGcKszdL0Fw88
         cLBoE4hj/w1u5xGcR7qftRu2Gf1xd/YL2j/681RGQ2p/D5hOsxyNFhT1UDyyMnnQuo4n
         qJT45p2eOJoaRoZcP70RB/cJ3K9bTUamu+pej4OpicTysoXInXFThRKn706LVq3TwxW/
         dluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618359; x=1750223159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7C7slGmOpsfIfSJYls1KJfjGXzs3t1bZ+iMnV8B5xk=;
        b=Qmdc3+IslMun0Mz7cntlSCwZIwcrtv/Vvgc7S0oU3ivDIF3GcYySqAO8HHBrepTPtI
         TbklO5pwKUq3WXG1K9dxmLzJZeSR1ziDuB+IyU7hOWkLH6BfJxfd7x3N81ITHGy/IfhY
         AoYJPFhEkXnhH7SJaEJwObns20TQpGqOn1A5c9cJaU/1PMr7jstO3S2T0lCZ81i3UXUH
         WeQPQNAn2NkuungYA/KXHHnOCawSc5af0K94S97cHWp04zIRYvhk31EMb8Z78WrIvNhY
         DvbA5Ak+S4lOBrYUCia3qv/bbvebjo8zn1Wk6tBqbmUUPkg9N5WDZZ5Qi+Nx6/Lc67+h
         5QHw==
X-Gm-Message-State: AOJu0YycNSnhTwgyp/T5F6cMHOP38jQYNCmhgtuxX0bnzlozjs9QUbpH
	uDQuMwUNNnR+CYbo/03zmj1B64ePhLGDIytHalBIvJ6G+Jj5R46MjGaq9TpSp/pJ+4fZID//FHj
	K/IZt
X-Gm-Gg: ASbGncsE66pQ2Si7jYJlt4SB6J78ZW4MbsOZFL6SEQS/g/7yTyvO9vneidLKsULbenn
	r2q/KPBtHoZ9uKRtGw3RWb/+x5h27mdXt5yLwTTeotJMUh0gYSBjFna03po01KH/ytWR+8qRXIL
	+wFoD84r+tkuIEgQa5W4+sZBm6rqFw4S2kSuPTT/76oZuyg12G7KDqvC8jPmBIfsUnVEuI6Rsy9
	erdZ57nk4TuC5IObUFDyjAJAz1LVyFDh3DE2c70FCOu22QjNhSjmHTig3orp0JUzksi+QM/iyxT
	HWVTq2uZQe2FDypPXCZ6Y3z4h9YJISN+YbUjsAfzKCXmnBO5WlkK5AEges3jyeUJDg59IzQtbef
	Vy637Wv9D9BXBYBZu
X-Google-Smtp-Source: AGHT+IHkebTEDt3owFpg7gBrb4gvSA0d9gHT/SlZlTPo/YXu9AkiEnN/p7utyReOmDVeD9+6OlA4lg==
X-Received: by 2002:a17:907:60d6:b0:adb:e08:5e71 with SMTP id a640c23a62f3a-ade8c769374mr132581266b.17.1749618358956;
        Tue, 10 Jun 2025 22:05:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3c427cafsm675513866b.75.2025.06.10.22.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.6.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 08:05:52 +0300
Message-ID: <20250611050552.597806-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050552.597806-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050552.597806-1-claudiu.beznea.uj@bp.renesas.com>
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
index 5e3b5b398151..716f12f866ec 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3406,6 +3406,22 @@ static int sci_probe_single(struct platform_device *dev,
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


