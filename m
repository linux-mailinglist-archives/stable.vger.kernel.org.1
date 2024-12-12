Return-Path: <stable+bounces-101895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AA9EEF8E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380F5175D20
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354A8226866;
	Thu, 12 Dec 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCBlFB/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18A217640;
	Thu, 12 Dec 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019188; cv=none; b=SJOHLk2Oz3c67N6oFheysbU8ZgrNXkvYPo0x441W5V3GmZHRy3nXBOd7QXJK4qq6zCpNJNNf37uB31TgLSM0zT898izrJR4W9Q+euPk/W2RyWzfizm5F4u7n1eemM7t9y51PRDObRxS9EaBdUi5xXRKWPvNmRPzyav6ydTRb2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019188; c=relaxed/simple;
	bh=N1+l6MGPkLYnyMWzCZVWzM+LW7G+y7gjUastS9rVp5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7+v6jSsFU4SsMcZshki1KJnRhNfuQUpcX74hECZH9/7z/uZR8+T0DKRHhR3OaFPgK8zr7XQqxFwyAs6sNPjuZG97+bn9BwVXHtpgQ0J6Mwa/y1+0dCVqu0PukOononznnGU8ek+zQhbjfAOx7yESDPt8M6+bB4fojYIt0V4zhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCBlFB/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4222C4CECE;
	Thu, 12 Dec 2024 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019187;
	bh=N1+l6MGPkLYnyMWzCZVWzM+LW7G+y7gjUastS9rVp5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCBlFB/1WkP+fbPWsipdOdAKsxoRdCAhstXCzK1SwJAi6SRhmsMaZkok6Ngr3L6Is
	 q/q5rmktEqyY2//ekI5PoXW+su5TyMjGUjhQuYrCZNIvs7ALHJISZUD+Wy2HQUzXK9
	 ++5Ug/AQbPcJUMmj3I3QIEXG9fPUSPAPIKOHyu9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 142/772] ASoC: fsl_micfil: fix regmap_write_bits usage
Date: Thu, 12 Dec 2024 15:51:27 +0100
Message-ID: <20241212144355.799758036@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 06df673d20230afb0e383e39235a4fa8b9a62464 ]

The last parameter 1 means BIT(0), which should be the
correct BIT(X).

Fixes: 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://patch.msgid.link/1727424031-19551-2-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 3a03f49452fa3..6fa900302aa82 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -563,7 +563,7 @@ static irqreturn_t micfil_isr(int irq, void *devid)
 			regmap_write_bits(micfil->regmap,
 					  REG_MICFIL_STAT,
 					  MICFIL_STAT_CHXF(i),
-					  1);
+					  MICFIL_STAT_CHXF(i));
 	}
 
 	for (i = 0; i < MICFIL_FIFO_NUM; i++) {
@@ -598,7 +598,7 @@ static irqreturn_t micfil_err_isr(int irq, void *devid)
 	if (stat_reg & MICFIL_STAT_LOWFREQF) {
 		dev_dbg(&pdev->dev, "isr: ipg_clk_app is too low\n");
 		regmap_write_bits(micfil->regmap, REG_MICFIL_STAT,
-				  MICFIL_STAT_LOWFREQF, 1);
+				  MICFIL_STAT_LOWFREQF, MICFIL_STAT_LOWFREQF);
 	}
 
 	return IRQ_HANDLED;
-- 
2.43.0




