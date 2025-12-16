Return-Path: <stable+bounces-201249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FBCC2205
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D69ED3005D32
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5E33C1BD;
	Tue, 16 Dec 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkGe+CCS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85F3358A8;
	Tue, 16 Dec 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884018; cv=none; b=QJ2U1+HwTun35oUqJ2oVk9fvlqB9z381POL1u+czQpd8SsF3b44f8dviukOOSTljpqJ5xKH9g9mVj/fvQb2pLXnm7RZq2xbFA83X9XCi6uhh/818NkZkC9MludCUiENEdtH+sZSb93YEFigSO2qyqPjkXMETBpEom1Dt0kzB3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884018; c=relaxed/simple;
	bh=um2LOWd6kVgKhQkuErrfXNhjtyMA72rFWeCCcRcaLiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax5/OnCHvaWEATq0NLcu9TQxF/KV5lPdfhdw/vrmm4jn+FdWuWoB+6VKv1OHn6/zGQkFi1zQk4UBkksQYVGa4j+E0cO/rZr0zp+6qpu/tWYtJTOOrgAO4UHfoEjw29jJokrclR/RDbOIt29Ar+fwaSLwcLYdX+QBkrPlMxM2buA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkGe+CCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF1FC4CEF1;
	Tue, 16 Dec 2025 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884017;
	bh=um2LOWd6kVgKhQkuErrfXNhjtyMA72rFWeCCcRcaLiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkGe+CCS24G41dziuq8lhcJ8C63rtTeDRtV+ZnVMw3UQ7dtsMCoA7z8654UtMrkAp
	 Yk3wG4lJMUGz9+/lZLn40Xah7rIwejoiWskquSDiFiVEeqtSoMPTLIAG9F1BHlu8YI
	 YgCdfH/RZE2m6qkSL20jPMT4egkH+8aJzek7yzNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 035/354] irqchip/starfive-jh8100: Fix section mismatch
Date: Tue, 16 Dec 2025 12:10:02 +0100
Message-ID: <20251216111322.186417650@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit f798bdb9aa81c425184f92e3d0b44d3b53d10da7 ]

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: e4e535036173 ("irqchip: Add StarFive external interrupt controller")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-starfive-jh8100-intc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
index 0f5837176e53f..bbe36963ccf16 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,7 @@ static void starfive_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init starfive_intc_init(struct device_node *intc,
-				     struct device_node *parent)
+static int starfive_intc_init(struct device_node *intc, struct device_node *parent)
 {
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;
-- 
2.51.0




