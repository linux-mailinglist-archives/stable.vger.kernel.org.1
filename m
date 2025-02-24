Return-Path: <stable+bounces-118792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB42A41C54
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AC31895022
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFDF25A2BC;
	Mon, 24 Feb 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK10cCqj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671B25C706;
	Mon, 24 Feb 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395823; cv=none; b=hRFt12ZlzKH0fTTKhBFUvrWO0YXP8rQzVUmpDFYzHSdY48cnhmc15VDjBoXnvblxbCV0Mf4jxOEpRXh40CvKDsQqsW2h77ysCCmVXcoqYwGKHGEQzKOb0ZWYolJ3sZTw6SNRDDmU0rDV5FlEKbC8cKp1c3ZcihlWxDHjExwMskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395823; c=relaxed/simple;
	bh=EoW60TsbX+PVkHaLYf0CRmSChSo/i0ceG54/YtQ3yNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Te3zT8fczFp9ub4iFVRchDKOQ59F20/+tLdlAvQL9jBtbDRw+xbFdB1ZPTM3hOd+HSIpW3XhKlv5v5qTfejGHR1MSUN6bySOpGn01GlhdCzrpqFD8sYdIqY5YYVhTQ3X1bmKvcBZHub3qcaFCOkw4zeIWB8j3YM570deV5CKEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK10cCqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23CDC4CED6;
	Mon, 24 Feb 2025 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395822;
	bh=EoW60TsbX+PVkHaLYf0CRmSChSo/i0ceG54/YtQ3yNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CK10cCqjj90vTi8cGFp1eJA0iDfxF3q7xTax0FpE2erkAgGR8+mfMuW1r77oQ1DgN
	 o8E28NasoHEXIZATKZO+38PtYBqANnXE2X1tD1XptdWZONXz7uIQSIJtDqx1jX6MGb
	 7gXNBRY6N4PeaJVPK8a21G77ztPkctDz+JLD5Okj7gGU/HI7R6b+xh49ITv9CnQezp
	 1tdNDLa6YJqZxDRN3eji/0E4JLlkL0DbI2div2nhbEb+BdR5ruuyUeUYUzw7PJC3jd
	 KYSy+h6Ladq1wks+xsmgjAifLk/3FBlkmB96AVW+7wrgMekSKKLfaqMEGohOkpH7eE
	 VGSK9ojW4LDlg==
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
Subject: [PATCH AUTOSEL 6.13 08/32] ASoC: simple-card-utils.c: add missing dlc->of_node
Date: Mon, 24 Feb 2025 06:16:14 -0500
Message-Id: <20250224111638.2212832-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index 24b371f320663..5b6c2f7f288a0 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1103,6 +1103,7 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 	args.np = ep;
 	dai = snd_soc_get_dai_via_args(&args);
 	if (dai) {
+		dlc->of_node  = node;
 		dlc->dai_name = snd_soc_dai_name_get(dai);
 		dlc->dai_args = snd_soc_copy_dai_args(dev, &args);
 		if (!dlc->dai_args)
-- 
2.39.5


