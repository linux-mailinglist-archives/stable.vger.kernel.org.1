Return-Path: <stable+bounces-201582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B726CC34CB
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E84C0303FDDC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85DB347FD8;
	Tue, 16 Dec 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x7W2Ef8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65792341666;
	Tue, 16 Dec 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885111; cv=none; b=NRHpZNq1k2CDmM4ZcSQOP2UJlsK7qm40BemhIixNqr3ZeUWatdf2V8Uc7IQPzUGKtb/lgcedazFEh759yIkVYKjZcT/306JwZhYGBoSSwthsU3GQnoptQ6bp9SIW3cCtAAf0NyF4nCWkUfSGZ0ZZiMaJ8pC5MnrC8S7mX+8+F9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885111; c=relaxed/simple;
	bh=lNAPSmh7sgbYfRgLHsye1uNjpu/bse3LpMa+ILpbIsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc43UtXxmWQ2aXmAbm+3KfD1utd1JFAxSSJ7+/NzeVCsmr6/i7L43o4p2yETIBBKVVppr2IQLlvdVH+RBZQx5ll/xWUzg2dWFixbg8lOTpSIIxFww1JvuETBgyUwOS+RPCcY1ZwYgKork6yqeFyllhcx6cp71Rx3BMJg+Tu92c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x7W2Ef8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974FDC4CEF1;
	Tue, 16 Dec 2025 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885111;
	bh=lNAPSmh7sgbYfRgLHsye1uNjpu/bse3LpMa+ILpbIsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x7W2Ef8aGDCq9jnpL6oj02/oWJ3xtmwvPnKw+aU8tfktfcFZKTdS1JpqqHmeUlMH5
	 r5DNznqGZ0EN1K98mCCkrWcZOZhzVeu5R8v8GV9N0D/UAMZ6vaEpD83qklGmd9cbqe
	 eMPVpamnVcIT/SpKc4ZG77c8fGIOreNSfuLX0YRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 042/507] irqchip/irq-brcmstb-l2: Fix section mismatch
Date: Tue, 16 Dec 2025 12:08:03 +0100
Message-ID: <20251216111347.067015530@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit bbe1775924478e95372c2f896064ab6446000713 ]

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: 51d9db5c8fbb ("irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-brcmstb-l2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 1bec5b2cd3f0e..53e67c6c01f7a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,10 +138,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
 
-static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent,
-					  const struct brcmstb_intc_init_params
-					  *init_params)
+static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_node *parent,
+				   const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set = 0;
@@ -257,14 +255,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 
-static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }
-- 
2.51.0




