Return-Path: <stable+bounces-114548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDC9A2EDC6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D97188525F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957B22E402;
	Mon, 10 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WTQKFtaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039B2206B0
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194210; cv=none; b=PkpuuYHCqDnKCuFs92MtR+8/QWNpkpyr7O9OWGic4+OpmyG5G0xCIUJ4kUVVsX0gsa7lf9JPy8/2SkLe9gBow+SS4FFJ+bnkkOtc3sz78DovnGmcCdOdVjB8ZjykzInhQbYdLt8X2invU9QwoDWnu9l5GvHQYD8oBf9re2jEG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194210; c=relaxed/simple;
	bh=iOgLS6GH1AtFf5yowBj5lJ4cryAtfLkVppCV93uEf1M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=akfY763umOkar3P24vJYHNrQ8o9z0LN41Awz7Y67zQvtRQ7mQPI53nSyb8SJs+1w/fmZL1Vu3Xuh4AQ36TIr9rGeZHMxi+i1x2TbXNj2aJdcWrpjik3VacK8Qu//sNPhBM9gCHuHeS68yAZCEuGu3Aq7NyBZhbr7LJbOtKjgCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WTQKFtaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9B0C4CED1;
	Mon, 10 Feb 2025 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739194210;
	bh=iOgLS6GH1AtFf5yowBj5lJ4cryAtfLkVppCV93uEf1M=;
	h=Subject:To:Cc:From:Date:From;
	b=WTQKFtajY5oFrUxQ8nMsnyQOe+CGBzyYMS6KSBPBRg90eNR9MzXH4kyKTpONWUDke
	 SfT7NbJXouAq7DNrZx4GCXwf/+CvF8EZFC1ayYKkU4sTt435Rrk2E0RFNKatz/47QZ
	 SGxH6Lxnl8g+4jVnIcwWuCDBMQPs+/f5Shbgcea8=
Subject: FAILED: patch "[PATCH] clk: mediatek: mt2701-vdec: fix conversion to" failed to apply to 6.1-stable tree
To: daniel@makrotopia.org,angelogioacchino.delregno@collabora.com,sboyd@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:29:49 +0100
Message-ID: <2025021049-dipper-royal-a0b9@gregkh>
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
git cherry-pick -x 7c8746126a4e256fcf1af9174ee7d92cc3f3bc31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021049-dipper-royal-a0b9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c8746126a4e256fcf1af9174ee7d92cc3f3bc31 Mon Sep 17 00:00:00 2001
From: Daniel Golle <daniel@makrotopia.org>
Date: Sun, 15 Dec 2024 22:13:49 +0000
Subject: [PATCH] clk: mediatek: mt2701-vdec: fix conversion to
 mtk_clk_simple_probe

Commit 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to
simplify driver") broke DT bindings as the highest index was reduced by
1 because the id count starts from 1 and not from 0.

Fix this, like for other drivers which had the same issue, by adding a
dummy clk at index 0.

Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index 94db86f8d0a4..5299d92f3aba 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -31,6 +31,7 @@ static const struct mtk_gate_regs vdec1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
 
 static const struct mtk_gate vdec_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "vdec_dummy"),
 	GATE_VDEC0(CLK_VDEC_CKGEN, "vdec_cken", "vdec_sel", 0),
 	GATE_VDEC1(CLK_VDEC_LARB, "vdec_larb_cken", "mm_sel", 0),
 };


