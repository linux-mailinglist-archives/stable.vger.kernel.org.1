Return-Path: <stable+bounces-152388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C1AD4A34
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5743A5DBE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230D1E2858;
	Wed, 11 Jun 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YsQ+JPcj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67D176FB0
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618327; cv=none; b=jN+etwt4qqPwmY0t0CpINKZeL7tP7mD4Wxe/om605/h/kIX5XrgOlb8S2ev42KXmyAGs1BOgtn5C+gypO2iPB0R3MtyEFZjboMHqReg1TJcuH+SEw8timHQcWajUZHkznJHWQyYtpZ0kaIQ1/evm5XDeoDcvMO8xpqWvN9Yn+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618327; c=relaxed/simple;
	bh=ZLGYTmNrREtG/NfMknDUkA+vRwr7u6xaBYsMayOf1y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYpyzRPAQp6ja4ywDXRaM+LsklOn6bZ9l5c92HViAOsoEzsHqnmohk5NXM8Rzxz3xxCFLMMRnehr+2MtwKoiXcDTEoucFDsls5tn9AOczHidwxO/c9McX5sImvGuVlP6jWrlfsauv2WNWNKjdF6wMI4LAaFW+thO7/BZifeDHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YsQ+JPcj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so1130438a12.1
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618323; x=1750223123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mxOFJlPwtubcbBJnoaf4HD8p45gKl4j7esdi+6PglE=;
        b=YsQ+JPcj87//OSvdqR1g6h1WS2D/8KQNFKyCgCfwSroE+WCawRrrrSNZfwuQdV/vyR
         Gxk3JX6OSOZLqcM9VSh247CGuEJRaJH2K/mR3f/8sUdfyOTR1d5V/jyL7NXq9hBv5dGq
         qEgx3CtHkYyG8QFlG77Cu8AncJ2k76jeAwFCIpb2pKQWKsVF16mmPu+BP/7Gb+fYLwE7
         /HBQtkp3idVUEieSLON+tbdoPL2aM+y+70OjdlZZTu7Vg41nK6uKdA7zDdyrfSLy9GMF
         Wm6HhEN7kbjPBDYs7SSzHXkiM0RKgXMkjMtz0IfQZPgTNye3jnvNwpG82lvhtasXlhfj
         Kppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618323; x=1750223123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mxOFJlPwtubcbBJnoaf4HD8p45gKl4j7esdi+6PglE=;
        b=i4eOApBxhRKoiA3ZhcoWdEr4/9Su9G5Xsr0Bqt5fbj3fO1/vXe17HvVhkKhLTsSPVj
         7kT9naFdadoOJ/VX6SS1zy46ekpBTjE2cRC2rjTdCUTscqr79NODBkCrnM68ubSt4y2r
         5yXcNu2NKSfFsGuTIFlWU6uocke89v/TtOfzrcFeplXoEN8RvNShzpZHxjA8QbN56Co3
         nCmQ+zc8SHKIwfOnjO+Pade58UGbJU0YUEqoz6e0xvOfU78dvdnAEhEg++p2ZPCxJtbU
         R6S2QDck7aP5OleD4dN2Af0wPchgfvlaLE2/cMS/vV/xJ1WfLlk8uk9rZOFOkaNUxxYP
         vPIw==
X-Gm-Message-State: AOJu0YxK9EQkcrMxfFORKTmlz1gezAW+mf9C8MIlvB5LmqiKMWP/mWyc
	owrniiq6FFfx3xnLY356U9Cx6cPejLXw8wh1IALIBFIeNQS8UnCLd5oR4hF1X3SGnI0UtJzXAk6
	5ryws
X-Gm-Gg: ASbGncslwTe7pUZFlnATc6RNWF6g67soc6/gtTBq7qyOlWOpS7HDDr7qExK8BhlecvK
	k4KOJo0ieM1miOmYtk5YMJ/xNhC4hi7wXf/08Z6qETdU+HoTgf+qvE6IKIaGcYwsP+0VTNY8Wvo
	1/ibt33+gsEiDFsFTf6WUoTef1dX+1DetkxN7gQlyrSncO38LPeDr/3LW4rIBjB3cfGIIDTh/6p
	SanbcwVdb3GawS2+/64c96ZHKxcoxSxUgxme1BVzhFGNI6161v7Y4i+Z31E4KYrcKGBbMdN6svX
	v069+IAHo+bCGMRbf7pSzAa6tgFcvP25vstNUNY4bZTWmRuZRJbToX1xvBiNPPaNw2TvXSePno3
	WQm8y0H0MGNLZAIzh
X-Google-Smtp-Source: AGHT+IH+FAKh/sBhOt/WFC8jsEtjCvgy9FzWlby8ZtJMJ/Gc2dlJeV0ovuuhdufVnNt9M5y29+UVYw==
X-Received: by 2002:a05:6402:5106:b0:608:199e:df25 with SMTP id 4fb4d7f45d1cf-60844e69ed6mr1596680a12.2.1749618323411;
        Tue, 10 Jun 2025 22:05:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c04f9sm6961577a12.52.2025.06.10.22.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Wed, 11 Jun 2025 08:05:16 +0300
Message-ID: <20250611050517.582880-4-claudiu.beznea.uj@bp.renesas.com>
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
index c25cda67d488..21f892d68f3f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -167,6 +167,7 @@ static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
 static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3283,7 +3284,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
-				      struct sci_port *sciport)
+				      struct sci_port *sciport,
+				      struct resource *sci_res)
 {
 	int ret;
 
@@ -3330,6 +3332,14 @@ static int sci_probe_single(struct platform_device *dev,
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
 
@@ -3388,7 +3398,7 @@ static int sci_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev_id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp, res);
 	if (ret)
 		return ret;
 
@@ -3471,6 +3481,22 @@ sh_early_platform_init_buffer("earlyprintk", &sci_driver,
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
@@ -3490,6 +3516,8 @@ static int __init early_console_setup(struct earlycon_device *device,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
+	device->con->exit = early_console_exit;
+
 	return 0;
 }
 static int __init sci_early_console_setup(struct earlycon_device *device,
-- 
2.43.0


