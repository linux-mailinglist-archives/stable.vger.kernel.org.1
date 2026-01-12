Return-Path: <stable+bounces-208121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B1D13009
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC8D73023D75
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F933DED6;
	Mon, 12 Jan 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxO1SC+h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F231CA50
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226670; cv=none; b=t7uFxigRBwd8TBvjNNmVW0cluriMxe/zA/CKC1FmyCFyX9aEva9nusiCEkHa2ie69dYca7aaPKcidF9lHEFCoToRcgLYQQJC/ZDfk4/H6gbZTinGUZ+PCBtb/2PnyO9uVDBF+dx5xy9nCIxGqfDcDTKrL+1LQf3BttuT3muGkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226670; c=relaxed/simple;
	bh=DaGHYSZRKjN0qbFSeTmb7c7ON+ENG7XUIdBvvTtGqqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7xBXC8LhK+CNC5LT6t2fn++uC3U4nGlzUPym0sGiym6JtNl9l55+WCwSik6wX4If6g5OIjCPCXq97VpI9+AGxVFb6g/7vBklENkHbOjyMM2/jDUtstfVh2NN/Feewms9C9T3IlWhdgscei20HGCYOmyV1J1oafA9n3WQGUo1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxO1SC+h; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47928022b93so13647075e9.0
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768226668; x=1768831468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckmRos2OAgMm2H7B68f5iy8S3ZBKtjS9ZYbxKUXmKoY=;
        b=XxO1SC+hhlRmJOQXgoSXdRTHqXvqemmqMiV4vSwC6SePEWwQg2D4jytIhlqOeeArdn
         5x+hLmRNlMxn7g7+/Uq3g+y9qlFBBFRv1cF9MjR5Kmk0JijFM+UQ90ATNZqXT6+sWR1C
         Kq4sBM9PCTU2hAYS7SI3PeSMqLfvY8cAcl3zdVDE3zgrImcvnSqJc21urjELVADS56df
         qrr0b+7ciWSkS9vQjDCv+JqDhD8kozBnia4H2QilO23/9r20Kk08FOB1CMIC58392+5k
         bae2A5KE1E8D+mvB2d9TKjcJYkahITkcPTCjvtu2yW4Wjoq1Ks1EicvhpUP6zYA8Lz9i
         7VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768226668; x=1768831468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckmRos2OAgMm2H7B68f5iy8S3ZBKtjS9ZYbxKUXmKoY=;
        b=cCFT2KilWmaDDshb6h9Z2XwoS1Sf+e7mNKXhS5ShS8Df9saOXnLUavkihFchF3IquR
         RJmLs9Um62p20da6HdHofQvi4rABjjrImGfXoUF6EBniAS+ngelx49x5VDcWmjUjrsHl
         5r3EmTivqaiNwLL8oP+sut2ysIHPEUQOnZFZyAAqkRq3OW+ogRqYFNPOpLxM82l+myx2
         bA/w7ciYiDcN4gl0bZe8EjVjBOD6//0cCUsF5RcKE7UGD0VY8WWhZnsqfhhBeX1n59S5
         7uZxkq6JJ+eecy1vSFIGlRb0n3VP8RydmD50WMo/pqpOfsXxREm7sT+GM3O4Aulbn9zX
         pVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqfGOhRzN3FVhf8AxsbysEEPvljDRFXMxA9Hpg2x0dBCLiwQhPDJEgAYJ6kIRlIeqJBA6Ips=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEr1XJQsYoD+xEndj0O97Ir608bkNVYRObGkYEUq6DZ1076qwb
	KPPlIkZYh6kJyiHS5KBIcTWEfs0Scr1KkHDNp8rqvVG+4o+hdUQMztYs
X-Gm-Gg: AY/fxX4kcOKmC4KX46Ai/mdHE2qWc+yqz7030pv4kQQz2hye3wFM8RLBhr6iNnb20q+
	9sGiih9nftYbrmEXrcUMdYQK6nADKlMl6MuXdcacB7fDwRMX+BTc+OXXOOOLHtJcjhRyJmrQYsr
	dc/b0Yf/i1xWeoRpTBj0IIIDBtPSm6GbUT/WUc78AOsXtjGdjjFXC1DsmGAqHLhpnXg2FdvgLhY
	vV2NO8b5y9B37u3BSVXFcPOfcgcHlj18dgk7HQ/6TgKYjePgEyiHFauOiHzvL/fhpOx7wnsJlKh
	Cf61RLfAdWeHCP5lIjDbGOp4sFFvC1Ym/isFn3aKeRC4cJ5PgphXLgfzOisJ5CFyW6PSU7RBnFT
	IbkU68qJy0PYZdoHLWqZQvv8Apeg2s7MIsmGawW0VJ/e5/SfOfrm2KI2ChPLp+e2alxxY1CMvk+
	M6yZgq8yNqXD7y79a9r5c92j6PhjeU7KzP1+99g02X9Ro88hDp6QKwJpk8n0CNrflZhZJYwHaW+
	lhQuOw=
X-Google-Smtp-Source: AGHT+IH7GUSAAsNDPqrKUndihq0lAKqsPDKz3kaDifL2lP8tPCtWl0A1pugqhFaqlY9nRll5jZEn6w==
X-Received: by 2002:a05:6000:22c1:b0:430:f718:23a0 with SMTP id ffacd0b85a97d-432c39ded43mr12214129f8f.6.1768226667344;
        Mon, 12 Jan 2026 06:04:27 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa07sm38643537f8f.25.2026.01.12.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:04:26 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Alexey Charkov <alchark@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Tony Prisk <linux@prisktech.co.nz>,
	linux-arm-kernel@lists.infradead.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: vt8500lcdfb: fix missing dma_free_coherent()
Date: Mon, 12 Jan 2026 15:00:27 +0100
Message-ID: <20260112140031.63594-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbi->fb.screen_buffer is alloced with dma_free_coherent() but is not
freed if the error path is reached.

Fixes: e7b995371fe1 ("video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/video/fbdev/vt8500lcdfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index b08a6fdc53fd..85c7a99a7d64 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -369,7 +369,7 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 	if (fbi->palette_cpu == NULL) {
 		dev_err(&pdev->dev, "Failed to allocate palette buffer\n");
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed_free_mem_virt;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -432,6 +432,9 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 failed_free_palette:
 	dma_free_coherent(&pdev->dev, fbi->palette_size,
 			  fbi->palette_cpu, fbi->palette_phys);
+failed_free_mem_virt:
+	dma_free_coherent(&pdev->dev, fbi->fb.fix.smem_len,
+			  fbi->fb.screen_buffer, fbi->fb.fix.smem_start);
 failed_free_io:
 	iounmap(fbi->regbase);
 failed_free_res:
-- 
2.43.0


