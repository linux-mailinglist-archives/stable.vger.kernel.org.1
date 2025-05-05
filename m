Return-Path: <stable+bounces-141459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DDAAB383
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F555176EE8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0CA298262;
	Tue,  6 May 2025 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ6qvVcA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1C239E71;
	Mon,  5 May 2025 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486353; cv=none; b=KUIiZYmz5a3yfICdBSzHDkIIJVKe3CwX5Vsn4Co/RO3F5YkLJQ0Ywj5N5rgSDcMT93+rbCfyIiqxw8+naBlXB1x7WFFRIru1cOUNISdToriJpP1Ayv5OKm7tFZN0k2p2j0ujLK32udsQCKKldlGJJq8zOjjjiwzoTseax5u4gCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486353; c=relaxed/simple;
	bh=zeqisvW8BXWVJ6urW1OBGJzYoRnVb8dvb7S/BOriN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsBMxSxb/JALHXpx4fzaby+Zuqgw1csL76yV3Wz5Y2jTUJEObPR7m2OI+BS94jj1XCwNM5IcSIkYDZem/lBTW+WocKNrzLKGjYS7ALX8p+T3mHIH2oAJzyP5TThp+YXb9z8bj1cErikQekPYue8Kkdea2W5bXI/ZM0kayLqxoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ6qvVcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D1FC4CEEF;
	Mon,  5 May 2025 23:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486352;
	bh=zeqisvW8BXWVJ6urW1OBGJzYoRnVb8dvb7S/BOriN2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQ6qvVcA43poQre0syV1c3hoMhClpicgklMl2YSRWOGz1oAc4JLrzKbIbcA+Mr1/z
	 TR0KwzYmZNNs2MX8lt1FSw9va6DL+9wUWgdln5yvNbnE88NiiBXRXL3P84n9fSDgt8
	 V7ABmhLhv2hf8LVj1VEK6nU2TWOLNdlJ8t8MltL4L4EStsyr0KYFGAn5FzR8j5saEA
	 JvL18THTCan4TBybuG+5o9/AzRU9i8Ncl7+0xojGVPF9TucM5ph8BVC4nonhAk1arP
	 mYUs0s+hNvIE498ElTFhK1Z6ZYT/4r/InIC0qcs4F1H4vdP9z8ib9nS9jpueF2dg37
	 b3lhpXmR2QUSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Shuming Fan <shumingf@realtek.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 275/294] ASoC: rt722-sdca: Add some missing readable registers
Date: Mon,  5 May 2025 18:56:15 -0400
Message-Id: <20250505225634.2688578-275-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit f9a5c4b6afc79073491acdab7f1e943ee3a19fbb ]

Add a few missing registers from the readable register callback.

Suggested-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Link: https://patch.msgid.link/20250107154408.814455-6-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca-sdw.c | 49 +++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index c382cb6be6025..c0bb1b4b2dcb5 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -28,9 +28,50 @@ static bool rt722_sdca_readable_register(struct device *dev, unsigned int reg)
 			0):
 	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_GE49, RT722_SDCA_CTL_DETECTED_MODE,
 			0):
-	case SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01, RT722_SDCA_CTL_HIDTX_CURRENT_OWNER,
-			0) ... SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
-			RT722_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_XU03, RT722_SDCA_CTL_SELECTED_MODE,
+			0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05,
+			  RT722_SDCA_CTL_FU_MUTE, CH_L) ...
+	     SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05,
+			  RT722_SDCA_CTL_FU_MUTE, CH_R):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_XU0D,
+			  RT722_SDCA_CTL_SELECTED_MODE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F,
+			  RT722_SDCA_CTL_FU_MUTE, CH_L) ...
+	     SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F,
+			  RT722_SDCA_CTL_FU_MUTE, CH_R):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE40,
+			  RT722_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE12,
+			  RT722_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS01,
+			  RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS11,
+			  RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E,
+			  RT722_SDCA_CTL_FU_MUTE, CH_01) ...
+	     SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E,
+			  RT722_SDCA_CTL_FU_MUTE, CH_04):
+	case SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_IT26,
+			  RT722_SDCA_CTL_VENDOR_DEF, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_PDE2A,
+			  RT722_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_CS1F,
+			  RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
+			  RT722_SDCA_CTL_HIDTX_CURRENT_OWNER, 0) ...
+	     SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
+			  RT722_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06,
+			  RT722_SDCA_CTL_FU_MUTE, CH_L) ...
+	     SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06,
+			  RT722_SDCA_CTL_FU_MUTE, CH_R):
+	case SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_OT23,
+			  RT722_SDCA_CTL_VENDOR_DEF, CH_08):
+	case SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_PDE23,
+			  RT722_SDCA_CTL_REQ_POWER_STATE, 0):
+	case SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_CS31,
+			  RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0):
 	case RT722_BUF_ADDR_HID1 ... RT722_BUF_ADDR_HID2:
 		return true;
 	default:
@@ -74,6 +115,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x5600000 ... 0x5600007:
 	case 0x5700000 ... 0x5700004:
 	case 0x5800000 ... 0x5800004:
+	case 0x5810000:
 	case 0x5b00003:
 	case 0x5c00011:
 	case 0x5d00006:
@@ -81,6 +123,7 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x5f00030:
 	case 0x6100000 ... 0x6100051:
 	case 0x6100055 ... 0x6100057:
+	case 0x6100060:
 	case 0x6100062:
 	case 0x6100064 ... 0x6100065:
 	case 0x6100067:
-- 
2.39.5


