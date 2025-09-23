Return-Path: <stable+bounces-181511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24897B9664E
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F631B206A7
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB188202960;
	Tue, 23 Sep 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C57N7P+w"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98413AD05
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638650; cv=none; b=WCvXIwTzamI9n6FElnz1n+jPuxKAZa0RzhJfFTFG2o4C77shqnFeP7AwvqGA115Al9LDlvEzIS3++G4+L4FgKJlczL8c5cFUoTtDziFMn9tld5mLVLygeekCLF8T681J+b5033V3ZUZ9z2h1H2Ur1n0bru0v3SbnTHVuFIfxiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638650; c=relaxed/simple;
	bh=1f/iNpa8REp0q5IifN2/u+4le7ji9XIT3CznMWHDGTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWjq/wvYflJQemgakrmrcC30PIP6Mn0pYNqnwV/LQCfv3B4EnQaKkN8llppQ3zGp+dLCBz6R2EsRn826jPvVcAdalr4X0ob5BpiArhaIJnr96LCrXY6O2JxHcXYaJBm2YFDPe8Z6OhWGAWPYQdAs6xugbHmxDmHdm+eTfOMMIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C57N7P+w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AfHkQLmJzDaguPM1LLGZDRbh3ErHlcNdVQv+rG4OVec=;
	b=C57N7P+w894RXj82SOY3Tse3SzrC0pQQDcCXn2LEagNqr3jb0xZoXCA4JYfeqPNt8QqgLu
	HJkmIJIhycfC28t6Tucqt3nsCJBlbTx2jKM4S1UI0PGsv9mw2cUW2JmFo6nAYHXNpY+6yG
	5fSIH1Jyzr4beXjzfuQxcBWWNTSgr7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-kZ2UXBDzMRmJdo-iJi3YCw-1; Tue, 23 Sep 2025 10:44:06 -0400
X-MC-Unique: kZ2UXBDzMRmJdo-iJi3YCw-1
X-Mimecast-MFC-AGG-ID: kZ2UXBDzMRmJdo-iJi3YCw_1758638645
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e19ee1094so18815535e9.0
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638645; x=1759243445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfHkQLmJzDaguPM1LLGZDRbh3ErHlcNdVQv+rG4OVec=;
        b=mqkQ+F20tsIpKTw/qawjAxd4QFU84A2iG/B0GcNWwF1TgAMfjZgclfingUeukrQ3RF
         /qC4NbCFfhKBu8a8fKOr6Er1HC64caVQWMIwyiNfDwX8BSpODLm8CUJf/i11p//7so8x
         X/CPltTxRjFZ17aHlyS/07vLyh+vVfod75hYHB2TDCXIqe8YPC4ajjENGh+RQhnP/ddx
         w89a/BeodXI04fi92G8ie2NjX472PvmHkWz7FuRKjqTG08M4pFCI2uGg8sUayNoXQq3K
         2mspQPG2HrVklf6e8MvLNoHFOoV2mJ8nJv3hz6vzUXgRPxtEEy9AdozqASwUuC3tfE2C
         t0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUC9vtbcx9mdG7oGHylitkiEX08GUd1yM8dCtNa907oW3fsfMafiHoXjuMzUxNzE1XbKzBH/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx928/a8NQVPmQ1gbwEJp25ETwfKLowaPOPi5oRRI/x0IHrNCSa
	SRmrV60DrzkMw/JHrg/6JsHEGonMTRx0E3F8FJSTCAfg42ACwV13fAgJVR0ySzu1OJ0Z49qOtcM
	H3TZYbS6KsgFGqb3KFyrUiqTIVBsDrOfr3csaMmVV0MTW1+V5TiNDtFT7Iw==
X-Gm-Gg: ASbGncs/98NJSjR4hX+kMXHsD+KerF82g4DZhIBkKknNFLy5UJiqr0Vc2ykcNzHu/Xn
	/l2z62rFI5HECtaAh8dkdHEJN9cZ05nyWtalACR3M3isyw5Pi87fGDY0HgyWUqHIiGf8zuYb4Qg
	jBB7kqUlFBdtYoKLu1NwRhsPTYt5DGleM+eUiyoAGu6mt/STA1lot+Je4a8XaCE7IUcznKoXkTd
	kt82sPeGFgzKnptEJxlL04LnlhooELVEiRRMAlQPxff2/ubgAFuBsrFMFYRefWgszjX3DN8HrAW
	tL8Hs0ha9FlM0xHs28zYjgJ7kpsHEgXxf3Ifw85rJt9s6wARoQ==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id 5b1f17b1804b1-46e1d975235mr32497685e9.6.1758638645188;
        Tue, 23 Sep 2025 07:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtR/o9bQUXEdS+Oi31bQdhk8BctYD1m5Uah5+e9/ilwUN9948r0etgePRaDlcvqrdV4w3WVA==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id 5b1f17b1804b1-46e1d975235mr32497385e9.6.1758638644622;
        Tue, 23 Sep 2025 07:44:04 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd63a2sm24054261f8f.48.2025.09.23.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:44:04 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jia Wang <wangjia@ultrarisc.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v2] irqchip/sifive-plic: avoid interrupt ID 0 handling during suspend/resume
Date: Tue, 23 Sep 2025 15:43:19 +0100
Message-ID: <20250923144319.955868-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the PLIC specification[1], global interrupt sources are
assigned small unsigned integer identifiers beginning at the value 1.
An interrupt ID of 0 is reserved to mean "no interrupt".

The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
start the loop from index 0, which accesses the register space for the
reserved interrupt ID 0.

Change the loop to start from index 1, skipping the reserved
interrupt ID 0 as per the PLIC specification.

This prevents potential undefined behavior when accessing the reserved
register space during suspend/resume cycles.

Link: https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Co-developed-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71e..9c4af7d588463 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,7 +252,8 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
@@ -283,7 +284,8 @@ static void plic_irq_resume(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
 		index = BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
-- 
2.51.0


