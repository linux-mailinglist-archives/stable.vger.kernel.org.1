Return-Path: <stable+bounces-72855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F085C96A89D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A15A1F25476
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD79C1DB530;
	Tue,  3 Sep 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNl4JMZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D11DB52A;
	Tue,  3 Sep 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396120; cv=none; b=nmxCwgTO5DxiM0U+yLRwIDdH9Dwgxfih5XU/7ImAZKko3Fj9Gdde69zzgwmdGOokjBiIdYkX/Lg6EbiFHjX3m5eU3t8dbwrGcyi+QtWAVfZcwGNjmCDlVj4nIkrjXmR7nAwnCXv15dklGqKodTqMNzdT5xb/qwf+XJqG/tBJjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396120; c=relaxed/simple;
	bh=fObWe6/9NPe8SUFuJMyrYDaUhNT1pDVv6rt+ZUMVZYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RnDWlQYzg57FD/2If9Y9Ta/i5VrdTn86EBlg9KRWxJnHXTYsXBNoTeVBGNGKIO8P1hwgUlc9oCM0WtjH2ifo1+7Ntf9jBbYGvHdVzr+jFt4ughr4lJkTkVpioeteVd/nFQivitZJ009tMZcLuc+KQf43yuFjidiB3orZf3RiCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNl4JMZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D50C4CEC4;
	Tue,  3 Sep 2024 20:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396119;
	bh=fObWe6/9NPe8SUFuJMyrYDaUhNT1pDVv6rt+ZUMVZYc=;
	h=From:To:Cc:Subject:Date:From;
	b=MNl4JMZHjo05n3iUIdWYXSbsqozISkfNL9zTyfrWKZpoVnxB2ieqHj2jf0/HB9llN
	 K71aKkd5cgrCUQKB1RlzZHOpPT8xmMZrxdg+UoRiekwI3inc8wLI/KxA6+Kk0R9OJt
	 LqKt91yiVrmDiUo7q8ghx4rii+rT2HFiYC5PIvF/qXz1xj9qEkKdQ+flQbs78oS49n
	 wYQqY672G9JlD1qn++f/hl0dX1Yhxme6loLmDdoGT9rVXn+1bgN7dW0pD9Fe/mqN0v
	 JxrBrvuiKALCJDSug5DcVSf6v4wZsutqLJpGsPnYQ9uESvHfHtL9HLhI9XI8VYo9SH
	 lbHXfF+w5lQmA==
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
	cujomalainey@chromium.org,
	krzk@kernel.org,
	christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de,
	trevor.wu@mediatek.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 01/22] ASoC: SOF: mediatek: Add missing board compatible
Date: Tue,  3 Sep 2024 15:21:48 -0400
Message-ID: <20240903192243.1107016-1-sashal@kernel.org>
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
X-stable-base: Linux 6.10.7
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
index 8d3fc167cd810..b9d4508bbb85d 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -574,6 +574,9 @@ static struct snd_sof_of_mach sof_mt8195_machs[] = {
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


