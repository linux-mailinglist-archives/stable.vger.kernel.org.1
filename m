Return-Path: <stable+bounces-180600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3ADB87FA1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 08:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1907E625780
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFE27E1DC;
	Fri, 19 Sep 2025 06:17:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m8330.xmail.ntesmail.com (mail-m8330.xmail.ntesmail.com [156.224.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF02459CF;
	Fri, 19 Sep 2025 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758262647; cv=none; b=nRaqV6F5imSfTYgP9OembnJ+Qf15KCZDMg0+q5r8JJJFn5r/QEpBA9SjyCQ6jaySjIBk561XHws7emDdsKaIMzMJSIRwZe7kLZ80eEDqKCKVYIpDEAm2Ichd7OIesvKgVlPPXj1jkDNKr4k3T4Q98ZUsXzEn8DZg+7Dy0mGIRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758262647; c=relaxed/simple;
	bh=uBsupi6zocxC70qFPqLT5y7jVYq6ckmci2eDs1o6cZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjdpH3UMjpqgSqgoIFBsCZ1Wvh1yRgTdltlu8L45V3hCvy7zaMSTidlXKAtv8nVRKz9bFTeSp3Oscuoaa5ghdEymr/fV15FBlgfT54Tghq8KEMfPqwYVPBCHlIOBDVrbEGkwgIvoumH/OnqgSM35E8xENjBasnRcw/vIt0fPmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=156.224.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 106bec673;
	Fri, 19 Sep 2025 11:54:49 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] clocksource: clps711x: Fix resource leaks in error paths
Date: Fri, 19 Sep 2025 11:54:37 +0800
Message-Id: <20250919035437.587540-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250814123324.1516495-1-zhen.ni@easystack.cn>
References: <20250814123324.1516495-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99601c42eb0229kunmd8cb4e7b18b882
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUoeVktDSBgdTUhMH0hIS1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

The current implementation of clps711x_timer_init() has multiple error
paths that directly return without releasing the base I/O memory mapped
via of_iomap(). Fix of_iomap leaks in error paths.

Fixes: 04410efbb6bc ("clocksource/drivers/clps711x: Convert init function to return error")
Fixes: 2a6a8e2d9004 ("clocksource/drivers/clps711x: Remove board support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
changes in v4:
- Change the default value of ret from 0 to -INVAL
- Do not release the iomap in success paths
changes in v3:
- Change "err" to "error" in the commit message.
changes in v2:
- Add tags of 'Fixes' and 'Cc'
- Reduce detailed enumeration of err paths
- Omit a pointer check before iounmap()
- Change goto target from out to unmap_io
---
 drivers/clocksource/clps711x-timer.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
index e95fdc49c226..84dbcd049c25 100644
--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,33 @@ static int __init clps711x_timer_init(struct device_node *np)
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
+	int ret = -EINVAL;
 
 	if (!base)
 		return -ENOMEM;
 	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+		goto unmap_io;
+	if (IS_ERR(clock)) {
+		ret = PTR_ERR(clock);
+		goto unmap_io;
+	}
 
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
+		ret = 0;
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		break;
 	}
+	if (!ret)
+		return ret;
 
-	return 0;
+unmap_io:
+	iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);
-- 
2.20.1


