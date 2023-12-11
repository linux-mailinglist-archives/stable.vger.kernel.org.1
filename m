Return-Path: <stable+bounces-5398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA680CBC1
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CBC281F55
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE447A59;
	Mon, 11 Dec 2023 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyVcthlf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22647A4D;
	Mon, 11 Dec 2023 13:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F71C433CB;
	Mon, 11 Dec 2023 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302835;
	bh=pAKtpCP51RGpgiL/qardfqdOd9aodzvn0LyUO+jeRT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyVcthlfWek/VIsDk5GA6ZPvmhDIzxF4tX9zWd1y0EwjOJkTRUTvHTseNROwkOwli
	 uZkg1E2WMlE9yqag6yyOx4yev5qB2uZFlr4w6eF8aMSSzmlF3AI5SIHCEl1Pmz8m8T
	 YUuQCEFi8+VPCQmS1W+MYgjnzWkWchp1E9SiKY44HI89Lwm3WLMRI7n+LApNwf4U6L
	 1L/EOsKOWCTUBrf3DcokOxzLsKP7BI5LgEN9evTfwwttnPHtIhYq+OUznno2xhKO4B
	 Bv66/A3rDD7u2ofA4h83MO+7sgZ8MuezmnzBLdQOhU3pvhWvPc3viLVtYFbpdWEwwq
	 4NLjRlXSkQUbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 43/47] ALSA: pcmtest: stop timer before buffer is released
Date: Mon, 11 Dec 2023 08:50:44 -0500
Message-ID: <20231211135147.380223-43-sashal@kernel.org>
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

From: Ivan Orlov <ivan.orlov0322@gmail.com>

[ Upstream commit eb99b1b72a424a79f56c972e0fd7ad01fe93a008 ]

Stop timer in the 'trigger' and 'sync_stop' callbacks since we want
the timer to be stopped before the DMA buffer is released. Otherwise,
it could trigger a kernel panic in some circumstances, for instance
when the DMA buffer is already released but the timer callback is
still running.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Link: https://lore.kernel.org/r/20231206223211.12761-1-ivan.orlov0322@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/pcmtest.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b59b78a092240..b8bff5522bce2 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -397,7 +397,6 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
 
 	timer_shutdown_sync(&v_iter->timer_instance);
-	v_iter->substream = NULL;
 	playback_capture_test = !v_iter->is_buf_corrupted;
 	kfree(v_iter);
 	return 0;
@@ -435,6 +434,7 @@ static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		// We can't call timer_shutdown_sync here, as it is forbidden to sleep here
 		v_iter->suspend = true;
+		timer_delete(&v_iter->timer_instance);
 		break;
 	}
 
@@ -512,12 +512,22 @@ static int snd_pcmtst_ioctl(struct snd_pcm_substream *substream, unsigned int cm
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
+static int snd_pcmtst_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_delete_sync(&v_iter->timer_instance);
+
+	return 0;
+}
+
 static const struct snd_pcm_ops snd_pcmtst_playback_ops = {
 	.open =		snd_pcmtst_pcm_open,
 	.close =	snd_pcmtst_pcm_close,
 	.trigger =	snd_pcmtst_pcm_trigger,
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
@@ -530,6 +540,7 @@ static const struct snd_pcm_ops snd_pcmtst_capture_ops = {
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
 };
-- 
2.42.0


