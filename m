Return-Path: <stable+bounces-43290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE588BF166
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFCFB2522F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DA131735;
	Tue,  7 May 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh+s92qy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EB13118D;
	Tue,  7 May 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123303; cv=none; b=mUxl6W8RsllTW3PC7MWuYjxY4Db30VXjUi64s9S9ylpC9bLaVSwe6Ix3G5QQ3ixHwjGJ/T4WR2pXZlvwjnSBq2ZDqMfqwt3bCH+14bxKxNG5Wa85ACyHSgzpSgIDVLXNvJGXsc0/ReeXXdkuf7iWgGaJqpO2LB/48dPjvt9IikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123303; c=relaxed/simple;
	bh=CIfsrnD0zsMUFHMqqLqP520fgGLcEzV+dxAOybbhrOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bU7lUboEwBZ39lZXlFOtk35ElOJimDBY3KsHiBqZOnJJvx6jt6e79IPc2ksO/ZIhDMqvpU5caAwfAytIz1hBHa0xUzYVHAVpX7MZIK4109fn4DMzmBVmwhw81NMCl8j1FAVlPa43iRoW3sZi9oKElvUThf8f8napH7NqaeZaF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh+s92qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD31C3277B;
	Tue,  7 May 2024 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123302;
	bh=CIfsrnD0zsMUFHMqqLqP520fgGLcEzV+dxAOybbhrOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh+s92qy9xj8FvbL1hhvwtsUMm1w/XKDsuG6pidO50kmOH7+XDvVzzQ9ojjbtUiOO
	 kV0Vc91sQMoNl2XBSHQlhyFCrvnOugT1yzq4aiQV016xJr+kmFc7wcricJN0/uDxn/
	 p0fD+8CqK/IGUv3Lapzs9+Q0Hy8PkpL0BNmH35S3owP5iXdlNEaPZQIOM02sE4gMgS
	 PP6epzD3yyvpxsvWN52oCLgwXHATRzwii5SA1wounLP68WaA0IhWL26hxFPcBwXk2a
	 n08mT09OC2HZ+n2rKTYb+2iEyrh+NmZ/5cmnR6ZW5I3qzO03OPEeg9FeczAO04t2VT
	 thjwZgl1UxECg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 11/52] ASoC: rt722-sdca: modify channel number to support 4 channels
Date: Tue,  7 May 2024 19:06:37 -0400
Message-ID: <20240507230800.392128-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit cb9946971d7cb717b726710e1a9fa4ded00b9135 ]

Channel numbers of dmic supports 4 channels, modify channels_max
regarding to this issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://msgid.link/r/6a9b1d1fb2ea4f04b2157799f04053b1@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt722-sdca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index 0e1c65a20392a..4338cdb3a7917 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -1329,7 +1329,7 @@ static struct snd_soc_dai_driver rt722_sdca_dai[] = {
 		.capture = {
 			.stream_name = "DP6 DMic Capture",
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = RT722_STEREO_RATES,
 			.formats = RT722_FORMATS,
 		},
-- 
2.43.0


