Return-Path: <stable+bounces-77197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AE9859F7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F6286873
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498281B2506;
	Wed, 25 Sep 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL+SeMm/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9D1B2514;
	Wed, 25 Sep 2024 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264485; cv=none; b=mQaEr6JKnSQtw1WATfBK1od0/2Q/AQgZhzIgPoEnVNJ2TXva8ToNjAJ9nnTl75914RylP1iZMGn7YoCbdhgmFDvoGundTEcGefssR6oW0fXAoEpMMf4P1ElmmA8MH6RnIcQKDhqaxZAnyPfOrJoIDUIlMHIV3sKv+mowi3+Cg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264485; c=relaxed/simple;
	bh=dhq5X6qdemWuWl8YKUdnlcOs4PRlgYNWO9ieggBdS+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZipdXENkKg1hrRl7+vWmDxU3iaQaj79sOxir43wd76TiYrKtUyRLPzEJcqeg71yuZnJfl2oBQpOYPnDBxnaS6oTVHewPf/bdzKf4VlvZfckO1Pc/Vo3ybh+CCdmnUD2ah3V/Y6UkFJlXCU/xAY1yA2ou16eVmGDc+ieNKIaMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL+SeMm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27D9C4CEC3;
	Wed, 25 Sep 2024 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264484;
	bh=dhq5X6qdemWuWl8YKUdnlcOs4PRlgYNWO9ieggBdS+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RL+SeMm/chFbXmJcqG/mNUzHrgEdn9XGWX/cPs2D79zIlYjtWWGk63IrU6GdqlG4r
	 Xt7oSVcpfibByXQrKysArMF63QxvPEnn5N6aXrYK4261X99nJATjACIYcxEetC2cH3
	 GlPqEQxH7COxgCURnyqww0bpE2XsmqfPvUvezhNzo5kX87GGTUKIyI7k0i6iIMziiw
	 XXxVRzdlc7W+nqCyYHpok1mEwgbC+CTFly2IOlIfaxTWVfkFlD3ospr+FGbfoND9cA
	 nDPKnX2OkODirXlXC9ddjZRL+8NAf098ZzrecSczoR4qM9Dp738uGWZrsyWwVq1mlX
	 Q/fvWhIt7S+gQ==
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
Subject: [PATCH AUTOSEL 6.11 099/244] ALSA: control: Take power_ref lock primarily
Date: Wed, 25 Sep 2024 07:25:20 -0400
Message-ID: <20240925113641.1297102-99-sashal@kernel.org>
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
index f64a555f404f0..96a2c088a460e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1167,9 +1167,7 @@ static int __snd_ctl_elem_info(struct snd_card *card,
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
@@ -1208,12 +1206,17 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
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
@@ -1257,10 +1260,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
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
@@ -1285,7 +1285,11 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(no_free_ptr(control));
 
+	result = snd_power_ref_and_wait(card);
+	if (result)
+		return result;
 	result = snd_ctl_elem_read(card, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1300,7 +1304,7 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
-	int result;
+	int result = 0;
 
 	down_write(&card->controls_rwsem);
 	kctl = snd_ctl_find_id_locked(card, &control->id);
@@ -1318,9 +1322,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-	result = snd_power_ref_and_wait(card);
 	/* validate input values */
-	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
+	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION)) {
 		struct snd_ctl_elem_info info;
 
 		memset(&info, 0, sizeof(info));
@@ -1332,7 +1335,6 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 	if (!result)
 		result = kctl->put(kctl, control);
-	snd_power_unref(card);
 	if (result < 0) {
 		up_write(&card->controls_rwsem);
 		return result;
@@ -1361,7 +1363,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 		return PTR_ERR(no_free_ptr(control));
 
 	card = file->card;
+	result = snd_power_ref_and_wait(card);
+	if (result < 0)
+		return result;
 	result = snd_ctl_elem_write(card, file, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1830,7 +1836,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 		{SNDRV_CTL_TLV_OP_CMD,   SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND},
 	};
 	struct snd_kcontrol_volatile *vd = &kctl->vd[snd_ctl_get_ioff(kctl, id)];
-	int i, ret;
+	int i;
 
 	/* Check support of the request for this element. */
 	for (i = 0; i < ARRAY_SIZE(pairs); ++i) {
@@ -1848,11 +1854,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
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
@@ -1965,16 +1967,28 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
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


