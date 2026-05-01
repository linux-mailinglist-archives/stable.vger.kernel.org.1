Return-Path: <stable+bounces-242484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDSLHLPl9Gl1FgIAu9opvQ
	(envelope-from <stable+bounces-242484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 19:41:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64144AE9A4
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5699301388D
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908B302163;
	Fri,  1 May 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHi4KQ1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF143164DF
	for <stable@vger.kernel.org>; Fri,  1 May 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657261; cv=none; b=pIiXtF2syhTvhz3Ifq+4JRO7ym07q6/FtKacunbWdUJw3PvzvvXuIRLHjzGofOrtrq+LhivLTnVQGpvaNtGOghvAqzz0GmzHzc0Qw4Ffm5xiTCzHYhhsFWkCatxZY7pQoxa9uOrRX7iQNNNwVwhU9EinNo2zJp0rWsxh5qc8Xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657261; c=relaxed/simple;
	bh=FoAi3//zlDQQqco+9JIIy0SkUFF/xVU8DRZ/6p1kWC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd5yk5L6qtOily7ko+tSZSvv5329UzVtk3LByAdmYeZKac/xJ+et75v3mul7NAe/NuFM/pMswIXRm6jiL12ttpPDkhzGNN7hwp5TBlIPKilIbVpWwyapG1mvKe0qrXOSj99ysWjjzJqgOQd5EH8DevUYFZTJ1gjtznlESIElmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHi4KQ1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53DBC2BCB9;
	Fri,  1 May 2026 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657260;
	bh=FoAi3//zlDQQqco+9JIIy0SkUFF/xVU8DRZ/6p1kWC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHi4KQ1d5b5QXT3TvDkdSsuodp8UoUvYW8L+2iNfvuGL7Y3g2CaECbeB/mmKGo0+U
	 I5x6W8q9hICch3t5/GbAuVaS7yXT+sURXNm/xj4yczOJkDiut9+e7cTl8M3ZYhCUHr
	 9Wr1KORO4M5crKzJV5CoruDXBN+iYH+yTWroRr8b1svJNN1GyDJNlwdgqP67Q9w1Yj
	 bRbVL8JiYSs/i/QWgSKhXBiDZ6DqFcoH7LLF8wXGJBiMqohXcozgESQhwjsoP0LZnw
	 lI9sLBqtonaWz/9GWKzB2fxW8rzQ/eHMreSEdS5uuZXNg7OdM1Dl9OZNDhksegZDKZ
	 piF6bvJFXHbyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
Date: Fri,  1 May 2026 13:40:55 -0400
Message-ID: <20260501174056.3862921-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501174056.3862921-1-sashal@kernel.org>
References: <2026050121-sliced-purposely-b1ee@gregkh>
 <20260501174056.3862921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E64144AE9A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242484-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,msgid.link:url,linux.dev:email]

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit fd7df93013c5118812e63a52635dc6c3a805a1de ]

In i2sbus_resume(), skip devices with an empty codec list, which avoids
using an uninitialized 'sysclock_factor' in the 32-bit format path in
i2sbus_pcm_prepare().

In i2sbus_pcm_prepare(), replace two list_for_each_entry() loops with a
single list_first_entry() now that the codec list is guaranteed to be
non-empty by all callers.

Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260310102921.210109-3-thorsten.blum@linux.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/aoa/soundbus/i2sbus/core.c |  3 +++
 sound/aoa/soundbus/i2sbus/pcm.c  | 16 +++++-----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 51ed2f34b276d..d877718dda947 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -408,6 +408,9 @@ static int i2sbus_resume(struct macio_dev* dev)
 	int err, ret = 0;
 
 	list_for_each_entry(i2sdev, &control->list, item) {
+		if (list_empty(&i2sdev->sound.codec_list))
+			continue;
+
 		/* reset i2s bus format etc. */
 		i2sbus_pcm_prepare_both(i2sdev);
 
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 086c49d457c34..59cba5cb29434 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -383,6 +383,9 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	/* set stop command */
 	command->command = cpu_to_le16(DBDMA_STOP);
 
+	cii = list_first_entry(&i2sdev->sound.codec_list,
+			       struct codec_info_item, list);
+
 	/* ok, let's set the serial format and stuff */
 	switch (runtime->format) {
 	/* 16 bit formats */
@@ -390,13 +393,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	case SNDRV_PCM_FORMAT_U16_BE:
 		/* FIXME: if we add different bus factors we need to
 		 * do more here!! */
-		bi.bus_factor = 0;
-		list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-			bi.bus_factor = cii->codec->bus_factor;
-			break;
-		}
-		if (!bi.bus_factor)
-			return -ENODEV;
+		bi.bus_factor = cii->codec->bus_factor;
 		input_16bit = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -410,10 +407,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		return -EINVAL;
 	}
 	/* we assume all sysclocks are the same! */
-	list_for_each_entry(cii, &i2sdev->sound.codec_list, list) {
-		bi.sysclock_factor = cii->codec->sysclock_factor;
-		break;
-	}
+	bi.sysclock_factor = cii->codec->sysclock_factor;
 
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,
-- 
2.53.0


