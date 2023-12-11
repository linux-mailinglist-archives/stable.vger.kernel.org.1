Return-Path: <stable+bounces-5456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004A80CC75
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FB31F21315
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B2482CF;
	Mon, 11 Dec 2023 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0i08+P2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF8482C5;
	Mon, 11 Dec 2023 14:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92626C433CC;
	Mon, 11 Dec 2023 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303298;
	bh=hewV+haqm7iKFmVzteMqLLsZAMWK0d37JQvVNdoChUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0i08+P2Ak1hoZe+xMsHUv0GaRBfBq6ptLb7is1uujdn5CELA566hW+2Y1W9mo7AZ
	 SuziF8yP44gXvIlPPZsewwHy7kMoZlm+ed8nm5MnAaEfvzfI8e2JKC0xuijlQKN1Sq
	 X/MEsykUglEZyR4tRCBobTxRa9ODet1veDHQp19NqllsOQ4+xgmRy5fph4a8TDcikf
	 i4bBDJuaqYoKhr/ehmGKjSlPfsotli8Lp0GLXX2wss9BwJNgpn/lpjM9J+pL98d/ff
	 WhFht1A/q+R6bvSy7kO9HFyYo3MOy0kSOZevk3iNFk0kCjOQSKZpiLCPkgxLFNsvqk
	 aKaTDEIVY1ZbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/16] ASoC: cs43130: Fix the position of const qualifier
Date: Mon, 11 Dec 2023 09:00:29 -0500
Message-ID: <20231211140116.391986-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit e7f289a59e76a5890a57bc27b198f69f175f75d9 ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-2-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 8f70dee958786..285806868c405 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1683,7 +1683,7 @@ static ssize_t cs43130_show_dc_r(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2364,7 +2364,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_write	= true,
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
-- 
2.42.0


