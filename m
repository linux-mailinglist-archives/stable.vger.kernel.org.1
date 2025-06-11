Return-Path: <stable+bounces-152383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE02AD4A2D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CFE17AE02
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D82F509;
	Wed, 11 Jun 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LUFTtAOu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A372AE66
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618101; cv=none; b=cgp6H4PmXfffh+N8j8B9glGIYe3tXXdzbmTqSofvqKx40VSBkh8+z2lK7KPvNzLjlugLvKFsGoNVCKg4kTTrK/WDRo9JHAeFJISK03hmPFXD2OcSBfJ6aNz4R0aNcss6rtdzlS+V9lK1WSvoY3cXYGCFYG5p0NRylNsPsx7kLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618101; c=relaxed/simple;
	bh=annOtQVpUqLZD8YXA/wmb5jL0FMZYviwB6AxnlUvbzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIugmN4vsm5f1+Z/RaRMwO6iAEpv4DEqCoUBRTUw8n9PJt8f0CgyyiU3ghb9hTesZHfwNKPOoEZg3wzhb++lUwa+7nMKf6iFrplJeV1pcjj4+d6+Ph9X/dqa88crf7OQM0WX4eBYwBoI/1wX5QCTUQ3IJOhsbMeqi7H3VqgvV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LUFTtAOu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so3722047f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618096; x=1750222896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyVEWhSSwvT4V/N6jyhVb31Y/rbavo/iq2x7Z7IvhqQ=;
        b=LUFTtAOuKTlcoE0f+qQvQT8N/QXrbFYgGWSyD0qeQ0+9QP+VI8O3ZehG11BxZ9LBb6
         EZc9DLJQ4XWmKG4sKusrvwCNsaJDDE/slYcEL7WlMhkqh3uhHFbb2NmsDSMvZK5/P3yM
         HV08AFisDfIbv7E2b5t2doyo9p2Nd/5LsJ22gtahzH/xb/MO+9jF59v2AioD+r80ysBf
         XaHUdffsyZepANerIGAPxGWCPVz9QmD41qsN9YBdBYiJn15PEmtQRVwvEHEQT3WmRBJR
         pIEYyVeSP6X3Cvz4yt76Urm/AujD+XFMd3xQ2QpI9laXYpLesPROOu+deUQdJ+sWBc20
         7/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618096; x=1750222896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyVEWhSSwvT4V/N6jyhVb31Y/rbavo/iq2x7Z7IvhqQ=;
        b=gTV9HDB6wa+E3MkouIxh/N9HYRQFH5fnBc8zZR5tFc5RhRa3/3Z1o0dWzK0Gn3vh9e
         pS/RDTxzYWFIce+r7m2VWHMMdiD2y3st1ZOi94V6OxHMAsGMAQp5/SeOG/1Bjp8JFLqz
         TudBAnK6+deLCY/hU+D15vrWE/lDq00wfi/Ta4RnT7oSQXLkNs0D7WrJNdNpWiYniMkm
         92oYUzAQRdbbyHEmAswawNd0bW/P9buSnzOf7BUWL/XAgcriIyW08jD3tc/W6Jx+ZC08
         PRpoG9jYNcgwggNgWRWTsTWB//sa5MyebUJE1VBSS5H1HjGjlAINP1QYMQgLujQAum3L
         z/dg==
X-Gm-Message-State: AOJu0YzHGlBC42O6lT4glqsS73iwT0f5CZHLYy3giUkzJ0MXFusXFkkT
	mcDkId00JDNQLUaU4hFC0/DfXmC86mMU+o20vYIcLndkH1271rMq0rq5AKOiRY7brSpH31NvQBs
	pA/pg
X-Gm-Gg: ASbGncvdMwz7WvR+oCs4vnj+SkIwnmY+NwhuvOVauUSRdKxN//BQOXNKCWDPLrAezRQ
	Qyhvo2evyq7cAWJo4Ip4KOTK24t2kY4DMDFsqyyKW+zAnZUNmNenl2sa2yh2GfE75B0TOts6gM0
	KNcu0ykKtyvfoZ1bETOow0BMYVX+Akw5lVb5zmzaI/phdIerBIVfEK3jsHX4SdVfe4ND9s/vB7R
	hrTjhMpYG/LXo320GvA7IXDFMuBfjm4ZUOjZR04Ezq0g+qPZk0BdVPmjX8K/1ZEQI1o3LmBeGmB
	eLPjv/LaWmNfE348m1Px+4P7GnSsGpIIRgFCPLiTcJtBSLR+fi8mjumb/ajfUP5Bly3zzMLZQ/h
	zLZ2QIyatJPmyREPf
X-Google-Smtp-Source: AGHT+IGwC8fZY57mxoSKeZ0cQytFKUg0K034RWKQ/flHKaXjCOntChNqOjjQ8PJnCWJ5osZTJewCWQ==
X-Received: by 2002:a5d:64c8:0:b0:3a4:f2aa:2e32 with SMTP id ffacd0b85a97d-3a558afefa4mr1015215f8f.44.1749618096556;
        Tue, 10 Jun 2025 22:01:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm13885875f8f.100.2025.06.10.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:01:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 08:01:30 +0300
Message-ID: <20250611050131.471315-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611050131.471315-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250611050131.471315-1-claudiu.beznea.uj@bp.renesas.com>
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
index a24fcd702f6c..534b9840eb79 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3284,7 +3285,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3331,6 +3333,14 @@ static int sci_probe_single(struct platform_device *dev,
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
 
@@ -3389,7 +3399,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3472,6 +3482,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
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
@@ -3491,6 +3517,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.43.0


