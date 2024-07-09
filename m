Return-Path: <stable+bounces-58845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6E92C0AA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB77C1F235E9
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681521019C;
	Tue,  9 Jul 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwCjdLDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EE210194;
	Tue,  9 Jul 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542263; cv=none; b=QEqwwoTTbzg/xZkORvUVBcmzE+PEOi4g/Mw3FFRTJlXl7iy368V66PI2ouBvE69j8GMotAWnM3DxWv5Q12Smji8aWcpHJ9oQ4/bNHqEMVRC6KhzHO8mzuoWbFjCq8yXryHo3RcjL8s8EvsubC1SDe3AHgMm8LZjgJxMthdoofE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542263; c=relaxed/simple;
	bh=5W/QzPF8+BWOt969D2s3ygEH36m4oDYPYOL1Vrb6Qls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNbWriaHzPTmYHVLAiv2STulD+P/xeh1NgiTNdy7S/jowrR0ODXKJoJff/oRLPQJ2hJfkF+Mf/RBBamHQ83nRc53uu1tRkcE8yczDA2KjSL1z7Al1WrracdBU6zpDFeo/srUVvkuf6bvEcv4lKu+nH32Ra5caTfM6GyLhYfMwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwCjdLDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4329EC3277B;
	Tue,  9 Jul 2024 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542262;
	bh=5W/QzPF8+BWOt969D2s3ygEH36m4oDYPYOL1Vrb6Qls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwCjdLDX7nmljEcA+tekukCzhTAzLAO2BWpaIgSOznNIAKJUJ4jbsYkNWc/JijyoN
	 4gQQbJoiUYB+8lBlBU1M13cPMgyVCFT/3QCf/nss+XP1QjOr+Ct5OrmBASHCDPlVQu
	 YoHemJnpkk83E+VFwfRo/QGvP++UzRJWKNwqN9jRM/9/A89+2B+HJlMx/0ZXKOrxUA
	 PXvxw0gnNJEUg9kKHCXK7asY+eM0w6kPImbsBW2QylMH15MSuT3SN3G0gqh69Y0/aE
	 0JnZlfAR2hmc+HEh8immmdVo37wmz7yIKY7BPj2iKYTffRFwCpIbZiXIgqNo5qB8Rh
	 jfRCxVKi9razw==
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
Subject: [PATCH AUTOSEL 6.1 10/27] ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback
Date: Tue,  9 Jul 2024 12:23:24 -0400
Message-ID: <20240709162401.31946-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
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
index 061ab7289a6c3..b1141f4478168 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -328,7 +328,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
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


