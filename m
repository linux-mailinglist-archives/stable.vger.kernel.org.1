Return-Path: <stable+bounces-114550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B58A2EDE6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC13A2349
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7D522FF3D;
	Mon, 10 Feb 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COb26gMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AF22FF39
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194232; cv=none; b=qODqvYe1LlLPXDShCmfIHFdHXXuuMnvO1ZZQg8LjP1Rbqwb2lw5TzVVheW+5UM3c05HuBqqdEC/MeUBu+wf3k8tOMOjGoQIPQHxA5GKix2Xb0RGpDtjp6PyHeFth5K8DMG6jrXjlTAdlg2c1FKgjQ9YW8bhOmGHlbgEOKWcghA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194232; c=relaxed/simple;
	bh=kQZT3Z73eLI4a5LkXe/ihIhifWjj2LE5PDXbGO6XqzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lJ6aASVaFLuwrDudMxzkwrfPtep45BYPpDiHbPV+ZabuWumaeXJ1oMS4rveG0K/YVyQKaRuRTRcnY0kNTxRoDz5Yf2mBVYFo31AKeNWl3AyUSKrMxbqk+Oo9T6E3mvFUXSWnHINC9jUUTBUW5cxhAycTykdBdMNVkHyBBBMkQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COb26gMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD3BC4CEDF;
	Mon, 10 Feb 2025 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739194231;
	bh=kQZT3Z73eLI4a5LkXe/ihIhifWjj2LE5PDXbGO6XqzU=;
	h=Subject:To:Cc:From:Date:From;
	b=COb26gMn18mnyPijbWxhDoitrU/juGK2iWKhmzDmg6b8I7pgf+K6SL2TKrdoppok4
	 cowXkdEl8TPR9YguU07BK5G04Rsh+JtuFpzsYLhxoJQZSky54Y5Yv4pZp1+ntEU48V
	 oqJlkHR0ttRtGFdZW9YyYiDk5saJx1eb7e6IRuaM=
Subject: FAILED: patch "[PATCH] clk: mediatek: mt2701-img: add missing dummy clk" failed to apply to 6.1-stable tree
To: daniel@makrotopia.org,angelogioacchino.delregno@collabora.com,sboyd@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:30:28 +0100
Message-ID: <2025021028-sanctity-giving-9e31@gregkh>
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
git cherry-pick -x 366640868ccb4a7991aebe8442b01340fab218e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021028-sanctity-giving-9e31@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 366640868ccb4a7991aebe8442b01340fab218e2 Mon Sep 17 00:00:00 2001
From: Daniel Golle <daniel@makrotopia.org>
Date: Sun, 15 Dec 2024 22:14:48 +0000
Subject: [PATCH] clk: mediatek: mt2701-img: add missing dummy clk

Add dummy clk for index 0 which was missed during the conversion to
mtk_clk_simple_probe().

Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>

diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 875594bc9dcb..c158e54c4652 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -22,6 +22,7 @@ static const struct mtk_gate_regs img_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate img_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "img_dummy"),
 	GATE_IMG(CLK_IMG_SMI_COMM, "img_smi_comm", "mm_sel", 0),
 	GATE_IMG(CLK_IMG_RESZ, "img_resz", "mm_sel", 1),
 	GATE_IMG(CLK_IMG_JPGDEC_SMI, "img_jpgdec_smi", "mm_sel", 5),


