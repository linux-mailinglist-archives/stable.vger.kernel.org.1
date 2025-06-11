Return-Path: <stable+bounces-152392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78506AD4A3C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AD917B25E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C021E097;
	Wed, 11 Jun 2025 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DKXMNd5h"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBA176FB0
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618360; cv=none; b=IO34yPZ7eAqG5So1DS6WbX2sW28d9/vy2aF1BbNjdNh/Ikd27IwZb7FrSj4tr8MvV8TXRjZHC0/aYDx9Zs5G5cnAVvY6W6PrzgiotSlQZS3p5U2H1OEJ73gg4wVsOB/PbbmAMvtsFMW/hnoQDwvjsHSJxnEbZwzUnL6J96nEVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618360; c=relaxed/simple;
	bh=+SEtkNYRhwQvrvPQ+eujaRXHmMfZQcqinIvrJt9JvK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3NDh0jXxgj9v2xHJXzdyVityZRC65kO1Z3E7xWWdnpDQACcBXH4qKUE7XlZZXDTdmpbsKOqFj4Qbs2c8/NOV1FFLNIJ/T7sXjAMOUidj1C0+gaOhYkryzSzMcQp9P0QNNP+mdFSuy3z2cH9QWdkL+dt3wWPmF+WyLNQUys7imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=DKXMNd5h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1159122666b.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618357; x=1750223157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04c7AB4TmufFrPz+74OrE8hlahhp4L7sltbHinpsVm8=;
        b=DKXMNd5hsaXjx+pUn/SX/rq1qEaRiyl9zcHLO0QCgnkpLInWCYpSG/HDpaFDGt9tJW
         DITcELizTamT/1FDtJEPQLhr6bdventV1FYrw5e7pwJf16iR8EiKAMTJOYmRmhY9/wXp
         Qsa+ky6+TrhaLARNe5CIt+5RZQQPUS4nhtCxABlob4wzljHhrS2lTyn2ABTn+SDwhmKN
         mdYSRoGROrxNcBPR5ybNru8EqXENhTMb2KIysdRrbyGv8PbGtrEfLrPM0JtYU9PHlKz+
         F5xLAOa6n8pHFNBOpoQR6A08dtz91GYRl54NNy7vPp/PbKnxT2Vz4qpWWKSRNgmeCjsi
         ebtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618357; x=1750223157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04c7AB4TmufFrPz+74OrE8hlahhp4L7sltbHinpsVm8=;
        b=aipcwU3Szvg8aN8ijb9IXUQuT/5sL0HHtZTrEY4oIC4h77ZBn7TeeLgnoWK8z3JV5b
         xcVYtl5HeZPJwbQlleo9cBoC++DZXi08vL9WKH0SuDD4hcwe6KHqFiMlzMLX/2pBq+Jb
         77CzjXdxAk5STQhqZKU0RZEFOFQX+142BpBnMajAiXhZF2Hf2N1G6vQ11pXvO4CJP9eO
         nkRemhfcm24cNn12iB0pc2QfFptsY39sTtOBphLCVj42I/daiX2ihojf5+vOw9uPElYu
         PlHDXM+EZi6rosg1Uo+TZAOY098ikGLgKycpBh1jeXa8wJCX+1+DwA4ndg7iyAR9waYA
         nxMQ==
X-Gm-Message-State: AOJu0YzYBKtQJEBEmHbS1RcuTN0W3e0S5juM7sOTw4cHr2AA6B/B8GSL
	vwqdpEQcZX4jT9HSOJpcIKGHclcKHGmhg276baGKaH2lBgZtftWna8jadbVW8IvfUQRqwD3nYQb
	cAg9H
X-Gm-Gg: ASbGncs0NsygV33xDODMQAaAocXtfXT0cWiT+wQBIY58FqP9YXD+sMqVaFqZxLwRWw9
	H9QIK1a5rN5JIg6mlqhkB8QGxB8L6p/zdDd94YjlyvzoAvSPuG5npMLw5giRNrCxpMqzNZLC/Ft
	e8cFiK30/GMSevOXsVd1TVDkDL6EXGkq6DAsCsHIXhFaMM1RvVUXd0PcMkbfW3Gs5lVeHd8vj+q
	28bj7lW727t7GqAG0fpPUAWi1W24qqvTklpIGj4UzjGxVH5+mkFFPfEmMGp+qhfFMa1qufey2Sm
	yAAjJkrRb3O/2jrPC0NlD9IMY/vfQCepnWbJEPtpf3zmwFMmC/GvkZAL7PNmY3RRmALsd6NVvWF
	Kss4ZCr2muvTpWow7
X-Google-Smtp-Source: AGHT+IEHv6lSSzMnvqaTvfdKGafDbYYVl81XP/Jwm7VBVl6QZ3ebCFfkBAJ4OwDYxWMAR7T5o0ekiw==
X-Received: by 2002:a17:906:f581:b0:ac6:f3f5:3aa5 with SMTP id a640c23a62f3a-ade8945d864mr181984866b.16.1749618356565;
        Tue, 10 Jun 2025 22:05:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade3c427cafsm675513866b.75.2025.06.10.22.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.6.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 08:05:50 +0300
Message-ID: <20250611050552.597806-3-claudiu.beznea.uj@bp.renesas.com>
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

commit 239f11209e5f282e16f5241b99256e25dd0614b6 upstream.

Relocate the runtime PM enable operation to sci_probe_single(). This change
prepares the codebase for upcoming fixes.

While at it, replace the existing logic with a direct call to
devm_pm_runtime_enable() and remove sci_cleanup_single(). The
devm_pm_runtime_enable() function automatically handles disabling runtime
PM during driver removal.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bf77bf8f5a26..a76c2d0669d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3026,10 +3026,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3059,11 +3055,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3233,8 +3224,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3396,6 +3385,11 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->port.dev = &dev->dev;
+	ret = devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3409,13 +3403,7 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
-	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-	if (ret) {
-		sci_cleanup_single(sciport);
-		return ret;
-	}
-
-	return 0;
+	return uart_add_one_port(&sci_uart_driver, &sciport->port);
 }
 
 static int sci_probe(struct platform_device *dev)
-- 
2.43.0


