Return-Path: <stable+bounces-154794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36613AE0435
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C302316F9F2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7322758F;
	Thu, 19 Jun 2025 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jga15Wbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DD217737;
	Thu, 19 Jun 2025 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333592; cv=none; b=BwVk/VerGefMvurbEvkciT7lP88RfgCUxUvAI9gPp7U+4UhCT8g+K8O1qVls3cIFm9l+e3Lwo4vdY/9MgD96V3HmsaQ0UzvXgbAS/O3JCSaUlZ3qIMZuKXZSGV0WgNxb2pHY2dlzuA2edMG6xvEZi2+5DN3/BWS9y+yjjWV7peo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333592; c=relaxed/simple;
	bh=HScA7GRkDDV0SgvnPg2WLMl5mlEDg3ku+n1tWxwiFSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A0rbiTJ8vBSAsOtuYTfB+KbbVj941er2LD0hglZKLxoifRvJUPT0h2zjJFFg7VFm6m4pP0Sz9uUxVXMAKzuOjMJ8gt1xLbMi5POIuK1yKRzr3crHVFP0rfF6O1y64xMUi82PPy+8gadwdtv/nwLhr5RvZKcrbHLF7RjW8B3ZFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jga15Wbf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2353a2bc210so6486125ad.2;
        Thu, 19 Jun 2025 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750333589; x=1750938389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zY5F3UU/0eu+ezWkplimwRrPs6tfR7OLj+CFgWxLMM=;
        b=Jga15WbfH7RA7CYPSX8OxNHpUNrHPh20UibTYLG70xmMipJQGQQUiMgKlyLCvDAKkt
         VYAZHlixg/++4IOhAcmw2va1bEFiSTS7nJFWVBdouthZOuR3w89wKcbA8RunnfBwNwsh
         3JtJdikWs9XgbYICD6ZwP12nXfOMQLyLz6GWUVEXObF6sLXAEHHNkvloPsLSi+yMuQ8L
         v5XhQdl0NNhMkNI3luWRNcpbtR/S3+oe9gk41ZaIwcatiVUt8t6Q9ILoYBMCMO19PLnh
         t7gSGreQC8EQJ+98lu98MoXxnw/vlc8FYnCvoMrD/huLnGuXU4KMjYZatXFHIX7u0Pwu
         2/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333589; x=1750938389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zY5F3UU/0eu+ezWkplimwRrPs6tfR7OLj+CFgWxLMM=;
        b=HRN7ifKsWj3Zvd4SXxQtcGEEVfnh3Ve/r3bZsSqPbP6EYy1TTchAZqIgypqFzcKykm
         5TDYxLS6lHlYORvHU2ge7kvD9Up8sxI7xhIYf3d90wo1Tzcg2nys7TQcroFZ/3yBtcd3
         +88gQHx2+oQCoNnPuY+k8uEkzyBBIXGxtGPAymg53m8uqA6aAmySRHHA6zFZSSp+3qJA
         R9X6HxgdGNM/h30JFOptrolTPUPB1TSLuV59UE8c5LhOb/0E3rWLUV+u+gv8kgoG4IPl
         F9hs2lDKBbqSsORczE/J5RqCXzSqFoCzu0IA89Qj1MZE3XisAe+Y3oLWjYfJt0QEO/1U
         A6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2EvELWdrCKRYn5yUgmbioLAsc/d4qCrWyB+UuBGF82zmVCQxGBOEIgFEZkBJSp/1W/XDwQ2HZFESznCk=@vger.kernel.org, AJvYcCVyGWbdfzn2LORf36jvy6U+tIBR/sWd7Rc9ysEWLSLmGXwDFBUP/jNKAFpRS1BwfHt7FeGRK7UD@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5oelyIiiBo649tSMC3C2gJjQPOPFk53h1L5pK7CL4As/OubV
	sw/onhd4QZtwJFyF4c+pFPwst+PkP8+YZuMRkeJsyaWq0QImN/wguCzJ
X-Gm-Gg: ASbGncsFZ+E48wvhCwyWiZ2NFQo1oqAHubiKJRXhq8CLhzEl/aryRLVciErcrifo1Lz
	iDIpIxpoR8Vk6eOUgZvmHzwlp99rG3rnGj/4WbvI4E/9GZqfVl/AdlTce0MbPMyMZ/roMdOkBf5
	m11N3ME2yezD2DoBECx4953AAOZ+qmIg7gPlui87Gc2OHGFL8KPKNax19X5VXYkQ24EPchNVBK+
	d58DCHZil8Rw1+oFiJbFkBRxYBVwGu2puRBdMBi1Z8SbV5+30kPMawpRv/ydlkN4UzBA5h6eb0S
	ZsoPGFxzp287W2XCJv/V/natRl1c7zlCRG6rWGwL89BKxIP8UFpIlCkGTFo1y944gXVaoZiS6Cc
	P
X-Google-Smtp-Source: AGHT+IEqXJC4DnaLV0/S7qFrQlXQuofYwv0L6qzubFHg7yn/7ZdwZoXIcPaXqkUudCmoUPKjE0YIWA==
X-Received: by 2002:a17:902:dad2:b0:234:9670:cc73 with SMTP id d9443c01a7336-2366b32e583mr333965975ad.5.1750333588935;
        Thu, 19 Jun 2025 04:46:28 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c1e2:f516:9efb:a31c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1919sm118782665ad.66.2025.06.19.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 04:46:28 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: shawnguo@kernel.org,
	kernel@pengutronix.de,
	tomasz.mon@camlingroup.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: imx: Restore original RXTL for console to fix data loss
Date: Thu, 19 Jun 2025 08:46:17 -0300
Message-Id: <20250619114617.2791939-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
introduced a regression on the i.MX6UL EVK board. The issue can be
reproduced with the following steps:

- Open vi on the board.
- Paste a text file (~150 characters).
- Save the file, then repeat the process.
- Compare the sha256sum of the saved files.

The checksums do not match due to missing characters or entire lines.

Fix this by restoring the RXTL value to 1 when the UART is used as a
console.

This ensures timely RX interrupts and reliable data reception in console
mode.

With this change, pasted content is saved correctly, and checksums are
always consistent.

Cc: stable@vger.kernel.org
Fixes: 7a637784d517 ("serial: imx: reduce RX interrupt frequency")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/imx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bd02ee898f5d..500dfc009d03 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -235,6 +235,7 @@ struct imx_port {
 	enum imx_tx_state	tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
+	unsigned int		rxtl;
 };
 
 struct imx_port_ucrs {
@@ -1339,6 +1340,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 
 #define TXTL_DEFAULT 8
 #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
+#define RXTL_CONSOLE_DEFAULT 1
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
 
@@ -1457,7 +1459,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	sport->dma_is_enabled = 0;
 }
@@ -1482,7 +1484,12 @@ static int imx_uart_startup(struct uart_port *port)
 		return retval;
 	}
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	if (uart_console(&sport->port))
+		sport->rxtl = RXTL_CONSOLE_DEFAULT;
+	else
+		sport->rxtl = RXTL_DEFAULT;
+
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
 	 * requesting IRQs
@@ -1948,7 +1955,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	if (retval)
 		clk_disable_unprepare(sport->clk_ipg);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	uart_port_lock_irqsave(&sport->port, &flags);
 
@@ -2040,7 +2047,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 		/* If the receiver trigger is 0, set it to a default value */
 		ufcr = imx_uart_readl(sport, UFCR);
 		if ((ufcr & UFCR_RXTL_MASK) == 0)
-			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 		imx_uart_start_rx(port);
 	}
 
@@ -2302,7 +2309,7 @@ imx_uart_console_setup(struct console *co, char *options)
 	else
 		imx_uart_console_get_options(sport, &baud, &parity, &bits);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-- 
2.34.1


