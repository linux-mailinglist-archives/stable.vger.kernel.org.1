Return-Path: <stable+bounces-53675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B6A90E190
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 04:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9028D1F236EA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6844C224DD;
	Wed, 19 Jun 2024 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="GoK1NLbm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB41EA74
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763354; cv=none; b=tapXArVeRy1p8NwGAbpzSUUv+VDfEILtQDH10hKKdWnK9tpEraEb//ZYNJCMG/+jMZR0I5UQE0uLojmXQUXZp9OcbJYZlL7yDDbtis4/9HQNAaomZX2erKWfn8EVaIO2j+/IqPW791ANgYowXkExHhaPmHjGdE3SaDfG4pq/nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763354; c=relaxed/simple;
	bh=ux/EIcMlcqADBQC3pu3T9pHCPgpKyFzwYmx0CWpMx4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEKn5kxhkzt/6J34nFui+qGtGI7Dyyk9OniwAkm2x0UI5xtkfHG9XDsOECO3KtOEdpcIe1TF7npoLrccTVeNGoPVgb5woeehPSt1Gqf5KapBwjU9kxCvJ2a9MrudLqMJD5XGFLGsJ0sff738yK0TADgui7GQazM9cNuNs13p7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=GoK1NLbm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7043684628cso155887b3a.0
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 19:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1718763352; x=1719368152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1P5pA62qH9Qun2A5j0792ay9dUCbFe4CfBuuZEKJj1o=;
        b=GoK1NLbmfsWJiMEN/n2h0H0pPVAg7qkui7nWUpMx+Vu8ZjfnMNYs+UwhUl3jxVvz9V
         0pd3nBPH9AKqFlS/ewGDbywWXLJOf2m4W+Ciw8+audmzRbPcCeky+2MNrB9EIDLoWSvA
         gbjRYJ5CHe8dWASwd0tiPtIVCCybpW3EgdQGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763352; x=1719368152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P5pA62qH9Qun2A5j0792ay9dUCbFe4CfBuuZEKJj1o=;
        b=F162z0tFLk40jOEVqJ2kRszSy0cPcAzSRNOkoboeRqfliNGkHfaackV+odwBta9axL
         kf8TEguQ9fsvuAa7nKO6GB/FF+L0ZPgf3tizjYYDtydLnb2VelTMwRpXQv6nizPRZX1o
         u9lOvPPWTbwk31GBYx1j6RsfRCR39KGj/jQa9y2l9GS0QWfezVzfZFleY0y8lBPbVl4+
         NCNCYQoESDAz/q8GfmCP9IrWuBeDS+eZoHGKfuvZru9P61otwzAOlkgpVRPx8IvK/wsi
         xHqNP+L+SMJS7CbxCiGTvl8MTngvkdXCVocaGkx+QLV6UxYhIGW3WSMa6fz77nv26Dd2
         fW3A==
X-Gm-Message-State: AOJu0YwXHyyl/U/9Rl96FllrDQuChkYLA/JeKamKJ/GPLFCkkGXyQJSh
	gVQbx/8G5RL7xZK7+JxkLvxwj4HRRzKhavbYH1k5hnnrEVL10jwWOWrnX5wDHFhN5279dfo3Iyf
	Kegk=
X-Google-Smtp-Source: AGHT+IFY7LD8IpxIEC1d+p7nzfMcpsxHjWel1pJHh7ml1gWaZRU2tw9rFky/e9+XxDRgUwp41/JAPA==
X-Received: by 2002:aa7:8e90:0:b0:705:c0da:bdc1 with SMTP id d2e1a72fcca58-70629cbf8b2mr1377933b3a.2.1718763351722;
        Tue, 18 Jun 2024 19:15:51 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.120.71.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d268sm9584895b3a.101.2024.06.18.19.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:15:51 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: stable@vger.kernel.org
Cc: Doug Brown <doug@schmorgal.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Tue, 18 Jun 2024 19:15:34 -0700
Message-Id: <20240619021533.503024-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024061755-unissued-basically-add8@gregkh>
References: <2024061755-unissued-basically-add8@gregkh>
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
index 795e55142d4c..70a56062f791 100644
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


