Return-Path: <stable+bounces-152393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D95AD4A3E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5173A616F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79D220F33;
	Wed, 11 Jun 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W6P+APv6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5E1E2858
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618361; cv=none; b=nR46AeEfnFayYNenbGQTsS+V0Z97bYgWb8BZvMKopOLaTQXDf4cTm/Y2ZbrQXU4VhD0mllhro2fZyMalpRIjpD/2P/vIjLm05aWhWtUwsF8/+NTJVhjfW7k/hr4x/BpXqGi1/pYQtSYZNIAHkgiJ79Kb1K4wbJdcX+F4JKEEeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618361; c=relaxed/simple;
	bh=JLh9AlrJybUwfSAGbI6jpDRHp2uVUz596MQA9zGFEng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5W3OveSMRinZvvozIp7gOugMgP7Ix5KO9X814V2ik4RhlK9qZrhHrI4jQNKcWzgUpQlHRLZ5GZ5iGqX8UsVQ7gFQlSotQyAp+kKG80ICigQZvl9g2GG7rwuXpHMMoidvvZje3a5strCM1dUiOZn3Hp5U6npoG2O1B5457efPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=W6P+APv6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb47e0644dso97585066b.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618358; x=1750223158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rImQoQLPddgPzmKA1QeCq2IKJbe+YbDQUxO1UAv5jnE=;
        b=W6P+APv6YGbIq3CaWqMtkSHqhMAPXSvaCuzQWW8ljhijB6oj2L3NiDnmZ3W65OhBoC
         hQwx/kEMXY3LVUzM/PhNCS+ylZvXWqGFJYImeUnCOwEMzAGS7YkR6x77lZpR7bgXINUo
         CI+AuCzyv584DuPWUfeVYb4Z6A2sW/hvvDiSRPHik1S94yUMIriJ9/fxrXgt1Qu+IDQo
         NUpa11Lf48r0E4gI3Fwklk0/hvSjhh6//U8tokT3utftZjtPUWkM6uZGBdTRwh4WnDJU
         7buurUYdpWawgmVjMsY8GZ/VIgBtJkQaFJpLwAVDuTCxVvDTq88fX49Th5r2xFlHJfCC
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618358; x=1750223158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rImQoQLPddgPzmKA1QeCq2IKJbe+YbDQUxO1UAv5jnE=;
        b=pbNBo7bO34NSfwIL1qHz0GGkz60k676jpEvobZp4CJkiNY2CYkQY+LdUIPWt7RYNxS
         wrWd2fcl5BYokjsG3tH2PcrjTn5dGpVAaLfum0vzf4OPtbp8Y5qv21Km7VYFUQ5g/Vis
         bQGG87sQK5h9NvShlDgx5WpCNzjlLKnRdcBLgJytXyycIosmmzl29WwXo2hbNeD62+Ea
         Wp9A9GgUeBzTbdidEapGwzjBD9PIahQpOFSW98eP4R8Ouj0L6kyshJSFw8BwecQVB62W
         ImigFckXBFeEQDR0H9glOstkgw5Z/6m03A8JCnlAZGvKUEgaYEConZ8wP1IksGSwR+uj
         iWzQ==
X-Gm-Message-State: AOJu0YxhnQPCNV/wOv+SAFzHn6A+y+IR+MYazimA5JLLbWv7iV+Aud8C
	NRKIExLa1tu4UbT+ily0RpX1z7gfVP6+ewnUhopgwVEFuCpzb2kONgWrveMo6o8VAp/5pHZ4nGf
	RY4Gz
X-Gm-Gg: ASbGncvpKSa3qFWFG/Bj83BLZHroZAZpeZhFTWWNgVHMaPcSVRw43KaCGJkmy2y9Hr8
	+PfIKBEX9pOH3b011YH3OQglgTQadesT7VWCprBXbx5MHGg6Qtzq1JYFfs9aSs0peHGbojkG2OR
	wnHvfh49Y+oJqiYeVxczWABZnZt0isIirIhdQpeZFdfOZHy1x0M/4LhGHAvPO1dJiyS8gI/vR1C
	j87vpRSOH64MWWtx2voORLDz5mcwItqfyrccppDOlA0FJ8ZoJ46WfsjANLT8vVE8NgfWRERJuJC
	VFlKM90DpbzzayOmyExP3FykAGDj9YGlQz5c67l6O2/y7OVsB0OSp+6NBerd9Do7auPz5sONpO0
	fosUMVkzzTerD4uuU
X-Google-Smtp-Source: AGHT+IF8hI/GGTeeYHgYX+RNjTDrJ4tSw5+vKPDwH74Jmd30tUaWiBkhgEux39toTR1Nu78VycBJoA==
X-Received: by 2002:a17:907:e98a:b0:adb:4085:fb88 with SMTP id a640c23a62f3a-ade896a3445mr165526666b.1.1749618357730;
        Tue, 10 Jun 2025 22:05:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3c427cafsm675513866b.75.2025.06.10.22.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.6.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 08:05:51 +0300
Message-ID: <20250611050552.597806-4-claudiu.beznea.uj@bp.renesas.com>
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
index a76c2d0669d0..5e3b5b398151 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -166,6 +166,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3356,7 +3357,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3403,6 +3405,14 @@ static int sci_probe_single(struct platform_device *dev,
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
 
@@ -3461,7 +3471,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3544,6 +3554,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
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
@@ -3563,6 +3589,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.43.0


