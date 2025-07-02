Return-Path: <stable+bounces-159195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5CAF0C17
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0383B7A28F6
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 06:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35622538F;
	Wed,  2 Jul 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnHbK0y8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B41885B8;
	Wed,  2 Jul 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439543; cv=none; b=exFtoI7hp9tfxDD6PashcrxKR9l8pgOHLwQGFXNK+L2Wgn9AXsVJJuWUZNknUbI04yL00AgZQYmehXQwf367h+VZv8/Ic00v3W2DVKtoZrzOJj+ItOx2rTWAkRQkESv75tbQK98wbSTDHw++lOMNRTUZ6HQHOapecL0cAgwHfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439543; c=relaxed/simple;
	bh=A96+BvacTniNYLnDOqnMoXHQqbhSNtFXqgZ6PaRfBUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHqHRIGrTBOYv/4IWjsiPk/oy8XdeTf2e1MC6c7av7EMNKglihxY5GfVpX5pm0VJ41VFxEaHkFWcJrwmq+P3GISQTunioSIJ4N2ClOPOc+dGRykwC9rpvu4LgZIrjQXG+7quamVC9FsEVMM2mb+k4NdZlk3YtR4g96PMIPtbVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnHbK0y8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-454a3c5d6f3so87165e9.2;
        Tue, 01 Jul 2025 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751439540; x=1752044340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfDpen91rtZVBr1OXE02eGFc3PdKXJexUcMyudmuLZQ=;
        b=DnHbK0y8uZIBD+Wr2B1ylo3A7GdFdj2wkw9gxU8UdnhErJ5nuvSc9yNwlJ8tv7TAbW
         Ce4k2aKjPlfn6I1Pylq9wvhPwIXDDt5x79rjGw4PFPNOvoltRI6J3wIYg23T+DaNIPxy
         vvM6bkHFjXexVcMKft1LU1iTKAxh8LzuYawsBGgLrIOv5hRfbAa+huhsiA7owRRVaihz
         Bw0u/D8w1Ln80Zuikg/4Hw4FpQJs6wgLmTnUFdsLyj2N+9iMjqiN/xw6yowlSuxEv9zD
         dtE1YjHcFSmnhldAa5tkp9qaOkihHXjoxzDoxgIgnz7OEseqt1A71AbH85nJjei0kfv3
         d0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439540; x=1752044340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfDpen91rtZVBr1OXE02eGFc3PdKXJexUcMyudmuLZQ=;
        b=IM4BvdCioR/e6dYOUM7owqpXRRlVSvCkAyaDVRZBEk+7JrRL6cNAxASHmfCjO0+PyF
         7BBRYlwr4gIAKEzKVuA1OpjEhqN4wG8/9oqo6Qf8oohtKtVUYf/B+vMzz8GAzEOiKlHz
         k3Z2FSgyyashqtmX+RVGNI2e5lHGGT0zYo8ZW+rFJ4h0CG8fad+UmukOL5HOC+RKPR/+
         FPKxWmqwHS6GBJN/ewPXcJQL0RqkzeG2gdhEueJ2N6kOUraupo3IelUjdIwUC9d8EpU0
         14SBNnlpdjxscAqUw5CtiG9dZoJ3R4WGilEHNXgaotVXiwz9FzRc2siKJL9k/xa+F9Lc
         tSDw==
X-Forwarded-Encrypted: i=1; AJvYcCX+SW9jkv5EhVlTIfwPkddH2Nv7WEgxTLeWfzlCu24kKqexU9OMNnTvO61Hz8lphh48Q9pK44ZumfHtrSo=@vger.kernel.org, AJvYcCXWpAJZ7P0COP9vsDAigcARvoB9ovQB9STNzMrhzx8qO+GfhqNj4fxGpDKRsc7wXkR9I3t0YKkI@vger.kernel.org
X-Gm-Message-State: AOJu0YyGi9/3ix1AddwLvr0gg5XUuXqxUOK9kEiBPwJQK7RoURykNRJT
	Hw1/yDhPknoTESnbCWxgVeC+CgqMWrzwVzyV7EyIFVy3A68Xk58DtcSs
X-Gm-Gg: ASbGncuxarQmhO4+K1Ys45H0bvacqSNdXaNP3vG3h2eG/AsS1YuJUtDvhf1I6CwX77S
	b1jztf8x5PuJZSuOsrHHPCw1qcjXQy0kd4uzFICyw0IVPt8A9NlWGd3aAyLr6BXM04QQP+kosoK
	SyFphGqfPLsTQwFElYscGXbXqGw4jqGs2arQb5R7C1Shxh1u7s46uM9SDlWu9jkuursKwZHRHui
	w1hyJRqEWZval3AeRfgQ+eM9vjalwq/3BGEj8o5gcz9NmTuTu8fFl8V8h+54AcHPNs/XM2WyOHj
	zb8+fVEe7n2mQCntbRPK7WhKpwxzV/JsXKKzi1IqPbvPaYuwD/R7XXGrFaW6MfxMFWauWfJR5GN
	ctYpMhAqsT4KlhBrwwfFa814=
X-Google-Smtp-Source: AGHT+IGoL50y2ca/4Gf2mM1HgwW4biChFjoSDM5++my3AnnmPW/FAJC661fd5kX44+oDByiM/7p4Uw==
X-Received: by 2002:a05:600c:3b15:b0:453:8ab4:1b50 with SMTP id 5b1f17b1804b1-454a36e56bbmr6766395e9.3.1751439539848;
        Tue, 01 Jul 2025 23:58:59 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:9d5:215:761c:daff])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4538a390d05sm192091395e9.2.2025.07.01.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:58:59 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vipin Kumar <vipin.kumar@st.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Viresh Kumar <vireshk@kernel.org>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: atmel: Add missing check after DMA map
Date: Wed,  2 Jul 2025 08:58:02 +0200
Message-ID: <20250702065806.20983-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Fixes: 4774fb0a48aa ("mtd: nand/fsmc: Add DMA support")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1 -> v2:
- Add stable@vger.kernel.org
- Fix subject prefix
 
 drivers/mtd/nand/raw/fsmc_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index d579d5dd60d6..df61db8ce466 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -503,6 +503,8 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;
-- 
2.43.0


