Return-Path: <stable+bounces-186717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E58B8BE9D6B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04B965878DA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6C23EABB;
	Fri, 17 Oct 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGFzR9la"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7C337118;
	Fri, 17 Oct 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714037; cv=none; b=JYLPWsVH6Bol7pis+dCq7+XSDbctnrs135xj4ICn38evrqY2gcs4s7+frlUqGju58Tz+Q4x+9Y9IEccUaWxUEr6NO0di+iGTmYj1CTh40CjC21IqEJypTezvJnj2vNkdMcYdofpzvVLNBBrQ9TaZLZKkw7pNGInq42DwoItvBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714037; c=relaxed/simple;
	bh=zfiQTIBWAdHbVTDdR/7/BZIbx8I6hk8plFgCfaHdK3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZIwiC0rXyDV+oR4N8lmdl1u1gieCEnaJ+Woi3rXKA+lZVggHt2FQVmt882bJjy2hpOqvqD7RCIf72RD7tDQizhCn0fOe8sGJPRbVVGTCPloKAwPVmAfJuY1N/smKm5o80OTrLRWbRyRdQgIpsKB/ZxSaRbKn1kSHl6k9HO0I9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGFzR9la; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96855C4CEE7;
	Fri, 17 Oct 2025 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714037;
	bh=zfiQTIBWAdHbVTDdR/7/BZIbx8I6hk8plFgCfaHdK3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGFzR9la/G+bCdf1GTr1nwmUsLrA6Y2Dko/aN9RqUO0PNQczNKdFpls5ljsUv+EBX
	 +ZvDKJwNGxGEoZzHorICIkuEafHFRqUgVPrAQJz8y0KDO+Wrl/3NqCxOsHX7QLZh4n
	 UI166PjoFo27cNl+P1By/XPsms665zlhgZ0VdOB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Li <lihongbo22@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 192/201] irqchip/sifive-plic: Make use of __assign_bit()
Date: Fri, 17 Oct 2025 16:54:13 +0200
Message-ID: <20251017145141.814354804@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 40d7af5375a4e27d8576d9d11954ac213d06f09e ]

Replace the open coded

if (foo)
        __set_bit(n, bar);
    else
        __clear_bit(n, bar);

with __assign_bit(). No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20240902130824.2878644-1-lihongbo22@huawei.com
Stable-dep-of: f75e07bf5226 ("irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-sifive-plic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5728996691549..0fcd37108b67e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -248,11 +248,10 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++)
-		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
-			__set_bit(i, priv->prio_save);
-		else
-			__clear_bit(i, priv->prio_save);
+	for (i = 0; i < priv->nr_irqs; i++) {
+		__assign_bit(i, priv->prio_save,
+			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
+	}
 
 	for_each_cpu(cpu, cpu_present_mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
-- 
2.51.0




