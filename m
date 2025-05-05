Return-Path: <stable+bounces-141561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CCAAB474
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AFA5022F5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C474793DB;
	Tue,  6 May 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdq/9IMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFCE2F0B9E;
	Mon,  5 May 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486698; cv=none; b=TJouaE0CDfkNVCreUd7nd/IHy3PRHxexmlKmsbEXN/cLHu7tNXVIYxmW4wXCneAon/CgJsLPtMEIpYqKWsQN5ZLWBPZnDquyQj3RM4Me000ygmhgtnIB81n895sZWMwEdv6gBm96v1ysPNMdkfYmMr3Tz1Hfhl2JCGfG76jUIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486698; c=relaxed/simple;
	bh=SlxI5tOH8DtyZHXGqpM+DZfeyy30yBJyEJaeEeFFWlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PExU31cARR59pXLnjUS95m0PtESNu5EH91MotCqusCYr8YuagjnLtvw5XjStxzTXreHAQTzZaDBOExBW7Bm66fkH/0jzMvXFbeSVC0yUO8sp6XMtXmUSjDeIj9f6xQ3ujUVfQuKFCOeoG2V/NtmcfP+yegXbpY83OqHEWf9WI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdq/9IMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9A9C4CEE4;
	Mon,  5 May 2025 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486697;
	bh=SlxI5tOH8DtyZHXGqpM+DZfeyy30yBJyEJaeEeFFWlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fdq/9IMrqfNRX0Te+A5bE4ZQZ8GCJHDdxfxLA27APWJsxUSxdDpsSSotBu4Rqo2KE
	 IAU3rgSb1uTghnoL7wshZIC0LQ5MtK+XHk1+ZQ3KxWI2S/tWbU+/LTDUKM/pBtJd5H
	 6W9DYtXIsTX0KLhcfCozqbm5k0veoGb1xxR9ygy3ZcMNvIDa/B+XKZVZlWuMfsgAcF
	 ybqiUmCbGmmhfBqt6Vu6o9b/7Mr9x1SP3GkYXiTDSjCKK3fh+x7LXeNfOAeZQddg/t
	 r/RAxugiE0TPq9hztiF4NPlYgpM8A3K5/1R5oOkuL07i5sntCduzFRc1tyZtB3ffV/
	 RtAKInqzxYpUA==
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
Subject: [PATCH AUTOSEL 6.1 157/212] ASoC: tas2764: Mark SW_RESET as volatile
Date: Mon,  5 May 2025 19:05:29 -0400
Message-Id: <20250505230624.2692522-157-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Hector Martin <marcan@marcan.st>

[ Upstream commit f37f1748564ac51d32f7588bd7bfc99913ccab8e ]

Since the bit is self-clearing.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20250208-asoc-tas2764-v1-3-dbab892a69b5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2764.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 72db361ac3611..94428487a8855 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -654,6 +654,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
-- 
2.39.5


