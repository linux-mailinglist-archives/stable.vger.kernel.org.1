Return-Path: <stable+bounces-131159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E5A80853
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107B14C509B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF426E17E;
	Tue,  8 Apr 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J87sCIHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB9126E166;
	Tue,  8 Apr 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115648; cv=none; b=CKjCwthvM0IBFNiEJ3Ay3oF3tHxcFhnSaTwRoPUBV3qlGHGSoKH3emyFsaFnwdFSh0616n4lAYIglNbnjPlDE21IDfhAGWO2rYev3U/yKYJqm1RAIJjym54pnBdmhTuJBh9lrK3hsHWHx5flsQylsPngHyRNFoqw4d69w1F7Hi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115648; c=relaxed/simple;
	bh=HfPtBaexnRoo/SMYd3pnAJoE9sF9U+ybRNyGvb/zKKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK5Nxag2NNm2snFTb2+KvZkOPMgC6SOOxgMXC1F366VOrwpSZ4WcVH0S8uY8qDDC/lbGrG8Lq8lpnWUClf4ozkiLjpg8OGLuaD2sDQMmfsL1xPm0JL+lwxQWTO58XBRVLOKrtGjVR+X/Qe0vgeaoY5foBiNON/4lpt2wwY0G3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J87sCIHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F022C4CEE5;
	Tue,  8 Apr 2025 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115648;
	bh=HfPtBaexnRoo/SMYd3pnAJoE9sF9U+ybRNyGvb/zKKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J87sCIHdip/aTKa5Kj49OTjXc/tqC57DoWWesR52Pt0sHwjJWwyGaH+A0+/j7Ir/v
	 peM96rybizFP4r2CoXLAiVwnUJmMeZ1y78UfY2fh1CWMI1hLiS1NAEfGqH/JmeDgSl
	 mgIxnSGZdl/h54G30UEba0Vvd4ROIcn7dwiF/uE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/204] clk: amlogic: gxbb: drop incorrect flag on 32k clock
Date: Tue,  8 Apr 2025 12:49:42 +0200
Message-ID: <20250408104821.869411943@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit f38f7fe4830c5cb4eac138249225f119e7939965 ]

gxbb_32k_clk_div sets CLK_DIVIDER_ROUND_CLOSEST in the init_data flag which
is incorrect. This is field is not where the divider flags belong.

Thankfully, CLK_DIVIDER_ROUND_CLOSEST maps to bit 4 which is an unused
clock flag, so there is no unintended consequence to this error.

Effectively, the clock has been used without CLK_DIVIDER_ROUND_CLOSEST
so far, so just drop it.

Fixes: 14c735c8e308 ("clk: meson-gxbb: Add EE 32K Clock for CEC")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20241220-amlogic-clk-gxbb-32k-fixes-v1-1-baca56ecf2db@baylibre.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 608e0e8ca49a8..48c47503ea752 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1310,7 +1310,7 @@ static struct clk_regmap gxbb_32k_clk_div = {
 			&gxbb_32k_clk_sel.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.39.5




