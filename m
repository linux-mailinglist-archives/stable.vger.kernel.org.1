Return-Path: <stable+bounces-210039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6817D30881
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA00530730F0
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8237B40E;
	Fri, 16 Jan 2026 11:39:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAE35FF5F;
	Fri, 16 Jan 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563555; cv=none; b=Z+yB9RsgQgNbXc6KTfFGC9Kd18hL4TWU3XRuXwjelElSkyd8Sxwy8sXYvHzAEZXWQIYejbNYO1iaHQu36pCG2Zv/Zmcg9Qn16JmI8UJsHPd4Ig8AwlMzEVghpa+vtug+XlC4PqPg/CuiVjIT601XocPq/UYGZZib8BU1VgJYhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563555; c=relaxed/simple;
	bh=ApmfrV1Xe+9b4hzmj1RsenxBQsP0HCN0eEoPI03LR/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBxO3VPHx4fGQJ6dHbJPMl9n4hZ8LGqIyxGo5jzRgWaV3p7cL1O9v6hpefMilhgBuSWZQyWWJM0lDIostjuT2NcuezpPddh4/xEDqNIJJMYnedaK4B6UfPOETq0DBYsrWhLAx2dKpEPIfbZbjZT31wEaG52aeX+yXFAWnZR3iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowAC3TBBMI2ppZbMsBQ--.56400S7;
	Fri, 16 Jan 2026 19:39:07 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 5/7] clk: st: clkgen-pll: Add clk_unregister for pll_clk in clkgen_c32_pll_setup()
Date: Fri, 16 Jan 2026 19:38:45 +0800
Message-Id: <20260116113847.1827694-6-lihaoxiang@isrc.iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC3TBBMI2ppZbMsBQ--.56400S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18tw15WF43Zry5Gr1xZrb_yoW8Xw47pa
	4rGw1Yy34DXr4vqF45JF4Duas8G3WIgFW7CFW7Gwn5uwnxJry5Jw4Y9a4I93WUA3yxuF4a
	gr1q9r40vF4UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r
	1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbx9NDUUUUU=
	=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsJE2lp3rvVCAAAsu

In clkgen_c32_pll_setup(), clkgen_pll_register() allocated a
clkgen_pll memory and registered a clk. Add clk_unregister()
and kfree() to release the memory if error occurs.

Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/clk/st/clkgen-pll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 0239835b4015..f748e1fce735 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -764,7 +764,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	int num_odfs, odf;
 	struct clk_onecell_data *clk_data;
 	unsigned long pll_flags = 0;
-
+	struct clkgen_pll *pll;
 
 	parent_name = of_clk_get_parent_name(np, 0);
 	if (!parent_name)
@@ -787,7 +787,7 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 
 	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
-		return;
+		goto err_pll_unregister;
 
 	clk_data->clk_num = num_odfs;
 	clk_data->clks = kcalloc(clk_data->clk_num, sizeof(struct clk *),
@@ -829,6 +829,10 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
 	kfree(pll_name);
 	kfree(clk_data->clks);
 	kfree(clk_data);
+err_pll_unregister:
+	pll = to_clkgen_pll(__clk_get_hw(pll_clk));
+	clk_unregister(pll_clk);
+	kfree(pll);
 err_unmap:
 	if (pll_base)
 		iounmap(pll_base);
-- 
2.25.1


