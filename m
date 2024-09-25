Return-Path: <stable+bounces-77428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24F985D23
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88511F21E4E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BE1DA632;
	Wed, 25 Sep 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaNvYNQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301718BBB7;
	Wed, 25 Sep 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265744; cv=none; b=M93X9K2dF0HaE7UzgTgH8t+7u/oDc9jEBgHyfEQ3IaTKhH9P3eMZpZs0DNufiPZ3J2mjQPuQ929vi4Q2kNhQZ5LNEXgrcffS/ACw0+nMB+pGpu8j+DlEOdGFVh+V0+OqGSuYHejx7HeuiDzHMDVYliR6owok00jbz/+tDXCwe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265744; c=relaxed/simple;
	bh=evM6H/nIMWlAWCHRpVldjRC/PqmIAdaxslKj2q+kL34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe1xXY+ZFOqX6Ui5wSEjL3afwBOZeDDAkdhpfs5XYKr+U4t7DrUGMUTpDUf4/kYsCsYQXtpYGxCzqQXR9m2NQVOpyDD5yHjIXEzQD9DCrxJrZRSdWOvK+o/e3tw+jMu+Hr9PsA7pPHYCMFByvpFGUktqoQmA5fUHEWGrYcXPUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaNvYNQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9881EC4CEC7;
	Wed, 25 Sep 2024 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265744;
	bh=evM6H/nIMWlAWCHRpVldjRC/PqmIAdaxslKj2q+kL34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaNvYNQOWxt1TeSc8BAkeC2e1d+o9oKgC/QeZdLpoEBUccMWb1HtchCj0B/gk74am
	 /DYRA2JZ4W33wQXxWHJ/P2xdbpU5dn8Dn+ddlFdL6zoW4f40AE73pf1foB+dTAs/CD
	 G5vty1gBm+y13I9Ncst9sx9oehQyzLEG3jjsxz3rVL6eLyktFhl9649xixObHpZAJh
	 ohV3kJ6yTB6HH3+s4ctfhbmYnm24ZqF16NtAWU/mPda8WxI6DNgTEp0989XXr83Cuh
	 RH5vxI1en6ogN7FXxHBIgTxhqXoJwTUZlqFpbK1iiGFVDxQ9usup0139SlrdRRB0eM
	 NwD38PVIj4qZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	o-takashi@sakamocchi.jp,
	broonie@kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 083/197] ALSA: control: Take power_ref lock primarily
Date: Wed, 25 Sep 2024 07:51:42 -0400
Message-ID: <20240925115823.1303019-83-sashal@kernel.org>
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

[ Upstream commit fcc62b19104a67b9a2941513771e09389b75bd95 ]

The code path for kcontrol accesses have often nested locks of both
card's controls_rwsem and power_ref, and applies in that order.
However, what could take much longer is the latter, power_ref; it
waits for the power state of the device, and it pretty much depends on
the user's action.

This patch swaps the locking order of those locks to a more natural
way, namely, power_ref -> controls_rwsem, in order to shorten the time
of possible nested locks.  For consistency, power_ref is taken always
in the top-level caller side (that is, *_user() functions and the
ioctl handler itself).

Link: https://patch.msgid.link/20240729160659.4516-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/control.c | 54 ++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 1dd2337e29300..2151f19b432fd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1164,9 +1164,7 @@ static int __snd_ctl_elem_info(struct snd_card *card,
 #ifdef CONFIG_SND_DEBUG
 	info->access = 0;
 #endif
-	result = snd_power_ref_and_wait(card);
-	if (!result)
-		result = kctl->info(kctl, info);
+	result = kctl->info(kctl, info);
 	snd_power_unref(card);
 	if (result >= 0) {
 		snd_BUG_ON(info->access);
@@ -1205,12 +1203,17 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
 				  struct snd_ctl_elem_info __user *_info)
 {
+	struct snd_card *card = ctl->card;
 	struct snd_ctl_elem_info info;
 	int result;
 
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
+	result = snd_power_ref_and_wait(card);
+	if (result)
+		return result;
 	result = snd_ctl_elem_info(ctl, &info);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 	/* drop internal access flags */
@@ -1254,10 +1257,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	if (!snd_ctl_skip_validation(&info))
 		fill_remaining_elem_value(control, &info, pattern);
-	ret = snd_power_ref_and_wait(card);
-	if (!ret)
-		ret = kctl->get(kctl, control);
-	snd_power_unref(card);
+	ret = kctl->get(kctl, control);
 	if (ret < 0)
 		return ret;
 	if (!snd_ctl_skip_validation(&info) &&
@@ -1282,7 +1282,11 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(no_free_ptr(control));
 
+	result = snd_power_ref_and_wait(card);
+	if (result)
+		return result;
 	result = snd_ctl_elem_read(card, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1297,7 +1301,7 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
-	int result;
+	int result = 0;
 
 	down_write(&card->controls_rwsem);
 	kctl = snd_ctl_find_id_locked(card, &control->id);
@@ -1315,9 +1319,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-	result = snd_power_ref_and_wait(card);
 	/* validate input values */
-	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
+	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION)) {
 		struct snd_ctl_elem_info info;
 
 		memset(&info, 0, sizeof(info));
@@ -1329,7 +1332,6 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 	if (!result)
 		result = kctl->put(kctl, control);
-	snd_power_unref(card);
 	if (result < 0) {
 		up_write(&card->controls_rwsem);
 		return result;
@@ -1358,7 +1360,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 		return PTR_ERR(no_free_ptr(control));
 
 	card = file->card;
+	result = snd_power_ref_and_wait(card);
+	if (result < 0)
+		return result;
 	result = snd_ctl_elem_write(card, file, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1827,7 +1833,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 		{SNDRV_CTL_TLV_OP_CMD,   SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND},
 	};
 	struct snd_kcontrol_volatile *vd = &kctl->vd[snd_ctl_get_ioff(kctl, id)];
-	int i, ret;
+	int i;
 
 	/* Check support of the request for this element. */
 	for (i = 0; i < ARRAY_SIZE(pairs); ++i) {
@@ -1845,11 +1851,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	    vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
-	ret = snd_power_ref_and_wait(file->card);
-	if (!ret)
-		ret = kctl->tlv.c(kctl, op_flag, size, buf);
-	snd_power_unref(file->card);
-	return ret;
+	return kctl->tlv.c(kctl, op_flag, size, buf);
 }
 
 static int read_tlv_buf(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id,
@@ -1962,16 +1964,28 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
 	case SNDRV_CTL_IOCTL_TLV_READ:
-		scoped_guard(rwsem_read, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_read, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_READ);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
-		scoped_guard(rwsem_write, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_write, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_WRITE);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_TLV_COMMAND:
-		scoped_guard(rwsem_write, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_write, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_CMD);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
-- 
2.43.0


