Return-Path: <stable+bounces-187018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF75BBEA4EB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F274476B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1801337109;
	Fri, 17 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgQIeFaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D2F12A0;
	Fri, 17 Oct 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714888; cv=none; b=reu0Oh5ox3mQUIwCtas3spe29AkuICs6PFD8qj/R5Blk+i6gQjBgNb+AoYXoiLaz3OPOnIk7+ST+vf80iXuvk5V7SRE5d+i318/0Y/PRnMy4T6sxKvG3+SgFkiy0/lQU1XPQ/HKODN9gOLl/0BblX6rxR3/8Fp1yeobz5d6VwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714888; c=relaxed/simple;
	bh=/F1ocriF1pv2bBuJq6qG0gM4ox6Zt7R32vriKqxHcrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Vqp7J+ewi6JTktsnsypk3s/lJPv3gmppBa+sxurskzi0TJAZI+A/+vquJUvUb25HXwIIjz2ouM9klTwyRv8TkbQS60A8Np8DrQJcMKJIPbjmTzVz6WuPZ+bqMt0RQB4Lj5KXebGgOmS0GjO1y5ANRINzpvBCdh12oSEqXYljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgQIeFaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AFEC4CEFE;
	Fri, 17 Oct 2025 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714888;
	bh=/F1ocriF1pv2bBuJq6qG0gM4ox6Zt7R32vriKqxHcrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgQIeFaNmxILimPz2gWgUaqu1+K+OK/4G4jqlnFHI6z/UH/jYQT6XiqErSEW0rkuq
	 w+IShYtx+6ZDJLwVT4DNaCNTTKRiOn5xYCiQJ8nFaXc65FeuWZOiWL1uYi5ULuj9Qb
	 k3iUrME+ygatsOBFwM9fMp7RjVyssNYyeplHIibg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhen Ni <zhen.ni@easystack.cn>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.17 008/371] clocksource/drivers/clps711x: Fix resource leaks in error paths
Date: Fri, 17 Oct 2025 16:49:43 +0200
Message-ID: <20251017145202.096146615@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

From: Zhen Ni <zhen.ni@easystack.cn>

commit cd32e596f02fc981674573402c1138f616df1728 upstream.

The current implementation of clps711x_timer_init() has multiple error
paths that directly return without releasing the base I/O memory mapped
via of_iomap(). Fix of_iomap leaks in error paths.

Fixes: 04410efbb6bc ("clocksource/drivers/clps711x: Convert init function to return error")
Fixes: 2a6a8e2d9004 ("clocksource/drivers/clps711x: Remove board support")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250814123324.1516495-1-zhen.ni@easystack.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/clps711x-timer.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/clocksource/clps711x-timer.c
+++ b/drivers/clocksource/clps711x-timer.c
@@ -78,24 +78,33 @@ static int __init clps711x_timer_init(st
 	unsigned int irq = irq_of_parse_and_map(np, 0);
 	struct clk *clock = of_clk_get(np, 0);
 	void __iomem *base = of_iomap(np, 0);
+	int ret = 0;
 
 	if (!base)
 		return -ENOMEM;
-	if (!irq)
-		return -EINVAL;
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
+	if (!irq) {
+		ret = -EINVAL;
+		goto unmap_io;
+	}
+	if (IS_ERR(clock)) {
+		ret = PTR_ERR(clock);
+		goto unmap_io;
+	}
 
 	switch (of_alias_get_id(np, "timer")) {
 	case CLPS711X_CLKSRC_CLOCKSOURCE:
 		clps711x_clksrc_init(clock, base);
 		break;
 	case CLPS711X_CLKSRC_CLOCKEVENT:
-		return _clps711x_clkevt_init(clock, base, irq);
+		ret =  _clps711x_clkevt_init(clock, base, irq);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
-	return 0;
+unmap_io:
+	iounmap(base);
+	return ret;
 }
 TIMER_OF_DECLARE(clps711x, "cirrus,ep7209-timer", clps711x_timer_init);



