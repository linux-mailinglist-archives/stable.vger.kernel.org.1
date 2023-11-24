Return-Path: <stable+bounces-2435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E052C7F842A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83796B27CC8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB733381D2;
	Fri, 24 Nov 2023 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e2zwR8tT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861691A5A4;
	Fri, 24 Nov 2023 19:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4CC433CB;
	Fri, 24 Nov 2023 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853875;
	bh=Tn5VGOCDvY1zEVfedxy6lkxxf9DN2ZPOdmqo4Rm8Axw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2zwR8tTZpkmSV/JZf61rff81CJ618AHxOD/OwTjXyYJWwmiI/y2NWOoUq60Nr7sK
	 5A6FzLXkzqsihHNZGwZGaYBZ/U3GHoUnNEn1s8Pl+1oW3fF5tuy5CRzIupm94nSw6b
	 QJ+z0itza55sHxbAWAizU2XF2X5VIE6y0V3OYmpc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Kemnade <andreas@kemnade.info>,
	Tony Lindgren <tony@atomide.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/159] ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings
Date: Fri, 24 Nov 2023 17:54:18 +0000
Message-ID: <20231124171943.637302241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit fbb74e56378d8306f214658e3d525a8b3f000c5a ]

We need to check for an active device as otherwise we get warnings
for some mcbsp instances for "Runtime PM usage count underflow!".

Reported-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20231030052340.13415-1-tony@atomide.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-mcbsp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 3273b317fa3b9..3e8ed05f3ebd8 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -74,7 +74,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return -EINVAL;
 	}
 
-	pm_runtime_put_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_put_sync(mcbsp->dev);
 
 	r = clk_set_parent(mcbsp->fclk, fck_src);
 	if (r) {
@@ -84,7 +85,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
 		return r;
 	}
 
-	pm_runtime_get_sync(mcbsp->dev);
+	if (mcbsp->active)
+		pm_runtime_get_sync(mcbsp->dev);
 
 	clk_put(fck_src);
 
-- 
2.42.0




