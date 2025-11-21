Return-Path: <stable+bounces-195466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6DC777E3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF3342F8B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8A2586CE;
	Fri, 21 Nov 2025 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="diA61Jh8"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBB23EAB8
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763704853; cv=none; b=VbRh/jkLMfuisluU77arc5/QB2aHlXVqXdYDkg9M35OLlWOC64wkdI014GS4j9kgVfgmzx7ygGHEPFDigz/3agC9hQaEcPx+rWG4qpDhlMqLoqHhrnk8dlVoflDdldq328tDZ+62CdvZ6GGjrIdTbjhdhQfIGoE8g+nIiuEdhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763704853; c=relaxed/simple;
	bh=HJOXw0LUMavF3aipJkKbUMqj2aNEtD91pes5/jnkm4w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ajmA/LO63owUy+5kx5LwAkfoDxCkg9Kx5qxLc4IvuvVp7+kujo7m+4FWaU3Li1P0Qi30SmXkF1FOWSsKoYOmK5Mt1GK8Y9us5GSCnJwO1Rc25ME0SEoxcs5+n0+chsBq5dO1V3/xl6P9SVGga+h3UZFFEOi6QfprExaqrDyudo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=diA61Jh8; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=diA61Jh81jah8lD1a1cu+kH4aCFdkTYIbuxCl0PA5jT+JAobBY1Eaq720FTk8td7CKJPRzqSfBKF/
	 Y8EVelDGvzJKZcvGQZuGtNLdQPu9+J5GEVGE6o6UovHvaiXtQHZPF+3MJ4cMIi7GiMKZtJHvdH8/uD
	 +aaoTFbrwxsTJmiU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-27-12032 (RichMail) with SMTP id 2f006920000ad50-ff9db;
	Fri, 21 Nov 2025 14:00:43 +0800 (CST)
X-RM-TRANSID:2f006920000ad50-ff9db
From: Rajani Kantha <681739313@139.com>
To: dqfext@gmail.com,
	jacob.e.keller@intel.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] net: stmmac: Fix accessing freed irq affinity_hint
Date: Fri, 21 Nov 2025 14:00:37 +0800
Message-Id: <20251121060037.3210-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Qingfang Deng <dqfext@gmail.com>

[ Upstream commit c60d101a226f18e9a8f01bb4c6ca2b47dfcb15ef ]

The cpumask should not be a local variable, since its pointer is saved
to irq_desc and may be accessed from procfs.
To fix it, use the persistent mask cpumask_of(cpu#).

Cc: stable@vger.kernel.org
Fixes: 8deec94c6040 ("net: stmmac: set IRQ affinity hint for multi MSI vectors")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250318032424.112067-1-dqfext@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3155d69a013..aded4fb61345 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3516,7 +3516,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
-	cpumask_t cpu_mask;
 	int irq_idx = 0;
 	char *int_name;
 	int ret;
@@ -3628,9 +3627,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->rx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	/* Request Tx MSI irq */
@@ -3653,9 +3651,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->tx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->tx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	return 0;
-- 
2.17.1



