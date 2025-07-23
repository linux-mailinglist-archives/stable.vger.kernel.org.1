Return-Path: <stable+bounces-164359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB6B0E8B2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3918F17900A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BC1E5219;
	Wed, 23 Jul 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dBXdZBY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687401E1DF0
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238017; cv=none; b=fYdA7WZSj/fEU2tCrtToyS2PBucJjkxsS520jkKGeJKV0oCxKkNXNcjqhqdOiv+j/RVUcgXBK5iI/Quk88S04RsTJdwpBxw0q+oA64r2/Fedw0j2RwGSJtq346PQCfhdcDNHGyla98u67rCBGLBgHwoUU8OhQX4OE8OkN5Ym42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238017; c=relaxed/simple;
	bh=SqF492q9Kp82C7tym/WEovxGbqtFyhfwFxqr0W+j9Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyKynuWOIMd1MocIxbsEri9mvHRsqOX+5PwDWuPPTpKCLvgux+pdS7OYc53EYJyb5LM0dknnD22f3KR41RJzZoETODW5GzI1zo95onw0quODHJpo5s/kUwbjL8uxN04GDhKnIeiOCaf+HTOIxrqHImO8UzgP7WYzRQzMnLuQoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dBXdZBY7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237e6963f63so37244945ad.2
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753238016; x=1753842816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=dBXdZBY742Qe6eu3o+2wDaSvfIIreToWinwBW7Ng70yjYMJy685LqI6zuvJ+m9OzgO
         7wHGrpsSDbensDb9PbJB3RfFSGZZ70WJJHa4inD1lg94dE1fKWxvxAc5b2xFAGQLLd3m
         LOe69i90kS+gO6Uq2LvwtdEa1UubJZO+addWVv9KpixTxIEk34JMvsNAFjalGL6VJqLo
         1ZdibaJ17mpEebeYASDUHdIik6VXistwsntwOT2gKscDSn1JfZkRpSrV7zJOOpqflJ5L
         VVfVuh1AMvwy0PzEgwbBPy1cM6y7/+W8Z6tKIoUOkoDIf4+BV6Q2aEe7elBUJ23NXMuo
         3Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238016; x=1753842816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=PbsU0Vmi1Y5z+MI3tiHemKYJkrFkB4k84xkb9zXpPI82ysnCsR4sq00h770150Nz87
         yL9FLqxPswLlqvUDJNcT+v4SMjZ+dsGtnavFC/3aSUSp1M/jy+r6KmCgAx/V8OwBueRM
         XOUhb0U94Njbc4fJShWNqipexTPDm5Rywv/dupyXAU3sMXJp2vf7y8c5vploqywLPkS4
         51lBgKrtJ194d5Wkd5Pe1Z4mJq8ZtKTSVdSx3MAOvcS1fOrVFkMfgIakz56PbAZa11Jz
         Qj1J6S5dCsnXEmYMuUYsHNhmmAe8tRNCo0mFqc3J1b0RJm0XN1MhQO6uk1RYrEtuB6aX
         7CRA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9s7D07p451um4xtpHcIzYthpEql+UHbVodrfV/JlLSMHZyqsyAGBquX+P1FkiuGO6E/mpFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTu1JP6thWBvX1Tna2AXN9Dpv4bO3VJYRTgXD+9dsiMYQ2bRXF
	hxwQRFvzC150PqvllCe48TxbaNoQ1EAtsSNyI3V0uRV8sD/rs8AjHgPLjSw7DW13vBg=
X-Gm-Gg: ASbGnctTQUWKACDYTPlSG4X8I+mm5wU8wjLTGWrBvuaBioqeopVPbMutUZlTaUojCcW
	x4JM4SCnLQFYYuhjHuSgMOPM9JFLUF2g6JBaWl/jML0YuQ1qhnWQ490CCyVN69muYKNBBPn3wb9
	Uhozv2AXvOSL/9SokJxvLJTcGSpZNMnhM31EPfh3RanHSLI37W33FPqBj9oJYC5jlgYoFvGd8zo
	pRQhobG/UH4xHNdpcQJWHwfSHvIJoApQBrzWQnrsvqvE8rJ8ipdC85kpMzhVAG3BWecO0n4mWKL
	sCtRtsqTfPAbxrOfXebjbwlJnzsmACECZZs2I+XH+XZQDk/t0QYXlvavLQNW8rswbQoJ2FcFy8a
	b+swcJl5GjmkasuhfKcJGHgjjNLN+crXMnQRp4nsnNAjy26rRzjvArJht
X-Google-Smtp-Source: AGHT+IF2KZMu9tBJ5eQnwYDzw6P9UXzyzYbdG7iFoo+7BGUm52xEPh6annNbtlg5BtEsYH8AFeKVTA==
X-Received: by 2002:a17:902:e785:b0:235:880:cf8a with SMTP id d9443c01a7336-23f98149b7bmr15717685ad.15.1753238015655;
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a77sm85325795ad.136.2025.07.22.19.33.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	matt.porter@linaro.org,
	tim.kryger@linaro.org,
	markus.mayer@linaro.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v10 1/1] serial: 8250: fix panic due to PSLVERR
Date: Wed, 23 Jul 2025 10:33:22 +0800
Message-Id: <20250723023322.464-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250723023322.464-1-cuiyunhui@bytedance.com>
References: <20250723023322.464-1-cuiyunhui@bytedance.com>
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
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7eddcab318b4b..2da9db960d09f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2269,9 +2269,9 @@ static void serial8250_initialize(struct uart_port *port)
 {
 	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	uart_port_lock_irqsave(port, &flags);
 	serial8250_init_mctrl(port);
 	serial8250_iir_txen_test(port);
 	uart_port_unlock_irqrestore(port, flags);
-- 
2.39.5


