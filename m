Return-Path: <stable+bounces-118847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A535BA41CF6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B9C3BBD49
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA50268C7F;
	Mon, 24 Feb 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyr4Mx3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5C268C76;
	Mon, 24 Feb 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395961; cv=none; b=WSZ8Wei5dQe4gXjWcGeVz139fAlRrmZANQr5Zu1QhOcy/0n5uMogiH07PB2qSwQfuEMHQN4UBiNOverDR6h7yMGbBchE4XwwrTfvuKbfICxN5UMUnNX7P1Gz9o2qeCeMEYOMqtilOCF/SCr1+6ocufA0OHKaCSB3yRPaSLDQJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395961; c=relaxed/simple;
	bh=i4qu3MyKJNFO3nSp+1QsU/f+OfoYjeYxphN4vYl4NRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6Zesnu8jo+TBCNQxiZoBwRPBng2JmJmrH1CBpLM4nYIid2OkgTQdI6FrwZa19AYIEZcdjO7V5pDjPBIJDtN5LxWeXGSMRhVDW4jev65o+INkiY6s93mT+Ri17GfkBLLpFwB2Kfm9FAfV2WDl+rJMe1839qF6iLdsp/u9NxH4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyr4Mx3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A288C4CEE9;
	Mon, 24 Feb 2025 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395961;
	bh=i4qu3MyKJNFO3nSp+1QsU/f+OfoYjeYxphN4vYl4NRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyr4Mx3W5t0H7AwRCxUfemhFWJH/swTvHeBUgcDuPBgGYtBSGz6Rora2gpEcH0M2G
	 StBkhLgL60Z8M5+Ms47nEGYAb/EXGYud5qAV/6VBTwYuN26stY2DctTWAFNky9DG4v
	 hR1Ptgye56XUeN0XAGu8jSsRh0gn09cdrF+kLaPj8dApl3Rqa0A1gq5GDcTzHD0728
	 knV5bUgMD4vK+Admg9xKpmMK9ux9SWI182WBcPXdvNpypT+2Ut8IyjfxESUyRbNd76
	 RIEb6HrXxE5958zlN4MPVExfa8pAClMPJDOs4CYQVyfQs3LOy9hKwjLvp6TH1HseiL
	 ez99Fq+DYdWmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/20] ASoC: simple-card-utils.c: add missing dlc->of_node
Date: Mon, 24 Feb 2025 06:18:56 -0500
Message-Id: <20250224111914.2214326-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit dabbd325b25edb5cdd99c94391817202dd54b651 ]

commit 90de551c1bf ("ASoC: simple-card-utils.c: enable multi Component
support") added muiti Component support, but was missing to add
dlc->of_node. Because of it, Sound device list will indicates strange
name if it was DPCM connection and driver supports dai->driver->dai_args,
like below

	> aplay -l
	card X: sndulcbmix [xxxx], device 0: fe.(null).rsnd-dai.0 (*) []
	...                                     ^^^^^^

It will be fixed by this patch

	> aplay -l
	card X: sndulcbmix [xxxx], device 0: fe.sound@ec500000.rsnd-dai.0 (*) []
	...                                     ^^^^^^^^^^^^^^

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://patch.msgid.link/87ikpp2rtb.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 2588ec735dbdf..598b0000df244 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1086,6 +1086,7 @@ int asoc_graph_parse_dai(struct device *dev, struct device_node *ep,
 	args.np = ep;
 	dai = snd_soc_get_dai_via_args(&args);
 	if (dai) {
+		dlc->of_node  = node;
 		dlc->dai_name = snd_soc_dai_name_get(dai);
 		dlc->dai_args = snd_soc_copy_dai_args(dev, &args);
 		if (!dlc->dai_args)
-- 
2.39.5


