Return-Path: <stable+bounces-14116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C8837F93
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5E01F299C7
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891F6169B;
	Tue, 23 Jan 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q30vYIPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065686169A;
	Tue, 23 Jan 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971201; cv=none; b=nmZxJ/s6Zi++k0lHrYZoYVXrCFUBtfWLpM88NwkojMKr31NTTjLhUs2gKpnI+1AG2clzNFKBbvUCQ1TO4rBO9AOn20W8Vldfn9vKcEd8yitk0nN4s34LRYFfA7nv0OBnRYKgiqaMMfkLb+E9mPAN0AWZgL7z9315c/LB+UJtzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971201; c=relaxed/simple;
	bh=NXUBXeyJ44oBp+UEhODs+XmNLqrlC4/n+CijdLty36I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8SwO/McSAbKFsKAGdl+00t/lBtWSJJbP6yt2fsTa80/2gouku+1W8qNDd767Bca0qfWxevWoPCTViFJxGfN2+QlfC0up/1NGi7XXZwYNE85dlLDNOgW433QqPx83oa0paUtFYWoZELqcGpmUsrk9P1BmQ8jbfDt9ENytGtEdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q30vYIPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB4DC433A6;
	Tue, 23 Jan 2024 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971200;
	bh=NXUBXeyJ44oBp+UEhODs+XmNLqrlC4/n+CijdLty36I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q30vYIPgq4dci41qRjUY8CzIAvIL+WwLstqf+U7C9afWN/5PQaxcpD7VVWadSUJ2B
	 k4/+a9740zZJLtnPhwRmf+MYiBLDmeuliAFh1sLGA8YNVKbir6w4r8tIQdBQx/vY6C
	 8+JN9xLUBProkgLfohTVDI2sdPX7FLbecS4RFhsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 203/417] clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
Date: Mon, 22 Jan 2024 15:56:11 -0800
Message-ID: <20240122235758.963236024@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 5f9e29b9159a41fcf6733c3b59fa46a90ce3ae20 ]

Code in rzg2l_cpg_reset() is equivalent with the combined code of
rzg2l_cpg_assert() and rzg2l_cpg_deassert(). There is no need to have
different versions thus re-use rzg2l_cpg_assert() and rzg2l_cpg_deassert().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120070024.4079344-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: da235d2fac21 ("clk: renesas: rzg2l: Check reset monitor registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 38 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 84767cfc1e73..93720f319409 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1115,29 +1115,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
 
-static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
-			   unsigned long id)
-{
-	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 we = dis << 16;
-
-	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
-
-	/* Reset module */
-	writel(we, priv->base + CLK_RST_R(reg));
-
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
-	/* Release module from reset state */
-	writel(we | dis, priv->base + CLK_RST_R(reg));
-
-	return 0;
-}
-
 static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
@@ -1168,6 +1145,21 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	int ret;
+
+	ret = rzg2l_cpg_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+	udelay(35);
+
+	return rzg2l_cpg_deassert(rcdev, id);
+}
+
 static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
-- 
2.43.0




