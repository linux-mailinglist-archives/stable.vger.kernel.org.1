Return-Path: <stable+bounces-81368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29A9931B3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B792B1C23662
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C11D95B3;
	Mon,  7 Oct 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wnEk4ZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0A1D7986
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315842; cv=none; b=nd7kVIC3YjB1mLTrLKE7BDpHWdsugkHlXWcXVWeQiGEw1bQ6S/lIhwsO5AWM6HesIsBkF3Z7N8KpkkhmUnYvYReLmMt26wrRW3SG2joBJLps2JHgXoMXo7iTZu+b5MrYpU3MMZExMAYfN2n+dGRf5xOvnXXenNF94nuG0eYeqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315842; c=relaxed/simple;
	bh=FpNrOcIwuzCA+vxQzW3n9dBP935Le+L5QEK0FiHUJlI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=itVJv7a5JH4GS21NrrVyuk1Wix2iLuRv5n5Sayaf8mbY4aj6v4fvI2j6kf+uSiSwNqJygFnrBgebGsw9yvMviNmWuFmLXno+qV2cTTPOHT9hiYpkrv5FmHOOzyx5Is2Ge4B/6s5AbbE6W+xoUkpPl1jkUqAVgXxE5RfI1UTSIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wnEk4ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB4C4CECF;
	Mon,  7 Oct 2024 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728315842;
	bh=FpNrOcIwuzCA+vxQzW3n9dBP935Le+L5QEK0FiHUJlI=;
	h=Subject:To:Cc:From:Date:From;
	b=0wnEk4ZHfoyjzA1+VkqpDnXuFqg+tBh4JV6ICJX2MS5fHJB2n81e16wSXbmOtRNoc
	 NKfBAKLuEQUH2OvdvW+cNvFxc55qtzuMaWVB9eSAdj0sKveUYFUG1LKzolzkj/6/2R
	 KG3OW48lU3dQK9XP/HOxx6pzUQKMLrzMJWF6s4nE=
Subject: FAILED: patch "[PATCH] clk: imx6ul: fix clock parent for IMX6UL_CLK_ENETx_REF_SEL" failed to apply to 5.4-stable tree
To: Alex.Michel@wiedemann-group.com,abel.vesa@linaro.org,alex.michel@wiedemann-group.com,o.rempel@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:43:55 +0200
Message-ID: <2024100754-wrongdoer-finishing-98b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 32c055ef563c3a4a73a477839f591b1b170bde8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100754-wrongdoer-finishing-98b7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


