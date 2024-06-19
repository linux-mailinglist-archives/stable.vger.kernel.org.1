Return-Path: <stable+bounces-53674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA67590E18C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11EB1F2372E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1D8F6D;
	Wed, 19 Jun 2024 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="f3sOC3Dt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20A4C62B
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763304; cv=none; b=RfUoqoMa3Kgw0M6PcEIVkKD5BtWtnOvdhI6NIt4KrsX1sPVrLy0l9+pCJtaNoDV3nJ9OuqC3ODK1Rd3Kl1CCQXuuXZMT5pjWul8/Cv/MYhFikx+bMUyFsbRdJqdpqBUcAcTRbkz4Q3TMlYLxdYReNneqRDk6M8SeEv+BI4T5p1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763304; c=relaxed/simple;
	bh=QWaej0gdpMOaRMJoVhi+uVB7PMLhTLcWUBsMJ0P1qGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fURIDsmlHUFh8PzVFpxgV0A49RitnzLuc3Yq1t+RA8khXj1lsNTu9MzRFwx1Xl1mo5d3lv0wApWpRqIw85zq83r/LFeR7tdSIJkYEOerrdK5iCxE1NXmu4/7jmM7bdRR1YUUztjW29X5exgFfr+BYJeh8pHlzkCUUBI02X8vZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=f3sOC3Dt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c70c65ca5eso228104a91.3
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 19:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1718763302; x=1719368102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfYAebaLIjDvS7oAL9oFRyiaKOcIQjqol366D4urrEo=;
        b=f3sOC3DtAbSyY+LcwDtNK/Jpjxcenhm3REOl6lRsgfoK0D6Yc+uUkd7vC1K+Bg6xza
         6R0yfczcsSt18OotEu95ZjSaA6HgHwxbOe7Pxm+vol6iiE7CS7ft7GAA2/FcqMNE3wvl
         vdFLTbskdcKL9zZF8+YwuDFET4xKRKccyVKIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763302; x=1719368102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfYAebaLIjDvS7oAL9oFRyiaKOcIQjqol366D4urrEo=;
        b=nvSeoImWfjlgBzxc+mDMihb67Bp5pf4HxMBcWxeney3LbUsOTnpn1cIyePHiCeIme8
         0CSLEwoCf1cDjUEmXFtwwK+z3+V+cWtbqWaz5QZzlsGs/G0pn6Orj99RSHa9GiAiC1dZ
         Li+Ecs+DTABhUulh78T0jkHwrf6/K2ie11r1wqrQEmvfWvz/8OkF6vlGsM7lbEqBXVg8
         V7NIMh6jmGelW7HY/5azdtiZb/2awUB684MdQqvVDfUgYUde5XmWzdQpQrYINsz1tCi2
         MUrzBavBckibVdtFh6sA9fkF5+sH202tjj+xFShm0q+tzyNSQCc4fSAGeEa5eCDAaqRR
         1ScQ==
X-Gm-Message-State: AOJu0Ywo6a4+uUhUiRttvYEXKyBan34IHIeLi17DWQC+VIxX5K3Sp/hV
	gQrA1NF4J6kldNn+thzk/ItteJsf7g+f+6DAqj0JcZBpETVHMZG6R2ulec3/5aQA/P2eWZPuC2c
	Zr9o=
X-Google-Smtp-Source: AGHT+IFhR2XAEqyWeOCvm8g9ciOdjE8mjulJmeqpdfUc5nYoSmYSYXLAKaKKPocKKoTCB2HSK5l6CQ==
X-Received: by 2002:a17:902:ec8c:b0:1f7:414:d673 with SMTP id d9443c01a7336-1f9aa48996bmr14448025ad.4.1718763301724;
        Tue, 18 Jun 2024 19:15:01 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.120.71.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9941d957fsm20879745ad.273.2024.06.18.19.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:15:01 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: stable@vger.kernel.org
Cc: Doug Brown <doug@schmorgal.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Tue, 18 Jun 2024 19:09:29 -0700
Message-Id: <20240619020926.502759-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024061754-ceremony-sturdily-fedb@gregkh>
References: <2024061754-ceremony-sturdily-fedb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
bytes when a TX interrupt occurs.

This fixes a problem observed on the PXA168 that dropped a bunch of TX
bytes during large transmissions.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Doug Brown <doug@schmorgal.com>
Link: https://lore.kernel.org/r/20240519191929.122202-1-doug@schmorgal.com
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5208e7ced520a813b4f4774451fbac4e517e78b2)
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/tty/serial/8250/8250_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index a5b3ea27fc90..2cbaf68d2811 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -124,6 +124,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
-- 
2.34.1


