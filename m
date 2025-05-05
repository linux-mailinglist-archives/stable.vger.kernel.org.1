Return-Path: <stable+bounces-140767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE05AAAB04
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0F67A053F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C93A91C2;
	Mon,  5 May 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfCykZYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEA3710F2;
	Mon,  5 May 2025 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486199; cv=none; b=ZoG7JGw7LH0l6h7kmMXNyFPcI/4Rr/u0b9NTmuD5ylb61gLzjivSW/gt/XjB7Zr0CirUEa6oFuZrFrRS3pbojwUZofh/x4N3wkSJcZp3CJrtdV+qbswxN3va4bBUaGNILCh0dEbw7g49Jt9fvXgwXwRNWvL5yhFS+LtW5VSKyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486199; c=relaxed/simple;
	bh=vjZQ1VPxcLbNPDdNN17kBs0nqjUFWQOxO5EqmHg9gBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3Gmv3dpYjx9sjZWDhWfFQiTZQEV6pr8/HmbT+xs9wcXY7UWaFOZ+sZhm5zkYvh6aHjffRS0zPnyyN/pod4UEtUgQlEpnIiH7oC40l6noPvUh2spi4DctOP1j9lGxj4CwHnOePL1CC3C07DhFLxkEQDAAGmCPjVG27L5PGW9u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfCykZYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1FFC4CEF1;
	Mon,  5 May 2025 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486198;
	bh=vjZQ1VPxcLbNPDdNN17kBs0nqjUFWQOxO5EqmHg9gBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfCykZYNt1Fn4tBd7TDkhO9rNImX9mukm74TZ2tCrVNVcBfnPixA7dQEU6MSrg11m
	 a+om7x2TF/n9STGchVUx3uof62vEPxsIeYG9zP3XGaMNbn1+AnKgyGoXSVJAnS3fAE
	 SVGo6yOuppXOZbEWk6iyiMaiT+oRX/SoLjABbH+gK2km5oQE9TIcPTMBXC6l037LMC
	 6ln1xGaPpYf+oXqZwm4hguwPohTzOg9VW5DFd0jUUcBHpGlXsC9ulW+zFq8EWJYU+1
	 SdNw7AFdUESLG5uxUpL5vl65fjrE0y7bff5GYhqtu5aOu1s7guBEiRgG3nRUroAYZi
	 KWNJSvyyK398w==
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
Subject: [PATCH AUTOSEL 6.6 200/294] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
Date: Mon,  5 May 2025 18:55:00 -0400
Message-Id: <20250505225634.2688578-200-sashal@kernel.org>
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
index e87a07eee9737..4e5381c07f504 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -636,6 +636,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
-- 
2.39.5


