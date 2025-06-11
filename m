Return-Path: <stable+bounces-152382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151DAD4A2C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CED3A5ED8
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFB2045B5;
	Wed, 11 Jun 2025 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VvKpR7Ht"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7508F5B
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618100; cv=none; b=fXv0l7syI3xRaXrwAJdRVLGjP2A33ublXwV2ibRoLJFgMl1o1ddlaaRwn5F1NBhwFMc4s7vTk13XK172l97iOuPtUVGeM7kME/BaVODAMt8iDBPhjgf+3ZEH5OgdgWrLW4SiWILmZqDucpYdXLtVaztQUgI3XQR9yDF1BgkwR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618100; c=relaxed/simple;
	bh=hnWy3yz5gP6lnYVuF2b4uIQRZpcFwzL5zNhJCLg23Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh2onVCrtjuZ4OrifTFYV8EdD5+o9Idnur4URgYrdvqEgfA/x+u7AUROh3nQcCLpGwwSREufpJ6K3qgf5WC6UaNkfhpXIdNE6XWTRgyJ9CCWAyBtp+2r1qI5xJIMvpaxHrFnPB3FxoGSdcgoBnxI6C4KI7B7kBou36WUaemhRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VvKpR7Ht; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2810290f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618095; x=1750222895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IreRF78xMFZAGTlIwffaXcDkSJjB/6St10rhXTSRCxs=;
        b=VvKpR7Ht8iJy0LlZJQdxR4j4w02RMMmrirx7XOTUmnn3QAIB705+mG0uNF5diiTM8V
         RKvYspfi8hhJiiPGBmW0zOw6dvP2aYgyL0WfkkHi1/pNAXeERxRPFRkm+PKbeVXlo6s2
         VlkhkkSSdF+ZO3fwYLjteZPqu/Jty7z+YF8jsFpGGIqTD2Pz7APWWSHchnDUTEAk5i6z
         OmAkj54h62NjI7Olu24LIiCYr5dhup0a2SIjNMvtFFp6aAkC9mfmzXlDkcfkRCTcWqAA
         zma6Dltc78J3h65WJ9r0tt7kJV5cObWA2Kl08jeN/Zqg8QOJLiVyKHr8llSDavEcTUL4
         J5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618095; x=1750222895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IreRF78xMFZAGTlIwffaXcDkSJjB/6St10rhXTSRCxs=;
        b=OWuTo89LfUdQklk1hHbMg5tR/PY2RapV8YRKwpdDsxcS+GpGIAa0qo6a0MXyVOPV7a
         AoZlWqm35qPyeSVFtjSfEgg1fnQG0jYBr5ie5hn6oJgYISy1RByJJkCXZPCAj7MQCKHo
         bS3w7PLQ3R9BrzuJlytJ+emTLOEi7wFR52++RMMvs9IAeeHMkDN5j0mHNP5n/sDtVjrk
         lJfv8AjP7ZZ71hBOypzxnr+PP+55IN8qgcZtMMRVGzI3PUBan3irX3vA9HMGYxvLPNGK
         +2uCTVnTRe0gngHYmb2n2eifX0fcrKme2Iop1JI3+eMUr1b+naFoyo7zZEneN/4ZcY4R
         UwhA==
X-Gm-Message-State: AOJu0YzRD16y9BfBnYxFCmWvCx9vkgOmc5NMchUa32nm96TPybt95Rc3
	VrkfZdLlUMk5Nlnh0FigfafrO/0fr91nN1zJwQY1rukuqo2H7PRzO7xLG8Uipb7IoaejT4o/KCu
	LfxU7
X-Gm-Gg: ASbGnctm4VEeiH59agtg9Hs5qVvhMphKSjsb4d6NUN0IKPp6O4LQRjndKFP5B6DfimI
	zs1EHGQMOfVirGCdcEmDRdRqPPlhlAIzKRNBMUoGkveVXuqqZQmgtCTv9EzJ1O/kIiKkz6Ra5mt
	wduFAstahgJM0wlTYkVJEcwnY8ADGVUUfwKrPlrsoLCx1GGSk9D7prorHmZfqk0FYoCfes7x562
	IGSP5SZ3yQ8PoalVJhwDCZHA8vJUVOd/lArGmJTrddqVjZLSOZTymZW73Yngth1XQcFXlGnFzsf
	zSbRq81CkpG4N7t8097X7YhNzts8uV4/rlGeSrBhiht2kJ+hWdvFHFM4213H9YcD0rV2mIRGmNx
	83budRSoZX1Cyd6HiRN7vW8oaipo=
X-Google-Smtp-Source: AGHT+IGw7+ZNz6/bY2rDnn6zuhpc2fqdzXgJzUisDa1Hj/Y+fteDbMGGk98+FFafQ6dPTdvmqBnQcw==
X-Received: by 2002:a5d:5f89:0:b0:3a5:5270:c38f with SMTP id ffacd0b85a97d-3a5586748d6mr1071075f8f.0.1749618095371;
        Tue, 10 Jun 2025 22:01:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm13885875f8f.100.2025.06.10.22.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:01:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed, 11 Jun 2025 08:01:29 +0300
Message-ID: <20250611050131.471315-3-claudiu.beznea.uj@bp.renesas.com>
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
index a276efa10319..a24fcd702f6c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2993,10 +2993,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3026,11 +3022,6 @@ static int sci_init_single(struct platform_device *dev,
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
@@ -3188,8 +3179,6 @@ static int sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3324,6 +3313,11 @@ static int sci_probe_single(struct platform_device *dev,
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
@@ -3337,13 +3331,7 @@ static int sci_probe_single(struct platform_device *dev,
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


