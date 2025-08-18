Return-Path: <stable+bounces-169955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F0B29E80
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDBA34E27C8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5015930F81E;
	Mon, 18 Aug 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHiyF4rj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C473278146
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510923; cv=none; b=anxEbJDxZ95lTQ2JgVBCCGvCMaymzTkhyRDOObgDOmj4xMiRUjnIBWVL6DX7oDziYtVskYVLARjoRaAgnJNVQY+u8Ymkj6DF9FkxYXCaql+0fijy0YrRPYx+7t3dH2os8iYXegkiJGL9WogNN2+81J/6t+Ctxic/z+RE7qG7E2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510923; c=relaxed/simple;
	bh=RkfJjqptkVgB9z7B+NpMaGZ8EEBgKTzdVdoPQ8E0PeA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BwUhOUdp1q/NdvaJ6annCw7KiVmI1eT093ZkJrfpaHdibHbRnGJ4vtgV2a+UHAurdEbmegBkojPow5Bo3QqN2auMLAYLqld2Hp5Ku5TOfVHs1nVAPyaO0N7MyNekamfgq03ec5IgTBSJXsYiAzM3ZJw1q3og0P61AQLlG0wF2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHiyF4rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76CEC4CEEB;
	Mon, 18 Aug 2025 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755510922;
	bh=RkfJjqptkVgB9z7B+NpMaGZ8EEBgKTzdVdoPQ8E0PeA=;
	h=Subject:To:Cc:From:Date:From;
	b=rHiyF4rjp9822N04lKwrA3hcYzBkSrcchAuWskD9Vg6cvdvWM2AQbrmQ+YzAAy09y
	 Mn68kMNfDuhTejjKUOl8LwpCSR3fJ4QYHJhEkkHXVSBtOpULDIr+1LntZ/ZwS1m0Iq
	 BQdAeGU8e1EFhhkiJyM0yohO/I9IzG1aPE6vzo+0=
Subject: FAILED: patch "[PATCH] clk: imx: Fix an out-of-bounds access in" failed to apply to 6.15-stable tree
To: xiaolei.wang@windriver.com,Frank.Li@nxp.com,sboyd@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 11:55:10 +0200
Message-ID: <2025081810-dinner-pancake-ae44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x b2be1327a6ed74fbf7e1ac0bc6ca57750f7ebe07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081810-dinner-pancake-ae44@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b2be1327a6ed74fbf7e1ac0bc6ca57750f7ebe07 Mon Sep 17 00:00:00 2001
From: Xiaolei Wang <xiaolei.wang@windriver.com>
Date: Thu, 19 Jun 2025 14:21:08 +0800
Subject: [PATCH] clk: imx: Fix an out-of-bounds access in
 dispmix_csr_clk_dev_data

When num_parents is 4, __clk_register() occurs an out-of-bounds
when accessing parent_names member. Use ARRAY_SIZE() instead of
hardcode number here.

 BUG: KASAN: global-out-of-bounds in __clk_register+0x1844/0x20d8
 Read of size 8 at addr ffff800086988e78 by task kworker/u24:3/59
  Hardware name: NXP i.MX95 19X19 board (DT)
  Workqueue: events_unbound deferred_probe_work_func
  Call trace:
    dump_backtrace+0x94/0xec
    show_stack+0x18/0x24
    dump_stack_lvl+0x8c/0xcc
    print_report+0x398/0x5fc
    kasan_report+0xd4/0x114
    __asan_report_load8_noabort+0x20/0x2c
    __clk_register+0x1844/0x20d8
    clk_hw_register+0x44/0x110
    __clk_hw_register_mux+0x284/0x3a8
    imx95_bc_probe+0x4f4/0xa70

Fixes: 5224b189462f ("clk: imx: add i.MX95 BLK CTL clk driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Link: https://lore.kernel.org/r/20250619062108.2016511-1-xiaolei.wang@windriver.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 25974947ad0c..cc2ee2be1819 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -219,11 +219,15 @@ static const struct imx95_blk_ctl_dev_data lvds_csr_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const char * const disp_engine_parents[] = {
+	"videopll1", "dsi_pll", "ldb_pll_div7"
+};
+
 static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
 	[IMX95_CLK_DISPMIX_ENG0_SEL] = {
 		.name = "disp_engine0_sel",
-		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
-		.num_parents = 4,
+		.parent_names = disp_engine_parents,
+		.num_parents = ARRAY_SIZE(disp_engine_parents),
 		.reg = 0,
 		.bit_idx = 0,
 		.bit_width = 2,
@@ -232,8 +236,8 @@ static const struct imx95_blk_ctl_clk_dev_data dispmix_csr_clk_dev_data[] = {
 	},
 	[IMX95_CLK_DISPMIX_ENG1_SEL] = {
 		.name = "disp_engine1_sel",
-		.parent_names = (const char *[]){"videopll1", "dsi_pll", "ldb_pll_div7", },
-		.num_parents = 4,
+		.parent_names = disp_engine_parents,
+		.num_parents = ARRAY_SIZE(disp_engine_parents),
 		.reg = 0,
 		.bit_idx = 2,
 		.bit_width = 2,


