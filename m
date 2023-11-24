Return-Path: <stable+bounces-1370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EED87F7F55
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B88B21973
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB403307D;
	Fri, 24 Nov 2023 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1MDve7Ij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233033CC2;
	Fri, 24 Nov 2023 18:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10623C433C8;
	Fri, 24 Nov 2023 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851229;
	bh=khz9xSofs56dHVuRVdFljgvgZQ/s8nJ18KBXqppPB8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1MDve7IjHDAqPVpif4I6W5V/oiSfO8syHTvYNn6/qHonTfdT+e1BWE0WmqaqLXAf5
	 ZiRe7nLysWLdfEbOnAF1SLhxJLaSSL2YJMp05dXdmSwH5iP3tYa3p1sEsHfIdmaUBs
	 F2uQRPRY9PGg5aAT/Nd95+IeJkI3RjO0UuQYmRME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 365/491] pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable
Date: Fri, 24 Nov 2023 17:50:01 +0000
Message-ID: <20231124172035.544790965@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 2e75396f1df61e1f1d26d0d703fc7292c4ae4371 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/bcm2835-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1a179d4e011cf..d2f0233cb6206 100644
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
2.42.0




