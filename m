Return-Path: <stable+bounces-105497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C679F9827
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271857A2C5D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1323694E;
	Fri, 20 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQRSeNTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD1236947;
	Fri, 20 Dec 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714845; cv=none; b=HFv31x33CiuwL+GpQ1KstLANTIeg4ONk/d3L1b12hTUW85leHvt6ERKXtHsM72eZXdnuZmQTyc5fuIXTaUeEhe4GbK89hebHlXZWRUx9qTkmeW/VtOfGmsjJ8ucxr5y+dH3c/MPFuR5l2Mw2A7SX16LqGkUuriLy3doXMhWUfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714845; c=relaxed/simple;
	bh=PUH7xLZU3eTBut67cDj/0MSSJ+FcT2BnzFAo+dQQEm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oioOw6PYL14Gkx62tRVqbtlzImXmNReqA2UL2flz+xYM/Fptx0aNN/mt9yjd+V12tWuaAWnO8CxV7ajs2QEi3buwdzPdug9gn3Pvf3EhkAD7Yp1NWDkV9GuZcf8KfRB4ECkxcEBUiXjD2N14a4roc4bAb3lzFM/Hl/WeTk5c97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQRSeNTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ED1C4CECD;
	Fri, 20 Dec 2024 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714845;
	bh=PUH7xLZU3eTBut67cDj/0MSSJ+FcT2BnzFAo+dQQEm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQRSeNTtZCRkxmMkSB4D2+LmsgSPXGIl5eWGZgUpibwYGusy3mjd8ToI64X2lbJcv
	 bXwKCIVedHcYeW5JQRmWeNZP6+CWYrFhtJQS22gqZGJjWVM8Rufwd5fccxfKz22xPu
	 kfc53tePrHSU3PVFMrQOtAud/AZibUsNicPeFYr7AAHzqHckd/h33rznTtN02FTfYJ
	 wpz8Qxd/2Ya2oPLLIww3zdXYVcvrh0lOzUQZL2q6uchclm12O7IWTea8kL3mU/Vc/a
	 9NvRX7itJAuuJzbT9HarnT1p+6rgSGui5a5FyHpE+wCANrSghhyOxyWvJ+rNu+V6dw
	 M9fRqP4HHMbYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 8/9] irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base
Date: Fri, 20 Dec 2024 12:13:46 -0500
Message-Id: <20241220171347.512287-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171347.512287-1-sashal@kernel.org>
References: <20241220171347.512287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
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
index 99077f30f699..c941037199c8 100644
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


