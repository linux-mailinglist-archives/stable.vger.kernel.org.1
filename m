Return-Path: <stable+bounces-207878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1F0D0AEBF
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40FEA303D370
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878C35E530;
	Fri,  9 Jan 2026 15:27:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C14363C40;
	Fri,  9 Jan 2026 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972446; cv=none; b=GwvZHGQRylKaadJA0PJpYPktaOH0MPtNJzljzlQyV/b5ceWwxxjz7OUfCzJJPUmL4GWpP8Wb2rPF/Kbt60LjT/vsB7mxJ71cvsMPWCQuKe1u9C83eTF5b05lFEOGYf+5W3CtzjHfDqkEMery9avde1o1MTTctWJuALRUHcVL9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972446; c=relaxed/simple;
	bh=Bx4OIlxZ9fXNmZvc7hvZMNqnC7GPcQsrdQ3pEiGPu0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nY61XytCEaWNqelSKHY7a+erCyTxvhPtLfm/n36SgckUVswVwf12H62l0ujKQab6xixsOMra0dTocX6Uuy6O68fVqyvsytqKfP4VOcQDiil9yz1G6aXRq1RsUSWcudumsmcveCci/NTi9bY0UnUU2qkhbBC7YvZ+LmbkkjgEcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sw+0HGFpc+84BA--.1283S2;
	Fri, 09 Jan 2026 23:20:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: nm@ti.com,
	ssantosh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] soc: ti: pruss: fix double free in pruss_clk_mux_setup()
Date: Fri,  9 Jan 2026 15:20:16 +0000
Message-Id: <20260109152016.2449253-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Sw+0HGFpc+84BA--.1283S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DtryrJF48CrWfGFW5Awb_yoWkArXEgr
	4xWFZIqa1UCF47Gry7Jw48Z3sI93ZruF1IkanaqFy3AFyDArn8tF13ZFnxCa9rZrW8Gasr
	Gw1kXFn2yr17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F8l6FkdMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7sRib18PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsCA2lhGJoJYgAAst

In the pruss_clk_mux_setup(), the devm_add_action_or_reset() indirectly
calls pruss_of_free_clk_provider(), which calls of_node_put(clk_mux_np)
on the error path. However, after the devm_add_action_or_reset()
returns, the of_node_put(clk_mux_np) is called again, causing a double
free.

Fix by returning directly, to avoid the duplicate of_node_put().

Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

---
Changes in v2:
- Drop error jumping lable.
---
 drivers/soc/ti/pruss.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index d7634bf5413a..07d5134b503b 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -368,10 +368,9 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 				       clk_mux_np);
 	if (ret) {
 		dev_err(dev, "failed to add clkmux free action %d", ret);
-		goto put_clk_mux_np;
 	}
 
-	return 0;
+	return ret;
 
 put_clk_mux_np:
 	of_node_put(clk_mux_np);
-- 
2.34.1


