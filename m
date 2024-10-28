Return-Path: <stable+bounces-88988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51369B2D69
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4851F22AAD
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D271D95AA;
	Mon, 28 Oct 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORSAyh+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB621D9598;
	Mon, 28 Oct 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112671; cv=none; b=j5bvRtT0r5qyxzENpfF16bHf28RKqcKO1lEY64A/IR44PIj02SMyQvdX7i2lhL7BqlerHv1NrGN3nBHHMwLvg14bpYTHDWtrbKI/w6pWbgQ+9XovSjNV39YlNGhE7W1Leh1TPR1c7zfD9/R+iZCFZkSxrlkXfg0KeFH8eseeUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112671; c=relaxed/simple;
	bh=rmkLRByoW5Lccq/GvFPXliwqdCfsgMTs+7Q5rUWlJ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErBzTU2InA5R0zihpC6o604ZX6IZbaIdg8UZ50+1koarby6gPlpsgKi8E/fe6nMQoplPopmZ9twjQyfmSOKzo1e3FHRvguMQX18UmFBs0OTmAjfgnxqejH7NOC5QPylhcPV6bvnxRZhbKzi/4q5K4Xy6dO8Ogss/3QOB+iEAWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORSAyh+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A9C4CEE7;
	Mon, 28 Oct 2024 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112671;
	bh=rmkLRByoW5Lccq/GvFPXliwqdCfsgMTs+7Q5rUWlJ6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORSAyh+/cTaD0VH/HAm7cSrIsZs6XtvWHS2lWTUkeGRU/oCU2Wi3J0SmaVXcuvy9c
	 B88oIZcjlWzFbVS6p/OQq+9/gFJhvE2FKIy5qoZmxboM5MyXFsGCS+zE/atRAI0rDX
	 l01fwTicCkykGUrGLzKgUIi6nj/dhzoS15EDCd1CI8xKr2/PeJSabjpAGnQ64HKVN8
	 vtUt9F8918ETt0QQJQnjwEe3DMEdcx2fGFpnzmTDmta/8Ea7KwEXUnViQgu01rL64P
	 ElskUvFua1AoOtKFX/jhHX4aTDIhX0QQuzu7iOuFFRiEojFnoJt+0+aCJE4PVahFeG
	 ulxczJQ/L0aBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/32] ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
Date: Mon, 28 Oct 2024 06:49:48 -0400
Message-ID: <20241028105050.3559169-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit 9822b4c90d77e3c6555fb21c459c4a61c6a8619f ]

For aggregated DAIs, the node ID is set to the group_id during the DAI
widget's ipc_prepare op. With the current logic, setting the dai_index
for node_id in the dai_config is redundant as it will be overwritten
with the group_id anyway. Removing it will also prevent any accidental
clearing/resetting of the group_id for aggregated DAIs due to the
dai_config calls could that happen before the allocated group_id is
freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
All: stable@vger.kernel.org # 6.10.x 6.11.x
Link: https://patch.msgid.link/20241016032910.14601-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 87be7f16e8c2b..240fee2166d12 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3129,9 +3129,20 @@ static int sof_ipc4_dai_config(struct snd_sof_dev *sdev, struct snd_sof_widget *
 		 * group_id during copier's ipc_prepare op.
 		 */
 		if (flags & SOF_DAI_CONFIG_FLAGS_HW_PARAMS) {
+			struct sof_ipc4_alh_configuration_blob *blob;
+
+			blob = (struct sof_ipc4_alh_configuration_blob *)ipc4_copier->copier_config;
 			ipc4_copier->dai_index = data->dai_node_id;
-			copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
-			copier_data->gtw_cfg.node_id |= SOF_IPC4_NODE_INDEX(data->dai_node_id);
+
+			/*
+			 * no need to set the node_id for aggregated DAI's. These will be assigned
+			 * a group_id during widget ipc_prepare
+			 */
+			if (blob->alh_cfg.device_count == 1) {
+				copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
+				copier_data->gtw_cfg.node_id |=
+					SOF_IPC4_NODE_INDEX(data->dai_node_id);
+			}
 		}
 
 		break;
-- 
2.43.0


