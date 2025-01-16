Return-Path: <stable+bounces-109307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26286A1419F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 19:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F496167B49
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973C2309BA;
	Thu, 16 Jan 2025 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AwsU5Vk6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50322F3A0
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051789; cv=none; b=KB9CVqYtf0hTSKyw33VBxDRIF1cAf17NVs6nA+WIxEhYvyvXLg9A+i8DHfCTqJ1WM+bX8q2ZVkbO/58do+rxoawa35cG4Fi29fYM86rw+P/T+ap15dYxPbk8ZJ9067EzbZQM1nzebqS+ZGkcYsT5nlQOo5uJqNTjEJJ5ZkiCPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051789; c=relaxed/simple;
	bh=HlBz3gfd8OIUkMQUN/g2FCl5sNFUwPtUBGa8hY7PvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCAPKZL1qTiRJ+Tw458WVz7m3X5bFWpPAFuP/Luqh0WrhH6OOYsOFlSUzqPX6t00LMGKu+rUgoUNq8ySuD+gz/XK2fS//CCtycXR9uIYkeHwGkTQ1tJHUuNuS8E5kK191E5roxCR7YC70GO4DHETjbJQ0z5JpyZKu0az4BYnn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AwsU5Vk6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso8135945e9.3
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737051786; x=1737656586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F2SV8L8hT5i2mZ7qR6sl3DjzHF148Q2UE5FnnQt0fU=;
        b=AwsU5Vk6ZcMYDRyx0o3j13MdtxG8nzDn3SRMAYezKgNB8Ndmf+YWlJb3MNW3Ws0edb
         FZTPW9rXXTGZCylDWiNOOHW0daxLTHjSWlDcOJDWHXLpyFrVoSVcwgTgjV708+SrIBKh
         JB3DxTDukhdI5tgLrEXwV3JXdNas7+xOyuce3IInAxyTrX2KLexxH03f6NA8s+oNY/V7
         1EY5ym4Yy5BLlI9YobLmfXOK8P3RYTrpK9KNoF8loKETUj+m1KRjGqYjNVc2MVRvWbFv
         QlPEAVY4LEiSXee/ch6si62+MomUKdRajAWSDzdt+ne0qFAxpZFZfc0xmpvaS1t1h0At
         wfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737051786; x=1737656586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F2SV8L8hT5i2mZ7qR6sl3DjzHF148Q2UE5FnnQt0fU=;
        b=Z74QB3J60vbilA8/Ix+BKlsbO/54G+qwcVVsTTpZ2iScBVD2NNc9/f1UIXFG5Gsgng
         tBXav1V+HD+mv3CWnZigth4jYaloYA5YbfHjL7l/EFZG1dZ5+WvOYiBeC1CPPUDvoHPd
         AbDuekbeIVz2th9HPefFFFyspo+puMR2HGXswdsK2fKIHPR3eIjs7Eeo0c5B+LL823v1
         ztWhWrbhSC5fMzmP8EPAIK6pbVSiC0M1w7k0L4vlmlMuaWEpKkLggwrpMj1Y1cednd75
         IbUIew2NTEZB6Kjn1HQZUsrPW9MvleOWN/5JmI5YxYzUGW5TLMIWPev6UyMg4hCcG0Tc
         4xhw==
X-Forwarded-Encrypted: i=1; AJvYcCX+bveNb7lkPQrkT88RckvIAacpyeC/cByewd/MLlgdK2LQfoGwaTzShrwbD+PMmshmqJjqgYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iFW1iVOGcThhSkx7jshIsLdGqPnepnN5uQ5uEkigdPTm0KQM
	bo86886m/niLhOuvqxiJq7XUXP8sJbDXSIRs0wU9gZL3LdYWJDRVUxkGjZoYZ0M=
X-Gm-Gg: ASbGncsaE6pVms1uDRLB5eqJipA8aukDuWAH/QMYx/AXvYiQfg94vJJPiJU3DCU6ZKZ
	BU4NBw3qgdZi8ICKqK2DsMCWVHjs6VW1C7cThg7ObXGXzbUkdzQjQnfIJ2HoTS0bNZmpkWvckpw
	CeKUyLSn/S/xSWKCJiOoca68lD2iAoF/zo6Y3fnAsosHcaFBk4IvcVYUOY/VPbyrf2LYhL9/opz
	UqhkkAjxCr4Cj/3kl0EJ9qCTKVhZUcQxxTJQfXTP7zzZNjUpAzm7RXVnPhlrQ/8T0S3UPvSBHUM
	JvMdNu6hiu0=
X-Google-Smtp-Source: AGHT+IF1lBnApPaY87jL/VxiBnx84a/2Bv8/0Zi1V9RrOKuTmAxotcGlNP4QNTccsMRyPKvgBF/Ftw==
X-Received: by 2002:a05:600c:4586:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-436e26f041bmr286561865e9.23.1737051785759;
        Thu, 16 Jan 2025 10:23:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm495942f8f.48.2025.01.16.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 10:23:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] serial: sh-sci: Do not probe the serial port if its slot in sci_ports[] is in use
Date: Thu, 16 Jan 2025 20:22:47 +0200
Message-ID: <20250116182249.3828577-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250116182249.3828577-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In the sh-sci driver, sci_ports[0] is used by earlycon. If the earlycon is
still active when sci_probe() is called and the new serial port is supposed
to map to sci_ports[0], return -EBUSY to prevent breaking the earlycon.

This situation should occurs in debug scenarios, and users should be
aware of the potential conflict.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Chances since RFT:
- converted the earlycon member of struct sci_port to a local variable
- added sp == &sci_ports[0] check in sci_probe() to be sure the code
  is checking against the sci_port used as earlycon
- changed res->start != sp->port.mapbase condition to
  sp->port.mapbase != res->start to use the same pattern as used in
  patch 4/5

 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 51382e354a2d..b85a9d425f7e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -165,6 +165,7 @@ struct sci_port {
 static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
+static bool sci_uart_earlycon;
 
 static inline struct sci_port *
 to_sci_port(struct uart_port *uart)
@@ -3438,6 +3439,7 @@ static int sci_probe_single(struct platform_device *dev,
 static int sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p;
+	struct resource *res;
 	struct sci_port *sp;
 	unsigned int dev_id;
 	int ret;
@@ -3467,6 +3469,26 @@ static int sci_probe(struct platform_device *dev)
 	}
 
 	sp = &sci_ports[dev_id];
+
+	/*
+	 * In case:
+	 * - the probed port alias is zero (as the one used by earlycon), and
+	 * - the earlycon is still active (e.g., "earlycon keep_bootcon" in
+	 *   bootargs)
+	 *
+	 * defer the probe of this serial. This is a debug scenario and the user
+	 * must be aware of it.
+	 *
+	 * Except when the probed port is the same as the earlycon port.
+	 */
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (sci_uart_earlycon && sp == &sci_ports[0] && sp->port.mapbase != res->start)
+		return dev_err_probe(&dev->dev, -EBUSY, "sci_port[0] is used by earlycon!\n");
+
 	platform_set_drvdata(dev, sp);
 
 	ret = sci_probe_single(dev, dev_id, p, sp);
@@ -3563,6 +3585,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_uart_earlycon = true;
 	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
 	sci_serial_out(&sci_ports[0].port, SCSCR,
 		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
-- 
2.43.0


