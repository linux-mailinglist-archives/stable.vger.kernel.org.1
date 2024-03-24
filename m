Return-Path: <stable+bounces-29656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73218888EA2
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133041F345C7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35725200111;
	Sun, 24 Mar 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8dVn4gI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E71E6F50;
	Sun, 24 Mar 2024 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320856; cv=none; b=Y8oaCwRk5dCBp0NC3cckkpv0kbAPKV2+3DotEyhiQ6v9K6a6UeM54vWEpqq/+MY+9cIG/8d6sh5ANDRtaFbnhoYIlioZ5DaT/3577qbWSZ+FW2xqix9gcx+w0Dxnm9xPHYlFHqFWatOnYAUkcXjEGDK+UjAY2rzQr4bMianhVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320856; c=relaxed/simple;
	bh=15la2HOP4BZJOz/HljR3aeBvlmkYLsdL1e3Rm1CDSGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqM2CHcPmDv799Gr1CtcFTaqE66IlIhwxjVNGjtcPAgm699H0NA5j9/P1z3cUIfbFOAf/KNERw7Rm8Hyg08KTC9e6uiOQFNOigsvQ2/YzJhDDqZyXzYpm+7hH+KdKGgYPdxG+c//R0CbgDSkDWdbAOtiIAZsyOzT8tG7BJVoH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8dVn4gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08CC433C7;
	Sun, 24 Mar 2024 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320855;
	bh=15la2HOP4BZJOz/HljR3aeBvlmkYLsdL1e3Rm1CDSGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8dVn4gISlcmW9uGs4vdG/eBtwz1/LuGk4PLlwcWp5xkW60GM3FcwrzsuHbALxpCz
	 IFZ3BL/ml5J1tB1gdDPVTZNG4c4RQsE4BaVsOnIjMyUdW49UkaODTfc3A207GGKOHs
	 z5vWHXgM/yqy0mKbKDLFoLuSUiXxyUM5+NBqn9dOBf/gBFemPg6k9oeAMOeLbVr+lp
	 5ErgZNfdGFoNpuUASr3cuVo8kTRQbNNkam1qnXTblOwifj6vqNBmB7O5Xoj8sUN+ve
	 fRG4JkSn55TOV+mYH7wl1rZ+FZI9AFgac4V4dF/oAz2WCSSoBUhY+BcgYY7JMHm3Wl
	 NAbZ1oJxN4l6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 419/713] ASoC: sh: rz-ssi: Fix error message print
Date: Sun, 24 Mar 2024 18:42:25 -0400
Message-ID: <20240324224720.1345309-420-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 14cf1a41fb0d1..9d103646973ad 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1015,7 +1015,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
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


