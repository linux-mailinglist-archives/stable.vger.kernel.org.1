Return-Path: <stable+bounces-152264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D3AD31CE
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AC01884220
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D628B7F3;
	Tue, 10 Jun 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DEWwRNAf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56428B4E3
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547358; cv=none; b=uKesSIT+5dG6gRbldhqH14gOPi7AwHVwwF8Jubr/wOFdttYdEYMUzHEvwbdecXlTsrwZA74S+MirNR7Bq92KUHJywgD0wCW6aTST9toKbM+lve6jr9QVQBuk3IbAKxTeTJgAdLxxsgwApBwL7yZfdq0XGta/TBzZN/6t8STl7HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547358; c=relaxed/simple;
	bh=wS0CLPtfhOm5b92kf/uhx1Ra/XOqdQalM0tptjFMS7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD7FILiHAxuUm4KucEeg+WN5u9K6toYrq5UjaC6cuBEK5MarfObRdvqbnopDLiFyOZIxbiU8bX5xjrbbY4T6IylNPCAWhJxSAEdxaQnGQeFQch5cX0RcikDyjQG8GFU+P0LffOVqJOzwkacs/3ymYfEtZQ4oV01QDesWuew+7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DEWwRNAf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2363616a1a6so6655015ad.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547355; x=1750152155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va3siO387j2VoC06GK/4QFQK9voTcsrvQqeBKNKR4Iw=;
        b=DEWwRNAf0QB2d7GkzvpEDbRUyXqhoQQ/vHt80SnhzPnM7GUUyESOHyNPXAkWKlVIxu
         QeMWeeAbkCYiik3qIN+4ufsZB9lPUSX2fkytzQ+dsWX11E4sJyzH8DOKkfTyCqJBGYgy
         Gee0TjotVAdPxmB0+H1pWb5qNMM541rpYePFR7oXqN7OKaCaBN+FYc6iqL62FQSC2HUP
         7s15EUrFdXLtxWxrEpERwq4XyiMcN/fMfgwmwCUitSE3eWJRciRYeBHSSsrbykwQpV0N
         3Tyiteh71ern4CQtx74JD9VbpOhtEMfpXR21CXU7ROPJEXpiBGa0aNNZetOUegbHt4uV
         xGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547355; x=1750152155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va3siO387j2VoC06GK/4QFQK9voTcsrvQqeBKNKR4Iw=;
        b=wx1XL1ScpNOulJHmz0ceK8Q+QMCswLKN6Vy3yov+ydcez8CsDJyZeNLHwOelJfJtF9
         +P5SPsfMU4wyFFsO4r+s2qWQV4YmhJMn1SRJsppU1RP5XkbeQVJU4Of7a6oYr+NJpNAQ
         0/gw7Or7gSoTOyPsDQ9CxLUGqbJWdXS8gmAvS4JDB+738m3uj4lbASf0uY6FsAjbT2tx
         w14Q+Vx7eumYfZQkVc1DERfElTEIFvaMz5PRHSUKM/YhTjZwZKaHpn+ZN4Gppbm1+ajU
         qBYq5DkH10K8ju+J8tXoXqDqXOVUF6XPyJT0nyzvSpYdoFuSQF48wh2CVHr3D43BR74E
         Quqw==
X-Gm-Message-State: AOJu0YxL6OXFKyfmBcKg8j5/T5wtsvSQU45DLzc0UppDEGClrSyFa8e/
	7w+TcPuLq5fqFoifLMXiT6KqAhZ4SsRm4iBk6RwJDmz5CPff9t9Lm2STqiEodpNmCGU=
X-Gm-Gg: ASbGncv7F7w0gwIRqh1ZPgi8zr6tNdBQHPSEhg4Q0XdGduwEJU5UlOSYnZtpQAbdqLU
	rh9bLNdSOnrnFsWmU/fo0TuaRnvnRVguW3NarheBcSLu1E7x6H6ltjnXQueD5bZQyr/8a5MR/lQ
	7F8vQ/ajMtkXVMhASvzxreFau9UxRE6fwnpvuvXcZ4Y1q+yXZTJzJTjPTh50e6C5JTykHauahNm
	o9UFAjVvzgAE3OL+oInnI2XPXuOMGZ6vCLDKTAWNnwPT5oprH+jRhyrfhmND3KXowJhHZsIOmNu
	gLtK4emc08Yd8kR3GUw9v0z07AFDji0mgH2/ZZNSFYvAAUCTdewA8bbSB9U/6QS07sirdlKXVFX
	4SU2nJ13DPPjPUtQZgkfylWoleddoJQkqGLbbjnsT0g==
X-Google-Smtp-Source: AGHT+IGbJIHfa2t3hQ2mUqrjlD8bC5fxJHJIfWVyoLl/p5BzNAK7pEuE5ojARq5pOZZifArzHeM8sQ==
X-Received: by 2002:a17:902:ec92:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23601d05c8bmr191836805ad.18.1749547354908;
        Tue, 10 Jun 2025 02:22:34 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:34 -0700 (PDT)
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
Subject: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Tue, 10 Jun 2025 17:21:33 +0800
Message-Id: <20250610092135.28738-3-cuiyunhui@bytedance.com>
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

The DW UART may trigger the RX_TIMEOUT interrupt without data
present and remain stuck in this state indefinitely. The
dw8250_handle_irq() function detects this condition by checking
if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
detected, it performs a "dummy read" to recover the DW UART from
this state.

When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
while the FIFO is enabled and UART_LSR_DR is not set will generate a
PSLVERR error, which may lead to a system panic. There are two methods
to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
UART_RX when the FIFO is enabled, and the other is to read UART_RX when
the FIFO is disabled.

Given these two scenarios, the FIFO must be disabled before the
"dummy read" operation and re-enabled afterward to maintain normal
UART functionality.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1c..082b7fcf251db 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
 		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/* To avoid PSLVERR, disable the FIFO first. */
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, 0);
+
 			serial_port_in(p, UART_RX);
 
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, up->fcr);
+		}
+
 		uart_port_unlock_irqrestore(p, flags);
 	}
 
-- 
2.39.5


