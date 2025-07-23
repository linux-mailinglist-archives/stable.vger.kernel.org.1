Return-Path: <stable+bounces-164461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0ADB0F4F7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55C8188CE84
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA92D948B;
	Wed, 23 Jul 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uor5SQPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3628FFE6
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279848; cv=none; b=rBA4I1527B+N0r6/HoPoocsWOPCdKnh8vBEe5+4RVw212Z+FKN+1aKqjDehdGWFCFi+ZzIcX7aJarI87VFgUEubORYGLtCS2Flfc+fsplbRCkkDNlnLsTELuG/UT0ci1hpEqmG3ceq9hfI1ZlGic2dDg7JEfnXVlAwOUuq66r+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279848; c=relaxed/simple;
	bh=28q0llUXpLY3Y2+cUAWBtUXip4vXg0VP0PBRho59j8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lvxE65pSd7GVi91j74RrrE7APvEoTJ0m7XKTeiAhCNH/R3l9uph1UUQ2JUl1V0spf7oQ0vfaBL8dQ1Hpfi7BqqpnixnT9go1k3wxGnBrZuVXVpx74hMcxVBi0KG33Zz37iWmCa2x0sZMQubxy1Qr0FTOk0xk2dghFOmjDa7/Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uor5SQPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BB4C4CEF1;
	Wed, 23 Jul 2025 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279848;
	bh=28q0llUXpLY3Y2+cUAWBtUXip4vXg0VP0PBRho59j8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uor5SQPftturDB67now21a9aGMe5funmy13IglMWOUzPjSmhO/BTuvBJWmOm4OQKN
	 UWZHw9rA8vX9/YXRhduIrFPvTERm9Bpnz36W7ReC8TVdXm2Ckq26azFtjDT/Kte4UF
	 G3Sdcgx+YjMsgwblIhZd/xLuqIgbNW8Rpxkni3rgZZrjQvt9OtqbI0k7fzKaIfr5FB
	 b43KGvMhjrommYJvs8FqkDsNXZwRF4k9oaz99ScxiLTVHrl+oP2RUE4bg+Ru9m9djV
	 HoRcYKRTxOQXnm7mwEKAGq33ZoEmTYPSI8SfZFDnwyEu9s22OloQdvIIOspgDn6+zJ
	 7za9k/H41tXug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Dadap <ddadap@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda: Add missing NVIDIA HDA codec IDs
Date: Wed, 23 Jul 2025 10:10:42 -0400
Message-Id: <20250723141042.1090223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071244-canon-whacky-600c@gregkh>
References: <2025071244-canon-whacky-600c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Dadap <ddadap@nvidia.com>

[ Upstream commit e0a911ac86857a73182edde9e50d9b4b949b7f01 ]

Add codec IDs for several NVIDIA products with HDA controllers to the
snd_hda_id_hdmi[] patch table.

Signed-off-by: Daniel Dadap <ddadap@nvidia.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/aF24rqwMKFWoHu12@ddadap-lakeline.nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ change patch_tegra234_hdmi function calls to patch_tegra_hdmi ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 81025d45306d3..fcd7d94afc5d5 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4364,6 +4364,8 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
@@ -4402,15 +4404,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009b, "GPU 9b HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009c, "GPU 9c HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a1, "GPU a1 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a8, "GPU a8 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a9, "GPU a9 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00aa, "GPU aa HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ab, "GPU ab HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ad, "GPU ad HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ae, "GPU ae HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00af, "GPU af HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b0, "GPU b0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b1, "GPU b1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c0, "GPU c0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c1, "GPU c1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c3, "GPU c3 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c4, "GPU c4 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c5, "GPU c5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x67663d82, "Arise 82 HDMI/DP",	patch_gf_hdmi),
-- 
2.39.5


