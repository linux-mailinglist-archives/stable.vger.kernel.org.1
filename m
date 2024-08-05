Return-Path: <stable+bounces-65439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83E94812A
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2420828C082
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69B17B4E1;
	Mon,  5 Aug 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El/E7Tco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DBC17B437;
	Mon,  5 Aug 2024 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880727; cv=none; b=UyLS07wsh6rMGWDNd03b251wUhBN5F2qamunCF5Jr2P1Vs1AJO2I2QB1rGLKVUtnG0EbSb3RB2qctVZCT9EzuDTmrD9W2me9lo9xZgXtvEVgP+DH4dzC7HOND9nfTdPG9s312Uu3KOd+ogMK3asXJ2265m3XMMLgsnvzdYBUOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880727; c=relaxed/simple;
	bh=P6GgOUVtySuKP7ua3LE4vrD+CSXXYg8O0OnVCtMQAYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU+a3op0VW8BANtQ0cM0tz+vhOTYMfdT+35XsMYNZuxmDChlY4dPvNNC7/y4joqNTfWLJAsWvNVp3lcW3VVDIl0BKg4SvsM+R5kSQQ1JuJTeCvfRzQZr9kXkc9DeX8fjNfXGb/7ArKnAdOndhSSzPlFC5j7ybLQGYNI/f+13M1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El/E7Tco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D2FC4AF0C;
	Mon,  5 Aug 2024 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880727;
	bh=P6GgOUVtySuKP7ua3LE4vrD+CSXXYg8O0OnVCtMQAYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=El/E7Tcov5n2v/x+NPrg+xsF+MTalaxlwa8D/Wh67N6DEzmhvPBDt6a9e5OHgc1/7
	 GJaRIr7gbaGFFvWs4e4vKyJNvueBhOcVdWVMGTYA4Iluut2/vfQed0C4ZkZFIYfjCJ
	 70FpXY5rZgHUujPrqiwgeBy4JivvaHDP4PZAluov9ASr781zyQs/QnmFvmxi29+msG
	 kvWBZBpl7EnI8PETEfmgp17AHGfAHPwFZuZiX7snD5NUwhJ23+aPGCt/SQ1duPnO8T
	 UHFK9S3T1l++xFaUruyQ6HyJdgI0axDYt0LBRiAVkz/dRisqiQfYTTNDFe9DTXdWh0
	 KnZ3msVj8PAhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	hkallweit1@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/5] ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
Date: Mon,  5 Aug 2024 13:58:26 -0400
Message-ID: <20240805175835.3255397-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175835.3255397-1-sashal@kernel.org>
References: <20240805175835.3255397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.103
Content-Transfer-Encoding: 8bit

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
index dbf7aa88e0e31..992cf82da1024 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4952,6 +4952,69 @@ void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
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
index 34eba40cc6e67..fb3ce68e2d717 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -352,5 +352,6 @@ int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec);
 
 #endif /* __SOUND_HDA_GENERIC_H */
-- 
2.43.0


