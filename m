Return-Path: <stable+bounces-94961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA709D717F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C31163CE0
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EE71E1055;
	Sun, 24 Nov 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm2zmiWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047C1AF0DD;
	Sun, 24 Nov 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455416; cv=none; b=M2Gv3FOtgYWqRi7ASy6Z5PcCCuNJzU2BDt9IA2ppzOY7TC268z0R3xUu3Gy4g3ePkUcAhIpUlHYvE7BdcdkEEDcqKoCtBTqX+G3/EQ4jZKeOR3LFl2Z/CN/MgrmI/P8VoXVhSo6au04BqWrRWNkongRetyzLfk7u2daiFWThmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455416; c=relaxed/simple;
	bh=jlYImcx9wO2XluO1gIR1709Evon4tIC0qHQxrNv6DEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXnvctRX8URbA4Kq9c5ulFyLF53mLIxUIGc4zxBBY6gcjMwY7+NQ9tJDwBamFWRbiOlhdn2t6cyfxKXr3Np3d3sVtv8NYAKqSVB1pRV3aI//Dy61Px5Aw+58+MO6L7oT+EEVDz0hXMPikxGidnCMBH5hrhU5dyYv+C4AxWED2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm2zmiWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A52C4CED3;
	Sun, 24 Nov 2024 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455416;
	bh=jlYImcx9wO2XluO1gIR1709Evon4tIC0qHQxrNv6DEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nm2zmiWBJIyZxgK9Kc9XuBw7iMIm6mvAU46AL1htYCMhsRJh6rx4r6L2pgnXYiy6s
	 I8kgp64Y7z9QLILzRGR313asXEr96ah/B+Kv0W16t/NpnUeEuk7GmSSLN8sy79OjcC
	 sLPSOSOUsqsMH+ZT+1KDqxwIS6H6gFNDsKXwiFlAp4TnOMLxpwHy2o8JyT1OzuYu6j
	 +PxXisdd+tMNRGRDHtZLhwgNowUmW1SumdGEWUq6Na92yb4+iec1qV+JR2ivHZ/y0E
	 PG4ytWO8HDGGVXrWQYtbnulU50ib8JxZB0h1cQVkEgg3UblLmHuSzU2KwZHF5jTy1z
	 z7QkDffsnLXzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mac Chiang <mac.chiang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	Vijendar.Mukunda@amd.com,
	naveen.m@intel.com,
	ckeepax@opensource.cirrus.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 065/107] ASoC: sdw_utils: Add quirk to exclude amplifier function
Date: Sun, 24 Nov 2024 08:29:25 -0500
Message-ID: <20241124133301.3341829-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Mac Chiang <mac.chiang@intel.com>

[ Upstream commit 358ee2c1493e5d2c59820ffd8087eb0e367be4c6 ]

When SKUs use the multi-function codec, which integrates
Headset, Amplifier and DMIC. The corresponding quirks provide
options to support internal amplifier/DMIC or not.

In the case of RT722, this SKU excludes the internal amplifier and
use an additional amplifier instead.

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20241028072631.15536-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index c06963ac7fafa..e6ac5c0fd3bec 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -363,6 +363,8 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.num_controls = ARRAY_SIZE(generic_spk_controls),
 				.widgets = generic_spk_widgets,
 				.num_widgets = ARRAY_SIZE(generic_spk_widgets),
+				.quirk = SOC_SDW_CODEC_SPKR,
+				.quirk_exclude = true,
 			},
 			{
 				.direction = {false, true},
-- 
2.43.0


