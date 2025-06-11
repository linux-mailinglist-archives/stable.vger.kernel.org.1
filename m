Return-Path: <stable+bounces-152384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C672AD4A2E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5863D17A261
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65714B945;
	Wed, 11 Jun 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nSWuiACr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAB1E2858
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618101; cv=none; b=LJw3nuRW1272QVBdy4vmJfZ0lPrZSH0E9zik2/IwMjzFk5E1NKUGyksfCO5EzJjDZEX6n64JIz2mk+vVYoEmxRqvpdYVZF/SdaK5Ou3qsB7+qwUTT7LM0gAD7zwZZFZ69nT46oPEzLtBkDxsaTI2V1Z721a2JQpsX0lJus746+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618101; c=relaxed/simple;
	bh=10XBjr+FpKrP+FfZookakV9SGYz1HqKG6jSaOFysTmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCaHJCXJMyfCC+45J3dkJGfWVNKgfRhCp3SagmRCF2mn0qsVjnl6DZuacWzRagspXWr938dNJ+1gA1xia2RFyTR77yh0m+nYnY5N7jIiSjKc25y27dRePkEeskinmpfzayrDXfUF833WbsSuhFP707pLAs21kubwLZ6ihiL6bWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nSWuiACr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so36641625e9.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618098; x=1750222898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyixSVgZqrjnFsXmCDk/eO1iPau+z1A+NO2KdhjiOxI=;
        b=nSWuiACrk8j0hsp1PqyEowYPlrR7Pky/YHngyowpN00da9sCiV/O1T0LM7CRjH3oIQ
         O7q/AfaM/5edOXVeL/RjGHpxLSwM8W/dhPKfHsb9xEnh0QwcENi1U/uvtlUzBDYcBlez
         oco/PMLApFUgc+fhllm8W2EK+rfnO+Rbm8CbkS35+4Vmla4KgMoQ1K79qe99AOW02G3n
         3/X97cIP33H6ygBs+UgkUt8xB3IrxwCZMLim9YcMx4s+maqYxsfC992xyJF2i5cgU6uE
         BZs8ESYJOn7Htc6Y641rK9A3bwAF3YyE3G/K12dW/2bJkyCuQDgDq9vRkSHKtYccE78J
         uBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618098; x=1750222898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyixSVgZqrjnFsXmCDk/eO1iPau+z1A+NO2KdhjiOxI=;
        b=jQTMIGyrZCSwFyeLrKu2EhSuODhJEAyuHmRY5uFO7eCDsSoFl1QXLt996V0/XTB7cv
         tMbPhUITl8am9t/Qb6wD8UAuEniGa+0wHJA1b3Zp0SI+Nevfu3ITqQp2aOdwYBiQqj+W
         rhgb9SFiRZ2AYjblheeVWrljh7MSE8mv1XNzb+jLXOpCJxOKl1rnVzEmTL16TGOjUL/l
         +KxcPr8eoV6X+QVFZmsFJ3ON2ulNQOoV5EhvJyInBdREZjfpK+FPF6tY8j7gWpWBsTUO
         5eq35rU2dUYhBZQuu8oPEqNiS4SZbRyYA6Nl0/E2VS2Q4UPVJ2uG0i7+IyJ2ekB6jh4r
         sfzg==
X-Gm-Message-State: AOJu0YyVwfp8KO/2GH9ChAPG3vg+mYAnWOAOtliIBYhDh3B6ukiVd6wp
	qHSNqhlIHdmhiZJmzd2M1mJjH+5A37PMt25OO28EnpA2GPdC6TkOKPTD7VeDZOpXJnhrMXvWNwd
	VLUtA
X-Gm-Gg: ASbGncsf1Q1HV+dFkr4l4Uo+vd7WD+AHJtGugbkKdPgSrwCOdrWuJIkl26Efg1Bvq24
	Q+WMqyIwxGPhpQnQFtA1L761BtVrIibijHjl/O5Rm1MvZjiER9hZgbGJGWQpj1RUTJqe8T+RGLR
	OQ6te7EoAIUQpgPBie9gJKGA1971VwnFl6eRTJ/cEsdsosITQjIYCiAFOH+T9qUSEkA0gU4hOco
	q1N+MqR6JSKl+h/voJ03XeyS16s6HtZAi6aU47jFTsjRO9J/CgNCDRDCXNE9uDoIRabckPjJQnL
	MTSb1ng56eP8tbAD4pJas1UxNqqKcs7sBIOrxYI+yLD8EXICWwMOVrB6YmtRt9H8C0plPh8WXLs
	qy5ZWFdu+09LUQ1DM
X-Google-Smtp-Source: AGHT+IHz/sirS1saw1RzjcOyTiJAw9WYIsGeLmZn27WeELGfOQDS+h1ZbgVSO6XpB1PPebbmfRIsYg==
X-Received: by 2002:a05:6000:40dc:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a5587ea35cmr814520f8f.58.1749618097667;
        Tue, 10 Jun 2025 22:01:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532468360sm13885875f8f.100.2025.06.10.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:01:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.15.y 4/4] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 11 Jun 2025 08:01:31 +0300
Message-ID: <20250611050131.471315-5-claudiu.beznea.uj@bp.renesas.com>
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

commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.

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
Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 534b9840eb79..aa4f0803c8d3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3334,6 +3334,22 @@ static int sci_probe_single(struct platform_device *dev,
 	}
 
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase == sci_res->start) {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
-- 
2.43.0


