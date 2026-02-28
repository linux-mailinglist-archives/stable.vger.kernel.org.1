Return-Path: <stable+bounces-220322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NZSDjUxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058E1C59EF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6289737EE642
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D34394E09;
	Sat, 28 Feb 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m25NIfD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F7394E01;
	Sat, 28 Feb 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300223; cv=none; b=LtbVzGw1+QdZnLBBfw1VCJMFNVRA2yH/b1O3hHY45atTn1BO/8G3p52U5dAVUqQeepxgUEmJUPQnBDGABF5pyXxTrg236OacOPPWzkf1MB9Yuxq7zgGuIGrys1deWRQRyosA0ifaMN+GRw678TdgnYTCKEQBm5X48w0LKLUJ22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300223; c=relaxed/simple;
	bh=AgNHeU7/fsv4RDKURY3GGZmyyuNmR+S/YrtV8q9lkis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMyM4nNy+PoBoqbCZvrDqmpSGFoGG4IZt02l3bQdLAMHvlip046ccSCzh59wjbAvjto3KNRcjuprpLixHCpjMOef3SPQwSPwl3Q9hFgNAKDS/k8ZDrFWbGmpzAzXmNmn5kmbY0qNp//MietcHEAK4zUwVHUjDtxNMAJCPkmQxRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m25NIfD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106F5C116D0;
	Sat, 28 Feb 2026 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300223;
	bh=AgNHeU7/fsv4RDKURY3GGZmyyuNmR+S/YrtV8q9lkis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m25NIfD4DXMwyB1eGqy2M2D2AMe2zV1pPbn1X9tmNOnWolpjuc1Ha+BcZPNr76XVJ
	 PlDClRXwrxMMfq3oL18pR3fQ1MvPE3grj5dHfcC8LSjrk263QZ4N/L6RTIZVLm4308
	 HzdQcr3Rvw9o/wFQW6bhtalU5PmUmecGfvNwzT5WF1qI8yhISJc5HRkeMrrZziYat9
	 F4xHk52EmG4GB9DveHKoIsq+gAbFSHkXq4/jTUQh5+U5MEF7zLC/iXYIkh3lUbuWt3
	 YphPfsXwDHe6DAikCl3fFurxG9uHRyN47qNr6n0x3LydQapx47ubSMBCrfoqPxhFiM
	 MlqbiDM/IxbOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 244/844] ALSA: mixer: oss: Add card disconnect checkpoints
Date: Sat, 28 Feb 2026 12:22:37 -0500
Message-ID: <20260228173244.1509663-245-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220322-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 9058E1C59EF
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 084d5d44418148662365eced3e126ad1a81ee3e2 ]

ALSA OSS mixer layer calls the kcontrol ops rather individually, and
pending calls might be not always caught at disconnecting the device.

For avoiding the potential UAF scenarios, add sanity checks of the
card disconnection at each entry point of OSS mixer accesses.  The
rwsem is taken just before that check, hence the rest context should
be covered by that properly.

Link: https://patch.msgid.link/20260209121212.171430-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/mixer_oss.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 8d2d46d03301b..f4ad0bfb4dac6 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -523,6 +523,8 @@ static void snd_mixer_oss_get_volume1_vol(struct snd_mixer_oss_file *fmixer,
 	if (numid == ID_UNKNOWN)
 		return;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return;
 	kctl = snd_ctl_find_numid(card, numid);
 	if (!kctl)
 		return;
@@ -557,6 +559,8 @@ static void snd_mixer_oss_get_volume1_sw(struct snd_mixer_oss_file *fmixer,
 	if (numid == ID_UNKNOWN)
 		return;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return;
 	kctl = snd_ctl_find_numid(card, numid);
 	if (!kctl)
 		return;
@@ -618,6 +622,8 @@ static void snd_mixer_oss_put_volume1_vol(struct snd_mixer_oss_file *fmixer,
 	if (numid == ID_UNKNOWN)
 		return;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return;
 	kctl = snd_ctl_find_numid(card, numid);
 	if (!kctl)
 		return;
@@ -656,6 +662,8 @@ static void snd_mixer_oss_put_volume1_sw(struct snd_mixer_oss_file *fmixer,
 	if (numid == ID_UNKNOWN)
 		return;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return;
 	kctl = snd_ctl_find_numid(card, numid);
 	if (!kctl)
 		return;
@@ -796,6 +804,8 @@ static int snd_mixer_oss_get_recsrc2(struct snd_mixer_oss_file *fmixer, unsigned
 	if (uinfo == NULL || uctl == NULL)
 		return -ENOMEM;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return -ENODEV;
 	kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0);
 	if (!kctl)
 		return -ENOENT;
@@ -839,6 +849,8 @@ static int snd_mixer_oss_put_recsrc2(struct snd_mixer_oss_file *fmixer, unsigned
 	if (uinfo == NULL || uctl == NULL)
 		return -ENOMEM;
 	guard(rwsem_read)(&card->controls_rwsem);
+	if (card->shutdown)
+		return -ENODEV;
 	kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0);
 	if (!kctl)
 		return -ENOENT;
@@ -885,6 +897,8 @@ static int snd_mixer_oss_build_test(struct snd_mixer_oss *mixer, struct slot *sl
 	if (!info)
 		return -ENOMEM;
 	scoped_guard(rwsem_read, &card->controls_rwsem) {
+		if (card->shutdown)
+			return -ENODEV;
 		kcontrol = snd_mixer_oss_test_id(mixer, name, index);
 		if (kcontrol == NULL)
 			return 0;
@@ -1006,6 +1020,8 @@ static int snd_mixer_oss_build_input(struct snd_mixer_oss *mixer,
 	if (snd_mixer_oss_build_test_all(mixer, ptr, &slot))
 		return 0;
 	guard(rwsem_read)(&mixer->card->controls_rwsem);
+	if (mixer->card->shutdown)
+		return -ENODEV;
 	kctl = NULL;
 	if (!ptr->index)
 		kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0);
-- 
2.51.0


