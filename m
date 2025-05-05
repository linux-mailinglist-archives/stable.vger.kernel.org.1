Return-Path: <stable+bounces-139883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B71AAA193
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986B21A850AE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CB02BFC7C;
	Mon,  5 May 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItPrhyuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E272BFC75;
	Mon,  5 May 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483598; cv=none; b=TMUYwLYOBD1XfimaMG83L2WHPkxqfnSX8OOFAszDbyw5pZ5DIMBIbb+ZtyLd7fTQ6Gp80Ictgg3YKG/L1hecK0kp2cF8U08w86lm6dXNuaIUrkokxF8u0Nw939LDJCbd3C/vbg11wl1L71EmY1sqnOTsGFpBm5Ry+6SM/y55M6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483598; c=relaxed/simple;
	bh=yeGRSe4yeYnAkn6QCGTNyWrsb1g3xtn78uJVGtMC8Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BudIKS1CcN/18oL+WmcdXwbnlyi1iJfviqo8O8QxNYi1uhHbpd9L0Rt4v5Gct0RY3NINszVDJ0RfbZps9JI5rBdfJsOtjo7O741qrx8v73gp37i78x+gq/I9mgY7JYvOa4X7dPCPibeklTg3nMhpWgyDcPcWLhiX6Bwoh1ggkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItPrhyuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9FDC4CEED;
	Mon,  5 May 2025 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483597;
	bh=yeGRSe4yeYnAkn6QCGTNyWrsb1g3xtn78uJVGtMC8Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItPrhyuODKzMfcmKZYDtgeTrKHUx71BCBZ6ZH7SooV1H22ptN/xMDQg7TENtvMcut
	 fkzM4+SA7cI1eFwLswkP+v5rb7y1xUFrMNHsZ/RZSir7u1H16XXyfnjvKjxlTrHrDr
	 iZnIxst2SDc1hDQJxvXvC57GYJY5b84PG1yoOnXuk3G2L/62WgwV4wE12YoqyrKUoW
	 NeGdratECwL6DeUYKD+g/4O9vKZKmgvuRzzsmlTkiw4EBm85BP2FPHfkTIi8srqj/0
	 JXlN9l1JXLuIomS+e8Gey0ESrqDFqDGznFEWzzZ1ss14iGDrs0gXq4DCoZUbWu/3Kv
	 sRKD0pNtHY27g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chenyuan Yang <chenyuan0y@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kiseok.jo@irondevice.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 136/642] ASoC: sma1307: Add NULL check in sma1307_setting_loaded()
Date: Mon,  5 May 2025 18:05:52 -0400
Message-Id: <20250505221419.2672473-136-sashal@kernel.org>
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

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 0ec6bd16705fe21d6429d6b8f7981eae2142bba8 ]

All varibale allocated by kzalloc and devm_kzalloc could be NULL.
Multiple pointer checks and their cleanup are added.

This issue is found by our static analysis tool

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://patch.msgid.link/20250311015714.1333857-1-chenyuan0y@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sma1307.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index 480bcea48541e..b9d8136fe3dc1 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1728,6 +1728,11 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	}
 
 	data = kzalloc(fw->size, GFP_KERNEL);
+	if (!data) {
+		release_firmware(fw);
+		sma1307->set.status = false;
+		return;
+	}
 	size = fw->size >> 2;
 	memcpy(data, fw->data, fw->size);
 
@@ -1741,6 +1746,12 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	sma1307->set.header = devm_kzalloc(sma1307->dev,
 					   sma1307->set.header_size,
 					   GFP_KERNEL);
+	if (!sma1307->set.header) {
+		kfree(data);
+		sma1307->set.status = false;
+		return;
+	}
+
 	memcpy(sma1307->set.header, data,
 	       sma1307->set.header_size * sizeof(int));
 
@@ -1756,6 +1767,13 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	sma1307->set.def
 	    = devm_kzalloc(sma1307->dev,
 			   sma1307->set.def_size * sizeof(int), GFP_KERNEL);
+	if (!sma1307->set.def) {
+		kfree(data);
+		kfree(sma1307->set.header);
+		sma1307->set.status = false;
+		return;
+	}
+
 	memcpy(sma1307->set.def,
 	       &data[sma1307->set.header_size],
 	       sma1307->set.def_size * sizeof(int));
@@ -1768,6 +1786,16 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		    = devm_kzalloc(sma1307->dev,
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
+		if (!sma1307->set.mode_set[i]) {
+			kfree(data);
+			kfree(sma1307->set.header);
+			kfree(sma1307->set.def);
+			for (int j = 0; j < i; j++)
+				kfree(sma1307->set.mode_set[j]);
+			sma1307->set.status = false;
+			return;
+		}
+
 		for (int j = 0; j < sma1307->set.mode_size; j++) {
 			sma1307->set.mode_set[i][2 * j]
 			    = data[offset + ((num_mode + 1) * j)];
-- 
2.39.5


