Return-Path: <stable+bounces-73184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE696D398
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF85B1C214D5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112B19755A;
	Thu,  5 Sep 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnuFLR+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98B194A60;
	Thu,  5 Sep 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529415; cv=none; b=CQ4WNia53P3tjaaPQoFfO3Rtqa2kaz6Zy138VFyBmJRxYaquHeTpSEeeisRwwNHWuI/xQIBSXA1jZ+Cw6jJeNkbd+l5mzL43grd91f9525m9ygLe1/5qZfakVEKhMzK+6vOJpN165zQ1A4vys52I8ekvp+SBoj8toQohbLkopRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529415; c=relaxed/simple;
	bh=hYjuZhYO4g4nx7PRKdQ/w/HMfDGfLfPTm2BrcZac6U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZJyDj/U2g7GcvmKYXjZyEWk/i6KdncDyNg6OkhECxUMB7jb8CBWOfUE5SYow0idE9HBFUvfDSqOgOxKVM2bC298qfyFlR3buHQWe2L3fVUMQraRbDIWK8eElKWn3f+VgjLccqEeNihFS0BRTMCZpjfq9DzcV5yJTScavsg0J3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnuFLR+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE67EC4CEC6;
	Thu,  5 Sep 2024 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529415;
	bh=hYjuZhYO4g4nx7PRKdQ/w/HMfDGfLfPTm2BrcZac6U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnuFLR+pZXrxUG8WN1gKome3wX7gdvCSG3AiXJBOhE+Zuzq3oUe+1MMaliLe+KMqw
	 kDvj5eSCgnfQA4HX0gNBF3cnZfNu3SGH1NtSGIdY0wBiqcCdnI+J9EiWktYBC++bLF
	 ZW/SItxo1z22lGOYm1AhF3/eotN/E97UGRRuaqIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 006/184] ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
Date: Thu,  5 Sep 2024 11:38:39 +0200
Message-ID: <20240905093732.489772654@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6cd23b26b348fa52c88e1adf9c0e48d68e13f95e ]

Some devices indicate click noises at suspend or shutdown when the
speakers are unmuted.  This patch adds a helper,
snd_hda_gen_shutup_speakers(), to work around it.  The new function is
supposed to be called at suspend or shutdown by the codec driver, and
it mutes the speakers.

The mute status isn't cached, hence the original mute state will be
restored at resume again.

Link: https://patch.msgid.link/20240726142625.2460-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_generic.c | 63 +++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_generic.h |  1 +
 2 files changed, 64 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f64d9dc197a31..9cff87dfbecbb 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4955,6 +4955,69 @@ void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_stream_pm);
 
+/* forcibly mute the speaker output without caching; return true if updated */
+static bool force_mute_output_path(struct hda_codec *codec, hda_nid_t nid)
+{
+	if (!nid)
+		return false;
+	if (!nid_has_mute(codec, nid, HDA_OUTPUT))
+		return false; /* no mute, skip */
+	if (snd_hda_codec_amp_read(codec, nid, 0, HDA_OUTPUT, 0) &
+	    snd_hda_codec_amp_read(codec, nid, 1, HDA_OUTPUT, 0) &
+	    HDA_AMP_MUTE)
+		return false; /* both channels already muted, skip */
+
+	/* direct amp update without caching */
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+			    AC_AMP_SET_OUTPUT | AC_AMP_SET_LEFT |
+			    AC_AMP_SET_RIGHT | HDA_AMP_MUTE);
+	return true;
+}
+
+/**
+ * snd_hda_gen_shutup_speakers - Forcibly mute the speaker outputs
+ * @codec: the HDA codec
+ *
+ * Forcibly mute the speaker outputs, to be called at suspend or shutdown.
+ *
+ * The mute state done by this function isn't cached, hence the original state
+ * will be restored at resume.
+ *
+ * Return true if the mute state has been changed.
+ */
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const int *paths;
+	const struct nid_path *path;
+	int i, p, num_paths;
+	bool updated = false;
+
+	/* if already powered off, do nothing */
+	if (!snd_hdac_is_power_on(&codec->core))
+		return false;
+
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		paths = spec->out_paths;
+		num_paths = spec->autocfg.line_outs;
+	} else {
+		paths = spec->speaker_paths;
+		num_paths = spec->autocfg.speaker_outs;
+	}
+
+	for (i = 0; i < num_paths; i++) {
+		path = snd_hda_get_path_from_idx(codec, paths[i]);
+		if (!path)
+			continue;
+		for (p = 0; p < path->depth; p++)
+			if (force_mute_output_path(codec, path->path[p]))
+				updated = true;
+	}
+
+	return updated;
+}
+EXPORT_SYMBOL_GPL(snd_hda_gen_shutup_speakers);
+
 /**
  * snd_hda_gen_parse_auto_config - Parse the given BIOS configuration and
  * set up the hda_gen_spec
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 8f5ecf740c491..08544601b4ce2 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -353,5 +353,6 @@ int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec);
 
 #endif /* __SOUND_HDA_GENERIC_H */
-- 
2.43.0




