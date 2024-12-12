Return-Path: <stable+bounces-102969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B09EF44B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC41928E6F8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90967216E3B;
	Thu, 12 Dec 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovEWHg4o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC50213E6B;
	Thu, 12 Dec 2024 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023143; cv=none; b=tn4hv4h9KbsB9SY37q8lJztCvQHhpnf1NORIzAzOGoiXtP27YJUqeofd81D8A/sSt1AAMR7Va6zSofd6koCFZCCR1woqAlvfJ3Od2jjhOIvlGvVmqA9v9bCxSTazLpl/attImFBZPX4Qesu+/FpWaItc0wNlE2u/oNxJrShHb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023143; c=relaxed/simple;
	bh=sO+Wl5Xgt8K3N8u3p/UoAvQvyA30x+9pw+XK4+hT25o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNhK1EEg5Z27Qc0kdWHf5Fod9gI99ugB5fj1EUrzlYaSZ99+SRYmHK6LiVizSwzSgPFgWlMHBZWdv9rZyc8UiSoP7p4HuA8vsnvAu94s8j9ggnSEkzbKJHXLxoWXEMbULFzZGIc8obRjtGnHKWanArzH1rQyM4Ba5iEmYw1Z6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovEWHg4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8701FC4CECE;
	Thu, 12 Dec 2024 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023143;
	bh=sO+Wl5Xgt8K3N8u3p/UoAvQvyA30x+9pw+XK4+hT25o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovEWHg4o+UdNPUtsYKX+Jadorsos11achR6DdzrDSXHqrxBGQml0Uo+bYe9cl3RxU
	 /GxWHGbq7+Dw2EG+xgEyIn2LbghZw1SvmTJt+tUvwhNXXZ50Yz6qRcmIWOPHvRPlQw
	 cuNUuTptytSsYVPS6EpHMGuS0E9bWmv6UaS1QIZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 437/565] ALSA: pcm: Avoid reference to status->state
Date: Thu, 12 Dec 2024 16:00:32 +0100
Message-ID: <20241212144328.958462745@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit f0061c18c169f0c32d96b59485c3edee85e343ed ]

In the PCM core and driver code, there are lots place referring to the
current PCM state via runtime->status->state.  This patch introduced a
local PCM state in runtime itself and replaces those references with
runtime->state.  It has improvements in two aspects:

- The reduction of a indirect access leads to more code optimization

- It avoids a possible (unexpected) modification of the state via mmap
  of the status record

The status->state is updated together with runtime->state, so that
user-space can still read the current state via mmap like before,
too.

This patch touches only the ALSA core code.  The changes in each
driver will follow in later patches.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20220926135558.26580-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 4f9d674377d0 ("ALSA: usb-audio: Notify xrun for low-latency mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/pcm.h      |  20 +++++-
 sound/core/oss/pcm_oss.c |  42 ++++++-------
 sound/core/pcm.c         |   9 +--
 sound/core/pcm_compat.c  |   4 +-
 sound/core/pcm_lib.c     |  16 ++---
 sound/core/pcm_native.c  | 127 ++++++++++++++++++++-------------------
 6 files changed, 118 insertions(+), 100 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index cb9be3632205c..5de4bd872fa80 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -343,6 +343,8 @@ static inline void snd_pcm_pack_audio_tstamp_report(__u32 *data, __u32 *accuracy
 
 struct snd_pcm_runtime {
 	/* -- Status -- */
+	snd_pcm_state_t state;		/* stream state */
+	snd_pcm_state_t suspended_state; /* suspended stream state */
 	struct snd_pcm_substream *trigger_master;
 	struct timespec64 trigger_tstamp;	/* trigger timestamp */
 	bool trigger_tstamp_latched;     /* trigger timestamp latched in low-level driver/hardware */
@@ -675,11 +677,25 @@ void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
  */
 static inline int snd_pcm_running(struct snd_pcm_substream *substream)
 {
-	return (substream->runtime->status->state == SNDRV_PCM_STATE_RUNNING ||
-		(substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING &&
+	return (substream->runtime->state == SNDRV_PCM_STATE_RUNNING ||
+		(substream->runtime->state == SNDRV_PCM_STATE_DRAINING &&
 		 substream->stream == SNDRV_PCM_STREAM_PLAYBACK));
 }
 
+/**
+ * __snd_pcm_set_state - Change the current PCM state
+ * @runtime: PCM runtime to set
+ * @state: the current state to set
+ *
+ * Call within the stream lock
+ */
+static inline void __snd_pcm_set_state(struct snd_pcm_runtime *runtime,
+				       snd_pcm_state_t state)
+{
+	runtime->state = state;
+	runtime->status->state = state; /* copy for mmap */
+}
+
 /**
  * bytes_to_samples - Unit conversion of the size from bytes to samples
  * @runtime: PCM runtime instance
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ca4a692fe1c36..8a458c167452a 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1229,12 +1229,12 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream, const
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 	while (1) {
-		if (runtime->status->state == SNDRV_PCM_STATE_XRUN ||
-		    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		if (runtime->state == SNDRV_PCM_STATE_XRUN ||
+		    runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm,
 				"pcm_oss: write: recovering from %s\n",
-				runtime->status->state == SNDRV_PCM_STATE_XRUN ?
+				runtime->state == SNDRV_PCM_STATE_XRUN ?
 				"XRUN" : "SUSPEND");
 #endif
 			ret = snd_pcm_oss_prepare(substream);
@@ -1249,7 +1249,7 @@ snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream, const
 			break;
 		/* test, if we can't store new data, because the stream */
 		/* has not been started */
-		if (runtime->status->state == SNDRV_PCM_STATE_PREPARED)
+		if (runtime->state == SNDRV_PCM_STATE_PREPARED)
 			return -EAGAIN;
 	}
 	return ret;
@@ -1261,18 +1261,18 @@ snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream, char *p
 	snd_pcm_sframes_t delay;
 	int ret;
 	while (1) {
-		if (runtime->status->state == SNDRV_PCM_STATE_XRUN ||
-		    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		if (runtime->state == SNDRV_PCM_STATE_XRUN ||
+		    runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm,
 				"pcm_oss: read: recovering from %s\n",
-				runtime->status->state == SNDRV_PCM_STATE_XRUN ?
+				runtime->state == SNDRV_PCM_STATE_XRUN ?
 				"XRUN" : "SUSPEND");
 #endif
 			ret = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DRAIN, NULL);
 			if (ret < 0)
 				break;
-		} else if (runtime->status->state == SNDRV_PCM_STATE_SETUP) {
+		} else if (runtime->state == SNDRV_PCM_STATE_SETUP) {
 			ret = snd_pcm_oss_prepare(substream);
 			if (ret < 0)
 				break;
@@ -1285,7 +1285,7 @@ snd_pcm_sframes_t snd_pcm_oss_read3(struct snd_pcm_substream *substream, char *p
 					 frames, in_kernel);
 		mutex_lock(&runtime->oss.params_lock);
 		if (ret == -EPIPE) {
-			if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+			if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
 				ret = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
 				if (ret < 0)
 					break;
@@ -1304,12 +1304,12 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 	while (1) {
-		if (runtime->status->state == SNDRV_PCM_STATE_XRUN ||
-		    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		if (runtime->state == SNDRV_PCM_STATE_XRUN ||
+		    runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm,
 				"pcm_oss: writev: recovering from %s\n",
-				runtime->status->state == SNDRV_PCM_STATE_XRUN ?
+				runtime->state == SNDRV_PCM_STATE_XRUN ?
 				"XRUN" : "SUSPEND");
 #endif
 			ret = snd_pcm_oss_prepare(substream);
@@ -1322,7 +1322,7 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream, void
 
 		/* test, if we can't store new data, because the stream */
 		/* has not been started */
-		if (runtime->status->state == SNDRV_PCM_STATE_PREPARED)
+		if (runtime->state == SNDRV_PCM_STATE_PREPARED)
 			return -EAGAIN;
 	}
 	return ret;
@@ -1333,18 +1333,18 @@ snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream, void *
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 	while (1) {
-		if (runtime->status->state == SNDRV_PCM_STATE_XRUN ||
-		    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
+		if (runtime->state == SNDRV_PCM_STATE_XRUN ||
+		    runtime->state == SNDRV_PCM_STATE_SUSPENDED) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm,
 				"pcm_oss: readv: recovering from %s\n",
-				runtime->status->state == SNDRV_PCM_STATE_XRUN ?
+				runtime->state == SNDRV_PCM_STATE_XRUN ?
 				"XRUN" : "SUSPEND");
 #endif
 			ret = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DRAIN, NULL);
 			if (ret < 0)
 				break;
-		} else if (runtime->status->state == SNDRV_PCM_STATE_SETUP) {
+		} else if (runtime->state == SNDRV_PCM_STATE_SETUP) {
 			ret = snd_pcm_oss_prepare(substream);
 			if (ret < 0)
 				break;
@@ -1627,7 +1627,7 @@ static int snd_pcm_oss_sync1(struct snd_pcm_substream *substream, size_t size)
 		result = 0;
 		set_current_state(TASK_INTERRUPTIBLE);
 		snd_pcm_stream_lock_irq(substream);
-		state = runtime->status->state;
+		state = runtime->state;
 		snd_pcm_stream_unlock_irq(substream);
 		if (state != SNDRV_PCM_STATE_RUNNING) {
 			set_current_state(TASK_RUNNING);
@@ -2852,8 +2852,8 @@ static __poll_t snd_pcm_oss_poll(struct file *file, poll_table * wait)
 		struct snd_pcm_runtime *runtime = psubstream->runtime;
 		poll_wait(file, &runtime->sleep, wait);
 		snd_pcm_stream_lock_irq(psubstream);
-		if (runtime->status->state != SNDRV_PCM_STATE_DRAINING &&
-		    (runtime->status->state != SNDRV_PCM_STATE_RUNNING ||
+		if (runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    (runtime->state != SNDRV_PCM_STATE_RUNNING ||
 		     snd_pcm_oss_playback_ready(psubstream)))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		snd_pcm_stream_unlock_irq(psubstream);
@@ -2863,7 +2863,7 @@ static __poll_t snd_pcm_oss_poll(struct file *file, poll_table * wait)
 		snd_pcm_state_t ostate;
 		poll_wait(file, &runtime->sleep, wait);
 		snd_pcm_stream_lock_irq(csubstream);
-		ostate = runtime->status->state;
+		ostate = runtime->state;
 		if (ostate != SNDRV_PCM_STATE_RUNNING ||
 		    snd_pcm_oss_capture_ready(csubstream))
 			mask |= EPOLLIN | EPOLLRDNORM;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 1ce21677d030b..9df2e819035f2 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -386,7 +386,7 @@ static void snd_pcm_substream_proc_hw_params_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "closed\n");
 		goto unlock;
 	}
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+	if (runtime->state == SNDRV_PCM_STATE_OPEN) {
 		snd_iprintf(buffer, "no setup\n");
 		goto unlock;
 	}
@@ -423,7 +423,7 @@ static void snd_pcm_substream_proc_sw_params_read(struct snd_info_entry *entry,
 		snd_iprintf(buffer, "closed\n");
 		goto unlock;
 	}
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+	if (runtime->state == SNDRV_PCM_STATE_OPEN) {
 		snd_iprintf(buffer, "no setup\n");
 		goto unlock;
 	}
@@ -969,7 +969,7 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	init_waitqueue_head(&runtime->sleep);
 	init_waitqueue_head(&runtime->tsleep);
 
-	runtime->status->state = SNDRV_PCM_STATE_OPEN;
+	__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_OPEN);
 	mutex_init(&runtime->buffer_mutex);
 	atomic_set(&runtime->buffer_accessing, 0);
 
@@ -1110,7 +1110,8 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 			if (snd_pcm_running(substream))
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
 			/* to be sure, set the state unconditionally */
-			substream->runtime->status->state = SNDRV_PCM_STATE_DISCONNECTED;
+			__snd_pcm_set_state(substream->runtime,
+					    SNDRV_PCM_STATE_DISCONNECTED);
 			wake_up(&substream->runtime->sleep);
 			wake_up(&substream->runtime->tsleep);
 		}
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 7af9fa1331895..21c6fbb4f8c90 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -299,7 +299,7 @@ static int snd_pcm_ioctl_xferi_compat(struct snd_pcm_substream *substream,
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 
 	if (get_user(buf, &data32->buf) ||
@@ -345,7 +345,7 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (substream->runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 
 	ch = substream->runtime->channels;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8947c988b6d34..f319e4298b874 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -185,7 +185,7 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 	avail = snd_pcm_avail(substream);
 	if (avail > runtime->avail_max)
 		runtime->avail_max = avail;
-	if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+	if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
 		if (avail >= runtime->buffer_size) {
 			snd_pcm_drain_done(substream);
 			return -EPIPE;
@@ -1910,7 +1910,7 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 
 		snd_pcm_stream_lock_irq(substream);
 		set_current_state(TASK_INTERRUPTIBLE);
-		switch (runtime->status->state) {
+		switch (runtime->state) {
 		case SNDRV_PCM_STATE_SUSPENDED:
 			err = -ESTRPIPE;
 			goto _endloop;
@@ -2098,14 +2098,14 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
 		return -EINVAL;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	return 0;
 }
 
 static int pcm_accessible_state(struct snd_pcm_runtime *runtime)
 {
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PAUSED:
@@ -2209,7 +2209,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		goto _end_unlock;
 
 	runtime->twake = runtime->control->avail_min ? : 1;
-	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+	if (runtime->state == SNDRV_PCM_STATE_RUNNING)
 		snd_pcm_update_hw_ptr(substream);
 
 	/*
@@ -2217,7 +2217,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	 * thread may start capture
 	 */
 	if (!is_playback &&
-	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
+	    runtime->state == SNDRV_PCM_STATE_PREPARED &&
 	    size >= runtime->start_threshold) {
 		err = snd_pcm_start(substream);
 		if (err < 0)
@@ -2231,7 +2231,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		snd_pcm_uframes_t cont;
 		if (!avail) {
 			if (!is_playback &&
-			    runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+			    runtime->state == SNDRV_PCM_STATE_DRAINING) {
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 				goto _end_unlock;
 			}
@@ -2283,7 +2283,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		xfer += frames;
 		avail -= frames;
 		if (is_playback &&
-		    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
+		    runtime->state == SNDRV_PCM_STATE_PREPARED &&
 		    snd_pcm_playback_hw_avail(runtime) >= (snd_pcm_sframes_t)runtime->start_threshold) {
 			err = snd_pcm_start(substream);
 			if (err < 0)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0193ac199c270..56b4a25fc6f0b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -595,8 +595,8 @@ static void snd_pcm_set_state(struct snd_pcm_substream *substream,
 			      snd_pcm_state_t state)
 {
 	snd_pcm_stream_lock_irq(substream);
-	if (substream->runtime->status->state != SNDRV_PCM_STATE_DISCONNECTED)
-		substream->runtime->status->state = state;
+	if (substream->runtime->state != SNDRV_PCM_STATE_DISCONNECTED)
+		__snd_pcm_set_state(substream->runtime, state);
 	snd_pcm_stream_unlock_irq(substream);
 }
 
@@ -724,7 +724,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 	snd_pcm_stream_lock_irq(substream);
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
@@ -889,7 +889,7 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 	if (result < 0)
 		return result;
 	snd_pcm_stream_lock_irq(substream);
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_SETUP:
 	case SNDRV_PCM_STATE_PREPARED:
 		if (atomic_read(&substream->mmap_count))
@@ -920,7 +920,7 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
 		return -ENXIO;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+	if (runtime->state == SNDRV_PCM_STATE_OPEN) {
 		snd_pcm_stream_unlock_irq(substream);
 		return -EBADFD;
 	}
@@ -1013,8 +1013,8 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 	} else
 		runtime->audio_tstamp_report.valid = 1;
 
-	status->state = runtime->status->state;
-	status->suspended_state = runtime->status->suspended_state;
+	status->state = runtime->state;
+	status->suspended_state = runtime->suspended_state;
 	if (status->state == SNDRV_PCM_STATE_OPEN)
 		goto _end;
 	status->trigger_tstamp_sec = runtime->trigger_tstamp.tv_sec;
@@ -1148,7 +1148,7 @@ static int snd_pcm_channel_info(struct snd_pcm_substream *substream,
 	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+	if (runtime->state == SNDRV_PCM_STATE_OPEN) {
 		snd_pcm_stream_unlock_irq(substream);
 		return -EBADFD;
 	}
@@ -1411,7 +1411,7 @@ static int snd_pcm_pre_start(struct snd_pcm_substream *substream,
 			     snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	if (runtime->status->state != SNDRV_PCM_STATE_PREPARED)
+	if (runtime->state != SNDRV_PCM_STATE_PREPARED)
 		return -EBADFD;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    !snd_pcm_playback_data(substream))
@@ -1446,7 +1446,7 @@ static void snd_pcm_post_start(struct snd_pcm_substream *substream,
 	runtime->hw_ptr_jiffies = jiffies;
 	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
 							    runtime->rate;
-	runtime->status->state = state;
+	__snd_pcm_set_state(runtime, state);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    runtime->silence_size > 0)
 		snd_pcm_playback_silence(substream, ULONG_MAX);
@@ -1487,7 +1487,7 @@ static int snd_pcm_pre_stop(struct snd_pcm_substream *substream,
 			    snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	runtime->trigger_master = substream;
 	return 0;
@@ -1508,9 +1508,9 @@ static void snd_pcm_post_stop(struct snd_pcm_substream *substream,
 			      snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	if (runtime->status->state != state) {
+	if (runtime->state != state) {
 		snd_pcm_trigger_tstamp(substream);
-		runtime->status->state = state;
+		__snd_pcm_set_state(runtime, state);
 		snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSTOP);
 	}
 	wake_up(&runtime->sleep);
@@ -1586,9 +1586,9 @@ static int snd_pcm_pre_pause(struct snd_pcm_substream *substream,
 	if (!(runtime->info & SNDRV_PCM_INFO_PAUSE))
 		return -ENOSYS;
 	if (pause_pushed(state)) {
-		if (runtime->status->state != SNDRV_PCM_STATE_RUNNING)
+		if (runtime->state != SNDRV_PCM_STATE_RUNNING)
 			return -EBADFD;
-	} else if (runtime->status->state != SNDRV_PCM_STATE_PAUSED)
+	} else if (runtime->state != SNDRV_PCM_STATE_PAUSED)
 		return -EBADFD;
 	runtime->trigger_master = substream;
 	return 0;
@@ -1630,12 +1630,12 @@ static void snd_pcm_post_pause(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
 	if (pause_pushed(state)) {
-		runtime->status->state = SNDRV_PCM_STATE_PAUSED;
+		__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_PAUSED);
 		snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MPAUSE);
 		wake_up(&runtime->sleep);
 		wake_up(&runtime->tsleep);
 	} else {
-		runtime->status->state = SNDRV_PCM_STATE_RUNNING;
+		__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_RUNNING);
 		snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MCONTINUE);
 	}
 }
@@ -1670,7 +1670,7 @@ static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream,
 			       snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_SUSPENDED:
 		return -EBUSY;
 	/* unresumable PCM state; return -EBUSY for skipping suspend */
@@ -1701,8 +1701,9 @@ static void snd_pcm_post_suspend(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
-	runtime->status->suspended_state = runtime->status->state;
-	runtime->status->state = SNDRV_PCM_STATE_SUSPENDED;
+	runtime->suspended_state = runtime->state;
+	runtime->status->suspended_state = runtime->suspended_state;
+	__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SUSPENDED);
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MSUSPEND);
 	wake_up(&runtime->sleep);
 	wake_up(&runtime->tsleep);
@@ -1793,8 +1794,8 @@ static int snd_pcm_do_resume(struct snd_pcm_substream *substream,
 	if (runtime->trigger_master != substream)
 		return 0;
 	/* DMA not running previously? */
-	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING &&
-	    (runtime->status->suspended_state != SNDRV_PCM_STATE_DRAINING ||
+	if (runtime->suspended_state != SNDRV_PCM_STATE_RUNNING &&
+	    (runtime->suspended_state != SNDRV_PCM_STATE_DRAINING ||
 	     substream->stream != SNDRV_PCM_STREAM_PLAYBACK))
 		return 0;
 	return substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_RESUME);
@@ -1813,7 +1814,7 @@ static void snd_pcm_post_resume(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
-	runtime->status->state = runtime->status->suspended_state;
+	__snd_pcm_set_state(runtime, runtime->suspended_state);
 	snd_pcm_timer_notify(substream, SNDRV_TIMER_EVENT_MRESUME);
 }
 
@@ -1850,7 +1851,7 @@ static int snd_pcm_xrun(struct snd_pcm_substream *substream)
 	int result;
 
 	snd_pcm_stream_lock_irq(substream);
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_XRUN:
 		result = 0;	/* already there */
 		break;
@@ -1873,7 +1874,7 @@ static int snd_pcm_pre_reset(struct snd_pcm_substream *substream,
 			     snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_PAUSED:
@@ -1935,8 +1936,8 @@ static int snd_pcm_pre_prepare(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int f_flags = (__force int)state;
 
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (snd_pcm_running(substream))
 		return -EBUSY;
@@ -1987,7 +1988,7 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 		f_flags = substream->f_flags;
 
 	snd_pcm_stream_lock_irq(substream);
-	switch (substream->runtime->status->state) {
+	switch (substream->runtime->state) {
 	case SNDRV_PCM_STATE_PAUSED:
 		snd_pcm_pause(substream, false);
 		fallthrough;
@@ -2011,7 +2012,7 @@ static int snd_pcm_pre_drain_init(struct snd_pcm_substream *substream,
 				  snd_pcm_state_t state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_DISCONNECTED:
 	case SNDRV_PCM_STATE_SUSPENDED:
@@ -2026,28 +2027,28 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		switch (runtime->status->state) {
+		switch (runtime->state) {
 		case SNDRV_PCM_STATE_PREPARED:
 			/* start playback stream if possible */
 			if (! snd_pcm_playback_empty(substream)) {
 				snd_pcm_do_start(substream, SNDRV_PCM_STATE_DRAINING);
 				snd_pcm_post_start(substream, SNDRV_PCM_STATE_DRAINING);
 			} else {
-				runtime->status->state = SNDRV_PCM_STATE_SETUP;
+				__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
 			}
 			break;
 		case SNDRV_PCM_STATE_RUNNING:
-			runtime->status->state = SNDRV_PCM_STATE_DRAINING;
+			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_DRAINING);
 			break;
 		case SNDRV_PCM_STATE_XRUN:
-			runtime->status->state = SNDRV_PCM_STATE_SETUP;
+			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
 			break;
 		default:
 			break;
 		}
 	} else {
 		/* stop running stream */
-		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING) {
+		if (runtime->state == SNDRV_PCM_STATE_RUNNING) {
 			snd_pcm_state_t new_state;
 
 			new_state = snd_pcm_capture_avail(runtime) > 0 ?
@@ -2057,7 +2058,7 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (runtime->status->state == SNDRV_PCM_STATE_DRAINING &&
+	if (runtime->state == SNDRV_PCM_STATE_DRAINING &&
 	    runtime->trigger_master == substream &&
 	    (runtime->hw.info & SNDRV_PCM_INFO_DRAIN_TRIGGER))
 		return substream->ops->trigger(substream,
@@ -2098,7 +2099,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	card = substream->pcm->card;
 	runtime = substream->runtime;
 
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 
 	if (file) {
@@ -2109,7 +2110,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 
 	snd_pcm_stream_lock_irq(substream);
 	/* resume pause */
-	if (runtime->status->state == SNDRV_PCM_STATE_PAUSED)
+	if (runtime->state == SNDRV_PCM_STATE_PAUSED)
 		snd_pcm_pause(substream, false);
 
 	/* pre-start/stop - all running streams are changed to DRAINING state */
@@ -2137,7 +2138,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			if (s->stream != SNDRV_PCM_STREAM_PLAYBACK)
 				continue;
 			runtime = s->runtime;
-			if (runtime->status->state == SNDRV_PCM_STATE_DRAINING) {
+			if (runtime->state == SNDRV_PCM_STATE_DRAINING) {
 				to_check = runtime;
 				break;
 			}
@@ -2176,7 +2177,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			break;
 		}
 		if (tout == 0) {
-			if (substream->runtime->status->state == SNDRV_PCM_STATE_SUSPENDED)
+			if (substream->runtime->state == SNDRV_PCM_STATE_SUSPENDED)
 				result = -ESTRPIPE;
 			else {
 				dev_dbg(substream->pcm->card->dev,
@@ -2208,13 +2209,13 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 		return -ENXIO;
 	runtime = substream->runtime;
 
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
 	snd_pcm_stream_lock_irq(substream);
 	/* resume pause */
-	if (runtime->status->state == SNDRV_PCM_STATE_PAUSED)
+	if (runtime->state == SNDRV_PCM_STATE_PAUSED)
 		snd_pcm_pause(substream, false);
 
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
@@ -2277,8 +2278,8 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_group_init(group);
 
 	down_write(&snd_pcm_link_rwsem);
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    substream->runtime->status->state != substream1->runtime->status->state ||
+	if (substream->runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    substream->runtime->state != substream1->runtime->state ||
 	    substream->pcm->nonatomic != substream1->pcm->nonatomic) {
 		res = -EBADFD;
 		goto _end;
@@ -2702,7 +2703,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
-		if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		if (substream->runtime->state != SNDRV_PCM_STATE_OPEN)
 			do_hw_free(substream);
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
@@ -2899,7 +2900,7 @@ static int snd_pcm_release(struct inode *inode, struct file *file)
  */
 static int do_pcm_hwsync(struct snd_pcm_substream *substream)
 {
-	switch (substream->runtime->status->state) {
+	switch (substream->runtime->state) {
 	case SNDRV_PCM_STATE_DRAINING:
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			return -EBADFD;
@@ -3196,7 +3197,7 @@ static int snd_pcm_xferi_frames_ioctl(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_sframes_t result;
 
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (put_user(0, &_xferi->result))
 		return -EFAULT;
@@ -3219,7 +3220,7 @@ static int snd_pcm_xfern_frames_ioctl(struct snd_pcm_substream *substream,
 	void *bufs;
 	snd_pcm_sframes_t result;
 
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (runtime->channels > 128)
 		return -EINVAL;
@@ -3283,7 +3284,7 @@ static int snd_pcm_common_ioctl(struct file *file,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (substream->runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
 	res = snd_power_wait(substream->pcm->card);
@@ -3412,7 +3413,7 @@ int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream,
 	snd_pcm_uframes_t *frames = arg;
 	snd_pcm_sframes_t result;
 	
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (substream->runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
 	switch (cmd) {
@@ -3457,8 +3458,8 @@ static ssize_t snd_pcm_read(struct file *file, char __user *buf, size_t count,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
@@ -3482,8 +3483,8 @@ static ssize_t snd_pcm_write(struct file *file, const char __user *buf,
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!frame_aligned(runtime, count))
 		return -EINVAL;
@@ -3509,8 +3510,8 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!iter_is_iovec(to))
 		return -EINVAL;
@@ -3546,8 +3547,8 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
+	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	if (!iter_is_iovec(from))
 		return -EINVAL;
@@ -3586,7 +3587,7 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
 		return ok | EPOLLERR;
 
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return ok | EPOLLERR;
 
 	poll_wait(file, &runtime->sleep, wait);
@@ -3594,7 +3595,7 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
 	mask = 0;
 	snd_pcm_stream_lock_irq(substream);
 	avail = snd_pcm_avail(substream);
-	switch (runtime->status->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_PAUSED:
@@ -3863,7 +3864,7 @@ int snd_pcm_mmap_data(struct snd_pcm_substream *substream, struct file *file,
 			return -EINVAL;
 	}
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
+	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 	if (!(runtime->info & SNDRV_PCM_INFO_MMAP))
 		return -ENXIO;
@@ -3900,7 +3901,7 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
-	if (substream->runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (substream->runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
 	offset = area->vm_pgoff << PAGE_SHIFT;
@@ -3938,7 +3939,7 @@ static int snd_pcm_fasync(int fd, struct file * file, int on)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
+	if (runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 	return fasync_helper(fd, file, on, &runtime->fasync);
 }
-- 
2.43.0




