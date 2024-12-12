Return-Path: <stable+bounces-103317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C09EF633
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BA3282945
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA92165F0;
	Thu, 12 Dec 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rc0xp1mS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337D13CA93;
	Thu, 12 Dec 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024199; cv=none; b=LiU0h0fPtP0aVFE1q6tUHITi0q6DQ+rlMb4GGDBky7nBXI52+m4kcsnaPTbLQepJxImoI49TcKxCqDsGO90da8cYJPT2+SoObyuvbYJnzr8Vl3RYnIpj7kEhk0D80t4vH4Z2ynX+d0dEz448LfKZrr8AxiYD5sau+HEq1hJX+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024199; c=relaxed/simple;
	bh=7ij68q00kIv8QSY6JtPJY85yWzq96oTmkLW+6iCNEbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYJ+vHZDC03RPwgaOWv+HBtA2eZ7nmpXTScUBrV1N7VJC2BZ9fGTEsMgHcgtUCQRsZtehRnIg7pTrY+4an+mkYfImZyP/cN8liSwOAqUFgHzUbH1p6d4fOJietKCSJAIFNtyZRpMvhfAoxZkfpAgGR5rYSNk3s8ZuBeK/UKhyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rc0xp1mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01EAC4CEDE;
	Thu, 12 Dec 2024 17:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024199;
	bh=7ij68q00kIv8QSY6JtPJY85yWzq96oTmkLW+6iCNEbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rc0xp1mSOrO5DZIiLCC/9KhW/a+RJlUMvKMNeH/RC7vA5m3kaKsPXhxoB89vOfhXf
	 RqNX2NOKgs1oqfr6RMye0W/mzgzfhU5QYaMN3RX3rRfnN6rJ87KucEtlgX727EP6ih
	 N/OF4/rt34rFOu24Ssi2N4EtXeBxb8iZTKSUpKIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nuno Sa <nuno.sa@analog.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 189/459] clk: clk-axi-clkgen: make sure to enable the AXI bus clock
Date: Thu, 12 Dec 2024 15:58:47 +0100
Message-ID: <20241212144301.024238973@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sa <nuno.sa@analog.com>

[ Upstream commit c64ef7e4851d1a9abbb7f7833e4936973ac5ba79 ]

In order to access the registers of the HW, we need to make sure that
the AXI bus clock is enabled. Hence let's increase the number of clocks
by one.

In order to keep backward compatibility and make sure old DTs still work
we check if clock-names is available or not. If it is, then we can
disambiguate between really having the AXI clock or a parent clock and
so we can enable the bus clock. If not, we fallback to what was done
before and don't explicitly enable the AXI bus clock.

Note that if clock-names is given, the axi clock must be the last one in
the phandle array (also enforced in the DT bindings) so that we can reuse
as much code as possible.

Fixes: 0e646c52cf0e ("clk: Add axi-clkgen driver")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20241029-axi-clkgen-fix-axiclk-v2-2-bc5e0733ad76@analog.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-axi-clkgen.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 1aa3d9fd8d0ac..3e2cf1fad262e 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -497,6 +498,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	struct clk_init_data init;
 	const char *parent_names[2];
 	const char *clk_name;
+	struct clk *axi_clk;
 	unsigned int i;
 	int ret;
 
@@ -516,8 +518,24 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 		return PTR_ERR(axi_clkgen->base);
 
 	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
-	if (init.num_parents < 1 || init.num_parents > 2)
-		return -EINVAL;
+
+	axi_clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+	if (!IS_ERR(axi_clk)) {
+		if (init.num_parents < 2 || init.num_parents > 3)
+			return -EINVAL;
+
+		init.num_parents -= 1;
+	} else {
+		/*
+		 * Legacy... So that old DTs which do not have clock-names still
+		 * work. In this case we don't explicitly enable the AXI bus
+		 * clock.
+		 */
+		if (PTR_ERR(axi_clk) != -ENOENT)
+			return PTR_ERR(axi_clk);
+		if (init.num_parents < 1 || init.num_parents > 2)
+			return -EINVAL;
+	}
 
 	for (i = 0; i < init.num_parents; i++) {
 		parent_names[i] = of_clk_get_parent_name(pdev->dev.of_node, i);
-- 
2.43.0




