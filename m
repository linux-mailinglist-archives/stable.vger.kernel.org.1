Return-Path: <stable+bounces-140322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3572AAA7A1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951299A0A9F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C833A367;
	Mon,  5 May 2025 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY0PhgEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1C33A35E;
	Mon,  5 May 2025 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484634; cv=none; b=GHT38amddC90CvNe+c+S1a09io7oSn/WSQShDydyiXkyQ4gN5hAZVF6GqDGUqGGJsSkW3MT3NNLgjFYpPoH/xUhmsvglcJIr3c0Lo/BusH6nsmXjUXQZS8xQ6sOFnLABm+AeTPHXIwyxp3JOQtT3tPmmoEFNeyp0Kie1j6uY3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484634; c=relaxed/simple;
	bh=lCeP4asWG7VCEWVudbQAEIyefnEQRpHhKbKRC9aG3N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oE9KhwTeCQ1gux9EkV7JnaTHQB26pq6FHQLoTqix+lATpBsIhG7xyYDitxHlWONr6yTKu7r8dH8dcfYMlJ3n7H8+KnbNEI136vMD95/KkQiL7g9qlyMUigBDI0Hdqvu4RVvSC/ThuGH4dUFTJdxgtBF7IEVhUPDy3rxndlBZbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY0PhgEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5795C4CEED;
	Mon,  5 May 2025 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484634;
	bh=lCeP4asWG7VCEWVudbQAEIyefnEQRpHhKbKRC9aG3N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iY0PhgEpoUFSn4QYWzYk7u+5OeOtlSTDgCzPk8pSVubSIl0nYdzLdSaHHA/T70PFV
	 x+004R5NJOS6UvHJlp6ZK7Q96eWlCUJroanMcm36aCxaL6Q2r4v+BlPn57mAwxgrJg
	 oA38oeJAebon4/hBFEvJoBafueuVxiyV4W5iQ0DOg+3q+axuY331iyyisalmvkaML/
	 CuhL+7dFNxGMLnT3OFnX/hTLLwqOmh2LGB0kFRRvlB12JLVhugGLS59SnoJ/qw3I7b
	 Tb5pwxkD7NyKNp1nKjkakoIeq9gZk0+1kKElmg6+95U62AL34D9bJDgYlylR2vWFok
	 PzghgVUDdZJLg==
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
Subject: [PATCH AUTOSEL 6.14 574/642] ASoC: rt722-sdca: Add some missing readable registers
Date: Mon,  5 May 2025 18:13:10 -0400
Message-Id: <20250505221419.2672473-574-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 4d3043627bd04..cfb030e71e5c5 100644
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


