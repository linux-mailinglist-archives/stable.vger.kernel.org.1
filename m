Return-Path: <stable+bounces-62245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1B93E77C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7441284308
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380979B99;
	Sun, 28 Jul 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y670VLp6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83C4F8BB;
	Sun, 28 Jul 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182745; cv=none; b=JcODH/HWmd5lC1aAf+9oDXPTKXvC7CO30wXYO4SQaFNfUNP5Q3ZoboDRN1km5MQmTO+ahIF4KjmyKDcETJXp/RY5lRKX15SguTxxIw0ABazfqDVzhaOtxsoXxNId7YV8VzaOK07emcHreRKQhw8ts3f+S6OJ3wVtbHJD+uvYYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182745; c=relaxed/simple;
	bh=xwVtkJUeRlDwxnmbUOFPYWdDGzfaMGXt5evdhgS8qUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StamRJiOEs0fnDoL4NVEdG7bSj3parmFaFSTvDcC8bidO4yOZ3bUy1sef1rUVPBb2ZSD5ol3jhhLkIyxjT/9Z0doF4AdMmoBjmIR51URAFQA0EzOBXEEnwqVL2GNH0nbhr6FEa9Il/weD3DYMmkVAeYVsaXDSVCr7nVC5SlSOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y670VLp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3184AC116B1;
	Sun, 28 Jul 2024 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182745;
	bh=xwVtkJUeRlDwxnmbUOFPYWdDGzfaMGXt5evdhgS8qUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y670VLp6k40ie1STd0ROQDNw5dIRi725/eAxCjdnHe5gwRCRKnsQbqTXwpeDSNm3C
	 9GiUkCB9aihunr4RzFSl8h3KUSDGS8np4j+kiRS+08ogzaLmGjBJd9xZApVHJN9R58
	 X2QQwtWNVWJkoHCFIuAqq8kb1G1ixWQ7J2xLWvvZd1pgdJ4S0lU+Dt5ZSds8XL7sRB
	 VUwWFpV0bHETPSLzOZZXUYMGA029gP5Je4nLcjbvDn3KB47JhHx/6rB71/rlxy3Jqz
	 gLyYwZwvxv6fYOgzYFthebvCxY7xHRkwMCJWzqs15fx8VaQppwPhpTSEZj6annpiMp
	 dJkwBFvnfNkCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 02/23] ASoC: Intel: sof_sdw: Add quirks for some new Dell laptops
Date: Sun, 28 Jul 2024 12:04:43 -0400
Message-ID: <20240728160538.2051879-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 91cdecaba791c74df6da0650e797fe1192cf2700 ]

Add quirks for some new Dell laptops using Cirrus amplifiers in a bridge
configuration.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://msgid.link/r/20240527193552.165567-11-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index e41b0d95e0ff7..a878b6b3d1948 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -505,6 +505,22 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(RT711_JD2),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE3")
+		},
+		.driver_data = (void *)(SOF_SIDECAR_AMPS),
+	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE4")
+		},
+		.driver_data = (void *)(SOF_SIDECAR_AMPS),
+	},
 	{}
 };
 
-- 
2.43.0


