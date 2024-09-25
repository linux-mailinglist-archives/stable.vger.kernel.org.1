Return-Path: <stable+bounces-77418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB78985D3A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1617EB2AAF7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F71D88D1;
	Wed, 25 Sep 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVmM/2kT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E91B0139;
	Wed, 25 Sep 2024 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265694; cv=none; b=F6f1rqywSDEVVvffbFtd0FTNMPkMjtRMIjMoLYUCqOv5uJn393FGwnezN4hMs9GBHFDlAjNEVtUGjNqVgWtTfDrEQpq2GvWnS/CFJyuct+zCbY81oZIOljsPAFzny1UFUN5BNaBmOkhiohyS8BoUH4JWNeiTG3CUtDBSI+HhmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265694; c=relaxed/simple;
	bh=I3lJyh+kPlOZxT1SjOLo9UCvjlclH4XGiTIaYBrtm+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcBZnzgNLIebIABv6/gd4gzF+5USwxHmmr4ZNjsIeoN9hWunuV4CZe3MVIAuJuhUIN6g0WAekbSucKD9D6A0H+KZGHCG/bJkd6z2vEvGSw41fZw1zrR9pIyS0fdajtFbuYgUDu/v0GJwJh6EToIIDaIfb+fppdQB99s42IT1p64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVmM/2kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF866C4CEC7;
	Wed, 25 Sep 2024 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265694;
	bh=I3lJyh+kPlOZxT1SjOLo9UCvjlclH4XGiTIaYBrtm+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVmM/2kT/5+8b458+HFuN9H2ZtYuvOzemYwZ9qybQyvsMAcm7Y6o749nbDk7s2z8F
	 JC8zh+t04FZ7LaXiTjrC2STj211vQezSXhiHBScDXl3X/KC9MDKP8IUx0dOEu6uArN
	 56JBCPn12JfauMb62FzEsxpcv2Wut1U7n+oJ8vC2FJcknURvT/f7+UVxRaJK52kC5X
	 6F6HbJwTgWIefO79RN8s8WzxPaJ1V0j317nwTwQRkW+Oc9Ozdns/Tkd5gndwXjW6D9
	 y3HhdDcVJhpShsE4NXnaTDnC1tfJK5RpeIztgcxEw//cq1mOw1CGRwEjfovqn/gMmx
	 J9ahfXNRmrKJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	k.kosik@outlook.com,
	wangdicheng@kylinos.cn,
	kl@kl.wtf,
	xristos.thes@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 073/197] ALSA: usb-audio: Add input value sanity checks for standard types
Date: Wed, 25 Sep 2024 07:51:32 -0400
Message-ID: <20240925115823.1303019-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index 8cc2d4937f340..197fd07e69edd 100644
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


