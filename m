Return-Path: <stable+bounces-119437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BCA432FA
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 03:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346A5172007
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 02:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B612C544;
	Tue, 25 Feb 2025 02:24:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E1364D6;
	Tue, 25 Feb 2025 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450258; cv=none; b=XqtZ7+r8R/9T6dsTGn/ZF0Cxxs1JicoXGsSB0ST3f2CxqbIQ/Y471blv7Qwdf/Q8iW5ysUxrk4ElboMpvQF2L5OHu4rfSf8EWWQ28yqkuzaZuct1pmNWr5VOmvVXX2eLE4qTbShlvwRwNIBomzd3togLb/mL4LCT0t+MA43DbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450258; c=relaxed/simple;
	bh=8xOjutctvz7dst4tkZ4ofSTIOfEjqCOXV1LpbhwVBUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QVTs3T9v+uFNcPY3czlFLUaL5k4caAyq2hXfENeOQXneND6nrAiiMjfYvBkqnGwfgiyky0vPjcrwxInOS2eHM5MeWssj9ffj0OQBf9qsWVT2NiUS8/PptJqpQWnAK9Ddej9jZJHQoxu/pd+17a3Rms+eVhKhfo+TDrdu3yGb4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAAHNPu4Kb1nmzAzEA--.46683S2;
	Tue, 25 Feb 2025 10:24:02 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: linux@armlinux.org.uk,
	elder@kernel.org,
	sumit.garg@linaro.org,
	make24@iscas.ac.cn,
	gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH v5 RESEND] [ARM] fix reference leak in locomo_init_one_child()
Date: Tue, 25 Feb 2025 10:23:51 +0800
Message-Id: <20250225022351.3146049-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHNPu4Kb1nmzAzEA--.46683S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw13CF4fuFW7AryDGFg_yoW8Wry7pa
	s7Cas8trWUWr4vgFW0qFn7ZFyUGayIkw45GrW8C340g3s0vrWIqFy0ga429w1UXrWkAFnY
	vF4xXw4UG3WUCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.

As comment of device_register() says, 'NOTE: _Never_ directly free
@dev after calling this function, even if it returned an error! Always
use put_device() to give up the reference initialized in this function
instead.'

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v5:
- modified the bug description as suggestions;
Changes in v4:
- deleted the redundant initialization;
Changes in v3:
- modified the patch as suggestions;
Changes in v2:
- modified the patch as suggestions.
---
 arch/arm/common/locomo.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index cb6ef449b987..45106066a17f 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	int ret;
 
 	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	/*
 	 * If the parent device has a DMA mask associated with it,
@@ -254,10 +252,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 			NO_IRQ : lchip->irq_base + info->irq[0];
 
 	ret = device_register(&dev->dev);
-	if (ret) {
- out:
-		kfree(dev);
-	}
+	if (ret)
+		put_device(&dev->dev);
+
 	return ret;
 }
 
-- 
2.25.1


