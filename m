Return-Path: <stable+bounces-171488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772FB2AAA8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA0D6E5CAF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068D322A2C;
	Mon, 18 Aug 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJORqViI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC3322A21;
	Mon, 18 Aug 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526094; cv=none; b=Un5VJa0qrjudSCDzejsX4wbE7Iq26ibyVnuXSxvjbiAo9IBEZ+/BJ2FF0VPgzjo9fkPq2oNkIH6hncLJeMob/iQ7p8jpdgPAXULzAFl9GRnAxdD0K+DinPYVSFpE86uMnewjp+Qiq688CEv16d2yCJXTcgRz1m5lC4PmMj+5CIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526094; c=relaxed/simple;
	bh=TveuMrop8MF8Ya+wIHLio5c4GbrzAhU/ncRIW54iBlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVNtIj+rOLZO0P2UrNzNj9COCnShOWvmV2xgsXGLZk7cfh7+DFcXGCn53O3VPw5txwJN5tRzk26n/cX5V3L8kB1aQ7JE4UKB6wUOFFySLVxe6L83irIhV2nY0ryemsn8ahHzAs1OsnJdkwjeaRmTq9Ndp1nxLQf4iR4qs1C3X/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJORqViI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16407C4CEEB;
	Mon, 18 Aug 2025 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526094;
	bh=TveuMrop8MF8Ya+wIHLio5c4GbrzAhU/ncRIW54iBlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJORqViIRgll00/xvedXLXY94skt7soM/DAYrsp7axW3A4NvSONlEczmICjYaoA4Z
	 UHBViYVc6lEbLEQjwbKx3lKMtDe0wq4qLnapWNq67Rqkgb/vYma60CFnq/JT1bGx1v
	 OF33SJYrd/i28FcrX1IPLXAg2A48HAAFAUwDFeGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elad Nachman <enachman@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 457/570] irqchip/mvebu-gicp: Clear pending interrupts on init
Date: Mon, 18 Aug 2025 14:47:24 +0200
Message-ID: <20250818124523.452450350@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elad Nachman <enachman@marvell.com>

[ Upstream commit 3c3d7dbab2c70a4bca47634d564bf659351c05ca ]

When a kexec'ed kernel boots up, there might be stale unhandled interrupts
pending in the interrupt controller. These are delivered as spurious
interrupts once the boot CPU enables interrupts.

Clear all pending interrupts when the driver is initialized to prevent
these spurious interrupts from locking the CPU in an endless loop.

Signed-off-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250803102548.669682-2-enachman@marvell.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-mvebu-gicp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d3232d6d8dce..fd85c845e015 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -177,6 +177,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		.ops	= &gicp_domain_ops,
 	};
 	struct mvebu_gicp *gicp;
+	void __iomem *base;
 	int ret, i;
 
 	gicp = devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -236,6 +237,15 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	base = ioremap(gicp->res->start, gicp->res->end - gicp->res->start);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "ioremap() failed. Unable to clear pending interrupts.\n");
+	} else {
+		for (i = 0; i < 64; i++)
+			writel(i, base + GICP_CLRSPI_NSR_OFFSET);
+		iounmap(base);
+	}
+
 	return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENOMEM;
 }
 
-- 
2.39.5




