Return-Path: <stable+bounces-48386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC808FE8CE
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ABA1F24D02
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5959198A38;
	Thu,  6 Jun 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXSfESii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649F9196C7B;
	Thu,  6 Jun 2024 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682935; cv=none; b=gHJe7cPhPGVXPju4Rh7tUS9EMWHm+0pV83TcKk1Y3GMmOZdyl2Ad1MNVucnv58ZqFHsfEXUUxR27CGFsUSuJgmzK+WBMI+yH8O5jNqJxO4I3rMQVCskk7Mnoi2Hbjfb69D0DPzm8toIK+r1pCPmJWFaje7uzm7WQJZ/+uYy6Rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682935; c=relaxed/simple;
	bh=eTdSzQu348qgBNqVeTj7tI9g8Dlr14jNbC2xVpNRRxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SubG8lMCnX8SAwjkFfda/SW1n2+AcvS44IY5tXEzi3g5K/JT3EKD/aPEKuZtV7wEq4DQk5h6/WFJFhHiInjyJfUv9lWOVqS2QwPy/ldh+VrRGxlCEN+NVqpkdgVXxNsDpRZgVFV7f38nx9FfMazAXUu1de3vMRCsWyK74hqh2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXSfESii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46148C2BD10;
	Thu,  6 Jun 2024 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682935;
	bh=eTdSzQu348qgBNqVeTj7tI9g8Dlr14jNbC2xVpNRRxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXSfESiiH2mEe5RF/tdHi7ut9xSIC4JWH4U2uDXD2jh7V5QFICrgW35nIIOLa1RuL
	 BGzHj5WeAqz/1NZ89g/O1xY/CsHZbaZpR6XG1PlFHSV2rmAX0Pe7/wjJrKXxGUXaXY
	 BVW8Det+zpx2mCd4wMbkMkApClfL8DLlOih2cUpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Wulff <chris.wulff@biamp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 085/374] usb: gadget: u_audio: Fix race condition use of controls after free during gadget unbind.
Date: Thu,  6 Jun 2024 16:01:04 +0200
Message-ID: <20240606131654.723801680@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wulff <Chris.Wulff@biamp.com>

[ Upstream commit 1b739388aa3f8dfb63a9fca777e6dfa6912d0464 ]

Hang on to the control IDs instead of pointers since those are correctly
handled with locks.

Fixes: 8fe9a03f4331 ("usb: gadget: u_audio: Rate ctl notifies about current srate (0=stopped)")
Fixes: c565ad07ef35 ("usb: gadget: u_audio: Support multiple sampling rates")
Fixes: 02de698ca812 ("usb: gadget: u_audio: add bi-directional volume and mute support")
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
Link: https://lore.kernel.org/stable/CO1PR17MB5419C2BF44D400E4E620C1ADE1172%40CO1PR17MB5419.namprd17.prod.outlook.com
Link: https://lore.kernel.org/r/CO1PR17MB5419C2BF44D400E4E620C1ADE1172@CO1PR17MB5419.namprd17.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_audio.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 4a42574b4a7fe..c8e8154c59f50 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -57,13 +57,13 @@ struct uac_rtd_params {
 
   /* Volume/Mute controls and their state */
   int fu_id; /* Feature Unit ID */
-  struct snd_kcontrol *snd_kctl_volume;
-  struct snd_kcontrol *snd_kctl_mute;
+  struct snd_ctl_elem_id snd_kctl_volume_id;
+  struct snd_ctl_elem_id snd_kctl_mute_id;
   s16 volume_min, volume_max, volume_res;
   s16 volume;
   int mute;
 
-	struct snd_kcontrol *snd_kctl_rate; /* read-only current rate */
+	struct snd_ctl_elem_id snd_kctl_rate_id; /* read-only current rate */
 	int srate; /* selected samplerate */
 	int active; /* playback/capture running */
 
@@ -494,14 +494,13 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
 static void set_active(struct uac_rtd_params *prm, bool active)
 {
 	// notifying through the Rate ctrl
-	struct snd_kcontrol *kctl = prm->snd_kctl_rate;
 	unsigned long flags;
 
 	spin_lock_irqsave(&prm->lock, flags);
 	if (prm->active != active) {
 		prm->active = active;
 		snd_ctl_notify(prm->uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				&kctl->id);
+				&prm->snd_kctl_rate_id);
 	}
 	spin_unlock_irqrestore(&prm->lock, flags);
 }
@@ -807,7 +806,7 @@ int u_audio_set_volume(struct g_audio *audio_dev, int playback, s16 val)
 
 	if (change)
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				&prm->snd_kctl_volume->id);
+				&prm->snd_kctl_volume_id);
 
 	return 0;
 }
@@ -856,7 +855,7 @@ int u_audio_set_mute(struct g_audio *audio_dev, int playback, int val)
 
 	if (change)
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &prm->snd_kctl_mute->id);
+			       &prm->snd_kctl_mute_id);
 
 	return 0;
 }
@@ -1331,7 +1330,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				goto snd_fail;
-			prm->snd_kctl_mute = kctl;
+			prm->snd_kctl_mute_id = kctl->id;
 			prm->mute = 0;
 		}
 
@@ -1359,7 +1358,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				goto snd_fail;
-			prm->snd_kctl_volume = kctl;
+			prm->snd_kctl_volume_id = kctl->id;
 			prm->volume = fu->volume_max;
 			prm->volume_max = fu->volume_max;
 			prm->volume_min = fu->volume_min;
@@ -1383,7 +1382,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
 			goto snd_fail;
-		prm->snd_kctl_rate = kctl;
+		prm->snd_kctl_rate_id = kctl->id;
 	}
 
 	strscpy(card->driver, card_name, sizeof(card->driver));
-- 
2.43.0




