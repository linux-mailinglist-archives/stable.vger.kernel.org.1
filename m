Return-Path: <stable+bounces-147737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDBAC58F6
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A951B9E01FF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E89527FD76;
	Tue, 27 May 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SOYvcov7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8AF2566;
	Tue, 27 May 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368274; cv=none; b=HZKNE3/aoMNPH8ftueRTkFQ8fagvt4wEe4pO+F5V5OZs2A/6qDiKakiWR58pK/W+BZvkClAJ3Dk/xQ3Xv355zgJDZtn1pjcaim3zeaKdSLdPkNEJuTm8oS9MOJDsC+OGboqvNX7mqyBPbyTHm0GLMzF9Env2/w96oKVC0747DXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368274; c=relaxed/simple;
	bh=6RBqwCDxWrOJUFtByhwRlPHQSq61Jc4uo7h8xq2XRcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws/POgTlsx2G6teTyNuCeW3GQrMP+aHUPFhB6VFHHxtuqQZww8IvoAduDF9GevlVOsGw3jawK4XaiQ3AfrGVOIAlVFFKU/kbnwjUyza5ALD280B0QkaHsty/z6zfRuD/aOueKPxHvkAKCFSeCY2etW4mkT6SUaUqWr2cn7XmdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SOYvcov7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A15C4CEEB;
	Tue, 27 May 2025 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368273;
	bh=6RBqwCDxWrOJUFtByhwRlPHQSq61Jc4uo7h8xq2XRcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOYvcov7QGESeHEM1PqT01+2f+WPSIvJM9seXHYNsS5OIbXRPR6pjOXJH8J6vPwyT
	 iQkk5lNZb+v7rulRbndMcDQg3hkTfiJtJUX2sEove+41Y4n+TqCR1qbfC6gMCQYNtm
	 2GGt8P1Jdgla/bckL6qldEtneh6wMSgFmtDYP86U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 655/783] ASoC: Intel: bytcr_rt5640: Add DMI quirk for Acer Aspire SW3-013
Date: Tue, 27 May 2025 18:27:32 +0200
Message-ID: <20250527162539.800798065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a549b927ea3f5e50b1394209b64e6e17e31d4db8 ]

Acer Aspire SW3-013 requires the very same quirk as other Acer Aspire
model for making it working.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220011
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250420085716.12095-1-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 6446cda0f8572..0f3b8f44e7011 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -576,6 +576,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{       /* Acer Aspire SW3-013 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW3-013"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
2.39.5




