Return-Path: <stable+bounces-77186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F09859D6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7731C23759
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739F18A950;
	Wed, 25 Sep 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQnHFiZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F618A949;
	Wed, 25 Sep 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264423; cv=none; b=k1nOJhk4nZI1jCgpzMSCcpXvdtIMQ+dFPUQfkathazypRdfZZ1FGz5ttDZhZdpvuMMvzgkgAyGt4AW2hkiLi9uA5cKzpSm+YQ6mN4HlV15JDC7GxApLgRxScr5/LKPvhXi27Q1ZUf27fdayW6IQsMO0273fZ4aLtr8Wnf4H5Gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264423; c=relaxed/simple;
	bh=PW5fMAmhdcvyDjuu5YHuScg2FLdJx4NnpLioQBmKeGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfMEfQho6doFQ/eJgAUVq4wTZ+zEjOMOiH0KSvfMnynYxbl+WJPAa2Koqp3OepKRl0PR7ElW0ZvY2DvxH5LCZKnOC8Gegx5ujaJBQjft1ZIs41BjsfefX1Iw4dfYuZqRst4uRA8PcxHYAgRaCW8U/ZMUs84sKPBDEZBoDzOzsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQnHFiZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98589C4CEC3;
	Wed, 25 Sep 2024 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264423;
	bh=PW5fMAmhdcvyDjuu5YHuScg2FLdJx4NnpLioQBmKeGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQnHFiZ9KraGpBWBNVFCucthul/h6LV946cBAGrbHo2zsw6CU91YxBgBs8XeV9b8p
	 aSruRPVRLv0pbHsCZ7ONjJsVBucsdmD4H/EWnqxWpqekVPjCCqWfCLncPfswOoojBW
	 xXmNmrrMyw4C7vWPLRyrpUw2iRoVLT+HyfrObhGWYkV7rpYSudLMInQOuHE34sCak8
	 lmoKodqGgHwWB9aXWXYuUnqG7OYJvbWcr0hQTo7PARAPTFrM8rlfvhBQcS2q1T9n52
	 5MZFi511RKCVnwDBBcKYbeomkwFYRJXr0BlNccEDlRqP1DeaJyKmr9IranabE1s/1y
	 drt+DCBpouXiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	wangdicheng@kylinos.cn,
	k.kosik@outlook.com,
	kl@kl.wtf,
	xristos.thes@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 088/244] ALSA: usb-audio: Add input value sanity checks for standard types
Date: Wed, 25 Sep 2024 07:25:09 -0400
Message-ID: <20240925113641.1297102-88-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 901e85677ec0bb9a69fb9eab1feafe0c4eb7d07e ]

For an invalid input value that is out of the given range, currently
USB-audio driver corrects the value silently and accepts without
errors.  This is no wrong behavior, per se, but the recent kselftest
rather wants to have an error in such a case, hence a different
behavior is expected now.

This patch adds a sanity check at each control put for the standard
mixer types and returns an error if an invalid value is given.

Note that this covers only the standard mixer types.  The mixer quirks
that have own control callbacks would need different coverage.

Link: https://patch.msgid.link/20240806124651.28203-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 35 +++++++++++++++++++++++++++--------
 sound/usb/mixer.h |  1 +
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index f7ce8e8c3c3ea..2d27d729c3bea 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1377,6 +1377,19 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 
 #define get_min_max(cval, def)	get_min_max_with_quirks(cval, def, NULL)
 
+/* get the max value advertised via control API */
+static int get_max_exposed(struct usb_mixer_elem_info *cval)
+{
+	if (!cval->max_exposed) {
+		if (cval->res)
+			cval->max_exposed =
+				DIV_ROUND_UP(cval->max - cval->min, cval->res);
+		else
+			cval->max_exposed = cval->max - cval->min;
+	}
+	return cval->max_exposed;
+}
+
 /* get a feature/mixer unit info */
 static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
@@ -1389,11 +1402,8 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = cval->channels;
-	if (cval->val_type == USB_MIXER_BOOLEAN ||
-	    cval->val_type == USB_MIXER_INV_BOOLEAN) {
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 1;
-	} else {
+	if (cval->val_type != USB_MIXER_BOOLEAN &&
+	    cval->val_type != USB_MIXER_INV_BOOLEAN) {
 		if (!cval->initialized) {
 			get_min_max_with_quirks(cval, 0, kcontrol);
 			if (cval->initialized && cval->dBmin >= cval->dBmax) {
@@ -1405,10 +1415,10 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 					       &kcontrol->id);
 			}
 		}
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max =
-			DIV_ROUND_UP(cval->max - cval->min, cval->res);
 	}
+
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = get_max_exposed(cval);
 	return 0;
 }
 
@@ -1449,6 +1459,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	int max_val = get_max_exposed(cval);
 	int c, cnt, val, oval, err;
 	int changed = 0;
 
@@ -1461,6 +1472,8 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 			if (err < 0)
 				return filter_error(cval, err);
 			val = ucontrol->value.integer.value[cnt];
+			if (val < 0 || val > max_val)
+				return -EINVAL;
 			val = get_abs_value(cval, val);
 			if (oval != val) {
 				snd_usb_set_cur_mix_value(cval, c + 1, cnt, val);
@@ -1474,6 +1487,8 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 		if (err < 0)
 			return filter_error(cval, err);
 		val = ucontrol->value.integer.value[0];
+		if (val < 0 || val > max_val)
+			return -EINVAL;
 		val = get_abs_value(cval, val);
 		if (val != oval) {
 			snd_usb_set_cur_mix_value(cval, 0, 0, val);
@@ -2337,6 +2352,8 @@ static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		return filter_error(cval, err);
 	val = ucontrol->value.integer.value[0];
+	if (val < 0 || val > get_max_exposed(cval))
+		return -EINVAL;
 	val = get_abs_value(cval, val);
 	if (val != oval) {
 		set_cur_ctl_value(cval, cval->control << 8, val);
@@ -2699,6 +2716,8 @@ static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		return filter_error(cval, err);
 	val = ucontrol->value.enumerated.item[0];
+	if (val < 0 || val >= cval->max) /* here cval->max = # elements */
+		return -EINVAL;
 	val = get_abs_value(cval, val);
 	if (val != oval) {
 		set_cur_ctl_value(cval, cval->control << 8, val);
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index d43895c1ae5c6..167fbfcf01ace 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -88,6 +88,7 @@ struct usb_mixer_elem_info {
 	int channels;
 	int val_type;
 	int min, max, res;
+	int max_exposed; /* control API exposes the value in 0..max_exposed */
 	int dBmin, dBmax;
 	int cached;
 	int cache_val[MAX_CHANNELS];
-- 
2.43.0


