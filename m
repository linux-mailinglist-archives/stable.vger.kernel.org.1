Return-Path: <stable+bounces-104297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991A9F2684
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6886165863
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0951C3F1C;
	Sun, 15 Dec 2024 22:14:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F21C3C1B;
	Sun, 15 Dec 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300898; cv=none; b=Lpk7EK0tOuebnMWJw4fZpD3zirfUcmyJSq0dhHWzUTsGV9qeW8JSwaM8EhYEmp6ab3D31zKIY7IWuAc11bptM4pJZLcZsp84kH7prB5z7I1iMaMpaZYp7iMCDlp77ixj1A/eSqk/L1E4uP4X/7gs035VgHzS1aaNRozvlWUj2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300898; c=relaxed/simple;
	bh=2nqemttgkTjflMavG2hIYuV83csL9Tep3vpKPFJ5wBI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLgcB8BcRSrsSQH4sAYSDCJbG9Ba8KLl4sHSqP6Wzt9gR2p3DO4dcHCXa1pEuvNE8Q99oUA6pxOb9c5DFhF27aa249AXU+qCGXAYHznvI6UvDGz2y7zZAahDhgG9BNNjE21ht4BefFIlxtWprxZtHcxs3bwVEH23HGz3Awb+E8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tMwt1-000000002sx-1oNs;
	Sun, 15 Dec 2024 22:14:51 +0000
Date: Sun, 15 Dec 2024 22:14:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Golle <daniel@makrotopia.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Miles Chen <miles.chen@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH 5/5] clk: mediatek: mt2701-img: add missing dummy clk
Message-ID: <d677486a5c563fe5c47aa995841adc2aaa183b8a.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org>

Add dummy clk for index 0 which was missed during the conversion to
mtk_clk_simple_probe().

Fixes: 973d1607d936 ("clk: mediatek: mt2701: use mtk_clk_simple_probe to simplify driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt2701-img.c | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.47.1

