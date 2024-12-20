Return-Path: <stable+bounces-105510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D09F9855
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E26C7A3D45
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10402206BC;
	Fri, 20 Dec 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/VewN0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06F23D435;
	Fri, 20 Dec 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714870; cv=none; b=dEf4SK6GR3WuvkC6fgzd9hWtSX5t9raHWjM+a2cHfqvw/dTNg3sARbWrRMdF2tTIspQivvTlWM6Vvy7UgBMFE9fTmZO0zrkZLgWownbeX5OQp3wCMnP8Xa/ntPeUhoLmqZX9DDwrkrWxaI4G4L3PFtQfbJqLxq+LkdaGtqJhSR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714870; c=relaxed/simple;
	bh=IoNioR4Ju/0+CVY6rT96SwXYV89BY8pzAPmMiokxOtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTZyZCeteRKP0aU1TLvNpGgtmm2V2Y9TkKT0Ujh2M/PAyw2ROt2IzNuKz9pCBptnKm0HjnCZCmOgpLm1HWj+Uc2gOM1SGqJ7rQoRggX2KLHmJxbFqeOXcKkoGUeClUUzht4nYSN3izPUASIXlLZ+y6QJ5TnuQKo/U6jTZHAURUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/VewN0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B87EC4CEDC;
	Fri, 20 Dec 2024 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714870;
	bh=IoNioR4Ju/0+CVY6rT96SwXYV89BY8pzAPmMiokxOtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/VewN0JkXHQB2lWgT1OvOauO8QCujkqqy9JMXBuwFYCMfNGx39mQQ2ihLaI7V3tS
	 CUHYXnpbEFeeZCJadD558VGEYQbnHmq8owJzq6etoJEOWDhx7l+jWiJ+YUtZeio7Pl
	 xUl/5+nEC8Lq6pala6eSm/y9I4ROrOuFfLH6dbSvZeWL6FOE0e2zbWi5lAvVXVzhrn
	 3j1IBuLd5LOGRYfiWcTE8kaeagTUO2WOvJ+f5F/VjqXxR+uMu7WnRIT+pAwMPfR1TP
	 t3d+SWGol172z3UGHDZEDVeVr61hmb2S8HRUHKOCOn7QAKS4zN4yfbPglUDmFTaual
	 kSPePFt5wiZNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 5/6] irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base
Date: Fri, 20 Dec 2024 12:14:19 -0500
Message-Id: <20241220171420.512513-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171420.512513-1-sashal@kernel.org>
References: <20241220171420.512513-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit a1855f1b7c33642c9f7a01991fb763342a312e9b ]

percpu_base is used in various percpu functions that expect variable in
__percpu address space. Correct the declaration of percpu_base to

void __iomem * __percpu *percpu_base;

to declare the variable as __percpu pointer.

The patch fixes several sparse warnings:

irq-gic.c:1172:44: warning: incorrect type in assignment (different address spaces)
irq-gic.c:1172:44:    expected void [noderef] __percpu *[noderef] __iomem *percpu_base
irq-gic.c:1172:44:    got void [noderef] __iomem *[noderef] __percpu *
...
irq-gic.c:1231:43: warning: incorrect type in argument 1 (different address spaces)
irq-gic.c:1231:43:    expected void [noderef] __percpu *__pdata
irq-gic.c:1231:43:    got void [noderef] __percpu *[noderef] __iomem *percpu_base

There were no changes in the resulting object files.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20241213145809.2918-2-ubizjak@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 882204d1ef4f..5937f3cd288b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -62,7 +62,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {
-- 
2.39.5


