Return-Path: <stable+bounces-164459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4DB0F4DF
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA1F188930D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A12F2C49;
	Wed, 23 Jul 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiyOj1cQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86436221F13
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279463; cv=none; b=MeWg/lA8OLj7FYLu03Py//m1dPDtfcW7hZYzqce6DfTScHBHzwSj70Qgfitstyw+Zicrvlm7Lf78aAHoi/latdpataS/VNwAr+eF1kVidBsGf8UHZWc9l/zzym9Gf1wTH82Yqm2NfzyYI8SFH8l+W5Ff8Uy9/8RBBf9G+ruIx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279463; c=relaxed/simple;
	bh=BHQLqGGmwUeusbqTGv+KTHv9iZ/cPfCw6by+aTDg4RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bL7MZ39pW3PTWV6we0ntbXxoIVFs4iNQAhgBue4SX0Jtrpf3p4m5tlYQkiLWowZCLaPjsEC9zS4SmqUOOOaxZ6d4BqqEPK3unD36FSnVifpYXTer/1DTmg6lOoHpq3i+lv5L+HfMAnwJtvFZ3waYvlj7Ur/AHRBbjvgoiTFi+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiyOj1cQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50BDC4CEF1;
	Wed, 23 Jul 2025 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279463;
	bh=BHQLqGGmwUeusbqTGv+KTHv9iZ/cPfCw6by+aTDg4RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiyOj1cQIt8Si2Lh5jyiuGnlFtcMyEp/CHsL7z4CpKRii+PVUw0Qyn1DfSAfiOt29
	 X0C6LSqjNMb6qKQvotBYnLQIklwcBqVLrc40I5wxUAg2T8x6MTX8RLQmNDX5NKntXr
	 ApyLYqwG4srj3sPv1tcnD9TRXoY+aF564Iti1c+MpZ08QE6a9JqSa6yPJOBuQqtiMo
	 vSvgRrgQLVlbbavTNoS1cVmltu7BOhaU7bComsb/r6BPvWyl4HtItDFSLH9erWsMh4
	 ClWWusf8ZuLAoQm4V2OGnbaRu5Q1LOebeZ9P2elZ/oaOJVynqTi7N4ecpNOG5usDH6
	 5tOXDJ2Ivr4kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Dadap <ddadap@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: hda: Add missing NVIDIA HDA codec IDs
Date: Wed, 23 Jul 2025 10:04:14 -0400
Message-Id: <20250723140414.1089892-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723140414.1089892-1-sashal@kernel.org>
References: <2025071243-supermom-obedient-408a@gregkh>
 <20250723140414.1089892-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8dc0476bce4c1..3388e407e44e2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4556,7 +4556,9 @@ HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0034, "Tegra264 HDMI/DP",	patch_tegra234_hdmi),
+HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
@@ -4595,15 +4597,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
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


