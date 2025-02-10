Return-Path: <stable+bounces-114549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21AA2EDD1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB618853D6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F022F17F;
	Mon, 10 Feb 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwF3NRSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B022F16B
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194220; cv=none; b=c0veNDa1fBeFOhuXo+6wkCnNmcxqqGO8nb2rDyYsdNgmSZt0sZxBULHVRApkdCVG1mEAwNTw7+HadPVsr8q+ZR9moEWnvRr1fXClWgTyhYo+YCH30ui+edFJodvtynT21s7yYvIIaBn9u0m4m1eSRC0jYtHETQKswcTiXSnRxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194220; c=relaxed/simple;
	bh=FYohtqZOQtqmSZurnQB0l60jQUKp4sr8nVG9Z/yNL40=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ROnKxgq6I20zCv+QNXsdbBd/ZGPeYG3Hr9wQnK09razgUJqNPyAp1heQkAxa/UjXNi3VfPi3/Nu0d27uH8cjtRD3bGiv9b45LKoUJPyFPVh11aCpFz2DvIXpbgW58yXF8Sh4Cvm4Ufc+gkS8o9qd5YiDhHdOGvh2k1jC8wCdkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwF3NRSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C1C4CED1;
	Mon, 10 Feb 2025 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739194220;
	bh=FYohtqZOQtqmSZurnQB0l60jQUKp4sr8nVG9Z/yNL40=;
	h=Subject:To:Cc:From:Date:From;
	b=hwF3NRSB59RB+XBBoPit5uatiGsOVuaqYzfvUlNS1OT6Ky04SPMjU1Uju4jaXPbnG
	 D+WFOimlwQ3T/PRaOh13aShi4r+6Dxsh9Bm4mgOeelUJlxEdfgJo6LL30Ltg9p2Ejo
	 ZBdSbCtM5SLELJOqmj8+QCBUuC7ScK9EPc72MNRA=
Subject: FAILED: patch "[PATCH] clk: mediatek: mt2701-bdp: add missing dummy clk" failed to apply to 6.1-stable tree
To: daniel@makrotopia.org,angelogioacchino.delregno@collabora.com,sboyd@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:30:17 +0100
Message-ID: <2025021017-tyke-stiffness-35bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fd291adc5e9a4ee6cd91e57f148f3b427f80647b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021017-tyke-stiffness-35bf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd291adc5e9a4ee6cd91e57f148f3b427f80647b Mon Sep 17 00:00:00 2001
From: Daniel Golle <daniel@makrotopia.org>
Date: Sun, 15 Dec 2024 22:14:24 +0000
Subject: [PATCH] clk: mediatek: mt2701-bdp: add missing dummy clk

Add dummy clk for index 0 which was missed during the conversion to
mtk_clk_simple_probe().

Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/b8526c882a50f2b158df0eccb4a165956fd8fa13.1734300668.git.daniel@makrotopia.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 5da3eabffd3e..f11c7a4fa37b 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -31,6 +31,7 @@ static const struct mtk_gate_regs bdp1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &bdp1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate bdp_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "bdp_dummy"),
 	GATE_BDP0(CLK_BDP_BRG_BA, "brg_baclk", "mm_sel", 0),
 	GATE_BDP0(CLK_BDP_BRG_DRAM, "brg_dram", "mm_sel", 1),
 	GATE_BDP0(CLK_BDP_LARB_DRAM, "larb_dram", "mm_sel", 2),


