Return-Path: <stable+bounces-106720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EE2A00CA5
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2261884A9B
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A21FBEA9;
	Fri,  3 Jan 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkgmYv/1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87D21FCCE0;
	Fri,  3 Jan 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924679; cv=none; b=lG8kQIiLBKWs5fb0dJ4k5OiJxWMF1j2aig6820ZaITG2K95Umt//DzTjkGlI6SRtxwBb9Y5gn1356lyxMu/H40uv1ghKUTUMHV6hjdtFuiR6u6ppcLjMaEUUQWi3Nrpw0gIoZxk29TRUiGevxLmoKOpeFo/88NztLwJBmaRiaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924679; c=relaxed/simple;
	bh=lgf+gwcB0+J7jS3lMRVlWwG6l9n4ty0mxF/NSDXrJGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UWGwHRbTgB9wp3l59L5s/KJKzOKTT+0iH/ETe4UPgS9pNxCDpm8eX9SaIhap0mv3Ew/ta3YNmdwoH6mgSw8bg2gNUVKLzVHWZVHHkJmW7uPZEK0Nkf8URjyWxbuLuhjH2Vms9m0Yhx4BbIHIo0Hi2eBE37bsj47g034FI9VtELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkgmYv/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0ADC4CECE;
	Fri,  3 Jan 2025 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924679;
	bh=lgf+gwcB0+J7jS3lMRVlWwG6l9n4ty0mxF/NSDXrJGY=;
	h=From:To:Cc:Subject:Date:From;
	b=jkgmYv/19Fi3AKxKSzFOTPDeW/Av8AAmSeJzPEFNk/gBfEs9NT0a12QZybiQdUaqw
	 xs2oY4H1K96hIKuOqNVsel/AT4IuKG5YRfrjqxf7mtVx3ICkGhlWfx83YWhRHaOcqQ
	 XCZE5jlLmubDrB9PZ9aUO6vicGimw0sm3dt8mkoiTp/p8MPPIzTAM3HyxgSZFcQk7W
	 9QzHIQebqUjL1bqeRQ5eOicUDVnygK544/BcFbAvZQ4hQRVUdhCK05ZLuf8iZBtu7b
	 X3O6z+8TcANSjpic1ZJS+kBYMIzE8CHbH5qN1FoGS8WgcH4wC3uFl8FeLws4bnH2W7
	 YMFAnwrVeodrQ==
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
Subject: [PATCH AUTOSEL 6.6 1/3] ASoC: rt722: add delay time to wait for the calibration procedure
Date: Fri,  3 Jan 2025 12:17:54 -0500
Message-Id: <20250103171756.492191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.69
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
index b9b330375add..0f9f592744ad 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1466,13 +1466,18 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
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


