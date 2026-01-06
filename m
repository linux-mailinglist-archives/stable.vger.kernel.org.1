Return-Path: <stable+bounces-205062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8433CF79FB
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912DA30F86D2
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BCD30C60D;
	Tue,  6 Jan 2026 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGhsONEx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6F1F1313
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692947; cv=none; b=L5AdU2xgvD1FcXM6BwpqydFKBhaIU5zXf998DBKQLRO3kwi1sMx3etw7Uxzy1ASvgRuzP26glIk/ehjjva9+UM474oCXeRghgyR5VKT7ydTnSkWrgh3JX/ZihHWG3wYs6VYvXmS8BbwrroK56EMH7kYdBV95cHavRYFZh5Biyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692947; c=relaxed/simple;
	bh=93sInUW9zEA86TJ92/hM/OPNM3sAV6MsWLI7AyWVdm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSQaQk3MHLmmN75mSPb6kDZWF2Po2QwXGf3hhcVO5lHDFZ4FLDxSTDco+FMNzMyFIQyn33NQ37j7gMQCLPOYZ43UvCrYwXHFAb0EuijFSMpcdpK9mm9grodbFeP5i6tW+t0zVci1D8NPebwCFLYCVoFIwQ+D0+JSDSpNb+M5FW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGhsONEx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47798f4059fso1113925e9.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767692943; x=1768297743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdSCrn+/q0mZzBSTq1BS80pekWEZnQx2RMu8OndDeLE=;
        b=bGhsONExMOpFHhfHnDMLcWiwayhtQNSdJy4aiS0mU0IdC2lwyz4oLSeALwwYqQD6/v
         2byTyN6a0YyQ+6LhNRzi0XA82d2qVgUf5gPlVXjC4oQu6WzRqDZ6mD2+PKMbFm7p8fRb
         U+qbnjJB7Dc/W9uAbHukmnzp1sWDlrHyeug9PMUDQEsPhHXPoLKTwfVscZmH6PlEaMaV
         ayp8O3P//GMPSjWjjTCaaPJG0whykLwnLit0pXd3Fbct6WHjWAndXnFyA6wSyCxRF0vQ
         f+iEbphTz6Ofarb4+3UPImOENEl1F5PnlRjlJX3iJI5zv5Zw/DJn0MZlSkUtnbqes0GX
         +D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767692943; x=1768297743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdSCrn+/q0mZzBSTq1BS80pekWEZnQx2RMu8OndDeLE=;
        b=UQKPgAB6Z4iU0fwgBtZfesTfXo8syjgOvFDWhrFgOYWG0w495wNIJUIYihLMYNXo8A
         d75l2LjWShm+C/2PtYK1Qy3B/dHoPCzV4ljFkIBQnWLLENTnFyREYQN73XF4rfh8eguZ
         Meq5rSOu6QPvNHcqgkDgT0wBaGEUua32P84GBRn2+T6W2h9Ji00WW8gj1G4f5p3LrcEA
         +AYZsrpawicj8t0FD8Z3haYQzMBmUlktuwHkl6DagjLcIbCLC2QaD3+UBFHvqNH1BAFB
         IK6BlOSUD/Ih+wl+2Ps+7C74kR/un+zZKrXVPWrFMYVbpsQ8w0t/a/opUBo/nROfNE/9
         L7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXQnk/1/Ce9rG0cSH9bV2zwdfjezQFMP+OljCgG2hVYjVFbnNlsEzncXH3XrDeK6Z2KXvNxPOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTllZ4u0eW+Vo+XoNAiim3hofxQ7OX/oeVfFG8rjbrOuVTX+29
	DQJe6ZnvfVqlSTKxjuNZi5vQNaxl/suMwBPRUImQ2P1QunBAynurr6TOaRwxsA==
X-Gm-Gg: AY/fxX4sAEh/BOwVJor93q2wAVwxS10VZJ6JLPQGmy51OwxCGCHaw4fayUFvVEG2GVp
	Ne20LMzYxLN5wR+gi7+KKBV/k14i07CvmXWHpZ+Sp50B+of1gxaVltustfPozrnjjQhc4sPlakl
	pd8vERy8/84P7vW79G3aqUQ9b15HfIw4iJjM50TcuZDKng8v4Q9X/jYLxCL/3BctFbg5TO7p2it
	coMyj6tT8isHls7owzDjm+nMLW7OTerFFItqXnJw02pMoqsBlbLDPMd/Oq/3NEDJ2dAjzzbmClj
	YVj9fzx4+SC/p9jjqglba/pSezhH3/ryq8ADKx0oatJ+SVwZf1pyF9GV9o/2RPPi7aNuxc/F5gr
	Lc2QPGTQHIt4kB4H6Awldxnbx3jk9s1iBALxnJnS6uR0MueDoewEDurld9uLfQaQmm60GWgwG1D
	BROSPNr9g+F/leffXX+q4YctjJGU+BGM9M0n76ncPPhuTGUIA3XUAWqGIfp/Oo9/VQJ1WQ0Tic5
	CIN6oE=
X-Google-Smtp-Source: AGHT+IEx2UdQuxi7Q30O0PMFfygpPYTxnIeUBD5iNPkUORydOgAHKzsNi0xUzYgshQ1Av83QPmgZtw==
X-Received: by 2002:a05:6000:2883:b0:429:d084:d210 with SMTP id ffacd0b85a97d-432bc97d535mr2100593f8f.0.1767692943323;
        Tue, 06 Jan 2026 01:49:03 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm3330081f8f.29.2026.01.06.01.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:49:03 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Steffen Klassert <klassert@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: 3com: 3c59x: fix possible null dereference in vortex_probe1()
Date: Tue,  6 Jan 2026 10:47:21 +0100
Message-ID: <20260106094731.25819-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pdev can be null and free_ring: can be called in 1297 with a null
pdev.

Fixes: 55c82617c3e8 ("3c59x: convert to generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/3com/3c59x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 8c9cc97efd4e..4fe4efdb3737 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1473,7 +1473,7 @@ static int vortex_probe1(struct device *gendev, void __iomem *ioaddr, int irq,
 		return 0;
 
 free_ring:
-	dma_free_coherent(&pdev->dev,
+	dma_free_coherent(gendev,
 		sizeof(struct boom_rx_desc) * RX_RING_SIZE +
 		sizeof(struct boom_tx_desc) * TX_RING_SIZE,
 		vp->rx_ring, vp->rx_ring_dma);
-- 
2.43.0


