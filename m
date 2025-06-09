Return-Path: <stable+bounces-151991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D06AD192C
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07A91683DD
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABFF280CFB;
	Mon,  9 Jun 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zjw2bvIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1B257AFE
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749455050; cv=none; b=ArVUdu6Wguvj0vP+ZlwKsjvSDafMYSg7fxCP5hgSBFo48RbF3M9frwElU9KQ34SUNn9nTfbmzv3cdXDgJe8zXTi0tER7DKMdYB9Syw5BuIenIombC6/s9wzOLzgOHERIx69Di5nSutZtuQBUeFjOuPL9WJmgWFUuPwuAAoSudZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749455050; c=relaxed/simple;
	bh=Yay0E1IktJ5U3dv9Jr5sXBr5qazP/zu1WzMA4ShslGg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EGG6wY0HwNS5iRXikTPpaoPS1XTNu3nO9ob7HbP6EYnCEqahZY2s9ajNEjcbQcLf++oxJqfqK1l8Wdp86u08wgTYJCH65IfBp6yHrG3g7pMPeWIgekB3mmfTBQPZ0v/DjOgddtd67wrHB0iz+FR6p8FAmA2PaxWxCQ+nZm1TjbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zjw2bvIG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so53156275ad.0
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749455048; x=1750059848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=Zjw2bvIGPVF1gEa3KglU/w+QSyYvW9e6HVircu3B5lvU5QaEglyDT7CIAtU85a6lKV
         2F0u5ll9HNhfs6Onpryu4q3uee3ZOOMLPV+3CgSDyoFTXw8hdTDrwXZw10mmikQ1vLJN
         dCvIKgOcKU9ujVqSb/Wlgy5I+WyYL5J4mkTEyDj7GEx2ptth9Et+xTs/8TRpW0kjwnYv
         fzKhFa8Kt7jSTJq8pVjw6vKamI2WTqH0xOqIT7E8oaKdQEzV/wHwTl/wUs7YRh2Qhe9K
         Ocn+ee7mY2NvmSlSHl+8aJtHjAYOSRiFRfEaSFL4GygTEOe1fojJ/uvniohKKzSIIgdc
         kU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749455048; x=1750059848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=o05bDlQyN3baPsKM0LQqDEuFaSDTBGshKyvhNSP8Cit1sb0YXVT1oJ4YAi4wnZEKHV
         5pDB+X7qMYobAGzSiAnxXhfapurDKjE20UlDttkmDGOo21Cq5HJZ/DiSND8jAlQ6+yJY
         zElFq87eAt//RQaEzmHBGNFAX+x5WnSmYNhL1PoIoBHgUzS947VLpsUhc+udt163gueF
         xHzzLUdHSQFKJ25JQU0iPq57tfKilWm5Rs7lTXL0/nbdA0tOtZWJIzIHN3ECMTyUVba3
         YBRvZ2zJpxWfsDhAgnB+LGNXqOP6wXoMzDeLvtlbclwKlMSAy9oc5vfHAsYZpyDANvMt
         2cmw==
X-Forwarded-Encrypted: i=1; AJvYcCXHN14g/JyWV8UNWtQMp1KCOaGPgx+No1+fjWRpd23IiOGNwcZI7sJV6QyzQRuPYZlSmYgbkEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5L1aWM850jUUVkXcIe/LOl4TeBf77yRh0yke9VCOQCbFIhrp
	0DwIH2pJTf9+f+4cdEbCIUrMq9qPCnG8LIWxQyxd/dQ+svtO2ICUT9Jyx/F9dPWcb+g=
X-Gm-Gg: ASbGncvRmfWVJVz/7uzwrd/Hk0TqQj7eFCjWRLc+dVJpNHwYVEMxdL0Ri9nIxg1jc30
	7ZTsgvkqFK+jy6d6/ktMwNG+LSv//Hn+3Gi7wDgha/537lPC8AptK0T7P1VeWt5zE9TXQZRuD+j
	TnY1RcVhirT4Fiqex/L73gozTlxaX79KweAsAe7G7T8SrJy2Vu4pUaAtnTubZkY18WdCmFvstfb
	a/d4Bs9WMSLlPo2AJiI62282t7WesEziUCR82fDhfhaSkPDrTq+YVPpMvliYolO+o4KhtU6/CEe
	hbwzCmFC68mFGN6Qqpmh1SgejIcfhmqd4HqMXJMEjiesv2OxgWGTJD1dJH3Y4Z7H1cQgQfkDNwS
	6p6f3x2k8S/vFTvPM9sg1HgZWxV0VDNTJAr6EI7baXw==
X-Google-Smtp-Source: AGHT+IGfhLJOOr7W048JUz9Br7St9/rblBkEeqaO1eS84wCT9RHG7Sx6FmIfAdyIRIjtaw9ZkajVEg==
X-Received: by 2002:a17:902:d50c:b0:234:de0a:b36e with SMTP id d9443c01a7336-23601da6138mr183133125ad.49.1749455047769;
        Mon, 09 Jun 2025 00:44:07 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm48573715ad.72.2025.06.09.00.44.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Jun 2025 00:44:06 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v8 1/4] serial: 8250: fix panic due to PSLVERR
Date: Mon,  9 Jun 2025 15:43:45 +0800
Message-Id: <20250609074348.54899-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6d7b8c4667c9c..07fe818dffa34 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(port, &flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
-- 
2.39.5


