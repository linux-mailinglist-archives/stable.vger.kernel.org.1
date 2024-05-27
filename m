Return-Path: <stable+bounces-46506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CA8D0711
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A5128ADC6
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861216729C;
	Mon, 27 May 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGgsn+MF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275B16728E;
	Mon, 27 May 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825263; cv=none; b=EoZFul1VSr2xpD9fqrUW2FHRqR1EZVY5BpOZzWzrihhwVQFjPQs07Wn1473+fKnqEv7Yvz9eaYLsTOlevxw5Vwy0vv2IknGWm0QQDPV4Ro6Y+XlmGPps4wsq2bUO9aDWBg3gj8aLFdMXandiMhHt72cP4tPQlpJefTkX9Tq4XsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825263; c=relaxed/simple;
	bh=JBD5uyXOg5U5QC3/XSHMViSJs+yiNdm94tuokjSd038=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irWtAwd4ofjMvVCKQ2M9GQzM6I7KBGuzD2SchwAdYiYSGCpU0+nbWp265f87StvmBrxZ4eMqLNN3W5rx7oUQ0cfqbnbtVpTSMWcIKYYUBANRWDtld0n35aWPAux3y084xqshrKOQm7zkGHE0sp5/GwzAiZRKqDtLqO9Gecy9GgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGgsn+MF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B97C32789;
	Mon, 27 May 2024 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825262;
	bh=JBD5uyXOg5U5QC3/XSHMViSJs+yiNdm94tuokjSd038=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGgsn+MFx2GxrD2JgROhOvlKIXh7l/lGEi7FZz0q7UwZVIrqzOEb3VfGr3wwj8JC4
	 a9dIP7t2vg9tGQ3pFRhNyCYkVyHh6/3npwnsqi0pn1JWc0EcFZI2dJ7h4MiR5XL7Hq
	 iqUywWDBkcR5iQ2+0cjcvn1+85gsOIAbBVVTo4o0YOBban2sEkIfVIdsjGY0Ssznto
	 MRmdH+k6gbdU77QphnTuPzeIseeDXuHI0x13FPbpWIc1OeycskVwtkzcOz1rNZ9/v0
	 cEqNJ3qDHHL3YJlHnwXWhK/MT7kaja14R/LRtz/B1mek05MABDji0qTK2jQpVtiWkt
	 CPrBqn7OyytgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	ckeepax@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 08/20] ASoC: Intel: sof_sdw: add quirk for Dell SKU 0C0F
Date: Mon, 27 May 2024 11:52:51 -0400
Message-ID: <20240527155349.3864778-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit b10cb955c6c0b8dbd9a768166d71cc12680b7fdf ]

The JD1 jack detection doesn't seem to work, use JD2.
Also use the 4 speaker configuration.

Link: https://github.com/thesofproject/linux/issues/4900
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20240411220347.131267-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 9a4f801be93d1..468724ccde10e 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -429,6 +429,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2 |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0C0F")
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2 |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.43.0


