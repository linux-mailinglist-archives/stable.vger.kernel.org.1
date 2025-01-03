Return-Path: <stable+bounces-106717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5CA00C9C
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE35164399
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577631FBEA9;
	Fri,  3 Jan 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwFkn84N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDFF1FBE80;
	Fri,  3 Jan 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924671; cv=none; b=lioehr2/58b8NOblLj5mGHdHBDuhAtN1o/x3XW8LRDSH91HrkHTds9ObzmKgVdIRsZV1sZn9drXZWJ3EoLJRvCk9FBQWMLQSWTPRV7hUbvoGbXRI7O1lDKN/DwIUDuPDdUCrUgTDXC3++zpNkh22I3jYUxP8Xr7NSVWfii7D+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924671; c=relaxed/simple;
	bh=W5ce3mPlnsbOdxNzAANNVpIkTu+zyV9ES04CasQbtbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGLIogbIgzFQfxWGQWfN9XaMzgZqWlZkzyeh4k1sfvtrmJvzYVEz56pr/vb+i7TKym+IjoBZAWIFhM3W3/vkXbFBplfTho/MWU3yCs6hpPZdwjpgcginDD76dcDxsbHuY3F6QrBxQ3ZD8kZyIWk29CvYsqnOfuTI+JtHqoUq3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwFkn84N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710AFC4CED6;
	Fri,  3 Jan 2025 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924670;
	bh=W5ce3mPlnsbOdxNzAANNVpIkTu+zyV9ES04CasQbtbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwFkn84NiHOsMKlZhQqlYB/yfWkLX9UvZarzT93Kh2DS+V/IJTfMfqVRdHoUH3jRL
	 YoIluydfJROi/PxBNtgu4Dfd/TQgbwFsXZLy93UbYRFG1FCFIP9xsrRl8BewFIlWAH
	 3xBfPZnNn1sX5acmS90FDCGHpZ3l/mBKkbLqKula/1M41vuRxOQYNsI5IyLgwTkXu3
	 AEQKgLhZhu0SNNKlR5uhL/dXrEAWR1j5vfk+7+gVEfY6LO7ZXE4mq79H12vv3eZxHS
	 FSGRoGcvqI0HCzUoI/Sj7qOTC1NZY9W56b5JTdJAYVjX2n2RYDMyNyicYtwLlM5uWU
	 CA5PM8SmA9wWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shuming Fan <shumingf@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/4] ASoC: rt722: add delay time to wait for the calibration procedure
Date: Fri,  3 Jan 2025 12:17:43 -0500
Message-Id: <20250103171746.492127-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103171746.492127-1-sashal@kernel.org>
References: <20250103171746.492127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit c9e3ebdc52ebe028f238c9df5162ae92483bedd5 ]

The calibration procedure needs some time to finish.
This patch adds the delay time to ensure the calibration procedure is completed correctly.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://patch.msgid.link/20241218091307.96656-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index f9f7512ca360..9a0747c4bdea 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1467,13 +1467,18 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 		0x008d);
 	/* check HP calibration FSM status */
 	for (loop_check = 0; loop_check < chk_cnt; loop_check++) {
+		usleep_range(10000, 11000);
 		ret = rt722_sdca_index_read(rt722, RT722_VENDOR_CALI,
 			RT722_DAC_DC_CALI_CTL3, &calib_status);
-		if (ret < 0 || loop_check == chk_cnt)
+		if (ret < 0)
 			dev_dbg(&rt722->slave->dev, "calibration failed!, ret=%d\n", ret);
 		if ((calib_status & 0x0040) == 0x0)
 			break;
 	}
+
+	if (loop_check == chk_cnt)
+		dev_dbg(&rt722->slave->dev, "%s, calibration time-out!\n", __func__);
+
 	/* Set ADC09 power entity floating control */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_ADC0A_08_PDE_FLOAT_CTL,
 		0x2a12);
-- 
2.39.5


