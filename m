Return-Path: <stable+bounces-62315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DE93E85C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2547E28175A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324F18E76A;
	Sun, 28 Jul 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYZjr0sE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B118E763;
	Sun, 28 Jul 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183005; cv=none; b=OvtIGMn7ku+U/T7QWjiOD8f69AVjUFLJ/wYVN4cDy0ts8KW3/HdvBGbZf3BxauEBsXVA3xIpGR1q25Cuj5bpWud56F+5rmb/Xzm1NNDRw4jh7s7V007sQPgnrQ+mpWabl5vuauvNPbF1jlTsUpUw2iwhPK84rZL10EyizvMFy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183005; c=relaxed/simple;
	bh=KZK8VuZrZ3IXt6WyeipIDAW67Jimfs5oA6zZiCh0yzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kif81e5pJ5Lb0CpFqguF7J3g8G8WdxCjRnfiaDJ0X/U9OxO+F8LVQWTtwsqQBCtQHeUTAtRnFlSQE7yclj44Kw49QlrCD1nyE+2UruprMQPyN7BRiYDSqGp2Nt6ShnI6CLVS/JohanZg1GgKfGiUUlky/ig9HkXl0kRRebFa3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYZjr0sE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD3AC32782;
	Sun, 28 Jul 2024 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183005;
	bh=KZK8VuZrZ3IXt6WyeipIDAW67Jimfs5oA6zZiCh0yzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYZjr0sEKpyUyvRiHzMxZLDoQM8mC7HRGVBVyt4YHZBcSQUVETJIts+rxtYuzvnz5
	 CqwJ802bmvsEzcvxkJGVlKEzE8YevanVKRSWwjcyqEK9peR/4zQ/PUtPl2nZMZ0i3C
	 x33/Iks0UB7hhztDGw8NadD8UyZPUKynZtfk+pp+5OJNrN4UlimAJHSzgNw0SF7CTr
	 o6mF81qDIri7b1cBLLw6/yFzidmjlp6/u1r0fROKCqC2sbZb83s7Z9H+8TFPLufwu6
	 7vi859q7qfBhBia2KT5RrsXGYzVQ12MQtPiYRY1Bg2zQap5smqQqJGwM5nzXbYpUep
	 i5z15cfhp67nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	pawell@cadence.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/11] usb: cdns3: Add quirk flag to enable suspend residency
Date: Sun, 28 Jul 2024 12:09:37 -0400
Message-ID: <20240728160954.2054068-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 0aca19e4037a4143273e90f1b44666b78b4dde9b ]

Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
this bit to be set to workaround a lockup issue with PHY
short suspend intervals [1]. Add a platform quirk flag
to indicate if Suspend Residency should be enabled.

[1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
i2409 - USB: USB2 PHY locks up due to short suspend

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240516044537.16801-2-r-gunasekaran@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.h |  1 +
 drivers/usb/cdns3/drd.c  | 10 +++++++++-
 drivers/usb/cdns3/drd.h  |  3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 0d87871499eaa..1cecc97214239 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 95863d44e3e09..7f33fe02c0ea5 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -358,7 +358,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 int cdns3_drd_init(struct cdns3 *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -400,6 +400,14 @@ int cdns3_drd_init(struct cdns3 *cdns)
 			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
+
+			if (cdns->pdata &&
+			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+			}
+
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		}
 
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index a767b6893938c..729374f12cd7d 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -190,6 +190,9 @@ struct cdns3_otg_irq_regs {
 /* OTGREFCLK - bitmasks */
 #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
 
+/* SUPS_CTRL - bitmasks */
+#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
+
 /* OVERRIDE - bitmasks */
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
-- 
2.43.0


