Return-Path: <stable+bounces-179643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE1B58214
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE0D203DD4
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18E28851C;
	Mon, 15 Sep 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKSUywkf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662D2877EE
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953743; cv=none; b=C4bHRtOl3fVMiMQFLc9VMi+Smbg0KU9DBCbIbWX7C/xqTRi44LcLWoXi5OelE/Oq5sKYg1FvPPkRnPbLSJxUlaYn5CptAn5VKP68QJU4vLZebl4RRpxjpA5FmL7iP7Stn4WV8oPFnR38FhSHRoTEjfI2eNYo9PfBbkc2uUxW6CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953743; c=relaxed/simple;
	bh=SapIqnwTojIEKvm8JJFE1rz8q7ui11cRO+zNNtA+z4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2WZuMfWKZ92Bq8ahlDidVeZTuZgMXTZd/9+IHq4xjUwgcfDSZJinKH+Cl2QQaXaP3fSdUktDqM0L75RlwctTEBaEn1dBz1B4czAW0zggIozIxcvJ6sATS7x/4jf+hSpmFHd5aT01j42PG0E4HdOWAL8zhdCCFBusrBdS5FhF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKSUywkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757953740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=90J5I7tDJWuTtR4pzepvkTqrxkeGN9PC3IPf6m4g6yQ=;
	b=cKSUywkfgEEQQjwh6LL1H+eMxNJ0An1zmlDOvSeugYKP4jnlqj5y+3yNJ5TtNi7dCMl+69
	/RzY/WXywV0MjHfyiuYhwM/Xjtg6Clp1p9yt2B8KIQk4drIrDgCX+zuDAcVoPybhMKLO2U
	MtEH7qysb7M5aBahFkVjcLVK2O7PqR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-MclEWCHLMPabRi2r6z8w3w-1; Mon, 15 Sep 2025 12:28:59 -0400
X-MC-Unique: MclEWCHLMPabRi2r6z8w3w-1
X-Mimecast-MFC-AGG-ID: MclEWCHLMPabRi2r6z8w3w_1757953738
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so34155605e9.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 09:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953738; x=1758558538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90J5I7tDJWuTtR4pzepvkTqrxkeGN9PC3IPf6m4g6yQ=;
        b=QwW+pd4GzKpCNf2+GIxEHR8YCbFU1X0I+YoW4x+K26EGOMY5CvClw7Kim6+7cmITSH
         TD2eFNz3xLujVBcuAHfwZIqpNeNSeggPfXn/7/GOg/AWxl7a6EBOn0GUDMUKhEWDFKGH
         ivt9EkgfsSJgTi5M16NhCzCow0/q81ac7/IIlT4pSfaZucToVa8KNKIjf5/Md/U76sYw
         CywXG5eQBjxnRFugl8L8ReJSiOPp2/Xx8LSo0gPAp5wJ/KRswE33geJCZklYj+WGSfBf
         Fk1D6zFVcIR4mqKUMQQatQw+L3otMSjq8r34Zv2wuS6aon7dQ0n8uPv3Uf44EvWCVozl
         m1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVgQvtOLfXSQu7jLGMCQy/klyGJO6/jod2mUquh6SrZTwRlM3xU20e077oRKcg4LhB5Q5dGOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mqBVrUrJa6IuH3ua2rmHxYHikceGNtGwh9RTg/DH6QeqcSFg
	0P+/esHK5Y049TTM/IYUAM3OuXgKrikdh55gwFvdulXsglhHE7eHcnSfR8kCcPfYzXYhcmfGvMH
	skPeEWN8aIdy8LrcKU8kDA8BW2C1eJ9d/+jUe2dDiQ+71d5xHvUCSYJl9TA==
X-Gm-Gg: ASbGncve7wE4LPxQYN7EdTQ+bGDYq9DkKDGxuBMmDXgtWK7W+ysalL8sN1PbccjQJVZ
	YIALv+bNTOdz2hkNWJtX8/iAcrGxnJzVybKzKso53rL/+UcxXx81qRvicYZtR0BH1aKBsLj8mOh
	gup8k7eX8nU6QzVC2Pu4NY9lNI9pBHUzgHeo34qyjGMSR8WbG5zAHlUQJPU8ycQD6StFA9ULICQ
	3RoxZVf5a1slxTFs96fZqoCwc22o7uHp5gj2DHeU/TqtB7b5rYk1QQAhuQR4YFj8XRe1jdDeWDd
	EShtJdrhrVsAlk/+aYJ+LRbq9j1s+7Ou3XtlgAHv71iV3w1zvP7T5lw=
X-Received: by 2002:a05:600c:1d22:b0:45f:2bc1:22d0 with SMTP id 5b1f17b1804b1-45f2c422f88mr52741705e9.33.1757953737856;
        Mon, 15 Sep 2025 09:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGcqLg89RzAzIylVbUAdhxQnrbuII6q9BMD4UeHPPpyAnAih60GUdiWlXGIqVqjdTWEN3ljw==
X-Received: by 2002:a05:600c:1d22:b0:45f:2bc1:22d0 with SMTP id 5b1f17b1804b1-45f2c422f88mr52741475e9.33.1757953737422;
        Mon, 15 Sep 2025 09:28:57 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm12840179f8f.42.2025.09.15.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:28:56 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH] irqchip/sifive-plic: avoid interrupt ID 0 handling during suspend/resume
Date: Mon, 15 Sep 2025 17:28:46 +0100
Message-ID: <20250915162847.103445-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To: linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Samuel Holland <samuel.holland@sifive.com>
Cc: stable@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>

According to the PLIC specification[1], global interrupt sources are
assigned small unsigned integer identifiers beginning at the value 1.
An interrupt ID of 0 is reserved to mean "no interrupt".

The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
starts the loop from index 0, which could access the reserved interrupt ID
0 register space.
This fix changes the loop to start from index 1, skipping the reserved
interrupt ID 0 as per the PLIC specification.

This prevents potential undefined behavior when accessing the reserved
register space during suspend/resume cycles.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>

[1] https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..1c2b4d2575ac 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,7 +252,7 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	for (i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
@@ -283,7 +283,7 @@ static void plic_irq_resume(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	for (i = 1; i < priv->nr_irqs; i++) {
 		index = BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
-- 
2.51.0


