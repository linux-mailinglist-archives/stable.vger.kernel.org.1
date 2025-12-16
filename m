Return-Path: <stable+bounces-201578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE1CC3E2B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5818130312C5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FEE346E6C;
	Tue, 16 Dec 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHdeeHw/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3835346E64;
	Tue, 16 Dec 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885097; cv=none; b=GC27SjHIkBSUxsWA3fZmoZSGVqqjWAs8Cw2qsynhqYOdmy9kPCnWA52ba1a6wqRnRQVjs0a4ihg61HGgsmJTZXRtYR2QZPPGi+3GRmv4MAnAm0+CBNA9nyofh2gprSouiNIB/AUcOYxryqc246RLzZEDFxi6RMrqJKxwTReruL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885097; c=relaxed/simple;
	bh=lINmKoBuwkgDCXPy2Xp/zQMh1P8xG73o1yZUROBVwJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnoXaXmnJunGSQx9by0qNWgqPD8JBwsSsSPk3wLVk8Bay+hfNy+YXuevraezNfz4IUJBIuLYJR6cN9dPhpiNTYrkG7R+0R5EwDmqyj1ZQKjXoVYSmAREWNjikeauMlhnnnWi5Tc5pGoVwUq3vaEsMoEP8EKBXDSPzdPdRhAnoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHdeeHw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD6C4CEF1;
	Tue, 16 Dec 2025 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885097;
	bh=lINmKoBuwkgDCXPy2Xp/zQMh1P8xG73o1yZUROBVwJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xHdeeHw/A4Rhls9JDxuWk9MEnKcAgVejfRFdKvYXY2q0ocbk1mnzvhKAM8QhtZUWD
	 pI7w9oAHw424xvlARwuI9KkIqP3/4tkcl7JMLizqzNEa+xM7E0E8T7RDjtsFg7Zj9k
	 UE6jFwknLAteLBVhypGZsDpg3RMefJOKZ3mDf2Po=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 038/507] irqchip/bcm2712-mip: Fix OF node reference imbalance
Date: Tue, 16 Dec 2025 12:07:59 +0100
Message-ID: <20251216111346.920723829@linuxfoundation.org>
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

[ Upstream commit 0435bcc4e5858c632c1b6d5afa637580d9779890 ]

The init callback must not decrement the reference count of the provided
irqchip OF node.

This should not cause any trouble currently, but if the driver ever
starts probe deferring it could lead to warnings about reference
underflow and saturation.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-bcm2712-mip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 9bd7bc0bf6d59..256c2d59f717d 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -239,7 +239,6 @@ static int __init mip_of_msi_init(struct device_node *node, struct device_node *
 	int ret;
 
 	pdev = of_find_device_by_node(node);
-	of_node_put(node);
 	if (!pdev)
 		return -EPROBE_DEFER;
 
-- 
2.51.0




