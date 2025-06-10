Return-Path: <stable+bounces-152263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E62AD31C8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EADA1883612
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420D28B3E8;
	Tue, 10 Jun 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jVFiiOF3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D291628AAE9
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547350; cv=none; b=QZTXwK7XzQYLKsj4qqvnMdA+vehGRvDAO47ck4xGVCC6Z4Km7uZ3tGbVN12f+TL0QnQ3c7p5nYXrc95uUXWrbJjOsnq9lgVFCxj3mQrpz54zsgtZSglndBvyJQOywI+WasXcVl9VCICdjLoz+r4nuZGdAj1RywZcfOyH6Mzyu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547350; c=relaxed/simple;
	bh=Yay0E1IktJ5U3dv9Jr5sXBr5qazP/zu1WzMA4ShslGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGm170e04RmGxYKo6jw8t9PaAwNLnBoB2UGJ7+z01l2UV/ftrWq0FKVYyfEP4R457cc2SB/A1tb88LAKAvhKDBl8Os7LqO08v3u9RDad/r+9EHODCu4LH7snMNFA79/eoJIpp1spbpnMhFgMXXfDmVVzrHqK009x4f1OMgaTbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jVFiiOF3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23526264386so44608355ad.2
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547348; x=1750152148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=jVFiiOF38oqLjJUReNTGhqSFrZZPEFMTginsQDmkYe2OyS1Rjv0O6n3784AmpWp2rY
         pSnmlsUzdoVTwZDYZZjw/7IXKBpdWIG5pLa74sAG97KQxLNk+TN05KAG2hUayyOkMq0M
         4aGsGiJkvOTCG6rh/pL/D+E3B8+bVCrLQaPHy5ipZJ/e9XAAbdZkMWJNzI/jpjNvdEJx
         boMy8AUZzLsft9eDXqFnkB0R3iV1s8NTb1dneAo0u7zzgrDqbiBoT7k1zPaxz9FHOfNZ
         mGvZvSvUOqUEeMvW199o98XZN28o6Z05+dV/TRCD1ukzilHlg52A3zgX9eKSpAoWyfYZ
         0JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547348; x=1750152148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inkjt4Nq2XV942wyB2oCSN3ntPshT/X6vryIjMwcT1A=;
        b=UQyI2L8N9k/7dzS2fDDApN+1dNUb8xD4vvS6b1HeMS1cPHrGdoJtb/ZCj9SyiZY9RF
         xfYtE6dUe1eForAby1o2cAN85SfctyB8pFPagEMNXh4EvA6pwonNxfSG4cA7jsa9ENuM
         0DrnFtEoH0CpRoYjn7VDWed0Dd6LdA6j0aG4H1mxThYi0Tg1tk5KVeDjPOSsRhyGey2G
         r73vAehy6Kpp0bFr1Kwgy07oBopAPC+gt8FmhuOEp47GMS8VM3L3PWehR6Bx+b0vxDVJ
         qKoB2mjVxte5Vr2BTCI60wUlv2i5FmCYm8ge3zQHTnl8h5xvfphlYBx0KKln5+zg/MxE
         AGjg==
X-Gm-Message-State: AOJu0YwQZJVAcv2J7VIPzlIkdHemWFz+XFSaqx6ZM7EbAD9gJQAC1o2A
	xI6IWwMD7RCzLSxTaQcUPcI200+w9qanZVA5weYgHzzRTFF3jd79VuCIIJypussynBk=
X-Gm-Gg: ASbGnctUzYNmLG+EDYuXOz/DLQ8wBP9HrPV98jCO5tfxIedoxKnURqvSr94hjE4yoCV
	Gjo0pwNKy0N3gMVBNO78Relu9ILAtlhPRI8c6DCsGLnW3MISy4ZG4ywIwOo1v477OSQG6ZQEYSn
	uFCqSwcxLBTVlFbba7r50/3CQAjUElOm+PjsC5Sk38xAbNFBl2kLxD8xXX6XXgSkIzx1RGA3DRY
	+uNCZjkFdNZknCkEjnhzJVB18yr7Hl1eQyA2JNNQGapdFUhvWw7oVgbxBi6l1/4nFqA9ywPkkFH
	IQ4Cen3CB0/VYzySPF+fkH3sGUkTgDPwnzW51wGzi+f8r745/FE9xS9cjFlUmlvKrfubzi5usN+
	RtW57IQnSGR/LTBp0UZkOyFG89WPx5XJLZVEmCepoDw==
X-Google-Smtp-Source: AGHT+IGF1wKkfYtuiimtR/p3LIkqw+9S8l8lvSXg9Z3PNzxGl9/ZZMkReEoX7Hs9Ut7c8jSVbeCQjA==
X-Received: by 2002:a17:903:22c7:b0:234:b123:b4ff with SMTP id d9443c01a7336-23601d08686mr221662445ad.21.1749547348162;
        Tue, 10 Jun 2025 02:22:28 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:27 -0700 (PDT)
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
	tim.kryger@linaro.org
Cc: stable@vger.kernel.org
Subject: [PATCH v9 1/4] serial: 8250: fix panic due to PSLVERR
Date: Tue, 10 Jun 2025 17:21:32 +0800
Message-Id: <20250610092135.28738-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250610092135.28738-1-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
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


