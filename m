Return-Path: <stable+bounces-202327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E803CC37BF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F97C305F127
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFA3446C8;
	Tue, 16 Dec 2025 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KvPHHQQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEE343D82;
	Tue, 16 Dec 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887544; cv=none; b=KkewZGNk+HmUlZszEMhP0ps9KMGbol503hqa6I01r1eQH6IAZt0s7+e9krugjpTHWGfIF7QgPodrF8gWmhJV2ayhy+SfuzkjAHIwF8P5O6hvuyrWw+26NqByo46URFK6aPd5npqgXgJHyzxdknQxjORabA2rpQeVSsV30yX5KoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887544; c=relaxed/simple;
	bh=+ZI+rocPhApA55lmXD4xw6VhdgRkHu+w9xu3dM+n5oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9Zm73dEQ4wn+JzEgZo+gj0SlsU6lc0g6579cp0mHyqH+7Vvc18wH+pyIEbjzacucv4PcnVfgnMTORy0mjNLbsSR3/PXor8Xqv2FhwamCQC8Y+hNF+P0UMB1xNLelty8oG28eDAONCbdTgYmjitxNXfVzzJHpMmm6/bzZsGEu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KvPHHQQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB51C4CEF1;
	Tue, 16 Dec 2025 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887543;
	bh=+ZI+rocPhApA55lmXD4xw6VhdgRkHu+w9xu3dM+n5oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvPHHQQRexIWULvUswiFADTPsryom/fVLl7IqjUzf8YrcUwDykK0KHggN38YVDD3Q
	 1/Flq8q8HMc1AgfhcjnWgnXEKp65hDzyxg2FrxVA8xeg//U046vkIXnvppODQOxfWl
	 drUvgG+BZIp5iyw5BQstvtdBXnhz8dsY/Fy6lpmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 262/614] clk: renesas: r9a06g032: Fix memory leak in error path
Date: Tue, 16 Dec 2025 12:10:29 +0100
Message-ID: <20251216111410.865398013@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit f8def051bbcf8677f64701e9699bf6d11e2780cd ]

The current code uses of_iomap() to map registers but never calls
iounmap() on any error path after the mapping. This causes a memory
leak when probe fails after successful ioremap, for example when
of_clk_add_provider() or r9a06g032_add_clk_domain() fails.

Replace of_iomap() with devm_of_iomap() to automatically unmap the
region on probe failure. Update the error check accordingly to use
IS_ERR() and PTR_ERR() since devm_of_iomap() returns ERR_PTR on error.

Fixes: 4c3d88526eba ("clk: renesas: Renesas R9A06G032 clock driver")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251030061603.1954-1-vulab@iscas.ac.cn
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index dcda19318b2a9..0f5c91b5dfa99 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -1333,9 +1333,9 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	if (IS_ERR(mclk))
 		return PTR_ERR(mclk);
 
-	clocks->reg = of_iomap(np, 0);
-	if (WARN_ON(!clocks->reg))
-		return -ENOMEM;
+	clocks->reg = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(clocks->reg))
+		return PTR_ERR(clocks->reg);
 
 	r9a06g032_init_h2mode(clocks);
 
-- 
2.51.0




