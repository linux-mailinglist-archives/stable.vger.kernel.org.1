Return-Path: <stable+bounces-134906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F3A95B05
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CC2175BBB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381B61EE7B1;
	Tue, 22 Apr 2025 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRhzaWof"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E819D881;
	Tue, 22 Apr 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288169; cv=none; b=JFQudDHmyU5IG9qwrF71+WtzPn3QsQkfJjCXMIQi63FPTxJXWL+pZz0jzKUqIgmbWAVlthfNrr2dFZsjY73vaKenb4RRwUGxAM07c003/nPQd+Wa/bToRk93hSzVXG/830aSEM6jBDOXUmuUKHtkVyJyrBaWod6tcuSYOyY7T88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288169; c=relaxed/simple;
	bh=Bnz9KEBGvBhnzUyWYuUZ9LHfYHUReYjI9gmWKWGhC3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpqa0rF4b0gcroeO83MM4zQhP0tEEUFcRugz+D5EVkweQXGEBwiuPbm6kOK2mq/y7L2MaUBj2x6DT0i4a4/vu77zThK6uHQZUEmo44FC9lOj4gYdb3HS0vrxYTttAERJaKF8dE/iw9gMZT8RAZdnOufkF3bRQGt1lkSgSfwU1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRhzaWof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA3FC4CEE4;
	Tue, 22 Apr 2025 02:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288168;
	bh=Bnz9KEBGvBhnzUyWYuUZ9LHfYHUReYjI9gmWKWGhC3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRhzaWofKl5PshxraIWYFi7wXGSJ9dWXEUiHaCxfVdd3cmwSqvrYeLTGS5AR7mghP
	 lxdULUG0fxrAU1h0rvSCYUygXb2caWa8urR3pFWoAmX+uCFiBDNMNS1SRLIczUaw7o
	 opx86Lm0BbLOYDDweMwQe5MEeWZU+iLDmG6e3C0My5N/x9X7zBkgIDLUhL4Wc6kxpD
	 2PrWsSbI/mI3uWuUgeI2gzBx1hNVC37P3GBbXDnyxr7IJkUO5TqnXE0kjaoB3BnJt1
	 CqsXMJhKVq9gnUY8xs7NCiBmOKWfalL/SbCSGuIjkDQibbrUG8szXZ35ekWr3dmStY
	 0X31qunG1hsZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Weidong Wang <wangweidong.a@awinic.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	yesanishhere@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 08/30] ASoC: codecs: Add of_match_table for aw888081 driver
Date: Mon, 21 Apr 2025 22:15:28 -0400
Message-Id: <20250422021550.1940809-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

[ Upstream commit 6bbb2b1286f437b45ccf4828a537429153cd1096 ]

Add of_match_table for aw88081 driver to make matching
between dts and driver more flexible

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
Link: https://patch.msgid.link/20250410024953.26565-1-wangweidong.a@awinic.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/aw88081.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index ad16ab6812cd3..3dd8428f08cce 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -1295,9 +1295,19 @@ static int aw88081_i2c_probe(struct i2c_client *i2c)
 			aw88081_dai, ARRAY_SIZE(aw88081_dai));
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id aw88081_of_match[] = {
+	{ .compatible = "awinic,aw88081" },
+	{ .compatible = "awinic,aw88083" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aw88081_of_match);
+#endif
+
 static struct i2c_driver aw88081_i2c_driver = {
 	.driver = {
 		.name = AW88081_I2C_NAME,
+		.of_match_table = of_match_ptr(aw88081_of_match),
 	},
 	.probe = aw88081_i2c_probe,
 	.id_table = aw88081_i2c_id,
-- 
2.39.5


