Return-Path: <stable+bounces-63-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333267F5FB4
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 14:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1695281DBB
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C622F02;
	Thu, 23 Nov 2023 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JT0lYrkx"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30831A1
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jesyfwqDtZ8s0xRKaSN7YvNd1V2pDAq/Sy55zlnO7J0=; b=JT0lYrkxshcy2ZqB/te6rHZtkt
	//xLELPrh85ZUUK/MYbAWcpkIZhssd3HWnTfQIYRLQ7d58p8wanS0FUvVQk5Uhc3a5odAI9VfNPEH
	G0YC9Znh2ubVPyr7gMPnC6uptyGfyzjelgdtMfqhGXQgswuTMhlFN73Wn4W5holEKe8DumMAuxRXS
	pUSc50Y9aNrCi9mn3YD5Bs0oLoFffUQWbnB8zKC9QlEWTgOZt9KjwL48g3UxVakcfyKZ2Jt7Uivz3
	p8NckV+ZGGi1FIqvKL57kmYo/ojSVUjXGcJEmiHByYX/B/4Dlg7wmxVJMb+1wAvZ88inV5ScgYGBZ
	c3MagWCw==;
Received: from [177.34.168.16] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1r69Ru-006NbZ-Jy; Thu, 23 Nov 2023 14:08:55 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.5.y] soc: bcm: bcm2835-power: check if the ASB register is equal to enable
Date: Thu, 23 Nov 2023 10:06:55 -0300
Message-ID: <20231123130839.561235-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023112257-putdown-prozac-affa@gregkh>
References: <2023112257-putdown-prozac-affa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
refactored the ASB control by using a general function to handle both
the enable and disable. But this patch introduced a subtle regression:
we need to check if !!(readl(base + reg) & ASB_ACK) == enable, not just
check if (readl(base + reg) & ASB_ACK) == true.

Currently, this is causing an invalid register state in V3D when
unloading and loading the driver, because `bcm2835_asb_disable()` will
return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
ASB slave for V3D.

Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231024101251.6357-2-mcanal@igalia.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 2e75396f1df61e1f1d26d0d703fc7292c4ae4371)
---
 drivers/soc/bcm/bcm2835-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1a179d4e011c..d2f0233cb620 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
 	}
 	writel(PM_PASSWORD | val, base + reg);

-	while (readl(base + reg) & ASB_ACK) {
+	while (!!(readl(base + reg) & ASB_ACK) == enable) {
 		cpu_relax();
 		if (ktime_get_ns() - start >= 1000)
 			return -ETIMEDOUT;
--
2.41.0


