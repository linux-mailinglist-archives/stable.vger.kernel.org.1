Return-Path: <stable+bounces-49925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C98FF597
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A776FB24C19
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881A78676;
	Thu,  6 Jun 2024 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="gXJ5OlJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787573455
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703920; cv=none; b=io0GporgM9sZPys8ZGYO7XjlymN7rPuA3n12f5mEsei4Kdz6g8+1c7pNAINmoEGg3CO1ISyCvVjn6WlkGqmWK/3lsgb9O+8NMgk9Hav1PJC0k3Wu0m+tjWG3V2XBt6f1NYiNIef/V3nUPD/KnDE7WgB1qR9JQjJhDHIZLmVb8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703920; c=relaxed/simple;
	bh=om/tUMkX6OS8Ao+4R6UxrpZYLDopfROa6xD3DiyiTRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7ItHG09RzYlefl0Q5e38uYw+vNIVYj3mC97bxKCC8s2oZ1LmhhYgcjPhfCGeQHWYGJ/znrZ/LhuotlWrhKbHhU2h11MIlUnRlh+N9etDn/1CDWcgGPgdiTK5MOXbV7TRTWzKTzV0eSUOjEjCVEMC7GkohZNtoKG/GnF+VHF8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=gXJ5OlJt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c8b6e40ea6so171905a12.3
        for <stable@vger.kernel.org>; Thu, 06 Jun 2024 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703918; x=1718308718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1O9YIWaISmK5NIxJKMIlNcYeBFnqMM13+G/DI3fqzw=;
        b=gXJ5OlJtgwKM0MiLtg3J0Etg9R5xTUpbPCr0WEqFvA23NN/ItVYXsXfM/mKC6hsYpb
         aePVa6nRXZdA9JBb6mbZGjzuEIabCHk7GUG5PK1qq7Bz6FBwEqXTDx0mAIVY6j/Xdfza
         XfIAoYt6Ob934aA/XRWx0GxBU+K9xrn8fyung=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703918; x=1718308718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1O9YIWaISmK5NIxJKMIlNcYeBFnqMM13+G/DI3fqzw=;
        b=n1XMB1+X9PI/tsOjlCLSitQaia66+hR4OMAedHQIjWaFoMn/xPO6aRVhxWbkIkBPXt
         1JPgwcrWDpSv+SFrK1evbdT5+EpkMW7vPVKtbfUj1V+sAXwMOPPsglM+mk/D097tjbLh
         D9xrZ+eKxpdGe3EXUpmWMEZGFWlZvmfvhRVGjtcoWoVDMBumrx+ckLN5xGj9ia4ai54f
         5I3Vrw92MDhdqnR5s9AchwbMuqf2ZuowRjht623+Cj/D1I3v9j26gkBcCvFxGbMH7Egk
         YBhoSUxd+evbVLEfddixqxoTDrYSLk3Rkx0187a47qDlm+zIMwbzmWAbmWVgzkIGnPd9
         dyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY35NsDjn1/WiRvyLwR26bq/aHPtwI5t+YcN4cPH8LV11fWR5GEcci4tictyNZtguA81o/FsAZq8Gnb6Kicwc+fnSGfNyr
X-Gm-Message-State: AOJu0YzsNJuyDwpkC8WXOT0Jz32PlP2katSOnsusW6R6J4vPi7xPvinE
	gEw3ayTanH8TrRVkI00HZZWZLt/XLVEMisGOeR1P6KS/5KyBvwKFb5+DYPjv5fk=
X-Google-Smtp-Source: AGHT+IFZAvRK9sCokOpd775+K7Vnh3U8s1WAuk5KbQdzYOD2AqYp6+WQBgnCrhT26V0ykIG4QPYGRw==
X-Received: by 2002:a05:6a20:6a23:b0:1af:a4a5:a26a with SMTP id adf61e73a8af0-1b2f96945c5mr703169637.1.1717703917778;
        Thu, 06 Jun 2024 12:58:37 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:37 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 3/3] serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited()
Date: Thu,  6 Jun 2024 12:56:33 -0700
Message-Id: <20240606195632.173255-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606195632.173255-1-doug@schmorgal.com>
References: <20240606195632.173255-1-doug@schmorgal.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonas Gorski <jonas.gorski@gmail.com>

When bcm63xx-uart was converted to uart_port_tx_limited(), it implicitly
added a call to stop_tx(). This causes garbage to be put out on the
serial console. To fix this, pass UART_TX_NOSTOP in flags, and manually
call stop_tx() ourselves analogue to how a similar issue was fixed in
commit 7be50f2e8f20 ("serial: mxs-auart: fix tx").

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 34801a6f300b..b88cc28c94e3 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -308,8 +308,8 @@ static void bcm_uart_do_tx(struct uart_port *port)
 
 	val = bcm_uart_readl(port, UART_MCTL_REG);
 	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
-
-	pending = uart_port_tx_limited(port, ch, port->fifosize - val,
+	pending = uart_port_tx_limited_flags(port, ch, UART_TX_NOSTOP,
+		port->fifosize - val,
 		true,
 		bcm_uart_writel(port, ch, UART_FIFO_REG),
 		({}));
@@ -320,6 +320,9 @@ static void bcm_uart_do_tx(struct uart_port *port)
 	val = bcm_uart_readl(port, UART_IR_REG);
 	val &= ~UART_TX_INT_MASK;
 	bcm_uart_writel(port, val, UART_IR_REG);
+
+	if (uart_tx_stopped(port))
+		bcm_uart_stop_tx(port);
 }
 
 /*
-- 
2.34.1


