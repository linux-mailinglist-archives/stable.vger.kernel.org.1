Return-Path: <stable+bounces-58777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B6292C012
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6F1B2B551
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A161A2C37;
	Tue,  9 Jul 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om4DPKyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E71A2C27;
	Tue,  9 Jul 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542044; cv=none; b=JiOdV+nHq6d2YxW7W1nJqX/CwgacMYJcOAlrkVcuEJng7nziHIXvSsk9w6aFxwBupU4OW3ErF2CEnFsMv3m5Bhjtb+176sfUD1L7+zt6bhCvN6PMVqYSAU5buG7pRFdxs/bEmsCSnpX4bdw/1ikcpGs11iEnQFag0K9bHFLAPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542044; c=relaxed/simple;
	bh=+n8/vrOXVDBI5bEZRqWDXQIzeBUFPT4Rqrxc7p0dfrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kbbq4cP4kX935GSwxt3eXr1dHUmFsy1IUH91x59TtQjFOD/Y+m5Za7fU6CSqWoJ1WJGgGa3fikoEAIu0eKLkimDTb/FexqC952DJWsAushKFBVa1xofdhJ66nKeRIXipmOA2PRZuFtT3fd2sYgz5rguT/yWFLRS2/nDlQ4tZALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om4DPKyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A534C4AF0F;
	Tue,  9 Jul 2024 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542044;
	bh=+n8/vrOXVDBI5bEZRqWDXQIzeBUFPT4Rqrxc7p0dfrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=om4DPKyZDtJgD4hJV0Jq8aWWdA2nka27kRS4ztJl1Qbdx66st8rLflK+JIwdRxa3B
	 Mve4E6JN53xgjPgSeVxgh+HDa0xFjQGEmCDYrh8yVGAUTCSAy9u81Nf+NZZ7PvuQmM
	 FdCUe6+Yw2M1r7iBm9nmPtQ7COCuYdoJ6nIGOiHcCLN/018QiDBma2k1ihhto8qAku
	 gOXPJfH+ZLdFkNgrAqqvSVavGoL41/6Jr8cRCLEU9ifq7jRWYaYcy0f1Qg2YhjME/J
	 WvGV2cM/JnuBrz/sf2jieFuNmlQRlLWhO6z09d0yBIFo3wg1dsYNnfwFazW4HSMWdQ
	 bLlYQrk8JdP9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 15/40] ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback
Date: Tue,  9 Jul 2024 12:18:55 -0400
Message-ID: <20240709162007.30160-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 6f2a43e3d14f6e31a3b041a1043195d02c54d615 ]

If the ipc_prepare() callback fails for a module instance, on error rewind
we must skip the ipc_unprepare() call for ones that has positive use count.

The positive use count means that the module instance is in active use, it
cannot be unprepared.

The issue affects capture direction paths with branches (single dai with
multiple PCMs), the affected widgets are in the shared part of the paths.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20240612121203.15468-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index e693dcb475e4d..d1a7d867f6a3a 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -485,7 +485,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
 			if (ret < 0) {
 				/* unprepare the source widget */
 				if (widget_ops[widget->id].ipc_unprepare &&
-				    swidget && swidget->prepared) {
+				    swidget && swidget->prepared && swidget->use_count == 0) {
 					widget_ops[widget->id].ipc_unprepare(swidget);
 					swidget->prepared = false;
 				}
-- 
2.43.0


