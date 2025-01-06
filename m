Return-Path: <stable+bounces-107574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7BA02C8C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F19163D58
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9137E156237;
	Mon,  6 Jan 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8VsCl84"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD6182D2;
	Mon,  6 Jan 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178877; cv=none; b=O04AF+b9u8gaCXaSj+2lX5zbleVMTllFHSI6VsKGQsOHqXVtwOcjfSvozmXAA6jSeLApgoOHeeV2Mm9TgIo6v15jNugR8AE3xXit9SVLa24SDsCAbHjKl5rsgbqsfAOyrt8NqdHqJd+4aZHxVVrwU96eUhm5EY0+i5WZE3Ujz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178877; c=relaxed/simple;
	bh=Od+M1buuAo2g1zR1iazABrapLvv/CsboE1M/5d7BJtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll2Y5JJDX6FmKgGJQQRblG3nQ613of83UnMJmG44luG5+uhXxlAwHWdSXTir6QHfpnVp075QPCqUzKDOcerGZkIYR1ls8StbpVAu5/IKNjCGDhjlkKH77GnEbygjAQVt/gXLRsE8RB7yWbkWSfjzuLAszvLwvWYJIGC/ntABAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8VsCl84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECCC4CED2;
	Mon,  6 Jan 2025 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178877;
	bh=Od+M1buuAo2g1zR1iazABrapLvv/CsboE1M/5d7BJtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8VsCl84k7Son4VHvf40cmiH9WlgErdl4CQA798ewGONd7YecdGqt9YxW4CXKQxbY
	 QZSEA6iUbVOlb3TGL+ooH8dfAkpYVBcelOa+ymIBKOppx5shdLAPtR9bBEcOhVSd/M
	 SLWrZ63daQEhjolYTmVdUjtVuvhOSVsIKGmcAoJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Stefan Ekenberg <stefan.ekenberg@axis.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 122/168] drm/bridge: adv7511_audio: Update Audio InfoFrame properly
Date: Mon,  6 Jan 2025 16:17:10 +0100
Message-ID: <20250106151143.055905241@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Ekenberg <stefan.ekenberg@axis.com>

[ Upstream commit 902806baf3c1e8383c1fe3ff0b6042b8cb5c2707 ]

AUDIO_UPDATE bit (Bit 5 of MAIN register 0x4A) needs to be set to 1
while updating Audio InfoFrame information and then set to 0 when done.
Otherwise partially updated Audio InfoFrames could be sent out. Two
cases where this rule were not followed are fixed:
 - In adv7511_hdmi_hw_params() make sure AUDIO_UPDATE bit is updated
   before/after setting ADV7511_REG_AUDIO_INFOFRAME.
 - In audio_startup() use the correct register for clearing
   AUDIO_UPDATE bit.

The problem with corrupted audio infoframes were discovered by letting
a HDMI logic analyser check the output of ADV7535.

Note that this patchs replaces writing REG_GC(1) with
REG_INFOFRAME_UPDATE. Bit 5 of REG_GC(1) is positioned within field
GC_PP[3:0] and that field doesn't control audio infoframe and is read-
only. My conclusion therefore was that the author if this code meant to
clear bit 5 of REG_INFOFRAME_UPDATE from the very beginning.

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Fixes: 53c515befe28 ("drm/bridge: adv7511: Add Audio support")
Signed-off-by: Stefan Ekenberg <stefan.ekenberg@axis.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241119-adv7511-audio-info-frame-v4-1-4ae68e76c89c@axis.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 61f4a38e7d2b..8f786592143b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -153,7 +153,16 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
 			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
 			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
-	regmap_write(adv7511->regmap, 0x73, 0x1);
+
+	/* send current Audio infoframe values while updating */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), BIT(5));
+
+	regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
+
+	/* use Audio infoframe updated info */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), 0);
 
 	return 0;
 }
@@ -184,8 +193,9 @@ static int audio_startup(struct device *dev, void *data)
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
 				BIT(7) | BIT(6), BIT(7));
 	/* use Audio infoframe updated info */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
 				BIT(5), 0);
+
 	/* enable SPDIF receiver */
 	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
-- 
2.39.5




