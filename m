Return-Path: <stable+bounces-140372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624FAAA7FB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C5A1886242
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69625299945;
	Mon,  5 May 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayG1R0G1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE8299938;
	Mon,  5 May 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484714; cv=none; b=hu/SaUhQsMpNEJA8xc7kwgxeloeOXa/0s86KwB0FqRoJggZ18tWj4a7pct7rBCMNbD8qHs5NK/pjPtA3ZzdJGCWKalxB+6bsPjAfwmEZNDVO1QJmvKnu/5uztcnZBUEuZLGNqzQS8UFX5p1kudJRb6KnqrdqAeBbBmIvLeYcZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484714; c=relaxed/simple;
	bh=d/DLs+QbPTUT98KTTqpFeNBqqPPQdxTpZLK+KgjgoD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4ovfha9I3VOzvjKDf/T/l4IpR0OzMgO/pNx5f5aJLLZtx+Boadj5t5rzkcW+9Ri+DF69sNN+5mkGnzT6S6rFPcXpafXxK14w1+ZB/7AQSK6PyFklQWPm9J1KN66feGgFNHy51N3aWkkyUpvdFOaNOJYsGcx1aS65CsLvMWDgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayG1R0G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FE4C4CEF1;
	Mon,  5 May 2025 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484714;
	bh=d/DLs+QbPTUT98KTTqpFeNBqqPPQdxTpZLK+KgjgoD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayG1R0G1BNF74ahvjRlsIluexgY9Vg+0jY3931PhpxQxWVcsMnj+12sKYihmSzJyX
	 SQDA2TIX96JygLe89DOXug1tDT9tMJ3v9cqrB1nCUDsPJQvCYnhTDQXT9trJQZyQZs
	 Us1JTOg8sCjKZbiCtI4zztbPkDYg9eOIXXiLP0O2FCnjLOmq5oudJa7AX9OWUNPtBd
	 qbUnFr8xnIV7VPIobh+L5y/uWMsFSJhg0bb/IbbtjiQwBpSyHgd3wZqx8rLwZbLq5i
	 E3mNAzqIyFZTmKwizt8gpo9GKKMT9qRqkpgkN/v2bTmCenbMynq/t3M1hmC1ZGw7Cf
	 aTZupsreatqFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kiseok.jo@irondevice.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	chenyuan0y@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 623/642] ASoC: sma1307: Fix error handling in sma1307_setting_loaded()
Date: Mon,  5 May 2025 18:13:59 -0400
Message-Id: <20250505221419.2672473-623-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 012a6efcc805308b1d90a1056ba963eb08858645 ]

There are a couple bugs in this code:

1) The cleanup code calls kfree(sma1307->set.header) and
   kfree(sma1307->set.def) but those functions were allocated using
   devm_kzalloc().  It results in a double free.  Delete all these
   kfree() calls.

2) A missing call to kfree(data) if the checksum was wrong on this error
   path:
	if ((sma1307->set.checksum >> 8) != SMA1307_SETTING_CHECKSUM) {
   Since the "data" pointer is supposed to be freed on every return, I
   changed that to use the __free(kfree) cleanup attribute.

Fixes: 0ec6bd16705f ("ASoC: sma1307: Add NULL check in sma1307_setting_loaded()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/8d32dd96-1404-4373-9b6c-c612a9c18c4c@stanley.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/sma1307.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index b9d8136fe3dc1..793abec56dd27 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1710,7 +1710,7 @@ static void sma1307_check_fault_worker(struct work_struct *work)
 static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *file)
 {
 	const struct firmware *fw;
-	int *data, size, offset, num_mode;
+	int size, offset, num_mode;
 	int ret;
 
 	ret = request_firmware(&fw, file, sma1307->dev);
@@ -1727,7 +1727,7 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		return;
 	}
 
-	data = kzalloc(fw->size, GFP_KERNEL);
+	int *data __free(kfree) = kzalloc(fw->size, GFP_KERNEL);
 	if (!data) {
 		release_firmware(fw);
 		sma1307->set.status = false;
@@ -1747,7 +1747,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 					   sma1307->set.header_size,
 					   GFP_KERNEL);
 	if (!sma1307->set.header) {
-		kfree(data);
 		sma1307->set.status = false;
 		return;
 	}
@@ -1768,8 +1767,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	    = devm_kzalloc(sma1307->dev,
 			   sma1307->set.def_size * sizeof(int), GFP_KERNEL);
 	if (!sma1307->set.def) {
-		kfree(data);
-		kfree(sma1307->set.header);
 		sma1307->set.status = false;
 		return;
 	}
@@ -1787,9 +1784,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 				   sma1307->set.mode_size * 2 * sizeof(int),
 				   GFP_KERNEL);
 		if (!sma1307->set.mode_set[i]) {
-			kfree(data);
-			kfree(sma1307->set.header);
-			kfree(sma1307->set.def);
 			for (int j = 0; j < i; j++)
 				kfree(sma1307->set.mode_set[j]);
 			sma1307->set.status = false;
@@ -1804,7 +1798,6 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 		}
 	}
 
-	kfree(data);
 	sma1307->set.status = true;
 
 }
-- 
2.39.5


