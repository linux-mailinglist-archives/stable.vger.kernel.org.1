Return-Path: <stable+bounces-54880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13669913915
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF69E1F21BE3
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B945A4D5;
	Sun, 23 Jun 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="1/6wsBso"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DB3AC1F;
	Sun, 23 Jun 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719132703; cv=none; b=q2TDRy1Cs9Nvj0iHkcoblztPRhOYXGbsnDu6mVKI8hX1O5JRWwmM6dBFZKV3GLemZAvyvII0DySVH+sN9a0d+nzsEVBCor3GVZqyQdul1Or2G5qnCYYgVuN4P2NV1J+2eiENImVrH7eqwPtUx7uMw5WH5rWG0aga/NxHT6ne2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719132703; c=relaxed/simple;
	bh=/MbTc5IrzQ+vqZwxbntKS8rLbbH4xOE6FLZfVgj6O04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uAR9QldAN9hhTg8nPcIn1QF2nLyXjV51DZFxdPVxwqOvitx+hr+R2jxCDMqGAgzzQaihokmHH+DpLNlsRyCqJKxlwLsYq620YOKn3eodb4F63w3WW90wDiZREVAb6rhVYCSlOQJAvaU/vb4ZFB5xr7JCF+rhdcsyC6iVWc2FlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=1/6wsBso; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W6Pp3012bz9sdT;
	Sun, 23 Jun 2024 10:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1719132379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wt2mGoI760pT5VMOq6V2aEAJ75svBaYqL2cmxLmHat0=;
	b=1/6wsBsoXw9MhiP3LTPhgn32X0RW4xqZ9NqZokA5hIumFYs2RdRWYfn4JrHiYJtWbynzba
	BPjY4Doiovu9UYj5FP3y9PmNRsY5fhj47WWxxd16cV3zUpTF5fIMgUSGKonigbTUVNp6m6
	flrYpSdFVk5lIwiDBwrdp4KWREIxqvfzbaTlyF7orI0CAZqIwM4LLlF8vYuZ77O3xZKGc6
	aCbkekiPPpJNOfOHjhUAUOoImcWyit5LJ/RABgAahjppnSsd8bJVP2EqVA3QWX8zGVIrhK
	7pA7RpuD7XCfoAoE58FpswNWhr2iHH7cgpzHd9vFl0THchWOwQIMQ89AP0Rqcw==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Sun, 23 Jun 2024 10:45:58 +0200
Subject: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw
 without common
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
X-B4-Tracking: v=1; b=H4sIAMXgd2YC/x2MWwqAIBAArxL7nWD2MLpKhJSttR+toRRCdPekz
 4GZeSBiIIwwFA8EvCmS5wxVWYDdZ95Q0JoZlFSN7JQS8eJEgjfjKBnrj8OzOYNfULSd1rbGptf
 OQu7PgNn53+P0vh9hoB8SawAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: =?utf-8?q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Robert J. Pafford" <pafford.9@buckeyemail.osu.edu>, stable@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=/MbTc5IrzQ+vqZwxbntKS8rLbbH4xOE6FLZfVgj6O04=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBmd+DXrOE3LcA6aYi57bl6p32pUr0kuFo+nsrWf
 /LS/2jw7RmJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZnfg1wAKCRCaaaIIlErT
 x0GVC/4vLLhNxs05792lSZo5ox+4SDMVmuSHieQ5Me/oS7yC6CJMsBXkm8fFJSJk1YtNkC7QQve
 2ykhrFUbI7IrbBwDrNQFaLFjDJt2YlsSDvpY2AQQyiJa4jx2g59N6gpjV3hgSveyijb3vb+DcA7
 kOgB/Zddcp56czKp4TXsHa0nSQ+2DwQn4Cpe8Ss6cwJxWrKgzWN8duGS38t7NV5i8MiInW/ELmB
 lo4kvF5oAAPW75eCP2DY9P3mcdnPZWDBTmFvhkL0S44HuhL/mUAwtlUdDfF9hleI/m3TIyn7y8b
 9USZYyJmsKGLuYf88CoCnIM+R4npW1DwWESH5lN3JS9d03lz0Md/r0YCTJOZx/6651cYaqGwVJY
 lM4i4GtcKV7o6La5+Sb9EGzffxE+HRnXLeeoi3eSrIbAIFdPHCFlAnv0XWHF0CIMGW7BY9h4nlo
 rdgetJ1y4ZZlBhdcQnzMOXjTuyBr4KGWPDj+7yNqwtmdDux43bQl90/vQ113xxsIhFkcw=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

In order to set the rate range of a hw sunxi_ccu_probe calls
hw_to_ccu_common() assuming all entries in desc->ccu_clks are contained
in a ccu_common struct. This assumption is incorrect and, in
consequence, causes invalid pointer de-references.

Remove the faulty call. Instead, add one more loop that iterates over
the ccu_clks and sets the rate range, if required.

Fixes: b914ec33b391 ("clk: sunxi-ng: common: Support minimum and maximum rate")
Reported-by: Robert J. Pafford <pafford.9@buckeyemail.osu.edu>
Closes: https://lore.kernel.org/lkml/DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com/
Cc: stable@vger.kernel.org
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
Robert, could you please test if this fixes the issue you reported.

I'm CC'ing Måns here, because he observed some strange behavior [1] with
the original patch. Is it possible for you to look into if this patch
fixes your issue without the need for the following (seemingly
unrelated) patches:
      cedb7dd193f6 "drm/sun4i: hdmi: Convert encoder to atomic"
      9ca6bc246035 "drm/sun4i: hdmi: Move mode_set into enable"

Thanks,
  Frank

[1]: https://lore.kernel.org/lkml/yw1xo78z8ez0.fsf@mansr.com/
---
 drivers/clk/sunxi-ng/ccu_common.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index ac0091b4ce24..be375ce0149c 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -132,7 +132,6 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 
 	for (i = 0; i < desc->hw_clks->num ; i++) {
 		struct clk_hw *hw = desc->hw_clks->hws[i];
-		struct ccu_common *common = hw_to_ccu_common(hw);
 		const char *name;
 
 		if (!hw)
@@ -147,14 +146,21 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, struct device *dev,
 			pr_err("Couldn't register clock %d - %s\n", i, name);
 			goto err_clk_unreg;
 		}
+	}
+
+	for (i = 0; i < desc->num_ccu_clks; i++) {
+		struct ccu_common *cclk = desc->ccu_clks[i];
+
+		if (!cclk)
+			continue;
 
-		if (common->max_rate)
-			clk_hw_set_rate_range(hw, common->min_rate,
-					      common->max_rate);
+		if (cclk->max_rate)
+			clk_hw_set_rate_range(&cclk->hw, cclk->min_rate,
+					      cclk->max_rate);
 		else
-			WARN(common->min_rate,
+			WARN(cclk->min_rate,
 			     "No max_rate, ignoring min_rate of clock %d - %s\n",
-			     i, name);
+			     i, clk_hw_get_name(&cclk->hw));
 	}
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,

---
base-commit: 2607133196c35f31892ee199ce7ffa717bea4ad1
change-id: 20240622-sunxi-ng_fix_common_probe-5677c3e487fc

Best regards,
-- 
Frank Oltmanns <frank@oltmanns.dev>


