Return-Path: <stable+bounces-152378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D6AD4A28
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068733A5E63
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858921B909;
	Wed, 11 Jun 2025 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QArcpu69"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB72F509
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618063; cv=none; b=NRsA3y+npukNGj0vgqMzyap5xiHt38zAHukREhBhfS4sj0szk7FRWnt78uKQ7n+NbcETPf65qWXhl7db8APsoDZzafRNuIqRrQdDXlfwtbLQcDifbewxWKEIXXl6Us+mYB0G5k9mX8A1FaJdoOF4ESz0nuIFDCpOYqm0F8VFN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618063; c=relaxed/simple;
	bh=iAwNey10giuqzLjZt6H/3FUBz4l4twpM1CL14kRPeq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfdifEUegb0QI5UGygEPRbUxDNHUKExLYA3/fJqGDHCKfO2W18Di+35yicGCIroMEoZsx3th7y89xEu6a6LSfLEqBzMoGJ5WW+1LZK3kbgfNtEOvVwgJt+FsDRHzhw/Se07HF6gShhMqVkYPzeK+Vkgk7WK5GGPndwydu4P2mQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QArcpu69; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso5551736f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618059; x=1750222859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuV3myyDWLAVo9NfsHBwW+0FGMvMgUNo+g6P2ltaewA=;
        b=QArcpu69VAgM9eJ21pJ4OsJK9RUDkDx23Hepv3M9Tv6uTZFtKOt4yCefEcybjniOjU
         hUcUPOGuFISIfKXAOHsOBccOK7kVmRMmFnmCYfZ3Dm5ehPAFU3qZB5b04qFwTvBUJT4Y
         0ZlOIk8qaBD6qUCW6VCZ+dgyIchiYTRtZ9irdX30Emwr3aoNculKTp/PYuqjqwKawve3
         XoCO52aO7MzF4ZDoL9UUkDy5ulxTn6VqJHWz17czziVa1YJL+EcLv2S5WQUuG0XjOG7N
         AJ0A77p8hmjEm2RiYfnQct3Twe2AVGBvzYoPe96xAK9Ut4ueyZYWXrfAS/J2Hip/FqPe
         VXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618059; x=1750222859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuV3myyDWLAVo9NfsHBwW+0FGMvMgUNo+g6P2ltaewA=;
        b=d0oWa8frtNNj2j/v93HWnhQzBPHPfmNIM2+zi6jW+VuWHm5QyN3GDcYmd1ZBXNEkwL
         84L2E+2Mts3KRdFsW0ZcDapA0clXbBe/DNpETBmRWXJG7En6sJ3nBpNki/Vsym+G0Pz1
         FsivFKGt6VrUkiLvLmit04vL5V/VLT5Pa/W7nQNnnYLxEAtC3YbZ74JLy15ZAuh88nkf
         fB3dpVvWBdHjJdlo4z4GGZFLIXZHus57718ON84k/Wl9A3FkLyTfZYrQpF2VI50hfP0G
         Y8voP0K2v3hTR+anrI94O9tFiimJRf9G9LM0YdKtZKQrfsqhT53MX8+E+uuvPDvkMgTj
         NXJQ==
X-Gm-Message-State: AOJu0YweIVYJlei296J0lApB8jsxl2myc2bInoDGV3l8TUDSy1ftJSS/
	5jg7qpOQ5NnmexmAiRbTExhcHOcPcK5heiNWyXSJnhg2dDZeod76N6iwxQoUS34HiKIeOF+LYSq
	oLEhK
X-Gm-Gg: ASbGncvjxmGWcecqn56xzANcem2Sn4cr2t3iU77BR/cZe5WDgYEZrMzxo/krsc1ezL2
	kSyJHKDuVpcrCPch59hbcVEMOpbaW3SpqSQZjyXSESQoEOsJgw4PdVjvPhxpKQ3M0qN5avbKPM3
	uh7Pu5LvgqHcYkvE3LuCUqsxNxrELlxOTWRS9u0QwNFFrlGEzJ89HFYt5m02qu8rfumOw38p2lo
	GEZcT+ZhSMaT5dD5N3+o9xnsryUbu7swjsjIrni4FI1zgzDr8izp1H4pio/HAWV7BA65h6YAYJt
	bYbm0qCIKiFAvfAPPcFdtlMCBi5U1pyB1FiP5uTDde7B2aHbcQRWBc0bfpLsDr3CfLfWl3XyeoU
	kRxbn6O9HZZdue/Nh
X-Google-Smtp-Source: AGHT+IEcEL/yAqmJ9Wueb9q67QQ7E8VvM+hpQEY+t3K4Nw7jc5qF7eHJo9i4YrH25LJ8jlpfrnVn0Q==
X-Received: by 2002:a05:6000:438a:b0:3a5:2875:f985 with SMTP id ffacd0b85a97d-3a558afa707mr1092017f8f.59.1749618058919;
        Tue, 10 Jun 2025 22:00:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm14252044f8f.99.2025.06.10.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:00:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH RESEND 5.10.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 08:00:52 +0300
Message-ID: <20250611050053.454338-4-claudiu.beznea.uj@bp.renesas.com>
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

commit 5f1017069933489add0c08659673443c9905659e upstream.

The early_console_setup() function initializes sci_ports[0].port with an
object of type struct uart_port obtained from the struct earlycon_device
passed as an argument to early_console_setup().

Later, during serial port probing, the serial port used as earlycon
(e.g., port A) might be remapped to a different position in the sci_ports[]
array, and a different serial port (e.g., port B) might be assigned to slot
0. For example:

sci_ports[0] = port B
sci_ports[X] = port A

In this scenario, the new port mapped at index zero (port B) retains the
data associated with the earlycon configuration. Consequently, after the
Linux boot process, any access to the serial port now mapped to
sci_ports[0] (port B) will block the original earlycon port (port A).

To address this, introduce an early_console_exit() function to clean up
sci_ports[0] when earlycon is exited.

To prevent the cleanup of sci_ports[0] while the serial device is still
being used by earlycon, introduce the struct sci_port::probing flag and
account for it in early_console_exit().

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4ce6dd7c4092..7c574901ad1c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3308,7 +3309,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3355,6 +3357,14 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * Skip cleanup the sci_port[0] in early_console_exit(), this
+		 * port is the same as the earlycon one.
+		 */
+		sci_uart_earlycon_dev_probing = true;
+	}
+
 	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
@@ -3413,7 +3423,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3496,6 +3506,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct plat_sci_port port_cfg;
 
+static int early_console_exit(struct console *co)
+{
+	struct sci_port *sci_port = &sci_ports[0];
+
+	/*
+	 * Clean the slot used by earlycon. A new SCI device might
+	 * map to this slot.
+	 */
+	if (!sci_uart_earlycon_dev_probing) {
+		memset(sci_port, 0, sizeof(*sci_port));
+		sci_uart_earlycon = false;
+	}
+
+	return 0;
+}
+
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
 {
@@ -3515,6 +3541,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.43.0


