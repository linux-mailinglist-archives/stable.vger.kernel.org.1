Return-Path: <stable+bounces-132302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43705A869BD
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0118B442CCA
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 00:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FECA52;
	Sat, 12 Apr 2025 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLYbhQF4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840719443;
	Sat, 12 Apr 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417161; cv=none; b=FIF0yMMpjikgifZGbH+bvFLpUQxTfSs4RxIN1fGigRBxPTA49C5nSwuKwEFD8ACg45oWOGAo58SI5wTgua6WSp5bG3Z3Ek3QGcno8fEyMfEd7QSRVWM2sUCGSfWrVo7VlWZpiyWP3RMyUvykWfjLBP3seNaKJOyao2wG/DVVqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417161; c=relaxed/simple;
	bh=BLQ439q1MPWjp/KqOogAeG7uQPJqD5biwqUYUPtBIC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIFNvr0tmwyihLchHupxWuDcihDj0SRr8oyBj3d0JXzyFg8OsCP5Y8u4afRSf5HzXhCxg7VDCtB4GfoR1VRY6f6FC2nrd8AvfY/Xk4zKK7s3NCeznG3FQOj77t97FDrAjxm8eloHFZaubLvnelPVovu+MQXXb8lC44xyTMzGnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLYbhQF4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so3693676b3a.2;
        Fri, 11 Apr 2025 17:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744417157; x=1745021957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl4Ao+sGi12Y8GuDBgcGJjc/F643etgfiqYpC5NF9Bs=;
        b=BLYbhQF4ameMDSr6422pBxBx38BPYXvTivzuZ9kvcDVOqWkjVQJnNXWItpEyhRKs2R
         KBxdAUET3joaKocOQ8meF3gd6CAZxbCQWhge0q7hYepMO49HFgULmRHGwjgnA26N8IHU
         HGaLG/SHfC00Sk4wLBDKS+T4PmVXSVbYb4eL7fKaR1oRo+Z+H0dbNj+wwaiAp5y+62Na
         LIZhU2sFnuw96YADzRA9+xS2FPu51LiiSuBz/bZR4b2H3O/ZnqUacWPq0IGHE+vgDnlO
         alhUeU/LAud6MMEOsbqtsa6ymY/+/9MxkLCYwWs7LKMos6oYl8O17MQJwoNpWrF9tmZj
         sWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744417158; x=1745021958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl4Ao+sGi12Y8GuDBgcGJjc/F643etgfiqYpC5NF9Bs=;
        b=fBjZ+mvRH97Q7S4gDyRsHyd6TO9m75V63rPKgQ2jNHhy9vvLJAac0xlNm0EW/i5TUB
         cNeH5/NHsuIrobmowRQSvt/4s4/IdQ/iGGlV8e3+QmYzCG0v4OuYa1yJpEc55Jv8td5D
         pPOlmCiqdS8jFp8qwcxXzUp83FE0nJjxIeJXWo7fwM5g8RBP2f9OF2ks+CVo+eIYjFZr
         7/W3h2835eYQN1RYTc0u3ptvQn+84w+vH+KH7fjfRhIa3IJrPovu7ylvqJfyCcIc4bLM
         OlNRsZaLF8FrX5JVD9yLz1mh9+mA78Gaab5jUMXfcBxj328Wq16sSih/1IpXMJbSrDXT
         XeQA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkT/3WE3y+7w/9e8UnwrQ+lQasRYKcT0ToRFFQFMdmltPWzb86yHfCZICJVP1lGSo/Q0UUiuZ67+Y31c=@vger.kernel.org, AJvYcCVMruT8AYAk6AqXUzImMTa2MF7wwnvgQ95p/ASn1fCHj54jTiUCTNPwFGS+zY0RbfclCgQSDwfj@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhzsKCj9pHy5GDTYyI+Nz4mkcz+Il+lmwernCRko4CdH6Z6oM
	oY6AfqoUlLED13PakAZ3U71nnHntT/DzZ1dv0dVxRqQum20tm4tA
X-Gm-Gg: ASbGnctzQkCP5GNTnsNmeneIhVRKlNl1B84H36bAGboIuSnpiPz/S3t0wr5e3ip1j9T
	0wIs/njahRM5otSNTDlsbXGC/hjwVtE5mq7VxWMwMnMYDFicbnMzpHKEIEBZIhygNVVF1EPa7Cn
	yyTJ2Dq4BAms8cqNccBsswf6zhaSbezODcQZN+GmkE1+cnG4W027KCrGBvPyPpxYMGRvXCuTWD9
	r/dLiZ3aNNls+4Eb2ldYkx3J0pcfVEy6g+7bYuSuFztAD0NO90xWfOwBA4on0gFznvoptG1PAEy
	QL4gs27gzZ+qtietBX95GytrQJ7GkM1qm2EoRQlKBaqeLhYgPVRd3XdohIAaeejlUEq26TyoPQV
	YSWxYGGK8uw7VojA1c0DSsczfWIr8fkWPKuTq+Q==
X-Google-Smtp-Source: AGHT+IHxZRgFKr/eoGrqndx0eEnSsquSVnD+KeF8iKFQdtKjOmi7NLYyrW1oWrufBCw9OJAiRQqcNg==
X-Received: by 2002:a05:6a21:789d:b0:1f5:6c94:2cc9 with SMTP id adf61e73a8af0-201797c3a64mr6674058637.22.1744417157441;
        Fri, 11 Apr 2025 17:19:17 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf3604sm5520285a12.25.2025.04.11.17.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 17:19:17 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	stable@vger.kernel.org,
	Ryo Takakura <ryotkkr98@gmail.com>
Subject: [PATCH v3] serial: sifive: lock port in startup()/shutdown() callbacks
Date: Sat, 12 Apr 2025 09:18:47 +0900
Message-Id: <20250412001847.183221-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
The register is also accessed from write() callback.

If console were printing and startup()/shutdown() callback
gets called, its access to the register could be overwritten.

Add port->lock to startup()/shutdown() callbacks to make sure
their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
write() callback.

Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: stable@vger.kernel.org
---

Changes since v1:
https://lore.kernel.org/all/20250405043833.397020-1-ryotkkr98@gmail.com/

- It was sent as part of series but resent as a single patch.

Changes since v2:
https://lore.kernel.org/linux-serial/20250405145354.492947-1-ryotkkr98@gmail.com/

- Add Reviewed-by by Petr. Thanks Petr for the review!

---
 drivers/tty/serial/sifive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5904a2d4c..054a8e630 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -563,8 +563,11 @@ static void sifive_serial_break_ctl(struct uart_port *port, int break_state)
 static int sifive_serial_startup(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_enable_rxwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 
 	return 0;
 }
@@ -572,9 +575,12 @@ static int sifive_serial_startup(struct uart_port *port)
 static void sifive_serial_shutdown(struct uart_port *port)
 {
 	struct sifive_serial_port *ssp = port_to_sifive_serial_port(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(&ssp->port, &flags);
 	__ssp_disable_rxwm(ssp);
 	__ssp_disable_txwm(ssp);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 /**
-- 
2.34.1


