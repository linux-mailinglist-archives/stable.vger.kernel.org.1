Return-Path: <stable+bounces-152377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD516AD4A27
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7B43A5E38
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310202192F2;
	Wed, 11 Jun 2025 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UuwOgYuX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9314B945
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618061; cv=none; b=YTLP8aGamRcoTM3q92GaGFBfgSxfMZ0U8AEH5esxPm7KNxVR1JxSeZQ8fBC2hHiQ/hopno59Potx0FISre9DcVFTkugMaveuTMQS1W2zbiNaylqzlv7/OKEr1jAzhpy9FxIW7erm9io2ms8zNDqVambQDIKEUhwUVHihPNjWpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618061; c=relaxed/simple;
	bh=vldB5VMCnbJO89/JbrkJz2bRKjkrjJ5QFR7eqrX2DWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE0gJJZA8BzxV2K+/XCYU+Z2PY2Hyk/su/53WdkgsP9OA/28meneb0GBMHH/e7bEMiPhwReI37cAPMHjIfRfvrg0osf1HxZT0+es+fCk8VYA53ZqbAxwxBGmsTCpW37aonk7H/7anYk0txGz6O/vnTS8AGtqVqZ+HMLk7M6JFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UuwOgYuX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4530921461aso27252115e9.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618058; x=1750222858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xRb5esgybh/jNl2BOs78PawM39+rS6UD0SsIeC8ra8=;
        b=UuwOgYuX2gdd2W4myPenG57VgtLhAhc0fp16UJd/HnOis03X962Qv/lzUVmP6ZR9A5
         WDD5YFAMpqcs6KGcg900RQvC0jRHUJLSwRQKpRWYE9vZlkzIalLvI/kD9QB37fSmERHG
         MAxQvV2m71Gx42CsSpj6NIGmqPmQVDAHEiFtD2+JwNsSMpNo/fzJUW56akijtPqHNzUL
         6cV5QI9fe+1d1GV3EvLiqg1P3NLKxWy8UOZjLKzZ9tXrrcAz2owwCiedKtfTDfiFjXs5
         0lDwpNLbZkP9RC/1bj9KrtZVPTZUKe0mw1Hkg3rvETL39SSdjZGFZ2xhAAcqytyoJoRu
         +/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618058; x=1750222858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xRb5esgybh/jNl2BOs78PawM39+rS6UD0SsIeC8ra8=;
        b=B/DQLKeVNoEWkIByfB08+e6FuaUuaGOEg53d0Y5UDI2RFZ4S8UIbbctUZ6iCG2zLu4
         AfbcSm39dagCaprZw/owSMISy1UFQ6Kd0Gjg2S7dGbByDVm0rIDXr+c6xTYQAzniZcI1
         x1a8S0V7Hl4GfOF+pV3tAKGwjk2/p3xjmqkaxE04+HeWHpwrJj09MNfrfqJ94aBOrM1p
         +yjo3WIITULWm4Y7cMUUC8YzdLCItkzekC5Uu3Ine9dhh/JGy399+j/xPnIXorYPcO0S
         r+EMqBv/aftTJRPiERaNKcURgIcaqW84Bx9kyNosctWOGxsxR0/KHKFfGxBZevqm0qTk
         olBg==
X-Gm-Message-State: AOJu0Ywt53TG2HlWkmvSQlWPahd41iqpHHmDOKXX/HJuhO4cfXzkIUt+
	h0Jyi+4gxbxEZH8kjpFCjb4zB5Q90i/rZ6Dijed3nx+Kfw4dfct0qQIHSH2jnz6mdKwD1sgKtug
	2q0ms
X-Gm-Gg: ASbGncubLDJGKJ7ohp9EV5Vono8OkvTuH3sfvv4iUO7IDrFU2+xct3cWG4m2FTvTtIG
	n8FFp64JvB8Y5ksNs+TIl1WNqyDaMrtzXJI4AEe66a3ZqHvwZQO1CLd3xfA/pc1rziEn5m6qXkD
	CCfSpLUwL1SFxMl9Si02f9QwJerdsdDCYPild0g+aSvoVJjStsnJRlRRKmHE0rrGQMZ0+j6Rs3B
	ahxSgSpxSdU1LrsDJskQhdOlh6o7mpTgJqPUGKxDUwJX2YyJcDyb/cOJlh7/Lj7YZNiDNduu+6k
	tSmYYEpC45AAb3/zvaamcWQ1KZdK9gLMxwOduGOUlLxHwxHJEX/Zwl9cD8qLVWOQOa1G1ZcCrkK
	6tMhZrY4omzNdH8yF
X-Google-Smtp-Source: AGHT+IGwSxYJcvI+3d7yaU1Hx1ZB7tKv/NIg8eDztNSaajPrAvq0JAC3jiQc1Dmhw3HOtct3kGTaLg==
X-Received: by 2002:a05:600c:1d22:b0:453:b44:eb71 with SMTP id 5b1f17b1804b1-453248f9380mr11133405e9.19.1749618057778;
        Tue, 10 Jun 2025 22:00:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm14252044f8f.99.2025.06.10.22.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:00:57 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH RESEND 5.10.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 08:00:51 +0300
Message-ID: <20250611050053.454338-3-claudiu.beznea.uj@bp.renesas.com>
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
index f598135ea75c..4ce6dd7c4092 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3021,10 +3021,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3054,11 +3050,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, int ch)
@@ -3216,8 +3207,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3348,6 +3337,11 @@ static int sci_probe_single(struct platform_device *dev,
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
@@ -3361,13 +3355,7 @@ static int sci_probe_single(struct platform_device *dev,
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


