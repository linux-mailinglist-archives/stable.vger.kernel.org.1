Return-Path: <stable+bounces-118822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23FDA41CAA
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CA017B279
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554A3265CBF;
	Mon, 24 Feb 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M954/iXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68625C6E2;
	Mon, 24 Feb 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395897; cv=none; b=MaIDmiV04pyrkvvJ6dCWeW5mzgIh9e7hKGAm8xRxro7SQKkW5Ec6dT043Kje0mnVBuI8Jgo+15VZ+eUyQR2MsT8z9ag+29WEZXVyEJSMsrufkuRVfwp4nVyQDxN1v6/0XUEWCOOQk0PdPtZSjKsojCAGHfsC/4eEet6Tb/p5GTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395897; c=relaxed/simple;
	bh=gJf3KK+XUe5dpUclBs4MsuhirqGbm6M4k8FnLIcLw4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJZR2PZ0wtenDpWt6ZwL8Sv272FHtKWSV6r7OqGVbOqeve5u0EYFmqyGwzxKSJGrup8iOubB5avM6hMztchvPLdYXqmXxuxnS5kvYzSyPM/ktw3aEP4F5Hl0hWnWr6AdCCduSt/4Uqxq5Hz9ME/W6V/pKp70ci6NcWjfvQxrLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M954/iXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE178C4CED6;
	Mon, 24 Feb 2025 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395896;
	bh=gJf3KK+XUe5dpUclBs4MsuhirqGbm6M4k8FnLIcLw4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M954/iXc7htq9CE1JIfjkObPca9JHRlD97qaZsNecsMt4guMyIN5M4g2dd4Qq5lYw
	 dYMNwa1DoOdebTSi92L0D1Op6o4byg7/OWChs6bQa7U8qKtam+6QusLtyYuNoLcuso
	 JTM+fKidO8j/4sX9iKz0XYSxFBV7wxC9olWrTaRYb+w/y6eMS2nFA835+OBuXp53kD
	 BWC6/dwBnTqA1hcIJOtd3/+zw+wvKLO6FHD1H+WD80MhEn8b3IiM6al3f5XsxUBEwm
	 C+hcq7tLGXrpJfjOLBAdJLx+q9TAZf9+dCzI/mNS01EZlB45BLky7PYtcZoW9Qd6HP
	 5QTqpx0mUxSDg==
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
Subject: [PATCH AUTOSEL 6.12 06/28] ASoC: simple-card-utils.c: add missing dlc->of_node
Date: Mon, 24 Feb 2025 06:17:37 -0500
Message-Id: <20250224111759.2213772-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index fedae7f6f70cc..975ffd2cad292 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1097,6 +1097,7 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	args.np = ep;
 	dai = snd_soc_get_dai_via_args(&args);
 	if (dai) {
+		dlc->of_node  = node;
 		dlc->dai_name = snd_soc_dai_name_get(dai);
 		dlc->dai_args = snd_soc_copy_dai_args(dev, &args);
 		if (!dlc->dai_args)
-- 
2.39.5


