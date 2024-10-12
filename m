Return-Path: <stable+bounces-83522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5199B37E
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77A31F22658
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402311993A9;
	Sat, 12 Oct 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJZcFpUI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35F199249;
	Sat, 12 Oct 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732398; cv=none; b=Np2eHlqcT5tpsyeuUcDfzRxhPxy3Gp/hvr59QVC8rul6MSlrNUL235Kt1HXpzq9GgpKhQyGa+5fLn0OuBpHHjfIVDzCAirda9sQe+Fpzb5TU+UrhSFpqrGDSB0ecWvIl+WiAv9LtgiksIHIT++0e/d3ulRKM8ZnKllgxnwF9euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732398; c=relaxed/simple;
	bh=1skIrtuzhEdXdjRYtE21RMLEdVtdi4q6N2SdiwO/CYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0f2h8KghxEFGwjzyUmLcUZXa+qv/+gPdxGp9N8GalaxTVsL2/lQ/6w3QotU6s6m836BbaeP0lesW2nY09N6hkyQVbkMf0HoLXhSA75hXR55gVy5NRa8J27Sc0uaYmfVmcYv88mhSSq5rSZPkVic3xsFERw20sApptoY9ZqhFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJZcFpUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46074C4CEC7;
	Sat, 12 Oct 2024 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732397;
	bh=1skIrtuzhEdXdjRYtE21RMLEdVtdi4q6N2SdiwO/CYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJZcFpUIv1dWhYNnZz18aKsryFyNJLddQC4u7b0EE90SlxTD8hrwhBzX7bBERZKcD
	 2ET7mWyl5b6ITd+BO2qlsm8T2Lx9ORP1tlnHubRcbZURvwcupwV2vU3m4wCmEBNmop
	 B+Ron8EqU3R+oDrsaT8gBv4S1ek0OfVQSpiNEy1LonoNnfXV5ud4dn78hW9Q0krYEX
	 fWGUhe6evH6qgEKN3RCTs/2L6SI+/fvfOHasEdFVKfM1/Gdt5VgVWKsZHyFxkvVPcy
	 aoSUG0r58zjYIUX083xcyHq78qmrgUeMJhuSzwY6MCuAkHd1sFr0wOblJ3RPXw549x
	 bUHSFmJLfm2Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Zeno Endemann <zeno.endemann@mailbox.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	tiwai@suse.com,
	tglx@linutronix.de,
	cezary.rojewski@intel.com,
	yung-chuan.liao@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	songxiebing@kylinos.cn,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 08/16] ALSA: hda: fix trigger_tstamp_latched
Date: Sat, 12 Oct 2024 07:26:04 -0400
Message-ID: <20241012112619.1762860-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Jaroslav Kysela <perex@perex.cz>

[ Upstream commit df5215618fbe425875336d3a2d31bd599ae8c401 ]

When the trigger_tstamp_latched flag is set, the PCM core code assumes that
the low-level driver handles the trigger timestamping itself. Ensure that
runtime->trigger_tstamp is always updated.

Buglink: https://github.com/alsa-project/alsa-lib/issues/387
Reported-by: Zeno Endemann <zeno.endemann@mailbox.org>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://patch.msgid.link/20241002081306.1788405-1-perex@perex.cz
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hdaudio.h        | 2 +-
 sound/hda/hdac_stream.c        | 6 +++++-
 sound/pci/hda/hda_controller.c | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 7e39d486374a6..b098ceadbe74b 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -590,7 +590,7 @@ void snd_hdac_stream_sync_trigger(struct hdac_stream *azx_dev, bool set,
 void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams);
 void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
-				      unsigned int streams);
+				      unsigned int streams, bool start);
 int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
 				struct snd_pcm_substream *substream);
 
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index b53de020309f2..0411a8fe9d6f1 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -664,7 +664,7 @@ static void azx_timecounter_init(struct hdac_stream *azx_dev,
  * updated accordingly, too.
  */
 void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
-				      unsigned int streams)
+				      unsigned int streams, bool start)
 {
 	struct hdac_bus *bus = azx_dev->bus;
 	struct snd_pcm_runtime *runtime = azx_dev->substream->runtime;
@@ -672,6 +672,9 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 	bool inited = false;
 	u64 cycle_last = 0;
 
+	if (!start)
+		goto skip;
+
 	list_for_each_entry(s, &bus->stream_list, list) {
 		if ((streams & (1 << s->index))) {
 			azx_timecounter_init(s, inited, cycle_last);
@@ -682,6 +685,7 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 		}
 	}
 
+skip:
 	snd_pcm_gettime(runtime, &runtime->trigger_tstamp);
 	runtime->trigger_tstamp_latched = true;
 }
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 5d86e5a9c814a..f3330b7e0fcfc 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -275,8 +275,7 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	spin_lock(&bus->reg_lock);
 	/* reset SYNC bits */
 	snd_hdac_stream_sync_trigger(hstr, false, sbits, sync_reg);
-	if (start)
-		snd_hdac_stream_timecounter_init(hstr, sbits);
+	snd_hdac_stream_timecounter_init(hstr, sbits, start);
 	spin_unlock(&bus->reg_lock);
 	return 0;
 }
-- 
2.43.0


