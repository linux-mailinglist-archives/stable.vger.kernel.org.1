Return-Path: <stable+bounces-65427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C11948105
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22F9B23433
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF116B389;
	Mon,  5 Aug 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfmYyo8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7F16B38B;
	Mon,  5 Aug 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880679; cv=none; b=byjO2K/jG9az9SXhQ59xWStngOWPRfU8a0jjBm8fyLhtQwrA9mDd5ve1MFKp+H+W/c9TcTvvTRGtwey23xLsYmLGkC2AztTl+OT1HVZPrakwRGVOPlJ3YBdQIEm2xs+LqA9g2pqbIpRpa5ysZfZvSG5sdIuFuUhbT8/aVT8b/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880679; c=relaxed/simple;
	bh=4xse9+5LpxLLaU3JXPVVy4b27QNbH3nKTplmYBD9A38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OODykxv8fSrvk8ObuUdxfOzLk53rqMBdyZtchvQuIgPAGce0TgE73fzztWIPGjNzDRdy8lRWBjZCG8OK9aTlt9ze04TwXqKKwQB2aO9p4So7PoStTF76teyXzYAvDF/6u9+HhQhaCsnhmiItZEKZAoPbE1unriHd/jwZ4/cmEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfmYyo8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A0BC32782;
	Mon,  5 Aug 2024 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880679;
	bh=4xse9+5LpxLLaU3JXPVVy4b27QNbH3nKTplmYBD9A38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfmYyo8aoWASKROlZE8dxrhBPbV4ATonRuPxru7oGlhkJ/h345qIzim4eSfDE9H6X
	 a0yx9UhUV4PH1wLl2/nqQHig4XkYdK8/OGZax2cH4h/5gHKrQx6NpvRwnDxhWXmp25
	 uHlZyyw5+k0cmEf2rfqJe7VrzTMr2Y7SWONZMsdSaYiuetzF0D3BV97Jjc8qKIogx2
	 7pW14LG9tLhLn9lohk0dbZYp2fX62hcNRhINln5Ldiub5gyVO6mGvBzjXYIOJKrUrt
	 d7PJQO5QaiFXje+hh/7b4raXZcJ8Lq6xrs3SAiPAu8s2vWgpDquN1oBjqnWxsHcgvK
	 8g5h3Exr02Rxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	hkallweit1@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/15] ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
Date: Mon,  5 Aug 2024 13:57:03 -0400
Message-ID: <20240805175736.3252615-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175736.3252615-1-sashal@kernel.org>
References: <20240805175736.3252615-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.44
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
index bf685d01259d3..d3ed3e21b1979 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4956,6 +4956,69 @@ void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on)
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
index a8eea83676299..aed4381f7a619 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -355,5 +355,6 @@ int snd_hda_gen_add_mute_led_cdev(struct hda_codec *codec,
 int snd_hda_gen_add_micmute_led_cdev(struct hda_codec *codec,
 				     int (*callback)(struct led_classdev *,
 						     enum led_brightness));
+bool snd_hda_gen_shutup_speakers(struct hda_codec *codec);
 
 #endif /* __SOUND_HDA_GENERIC_H */
-- 
2.43.0


