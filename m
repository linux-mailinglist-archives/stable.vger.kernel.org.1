Return-Path: <stable+bounces-78815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A298D51A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE81C215CA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14B1D014A;
	Wed,  2 Oct 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSa73O5O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82B1D0403;
	Wed,  2 Oct 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875611; cv=none; b=b56l9bUGm56uZsisfl3RGHt+ITlhngcb2hg4O3Sq3q0xG7EIxtRvNONjGrPxATnQUmEAmEsjh0nfpPwY3z4ilvUDX+63onomjclGYgqfMs2BDrpqqdsLHC4gtGekJTw8JnCqSuE+qWEbZrDX0PDRl3cKeL2Wz+SJfZTYC4MXLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875611; c=relaxed/simple;
	bh=Fa2o0rhrjxY0JGnOexv/j6mQEqXq7BZ9kRGHPK94OoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1L1RjjCYQMJY16op2k0p52Ha6C7i3sKU2SGi7e9Yw7mX8QWMBSgS3ZmLWFfUmdhOvHEELTaS0YmYeuCCtJ//MdKmrkA4jefvLCJSX+wDzIuDK67hkVC29vqK8eb+I88I5MlR6fLMZpfyUqtkGBYqxz1ucV6FhoLtQDCud3jFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSa73O5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D65C4CECF;
	Wed,  2 Oct 2024 13:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875611;
	bh=Fa2o0rhrjxY0JGnOexv/j6mQEqXq7BZ9kRGHPK94OoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSa73O5OrrAMXwNmCwzSbzXg6YmVr+hiYjPdKOyX+xPtA2NDJijYaayb8bL0+7fhJ
	 RahiyORqOG3M04o8eT9/2HHkAZkCUY6ggq7H529H3G1TMeQrRTu1ebo+Rj/cKmVsBC
	 Pdxc2qnuzH+viTs8mCgicHGJbmsG/Nk885SGx1I4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 161/695] ASoC: rt5682s: Return devm_of_clk_add_hw_provider to transfer the error
Date: Wed,  2 Oct 2024 14:52:39 +0200
Message-ID: <20241002125828.902461013@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 3ff810b9bebe5578a245cfa97c252ab602e703f1 ]

Return devm_of_clk_add_hw_provider() in order to transfer the error, if it
fails due to resource allocation failure or device tree clock provider
registration failure.

Fixes: bdd229ab26be ("ASoC: rt5682s: Add driver for ALC5682I-VS codec")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Link: https://patch.msgid.link/20240717115436.3449492-1-make24@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index f50f196d700d7..ce2e88e066f3e 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -2828,7 +2828,9 @@ static int rt5682s_register_dai_clks(struct snd_soc_component *component)
 		}
 
 		if (dev->of_node) {
-			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, dai_clk_hw);
+			if (ret)
+				return ret;
 		} else {
 			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
 							  init.name, dev_name(dev));
-- 
2.43.0




