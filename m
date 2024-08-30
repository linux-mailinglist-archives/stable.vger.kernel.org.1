Return-Path: <stable+bounces-71658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F89966439
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2659A282235
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F01B1D78;
	Fri, 30 Aug 2024 14:32:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8412F59C;
	Fri, 30 Aug 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028335; cv=none; b=nUZnwYCTA7GulkRJVjpXHkg8NpY+uGew3Kgt9LOS9XfMRWJjohuqKK7C3QVp37PAnbS+hyPzfE41bqiR1V9vFoZWmX8dhv0JWEvGqUhvDcVs5NxKBYtprjfEkkAz/7j4Ql3swOHYqzIOIlUn1sQRih2/QfwJV3rmuSUd5l692SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028335; c=relaxed/simple;
	bh=EQPfdMGpmy4y59m3UT+tPKNiDni+BRn+4R2jOhZFPiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R6TAoY1PsBzDg7ThUfcDRGFZDayArxTG3mKO5XYTCvYgNkh4i2T2oQ3C/Ejm1cnQ/RbD1pWFU71Htx9VQJfKO5gEsn7uccW0ZteSNrnkMBXizvytwCrk505EPXCzqqgyASRgsZjfip/uFhRT2c4WXVLGkkkvXWNxWnqMQwnoz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABnTTje19FmE_x+Cw--.16418S2;
	Fri, 30 Aug 2024 22:32:02 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	derek.fang@realtek.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: rt5682: Return devm_of_clk_add_hw_provider to transfer the error
Date: Fri, 30 Aug 2024 22:31:54 +0800
Message-Id: <20240830143154.3448004-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnTTje19FmE_x+Cw--.16418S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWrGF4UGw45ZFyfKry8Krg_yoWDGrbEya
	y8uayjqryDGr4Ik39rJF4Yy3WvvryfCrW2vr1jganxGryxJr13tF17JFy3Z3Z8Xrs7tF15
	CF17trWFgrySyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
fails due to resource allocation failure or device tree clock provider
registration failure.

Cc: stable@vger.kernel.org
Fixes: ebbfabc16d23 ("ASoC: rt5682: Add CCF usage for providing I2S clks")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 sound/soc/codecs/rt5682.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index e3aca9c785a0..aa163ec40862 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2903,8 +2903,10 @@ int rt5682_register_dai_clks(struct rt5682_priv *rt5682)
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 						    dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name,
-- 
2.25.1


