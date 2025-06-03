Return-Path: <stable+bounces-150674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF46ACC33D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F9168504
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF528150E;
	Tue,  3 Jun 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lz2IP11p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543E28151A
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943428; cv=none; b=b8mofWFlUAfIvnVlntjEeK5r55BUwOjKe7J9xsrCQIHAt4enrz9h2tlPePn+mcCENyUr38B03Wy25QHt0ZbWq9/k9xCFJaWBKtNJ4wO+qg4RpLeXNcrFRFy0m18Tjgc0QzPU9kcU8hfkCNkXce1MeiB+zXpD34ngf14Dx5NyPO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943428; c=relaxed/simple;
	bh=sLouZb+/6MjH2ff5LFT6JbBIXLmZ+gosMi8EGDNWdfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjVTdJx18AEI7G3v1gYF7GnyO6OrcOlGZ1hWFZK7rq0Y43N6pmDThUP+SWMKGl07JzixChkMZuj1cDu2cMuCTFnUXtff5CGx8Dz6krDUOof5K+mQIaKIMkIXaItutVmciee1o9KRxS+5+YWVTpbLXqRXk5hP4GPB34Q3s9J0Pss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lz2IP11p; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606a4af1869so1347281a12.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748943425; x=1749548225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4DSwYU7fK5pN05qEJk409p/2DSKppvJDG0aeltLMHM=;
        b=Lz2IP11pJrA4m/uIryf3+7+T2Eyknp/LtdwBTW7U0cgUFAgQL1VU5MbKRitGhPbmMz
         D7p+6+yhD5Ag6hhhFdNT5nWOBdyKy5XtRsPcNBh/27B1foKjAL/PRICYcpC4RqoEmXxu
         fWk8sm1Arb5omNoVKleNr+0mLOsrCKuNOZF8X1hs+HSkirGWUIQDF4O1up86RxcxbA3j
         XGi6zyfw+Au15UoDtDv5IS+gbpjHcXH3Ffm1fEhgBLrGSyt2tpzgdq25DJrX2Bn3nLAH
         grK9eG63FzfVesxrwIgkRDwKn0NA6LybKN1eG6pVNf9ooaFKjsBschk5SzghdEKm61Cb
         tXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943425; x=1749548225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4DSwYU7fK5pN05qEJk409p/2DSKppvJDG0aeltLMHM=;
        b=KRJVdsJwfN89MkDGqPI2K0uIzT4epJsjdilVbQ82vufVqoEvFoTWPGUGVA8b5LHXd3
         HY6vt38jxqQnpnegnpzQp4NQDDVE1VuZkO2mVurd9o7jxlwyXQ5hjskPIkwTnYBAjq7H
         C86vjJDatl+bVrlFxBJmsGeT61R7gEiee48pHKZHrYUZO8brKzuj7IKQRgCLknFmMfBI
         brnP36NQ4yPMqKuYgNO6sugUbSj6SIgnqqS/2tVT11Wfu8k3hQyhyOIF46jFCycr5h9u
         d4NzK79803Djo9tXvRjngqOIQM+0sDyTQlUcC3VxFFMRCL5u94HRtRtEnxSewk/9zma4
         9R/g==
X-Gm-Message-State: AOJu0Yz3/5Lp8Bk8j6h8nynUSKV49dgvZp4EQS82+JuQeNc74QtAlvxn
	WzXVOIpYibSs6+m+3Ej01zPn2emK4jQuPqNSbTIaRrbVQklucg6IU5UEHlPtbP5Ie8TUC+KoOMH
	fKl4n
X-Gm-Gg: ASbGncvE/FoJUIVwnlCS3NEQIv5SxCflGDa/K0RcbvnpIUBu+rDOHeVVAnk0+XgrDi0
	8e1xObxxEl+DiLFkRclPpsrjKJoUGR6cXUn2P0TM8d9Rvt0Jgt33GMxzUvocnzjf/4Ke6PrM4+F
	KzFUjsuhnXjG9fWnt2xQpcp6nwvALzpnqQVvfazXUqPkY0bnZssgw3CEY9log+BINS3gVJcuyFl
	PNU2h3u0TfOkE7S7XhAKdVwBpSyYeOz5Y61SLFHOIviGPcKL3LKeZEX+j1YdGKF8sV4VId4MF5q
	QV2RYzS+10yMibwdwim9N07AYx7ac8RweCOteZOVvVOrp7bPqSSjo3wh9foXUWmG4xYSJgoQdS5
	DJMcC3Q==
X-Google-Smtp-Source: AGHT+IHRVDpTEiGThA0iRKONiZA/sN4oZUvIitXjbt/ctOwhnto34BTGPwKcfbkUc3ijqwI+XqIEVg==
X-Received: by 2002:a05:6402:555:b0:606:a653:ed38 with SMTP id 4fb4d7f45d1cf-606a653f179mr2025347a12.25.1748943424802;
        Tue, 03 Jun 2025 02:37:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606af7bafedsm779334a12.57.2025.06.03.02.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:37:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 2/4] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Tue,  3 Jun 2025 12:36:59 +0300
Message-ID: <20250603093701.3928327-3-claudiu.beznea.uj@bp.renesas.com>
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
index bdb156d4ac4d..478fa745ad99 100644
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


