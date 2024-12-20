Return-Path: <stable+bounces-105476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87F9F9802
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE97166EA0
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344422FE08;
	Fri, 20 Dec 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpGLersX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF022FE03;
	Fri, 20 Dec 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714796; cv=none; b=KD1hGIQ9AIlXvqKeeYLRHtQ8PKFf/PhcmPJwk0rbhlzjZtrWsvzV0uXIpU/Xg/jXmfoc034PYi+mh9r8Xk7zpDRpkh1aZ6Cyei4LVtsyrkKvBhgTUEC+MuJvKhQjxi4nZmC3VUMxM6Br0Rs45IxFH+fHfhrR/pAMRaSF9z55b+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714796; c=relaxed/simple;
	bh=JA2za8F6djLFcqYPd7qs0YZuwyH9yI+KQdrRY/Z3h74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2mbLvL/24H2K7AnTfuio7oOEmD3Llh50bz9RfAfpHXJ8ay3aP+N3YhQBJXCOXpz4JwjDqfYivM0qbfyAFw82lRowgfHLsUBRT7LjCWD2QXcIuqtPk70heeodPxfldRG/hSjpJHm3ojp38iExvyffKkSW+2xwtRmDNxCL9Vr8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpGLersX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D630C4CECD;
	Fri, 20 Dec 2024 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714796;
	bh=JA2za8F6djLFcqYPd7qs0YZuwyH9yI+KQdrRY/Z3h74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpGLersXRqiOwr9y4XX8+d+xcWwI4mjE4aeSw4MwxWD/F7CwjhwG1vbXSM0XtrdqU
	 aHM7hlm7TU89q5as5BUfhrK3vYkii77axu7RCUA41bPrnkWl04+8an1L6CBf9xctx4
	 kc9CYInc6tlksCh3etSSVsrKa5JeKKtnVxdT0oaNTr17SPVpPbZBtPzGvpMzxygpGk
	 2WZ67QSSKcHdYhE3QqIdOCBOvqMPUKouSMw7sy84qubeHfrR3pvTk0UKP740QsJwzR
	 UV1ckeX8NXdEURCWACwycBrCA044j5vej9o6Vfr++wB8qDD50V51HunLOaJM6rKPlV
	 80zEnY4yv291Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/16] irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base
Date: Fri, 20 Dec 2024 12:12:39 -0500
Message-Id: <20241220171240.511904-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
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
index 412196a7dad5..2c6c50348afd 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -64,7 +64,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {
-- 
2.39.5


