Return-Path: <stable+bounces-91973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF989C28F2
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 01:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBD9281BF4
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE11F5FD;
	Sat,  9 Nov 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="PAY0hWXQ"
X-Original-To: stable@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694811E871;
	Sat,  9 Nov 2024 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112713; cv=none; b=h+w/Y7fy4ME4se6Grv4eHaKUJXZz53b9ljsZAT97EmS7zTWIw5B/k40IdDRFjJ6f8kPjgYKEQnmT3y4PtLZ6wVrkCbgRZUjcNAyNlQdFaZoYdiywFHpvYWQ/kNeM7RGO/2YfDUFX/T6oQqkwnR9wfll9bt00hIPdZlYLwZkAeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112713; c=relaxed/simple;
	bh=+tH5r8cLpo1I9/b6hjipeQzb5fcbOBVbjlOj13fMT2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hv39N3W5FfovVl+2fjHT+VHSdXe8ALNwlq3tYOiJeTQlRjvdUY1vU6fWK75Fz7phspN7sK854sdu17BuRBoBjujeGo+8uiBLZoSKTxLBYqm06gsqRS2nXlUQgK1vX+3lQtRP1ayE00CXKYA9r9Bx570g+q3BrQk6OqvfXrh2dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=PAY0hWXQ; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1731112704;
	bh=+tH5r8cLpo1I9/b6hjipeQzb5fcbOBVbjlOj13fMT2g=;
	h=From:To:Cc:Subject:Date:From;
	b=PAY0hWXQfER7OCQRqiwOo0vfS/sROfzIpwW4hL9HKldH1/EfbsY580Q6zeFYojFyA
	 zOJ/iQOdWpuHur2yGZbN4ShDvPkMecYq92G9w6R/W0Fztwej6zT5sOji4jX/1zXjEF
	 N9pKWypZqcUN51miEXH64Di7jY6TX3J3EaTGBVPQZxt4KRaLa1qairAAUmkjQwze6Y
	 6lk6n59mwXWQsmRTXSKSRNbO2jg3C6SnSm77sUd6eJBzhTUUfWX8usM4jAZlO/YXmB
	 zX512cwTfABjJooNT1MCYX5aCIkOba151xrr+Blio/SkgXb4qx1/qYoaRIOp528x2z
	 eHAvtL5Fa8EAQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <frank@allwinnertech.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: a100: enable MMC clock reparenting
Date: Fri,  8 Nov 2024 20:37:37 -0400
Message-ID: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing the MMC nodes proposed in [1], it was noted that mmc0/1
would fail to initialize, with "mmc: fatal err update clk timeout" in
the kernel logs. A closer look at the clock definitions showed that the MMC
MPs had the "CLK_SET_RATE_NO_REPARENT" flag set. No reason was given for
adding this flag in the first place, and its original purpose is unknown,
but it doesn't seem to make sense and results in severe limitations to MMC
speeds. Thus, remove this flag from the 3 MMC MPs.

[1] https://msgid.link/20241024170540.2721307-10-masterr3c0rd@epochal.quest

Fixes: fb038ce4db55 ("clk: sunxi-ng: add support for the Allwinner A100 CCU")
Cc: stable@vger.kernel.org
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index bbaa82978716..a59e420b195d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -436,7 +436,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  0, 4,		/* M */
@@ -444,7 +444,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  0, 4,		/* M */
@@ -452,7 +452,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
-					  CLK_SET_RATE_NO_REPARENT);
+					  0);
 
 static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
-- 
2.47.0


