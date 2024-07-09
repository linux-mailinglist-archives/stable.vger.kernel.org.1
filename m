Return-Path: <stable+bounces-58814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5402F92C050
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9B81C2405A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B11C0946;
	Tue,  9 Jul 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCUB4HR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD71C093B;
	Tue,  9 Jul 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542172; cv=none; b=DOBxNcanUCbzciOqX09Z7i6TPQ5ocEDkDz+PENam/3UHHjz48l4SSgrogPtAuLtMHnTPUjXo6JwqZtAb4ynz58L4BVpb8hGZvXUfMY/4+QHRfIBq8e7qvI5SI0S64Vy8yEDDkhnElx18n5jIwtGIIs4LHGiuhaCVyFjr3IdRiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542172; c=relaxed/simple;
	bh=xHTnpCTyYx69gmm6zKiKpZD00ytCtT0Ijj3HsnjAZgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t32NKOyc5oI5Mo+DIZ2lTXSdZA4Q9XoIwU4nua3aTyCTxedx/rTZAJ5Qv6FWoWSG3gq2WXm/Z2ngtRFDbhbp6fD6lyWTF9W1G7Z0oE2ENbgJ4DPURlEud4oxcIk5iSlFTNQaEIQJ+rQeknH4KbHKwgNoqhlYAJTBvHY5ZqsQeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCUB4HR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6855C32786;
	Tue,  9 Jul 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542172;
	bh=xHTnpCTyYx69gmm6zKiKpZD00ytCtT0Ijj3HsnjAZgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCUB4HR1q1L0HRIObOrRl5xnt0ge1bp9cRuxsrXfNR4XmwsN+Bwzfh4hONkFDBwN6
	 0UNcWMteYbh9ofsp9rgj+kLa6vijTgyK4zIzwxB1fy4NpN6xh5xPH2fiwSZyfMlMbD
	 m56F1QEkVRtD8FpvS0W31vlTsByE8lIj/KLMUKHrKxRAXCbVZFyeV/w2jW7OPveskG
	 nZqOt6Cr3Yno+boiSxJ11iPyFWFAPixh9CQ4Y6X+fSaE8QKy16ogmKT7KgvloUBj6B
	 ct+zPdkF+aXWXXyCgnTXE1bBRvCYZ00z/B/3wfZxXVPPSebYTcdreAgvePklSsxdNd
	 lrY/dpfa+U5dw==
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
Subject: [PATCH AUTOSEL 6.6 12/33] ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error rollback
Date: Tue,  9 Jul 2024 12:21:38 -0400
Message-ID: <20240709162224.31148-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
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
index 77cc64ac71131..5162625834725 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -488,7 +488,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev *sdev, struct snd_soc_dapm_widget
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


