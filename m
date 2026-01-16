Return-Path: <stable+bounces-210041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B18D3084E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56756300EBB7
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DB37C117;
	Fri, 16 Jan 2026 11:39:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60137378D9C;
	Fri, 16 Jan 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563557; cv=none; b=MMPg7D1i95Js6QCc0dp9rl7JMjqcDAyJrOtwOqhC1i7mcmnGOyDKykn/sUgEyxcnJLAj1f3O5R/2lye1EOfQ8+h1wXtzvEKAl01PNyWyGiOXk7hd7LddTrNvIRkYz25ffuGHtkKMf9k1FxFzkTCj1PIUNGHGgSMIczAPCHqexaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563557; c=relaxed/simple;
	bh=JnkSFmQY9k6v8WohFjl1H0b7mO/x4zLqglFojc5fD18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zc7VAryZzKJXiYA3bu9YVTqJ6bc/W86ipZyUThZQaquFtWSA3oM8MM4u0gk4luNGlMWAD7+9IN6uk+Es9YbVuYbBVZRdahefFhUcvWNglFkRfj/R4HOukedMR9PxmrTiCiOvQ9ShLLR1unf75lGpzfyD/3Xqg4/MIzMVhv/D8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBBMI2ppZbMsBQ--.56400S9;
	Fri, 16 Jan 2026 19:39:08 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 7/7] clk: st: clkgen-pll: Add clk_unregister for odf_clk in clkgen_c32_pll_setup()
Date: Fri, 16 Jan 2026 19:38:47 +0800
Message-Id: <20260116113847.1827694-8-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3TBBMI2ppZbMsBQ--.56400S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar48Ar1ktF4rtr4UAFy5urg_yoW8trWxpa
	4rJ34Yy34DXF4kWFs3Jrs8uF98K3Z2kFW7urWYyw1Fvw43Gry5Jw4Y934I93W5CrW8uw42
	qr4q9r48uF4UtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
	JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYcTQUUUU
	U
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgoJE2lp3sLUGAABsH

In clkgen_c32_pll_setup(), clkgen_odf_register() allocated
clk_gate and clk_divider memory and registered a clk. Add
clk_unregister() and kfree() to release the memory if
error occurs. Initialize odf to zero for safe.

Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/clk/st/clkgen-pll.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 89f0454fa72e..3fc0af4b77c6 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -761,10 +761,12 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	struct clk *pll_clk;
 	const char *parent_name, *pll_name;
 	void __iomem *pll_base;
-	int num_odfs, odf;
+	int num_odfs, odf = 0;
 	struct clk_onecell_data *clk_data;
 	unsigned long pll_flags = 0;
 	struct clkgen_pll *pll;
+	struct clk_gate *gate;
+	struct clk_divider *div;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -808,7 +810,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 			if (of_property_read_string_index(np,
 							  "clock-output-names",
 							  odf, &clk_name))
-				return;
+				goto err_odf_unregister;
 
 			of_clk_detect_critical(np, odf, &odf_flags);
 		}
@@ -816,8 +818,8 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 		odf_clk = clkgen_odf_register(pll_name, pll_base, datac->data,
 				odf_flags, odf, &clkgena_c32_odf_lock,
 				clk_name);
-			goto err;
 		if (IS_ERR(odf_clk))
+			goto err_odf_unregister;
 
 		clk_data->clks[odf] = odf_clk;
 	}
@@ -825,6 +827,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 	return;
 
+err_odf_unregister:
+	while (--odf >= 0) {
+		gate = to_clk_gate(__clk_get_hw(clk_data->clks[odf]));
+		div = to_clk_divider(__clk_get_hw(clk_data->clks[odf]));
+		clk_unregister_composite(clk_data->clks[odf]);
+		kfree(div);
+		kfree(gate);
+	}
 err:
 	kfree(clk_data->clks);
 	kfree(clk_data);
-- 
2.25.1


