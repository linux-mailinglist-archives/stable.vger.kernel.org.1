Return-Path: <stable+bounces-84697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7C99D191
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796981F245E4
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A51AB6FF;
	Mon, 14 Oct 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RT06UEU7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5031BF80C;
	Mon, 14 Oct 2024 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918898; cv=none; b=spkLHdMnpW5aJiaYfOXefpeRN8lVTq46T4EnJ5vXD8nEccM98M4c7qkYeT8KAzCZRvjVyMugVkuimZ1JB9i83betA7fyBel5A8l+w+gySdDdblLsRyQ17IVAdsDnx/xaCKrkReM7k7SSiBr+WaZH3UMoOR48/ZLgM/bbWWIW4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918898; c=relaxed/simple;
	bh=9qeQnwb1tXACsNoU7uofljian/vbrKRSQwcMGIsoFgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+DpRp4HQ57xNszyfF/ePY975lvD3vg4aJsz7lB5roIOoNkJnIvGnGMgJAE8lTVtoPEwojiDIo/+uJMkYUlaFw11RKCH9O156mgWoPWoz8R/D+yTl1ruGX/S1aICtEn9Iv2uyQLBLrAbUl17yuOvOhaUYYIKh0hINMzawGWj3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RT06UEU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30680C4CEC3;
	Mon, 14 Oct 2024 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918897;
	bh=9qeQnwb1tXACsNoU7uofljian/vbrKRSQwcMGIsoFgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RT06UEU7V/GX1Mg1QcawwS5ZCCJN6wwgDsijhiqJiYUS90vEzOsgFm63LYcSClqQ4
	 ih2pT4uMuXinRe2fycDeh8D9WfmP0l7rqLXHwIX1/+xT1JJVk85FcH4mKKCwvykfPi
	 X3e8O48vGPijozFS8txakKw+cz4OClXj9ZrEvI7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 454/798] ALSA: usb-audio: Add input value sanity checks for standard types
Date: Mon, 14 Oct 2024 16:16:48 +0200
Message-ID: <20241014141235.808279792@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 34ded71cb8077..49facdf35b159 100644
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
@@ -2339,6 +2354,8 @@ static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		return filter_error(cval, err);
 	val = ucontrol->value.integer.value[0];
+	if (val < 0 || val > get_max_exposed(cval))
+		return -EINVAL;
 	val = get_abs_value(cval, val);
 	if (val != oval) {
 		set_cur_ctl_value(cval, cval->control << 8, val);
@@ -2701,6 +2718,8 @@ static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
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




