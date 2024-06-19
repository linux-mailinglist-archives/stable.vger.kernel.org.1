Return-Path: <stable+bounces-53676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78090E192
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 04:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E61C22541
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30071EA74;
	Wed, 19 Jun 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="M+fwVZvC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D742070
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763395; cv=none; b=KtlIqKemrB4OLjkjiLeCmVWzP1d/grXdyxoWGGZdj+j2D7eAhwABajyqGVJsErjafG7WhWidnXDQP5d3em+1SkDKQ7ebrC7XiCAUjuGiJQpIuZILsOfvGjQQIFVkEt4HsMLrvUj6V8C4L6BeUYI+wY73k0gzeScpsUr+dPeAcwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763395; c=relaxed/simple;
	bh=q2YGzhO8UrTaJ+Y8fuj2TS8BD0FNqLIzJndeKvmJQss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKWzuL/Q0Lblj/tR3WbvXFsmxdyaXelbAYFFJvUBCeC/SKZgcMCDKXY0aEmngtDfX2vO7vSKUXUxkNupL3K89W+JgkYtN9kK4wWKV99C2fX1K2sj/SrmLMatCjySy9hLmL3SvcFNhG3fdWdelqAimAeE5PeRBRQMoqKWc+P8G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=M+fwVZvC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c2c1473f73so886903a91.3
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 19:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1718763393; x=1719368193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkZFb4EXZYqzUEjX1RAn9tzpuhmFQrMHo0qA6DbBo+M=;
        b=M+fwVZvC3muZqhv0UxGFKoDa8E6j/wQf1bGYD8VOdQPG0mfE7n5zCYbtY629dYdqtE
         E8g2B1x+uq6JjboWxF8DmAQ8K5pziBBoE4j1BSbFhh27iHsCw8EG/3LLVFtBJQJzNVgZ
         mZzdWGv5uWAs72Ac/4PClB3hdwRP361C52uNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763393; x=1719368193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkZFb4EXZYqzUEjX1RAn9tzpuhmFQrMHo0qA6DbBo+M=;
        b=h4E6W483PG+yU1TZ6ixERMaN2cJQNz9WAeVHZjW6SDVSyPcXwKn0TR45RjKXyUMWL7
         V6rS3Tf7lE6E8iey2yfgSUPsWmuwGBK1ss4EBuEdHpY+PZ8jnsuPRcxgHhmEx3hyMhUj
         VlYUkgWh/g/gSduG8AIR2I1SQ+IluxOZ3/rLM1fycu9iviUP7QvhQVouZaZtjCCSfTJv
         tpWbS4hVpsifZaCf0kG6Q8MvNV9iqxqs5e00+KXRk7XKXlR98eYawL4SNBwVEQjZ1GMm
         XesOQfW059cs/r05bMtqVokIy119RHQldtdnzTMt7pACHjZwVwICQebfvOFUXUNvZUhP
         HiPA==
X-Gm-Message-State: AOJu0YxZiXw+mgroZV2lqbzhEBFX9+azbHxhXUyLkssIngUz3HXqu7YV
	9w+484/IWlQJuRhewgxebf0auwvbsFy9Nve8rtVU8Q6ciwT/djCyftG3euHdJvUVliKuGFLwzN9
	X7XY=
X-Google-Smtp-Source: AGHT+IEvVQzha3GX2Uw3TTMRoNjrFdEHfglDeGDN/ztsBpDfOD+838qMClja/e/W2OP4F747VnWzGw==
X-Received: by 2002:a17:90b:3105:b0:2c4:d7f3:faff with SMTP id 98e67ed59e1d1-2c7b5e38640mr1351524a91.3.1718763393358;
        Tue, 18 Jun 2024 19:16:33 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.120.71.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c467c535sm11643996a91.50.2024.06.18.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:16:33 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: stable@vger.kernel.org
Cc: Doug Brown <doug@schmorgal.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Tue, 18 Jun 2024 19:16:16 -0700
Message-Id: <20240619021615.503122-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024061756-sloppily-maximize-2870@gregkh>
References: <2024061756-sloppily-maximize-2870@gregkh>
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
index 33ca98bfa5b3..0780f5d7be62 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
-- 
2.34.1


