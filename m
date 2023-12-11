Return-Path: <stable+bounces-5363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000D80CB69
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6969CB2137F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150647765;
	Mon, 11 Dec 2023 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUDRA2e4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75938DD0;
	Mon, 11 Dec 2023 13:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA59C433C8;
	Mon, 11 Dec 2023 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302735;
	bh=Y14sf/IUPwBLYu+5nkTsbDeUTC00rHFDrEquURAriTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUDRA2e4Ls4r9wFERkzIj8SUD8ojJDIJn0M1YIY7/ge3BtoEDCQcG8ojlCWvI1ppF
	 l7jMeAqJKLLTblQWlC/j7gh5WeRvs7cc9cZIqmxsu1vrUuJ80s5ZKV0pGa0sr3AvUt
	 FJJz4LQNjW3W8qj9qCIlyfmQKUXEaSCyHE01EgjIne8r98X8Tuh95qBeNmLISt03Jz
	 XsZaXOkhFg8Cy+/vVoXF5bC1kOEXiMxLtuaoS6bIgt6aNc61LI6zycvoUjEVRitvNJ
	 Qo0yLrArmtXyoOaYhr5vMlK3tBGNyeEd4QHPXHngWC+Luat5OdtcpZwv2jMwATLT6O
	 qA+AUBAlIOoHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kamil Duljas <kamil.duljas@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/47] ASoC: SOF: topology: Fix mem leak in sof_dai_load()
Date: Mon, 11 Dec 2023 08:50:09 -0500
Message-ID: <20231211135147.380223-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Kamil Duljas <kamil.duljas@gmail.com>

[ Upstream commit 31e721fbd194d5723722eaa21df1d14cee7e12b5 ]

The function has multiple return points at which it is not released
previously allocated memory.

Signed-off-by: Kamil Duljas <kamil.duljas@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20231116213926.2034-2-kamil.duljas@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index a3a3af252259d..37ec671a2d766 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1736,8 +1736,10 @@ static int sof_dai_load(struct snd_soc_component *scomp, int index,
 	/* perform pcm set op */
 	if (ipc_pcm_ops && ipc_pcm_ops->pcm_setup) {
 		ret = ipc_pcm_ops->pcm_setup(sdev, spcm);
-		if (ret < 0)
+		if (ret < 0) {
+			kfree(spcm);
 			return ret;
+		}
 	}
 
 	dai_drv->dobj.private = spcm;
-- 
2.42.0


