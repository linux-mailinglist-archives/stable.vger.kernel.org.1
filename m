Return-Path: <stable+bounces-141196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD842AAB180
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A6F3A5F34
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AC3D14C4;
	Tue,  6 May 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jccztEwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C62D1126;
	Mon,  5 May 2025 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485466; cv=none; b=sISLdkQQUvJIQbTlJajOr/6Yc8CKE9YJEgFyKZLIM32mx6jB60L7xnaqfj3XUkyEOLn9fsrP4UHBYfh9f8z9n1nN0KBZeGEdFpl6otwx7hSswuNcWPaaU1gDdZsg/3ThHgWHM4GEaJG54HZ7WH2Si8WP8XypflyC4xhZbgtDYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485466; c=relaxed/simple;
	bh=z+fMMvtWpwcVSNZK80WDtwzO/qfwNQN/M5Kp/sFKa8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQKtdevbzUWq4lgKJOAroYMndMq3MyvGGVlod1suptJn28xjq2tVeLubYIAETh9zRCje4Exo/uPs4sYqtLVa2gegDiGI6gz00ezx7MLYCqHR2Xv0Bn6uY9mQrz0WVT4IW3xDe0SPoF3f6OlqNcYbQew/ggBXcoYWHLy8WR/0SXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jccztEwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEEFC4CEEF;
	Mon,  5 May 2025 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485466;
	bh=z+fMMvtWpwcVSNZK80WDtwzO/qfwNQN/M5Kp/sFKa8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jccztEwdHBN6vTAIockukC1wYv8biWzSe084L3lWYQ3S9KDxqXjv1le4Ib2VhheA4
	 PneEke1l42NFut9I03OIVgddKgnciAUmOakBGkG6SC5+mxZrOf9Q+Uv880I6mVAAtQ
	 Uitwc8CFtwum0GDaEojU3I7XJI78oMaklOt7Hj/IGf19WE1MnR3QmHqps3+I6HLKPT
	 sCPjFcK6GZDCf+0cNxXXXyD8lTf05gG+oTmHHXMc1RmY+1g1QWAfKYN8V4ujzkhYTU
	 x6yd55OrvXFDjZkUrZKCxWQHmMQMJsCtXBt05+lKCwnemALYXNFc2YQ3VQeFHrH0Oj
	 YBYX/WH6idPYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hector Martin <marcan@marcan.st>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 327/486] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
Date: Mon,  5 May 2025 18:36:43 -0400
Message-Id: <20250505223922.2682012-327-sashal@kernel.org>
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

From: Hector Martin <marcan@marcan.st>

[ Upstream commit d64c4c3d1c578f98d70db1c5e2535b47adce9d07 ]

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-4-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 58315eab492a1..bc0a73fc7ab41 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -634,6 +634,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
-- 
2.39.5


