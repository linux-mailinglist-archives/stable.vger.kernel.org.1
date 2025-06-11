Return-Path: <stable+bounces-152387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F4AD4A33
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E783A5AB1
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371C2253AE;
	Wed, 11 Jun 2025 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="F3DA0mLd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54F220F33
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618325; cv=none; b=W1IkJZeGu2dxRM9KlHpdz8KzqYsL/85LY8wMBfXZ2JKayfSoZB4gP6pIKaMn6PvmQ0KfRDwA8pUNP5uzC+TXBNVQSglfk9IOj1VU6OMGXuT2idhyp8os8dMlfEmC6y3TPTDifhzJbnnetkz+Xgp2GLxvQf6QtvbORuKWB7hQzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618325; c=relaxed/simple;
	bh=vSqiTsiniILXsKCN/SsSMSOlu6ZVatrLC9yV/EgeOW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjWz/zBTAMmrk3wbTAku94eyjjB070f9ECQN8RsP2r5la2nHIUZG9ZTnnydlzfjYP/G598hs7xnH0Otd+4oeZnv1bQiPARymiZaQ3vL6FFrfWqXuq8SMxpByDuKp6GYMp1cZsELWmdawFZRmPburJbBW3Bp4Kg9DhrKY85x1TG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=F3DA0mLd; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so11818294a12.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618322; x=1750223122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F85CjjgOSLM4wGDJlk2PW5gEQXnK5tzJNiewb7Kv3k=;
        b=F3DA0mLdsFhm9EUHuuGnJbI3cRgwS72pzr5xbyINONp4qhoxCDFFkBsHUDyLYijlKa
         YyRJNb3TV21UxqWi9VNLStdU0uPZ84OE19XXV6GsYHDbH8QZl8BMNUEBxHKRKkOWI71U
         JLdDDbgKnUgtDyD6PCuHhsoXMCcV6gWJ94pibBAqXVrtMfk1jqL+fei8vWGNxXRJ1j17
         rTT5SvTWxeAlFlfP0HMKespSM34wAQxAqBUqrOOro8D+GiHOk/R8uVJEPKomwOdjwNG+
         XeeL9i6euocsMBv/gVZyzYT0+18XyJ4iqi2zAB4SX/NFu4UU38KNelONq9CuoEP8+Tn1
         unzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618322; x=1750223122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F85CjjgOSLM4wGDJlk2PW5gEQXnK5tzJNiewb7Kv3k=;
        b=T0Oz4OHQ1fCG0BD0aTU+MAl93frpFOX+NOuRkwoTC2oyShtYj0+DZUl2nTuZGIkurE
         nQgwo+3f+z+tsxpXV6S/XCWo9OKZjuxCecbW0d0bS+3o7fGAFk0rkve1tlw1BTHtO/w3
         qU9PL+BeWPA5mPq3J2lKN0wTzaE3qEi136OX+5RI/k4Mu8ATFGGb342DKOHs0yoM8iQ2
         L/aOH1MFBNRsvKBN0/2Wt9EpH0MVsI3ZtUeO8YQrh43k/VcncD0wO3b7205GEt53cxoT
         gQsdsXn7u86o32E8/R/m7CyQjnFNC85CX4IrtVLuJLOhcFWq79lcgrXgEuY+5nOCj9Ft
         xsdg==
X-Gm-Message-State: AOJu0YzXhbd/QepW8gCzUjZ7+Ans5Lu7YmJx594gQMU3OoF7DGHWufz9
	0sPc52PPAvQjvhhyYjCp4cIDe5T40tFR6ByKK40xZ3o7EkVbpatR1KEoW1Uj59S0aRTCBGXGuoI
	FisOv
X-Gm-Gg: ASbGncvnmjbvI/DvgeeubglahE3qB/eVlmSrCp/RvTq2MJG9fHj0GGQCfpVvMJY7MiS
	WfV7vNWEnYvG9K8ClNKXiOwRCkrAJbS+Pk+NpftiMxdVgAAanLA1IK2jzWyEaboTsFNDQzQ+JZW
	G6LTpCHXcEE2lX7Pj8NOGzB6razyT8p1vi1hxWXw2nmvfwGKPgLv1G6vixMxk6AYkSL4ZD+nQHt
	LTZN50Gsz3gpnXky5sSu/Cw3/REL5hxlyqywUbXZC5W0nDAUgvNylb9i6QIWAagt5RFjKksz+eW
	S+Fp7niYeSN7gmiHGZRV07seHhgEZU7A3N3L4b0w+IOSINAVAlwVaNaGIAJwBu7hcheF8oG+lci
	7aUnmby30f3GrYmao
X-Google-Smtp-Source: AGHT+IF4NJ6IdHKQ+PTfN7XcUFq0/MLPCuCf8bJX4NNRoI4OSEVCy2bM+cUIhj91WpYI4VQijK21XQ==
X-Received: by 2002:a05:6402:13d5:b0:607:323e:8071 with SMTP id 4fb4d7f45d1cf-6084e6c212dmr1065152a12.14.1749618321868;
        Tue, 10 Jun 2025 22:05:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783c04f9sm6961577a12.52.2025.06.10.22.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:05:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 08:05:15 +0300
Message-ID: <20250611050517.582880-3-claudiu.beznea.uj@bp.renesas.com>
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
index 4e00dad52593..c25cda67d488 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2965,10 +2965,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -2998,11 +2994,6 @@ static int sci_init_single(struct platform_device *dev,
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
@@ -3160,8 +3151,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3323,6 +3312,11 @@ static int sci_probe_single(struct platform_device *dev,
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
@@ -3336,13 +3330,7 @@ static int sci_probe_single(struct platform_device *dev,
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


