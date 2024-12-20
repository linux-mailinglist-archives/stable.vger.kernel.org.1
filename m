Return-Path: <stable+bounces-105503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59849F9839
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084927A3F74
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082A6239BA8;
	Fri, 20 Dec 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jct6sGAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15A239798;
	Fri, 20 Dec 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714858; cv=none; b=Iz9dSiRahZZhVtVmYiPIimpwCmkuIllRbafNW/b4lR3QRMRf8jl5BAqWUxKbQqs0EZJ7vIIx1FTa3XPKvP/j2DlGjgRVnuWlcCVJ79kyFR7aaQcTHH7ATnXj9Bqvc0yIx6IZ4uuuusIgQpuUVJ5t7YP8Ln7UWYy14AflP0LUcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714858; c=relaxed/simple;
	bh=ou0E8CU/tzjqwpehGDyuARoQn+rVMMvSB4b7Is+CaYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YD/ZR3E9A9yJ5LnA84pr9JT8NVti6AqlCcNRbUCTa7ohQlwMnh6vMNM11cqwxa6gBOxhr0a5sio1Aybg73tc7dZ/3zYy0olwUvIRF+as0KHyXD9aG15fPYCh2CjEdHLWsrdwqPsOuaVgAhvA63hQOH0LmjrELjdah19J2eP3Bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jct6sGAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B74C4CEDE;
	Fri, 20 Dec 2024 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714858;
	bh=ou0E8CU/tzjqwpehGDyuARoQn+rVMMvSB4b7Is+CaYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jct6sGAJG3ofb1b/OliaeqC6jbqqPJp3hoAxcmj6AG54fj7/qNJLb19ZkgnzC3Mh7
	 2q8Ir10SEa5w9Ph3Gk46I2TmInxbGp1N89KSXqpE0dtRfo6cEEYC54oB41DFkEG4mH
	 7o9dGgz8nYbFD1FdWJVvDL73btU7sAd++zUH2c9bhlk4xkvkJXD/Nh0ZRuY55yuQBv
	 g/yWWsJeVuOtrsh+4Mto/YdciARLFlA0BsWtjWIpYJ3MiTJE86UoD+x7s6KILl1zTX
	 UQJ7eTBGbRA64B5XeDixGj3TZ3bvEpRIV6zR1EB0WBjv3K1bNrxlQt7ZYVnJ6UvkeS
	 7hYmIaBc1pUjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 6/7] irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base
Date: Fri, 20 Dec 2024 12:14:05 -0500
Message-Id: <20241220171406.512413-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171406.512413-1-sashal@kernel.org>
References: <20241220171406.512413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
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
index 205cbd24ff20..8030bdcd008c 100644
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


