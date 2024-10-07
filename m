Return-Path: <stable+bounces-81366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75249931B7
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703F1B24F23
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EA01D95AA;
	Mon,  7 Oct 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dES0iHP7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C081D7986
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315835; cv=none; b=jRM57oqbRphV+K2p3+i+c+jOuIebZ0iq4OPBIBs2tYg4iRjoxZF7epIsNoo32tLQ8VRhl3zZ6PsSyv4nnU1puSChn3X1vdfVsQzSX1QGMrtLzSljYBbCaO3kqHoEPlDvsdSJ1Y6A3zBl7JaYPsQrUK1KAmZCbPPbdEbm5M6brJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315835; c=relaxed/simple;
	bh=iLOc7wAAaYAROW/WSUClUY2jralCdN+64GKoeYfM/5A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=THSvkLd2qBAgrMQ9qF50vB/YVJZJmZ1dSItR45b5QakZ+MQ5j/W5w3vOOAfZvKjjKmJUeUWqWS01xO1EdWkIyfYUtuqOOf0MJ+jFzeeXYhfqZScoBj2C5g1RMAbrfVJ99eKdUQYtg5IAQnf1w4trrlkb1MiKzKxi4Sb9Myf8oMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dES0iHP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C964AC4CEC6;
	Mon,  7 Oct 2024 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315835;
	bh=iLOc7wAAaYAROW/WSUClUY2jralCdN+64GKoeYfM/5A=;
	h=Subject:To:Cc:From:Date:From;
	b=dES0iHP7BJngX9TBNH+FqBu7ZeDKlKJT6MiH0s796pnJtCEF5mRqpHDGuqTwaA4Is
	 jIP7Of2MBq7nYc4hKyU8LTLJPz6IcveDL9dwCFBD/npm+mCqrQYwX86Mh2bfj5qEAs
	 WkWIpoupAVEUgF1wj8YRMhgLXuBxstoYWcxXVWRw=
Subject: FAILED: patch "[PATCH] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL" failed to apply to 5.15-stable tree
To: Alex.Michel@wiedemann-group.com,abel.vesa@linaro.org,alex.michel@wiedemann-group.com,o.rempel@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:43:49 +0200
Message-ID: <2024100747-elevating-mobster-a3cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 32c055ef563c3a4a73a477839f591b1b170bde8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100747-elevating-mobster-a3cf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

32c055ef563c ("clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL")
912d7af473f1 ("clk: imx6ul: retain early UART clocks during kernel init")
4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
5f82bfced611 ("clk: imx6ul: fix enet1 gate configuration")

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


