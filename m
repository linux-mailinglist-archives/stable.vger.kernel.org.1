Return-Path: <stable+bounces-43340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665678BF1F6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6266AB297FB
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1F149C41;
	Tue,  7 May 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+NQxlV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297E1494D9;
	Tue,  7 May 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123451; cv=none; b=HKJRxddKsosWW1le6CerdOqB4aX0NNnFnhIRYjk6VijOT6IAqlWiAciOSHoep8N21imExNw/ONM03tXi0HgevpuDdlSc0G1v+8Pb41RLhpP1lNsnz8n2k5kBD0miugmnl4gjeOyrwwwCekqIMaph0gjspVo6y2EWMqNuKyubXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123451; c=relaxed/simple;
	bh=8flEoGuR5cknPXB6dawqgRqhe1hzDJzH/am2PZMz4Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjoPoyDgHwlBtUcXqpohP+7xNKAon41c8Hy8lyWJonHAdJzDlcqIBzb/pwKJj6UN8kXEhru6B6D43tVl0F3k+oJXHri0nRwigMA/FeHLMa/0D48pn/U+80j9u0w1JLKPdEvZE7W6Rr69ep80ZvD+yxOW7wr9qmTXNoOTHhSBvhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+NQxlV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBECC4AF63;
	Tue,  7 May 2024 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123450;
	bh=8flEoGuR5cknPXB6dawqgRqhe1hzDJzH/am2PZMz4Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+NQxlV334yFa5vdIs02SeyZDRr7+TdiG5CM0iv+lTLIxIm7fU4uBoINI727efDy6
	 +eMI0JfmYo3Pto9Xg5XcnCR+nsQHL71vsUA+zUJ6Fqu1LuQDOGEmCnQLqOWS0VrV3V
	 a4JfV/G+49lT828Fal1rCdW3fgA0t1hp7MMMybaYOB2CsQ4dmJDGXofIFG7mPoOVxC
	 n57AWx9tlLSqNITqLuYDJTfKIGIrp6X5j8P31Uu3cSmr0sLg5IZOPvRY1+xQAIfe6W
	 TPBpfn6lt0bDFW5X72oqgyU5eL9STDJ/OooRpb5vCe9IcCRdwsZ3HeJWt+Y0gVau+s
	 bqb17uuGg70FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/43] ASoC: rt722-sdca: add headset microphone vrefo setting
Date: Tue,  7 May 2024 19:09:30 -0400
Message-ID: <20240507231033.393285-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 140e0762ca055d1aa84b17847cde5d9e47f56f76 ]

Add vrefo settings to fix jd and headset mic recording issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/727219ed45d3485ba8f4646700aaa8a8@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca.c | 25 +++++++++++++++++++------
 sound/soc/codecs/rt722-sdca.h |  3 +++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index 4338cdb3a7917..9ff607984ea19 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1438,9 +1438,12 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 	int loop_check, chk_cnt = 100, ret;
 	unsigned int calib_status = 0;
 
-	/* Read eFuse */
-	rt722_sdca_index_write(rt722, RT722_VENDOR_SPK_EFUSE, RT722_DC_CALIB_CTRL,
-		0x4808);
+	/* Config analog bias */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_ANALOG_BIAS_CTL3,
+		0xa081);
+	/* GE related settings */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_GE_RELATED_CTL2,
+		0xa009);
 	/* Button A, B, C, D bypass mode */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_UMP_HID_CTL4,
 		0xcf00);
@@ -1474,9 +1477,6 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 		if ((calib_status & 0x0040) == 0x0)
 			break;
 	}
-	/* Release HP-JD, EN_CBJ_TIE_GL/R open, en_osw gating auto done bit */
-	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_DIGITAL_MISC_CTRL4,
-		0x0010);
 	/* Set ADC09 power entity floating control */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_ADC0A_08_PDE_FLOAT_CTL,
 		0x2a12);
@@ -1489,8 +1489,21 @@ static void rt722_sdca_jack_preset(struct rt722_sdca_priv *rt722)
 	/* Set DAC03 and HP power entity floating control */
 	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_DAC03_HP_PDE_FLOAT_CTL,
 		0x4040);
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_ENT_FLOAT_CTRL_1,
+		0x4141);
+	rt722_sdca_index_write(rt722, RT722_VENDOR_HDA_CTL, RT722_FLOAT_CTRL_1,
+		0x0101);
 	/* Fine tune PDE40 latency */
 	regmap_write(rt722->regmap, 0x2f58, 0x07);
+	regmap_write(rt722->regmap, 0x2f03, 0x06);
+	/* MIC VRefo */
+	rt722_sdca_index_update_bits(rt722, RT722_VENDOR_REG,
+		RT722_COMBO_JACK_AUTO_CTL1, 0x0200, 0x0200);
+	rt722_sdca_index_update_bits(rt722, RT722_VENDOR_REG,
+		RT722_VREFO_GAT, 0x4000, 0x4000);
+	/* Release HP-JD, EN_CBJ_TIE_GL/R open, en_osw gating auto done bit */
+	rt722_sdca_index_write(rt722, RT722_VENDOR_REG, RT722_DIGITAL_MISC_CTRL4,
+		0x0010);
 }
 
 int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave)
diff --git a/sound/soc/codecs/rt722-sdca.h b/sound/soc/codecs/rt722-sdca.h
index 44af8901352eb..2464361a7958c 100644
--- a/sound/soc/codecs/rt722-sdca.h
+++ b/sound/soc/codecs/rt722-sdca.h
@@ -69,6 +69,7 @@ struct rt722_sdca_dmic_kctrl_priv {
 #define RT722_COMBO_JACK_AUTO_CTL2		0x46
 #define RT722_COMBO_JACK_AUTO_CTL3		0x47
 #define RT722_DIGITAL_MISC_CTRL4		0x4a
+#define RT722_VREFO_GAT				0x63
 #define RT722_FSM_CTL				0x67
 #define RT722_SDCA_INTR_REC			0x82
 #define RT722_SW_CONFIG1			0x8a
@@ -127,6 +128,8 @@ struct rt722_sdca_dmic_kctrl_priv {
 #define RT722_UMP_HID_CTL6			0x66
 #define RT722_UMP_HID_CTL7			0x67
 #define RT722_UMP_HID_CTL8			0x68
+#define RT722_FLOAT_CTRL_1			0x70
+#define RT722_ENT_FLOAT_CTRL_1		0x76
 
 /* Parameter & Verb control 01 (0x1a)(NID:20h) */
 #define RT722_HIDDEN_REG_SW_RESET (0x1 << 14)
-- 
2.43.0


