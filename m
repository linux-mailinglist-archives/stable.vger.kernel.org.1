Return-Path: <stable+bounces-168600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903DB235E1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B25F6E6B6A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88028000F;
	Tue, 12 Aug 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S1wB+8AL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81E1474CC;
	Tue, 12 Aug 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024711; cv=none; b=KDq9Dvalueukon6TTRprOX/lzyhtXJHQBoqm7hqA0D3x4e0VDD1L7JWk56Pwn+iWwjWrCBXHm2r+nktHCSoz4Dqa6GLtIA718rIY3ntCl2fbrOvIuSFtPI4qSxOxN4bydZrfc2W9ZVqI9NeLwyoiTTRzDeA3sGvhN/5nbcORNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024711; c=relaxed/simple;
	bh=tMNhike4eQJLdtmXzRAKXkwTnOwfX5pk3lv7mOy8dX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0CFdGemAfpx9HPqhbYuE4DApc8sFE/ZTpmOk8w5vmHjPQ1rFwaCCc9p7Txh5VLMirskcGnqvMYQkHJ42LamCN3ynoLjDxYDbJshR8UdzDQgwJJbQtCht2jWtmwOttMGM06b4X7eetxkxp008OjW8zZneFJzI5snpVJVDn+joNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S1wB+8AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F510C4CEF0;
	Tue, 12 Aug 2025 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024711;
	bh=tMNhike4eQJLdtmXzRAKXkwTnOwfX5pk3lv7mOy8dX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1wB+8ALP6/HseTPvPfO7CA4e4iuEk0qz5EoJLOPzfd81RdlgE6c1UlpniYW4+eiM
	 WODcrv28JSDrE+6w5C540U1rmgTnsj2EwBZtQX95z7OZV5MHrD+ghRxwwo54psNONY
	 OobFYFCnKuhexepWFwwvOt5OhKW26mV+YaSK6Dwk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 421/627] ASoC: fsl_xcvr: get channel status data when PHY is not exists
Date: Tue, 12 Aug 2025 19:31:56 +0200
Message-ID: <20250812173435.292296541@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit ca592e20659e0304ebd8f4dabb273da4f9385848 ]

There is no PHY for the XCVR module on i.MX93, the channel status needs
to be obtained from FSL_XCVR_RX_CS_DATA_* registers. And channel status
acknowledge (CSA) bit should be set once channel status is processed.

Fixes: e240b9329a30 ("ASoC: fsl_xcvr: Add support for i.MX93 platform")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20250710030405.3370671-2-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_xcvr.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index e3111dd80be4..405433144515 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1423,6 +1423,26 @@ static irqreturn_t irq0_isr(int irq, void *devid)
 				/* clear CS control register */
 				memset_io(reg_ctrl, 0, sizeof(val));
 			}
+		} else {
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_0,
+				    (u32 *)&xcvr->rx_iec958.status[0]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_1,
+				    (u32 *)&xcvr->rx_iec958.status[4]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_2,
+				    (u32 *)&xcvr->rx_iec958.status[8]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_3,
+				    (u32 *)&xcvr->rx_iec958.status[12]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_4,
+				    (u32 *)&xcvr->rx_iec958.status[16]);
+			regmap_read(xcvr->regmap, FSL_XCVR_RX_CS_DATA_5,
+				    (u32 *)&xcvr->rx_iec958.status[20]);
+			for (i = 0; i < 6; i++) {
+				val = *(u32 *)(xcvr->rx_iec958.status + i * 4);
+				*(u32 *)(xcvr->rx_iec958.status + i * 4) =
+					bitrev32(val);
+			}
+			regmap_set_bits(xcvr->regmap, FSL_XCVR_RX_DPTH_CTRL,
+					FSL_XCVR_RX_DPTH_CTRL_CSA);
 		}
 	}
 	if (isr & FSL_XCVR_IRQ_NEW_UD) {
-- 
2.39.5




