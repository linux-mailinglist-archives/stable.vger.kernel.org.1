Return-Path: <stable+bounces-109404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8CA15534
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D0F3AADC4
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57D019EEBD;
	Fri, 17 Jan 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp6uj4PW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1C19D892;
	Fri, 17 Jan 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133371; cv=none; b=MCSDMQT73jIknoE1sHlPPlb4B8xFNZy7w8NTciZMnHOBH6NZFyISmZ0kU4TcUzF+wscBKuvP074UXJWpoPPeYX484JLLzRlXsMRx38+qgPWBACAq/0KWnSs2ru/pMmVwu+taP3KsK4C9ycpYitnmd5KHIEIdcYDyYShMf1K9inY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133371; c=relaxed/simple;
	bh=wFgjuoyBqwQ4sQPn4mUJKjloW9Bov770FPUWOprtCX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXot4LrbWg/eZ2lCAsM8kMulKPf9J79kn+TB/Sfnk/YDy7w9qCUpMZixde75MPeC6MNmOSqdnuQ+VEOzknRmY8QyHV433/l15tMqcpvR+8ZZXGtU7EeTpXI3zGjLNWybG6tR008Ik5O1ezfKHxWoTVSvKRl96qr5c3Ug+7QePEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp6uj4PW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so4130834a91.0;
        Fri, 17 Jan 2025 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737133369; x=1737738169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4kDojqUMiIFkZnyNMg3tExxWOhbTs+aQLMwWb7s2ao=;
        b=mp6uj4PWOCl8KJdGmWwmikSZTIQ6tI1mAppMqoQD7/8dAw/4Nrw6qnlGgVVriHlW8M
         EgVWiu1nUmwht7RTHiugx3vtHgzInp2a4Ya0dqslC2HOtIBI0ym5lE6pOeUYS0VzJgg3
         UoSazN7s7hEgUzcGonG6z6seGqpItM75hHM6kBFZpsbnt1wgw05XUKhmCh8mS0Q0yPPs
         DqC+mR0xpuqu+q7b80bomEetd7rrx3fai819wscPlm1kMl6sldAGmujApw08vkiS4/Nq
         V333y+oSe30O2OLNKbzWYy6N620bgL/7KvIcFgApu7nNrVBZm1Y5WthP7kNpOfLbo/Fk
         FGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133369; x=1737738169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4kDojqUMiIFkZnyNMg3tExxWOhbTs+aQLMwWb7s2ao=;
        b=NLOKTUW47az42hc6Cgh62HcqYVVfJDeu5WvOc4A2eu0ytWjOUNWDjCGsNwite17y9b
         A2QEJw+Kl10lfd0Hlnxy30jzQspedubaVAucgETCzfWIXPmn0kNufeMB2ZUwVl6w+rgn
         80NjEIohXNLIQliPP6Rhm92g31fSFksM9442QliKHptC01qzsq5TinT3puXK9sOaNU5L
         6XtyC0o9TCEhzkp7nNxP4HI4C6Q9BeswJ8jZGT+1v5gUei4yD113j3RzZKzjNfk5nqbI
         pV0O6p72pUzte2RqrNMms3EbBK6jM+Rb/XpVYEPYodtQPtCFHBPPylltQ8M6SAH6eFqc
         NPrA==
X-Forwarded-Encrypted: i=1; AJvYcCXTmOmXOsjWAsxdbAq6O8GNywqIiVzZyu0VsQhW9DcLkqVcLLE2YJMVkHjPYewvVu7MXHAYwaQz+LBxj6g=@vger.kernel.org, AJvYcCXuCx6u9Nd9EyAhspfef8ayDIENxacXLhWQlRUX8Up5p5ystevwvqOB8/WzqiOqmhibnIC+W4vZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVKnGawbO/i1u5gRj8Nh9Zg0hVu9QKvdw9g4IBVuOoHbpR2WC
	N4LBdc18wtaGx2Z2XwJL+6FWo9Cyx3Sht74igVV1P6oL/VmnsR7Z
X-Gm-Gg: ASbGnctV6rz8mnJRyGVACKFcOD3FdFoL3QCjG50Xm0ACYaFnEpf1vTIE5K7yznZW1G4
	vXXFLnZtW9+iwwpOoy3WRPP6OrgJHNPbEgQy7wIxC/g8okFjGZqurVWlPdTTf/X9ce4JGbAknRc
	sQ8JZyzXxxZWh1BzdW2M6c6omhrQf/WOjc5qS+B5RKO0ibaeeheHXAJOMPs+DdsM9EIE95wkXAt
	R9lQioq4CD/5vew3KOSqOEnJhkbqDlh5KHa8WMnC/DyZSo39ddWoQr/Tw==
X-Google-Smtp-Source: AGHT+IFSKYz5MJBYL73PaQgH4rfTufNnsapr7Rut4pl5xrZYZx9FoXciCNIkw1AxE63eVLgrgYPDDw==
X-Received: by 2002:a17:90b:2f50:b0:2ee:fdf3:38ea with SMTP id 98e67ed59e1d1-2f782d32c45mr4034054a91.23.1737133369113;
        Fri, 17 Jan 2025 09:02:49 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2f72c1ccf46sm5544422a91.22.2025.01.17.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:02:48 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/apple-aic: Only handle PMC interrupt as FIQ when configured to fire FIQ
Date: Sat, 18 Jan 2025 01:02:27 +0800
Message-ID: <20250117170227.45243-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU PMU in Apple SoCs can be configured to fire its interrupt in one
of several ways, and since Apple A11 one of the method is FIQ. Only handle
the PMC interrupt as a FIQ when the CPU PMU has been configured to fire
FIQs.

Cc: stable@vger.kernel.org
Fixes: c7708816c944 ("irqchip/apple-aic: Wire PMU interrupts")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index da5250f0155c..c3d435103d6d 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -577,7 +577,8 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
-	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) &
+	    (FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
 		int irq;
 		if (cpumask_test_cpu(smp_processor_id(),
 				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.48.1


