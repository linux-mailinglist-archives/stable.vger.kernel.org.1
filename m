Return-Path: <stable+bounces-98314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DD9E3F12
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA9160FB3
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1121766A;
	Wed,  4 Dec 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="PUWJhPhh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88D217647
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327907; cv=none; b=kAUeaGYNxtZol8Ho7mcimQyzhLARx5eO9LpGDIAT0CqDnbRBqwT6TKPvCHkuKqrCtsFT1khBNbZQ8hon/7FZAwl65q8FQ1K2rFjAza1KtdY0llAFvt4YQlnPOW1YzfNq8euciOri0DihsfdknYmRLYkl+49th1ONeSbXMdSSp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327907; c=relaxed/simple;
	bh=fnmIuQ3AC6S2Pd91eCPrbiQeWsPvWcflJGps7V3hZSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1H9HtO1aXIglsg0zX34R7GvNdA7fcRZ4dpPgjVmvV34vOxIVmTjzRhrdmnq8W+LzBWYv/3n/bNhAoqR/ojRYtcbQDaE2OsC/cfV4davkskuTEAbAT6FfYxgK60rm5dBmA5vMwabn2CYJ0qSxx37thso2Kr/1XBj9BXdLWFwv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=PUWJhPhh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434ab114753so59034635e9.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327904; x=1733932704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIgexULd80z2MjCqhWRkmxhXY4y89/FFLZbXUxSS9MA=;
        b=PUWJhPhhST9iGelcZq0AP77BmiT5SOZDHhxomGLaPic/OLfvRo7VXUhagBoc8a2QWF
         XprvNiAYIrw1Zrj5uot8RTazjOpdjooSYC3On9Yl8deLKNe9XAub86opHhhiQkghuqgL
         0IjG66vWcopFmIPVdKkkW88TQDpSM4yavW6ruQiSzme1LkeTHvJJ1S1rVd8dBinZ+lhQ
         aK1QY+3HduznV8cTtJOaWY2dRICsllcaedwSbleTYPWLZwRv5uKQV9YnFcJRqs2GqzF4
         2mS5nzHtpYJnLwqqq6eDcEr9rREaybS6nBRZj9kSZDylXDBh7vDOBgYycbBkRP/3Nf8L
         NKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327904; x=1733932704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIgexULd80z2MjCqhWRkmxhXY4y89/FFLZbXUxSS9MA=;
        b=NnDhyQuOHFeJDIk6Jq7X9ZkDM1YSX9QK65MJWrd8gwFHF1Zjn/nrnGHNTjJFibh2Yz
         /tGpdLl7lwGKe+YSgwgXLD5RlSGt2+6kTAGRiOzSH84Adbg2Sgkf8lCS7lHxjdBSB1D9
         ZFv17CUEMw2gcz1gqMkfB767TCZugfDYWHpVtr32t5VwQqHME4Rq1Ig+UndYiFCDOWQ1
         zgjn7knLQFtuJIOWW2Xt1yBKQnDakkInRpruMeifSCh+IDF7s4EKTjLEZsTHa90Q/D/1
         3OOXt8vH3GEcPi5pCYf6VeJG7HhEA+h5EmO2Y/LgNXjbITFVtBN6ZhVZuU0Ky/Mz4UvW
         6Dfg==
X-Forwarded-Encrypted: i=1; AJvYcCWxSbY1+2EWiWsxE38DkcSqhF3kHf3AkLEfKN2OPtb1ikWLyhih+ixTuzw7l3/A7QUppDfKYOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeRoCHxvUAtX4+G494t9CwmhOHFPWCd4PdcN8dcEHmgHwj+qr
	+taaQpDq/jH9YLb6ruBAYaaadswdN5D50ZrsCrkWclNA7zxc5QSI+sfzgKSHLcA=
X-Gm-Gg: ASbGncvM4u2AMHy7GUvJfDjsXsWQ8tgwuGKRAvTw9c/+D5pMCB0+3cANYefdDOfx5et
	Tceq9P/hr9wJ6AHmSjyCqVH3k6NjwH9A+5TFHxrEYzLzX5wz/23EiRhS0oKdHWMxh277Fv8lPZa
	/O7qvysowjnXmEZbUVV+jOJmQaskWIDCdjAMd3r3uYczItLql0Oo9b5rb7JjP1KDATON4nK6PuE
	yNn62XUgeB3zPygapDSM8qJ+gK4AxyD6kkMA+Cuo88v/hSe305M+579ap7Gin/4WXcabEOXyCsj
	2ujD
X-Google-Smtp-Source: AGHT+IFbwxrksVk/MTeFkTAjIssqvXFYbv9NCxbCkjPtRUqUluTZ9LIe0N58I+leYtxliC1iMWLK8g==
X-Received: by 2002:a05:600c:46cd:b0:434:882c:f746 with SMTP id 5b1f17b1804b1-434d09c8e42mr68216715e9.17.1733327904095;
        Wed, 04 Dec 2024 07:58:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 6/6] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed,  4 Dec 2024 17:58:06 +0200
Message-Id: <20241204155806.3781200-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
	  device_add() ->
	    bus_probe_device() ->
	      device_initial_probe() ->
	        __device_attach() ->
		  // ...
		  if (dev->p->dead) {
		    // ...
		  } else if (dev->driver) {
		    // ...
		  } else {
		    // ...
		    pm_request_idle(dev);
		    // ...
		  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f74eb68774ca..6acdc8588d2d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3435,7 +3435,24 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
+	/*
+	 * In case:
+	 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+	 * - it now maps to an alias other than zero and
+	 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+	 *   available in bootargs)
+	 *
+	 * we need to avoid disabling clocks and PM domains through the runtime
+	 * PM APIs called in __device_attach(). For this, increment the runtime
+	 * PM reference counter (the clocks and PM domains were already enabled
+	 * by the bootloader). Otherwise the earlycon may access the HW when it
+	 * has no clocks enabled leading to failures (infinite loop in
+	 * sci_poll_put_char()).
+	 */
+
 	if (sci_ports[0].earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup up the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
-- 
2.39.2


