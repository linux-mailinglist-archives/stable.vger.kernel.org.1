Return-Path: <stable+bounces-72877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542ED96A8DC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B5AB232CC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09731D5CD2;
	Tue,  3 Sep 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMcxCfHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3051D79BE;
	Tue,  3 Sep 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396222; cv=none; b=M+IpRuW3XN2CmySH14FlGPKwkszC+3xKFtfKSCcd67TbpwiVE1y3bJT71cpgEoZgAy670E7r5LPRyH8kberds/0J89wP29tYXsgftOCEi/R5mMvuV1TYay1hVBWvHihHpAHYJCNYTc5KVSzicA3fB0MKopQs/ZcoEcP2w1qY3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396222; c=relaxed/simple;
	bh=w6xmb8ZJDVceRYIFTagavHFeNZRazE64x1rzW/Yj8ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJ2LKvV8fSZsyDBoNvSxmXv0c1B7dinE+7s4T6le2blbj0ZVYYOETk+EuTkdVWo2sDZmY8JPE6RPFBmQ58xdCZ7lVdBzS6Mq4cuVRMVY/cmcncsaUHHMQbKrk/MStHuQbjBABQUyChUtOKp9gjmfCPqFw0xusNbfkELvYSsv/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMcxCfHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C53C4CEC4;
	Tue,  3 Sep 2024 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396222;
	bh=w6xmb8ZJDVceRYIFTagavHFeNZRazE64x1rzW/Yj8ZU=;
	h=From:To:Cc:Subject:Date:From;
	b=LMcxCfHzxzeeluwzl2z6hgk+b/om2tAw7BPsseBLiDbZUnkx9hZrY6aPGccm8MjHH
	 aZ/n2ANHl93r51DdegRLPGH30LkOouKmVjRnmxszIXyrl3qs9llqeiorXPGMyrobG2
	 Ac7US+DUZXNyfMOWQxl0PMcXtDLQjhzk/wxCG9h5x1Nol67vy9+itFcU72A77MnzJj
	 S4jPK1GWZasa5/gx3DkkFGsNFioxvi2Z3RoReCP5xTrnbYnW8PIo6HbYjwQghSU8YB
	 zhoq0MYbnHf15FRqxS7MX69kHzYZdsbDKtief2z2hsZJ4m7KTcEb1S7mu4Ti8UPfAU
	 XCHLUp/5JyECg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Albert=20Jakie=C5=82a?= <jakiela@google.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	christophe.jaillet@wanadoo.fr,
	kuninori.morimoto.gx@renesas.com,
	u.kleine-koenig@pengutronix.de,
	cujomalainey@chromium.org,
	krzk@kernel.org,
	trevor.wu@mediatek.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/20] ASoC: SOF: mediatek: Add missing board compatible
Date: Tue,  3 Sep 2024 15:23:33 -0400
Message-ID: <20240903192425.1107562-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Albert Jakieła <jakiela@google.com>

[ Upstream commit c0196faaa927321a63e680427e075734ee656e42 ]

Add Google Dojo compatible.

Signed-off-by: Albert Jakieła <jakiela@google.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://patch.msgid.link/20240809135627.544429-1-jakiela@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index b5b4ea854da4b..94db51d88dda0 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -625,6 +625,9 @@ static struct snd_sof_of_mach sof_mt8195_machs[] = {
 	{
 		.compatible = "google,tomato",
 		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682.tplg"
+	}, {
+		.compatible = "google,dojo",
+		.sof_tplg_filename = "sof-mt8195-mt6359-max98390-rt5682.tplg"
 	}, {
 		.compatible = "mediatek,mt8195",
 		.sof_tplg_filename = "sof-mt8195.tplg"
-- 
2.43.0


