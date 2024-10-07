Return-Path: <stable+bounces-81364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A419931B0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC001F2119C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578061D958B;
	Mon,  7 Oct 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P43hytiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C81D9337
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315829; cv=none; b=CV1DETqKr1He8OGL8QCEPlTimwtnUfThPqHUezUR3Sof6cxmdszzwt3CA/xp23/XQ2On8SYttllTt8+RhCsMSDa1PYldWJH8th2m1oC08wBsv3fjYR4TKTclPXEtQKJezInYR+nGtYSFNP/eeO8Th+zbgOcxHsBJsMtPyXmmB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315829; c=relaxed/simple;
	bh=faAjx2Loz+YP2cx6TbiHN3DwYbLDz6J/UKYih/mKENE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LEvwePwTnGGW3Mhyb2reNOi6Ok3A/pdSakQ3oR/Ir5AfNDtW+lCrVOj9cCjJkeXyJL1ejIYJtX18bEoTMyLCYERfxB48se9G4Cx3H8GB6a8F9F+VfNmTinHMUMvrPvNKdGN4dIdQ3fhKtq0MuxZdpLiVKA8PPFAdfrlhV0EMJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P43hytiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39872C4CEC6;
	Mon,  7 Oct 2024 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315828;
	bh=faAjx2Loz+YP2cx6TbiHN3DwYbLDz6J/UKYih/mKENE=;
	h=Subject:To:Cc:From:Date:From;
	b=P43hytiEKEXw83G3j5qghShV09EHs6X1tR2G7pc2Nem/EItgsirR8NAPr1ag21W8C
	 +WSQc3aE/vj+z7RJVMIvCyjFk+OQxNVWD4ZpG+Rxg8MYQfrlmsHM9iHpk0gWpz4xAn
	 FgdibcUWKKNT0YsBf+6gth072xSioacxZYLemjgQ=
Subject: FAILED: patch "[PATCH] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL" failed to apply to 6.6-stable tree
To: Alex.Michel@wiedemann-group.com,abel.vesa@linaro.org,alex.michel@wiedemann-group.com,o.rempel@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:43:42 +0200
Message-ID: <2024100741-grit-briskness-675a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 32c055ef563c3a4a73a477839f591b1b170bde8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-grit-briskness-675a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

32c055ef563c ("clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32c055ef563c3a4a73a477839f591b1b170bde8e Mon Sep 17 00:00:00 2001
From: Michel Alex <Alex.Michel@wiedemann-group.com>
Date: Mon, 2 Sep 2024 09:05:53 +0000
Subject: [PATCH] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL

Commit 4e197ee880c24ecb63f7fe17449b3653bc64b03c ("clk: imx6ul: add
ethernet refclock mux support") sets the internal clock as default
ethernet clock.

Since IMX6UL_CLK_ENET_REF cannot be parent for IMX6UL_CLK_ENET1_REF_SEL,
the call to clk_set_parent() fails. IMX6UL_CLK_ENET1_REF_125M is the correct
parent and shall be used instead.
Same applies for IMX6UL_CLK_ENET2_REF_SEL, for which IMX6UL_CLK_ENET2_REF_125M
is the correct parent.

Cc: stable@vger.kernel.org
Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/AS1P250MB0608F9CE4009DCE65C61EEDEA9922@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index f9394e94f69d..05c7a82b751f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -542,8 +542,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(hws[IMX6UL_CLK_ENFC_SEL]->clk, hws[IMX6UL_CLK_PLL2_PFD2]->clk);
 
-	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET_REF]->clk);
-	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET1_REF_SEL]->clk, hws[IMX6UL_CLK_ENET1_REF_125M]->clk);
+	clk_set_parent(hws[IMX6UL_CLK_ENET2_REF_SEL]->clk, hws[IMX6UL_CLK_ENET2_REF_125M]->clk);
 
 	imx_register_uart_clocks();
 }


