Return-Path: <stable+bounces-134778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8FA9502F
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F54917171A
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4E263F38;
	Mon, 21 Apr 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JM0Vqkxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5926156A
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234808; cv=none; b=TqNff9y5y7eY3oY1kM6GM0IT/+otw4S9s6lgao7BX0AMMAEkIbafoIQsQaBV8Rs7387PfK0DSatH1/BPLtEn6NP0+lipzSehR5ZqXtu1cjN0CjsCBsDEtRo/D5MtAMPY7cPNWOqzb3DhdwJ7+vblQby0UVasr0JcFgZZN56Pr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234808; c=relaxed/simple;
	bh=sDfOgfxCxa5knDlM2rbUL8/5sRPeWFd22Hfj0I9GQCM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u9Hi4EKA4kDjHlDwTe+YStTnuzJkE74cscDOA6g3ktOZDTv+4K/ihYFfd6wBbgcdPr1Q2garugy3Yoc0WdAui0Ada8OTPidoUKzB2bN0uvAoKo+MQ/eKziyncLq3FajZtH/Gzo7F/HQeZ5O/xxCow75HV8umLIa4EVYLafFmgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JM0Vqkxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ECBC4CEE4;
	Mon, 21 Apr 2025 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745234808;
	bh=sDfOgfxCxa5knDlM2rbUL8/5sRPeWFd22Hfj0I9GQCM=;
	h=Subject:To:Cc:From:Date:From;
	b=JM0Vqkxn0xkeZ0hzbv4xE+LJLFfC83dOrql6ytuAO4jjBQRbLJh3SrHavO3fub3Je
	 GvS7k6qXZ8Asv/3rwDZ/Zk7OtmtEn6snK82Mt7P664eEPidZF9hI/kLiWGnaZxBvxm
	 cfVyekJFPATWPOTOBuvF6FVmj4fAVTTaVXja9RJM=
Subject: FAILED: patch "[PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on" failed to apply to 6.6-stable tree
To: herve.codina@bootlin.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:26:45 +0200
Message-ID: <2025042145-scrunch-freckled-e48e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9aa33d5b4a53a1945dd2aee45c09282248d3c98b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042145-scrunch-freckled-e48e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9aa33d5b4a53a1945dd2aee45c09282248d3c98b Mon Sep 17 00:00:00 2001
From: Herve Codina <herve.codina@bootlin.com>
Date: Thu, 10 Apr 2025 11:16:43 +0200
Subject: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event

On SNDRV_PCM_TRIGGER_START event, audio data pointers are not reset.

This leads to wrong data buffer usage when multiple TRIGGER_START are
received and ends to incorrect buffer usage between the user-space and
the driver. Indeed, the driver can read data that are not already set by
the user-space or the user-space and the driver are writing and reading
the same area.

Fix that resetting data pointers on each SNDRV_PCM_TRIGGER_START events.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://patch.msgid.link/20250410091643.535627-1-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index b2979290c973..5614a8b909ed 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -250,6 +250,9 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		bitmap_zero(prtd->chans_pending, 64);
+		prtd->buffer_ended = 0;
+		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
+
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			for (i = 0; i < prtd->channels; i++)
 				prtd->qmc_dai->chans[i].prtd_tx = prtd;


