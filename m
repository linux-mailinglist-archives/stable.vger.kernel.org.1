Return-Path: <stable+bounces-30098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41B988897B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E444E1C2802F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945815CD59;
	Sun, 24 Mar 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyJYNvzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B020CDFC;
	Sun, 24 Mar 2024 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321644; cv=none; b=TnA4uVTygHGIWa0uIZ7Fa1F9RC2tHNoZqARjMM02FmGwfV9cLB7ogWPA2j+1vQGn6EZdknPfsCCVFajUM2yn60LvIoMZ6vZll8D/A2IUjIz6aAIhYWiUGlEuc00fy8ZqZRtoh9VNEDD5uM16xE9Ohc/7myA1cdhSzi4qD7iGPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321644; c=relaxed/simple;
	bh=VWoRI8HI5jc97HNcSrQ3QN+FQJpLPEqAeA5mAa2NeLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAnEpH/jppS/77C4wUxfx1ZVlrTlPyXe+H0ItoizZNWnUux6VUhod+7jHC3/BmgD3qilKjFqutFCCS/ppdzzQX45oPBoUUUyA9yhkAVCW0RHTJS1FB3O5ToRj5luC1CnPIl0WI+GlNQ0zPrtyB6aa+Gh68A7y5hfxCksQ3u5q+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyJYNvzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DCEC433F1;
	Sun, 24 Mar 2024 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321643;
	bh=VWoRI8HI5jc97HNcSrQ3QN+FQJpLPEqAeA5mAa2NeLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyJYNvzcEySImswkFaPtR40C0FTTBMp2bR/1r35odWLCZz+kWNF0gmnC1Ejqh26A4
	 0f8LnKA1UFYId82jeIxjyifFWUWESEdXw0Lmn/IjyM10UmRaWQ76rgs2FKpdce3ZhY
	 rHSqb9rglZqFTslqc5aN5UgA9KyfxjeiH4Nr2HtCwHpL8jGrqVSANpkwJWZ0OFOD7X
	 kV7JLPv8gr2DqaiDoLut5e+jy1KEgvEJCx2/E8EreB37dlWTv6OhkTp3iifmyYIQv4
	 6n/QJdAJMYpklu+Sb4ZUoBVq8atttn2c5DTLh8iw0XQaCD+r1uZMy03ZBPN6v21kIV
	 h2yzykNNvGD8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 372/638] ASoC: sh: rz-ssi: Fix error message print
Date: Sun, 24 Mar 2024 18:56:49 -0400
Message-ID: <20240324230116.1348576-373-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 9a6d7c4fb2801b675a9c31a7ceb78c84b8c439bc ]

The devm_request_irq() call is done for "dma_rt" interrupt but the error
message printed "dma_tx" interrupt on failure, fix this by updating
dma_tx -> dma_rt in dev_err_probe() message. While at it aligned the code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Fixes: 38c042b59af0248a ("ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://msgid.link/r/20240130150822.327434-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index fe79eb90e1e5c..1588b93cc35d0 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1016,7 +1016,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					       dev_name(&pdev->dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(&pdev->dev, ret,
-						"irq request error (dma_tx)\n");
+						     "irq request error (dma_rt)\n");
 		} else {
 			if (ssi->irq_tx < 0)
 				return ssi->irq_tx;
-- 
2.43.0


