Return-Path: <stable+bounces-185222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A5BD4F96
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B466487E76
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB530F80E;
	Mon, 13 Oct 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXTQVxeB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6230F92A;
	Mon, 13 Oct 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369680; cv=none; b=GYQ48QddjkGA1LvbC5orMXTSRU8RtHUrC0QpbrTEcK0jjWiayfA6+P+6IJwek32XTiGpK+eRNIrxvhupNu1JvtdCPktjddivFIFhrcQ3vno+vImaMp7ICJq+NeYkqoj9GDLlwMELtDMfXJ6xRt0LCuQr9lMwRL40wlUY1K1lCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369680; c=relaxed/simple;
	bh=uDJqEjK5q7EGq0guwt36E67b05ByvMFB/aw68dfdlgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsqYr1lGDjr4jraixgeqNU98XZLSH7CmsC5384jFxmB9OApgtOIBA61QqA0FePwQa5hmYHeCK2pOTiN4uA4BbblU0Uf8mMdv4xW/C4qCV5OsUegmYF7MV54Hs58lI/BzoDAZ9geogZP2A5Ayma+CUuQGB0SBot8dlzURUWrbTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXTQVxeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC98C4CEE7;
	Mon, 13 Oct 2025 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369680;
	bh=uDJqEjK5q7EGq0guwt36E67b05ByvMFB/aw68dfdlgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXTQVxeBsjqff6T9OmEeUt741jMVe+p8wDcVYFE2rfOC+64wrq+fEfeOYiMQOZam+
	 W/Pw77Yt0DW4hI0NoAbiG2zEFkyoaQdx4kK4Fh2O7B7HzfEzBlAcovZnxzYpPPBGU2
	 FGsLeNUh95Gi1wS1qDnZjcGVs3/m24lTrSgkzsnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 331/563] ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
Date: Mon, 13 Oct 2025 16:43:12 +0200
Message-ID: <20251013144423.253534693@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit fba404e4b4af4f4f747bb0e41e9fff7d03c7bcc0 ]

When an invalid value is passed via quirk option, currently
bytcr_rt5640 driver only shows an error message but leaves as is.
This may lead to unepxected results like OOB access.

This patch corrects the input mapping to the certain default value if
an invalid value is passed.

Fixes: 063422ca2a9d ("ASoC: Intel: bytcr_rt5640: Set card long_name based on quirks")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20250902171826.27329-3-tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0f3b8f44e7011..bc846558480e4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -68,7 +68,8 @@ enum {
 	BYT_RT5640_OVCD_SF_1P5		= (RT5640_OVCD_SF_1P5 << 13),
 };
 
-#define BYT_RT5640_MAP(quirk)		((quirk) &  GENMASK(3, 0))
+#define BYT_RT5640_MAP_MASK		GENMASK(3, 0)
+#define BYT_RT5640_MAP(quirk)		((quirk) & BYT_RT5640_MAP_MASK)
 #define BYT_RT5640_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5640_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
 #define BYT_RT5640_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
@@ -140,7 +141,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk NO_INTERNAL_MIC_MAP enabled\n");
 		break;
 	default:
-		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to DMIC1_MAP\n", map);
+		byt_rt5640_quirk &= ~BYT_RT5640_MAP_MASK;
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
 		break;
 	}
 	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1)
-- 
2.51.0




