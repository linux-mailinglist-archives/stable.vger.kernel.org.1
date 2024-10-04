Return-Path: <stable+bounces-81114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6A990FCC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D571B29D49
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE80230239;
	Fri,  4 Oct 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9p00HvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B078230230;
	Fri,  4 Oct 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066726; cv=none; b=NXRCygMaHkfPdbBRhQfOoGWApcfwA1jExtBOiNfiQxUpvavD7NBP/NomthyymxJ7LX+C3LpzF4oVexbeKMEnUmSfoTSBRicfhxjKeNHYdrzo2ShpCw4CvNv4u4diEy05R47Sh/lfKg/Z7OFl5hKMuMVRejg20OzBkDrtNTpsQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066726; c=relaxed/simple;
	bh=cIudPX+z8eB+rsul2HwYMPjgwGJNYwI7JcPY7jOIuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXmeNerNFHRN0hZGnRwKN9JrPSR2wDm31K+LFDapR4tw7i7dLbLbJpPPD/TgTAk/1d1gCoDEyOdFFvs4Fok/X77k0BY5sXW+QiMpOwmQMeYrL0Y81zYOzilmyhdY0Xsav9Z5uGNuyAwlEE4B64Ez+MakDuH7nEGJy7jGpc/lEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9p00HvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19630C4CECC;
	Fri,  4 Oct 2024 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066725;
	bh=cIudPX+z8eB+rsul2HwYMPjgwGJNYwI7JcPY7jOIuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9p00HvBGwTz1GJPNjqgGHyx/zKjnvUVrYd3pSx/sWQkIVu9ILTPXhB/CTqq7EUrB
	 K0iwi6kSq3DC4vNU+TrDXwDlxm501qyzOylIj8jgleueEINXM/vU0IzRaFQTC1iPNr
	 v3pa/RIP3NLa4KG54JGhmUwlniF8gma1hbvInLfTxjh2a4PLdvLE/aQFOuBeMMPy1L
	 fwjHKSY0AwVjvyH/+B+CEApnx4XKMLO4r4K/39316plRdO86YEBASdeo7sSRag8pRX
	 QXgBETW49PGNqN99XPb+ODN0uAV6MmVkHutANq0gk3VGGg9xbxeTu2qqDsj/LYnpOl
	 0bmXHxNv8mrAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/16] clk: bcm: bcm53573: fix OF node leak in init
Date: Fri,  4 Oct 2024 14:31:36 -0400
Message-ID: <20241004183150.3676355-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit f92d67e23b8caa81f6322a2bad1d633b00ca000e ]

Driver code is leaking OF node reference from of_get_parent() in
bcm53573_ilp_init().  Usage of of_get_parent() is not needed in the
first place, because the parent node will not be freed while we are
processing given node (triggered by CLK_OF_DECLARE()).  Thus fix the
leak by accessing parent directly, instead of of_get_parent().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240826065801.17081-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/bcm/clk-bcm53573-ilp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm53573-ilp.c b/drivers/clk/bcm/clk-bcm53573-ilp.c
index 36eb3716ffb00..3bc6837f844db 100644
--- a/drivers/clk/bcm/clk-bcm53573-ilp.c
+++ b/drivers/clk/bcm/clk-bcm53573-ilp.c
@@ -115,7 +115,7 @@ static void bcm53573_ilp_init(struct device_node *np)
 		goto err_free_ilp;
 	}
 
-	ilp->regmap = syscon_node_to_regmap(of_get_parent(np));
+	ilp->regmap = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(ilp->regmap)) {
 		err = PTR_ERR(ilp->regmap);
 		goto err_free_ilp;
-- 
2.43.0


