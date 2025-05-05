Return-Path: <stable+bounces-141304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97029AAB27E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E85B3A3E12
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0A426CE9;
	Tue,  6 May 2025 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5/yfYeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F22D7AEC;
	Mon,  5 May 2025 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485732; cv=none; b=NJ4uCGWkDaIOeHP9oWKwU0lvN3ill4/BxY7upXTYcBx/pd19/BMIULDcyxAy854/OGDCS/psTrZZtnATu6a1WgWnsFQVnj3hy6MBVaep5jH43MOFzfQb2ifHesqvrLr4lt6vvZpaGvAFpsr+Wb2RS2xjdmsC4IghQkoIBHKdhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485732; c=relaxed/simple;
	bh=lOaXVfAMBDlGa62+0rELA0eR88qBti/i5Qonwh7IbjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujh5K8SQTg3H6d1FYzc+K7q9fOJc2F8yC9XCI/GAau9LdDfWhf3mpQntzquaUPvp7+0VSnALkZxQoFIAXU62mZLsi1Mxqa0Hs2K+8e8oBhHBt65PH5DNcgu5RIAUy0KkEEgtrawFkYqYHkxoSH1HFHuNJJivfXD4/Qlkyp7pzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5/yfYeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2167CC4CEF1;
	Mon,  5 May 2025 22:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485731;
	bh=lOaXVfAMBDlGa62+0rELA0eR88qBti/i5Qonwh7IbjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5/yfYeD0j3VuinLP2Pf2mhGbAuOKBXDcI+1H7377FqzInsmM+CGD6mbMmt8Yxh+b
	 7cvgsHjQbEHx+ZDdClrj/WfQ8cVD7kWpF1y2iN8hXQlTyvcv3KcIFelF0B9oYX4y7p
	 q6t49fTDCT8RRIZtMx9NRSDsVyPsVVO+v5P+cqbKCmoHQSn4rPO1o8R5PMTB9lTSPg
	 RywJO3w7Axo+yunkA02Kx+o1HBtOuUhugJOH+/hfKRggdIsz8w0fcWg6pvnVVywqOF
	 rk9QjpUPG3cZCfBl4BOm6Uc3tPV4YDxvMe3D3T5nu+g+zuIMPyg19TK902oqknglxe
	 7uwWyL9x7EqNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 449/486] ASoC: soc-core: Stop using of_property_read_bool() for non-boolean properties
Date: Mon,  5 May 2025 18:38:45 -0400
Message-Id: <20250505223922.2682012-449-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6eab7034579917f207ca6d8e3f4e11e85e0ab7d5 ]

On R-Car:

    OF: /sound: Read of boolean property 'simple-audio-card,bitclock-master' with a value.
    OF: /sound: Read of boolean property 'simple-audio-card,frame-master' with a value.

or:

    OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'bitclock-master' with a value.
    OF: /soc/sound@ec500000/ports/port@0/endpoint: Read of boolean property 'frame-master' with a value.

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Replace testing for presence before calling of_property_read_u32() by
testing for an -EINVAL return value from the latter, to simplify the
code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/db10e96fbda121e7456d70e97a013cbfc9755f4d.1737533954.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 20248a29d1674..e3c8d4f20b9c1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3057,7 +3057,7 @@ int snd_soc_of_parse_pin_switches(struct snd_soc_card *card, const char *prop)
 	unsigned int i, nb_controls;
 	int ret;
 
-	if (!of_property_read_bool(dev->of_node, prop))
+	if (!of_property_present(dev->of_node, prop))
 		return 0;
 
 	strings = devm_kcalloc(dev, nb_controls_max,
@@ -3131,23 +3131,17 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 	if (rx_mask)
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
 
-	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
-		if (ret)
-			return ret;
-
-		if (slots)
-			*slots = val;
-	}
-
-	if (of_property_read_bool(np, "dai-tdm-slot-width")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
-		if (ret)
-			return ret;
+	ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slots)
+		*slots = val;
 
-		if (slot_width)
-			*slot_width = val;
-	}
+	ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slot_width)
+		*slot_width = val;
 
 	return 0;
 }
@@ -3411,12 +3405,12 @@ unsigned int snd_soc_daifmt_parse_clock_provider_raw(struct device_node *np,
 	 * check "[prefix]frame-master"
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
-	bit = of_property_read_bool(np, prop);
+	bit = of_property_present(np, prop);
 	if (bit && bitclkmaster)
 		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
-	frame = of_property_read_bool(np, prop);
+	frame = of_property_present(np, prop);
 	if (frame && framemaster)
 		*framemaster = of_parse_phandle(np, prop, 0);
 
-- 
2.39.5


