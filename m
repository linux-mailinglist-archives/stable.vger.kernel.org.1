Return-Path: <stable+bounces-203402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BACDDDC8
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 15:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D7A30142E8
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80914BF92;
	Thu, 25 Dec 2025 14:33:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C111397;
	Thu, 25 Dec 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766673198; cv=none; b=E+7K3/fvxW/HC0MzIiT9yl+tJlWcvB7m1CBuEDzKWG86iBW/rbpHbQgqHWr2zWTQUB3QDeHMzHbSZFAcrYCeLrlZ9i2JfY4wBTxKActkthD8C8zRaa/yXEts1vpWMj2gPdSt06grmZYCZqBV91PY68Pug5u8v1PlPJF6b1Iz26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766673198; c=relaxed/simple;
	bh=cmB8PjYqQS7IWaOs2HMtb81S8czNoLvS4OBgodkcD5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrlPoGNnmBlT0RalSmP2wTngyOoyEgJjEnLJ3m5rE1Y5ddzFQdlM/kvymXHy7qaMLwd2XNqIZeC30KaSPMsnDuXYkGyMB3aQJnHGdGtI+hllHfZ4dempUeWoEeyiTyPXPndISEe8qoGuApcDtYBCl7wrJU64ABrIMjuhYcxakUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAXMNciS01pfPn4AQ--.15897S2;
	Thu, 25 Dec 2025 22:33:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: nm@ti.com,
	ssantosh@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] soc: ti: pruss: fix double free in pruss_clk_mux_setup()
Date: Thu, 25 Dec 2025 14:32:56 +0000
Message-Id: <20251225143256.2363630-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXMNciS01pfPn4AQ--.15897S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DtryrJF48Zr48JFy7Wrg_yoWkWrgEgr
	4rWFW3Xw4UGF47Gry7Jr48Zrna93ZF9F1xCan2vFy3AFyDArn8tF45ZFnrCr9rZrW8Ga47
	Gw1kZ3W8try7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F8l6FkdMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjfUUYFADUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsHA2lM61TPgQAAsc

In the pruss_clk_mux_setup(), the devm_add_action_or_reset() indirectly
calls pruss_of_free_clk_provider(), which calls of_node_put(clk_mux_np)
on the error path. However, after the devm_add_action_or_reset()
returns, the of_node_put(clk_mux_np) is called again, causing a double
free.

Fix by using a separate label to avoid the duplicate of_node_put().

Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/soc/ti/pruss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index d7634bf5413a..c16d96bebe3f 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -368,13 +368,14 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 				       clk_mux_np);
 	if (ret) {
 		dev_err(dev, "failed to add clkmux free action %d", ret);
-		goto put_clk_mux_np;
+		goto ret_error;
 	}
 
 	return 0;
 
 put_clk_mux_np:
 	of_node_put(clk_mux_np);
+ret_error:
 	return ret;
 }
 
-- 
2.34.1


