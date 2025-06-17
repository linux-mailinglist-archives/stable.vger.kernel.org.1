Return-Path: <stable+bounces-153819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359EADD6A0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2192C5881
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218AE2EE28D;
	Tue, 17 Jun 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+E9lT51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B02EE28A;
	Tue, 17 Jun 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177198; cv=none; b=BZ4rNss6qQEJfH5lYI822FnJ5/Y0TztYCfNmJxDuAPPrgXZIvjoPVzsMPkAX6u98NJRIv+mI5TbAFIF4KoaaBLSVyM+yEym9NkAkHLwbwXgHVmqKTOvxOg87xoglxS039++EVmQ58d7BB0S4NO4a72Xjt1bSRHS2W9HSLosdyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177198; c=relaxed/simple;
	bh=Kh2afZ5CSkq0tjIYqI+Zc2w288uYiSY+MkUG7cUqmOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1wEeiOF0BhvzeFIwkFNPaJY6ICi2+Zme6lm1symWKX1FrFfVmDbqSz4xsm3fAtA4j5jRvEk2N4ULYrsl3fbjxMceiX1YEkNJY/zfYYPHrxhdM1ssYcmpp87XFEQwVIiv+6TQviHVdeIr0y9xnHzt5jbGpGzCCl+Tj3MZ5kT97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+E9lT51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB93C4CEE7;
	Tue, 17 Jun 2025 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177198;
	bh=Kh2afZ5CSkq0tjIYqI+Zc2w288uYiSY+MkUG7cUqmOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+E9lT51TZR1FMUie21Ny3jU3JKA2DzeITPjEBaxPTgm/rdTpms5rXaS/AhhoLzJs
	 fY5cNV/gGvuvYgrk5/7YNIQjn7cu2Mz1zEBdXmmo491yn5VngNXBGyBI2eO7094hK6
	 TpMLm0U4qHssYDvdFJBuoVw8o/hT3ILyhP45xQEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 306/512] rtc: sh: assign correct interrupts with DT
Date: Tue, 17 Jun 2025 17:24:32 +0200
Message-ID: <20250617152432.004742995@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 8f2efdbc303fe7baa83843d3290dd6ea5ba3276c ]

The DT bindings for this driver define the interrupts in the order as
they are numbered in the interrupt controller. The old platform_data,
however, listed them in a different order. So, for DT based platforms,
they are mixed up. Assign them specifically for DT, so we can keep the
bindings stable. After the fix, 'rtctest' passes again on the Renesas
Genmai board (RZ-A1 / R7S72100).

Fixes: dab5aec64bf5 ("rtc: sh: add support for rza series")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250227134256.9167-11-wsa+renesas@sang-engineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-sh.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 27a191fa3704c..e66c9c6fd3724 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -485,9 +485,15 @@ static int __init sh_rtc_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	rtc->periodic_irq = ret;
-	rtc->carry_irq = platform_get_irq(pdev, 1);
-	rtc->alarm_irq = platform_get_irq(pdev, 2);
+	if (!pdev->dev.of_node) {
+		rtc->periodic_irq = ret;
+		rtc->carry_irq = platform_get_irq(pdev, 1);
+		rtc->alarm_irq = platform_get_irq(pdev, 2);
+	} else {
+		rtc->alarm_irq = ret;
+		rtc->periodic_irq = platform_get_irq(pdev, 1);
+		rtc->carry_irq = platform_get_irq(pdev, 2);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res)
-- 
2.39.5




