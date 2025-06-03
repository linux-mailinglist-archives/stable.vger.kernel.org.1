Return-Path: <stable+bounces-150675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE660ACC33E
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E14168233
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6340281370;
	Tue,  3 Jun 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KE3dSQyt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA03281524
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943429; cv=none; b=oTbb4fAQ4O0kYePF+/XolhPJUrvS+yd5S+KJA3bc8EdVZOP6EBULrpXPed9hogTtBz3yVnWyjbiUyCvEqz3mE9uVpDot+R+PBVlmrPU1SmRXLmlW6+XMko1LQ0tp+RndHhXrn2S5Dt3Oq02TiN2vEqxFVGBwq9jKuv3krPTizZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943429; c=relaxed/simple;
	bh=ilKopf8VuHJrDpJw5IbM7EopRBWleqE2gq9IvKzbgw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0UHw/72mRxG9+mJxnjjYQy2cGUSKg+aXEC4TVG34jFUFfCQUUG2UY+qykmjuj9GOMxc7Q3y/k5JG46dYRvutesXWH45zgEJAk7zlqz1O9IM1zpQNUju4RxOoC3ExU3g7E1xXXjmWDLTr+NE6PltFZB45/FeICFrXRS9DTKkESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KE3dSQyt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60410a9c6dcso147246a12.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748943426; x=1749548226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EuboCBDYKxaPwlVfvjIDUeiF0Et7Z59D4d4d8YOogg=;
        b=KE3dSQyty6jQ7ZIXR4Mb4aNb21qC91DO9L4OkaCtMR3LgJCpPMBHCAfYWLDsJGepF1
         EKs+J3zMrRYS9jmDKjPF0Qf606+2FXb3/rgrL+Cjap3F2sXcrlkU2Ivg5bHgckmowQBX
         ATmodFwq1f1MLnBLzCOV+A02XcwiIOysvxFCy+7CavTK0TsEhVU4gH86K5LAwjysn2WS
         ZfufKBtZsTqHDXnew8W4PoVYPxiVmW28X0WnxTKeCZW+LMdQICBQghpxxE6FA02eNBMN
         MY+1M6l21mUbSNjDNpOtGhrfbGy6E4zBxykhCH11Hrv3rSfhXn2fLtGwnJwQc+ToBSHf
         cV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943426; x=1749548226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EuboCBDYKxaPwlVfvjIDUeiF0Et7Z59D4d4d8YOogg=;
        b=aabRoyk7BXcpNRppBt5H1HIZ1wmL/YxOb5Fcragh/qw3D5AJ1B9A5kKCXD/7aGONGk
         b3i5y5QnvokHYQacIwmXIbNcW8yv5nOt8lRarvn8VOzN90Dm45idobGzVGEFDwnF4Z1Y
         HMXWlJtscvVHWeV7MPh77fcvigVDKVtUwOX6dn3TlBXZsCNRye9zZvR+tRFnJvDOazBH
         GDh0eWJoYiGW5yUU136CeqTUNNLBwUEYebGkGSIc6MwnYB3E4SWANDAFjPk4a/jcGOgt
         1CKqHJtwx8ed6cEWrPkouBfsZjY/S38DzdATyMUt8w/031a0MuLhljIGSfA5wfVo8Ier
         0XHw==
X-Gm-Message-State: AOJu0Yz5b5DO8lEmYb7al9EE0/tpt15kt64W/PD+iecfs3LDQyLWD+CT
	yX0J5JGe4XMm8NMcgE+dQ8rsw+YNNMHvASpSQ6f4aAIEGa4kbnTFokqGGjqGV05yWs3BukcRIQ0
	DzUMi
X-Gm-Gg: ASbGncuu/Sm7zmgjpFt3aELCcIT9SjcsJ0FhLHcOKNA9aNAs14u8NSiNRFAkNOc1eWb
	7OSXV1XGemui6lOde+28hys4oOXJ8Oycu0PKi7TSg67zPxYWUKRNaookgOsxYG6YNVXQRB2yOTN
	oZwGlnXJRKcDaz2B0aWkp+SvppihTYXm2HMcTVPobajedJq2omwRUg0PWJ7wNdtmqFbr6697TNx
	srWMO4U0DbjNo0HD5bD+PrNu1vuBY8xKYvAccvdbYwCwU5PdCdz9FhIdEUlBUwssWuGwtIbZSux
	IJHy0gIpg9/yIiYCEPfpred7/Lc7wc2SICk7z5eOZlrbMl7Orh41iNsejM0CSUGZzBDQYdvjbo5
	DQdd2pw==
X-Google-Smtp-Source: AGHT+IEAtiIz8rcAoZMpoGdR2H/LGNVLyBj81jKIYzA5AdKmr5FttL7MstqQl50PmvctIvueMscwdQ==
X-Received: by 2002:a05:6402:d0b:b0:602:ddbe:480f with SMTP id 4fb4d7f45d1cf-6056db33e7cmr12984382a12.9.1748943425820;
        Tue, 03 Jun 2025 02:37:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606af7bafedsm779334a12.57.2025.06.03.02.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:37:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Tue,  3 Jun 2025 12:37:00 +0300
Message-ID: <20250603093701.3928327-4-claudiu.beznea.uj@bp.renesas.com>
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
index 478fa745ad99..000a920727b3 100644
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


